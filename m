Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9607778E8E6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242079AbjHaI5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjHaI5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:57:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE93CEA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:56:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c1ff5b741cso4335445ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1693472217; x=1694077017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GFSqNDPkeaHQR4IVBJ1wtH05it7jXcUWJdQhCPiuhFU=;
        b=ayuNNWsG/sehQYIkEhKh0bPs4XTwjv2y2X+kRWB3sHQgk1I4Gc8kaYGjGV2Ohrs9Hb
         m3Mi31zK0qVm1DW9ioxvCXSuQw0cRpE6BbKMFh4do9W0SAulShPhRDVagKCXHX9B0NSR
         4BghnpTWdU2XnpUN3JZ8zlwqqQ92YDkqAsNGFFvjwdCLBUA1YcfQrsLwbRzL2KDGhLW6
         YsLiWxbaR3woF7QBMxl6u1x4nYA7ZQV3s0B2PO4YQcwnVqqOi8G1KPVrjmABpEQXA+gS
         I9Mpa/svGip5NYMvihpN5XTgJ75QmIGj2/0prfhdCaJTbr3zugnE+1dont8mqJi3TnA/
         WolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693472217; x=1694077017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFSqNDPkeaHQR4IVBJ1wtH05it7jXcUWJdQhCPiuhFU=;
        b=YPGQ+yGUQL1KUKsa9cKiHzKOxzrKCjqEeBvsKmGxkSa1RgaZV2htMEwhB+8R1IKpw+
         2Huc7XrRmOn8Hx9sVyTzocdtbk6HQEtTOup/zPbJqB0X2ChFUMTVdD8dyaqjx2hmApFh
         ET5WAzO9q+tKXZhde93VZLy8wORAkBLxZFlVLfvtgt2bGqGY/qgenb4pHRRjfURUcj9I
         fbmIMaNkKGCsZ2OS4cj9Lm+hnubp+5aZ3Zd9P5KIGucTzbc/9FHqUdejf3t+P5PiI5M9
         1l1Pj1atDLm4fXHH9zdPWMu+WU175JJqnEVVbR/1ma6A/vhqfZ8YLqLq3e6sZkcRR/z6
         0NxQ==
X-Gm-Message-State: AOJu0Yymrn9LqDCHjSlCZck/NrvB1q0wfN1OjvER6jkyqHX3MobQVnG0
        9OKSlpX8a67A+D1TeCaV0m27Gau0hjRsdXn4p0quzX0yE1i8yyUdO+s=
X-Google-Smtp-Source: AGHT+IHvvswip25U6YKteyOygNkgxG1DFzTx9idjU9EotOhI8666Cl6ge6BrbiYNkQsHjmLdjQusf7pYrurulvmtVPc=
X-Received: by 2002:a17:90a:8043:b0:268:2523:652c with SMTP id
 e3-20020a17090a804300b002682523652cmr4261818pjw.31.1693472217352; Thu, 31 Aug
 2023 01:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230830111319.3882281-1-Naresh.Solanki@9elements.com>
 <0bfbbbb3-6144-fc9a-c8ab-423a8865591b@roeck-us.net> <CABqG17ig1VRJYqbrOvPKAYS8iUFwY9J3tYcgYGtnnXw+vrnoRA@mail.gmail.com>
 <1efe9234-a97f-6df2-c47d-e153dc362599@roeck-us.net>
In-Reply-To: <1efe9234-a97f-6df2-c47d-e153dc362599@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 31 Aug 2023 14:26:48 +0530
Message-ID: <CABqG17hhPUjSKoAxVFKAmrZfQ0TpTRWVpoe-CrRAu0i7jt=JFw@mail.gmail.com>
Subject: Re: [PATCH] regulator (max5970): Add hwmon support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, zev@bewilderbeest.net,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


On Thu, 31 Aug 2023 at 01:02, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 8/30/23 12:14, Naresh Solanki wrote:
> > Hi
> >
> [ ... ]
> >>> +                     /*
> >>> +                      * Calculate voltage from ADC value and MON range.
> >>> +                      * ddata->mon_rng holds the voltage corresponding to the maximum value the
> >>> +                      * 10-bit ADC can measure.
> >>> +                      * To obtain the output, multiply the ADC value by the MON range (in
> >>> +                      * microvolts) and then divide it by the maximum value of the 10-bit ADC.
> >>> +                      */
> >>> +                     *val = mul_u64_u32_shr(*val, ddata->mon_rng[channel], 10);
> >>
> >> Why do you use mul_u64_u32_shr() here but a direct shift above ?
> > There is possibility of overflow due to large value of ddata->mon_rng
>
> Does the right shift guarantee that the result fits into 32 bit ?
Yes. Value in ddata->mon_rng can go upto 26bits, & ADC is 10 bit.
The 10 bit right shift(part of calculation) makes sure the result
never exceed 32 bit

Regards,
Naresh
>
> Thanks,
> Guenter
>
