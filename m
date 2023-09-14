Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF4D7A0778
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbjINOiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjINOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:38:10 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0A91A5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:38:04 -0700 (PDT)
X-QQ-mid: bizesmtp67t1694702259t9udhzzs
Received: from [192.168.70.112] ( [125.75.40.56])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 14 Sep 2023 22:37:37 +0800 (CST)
X-QQ-SSF: 01200000000000907000000A0000000
X-QQ-FEAT: 3M0okmaRx3hDlEzMIU7uSqErUQ9TeKNJWqroh3lGXB8lWHuCiOOCSNtHXao10
        uIy6MbO2eBWoV9qVfIhyoylKvVYM5N8reBL4zsiZKGDaP4P3xfmF66OLMNXbVRa3N42FxCb
        ntUPOnGvlYt4DZUJx68vqf2HN/DCVxXwp34LAyxVR34JMAEnlQOWw1O8tcvIkpy9sqaLmDS
        TwIJKjs2m+nS8DD7YKHZ0hYI8WnuhKtH3VdD7s7c16SuNrTGN1F7wRA/Eh5tVYVTg/pRZ7q
        oa4BRYf2SexgVRmtQct/iCdrpi/NEW947038ZgxglVPDfBeii8pn8fP3QgdF5t3Uw776tye
        ZUaDhG+CdVm86YbfhnDyXSi5ThxXp1bQzaiSbD22sv89FGeMcA=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1016913453215264975
Message-ID: <A81E00EBD697C30F+9c7a7721-e949-4ca6-a6b3-8eeb181718f2@tinylab.org>
Date:   Thu, 14 Sep 2023 22:37:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] powerpc/config: Cleanup pmac32_defconfig
Content-Language: en-GB
To:     Michael Ellerman <mpe@ellerman.id.au>, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org, w@1wt.eu, linux@weissschuh.net,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <cover.1694685860.git.tanyuan@tinylab.org>
 <23b30e8e9e31e7a6af4aa7d317699e1538ad89c2.1694685860.git.tanyuan@tinylab.org>
 <87y1h87vf3.fsf@mail.lhotse>
From:   Yuan Tan <tanyuan@tinylab.org>
In-Reply-To: <87y1h87vf3.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael

On 9/14/2023 9:10 PM, Michael Ellerman wrote:
> Yuan Tan <tanyuan@tinylab.org> writes:
>> Use 'make savedefconfig' to cleanup pmac32_defconfig, based on Linux
>> 7.6-rc1
> Thanks but I don't like doing these updates in a single commit like
> this, it's easy to accidentally lose a symbol.
Yeah I have the same concerns too.
>
> I prefer an explanation for what's changing for each symbol. See
> 1ce7fda142af ("powerpc/configs/64s: Drop IPV6 which is default y") and
> the commits leading up to it, to see what I mean.
>
> But I suspect you probably don't want to go to all that effort, which is
> fine :)

I am not familiar with other options, so I'd better not do that. :)

By the way, just to be cautious, since the defconfig can only be updated 
by 'savedefconfig'[1], how can we write an explanation for a single 
change in an option?

I mean, when I change one option, the value of the other undetermined 
option will be set just like in patch 1.

[1]: 
https://lore.kernel.org/all/54da2376-dc65-0a96-55df-7a5acfbb9bff@csgroup.eu/
>
> So I won't take patch 1, but patch 2 and 3 look fine. No need to resend,
> I'll deal with any merge fixup needed.
>
> cheers
Thank you :)
