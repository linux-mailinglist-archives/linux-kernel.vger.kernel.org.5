Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D3C7BF177
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442029AbjJJD3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442013AbjJJD3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:29:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911949E;
        Mon,  9 Oct 2023 20:29:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA8AC433C7;
        Tue, 10 Oct 2023 03:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696908577;
        bh=PNrpxzwMPHZAXENZJTeP+nz+JFLdco5OM86AWAA6ZEI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fZmgN+7BIky+iz4AHaKxaW1VUc/zGefQSNu1gjrl5i6VLbRS/wulqcjj59JZmRQ9Q
         7Og7JbAJpitKGIv/BQ/GsgUINeaXiIjrMKR8ZBMC8pIVXFAT3gkZw2ISEb9Y+nqxkV
         XB82BkqytMa7oNUWw1vdUk/SODHE2i28rWVJasTxl+CWFxlsOF2UDeRH4ZqFO//Hgq
         VmaRRdHeTMOgzSYD7Z8mXSM7yMQMnQnhImmFelVugyC9hU7qkrYKnjVdp4HKGKYUco
         xsnOOsxf/oGM0RfGHu6LQpS0jWNwAzsmArK3G16AQwrBztv3LXpsKqniaYlIGFMuUp
         /SnoJsQ5b6JpQ==
Message-ID: <c1376fe541113b510ade173c8e895a1c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230929-clk-maple-si-v1-4-e26cfcaf27bd@kernel.org>
References: <20230929-clk-maple-si-v1-0-e26cfcaf27bd@kernel.org> <20230929-clk-maple-si-v1-4-e26cfcaf27bd@kernel.org>
Subject: Re: [PATCH 4/5] clk: si544: Convert to use maple tree register cache
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 09 Oct 2023 20:29:35 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Brown (2023-09-29 05:22:02)
> The maple tree register cache is based on a much more modern data structu=
re
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Applied to clk-next
