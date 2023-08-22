Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CABD784C51
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjHVVyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjHVVyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:54:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B01E45;
        Tue, 22 Aug 2023 14:54:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDD7364597;
        Tue, 22 Aug 2023 21:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B0FC433C8;
        Tue, 22 Aug 2023 21:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692741253;
        bh=Sr982m0BwMXiOIL1/muQ+GsuQmATJHz2sa4eTfPXaFY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=igUP6W0FlpotNSmUjCB5urSYheVA/ddPGdsVSlQwx7XJRqaukuYkzDGhHWCbnkkwJ
         vhsV3Dp08erF0eIz9wtC6N0t3/X4JsW4nyIF+zlkCXOABOg5Oj+9pXlkUAgBJRJSP5
         v3vCNQ0mbs1mKhHDsP2TeG3XTP/7dsiYnS7/IV1kSp1jaDrqlvN+Ub5b2uEqSIcvLl
         HjEnIXP3arQKcnxOVFjA2UDGJVhK1SOUuARDrqyXwWmS4aFdCcAWwfskOidWeQ6/2O
         AmQdEjlPto2OT2hXozfcMFEIJceB+OPq71r/pJ1req5T6mc/ZfH/iwFaGoGcpC9Wpb
         +AgPr9o7wxw9g==
Message-ID: <7cee809d19f8e7ad505fe78d59f0e61b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230705065313.67043-4-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com> <20230705065313.67043-4-frank.li@vivo.com>
Subject: Re: [PATCH 04/13] clk: bm1880: Convert to devm_platform_ioremap_resource()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Yangtao Li <frank.li@vivo.com>
Date:   Tue, 22 Aug 2023 14:54:10 -0700
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

Quoting Yangtao Li (2023-07-04 23:53:04)
> Use devm_platform_ioremap_resource() to simplify code.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---

Applied to clk-next
