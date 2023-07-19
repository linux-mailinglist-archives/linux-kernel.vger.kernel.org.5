Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED0A758E63
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjGSHJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGSHJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:09:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C9C172B;
        Wed, 19 Jul 2023 00:09:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2791612D1;
        Wed, 19 Jul 2023 07:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F47C433C7;
        Wed, 19 Jul 2023 07:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689750571;
        bh=TGuGkslziOMhZmDOtzDSHlMeJVeuyRbhFTxBT82YCA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmqvQ2IGwmEfA/K8sPK+HIhxiUQml9qk6b5yEHcPMSwej/C66TtKHsbYyEhp76sZB
         mNrfx3m0OzWg3tB5CLaj8aXiU+Rrs0A89cYMEyNKCgqvoAoj3MyMWKqXErE6l+JUrW
         ztN/5AByAn6AdPPtFI9kOLqPLu5Qy1mqJfSUBUo0QHG1w3Mjv4NrDQHEsy9AJPSRLz
         pn5r0EYQI2c22WwEbchiDibcy+l8tLi2X7wqRw+uj5AKBb51tmGLWPCtPvj/XDZAGR
         QrpdWrbDE/mW4SVDmr8o2ExmChTQagkRoBIQaEph1l3vysWjfZVh4PGTmHPDxlAgB0
         ppBlb6n3PxPPg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qM1Jb-0000xJ-2Z;
        Wed, 19 Jul 2023 09:09:39 +0200
Date:   Wed, 19 Jul 2023 09:09:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] clk: qcom: gcc-sc8280xp: fix runtime PM imbalance on
 probe errors
Message-ID: <ZLeMMxxtsqrwXWOd@hovoldconsulting.com>
References: <20230718132902.21430-1-johan+linaro@kernel.org>
 <20230718132902.21430-5-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718132902.21430-5-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 03:28:58PM +0200, Johan Hovold wrote:
> Make sure to decrement the runtime PM usage count before returning in
> case RCG dynamic frequency switch initialisation fails.
> 
> Fixes: 2a541abd9837 ("clk: qcom: gcc-sc8280xp: Add runtime PM")

I noticed you merged these for 6.6 instead of 6.5 as I had expected.

Note that I left out the stable tag here as the offending patch was
merged as a fix for 6.5 and I specifically assumed this fixup would go
in as a fix for 6.5 as well.

> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Johan
