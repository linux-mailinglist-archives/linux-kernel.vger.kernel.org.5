Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC2E79B138
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376488AbjIKWTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242484AbjIKPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:42:01 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B554FB;
        Mon, 11 Sep 2023 08:41:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF6F6E0018;
        Mon, 11 Sep 2023 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694446915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8eGFlRAiKwz7g/fasY8Jk6HfMvuOa7JI1wixiyPB1o0=;
        b=kr2EVhvMPtWMwb5y+Kvze/QsqQazMWGPWzFvc5PrkpprxXZfVN3kthJ9G9iHjOAx3BuS6Z
        wA4IUI8fg/NmFxbGJ1cmQoXP4ReVJp+NKp3ii5ILXwKto5dFoCjC5KiQ18HfSwcTltQ7oN
        1B+sZIAQHqL9yxkPnTL2xU3gH7nFjDWNsKjNWs1q6sA1NSlKtXXTvNYxy0z1eLM5TIhZdP
        E3k8wrl6yxNiNr6zgiXmLRj7WMkm+r+00R6w0hVYKCsdat0maMi0xBkkRSIjib5oP8T8Y5
        bPQHCa/IGCq2UNjzUN3qTju1uxSdXewX/xr/KFLR3+NvRrN2WTBBg2IrA42QYg==
Date:   Mon, 11 Sep 2023 17:40:39 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc:     <mani@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_charnte@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_pkondeti@quicinc.com>
Subject: Re: [PATCH v2] mtd: nand: qcom: Fix the node for nand unmap
 resource
Message-ID: <20230911174039.63f6e835@xps-13>
In-Reply-To: <20230911133026.29868-1-quic_bibekkum@quicinc.com>
References: <20230911133026.29868-1-quic_bibekkum@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bibek,

quic_bibekkum@quicinc.com wrote on Mon, 11 Sep 2023 19:00:26 +0530:

The title prefix should be s/nand/rawnand.

The title itself is unclear "fix the node" does not mean anything to me.

> Fix addr argument to dma_unmap_resource() in the error path of probe.

      ^
No abbreviation unless you are quoting the code directly.

                    of?                            probe error path

> The addr argument should be dma address instead of physical address.
      ^                      ^                      ^
      ditto                  the?                   the?

>=20
> Fixes: 7330fc505af4 ("mtd: rawnand: qcom: stop using phys_to_dma()")
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
> v2: Incorporated comments from Pavan/Mani.
>=20
> v1: https://lore.kernel.org/all/20230907092854.11408-1-quic_bibekkum@quic=
inc.com/
>=20
>  drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qco=
m_nandc.c
> index 64499c1b3603..b079605c84d3 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -3444,7 +3444,7 @@ static int qcom_nandc_probe(struct platform_device =
*pdev)
>  err_aon_clk:
>  	clk_disable_unprepare(nandc->core_clk);
>  err_core_clk:
> -	dma_unmap_resource(dev, res->start, resource_size(res),
> +	dma_unmap_resource(dev, nandc->base_dma, resource_size(res),
>  			   DMA_BIDIRECTIONAL, 0);
>  	return ret;
>  }
> --
> 2.17.1
>=20


Thanks,
Miqu=C3=A8l
