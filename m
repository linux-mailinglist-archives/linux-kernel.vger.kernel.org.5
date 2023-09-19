Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CD27A6228
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjISMJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjISMI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:08:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B87F7;
        Tue, 19 Sep 2023 05:08:53 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so1073100b3a.0;
        Tue, 19 Sep 2023 05:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695125333; x=1695730133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6xhmX02krfuudIK/kDSdYE25699Zi1WYmFbMkp7FRE=;
        b=hnoI0P+M+YUOpP1FT4yzhvNM6inN2zyXMfAAiSOt5Dl9lgLs/aM0A+/SozgjgGm6Ft
         a8y33cuSZO+t+2UjVjUekFd9Dimscqgisygr2F7f5KaVZxbmVA0qsB3ieCVuBJTxLxWW
         RJs/wqWS2hEzL51S7CPKUOgwXmsDU+kPNhvlfmuIW6V3p8OAN5R1QqB6aNI9vTOKPTIa
         Ke7/e1yNeLfJA33hjfa5njzVla1Gg7NXs8oFdI0e7NUaZl1+ncEfFoFJBvB+OHBzQMwJ
         LIgZZrn4u1bPrXlJE0SozC4lDtcGSq9fV8/rpQ2vLVrom2HpFcxS29m1bH8Kvy8zVRYq
         ch1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695125333; x=1695730133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6xhmX02krfuudIK/kDSdYE25699Zi1WYmFbMkp7FRE=;
        b=S53DXxbKYIN4A+dF1rxRvj3xZuCsfkI8ZY1aIpd4lHwgmu+8sDN4Wl68Ub9OX9LR1F
         8DOo6/xCGNkNvGGD0C6SXClBBbG/uKhK3lI3ZMmHv33foAtvrsgnjvBC5+LBOFD1M8IN
         ATiOsdTKFQpzuZp/t7oybnCS5oDRXvO0rYqU3qv7OyxtjJLbqxAvU884VAwTbesZKlM6
         LLu5AHh0PSyI83OneFDIAHQrr1s/lSwEh7LJuCMNWiK5fklscThiYtHnZezIfN/MKjKO
         BDRIV/reaCMa6xqFd3yBBJqqg5+Sxu10y93E3pUQi2dzQ1g3im47IX7szpbAXAk/t2dV
         aCDA==
X-Gm-Message-State: AOJu0YzIbjdtCjctyRa8plHBvKwDOvDRm+sNn9u4ws4B4k4mg9k+qWTx
        HTZP1ujombDQdeERB9HOOZo=
X-Google-Smtp-Source: AGHT+IGWrKUt1gJtfuwgclUNdSACapHw0G929wnxRxw67DgRvp8vDesvlYLDs+VGKnIIi/plOt67HA==
X-Received: by 2002:a05:6a00:813:b0:68e:39b5:7e63 with SMTP id m19-20020a056a00081300b0068e39b57e63mr12467455pfk.16.1695125332780;
        Tue, 19 Sep 2023 05:08:52 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id c21-20020aa781d5000000b0068fe68de4e1sm8758513pfn.145.2023.09.19.05.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:08:52 -0700 (PDT)
Message-ID: <bbc73924-299d-4de5-a06c-995a49e5f27e@gmail.com>
Date:   Tue, 19 Sep 2023 19:08:41 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Marvell RAID Controller issues since 6.5.x
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Song Liu <song@kernel.org>, Timo Gurr <timo.gurr@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Linux RAID <linux-raid@vger.kernel.org>
References: <224f10a4-7a6a-48bb-88be-491faf8ecff7@gmail.com>
 <ZQf9mh3v5qfN5Tm0@x1-carbon> <ZQgCoJ17UioOtdOJ@debian.me>
 <ZQlFg4GsULu633P1@debian.me>
 <9c791f68-bbfe-4722-9cbb-5e791ce042ec@leemhuis.info>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <9c791f68-bbfe-4722-9cbb-5e791ce042ec@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 18:32, Linux regression tracking #update (Thorsten Leemhuis) wrote:
> [TLDR: This mail in primarily relevant for Linux kernel regression
> tracking. See link in footer if these mails annoy you.]
> 
> On 19.09.23 08:53, Bagas Sanjaya wrote:
>> Another user has confirmed the fix (see Bugzilla), so:
>>
>> #regzbot fix: https://lore.kernel.org/linux-scsi/20230915022034.678121-1-dlemoal@kernel.org/
> 
> Bagas, FWIW, using "#regzbot fix" is not supported (maybe it should, but
> I have other priorities currently), hence let me fix this up:
> 
> #regzbot fix: scsi: Do no try to probe for CDL on old drives
> #regzbot monitor:
> https://lore.kernel.org/linux-scsi/20230915022034.678121-1-dlemoal@kernel.org/
> #regzbot ignore-activity
> 

Duh! I should have read regzbot doc then. Thanks anyway.

-- 
An old man doll... just what I always wanted! - Clara

