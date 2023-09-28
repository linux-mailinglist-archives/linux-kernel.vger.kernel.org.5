Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3C57B1F01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjI1Nxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjI1Nxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:53:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3AA136
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:53:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749F9C433C7;
        Thu, 28 Sep 2023 13:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695909222;
        bh=iSo3Vv83opeDiMziiEr9meXPXAR2jmotAhidSIfYl6w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PqnkxzaG+HrT5zGQTiwMcCeLp7HVQWUgvpP+JNa+GImZP+vSiQ6/YdVZCnkWr6pdo
         CkKk9dcvct1QPopVq/V5gAFiOfjnLLr+kDpu+cM9gejtIaC1TG8ssKutPr1OdqCD7M
         4OgBzFnnrKWOpgZ39TOvPRlMuaAxENgP5Tk4l1iLqXx3iTAM90j7LGZhHqwEc+oYHa
         OaGLotqMvA6Wa+TbZnIRno5Tx2OXdaMhHwNlT2+eO/Zrtovq7KisCD0uv5VC9qBNSg
         fr399/rR8vboIG6uNxQ/35Giy7c6fNGdpJbV4QBgPztLYVXDFWLiTXk8/aTrm0llZH
         SCcckzyFs6aag==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        - Keerthy <j-keerthy@ti.com>, Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org
In-Reply-To: <20230925212729.1976117-1-robh@kernel.org>
References: <20230925212729.1976117-1-robh@kernel.org>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: Add missing
 unevaluatedProperties on child node schemas
Message-Id: <169590921918.1613753.10940861151886567899.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 14:53:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 16:27:24 -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
> 
> Add unevaluatedProperties as needed, and then add any missing properties
> flagged by the addition.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: Add missing unevaluatedProperties on child node schemas
      commit: c7d1263be9396582f86024dc33f336d974496b83

--
Lee Jones [李琼斯]

