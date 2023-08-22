Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309B4784BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjHVVPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHVVPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:15:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49ACCE2;
        Tue, 22 Aug 2023 14:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4332063D2E;
        Tue, 22 Aug 2023 21:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BA1C433C8;
        Tue, 22 Aug 2023 21:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692738897;
        bh=K6pJHppdKklQ3rQ4cf2Xv9YHa2wO4so9Jg5yzN39o/A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kNwWqnBmgRsbe1avEgYlVDtYVjzNJgc4USQJYfX2CGWtsSqFZY3KKWmp+jgClAkjn
         gw6D3X7eDuzhduGH3vm+VsqwLC7K62elO/wft4lrTPVPyYRnenrgczLvW0vpkKkEZ4
         TLdnd1yRkgRKw4SmZ4/7bymIw+VVGgH/eLW2KIfdtjidlo55R3KXWu8DgCEpEzi4f4
         AmwaC2c9gTtGwMUjYEQNSXgq7nOsJmiDYtyEhlBhhE7vAWLRtELa4KoOpqj2wUXiio
         DH3GmFAMvNDkZjwvPqFMfh0GPoxp+1ILUbmJlGzug1lrDIneVV52OzfJCB7KkVLJvi
         ZcLKZh+PwqH9g==
Message-ID: <481eef17d430c09dfc85f3663be2c7ac.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230812-mmp-nr-clks-v2-2-f9271bd7eaa5@skole.hr>
References: <20230812-mmp-nr-clks-v2-0-f9271bd7eaa5@skole.hr> <20230812-mmp-nr-clks-v2-2-f9271bd7eaa5@skole.hr>
Subject: Re: [PATCH v2 2/4] clk: pxa168: Move number of clocks to driver source
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Duje =?utf-8?q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
To:     Conor Dooley <conor+dt@kernel.org>,
        Duje =?utf-8?q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 22 Aug 2023 14:14:55 -0700
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

Quoting Duje Mihanovi=C4=87 (2023-08-12 03:02:57)
> The number of clocks should not be in the dt binding as it is not used
> by the respective device tree and thus needlessly bloats the ABI.
>=20
> Move this number of clocks into the driver source.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---

Applied to clk-next
