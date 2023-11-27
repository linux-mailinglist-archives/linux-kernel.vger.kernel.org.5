Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2387F9D46
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjK0KP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjK0KPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:15:54 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EE59EA;
        Mon, 27 Nov 2023 02:16:00 -0800 (PST)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id B99B91A6DDA;
        Mon, 27 Nov 2023 11:15:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1701080160;
        bh=eAhgPje9vHibRmObvDpBzw2Pjvc6FHaCkUAWpn5/+o8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vcyfY41GS/4Z36EIYT5/OLQA3/PW2Pr3LoAaoonYmdaf6O/GcFJys50/WPm5m9cPe
         8mcSG1A5IqMVYpgG/mqbH2nAWUEVUZfYG3PhPeAK5NElUlX5KJUZnF7WiK3aKAi2+T
         XbTfaY8EhFlIg+WNgHJWgbMtLl3yHoszK+Rw2H6N1bzkdHNIYb8LY2lGe2DHkwPwPI
         qaxKC9iy0in/VG5RpHZ/59CfM0vsmBmvx99KVGlYfaYdbnthdsdJGIrn49V6p5nF5v
         wyV0zDAavbxB0xWxNJhciPYomQwU5VCGIawM3aawKmxusN6BQCUwdz9e1OzawAY7cT
         38UIGr/oFmMnw==
Date:   Mon, 27 Nov 2023 11:15:58 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Apple M1 USB4/Thunderbolt DART support
Message-ID: <ZWRsXm7fFCODruj0@8bytes.org>
References: <20231126151701.16534-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126151701.16534-1-sven@svenpeter.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 04:16:58PM +0100, Sven Peter wrote:
> Sven Peter (3):
>   dt-bindings: iommu: dart: Add t8103-usb4-dart compatible
>   iommu: dart: Write to all DART_T8020_STREAM_SELECT
>   iommu: dart: Add support for t8103 USB4 DART
> 
>  .../devicetree/bindings/iommu/apple,dart.yaml |  1 +
>  drivers/iommu/apple-dart.c                    | 35 +++++++++++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)

Applied, thanks.
