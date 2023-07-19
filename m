Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE19375A165
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjGSWIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjGSWIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:08:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817981FDC;
        Wed, 19 Jul 2023 15:08:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2047A61841;
        Wed, 19 Jul 2023 22:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0CBC433C8;
        Wed, 19 Jul 2023 22:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689804523;
        bh=Q7qhiBSKFdS3iwGZGZrTqDpp+Ig1Zgkic98cWxoPI0I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TceqhCewmpe5C331IRog4jupR1LqDk7lz//CsBSh2Ixi4oEn0oqzEKXnyuSqGYfRY
         C+FsctB17WJAcj+TCM3v0Aj4IxwNAx/9vExaeSVY/n8HcSLiiL1eJlNpTIe+4B+WLM
         tIxSAzcwy9G12TdM127/Idzzb8NRsrx2EwYrz+Ej7g7m1dut3Eb7SkJnOXu2+3bb8h
         I9y7Y+pC7wNy8JVCn/RluXWo+pMnGT0qhkXPSLju6bDbobS37jkITH5BD0L44YrjR5
         AxOpne5iiLZee62F8PSdXYjErSUYqEaNcnH142OXhvF8sZOCPoIGwMf0qVdENwOt8u
         Blg3Q0i8orCnw==
Message-ID: <307a29b991d3da3fc7a83c9c31a9733a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fcd37e67fba625da304fdaf07e0ab0db@208suo.com>
References: <20230612033904.34921-1-zhanglibing@cdjrlc.com> <0dc9409b662180ed29cbc281f0f076b7@208suo.com> <fcd37e67fba625da304fdaf07e0ab0db@208suo.com>
Subject: Re: [PATCH] clk: baikal-t1: Using div64_ Ul replaces do_ Div() function
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     mturquette@baylibre.com, wuyonggang001@208suo.com
Date:   Wed, 19 Jul 2023 15:08:41 -0700
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

Quoting wuyonggang001@208suo.com (2023-06-13 22:45:48)
> Fix the following coccicheck warning:
>=20
> drivers/clk/baikal-t1/ccu-pll.c:81:1-7: WARNING: do_div() does a=20
> 64-by-32 division, please consider using div64_ul instead.
>=20
> Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
> ---

Applied to clk-next

I had to manually apply it though and I had to fix the author to match
the SoB. Please take more care next time.
