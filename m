Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B91B7CCBD2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344122AbjJQTJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343997AbjJQTJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:09:52 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E83ED;
        Tue, 17 Oct 2023 12:09:50 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6c67060fdfbso4246307a34.2;
        Tue, 17 Oct 2023 12:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569790; x=1698174590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hsq/qKnq6l/ZglDvqX8puzt3/YPat0dlcmzHX8n059w=;
        b=NlzBa1ci8yQ+FekNyMscEYJrANVRqMXJMmE9gar0IZ20kz1cB4kJFNcRhFCPNER1y1
         A865kKCiqMltpy2ygiSYwFUrh0WaldbTMMe2fOPnHoPs5n38hv82QGWj0bkZXDdcyFcd
         ySO6Zgl97OYfSjikJFf24fNqYxJpRP46jM0GyLCp+FJ8jbWNDSFwa1vr0pPucrRDs5oe
         x0MhrSqYkxALapKbaqT8z6upK4mEDeBTdKEXjRanpuM1PWhL6WXmwLD2Y1zKwNfxtaVs
         vDjZ5dZIf6VVFPLjSzHux8O5IEj9ZX+5OIrTaznmXTZEhThwWZ98rm5E95a9PC5Zv1EZ
         Ncvg==
X-Gm-Message-State: AOJu0Yx5Ifc/xzgi3sDvuliNAd8eNGY629XdEywfOdKcTARKmCp+qSUt
        Nj0agi0/p7ttFiLBQywBQQ==
X-Google-Smtp-Source: AGHT+IFsuTE38qfeNB0xuLfLDlF3//sxJrUPKESH01L/xPOutm3tTkoAeKJmsazGo7ze21d+XITEfQ==
X-Received: by 2002:a05:6808:138a:b0:3b2:e12e:d2db with SMTP id c10-20020a056808138a00b003b2e12ed2dbmr1925675oiw.39.1697569789785;
        Tue, 17 Oct 2023 12:09:49 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bl24-20020a056808309800b003afc33bf048sm253949oib.2.2023.10.17.12.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:09:49 -0700 (PDT)
Received: (nullmailer pid 2526574 invoked by uid 1000);
        Tue, 17 Oct 2023 19:09:48 -0000
Date:   Tue, 17 Oct 2023 14:09:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sam Edwards <cfsworks@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Daniel =?utf-8?Q?Kukie=C5=82a?= <daniel@kukiela.pl>,
        Lokesh Poovaragan <loki@gimmeapis.com>,
        Sam Edwards <CFSworks@gmail.com>,
        Sven Rademakers <sven.rademakers@gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: rockchip: Add Turing RK1
Message-ID: <169756978718.2526521.10700760788625408970.robh@kernel.org>
References: <20231011225823.2542262-1-CFSworks@gmail.com>
 <20231011225823.2542262-3-CFSworks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011225823.2542262-3-CFSworks@gmail.com>
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


On Wed, 11 Oct 2023 16:58:22 -0600, Sam Edwards wrote:
> Add the Turing RK1, a Jetson-compatible system-on-module (SoM)
> powered by RK3588, from Turing Machines, Inc.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

