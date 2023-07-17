Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39970755C43
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjGQG6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGQG6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:58:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64376E6;
        Sun, 16 Jul 2023 23:58:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0240060F31;
        Mon, 17 Jul 2023 06:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE236C433C7;
        Mon, 17 Jul 2023 06:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689577118;
        bh=ftPB+gA80Oi5Fk0N1wnPVaxi1tBS/P5y3ItAmzUQ2mE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZS4FHXkIzqcvlSAtdl0aCCk/VXJ13yVtaByRKXvFjk39M3kp47FXUHwW7Bl1UstAU
         iKablHGr/ppzss1ColXmbJNVnx7l43OEQtLF/6Nc4qlJ9ewLJPnPDbqLqQ41+AKhcW
         aut8mBp2nMB9n6t+8tYKV3AMxL63CU5mIGN2HkTmYJOaZRjy1imzzl+2ltHpphAmQf
         VAHZCflgO0CM1GlolLy20xwOjgxi7euhWQ5rKsikv4bUmknGsUZXCCE1l13+Gd08Nj
         CG9XJbO95r8KsxtuVnQ3+jAcF4Pa/e/VYD5GkCbhCvMdB99x/xUxTfKEm/LobHGQb6
         CYeg5zvOMf8OQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230714174946.4063995-1-robh@kernel.org>
References: <20230714174946.4063995-1-robh@kernel.org>
Subject: Re: [PATCH] soundwire: Explicitly include correct DT includes
Message-Id: <168957711444.296382.9973518648433664121.b4-ty@kernel.org>
Date:   Mon, 17 Jul 2023 12:28:34 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Jul 2023 11:49:46 -0600, Rob Herring wrote:
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

[1/1] soundwire: Explicitly include correct DT includes
      commit: 3f92da3ea4480648ebeb8a4802085908a5c64cee

Best regards,
-- 
~Vinod


