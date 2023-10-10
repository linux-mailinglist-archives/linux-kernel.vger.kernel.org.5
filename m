Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75577BF15E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441862AbjJJDXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441969AbjJJDXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:23:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6002A6;
        Mon,  9 Oct 2023 20:23:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40113C433C8;
        Tue, 10 Oct 2023 03:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696908199;
        bh=svOySVpdTq4zrtHC4TrHg5u+BeEE9tyEDYgZhlD3pCQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=vBaoLD918wWXo8ktHuxu9HLV8XPLWeZoEb4PkV7WLRdsS8dJdPwo2Yl3gu3fDN+Kt
         KFZuZDqxDW0gri1BStfkikMQssLJYUnxfulQBDJ61h0kzHUlJuM20FLNDhuJpvZaeA
         ed/gsrgXSImJsZpf41m/rvaL5Sl7zUqwIbpAoRipQsu6UcMu5NnPNexkCE/YVL0S0c
         rsXf3sabsU3K+wfI/209LMAQhY5FKQV7GW8MSWYo68QgcFV8ylxr9L5cbxJB5075Zj
         O5huJv1ZaYxt7e0uAx0XfiCVXYRjjWHHBNsJzBCs7WH8m8VayReBpoThm6YWeg2kWE
         YtTO63l0iHtqw==
Message-ID: <7be6d0f2101b82f423818a2bb82eee90.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230912175534.2427862-3-sboyd@kernel.org>
References: <20230912175534.2427862-1-sboyd@kernel.org> <20230912175534.2427862-3-sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: Parameterize clk_leaf_mux_set_rate_parent
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
        Maxime Ripard <mripard@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Mon, 09 Oct 2023 20:23:16 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2023-09-12 10:55:31)
> Transform the existing clk_leaf_mux_set_rate_parent test into a
> parameterized test that calls the various determine rate APIs that exist
> for clk providers. This ensures that whatever determine rate API is used
> by a clk provider will return the correct parent in the best_parent_hw
> pointer of the clk_rate_request because clk_rate_requests are forwarded
> properly.
>=20
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
