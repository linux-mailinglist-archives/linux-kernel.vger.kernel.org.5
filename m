Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B4C76BD75
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjHATNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjHATNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:13:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8678E18B;
        Tue,  1 Aug 2023 12:13:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B767616A2;
        Tue,  1 Aug 2023 19:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77973C433C7;
        Tue,  1 Aug 2023 19:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690917182;
        bh=6e28umF2u1i8SSVJpPICenCM4Gk45G15e24p4wmMd28=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=X0Wqg142Z/A+UZs7FqgB96XiymHIDPtplqvE41l78WI+yhx1K8vxVTgjaHAZj1hBl
         DMW1nmOUoT3V1Mz23v1lgc4QCGAiGEGy+pLFarBZd7f/cu26mmd9Fq7ecFcCRHE6GN
         VT9JpEu2mGZoygIaeMafWH2EtSiF1f+W39Q4tAKruXSXt07GfR9NGLu/CHwzPtIZBC
         mCjD/dlkNtcNvVDw7AWO9ZoMikvR6cH9MHJPosGvuUC/HDW2uuUESL2eFwzziyByh4
         YiuRYmegRQE5PBMGUKP21bwnAnZfoHo9Q3CUbx76LPI7SJctZsshj+jkZQcnfLmSjg
         AWf+VvN4sJuUg==
Message-ID: <e0acf791831bcfed56d56c97f6867a89.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230730163928.70637-1-martin@kaiser.cx>
References: <20220602080344.208702-1-martin@kaiser.cx> <20230730163928.70637-1-martin@kaiser.cx>
Subject: Re: [PATCH v6 0/2] ARM: imx25: print silicon revision at startup
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
To:     Abel Vesa <abelvesa@kernel.org>, Martin Kaiser <martin@kaiser.cx>
Date:   Tue, 01 Aug 2023 12:13:00 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Kaiser (2023-07-30 09:39:26)
> Resurrect the unused function to print the imx25 silicon revision at
> startup.
>=20
> This patch set is blocking Arnd's work on enabling -Werror=3Dmissing-prot=
otypes.
>=20
> I'd really appreciate a response from the clk maintainers if these (trivi=
al)
> patches are ok.

You need to Cc linux-imx@nxp.com on imx clk patches. I think Abel has
some filter that looks for linux-clk@vger and linux-imx.

Also, please don't send series replies to previous rounds. It buries the
patches deep in my MUA and my scripts don't work well to apply patches
when they're sent like that.

I presume that Abel will pick the patches up? Or do you want to land
them through Arnd's tree? Either way feel free to add my acked-by

Acked-by: Stephen Boyd <sboyd@kernel.org>
