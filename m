Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F5D7792C1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjHKPSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbjHKPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:18:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4104530DE;
        Fri, 11 Aug 2023 08:17:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEF3E6748A;
        Fri, 11 Aug 2023 15:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE9DC433CC;
        Fri, 11 Aug 2023 15:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691767074;
        bh=PoROgr1ezcari3jTV71mALtsKzk/4Owqf38304zYh0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fkhRj0T7n8hC921y+qFzPwZ1e1kXJ7SdxBWAwtzj2X2noTyak9wML6sl1OEQDlaAM
         uUrusYfJvDHzWXVyQxm1UnfdDzl3bmcxPBODhkJ+6UpQHR0kLzVFqFmYSGkfpj/50t
         rzM+oQrJyP0eGSvvkjJSQeoUhn6u5ANVUJUTCoFZxXaOGsMCDgsWQTcKHQJyWGch4k
         pzhb6RGH8hjbGi4chikOnN0ISTv62IoDJzD+7nw17fSfG6002LftIvRhrl7MSmj0f7
         8XLw51YQ8LwCyLuXjl6MLX1zi2i8yNLz6yrCnt7QDevB7UhzhhWtZGod+dJ0JQCsYP
         GHX0/BmNipOXg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-sm6350: Fix gcc_sdcc2_apps_clk_src
Date:   Fri, 11 Aug 2023 08:20:41 -0700
Message-ID: <169176724021.691796.4516185582008783101.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804-sm6350-sdcc2-v1-1-3d946927d37d@fairphone.com>
References: <20230804-sm6350-sdcc2-v1-1-3d946927d37d@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 04 Aug 2023 16:09:30 +0200, Luca Weiss wrote:
> GPLL7 is not on by default, which causes a "gcc_sdcc2_apps_clk_src: rcg
> didn't update its configuration" error when booting. Set .flags =
> CLK_OPS_PARENT_ENABLE to fix the error.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gcc-sm6350: Fix gcc_sdcc2_apps_clk_src
      commit: df04d166d1f346dbf740bbea64a3bed3e7f14c8d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
