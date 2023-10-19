Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9603E7CF915
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345596AbjJSMgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbjJSMgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:36:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DDD91;
        Thu, 19 Oct 2023 05:36:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D85C433C8;
        Thu, 19 Oct 2023 12:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697719000;
        bh=zPLlV2d7AkNv4mXJFH+PHDI8dVAGF6XbxkLaS0eaDAY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=l656K7EZjJjaUIeTiC/m7D9Fx4rrQh4M4fDTE/e0PWN8LUrmPReFiSLe0MYWffagH
         1R+E8L+QhcZhl/xJA93IjSS8dyaqjMtMIUpXFqt40rNzWqK1YxNNjIYe4j3mUlewqg
         p8tBIGdiQ9IJi2JpTYW6r3JudTExgKYSBniq2M5I3nbTpZ+a9chcric5XDHtAatRW0
         guo03/Qg/RePcMthSgrQcL0VlXJK7VRLfMF0pjZMNSNpuoaSTcNYLjBUfPrB31g3Jw
         BI8BW4tOYgQ/UzXE9mbZa9qTIhwOL4a0BaWHafF0gzFURWM+vxK+wI20L0/N2q/qQV
         OO1X/bGQsVrbQ==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org
In-Reply-To: <20231017203612.2701060-1-robh@kernel.org>
References: <20231017203612.2701060-1-robh@kernel.org>
Subject: Re: (subset) [RESEND PATCH] mfd: Use device_get_match_data()
Message-Id: <169771899726.2477462.15071317748213274655.b4-ty@kernel.org>
Date:   Thu, 19 Oct 2023 13:36:37 +0100
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

On Tue, 17 Oct 2023 15:36:10 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> 

Applied, thanks!

[1/1] mfd: Use device_get_match_data()
      commit: b0919cf8ff1160eb3d8fe4236620e8b6a3cefa54

--
Lee Jones [李琼斯]

