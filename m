Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D2275BB4E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 01:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGTXk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 19:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjGTXk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 19:40:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B301270D;
        Thu, 20 Jul 2023 16:40:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC04A61CBA;
        Thu, 20 Jul 2023 23:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FBAC433C7;
        Thu, 20 Jul 2023 23:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689896455;
        bh=OO5Vih9U8xrxi/OOBd7+3Y3kFFY79QAH8asfMvji0rs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QbclupTp+8EQDa1lt4z07gP4AB+IATtX1fgMXCfCsacMyX88cnuv6R+3DMUXpCB+9
         +fKOj197SJEYctg9/1oiKeliNyv+2v1uYSAwmAiemXRL7yJ6V2pMmKnRB2A+OyW2Mh
         N4dvUUAmvvwAYlDRcyHx331sYHyNH5N0eVW3QOSV4w9Mzb9gHfwy22itxM9wDEqehN
         Jrpeea3oduKmNIhf3DLC0TGC5xnQK1AwxYwLAC12IGx2Uzld9A2bAN09keyaoU2eo1
         16qJFy+G7e1YonsItze2keAKzUqqcbdcyfETCcH9JmMSN8/ie3rb2HQVBWf7DE3sCO
         /lnLwhD1VrvNA==
Message-ID: <7d2d1897fdb5f4b8a1c68eaea22ed472.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230411174329.424763-1-mmyangfl@gmail.com>
References: <20230411174329.424763-1-mmyangfl@gmail.com>
Subject: Re: [PATCH v4 00/13] clk: hisilicon: Migrate devm APIs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
To:     David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Date:   Thu, 20 Jul 2023 16:40:52 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Yang (2023-04-11 10:43:09)
> Migrate devm APIs for HiSilicon clock drivers and remove redundant codes.
>=20
> This series is a partial improvement of [1]

Thanks for sticking with this. Unfortunately the patch series got
wrecked by some remove_new refactoring work. Can you rebase and resend?
