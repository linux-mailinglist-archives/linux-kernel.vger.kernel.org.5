Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8FF7DA6B7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 13:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjJ1Lay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 07:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJ1Law (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 07:30:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2199C;
        Sat, 28 Oct 2023 04:30:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9bdf5829000so468828666b.0;
        Sat, 28 Oct 2023 04:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698492648; x=1699097448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+GZgpjtqscAa143cX/9uuh3k2yGrgKZoz3xkY7o9yEo=;
        b=VBdSr5KY2Q8D37X2UpbZ/IzPhhuLlqheBsL2hZEuYCNHY6RPlpP26VwtRyzZ58yf0f
         /iyv/eC/EdmAYpaekIr4NzBn2+6l0Kv8mp8SOnUZdx4kTyUzU0evxtSrcK/UNLaqfoY+
         VTaT62RmOYsNxfJjoXr1DWK9VUETPZYqruKJvydT49DpY5/6skoXIbnl9/JKpaAL540M
         Lx6UgPsw7nLPJYujSu5suxG/lbTDxccZ8hptasbsRHHAUAJpZmhS1ya0mJsnDRw78XTJ
         L0rq3l75Iv37b6Qc5c0tavyN6YJ/jTxemDlbkdUd/1AtSezmBNGWXXTnPMC0QA3dQAZ9
         Q/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698492648; x=1699097448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GZgpjtqscAa143cX/9uuh3k2yGrgKZoz3xkY7o9yEo=;
        b=le9uTv5avLXrH9jrAcQIXvbr/dPMRlBDbvL9wMSBSI3gh5WAtVtuhFvfW8NJHfDgaL
         a1OxQFmTOH7ltfCn++q/Z1Qb1Bx6/nnucCxkrGYkd+fewX4uy2fhpT6zLSHpkA+bdPpv
         3Z8OexVzfzDqosSlZsnZKMZiN/5wphRB9purb2+Tfv3EN9j4VXdBsSiGn4cC4ALRy+vW
         6g5M/ROaeg8+cVKUeZt+wrnRBCHHKgqt3z1DoR1JYNJkY06+/32T3AyDFBIOwqb3htSy
         8gPfiBMXl8ldvHXbKDKoAeZZ1PXxmmlXlmgcoOpMKRbdRP/vETkbXAu+AOCAddesB0RB
         8R/g==
X-Gm-Message-State: AOJu0YxiLJP7OI4Aqhsr31urcjwNYlT22I4ASC775EdWcid6JxzwlNkK
        mLKIWsu6ndd5AFCFwsaGs8s=
X-Google-Smtp-Source: AGHT+IEV6JxpXRi7QuZm8U8u6YWPsop5BcBriL1ekBjQfCgQhSUqwWiN1PUUIGeqqBCb2DIqTuc7KQ==
X-Received: by 2002:a17:906:ee87:b0:9a5:874a:9745 with SMTP id wt7-20020a170906ee8700b009a5874a9745mr3942462ejb.26.1698492648276;
        Sat, 28 Oct 2023 04:30:48 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id u18-20020a170906409200b009928b4e3b9fsm2648331ejj.114.2023.10.28.04.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 04:30:48 -0700 (PDT)
Date:   Sat, 28 Oct 2023 13:30:45 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: clock: brcm,kona-ccu: convert to YAML
Message-ID: <ZTzw5c5/MwU3VOBo@standask-GA-A55M-S2HP>
References: <ZTf0oWfOqnyMEKbF@standask-GA-A55M-S2HP>
 <20231027-bulldog-component-5b84e4660465@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027-bulldog-component-5b84e4660465@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 03:47:48PM +0100, Conor Dooley wrote:
> On Tue, Oct 24, 2023 at 06:45:21PM +0200, Stanislav Jakubek wrote:
> > Convert Broadcom Kona family clock controller unit (CCU) bindings
> > to DT schema.
> 
> I didn't cross-check the clock-output-names, but this conversion mostly
> looks good to me.
> 
> > Changes during conversion:
> >   - remove "dmac" from clock-output-names for brcm,bcm11351-master-ccu,
> >     it is not used in DT nor the dt-bindings
> >   - remove "uartb4" from clock-output-names for brcm,bcm21664-slave-ccu,
> >     it is not used in DT nor the dt-bindings
> 
> This I'm not sure about - they _were_ documented in the text-form
> dt-binding, even if they weren't used in the dts. If the clock
> controller does actually produce these clocks, removing them doesn't
> make sense to me.

Hi Conor. Looking at downstream, I was not able to find these clocks, though
I admit that I'm not familiar enough with the downstream mess to be 100%
confident.

From what I can tell, the BCM21664 arch/arm/mach-hawaii/clock.c (e.g. [1])
doesn't contain any mention of uartb4, only uartb, uartb2 and uartb3.
And similarly, for the BCM281XX arch/arm/mach-capri/clock_capri.c (e.g. [2])
I wasn't able to find any mention of dmac, only dmac_mux_apb and dma_axi
(though these two don't seem to be supported on mainline yet).

Judging by that and the fact that mainline Linux or the dt-bindings includes
don't mention these clocks either, I would say the old txt bindings document
was the wrong one.

The old clock-output-name table also didn't match with the dt-bindings include
it was supposedly describing - for example, BCM281XX_MASTER_CCU_USB_IC is
defined as 4, not 5 as the old table stated.

[1] https://github.com/Samsung-KYLEPROXX/android_kernel_samsung_kyleproxx/blob/cm-14.1/arch/arm/mach-hawaii/clock.c
[2] https://github.com/surblazer/android_kernel_samsung_galaxys2plus-common/blob/android-7.1/arch/arm/mach-capri/clock_capri.c

Thanks,
Stanislav

> 
> Cheers,
> Conor.

