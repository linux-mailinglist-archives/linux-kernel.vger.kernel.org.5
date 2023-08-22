Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A716A784C47
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjHVVxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjHVVxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384A8CE;
        Tue, 22 Aug 2023 14:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1EAE644FC;
        Tue, 22 Aug 2023 21:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2194AC433C8;
        Tue, 22 Aug 2023 21:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692741181;
        bh=Un7HBbiIJbqJ5ghFlDstPKll75hH6cS5IipCZSoFDG0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NxwYxEwu2s65KaJPseoIUp133or9O2W9FtWZ6G4o2RM6dX5fthoxYsEEuW7A94b9X
         XxfvFv5OgfHfCgelZjdiyq+5HNV9ORxoWjp1YGztSdBe3D5P9NzF9nmfDjZuI1ppKN
         RVLI3HbVwHiJItwVHw3wKIcGHyKD+3qu1ezgFadByoZRYydWmXvGq93R4BSnurDc7E
         K6am0y3uBJPIIThG61gi7c5tLHLNz9BqLdXsPFI6DGNMoXC9aXDwr77+4fxHtq3046
         RgSBRbwu42fPK5fvQW6r/G25UbHdseb2H0xrDebQ53WNnx9BqNClKmTdYGg0R/AZou
         fQaWpU8YxNV3g==
Message-ID: <0ebe7ba5eb11176bf4122d491b043cfc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230705065313.67043-10-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com> <20230705065313.67043-10-frank.li@vivo.com>
Subject: Re: [PATCH 10/13] clk: ti: Use devm_platform_get_and_ioremap_resource()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Tero Kristo <kristo@kernel.org>, Yangtao Li <frank.li@vivo.com>
Date:   Tue, 22 Aug 2023 14:52:58 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangtao Li (2023-07-04 23:53:10)
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---

Applied to clk-next
