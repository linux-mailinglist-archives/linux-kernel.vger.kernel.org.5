Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8727A607F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjISLB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjISLBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:01:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38FF12F;
        Tue, 19 Sep 2023 04:01:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD9AC433C7;
        Tue, 19 Sep 2023 11:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695121306;
        bh=c/PyV2hre80VbWwB9fK5oidLjC6ryxb/+42Jw2t/bFQ=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=ts37NcED95/E8MxaWIL/Kmj/KYCvkndLduGCPbwSkwEp238wn6v3uuDT11zSnZwZE
         hkj4dGGnX7TjHVa+brG2BGNi/D18c+gUNAMFJ+2OvEgoyzlOQFt5vHSD5lyr6vdNww
         eRq6xTdbF1y0xLy9HSO4XjTOwaOw7lIh6JtRCP6kH4hRwO4I+kBHlmmDZwGjM3aWs4
         EUZ9gBnbJhTDAZ4F2DX/tuY+4FPy5KOinaBrKwICim+7iy5+c7t6s8tK+yuFvOeiw3
         qChst3MRTSuRvgPMPECJeqbWRcZ3ugx/cKqbgF72QzJwVDdzzsrfR3jf65AAAc7EaM
         l9p4bXFAAvdBg==
Message-ID: <f780cc47da223a96bdaffe2361388641.mripard@kernel.org>
Date:   Tue, 19 Sep 2023 11:01:44 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Stephen Boyd" <sboyd@kernel.org>
Subject: Re: [PATCH 0/2] clk: Fix lockdep warnings in clk_test
In-Reply-To: <20230912175534.2427862-1-sboyd@kernel.org>
References: <20230912175534.2427862-1-sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, "Guenter Roeck" <linux@roeck-us.net>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023 10:55:29 -0700, Stephen Boyd wrote:
> This is a replacement for the series from Maxime[1]. I didn't want to
> introduce more wrappers, so this series takes the approach of driving
> the test from a clk_op instead. The second patch extends the test to
> look at more determine_rate variants. We can probably extend the test
> further to set or not set the CLK_SET_RATE_PARENT flag as well but I
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
