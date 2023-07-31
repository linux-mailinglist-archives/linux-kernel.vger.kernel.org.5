Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D0C76A2F1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjGaVfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjGaVfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:35:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537D82113;
        Mon, 31 Jul 2023 14:35:09 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 64A166607030;
        Mon, 31 Jul 2023 22:35:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690839304;
        bh=+Qw/EKKjhVitBPeNeytCK9mdp70rSjFj6Cp11Vay6qk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ATBVYNT26DDVnsCnkFakRRYvMv6RKdN2s2vzQMG44IrNRNrw16eFb9xYoahCLKhGW
         NvYkvoordiN4v17X44B9VaHP7aECJtbJ2LAx8q2T79PmKv/TlppY9bRqqXnQ/I0G6d
         lF/sYbcM54roH8YaWtvkz9MdJzI4Esq0woT7rOFg7CQFI5BU1Poy46iLwbx25Rkzyi
         mTMJnqlaqUuZ9c03rHb/SoYeuTwi9mgZubSmRy8VXgAtREeWs9eageRjZ9ysak0P/r
         nfSEEZJgRTMc0kmLiCH47hrI3XWwvC8VaHvAuTV7cJyPs4oFVHY+d6WfaDfQxPK0+L
         kaVUEBtH6NI4Q==
Received: by mercury (Postfix, from userid 1000)
        id 0244F10622DC; Mon, 31 Jul 2023 23:35:00 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230714174554.4056851-1-robh@kernel.org>
References: <20230714174554.4056851-1-robh@kernel.org>
Subject: Re: [PATCH] hsi: omap_ssi: Explicitly include correct DT includes
Message-Id: <169083930099.70164.13850344617234955659.b4-ty@collabora.com>
Date:   Mon, 31 Jul 2023 23:35:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Jul 2023 11:45:54 -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Applied, thanks!

[1/1] hsi: omap_ssi: Explicitly include correct DT includes
      commit: 7ebf243a201856adcac240e490596bb908ee5fcc

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

