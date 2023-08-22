Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4575E784C42
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjHVVwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjHVVwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:52:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED0DCEB;
        Tue, 22 Aug 2023 14:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7119363B9F;
        Tue, 22 Aug 2023 21:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7449C433C8;
        Tue, 22 Aug 2023 21:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692741121;
        bh=q/E8Jdc7YDjCQYsLGf4JEUHgk+lZecIuRPZ+xd1cQkw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pfm+ehBrUOQ0bXAKB5lAB2/2vvTd3Aoen0MHxClRlwY/9/XCl+VHo3Szae0iwYfS1
         /yVTy6VJE2/Nygi7C5iKcqa8RDZOxV/2YaIzgY9lIpnKFvzQm7JyOufxTd2WO5CR/v
         QD7smUclydWy5IvAnarQGkfmyJigXBgJoGCkj2eVPoFkHF+4z++NgAI/JbVd8AIbv4
         DjavJZwAdACA5GdHZWeS6fJCIM5mgfJ7uQ9LunVfUyyukMW+M7b2H+w79GtCl6Orjo
         aoxPxnR1NBbaW/e2s2dsMW5SPmK5Jjwhnll0IvCRN50jkV8q+ztNnxDxG/FJ/DluR8
         ux1eMEhY5L6uA==
Message-ID: <2b9eea68d6611cbb83f66d16cb02fe7d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230705065313.67043-12-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com> <20230705065313.67043-12-frank.li@vivo.com>
Subject: Re: [PATCH 12/13] clk: nuvoton: Convert to devm_platform_ioremap_resource()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Jacky Huang <ychuang3@nuvoton.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Shan-Chun Hung <schung@nuvoton.com>,
        Yangtao Li <frank.li@vivo.com>
Date:   Tue, 22 Aug 2023 14:51:59 -0700
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

Quoting Yangtao Li (2023-07-04 23:53:12)
> Use devm_platform_ioremap_resource() to simplify code.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---

Applied to clk-next
