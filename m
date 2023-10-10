Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28457BF18E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442059AbjJJDci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442036AbjJJDcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:32:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFAEAF;
        Mon,  9 Oct 2023 20:32:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F58C433C8;
        Tue, 10 Oct 2023 03:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696908754;
        bh=m8xKOMH1j/BwsBc+9EB3zEiE0n0lKbtJkeGcnuhAgW8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LjvF74OFA3rzWCrLq0uf7kQgHJNxLEhy4Ct7rl0+smEB9Q688ZBAO/avQsDBaxa/O
         1Yo0Su5M0bJsjdzKm7Y89/P2PDVrQkJDgNSDmUoDYhoB4gagq4tP3vIumpfZejiTcl
         QJztiFKGHzViHXfIv5Sm2syBBbrYJO3jRbH0fgK3A9O6/UQAakm7Q/b1g+dCZW6lnb
         aOlhG69VdqzjaRYzBXZv6erXPGpRg+O5z73gkdOLeZxJgVe4sRZKZu8qkIPf+f69tP
         ZQO5SpkyZjzfYV0gvELm80L7CnClO7l0H24oQFsoIOUqDdqZSd37Vj0cuTG9Noqk1i
         o/0MQfPe+xgbw==
Message-ID: <bb3b8ad146f3900467510ad671138df0.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230929-clk-maple-versaclk-v1-1-24dd5b3d8689@kernel.org>
References: <20230929-clk-maple-versaclk-v1-0-24dd5b3d8689@kernel.org> <20230929-clk-maple-versaclk-v1-1-24dd5b3d8689@kernel.org>
Subject: Re: [PATCH 1/4] clk: versaclock3: Remove redundant _is_writeable()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
To:     Alex Helms <alexander.helms.jy@renesas.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 09 Oct 2023 20:32:32 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Brown (2023-09-29 07:26:05)
> The versaclock3 driver provides an _is_writeable() function which returns
> true for all registers. This is the default assumption for regmaps so we
> can remove the function for a very minor improvement in performance and
> code size.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Applied to clk-next
