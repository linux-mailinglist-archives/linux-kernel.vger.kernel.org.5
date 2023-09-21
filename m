Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5427AA380
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjIUVvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjIUVvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:51:03 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3128B102
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:41:14 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59bf1dde73fso15855387b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695318074; x=1695922874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2yMALxVMz8eu5uuCFT9jsKazczGt2OLOMSS4WKXUPfs=;
        b=KUe3Yn4Qk+Cm8iYHZzReyst2Xjxc7WlC0ngG29bpEZYbsH7+e1oPHws2UR8Rvi1Esi
         U9jUFt55o9B+N76AaJQ0PlGpwFG6nBiqfnWQTDxLiY1KePzqF41B1L9rWJogtBbGmzIj
         yASLRgxMjKrx18jQ2rFFZTwjMFaJwoKQbPz16Lk1Y2QGaFbX3SJA3ZFupUI7AlshtIsY
         bsAgLUm6BMSTTPoNWXVH1Y6cYdARExFzTSBRSehwI5kTPnuzvWDfLS1tSR66jCXOTVRa
         CBBtryUTm+6yRCZwohsfw25/48VdvjTG94yz6Fi8By+lzOGkqqdzJpqICZv/zPaDoCzW
         gVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318074; x=1695922874;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yMALxVMz8eu5uuCFT9jsKazczGt2OLOMSS4WKXUPfs=;
        b=L532Y2UvwTqUFyrOmyqA3z1cJSRD3gWmClmsguP+ngvN/5Zff+WmgbCxEJolaPSaij
         nr2DcThfQLeJIKma7SzE43uXr0ANnYPo7YXYSigzb1BQx9bmAgvT8JH+PRn7Pt3M4Qx3
         IcGraAdTJynihoFHJJ+ZZvJYIEV+KIyoREW2L+/Yfgc3ryfjq0IfPOdNAKZ6WLsO+DPq
         5k6LKgrObyIobfMopoji85l9n9Ttia7WsQR7pqhTidWxQIMmgY3Lcm+wBZcIIZZEkZE1
         RQJIzazguIVtovs13MWcgq89VKglAYRKBs3acCVcrXVcDsA5WGqDELab0NJks04PChs8
         GYLw==
X-Gm-Message-State: AOJu0YwIN/vY6gcDsMbiluRSttjFk2/A+0IdsW9JhrhytFBjJKp3+CSm
        9/DxWDiGK+ggx52kMILB4A3UmsFDjrtKnTO3AQCLC3VImjypXDY2fLQ=
X-Google-Smtp-Source: AGHT+IG2MD5sh61wBj+qCb/GndH+IXTfCKZ2fjrPeCIUS4IVd/M7asl1O3/m4e4yOmvEJ6GOztcpu0F6OSG4Kp/sp4E=
X-Received: by 2002:a1f:ca03:0:b0:490:aa9b:4809 with SMTP id
 a3-20020a1fca03000000b00490aa9b4809mr4281527vkg.4.1695283936991; Thu, 21 Sep
 2023 01:12:16 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Sep 2023 01:12:16 -0700
From:   Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <ZQr3E/7crMrVxMp9@smile.fi.intel.com>
MIME-Version: 1.0
References: <20230920073253.51742-1-brgl@bgdev.pl> <ZQr3E/7crMrVxMp9@smile.fi.intel.com>
Date:   Thu, 21 Sep 2023 01:12:16 -0700
Message-ID: <CAMRc=MfvOL-ovQ89i7FASg=RoWHQPARGsc5Pxu9kC+roGqaE4g@mail.gmail.com>
Subject: Re: [PATCH v5] gpio: sim: fix an invalid __free() usage
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 15:43:47 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Wed, Sep 20, 2023 at 09:32:53AM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> gpio_sim_make_line_names() returns NULL or ERR_PTR() so we must not use
>> __free(kfree) on the returned address. Split this function into two, one
>> that determines the size of the "gpio-line-names" array to allocate and
>> one that actually sets the names at correct offsets. The allocation and
>> assignment of the managed pointer happens in between.
>
> ...
>
>>  	list_for_each_entry(line, &bank->line_list, siblings) {
>> -		if (line->offset >= bank->num_lines)
>> +		if (!line->name || (line->offset >= bank->num_lines))
>>  			continue;
>>
>> -		if (line->name) {
>> -			if (line->offset > max_offset)
>> -				max_offset = line->offset;
>> -
>> -			/*
>> -			 * max_offset can stay at 0 so it's not an indicator
>> -			 * of whether line names were configured at all.
>> -			 */
>> -			has_line_names = true;
>> -		}
>> +		size = max(size, line->offset + 1);
>>  	}
>
> As for the material to be backported it's fine, but I'm wondering if we
> actually can add the entries in a sorted manner, so we would need the exact
> what I mentioned in previous review round, just search backwards to the first
> satisfying entry. I don't believe the adding an entry to the list is a
> hot-path, so would be fine to call list_sort().
>

Given the need for the callback function, this would result in bigger code.

Also calling:

    list_add_tail();
    list_sort();

is not very elegant. I would possibly go for adding list_add_sorted() but
that's a separate change for the future.

Bart
