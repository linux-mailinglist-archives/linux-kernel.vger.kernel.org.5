Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EF4782473
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjHUH3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjHUH33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:29:29 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AB8B5;
        Mon, 21 Aug 2023 00:29:26 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D063E1C0005;
        Mon, 21 Aug 2023 07:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692602964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VB0zz0K+Kec15Zr+s4clFuGZtwWuG8rXdL+bGDFcguA=;
        b=aHkuW+sKsyf1aKqa6GIJT2MRUoDZ+MJUvnVTvgwtz74Cr+OXRvyD6L5F6lni5BksaRmE6x
        enxAhCul+Co32CuTqnyt5oqEnL1JtDNWbYxpR52uB74RjxUtQ9mpYgZpwxXGU6hYivIVM2
        Z+Va8W29a8jdJeq+L55tZuk5OvWrfp/sl2il1gYML1FC5SLyiF+52m3P6rXYeL+LeTiTe0
        7XU9iWcfswS2GiXj45Ke6RwvpwJr0gwgnxDF6V4ajR6e/S6KfABOClQH/I7YboYau7A7EW
        HmVhHCdJOYyKM6vyAZ8XU7qFIMBN4tHQY5lGysZ+JuK91MiGmt8F2E95vlVVGQ==
Date:   Mon, 21 Aug 2023 09:29:23 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     mani@kernel.org, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH] mtd: rawnand: qcom: Fix build issue
Message-ID: <20230821092923.7043c90f@xps-13>
In-Reply-To: <20230821053513.13728-1-quic_mdalam@quicinc.com>
References: <20230821053513.13728-1-quic_mdalam@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

quic_mdalam@quicinc.com wrote on Mon, 21 Aug 2023 11:05:13 +0530:

> Fix the build issue, after removing unused variable nandc
> in qcom_parse_instructions() function.
>=20
> Fixes: 0bb2bd18efe8 ("mtd: rawnand: qcom: Add read/read_start ops in exec=
_op path")

I will squash this fix.

> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qco=
m_nandc.c
> index 370a779610e2..6aff45f32260 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -2593,7 +2593,6 @@ static int qcom_parse_instructions(struct nand_chip=
 *chip,
>  				    const struct nand_subop *subop,
>  				    struct qcom_op *q_op)
>  {
> -	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
>  	const struct nand_op_instr *instr =3D NULL;
>  	unsigned int op_id;
>  	int i, ret;


Thanks,
Miqu=C3=A8l
