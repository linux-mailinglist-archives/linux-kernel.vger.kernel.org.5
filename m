Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98357F632E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346113AbjKWPlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjKWPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:41:20 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2B8F9;
        Thu, 23 Nov 2023 07:41:26 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5079f6efd64so1254540e87.2;
        Thu, 23 Nov 2023 07:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700754084; x=1701358884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdosComnmH9qpEjr3EFMpMZqgrLCLTQb6rWBIKchZWY=;
        b=WD/F/dX5vF4YSpx70GPjIiTupT+nkADgynVvLJy1ehWhvtBKubvMjDzOZjk6wr1z1F
         eALy93iU3346nnWVO024h54twLEu4szYt9FCm2gjvs0Qy4ATTc8UDu5TywYT7/XhG/ua
         v/c4W9yLW+3+stJ4hk9Sd1AhUdoPmhhJWLj36TY8PKpzyczQGuDstovytrv087TfPOOo
         noXqePZMGwx1KYqaNEwLzGg1hsKqEBYL+/cMXrvt15jyl5xENeyyMIUjZ/TS4vQ805Sy
         StQnA/rypicYyM3H4DL31OrezPNLooyyu1L2iEQDhaOGuG4FmNVPeYpAjKlGcHTlJeQ0
         h2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700754084; x=1701358884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdosComnmH9qpEjr3EFMpMZqgrLCLTQb6rWBIKchZWY=;
        b=wYbzGrWiBwMFg9q/LThOMTq4ekpdxFzCUI5kIgmhXNPQCZPadzVWJ+guUS/H/gFuOp
         74ADGw3eqQ5wCsZaMeo1jnbwBTAX/hx9H9D5kaPw5sh4jPzqZJCKvsX5xFL2JlBu5RQC
         OsUGKtQa6BIDMFHDoxl2KdZtVnjK1a9pRNZVzLfLDeRZMqzcwBNbnX4o+ho3E425denn
         Jv54Tg48LOBkc1I4riQB4Jidp/91Eiseh7/aFadJebj70orbg0jOHVmUk8jZ3DpS5onj
         fvDfqMQ+H1hSJB02I4xFytiskaM9sC0ym5MjX1LFhpbprHzdo8tIJY/QpYLQMjVhK2/z
         09dw==
X-Gm-Message-State: AOJu0Yw1JCYFerqAaR/0oPtQoKGhw2Y6POXpvXRm2CdC4wD/9ZLnU/Bs
        Rtll73ExDarfsIaR3W2APmg=
X-Google-Smtp-Source: AGHT+IGqFaC+59oNq24Mg+Crqp+gb/nHUU2KaMqjSoTVfc2L5dU0b6uh33wraYSE8V+luIKdE9MXnA==
X-Received: by 2002:a05:6512:b02:b0:507:a04c:76e8 with SMTP id w2-20020a0565120b0200b00507a04c76e8mr4953204lfu.46.1700754083602;
        Thu, 23 Nov 2023 07:41:23 -0800 (PST)
Received: from ?IPV6:2001:999:251:b686:cec4:d552:2937:637c? ([2001:999:251:b686:cec4:d552:2937:637c])
        by smtp.gmail.com with ESMTPSA id c15-20020a056512324f00b005095614210dsm232214lfr.241.2023.11.23.07.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 07:41:23 -0800 (PST)
Message-ID: <60e1ee8c-870a-4d38-bad8-bc28e98ee425@gmail.com>
Date:   Thu, 23 Nov 2023 17:42:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: twl4030-power: Revert to use of_match_device()
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     tony@atomide.com, robh@kernel.org, wens@csie.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231029114909.15652-1-peter.ujfalusi@gmail.com>
 <20231123103906.GE1184245@google.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20231123103906.GE1184245@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/11/2023 12:39, Lee Jones wrote:
> On Sun, 29 Oct 2023, Peter Ujfalusi wrote:
> 
>> The core twl chip is probed via i2c and the dev->driver->of_match_table is
>> NULL, causing the driver to fail to probe.
>>
>> This partially reverts commit 1e0c866887f4.
>>
>> Fixes: 1e0c866887f4 ("mfd: Use device_get_match_data() in a bunch of drivers")
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
>> ---
>>  drivers/mfd/twl4030-power.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> Rob, does this work for you?

This is not needed, twl4030-power is a proper platform device, it should
have of_match_data.

I had a boot failure likely caused by something else and I thought this
might be part of the puzzle to get it working again.

Sorry for the confusion.

-- 
Péter
