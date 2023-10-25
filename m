Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D3E7D7518
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjJYUDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJYUDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:03:12 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5414F129;
        Wed, 25 Oct 2023 13:03:10 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1e0ee4e777bso63284fac.3;
        Wed, 25 Oct 2023 13:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698264189; x=1698868989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5r+62BGyhlZ2nS1rxbtagnoldZmEnkd8Tctfhnbykf0=;
        b=J49iXWc8HUI6J0OsmVqV1dI/hjOvn7c0hFTkegTO/cWe5HEr6QwWdvd1PkUHBZD4wO
         vT7r8gJXxccgAVeNeiDI/efYtieaImJ5qZTrNa0xbxMe0vK2XOhgcQ/2wgNpejC907Eb
         oGhZoDL6blymEfijZ6aTnjkvlaPDtnuDfbbDK0VlyLsNf4h7lnA5jHgAs59kxSbQ0rFP
         hSHPoxfbbK5KMLMJmXyWKHPEzi/7LWrd6YchWX3E7c8dZdeRndRU3kNFNuYIccgt2kes
         xmEvvFUNBZmqzP2Yy3ugJTexHlJF/QsCmBIAKwVF7QAD42CscPyyQZAC6AtFXUhGWTJx
         VBog==
X-Gm-Message-State: AOJu0YzJbO8WavpGNKhSM3dDmzjV4rBKj5oZw94LqyF+IrGUbSkmb5Cm
        TGY7X/dT0t6vwwvCVaP54G71MkrcUg==
X-Google-Smtp-Source: AGHT+IEh96+Eom5+++QZIF6DKoxC+gFh+J0Jjb7AI/CVWjOw1Yv61sZNaPJPNdmEwA+s6Pu73BExDw==
X-Received: by 2002:a05:6870:2893:b0:1e9:da6f:a161 with SMTP id gy19-20020a056870289300b001e9da6fa161mr20155913oab.3.1698264189543;
        Wed, 25 Oct 2023 13:03:09 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i1-20020a056870344100b001ea7e2adbc2sm2775807oah.1.2023.10.25.13.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:03:08 -0700 (PDT)
Received: (nullmailer pid 1069035 invoked by uid 1000);
        Wed, 25 Oct 2023 20:03:07 -0000
Date:   Wed, 25 Oct 2023 15:03:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v2] dt-bindings: irqchip: renesas,irqc: Add r8a779f0
 support
Message-ID: <20231025200307.GA1068690-robh@kernel.org>
References: <9467a1c67d5d240211f88336973fa968d39cc860.1690446928.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9467a1c67d5d240211f88336973fa968d39cc860.1690446928.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:36:23AM +0200, Geert Uytterhoeven wrote:
> Document support for the Interrupt Controller for External Devices
> (INT-EX) in the Renesas R-Car S4-8 (R8A779F0) SoC.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
> v2:
>   - Add Reviewed-by,
>   - Widen audience after testing.
> ---
>  .../devicetree/bindings/interrupt-controller/renesas,irqc.yaml   | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.
