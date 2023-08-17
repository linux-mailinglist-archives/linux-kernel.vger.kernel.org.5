Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B829E77F3EF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349849AbjHQJ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349575AbjHQJzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:55:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0670E12C;
        Thu, 17 Aug 2023 02:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81875617E6;
        Thu, 17 Aug 2023 09:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B3FC433CC;
        Thu, 17 Aug 2023 09:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692266138;
        bh=pXiGancAeYKnPcvOFhUswbg11PDFY6ZLcz2zikEUJVg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=brXns1YmUYp1vyVgROcwnPjf7nbY3k2odTOaRRIPfWHHZ7WMV1Rw+ZQdpvvtLe1Es
         CG+otVE+H4qlFvN8qoV0Z4ZGjKYCdwLZ+05f+I/kRQf1383ISYuJg81eLSY0qC6NZ5
         SP8uShxTY5gRC7/w5RPLAf2I0PN1LQl/riWzj+6tGdy/lVuykGoj5dF3cFVAplmSRf
         5r/1GbONOFOIRZ3AQ+RFAJxmAgXEq3CZEMYdeTrIuzomhjanU8DnQnoKomzC5eCAkp
         tavvCchX8+cCNvXuUmHSMcEgM/9GhoqUeLH+LKP8Tymw+wGSjJtBj3PG71HBQyd/IU
         9xMkTBlrvXe+A==
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-mediatek@lists.infradead.org,
        Eugen Hristev <eugen.hristev@collabora.com>
Cc:     chunfeng.yun@mediatek.com, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        sam.shih@mediatek.com, jieyy.yang@mediatek.com,
        frank-w@public-files.de, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chris.obbard@collabora.com,
        kernel@collabora.com
In-Reply-To: <20230814093931.9298-1-eugen.hristev@collabora.com>
References: <20230814093931.9298-1-eugen.hristev@collabora.com>
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: phy: mediatek,tphy: allow
 simple nodename pattern
Message-Id: <169226613323.81413.1101515821069495424.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 15:25:33 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Aug 2023 12:39:30 +0300, Eugen Hristev wrote:
> The pattern for the nodename only allows t-phy@... , however, for the case
> when the t-phy has no `reg` and only `ranges` (basically when the t-phy
> is just a parent node), dtc will throw this warning:
> 
> Warning (unit_address_vs_reg): /t-phy@1a243000: node has a unit name, but no reg or ranges property
> 
> For a node like this:
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: mediatek,tphy: allow simple nodename pattern
      commit: e4077ca4ebdefa1b4616e4dafcb67b621253b233

Best regards,
-- 
~Vinod


