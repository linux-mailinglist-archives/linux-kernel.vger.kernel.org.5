Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87EE79D831
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbjILR6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbjILR6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:58:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5005310D3;
        Tue, 12 Sep 2023 10:58:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71B3C433C9;
        Tue, 12 Sep 2023 17:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694541515;
        bh=+Eq25XEn9jifU6vVTGtb/lZ0KcmNKOeLGV079+pMeDU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uaabi6dfyRs9j65Aa1XYQUeho12OQxb7SNNtrBiWpQzSj+7YhVgAffPnJF6+qzABd
         p8ytouZDqJLsT8UsX6HJiM1xD2gxVvu2BNG2+mJpiSbd5A7cTZlQRp36PufhCtImLY
         hAgzJatDyYmgPgWf8LrYmxGmYu7CyxcmWBsbCTrMuCNYMh9DLVpjEBv5xP3V9fc1js
         pn0hVcsb+DGXjAi0DuSe2syAXHAeVX7fE11sdTC7b28kvcuZSULRZcbIE4Ubv9lnew
         mG+p9++0UotYJcnMCW/BB5lkkvNz+u8lq25656a+nwuwKryYB/lMRyiJ+A+dd+LdOq
         WMRkm3KL6bacQ==
Message-ID: <1a1278715076b92ae73ac97950cd70e9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230912112951.2330497-1-cyndis@kapsi.fi>
References: <20230912112951.2330497-1-cyndis@kapsi.fi>
Subject: Re: [PATCH] clk: tegra: fix error return case for recalc_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Timo Alho <talho@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>
Date:   Tue, 12 Sep 2023 10:58:33 -0700
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mikko Perttunen (2023-09-12 04:29:50)
> From: Timo Alho <talho@nvidia.com>
>=20
> tegra-bpmp clocks driver makes implicit conversion of signed error
> code to unsigned value in recalc_rate operation. The behavior for
> recalc_rate, according to it's specification, should be that "If the
> driver cannot figure out a rate for this clock, it must return 0."
>=20
> Fixes: ca6f2796eef7 ("clk: tegra: Add BPMP clock driver")
> Signed-off-by: Timo Alho <talho@nvidia.com>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---

Applied to clk-fixes
