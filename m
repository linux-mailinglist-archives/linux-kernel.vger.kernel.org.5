Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E2D7726DC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjHGOBC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Aug 2023 10:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjHGOAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:00:44 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B35C6581
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:58:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc63ef9959so14144485ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691416599; x=1692021399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQX6/hwjPJpQfq4LHTlP4C5iuDX8LOTIHNqooa8/Auk=;
        b=D3YFgJg+IcNjCpwIrJMeFgu5qVLVcMpd66ZZ4YFX20dy+3RKXiZLfn4RNpFb3OhSOQ
         rQ/KP9Y/Q4S9815A5CahJkjFyUVHxdYrEitHFIt7N2ZuG2oyTvEloi2uqfJux8drOf41
         otbpMgJLkK18+C60mhFSne+0Vux4xAkn9dHBGNIK/zCM1TG7eM0iKLaSUryi+GrgyiBj
         25U90+1iIWTEDqviv/rnhNEMb3AG+dH7DIenWEi3+mkHTVZFXbRkkbzpA/DIjrqmE0tC
         kH2Edt7vItSP0K9Eg1+/7WXWuxz4Iws+lq1KKvw1v5MOYIzCtPTHi3Cpn1U8fi5FwWxQ
         8EPg==
X-Gm-Message-State: AOJu0YxOQ6NvQZ4oRPqBKLyEnfrSnRi/q5iHg1ldeYLGFBaHYhH0A/mJ
        YO/90RvJiHdRtkittENpHJz+2lP3qP/mBA==
X-Google-Smtp-Source: AGHT+IHg6E4UedOPhgqE0EJGGs2TdVQ++ktivVEnvDE3by61W2emt6KIIUCHGHNKwQxyqhc8kpcaJg==
X-Received: by 2002:a17:902:e546:b0:1b8:a697:3719 with SMTP id n6-20020a170902e54600b001b8a6973719mr11442004plf.25.1691416599246;
        Mon, 07 Aug 2023 06:56:39 -0700 (PDT)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com. [209.85.215.179])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001b8b45b177esm6889702plp.274.2023.08.07.06.56.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 06:56:38 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-564ca521549so1931393a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:56:38 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac1:b0:25b:d292:d9a3 with SMTP id
 mh1-20020a17090b4ac100b0025bd292d9a3mr9166890pjb.37.1691416598335; Mon, 07
 Aug 2023 06:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230807133930.94309-1-andre.przywara@arm.com>
In-Reply-To: <20230807133930.94309-1-andre.przywara@arm.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 7 Aug 2023 21:56:27 +0800
X-Gmail-Original-Message-ID: <CAGb2v67NP0r9arrE7His6jpyb9N=yhpUUNJT3joTWAXoDRnOVw@mail.gmail.com>
Message-ID: <CAGb2v67NP0r9arrE7His6jpyb9N=yhpUUNJT3joTWAXoDRnOVw@mail.gmail.com>
Subject: Re: [PATCH] mfd: axp20x: Generalise handling without interrupts
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Shengyu Qu <wiagn233@outlook.com>, martin.botka1@gmail.com,
        Matthew Croughan <matthew.croughan@nix.how>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 9:39 PM Andre Przywara <andre.przywara@arm.com> wrote:
>
> At the moment we allow the AXP15060 and the AXP806 PMICs to omit the
> interrupt line to the SoC, and we skip registering the PEK (power key)
> driver in this case, since that crashes when no IRQ is described in the
> DT node.
> The IRQ pin potentially not being connected to anything does affect more
> PMICs, though, and the PEK driver is not the only one requiring an
> interrupt: at least the AC power supply driver crashes in a similar
> fashion, for instance.
>
> Generalise the handling of AXP MFD devices when the platform tables
> describe no interrupt, by putting devices requiring an IRQ *last* in
> the MFD cell array. We then can easily cut short the number of devices
> to be registered in this case.
>
> This patch just enables that for three PMIC models for now: the two
> already handled, plus the AXP313a, for which we now have mulitple examples
> of boards without the IRQ pin connected.
> To stay consistent with the current behaviour, we still (try to) register
> all devices for the other PMICs, even though this will probably crash
> without an interrupt specified, if those problematic drivers are loaded.
> But this new approach can now easily be extended to other PMICs with more
> devices, should the need arise: currently all in-tree users are fine.
>
> This fixes operation on the first boards using the AXP313a, which do not
> bother to connect the PMIC's IRQ pin.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reported-by: Shengyu Qu <wiagn233@outlook.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
