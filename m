Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C404782F77
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbjHURbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbjHURbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:31:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788A5119;
        Mon, 21 Aug 2023 10:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D7EB636E3;
        Mon, 21 Aug 2023 17:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782B8C433C7;
        Mon, 21 Aug 2023 17:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692639093;
        bh=VkemwibYJ2nMzyGNc3hL2Coq8QPTF8mVnHs9ZucqfV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iKLzO+HCkli6SytGfQDyri5m6mX8il8Ygo8QkFmlAyxkATiyObOGpZFkKbUIbwvDS
         WHNM5sFvBjO8b8ZyXtOwY3UnoPnvUyAYVZAoJIMFSLwkKytxF9mpjGu8YuVcldWcfk
         aWljEjo7eE5/XC61hCq33NMnlRibYy0ODQNtDx8gqoKFMJri9d7oCp7O6JnYWbylZa
         SbuKUuyX3pVCtbveJtSfcmmIkRsM8l7lD7Puo91137q2YSyJbDOJDPZt+pDbHoXXTW
         DYO28g3tfjyB53CCXUOfvNefbys7SpkNLXCzBPTS2KYbxUP5FbyFRRSRMBbEXoUg+Y
         ZzLkxX5F5O+2w==
Received: (nullmailer pid 2000961 invoked by uid 1000);
        Mon, 21 Aug 2023 17:31:31 -0000
Date:   Mon, 21 Aug 2023 12:31:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 2/8] dt-bindings: mtd: nvmem-cells: add support for
 UBI volumes
Message-ID: <169263909099.2000909.1836274572837880546.robh@kernel.org>
References: <cover.1691717480.git.daniel@makrotopia.org>
 <7df4543f5dacef006bd7067117cf959b59842d69.1691717480.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7df4543f5dacef006bd7067117cf959b59842d69.1691717480.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Aug 2023 02:36:55 +0100, Daniel Golle wrote:
> UBI volumes may be used to contain NVMEM bits, typically device MAC
> addresses or wireless radio calibration data.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../devicetree/bindings/mtd/partitions/linux,ubi.yaml        | 3 ++-
>  .../devicetree/bindings/mtd/partitions/nvmem-cells.yaml      | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

