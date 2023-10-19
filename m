Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4088E7CED73
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjJSBU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSBU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:20:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FB0112;
        Wed, 18 Oct 2023 18:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE20C433C8;
        Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697678424;
        bh=OEFMKzkQUdF2lkI84d/oCDnjWjpkF/2CWqt1c/w7l5I=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=agAqvCUC0fJ6MgF36t0nVVeo0JjmWk1vYdPA2ssuFUKM7Gt+UgXVYgSva4rh2RyOC
         bnxXbiVJDZ8XLApdewHDkCqrtgUztHXar5GeJzG4Jv8CoAFBmH8qWf5/CtiRXJxCUV
         bTYXEoMCLJUpPpL7xzWkO8579xz/b3qFxTO49nHhz4UNiMkTzal4d8yvAdZX/wB5nh
         1zjTKZNLrXEPvqamhtckXKtOrlxKZw398nnAbkXEfqsNJFd6ChHfEMdshrvHMhDtfS
         zozTJ4mt3u69iEGT5hj1dV4h/MxGy8X76t5IQlzNMI8rEpVVuRxfToKzhFDPKm/nUR
         cDNMYRpmEA5Tg==
Message-ID: <8c63372175266d42efbfca0104e19a14.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230916100515.1650336-5-andreas@kemnade.info>
References: <20230916100515.1650336-1-andreas@kemnade.info> <20230916100515.1650336-5-andreas@kemnade.info>
Subject: Re: [PATCH v4 4/5] clk: twl: add clock driver for TWL6032
From:   Stephen Boyd <sboyd@kernel.org>
To:     andreas@kemnade.info, bcousson@baylibre.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, tony@atomide.com
Date:   Wed, 18 Oct 2023 18:20:22 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andreas Kemnade (2023-09-16 03:05:14)
> The TWL6032 has some clock outputs which are controlled like
> fixed-voltage regulators, in some drivers for these chips
> found in the wild, just the regulator api is abused for controlling
> them, so simply use something similar to the regulator functions.
> Due to a lack of hardware available for testing, leave out the
> TWL6030-specific part of those functions.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Did you want me to pick this up in clk tree?

Acked-by: Stephen Boyd <sboyd@kernel.org>
