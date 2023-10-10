Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27047BF18C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442038AbjJJDc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442022AbjJJDc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:32:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBB7B7;
        Mon,  9 Oct 2023 20:32:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9458C433C8;
        Tue, 10 Oct 2023 03:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696908743;
        bh=iIUojdZVwTW9YtBP8569vJdrA2i/kQQ00C7uBe7o2CA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CpSUNJ0aYu/XK8bVrR8JzhwPMkmXgmqeLM8YaKf3hhrqJhwPKiTHEOtKTAIfvLH95
         ZhtagFwf74GCSwk19R27GVQ8lbU/Kxv99IBauHMDfeLS5qgVYw2pOmL8jePa0cxoV/
         K40Hd8E74pcKAw0vZ08sIc45Hzr+DyYdhNxUbIntN2K/0sEanHdZrq6X9hkTbfZCl7
         U9HflImKOK/Xu1qutIRkkNnmBXNATC3v/dMxI6aZaB8/RgOTilAwFY7ZrviwNBknGz
         zAOkWoK4k76N1G8ROtoPZBmmqso4CytTAHO7AL2JAFLA5/LtOQ9N/CtOJSPhOap3Qu
         JPpBuGlnWwEAQ==
Message-ID: <7fedb64fe9fe1c8bb90b35e051a3c436.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230929-clk-maple-versaclk-v1-2-24dd5b3d8689@kernel.org>
References: <20230929-clk-maple-versaclk-v1-0-24dd5b3d8689@kernel.org> <20230929-clk-maple-versaclk-v1-2-24dd5b3d8689@kernel.org>
Subject: Re: [PATCH 2/4] clk: versaclock3: Convert to use maple tree register cache
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
To:     Alex Helms <alexander.helms.jy@renesas.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 09 Oct 2023 20:32:20 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Brown (2023-09-29 07:26:06)
> The maple tree register cache is based on a much more modern data structu=
re
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Applied to clk-next
