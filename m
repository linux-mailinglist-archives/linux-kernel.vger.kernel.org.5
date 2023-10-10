Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095017BF183
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442040AbjJJDan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442039AbjJJDa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:30:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154F4DB;
        Mon,  9 Oct 2023 20:30:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E742C433C9;
        Tue, 10 Oct 2023 03:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696908625;
        bh=O1wyqx/9Ds6QxvhtYzNXKXlMwEy5eps75KSeWMdqqjM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=os1xvpH5ZwDMCtoZ+/ZBxaMkZgeKuTgip+vqJRLUSIvDyKw+TrbOGHnx3FOY8kGP3
         d+kTVC9WHKJBcqIxS4Spdc8vwOtrh9ZLfGotv+QKkpAhFSPbVojaeR33dA1O51tZ/v
         VNti3OynZr931jKYMcGMD4YmL2Bx53luu+0P6LaWmMSduYsDzsp4YGcB4PeuoGS5/8
         S/yj775oJ7NNQE22PoRZaSpN7GINryzxualkP0iBRzyet14azTv1RxHZH/ONYhcn0Y
         4UFew/rh16eNZXQWVQvWUHKtH+P5srg6SJTE/udofZPpj4VqY36S1DJ+YUucWu7D1J
         VPg4Zd58YnUKg==
Message-ID: <02047625d2466237a8787c81de6e4279.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230929-clk-maple-si-v1-1-e26cfcaf27bd@kernel.org>
References: <20230929-clk-maple-si-v1-0-e26cfcaf27bd@kernel.org> <20230929-clk-maple-si-v1-1-e26cfcaf27bd@kernel.org>
Subject: Re: [PATCH 1/5] clk: si514: Convert to use maple tree register cache
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 09 Oct 2023 20:30:23 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Brown (2023-09-29 05:21:59)
> The maple tree register cache is based on a much more modern data structu=
re
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Applied to clk-next
