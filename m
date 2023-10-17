Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C98C7CBC07
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjJQHJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbjJQHI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:08:59 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3F1107;
        Tue, 17 Oct 2023 00:08:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9c5a1b87bso36166925ad.3;
        Tue, 17 Oct 2023 00:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697526537; x=1698131337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzW3ddlIc/g6qI+zVds2r3DLCiTHQ00BzaCVpAuMb6I=;
        b=e4jB56u313GO8zL/skCN1rbJLqtaJSs9elokkbHQ24e2YYryqSF8CFT575hKpjwa0T
         pdw+REbXiGcvYIfAl937Rdunhbe8kn1jdtfosph+IzsOb9hQqfgJP1gbnu7OKVKXuXc4
         uy8sVv4xFVfvQNjWthV55A++2+0WrKNTuV18igqGHsb9K0xydX8odjDxxUeLFce4umOV
         G225a9aXGCnim/dASc4QWRaCTWUB0OHzgcgPOZ/yt/yUm8KqDfsibpsDG/tykD1hsv6j
         XShgsz5ripVOk9d7DGn9sU/jG3+tp+qwCmsPwgKq9TUaV8OSbVnDytZWa1JUEkETHm3A
         pzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697526537; x=1698131337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzW3ddlIc/g6qI+zVds2r3DLCiTHQ00BzaCVpAuMb6I=;
        b=bc6zsSgUuFRf1zny8npe/jIztusDh7dQ2ygRcFe2Hm5HgIqGCITiBvXyoBlQsnbhIO
         2We+uKRSkl4xlcCZApWPc/2ZRviMLaLxZVeS9I1n//ZpDQ3pAfG+xtq+UHfrMlMbHWv2
         c5cE2WfP/nz65vfh/o9lmfFpQy2nnMI6ZwiZ9IkteaaAIy4TH9SlICvCNmpaCUA4Y3/i
         HM369Nkqz6OEL84mknEJhqbiDX4O9da+B7I4SBzJJZZeWBbVQ6cpT/02tThxfBNllbWe
         kkNKvo8KuVBLMon09yvrvz8a8k8vp+xpcOJLtPP6KdsKF2GVL+Cga/F4LdH3NKxZYjEm
         paPA==
X-Gm-Message-State: AOJu0Yz5Gtk1IIIucmW/2qoauLBDKn68eX/13DNv1Y/1YdnDH836EImU
        LJfXWcbgeN97TC811XVsItY=
X-Google-Smtp-Source: AGHT+IFcZm2I+/ze3s7LVVDqOJSLHWpKutKCrCcG53oJu5+j2C1Yli/FVpo7Mkc/J58Z4ZLrjwq0PA==
X-Received: by 2002:a17:903:228e:b0:1ca:86a9:cace with SMTP id b14-20020a170903228e00b001ca86a9cacemr1578654plh.2.1697526536615;
        Tue, 17 Oct 2023 00:08:56 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902bd0c00b001b850c9d7b3sm738472pls.249.2023.10.17.00.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 00:08:56 -0700 (PDT)
Message-ID: <f8387cd2-032e-4231-9769-a8229b573614@gmail.com>
Date:   Tue, 17 Oct 2023 14:08:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Intel 7560 LTE Modem stops working after resuming from standby
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Intel Wireless WAN <linuxwwan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
References: <267abf02-4b60-4a2e-92cd-709e3da6f7d3@gmail.com>
 <CAMZdPi9RDSAsA8bCwN1f-4v3Ahqh8+eFLTArdyE5qZeocAMhtQ@mail.gmail.com>
 <ZSiJdxjokD0P9wRc@debian.me>
 <CAMZdPi8qmc4aKPsm3J60Fb+wa0ixVCV+KK11TDsvqFJk81Gfrw@mail.gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAMZdPi8qmc4aKPsm3J60Fb+wa0ixVCV+KK11TDsvqFJk81Gfrw@mail.gmail.com>
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

On 16/10/2023 20:18, Loic Poulain wrote:
> Hi Bagas,
> 
> On Fri, 13 Oct 2023 at 02:04, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> On Thu, Oct 12, 2023 at 06:54:11PM +0200, Loic Poulain wrote:
>>> Hi Chetan,
>>>
>>> On Thu, 12 Oct 2023 at 11:52, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>>>
>>>>> I noticed a few days ago, after Fedora moved to Kernel 6.5, that my Intel LTE Modem was not working anymore after resuming from standby.
>>>>>
>>>>> The journal listed this error message multiple times:
>>>>> kernel: iosm 0000:01:00.0: msg timeout
>>>>>
>>>>> It took me a while to determine the root cause of the problem, since the modem did not work either in the following warm reboots.
>>>>> Only a shutdown revived the modem.
>>>>>
>>>>> I did a bisection of the error and I was able to find the culprit:
>>>>>
>>>>> [e4f5073d53be6cec0c654fac98372047efb66947] net: wwan: iosm: enable runtime pm support for 7560
>>>
>>> Any quick fix for this issue? alternatively we will probably revert e4f5073d53.
>>
>> Chetan can't be contacted as sending to his address bounces (error 550)
>> (had he left Intel?). Last message on LKML is this culprit patch [1].
>> Hence, revert for now.
> 
> Could you please submit the revert fix?
> 

OK, will do.

-- 
An old man doll... just what I always wanted! - Clara

