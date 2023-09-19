Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2817A59D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjISGO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjISGO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:14:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC57FFB;
        Mon, 18 Sep 2023 23:14:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD96C433C7;
        Tue, 19 Sep 2023 06:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695104091;
        bh=Lgd5+nYbpB9ZFLzoFtX/eam0a0z2Dw22oPiFpAlfiZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQyPYAebob2b+Cm8kfLBd/WNROy8/CTQdrrPZcpGUuC0F0RZAoAIFSFaCpMAX40eD
         /NeEvOs7WdWkYLs1xctmfSbmzhkCGEFTrXT6ZmF7RJ62hIkxKP1UeZbjsHSBjA7gYg
         FhGWi+kcW/WqfBaSrs2REN9MeyPl9FD+rYManlTOYwym3Z5Qp09r0dUkaVWoYCTCMv
         LUNf7XpsrE2uC36YMhw3TS2F5QDRFSoSMgtFH4Qkxcb2He/KRLyWftZE/VOjqdqkWw
         Oh+j9hjn4qDk0yVg4KX4d4oqgF4Cw1drlDulE0Mp9j5erTT9FATYCq9ESd4niPwhRh
         8V9lEbMZ1exgg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qiU0m-0006Eq-1E;
        Tue, 19 Sep 2023 08:15:04 +0200
Date:   Tue, 19 Sep 2023 08:15:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.5 30/36] arm64: dts: qcom: sc8280xp-x13s: Add
 camera activity LED
Message-ID: <ZQk8aJx268Soy4yH@hovoldconsulting.com>
References: <20230908192848.3462476-1-sashal@kernel.org>
 <20230908192848.3462476-30-sashal@kernel.org>
 <ZP60ngCV3hhNZiX5@hovoldconsulting.com>
 <ZQjEEt7sB2M5EO53@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQjEEt7sB2M5EO53@sashalap>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 05:41:38PM -0400, Sasha Levin wrote:
> On Mon, Sep 11, 2023 at 08:33:02AM +0200, Johan Hovold wrote:
> >On Fri, Sep 08, 2023 at 03:28:41PM -0400, Sasha Levin wrote:
> >> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>
> >> [ Upstream commit 1c63dd1c5fdafa8854526d7d60d2b741c813678d ]
> >>
> >> Disappointigly, the camera activity LED is implemented in software.
> >> Hook it up as a gpio-led and (until we have camera *and* a "camera on"
> >> LED trigger) configure it as a panic indicator.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> Link: https://lore.kernel.org/r/20230805-topic-x13s_cam_led-v1-1-443d752158c4@linaro.org
> >> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> >This is a new feature if anything, not a fix. Please drop from all
> >autosel queues.
> 
> Not a feature, but hardware enablement.

Call it what you will, but please drop it. Otherwise by that logic you'd
need to backport all devicetree patches (as well as most driver changes)
since they ultimately aim at enabling hardware.

Johan
