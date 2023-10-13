Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730CF7C905A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjJMWi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMWi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:38:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0468CB7;
        Fri, 13 Oct 2023 15:38:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8823EC433C8;
        Fri, 13 Oct 2023 22:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697236735;
        bh=usKEUVWheOZMQgx8MWyA6BzS1pi67O5cI/bZkf+wg9k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EqNQgpWr8H6hdFKyIrH/NuV/CHA1F6iTniXqW++EmL5fQ4z2iciBHa5y9k5TXhb8R
         ZqX5wgb/r9lqT9iHtN4iQ5neooTtFRDmw3JxK8uFjan06tYHQlNXnbNe7onB+tAEfV
         uozwEJfY2ZyFimEZuI4EsHgkigCOjlCgNjBXsohwY9+gZaOT8+eRTkTBkoXCEDtF0m
         tK5HwDBMTGBbkJrEedBeQfTF9uWd5BezNpAHNxM/CSPCNH77T29WPxO76ZB1sgO6Y8
         7Fj1W5b05f2h90exMtz7p+T7EY/32hO14z7NbA/FQs+6t7iAvMphH4+LgsfNaCYciL
         PJcvnFafI5L+A==
Message-ID: <23452d8921f1a2ec898ffeaa5fb2c54e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230930221428.18463-1-rdunlap@infradead.org>
References: <20230930221428.18463-1-rdunlap@infradead.org>
Subject: Re: [PATCH] clk: linux/clk-provider.h: fix kernel-doc warnings and typos
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Date:   Fri, 13 Oct 2023 15:38:53 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Randy Dunlap (2023-09-30 15:14:26)
> Fix spelling of "Structure".
>=20
> Fix multiple kernel-doc warnings:
>=20
> clk-provider.h:269: warning: Function parameter or member 'recalc_rate' n=
ot described in 'clk_ops'
> clk-provider.h:468: warning: Function parameter or member 'parent_data' n=
ot described in 'clk_hw_register_fixed_rate_with_accuracy_parent_data'
> clk-provider.h:468: warning: Excess function parameter 'parent_name' desc=
ription in 'clk_hw_register_fixed_rate_with_accuracy_parent_data'
> clk-provider.h:482: warning: Function parameter or member 'parent_data' n=
ot described in 'clk_hw_register_fixed_rate_parent_accuracy'
> clk-provider.h:482: warning: Excess function parameter 'parent_name' desc=
ription in 'clk_hw_register_fixed_rate_parent_accuracy'
> clk-provider.h:687: warning: Function parameter or member 'flags' not des=
cribed in 'clk_divider'
> clk-provider.h:1164: warning: Function parameter or member 'flags' not de=
scribed in 'clk_fractional_divider'
> clk-provider.h:1164: warning: Function parameter or member 'approximation=
' not described in 'clk_fractional_divider'
> clk-provider.h:1213: warning: Function parameter or member 'flags' not de=
scribed in 'clk_multiplier'
>=20
> Fixes: 9fba738a53dd ("clk: add duty cycle support")
> Fixes: b2476490ef11 ("clk: introduce the common clock framework")
> Fixes: 2d34f09e79c9 ("clk: fixed-rate: Add support for specifying parents=
 via DT/pointers")
> Fixes: f5290d8e4f0c ("clk: asm9260: use parent index to link the referenc=
e clock")
> Fixes: 9d9f78ed9af0 ("clk: basic clock hardware types")
> Fixes: e2d0e90fae82 ("clk: new basic clk type for fractional divider")
> Fixes: f2e0a53271a4 ("clk: Add a basic multiplier clock")
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> ---

Applied to clk-next
