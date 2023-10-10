Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BFD7BF188
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442032AbjJJDby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442021AbjJJDbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:31:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E0692;
        Mon,  9 Oct 2023 20:31:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF73DC433C8;
        Tue, 10 Oct 2023 03:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696908711;
        bh=5a/eXg4zhIfuEa60hhkirr8gSREXauzictNAgXnjWbc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=m5YZHZb0WeMcqIdgc8XvoroGMvjehK0/gwTTpYbb4u8YHbYb7k7K6y/ZtkuCZKIV8
         LO8pQVv4XU1JR0/bcF0oQ9vAnJKTkStWfnHNG1PO21sodlfzsUTZ/i7NPac6PuvIPn
         CPqqNxKyao0xEQ1XOqto/F8NP8eQcYoF4dwldu65F75cQPoRMjhIUvj82lYSerE4KI
         cgvSAcNMBJfDB3DnMeAmb3yiN8DUbpL9MzhnT5fP2/vt4Jq5au3nsInQKEztPesbaq
         Vq0Zq/uFgF8gqQ4sd2Q1qjVbn3YA+jwZIrxC8WsIkz8LIgcCk4MoKv3XcQyhhBPfth
         xH3ZM5X6UVLSg==
Message-ID: <1a0da000de972ee9a8c63685c789928b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230929-clk-maple-versaclk-v1-4-24dd5b3d8689@kernel.org>
References: <20230929-clk-maple-versaclk-v1-0-24dd5b3d8689@kernel.org> <20230929-clk-maple-versaclk-v1-4-24dd5b3d8689@kernel.org>
Subject: Re: [PATCH 4/4] clk: versaclock7: Convert to use maple tree register cache
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
To:     Alex Helms <alexander.helms.jy@renesas.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 09 Oct 2023 20:31:49 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Brown (2023-09-29 07:26:08)
> The maple tree register cache is based on a much more modern data structu=
re
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Applied to clk-next
