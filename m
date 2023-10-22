Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8C97D24B1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjJVQ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVQ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:58:32 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3FEEE;
        Sun, 22 Oct 2023 09:58:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b497c8575aso2530892b3a.1;
        Sun, 22 Oct 2023 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697993908; x=1698598708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IwkHwhxesLPKqjBuQHsCOV/nzGIgUui9PvuqFp60Gu4=;
        b=Psm4wsGpF2xEcjvz9RxQykfY0kESoRu5NcwVTuAqadyCrudKSOz5aaw8pOGjIzAmlz
         wPy1O+4Uo2J9upLNDDqmsJJqekbXu59q+mWceos5AG/xb8zUgQJXUmvoJtu6LkVSz+u4
         YUHRjntPZ4yo3wa00J+rbgED1xrM4HIWqe+KjELmM3jQGdA3Sbq2i6zVmYT9DiGtNALZ
         q/8NK7irNlNt5x1kAwiWPCuBYv7oucNUvBSHNraQzXJAjN1ch1CieW3T7YRLcnNrI6KW
         p2MvaVcZMjIxYz+w8/IPIpP6Ch5QXJPhhIDDq83lrlL821Wbv6pob+QsR4M2fFCF70m2
         qnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697993908; x=1698598708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwkHwhxesLPKqjBuQHsCOV/nzGIgUui9PvuqFp60Gu4=;
        b=vH8cDK07SFdpcD7oXu7JGQHtciYJnxKlsr1nRCWd2AaG6b+6InHMlhSHowz33Ctex8
         ckY0IGe2NQdoVrFf8PXzlWbPq3lNTzS/QlSfF9Fpw20UqJHNWVJna8UT1qlTm1OBlThj
         jgYz9WXx8dRpnSdJjEwy57b2NakdJwqFosvPCd08xvtkMtUxJzYXP7kiifz/hkVdY08q
         NGR184XIWHaVM1bKMzMk7QBY3zsDdS/fjZsXeBqxMEFNRnBPpB7BzS8Rsms5aLW3SNPC
         F0WLwM2/D1wQA8RJXKF9MEAjdmHit8W/oZEJ7hanaqIWdcClV5Uuw4BUap6AN3Gu2Q1j
         uV6A==
X-Gm-Message-State: AOJu0YxpbH+P0XzAza4Rd/x4oYHXLskPHcgW83uhhCXz8NQzjRGMqRvf
        aSjKh9AkSaQr32lGIC6cbBk=
X-Google-Smtp-Source: AGHT+IEYfJ/AoRsJ9amHD/W2WLpvXa/3dxIzCpTXNeztkwnwYxALQX6X+GqFhvmVrl3w1YkurD0PPA==
X-Received: by 2002:a05:6a20:1602:b0:153:7515:9919 with SMTP id l2-20020a056a20160200b0015375159919mr9062907pzj.21.1697993907684;
        Sun, 22 Oct 2023 09:58:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z11-20020aa79e4b000000b006b725b2158bsm4790807pfq.41.2023.10.22.09.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 09:58:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1fae4d2c-4bc7-f169-7b84-501674a82ee4@roeck-us.net>
Date:   Sun, 22 Oct 2023 09:58:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] sbsa_gwdt: Calculate timeout with 64-bit math
Content-Language: en-US
To:     Darren Hart <darren@os.amperecomputing.com>
Cc:     linux-kernel@vger.kernel.org,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <7d1713c5ffab19b0f3de796d82df19e8b1f340de.1695286124.git.darren@os.amperecomputing.com>
 <bcc41311-075c-44fe-b0f7-30564d7ac58c@roeck-us.net> <ZSpbfXzFeaoUJRZ3@Fedora>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZSpbfXzFeaoUJRZ3@Fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/23 02:12, Darren Hart wrote:
> On Tue, Sep 26, 2023 at 05:45:13AM -0700, Guenter Roeck wrote:
>> On Thu, Sep 21, 2023 at 02:02:36AM -0700, Darren Hart wrote:
>>> Commit abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
>>> introduced new timer math for watchdog revision 1 with the 48 bit offset
>>> register.
>>>
>>> The gwdt->clk and timeout are u32, but the argument being calculated is
>>> u64. Without a cast, the compiler performs u32 operations, truncating
>>> intermediate steps, resulting in incorrect values.
>>>
>>> A watchdog revision 1 implementation with a gwdt->clk of 1GHz and a
>>> timeout of 600s writes 3647256576 to the one shot watchdog instead of
>>> 300000000000, resulting in the watchdog firing in 3.6s instead of 600s.
>>>
>>> Force u64 math by casting the first argument (gwdt->clk) as a u64. Make
>>> the order of operations explicit with parenthesis.
>>>
>>> Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
>>> Reported-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>>> Signed-off-by: Darren Hart <darren@os.amperecomputing.com>
>>> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: linux-watchdog@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: <stable@vger.kernel.org> # 5.14.x
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Guenter or Wim, I haven't seen this land in the RCs or in next yet. Have
> you already picked it up? Anything more needed from me?
> 
> Thanks,
> 

Sorry, I am suffering from what I can only describe as a severe case of
maintainer/reviewer PTSD, and I have yet to find a way of dealing with that.

Guenter

