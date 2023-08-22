Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25303784BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjHVVOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHVVOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:14:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B65DCD5;
        Tue, 22 Aug 2023 14:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 197FF634E2;
        Tue, 22 Aug 2023 21:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69561C433C7;
        Tue, 22 Aug 2023 21:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692738879;
        bh=SPp1M0vHZgQWOwHmNtx6gdbtHubBTU74HyDjyjXehKo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jCPpW6GTFUHktg0LNOrTOeONo2ycd7Jevp2S0xMVkM62FGTp14eNu0B/wtOvuQRfX
         UVDdRPrtzBHBdmbpjJ9Il1SP44sNdGq5+PKhmMUfchW9g7ULrbTJIbOLzs84x3wEVD
         WQyc0zJnCNfEcLnpAXl3Pwwyn9Tlx7q77eNTCNh9pxvaFzgntoCUoiHD0P8ih604j+
         Nu3+Zgaub36WxBsXtu8pLafPp5uYy2l0KKyc4ojc5AerBPwZ6DpndJmVR2afrHt+8Z
         xMlaUuZ64H+1Rk922yH9QYo0jSjv7wToo8/FaeR8UzyP5x/YX6qWo1QWJUCPK0JE4k
         2zSNV/wxIprxg==
Message-ID: <c7e413675d10671d763780ad0a441acb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230812-mmp-nr-clks-v2-1-f9271bd7eaa5@skole.hr>
References: <20230812-mmp-nr-clks-v2-0-f9271bd7eaa5@skole.hr> <20230812-mmp-nr-clks-v2-1-f9271bd7eaa5@skole.hr>
Subject: Re: [PATCH v2 1/4] clk: mmp2: Move number of clocks to driver source
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Duje =?utf-8?q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
To:     Conor Dooley <conor+dt@kernel.org>,
        Duje =?utf-8?q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 22 Aug 2023 14:14:37 -0700
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

Quoting Duje Mihanovi=C4=87 (2023-08-12 03:02:56)
> The number of clocks should not be in the dt binding as it is not used
> by the respective device tree and thus needlessly bloats the ABI.
>=20
> Move this number of clocks into the driver source.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---

Applied to clk-next
