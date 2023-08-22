Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABD2784BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjHVVPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjHVVPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:15:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA75E49;
        Tue, 22 Aug 2023 14:15:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6C9E63F0D;
        Tue, 22 Aug 2023 21:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E62C433CA;
        Tue, 22 Aug 2023 21:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692738907;
        bh=0MUK94k+cTpSh3AACZ7D5ZIcfF1cL+r5L4T55Xl5DLs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BORgcrNQ3fsqYaVwiA3wVasvzT66XPSbs6GAIv/k5A9yomufF/Zpxm51I/y/dt6ib
         c7eg7ivH+xKE62PZZQo/pFFtP86bC9Tqeg4BxzWDx8xJM/Sb7qXgNJiZepzb2yQLyw
         eExz03hGNr5W35Fm+lYOxpAWca/eJCP59rYiKXWZj+vRWppum3c/Qh2wjg9MMQlH+x
         EqMbxFp3YCribsB6esUOhoukBdQCV1cOudGPR/YeHO+jTQ3tXoUU94qFSak4cFYWjA
         PAaVo/bqpT3jgL79ZqHMbbT8v805+lW77Qyg+8diZXG7fsOLMAWBH4ADHo0uP3YKYY
         /IhIqtiTgfQ+A==
Message-ID: <f2da35b66052c38b6f40bbf3b0c8dc6a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230812-mmp-nr-clks-v2-3-f9271bd7eaa5@skole.hr>
References: <20230812-mmp-nr-clks-v2-0-f9271bd7eaa5@skole.hr> <20230812-mmp-nr-clks-v2-3-f9271bd7eaa5@skole.hr>
Subject: Re: [PATCH v2 3/4] clk: pxa1928: Move number of clocks to driver source
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Duje =?utf-8?q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
To:     Conor Dooley <conor+dt@kernel.org>,
        Duje =?utf-8?q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 22 Aug 2023 14:15:05 -0700
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

Quoting Duje Mihanovi=C4=87 (2023-08-12 03:02:58)
> The number of clocks should not be in the dt binding as it is not used
> by the respective device tree and thus needlessly bloats the ABI.
>=20
> Move this number of clocks into the driver source.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---

Applied to clk-next
