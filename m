Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEE6751B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjGMIbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbjGMIa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:30:27 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BEB1BFA;
        Thu, 13 Jul 2023 01:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1689236444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UOOBqUgvHuPo6oWCliTlkcsf1P60C5K6cRYNo3O2Cy0=;
        b=T6OSn0Rmxqmn8IAK1KKPdZovLHXxMCyyctONW5Yz10JH91m9+bYeynjk+9i23HFvXBCwEk
        qk59KHO6lU+C23LmKmDog1/9tsFgnGWV2Min5EN/Vg1L7zMYUXCFHOJO0lUxNdLJFNK2Sa
        Cd2Wsr57KYkZBTaQIWXSwQnRumNugx0=
Message-ID: <ac10f71996d363b8298c9cded7fda5a98675b5ec.camel@crapouillou.net>
Subject: Re: [PATCH 03/58] mmc: jz4740: Convert to platform remove callback
 returning void
From:   Paul Cercueil <paul@crapouillou.net>
To:     Yangtao Li <frank.li@vivo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Jul 2023 10:20:42 +0200
In-Reply-To: <20230713080807.69999-3-frank.li@vivo.com>
References: <20230713080807.69999-1-frank.li@vivo.com>
         <20230713080807.69999-3-frank.li@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeudi 13 juillet 2023 =C3=A0 16:07 +0800, Yangtao Li a =C3=A9crit=C2=A0:
> The .remove() callback for a platform driver returns an int which
> makes
> many driver authors wrongly assume it's possible to do error handling
> by
> returning an error code. However the value returned is (mostly)
> ignored
> and this typically results in resource leaks. To improve here there
> is a
> quest to make the remove callback return void. In the first step of
> this
> quest all drivers are converted to .remove_new() which already
> returns
> void.
>=20
> Trivially convert this driver from always returning zero in the
> remove
> callback to the void returning variant.
>=20
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> =C2=A0drivers/mmc/host/jz4740_mmc.c | 6 ++----
> =C2=A01 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/jz4740_mmc.c
> b/drivers/mmc/host/jz4740_mmc.c
> index 1846a05210e3..f379ce5b582d 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -1163,7 +1163,7 @@ static int jz4740_mmc_probe(struct
> platform_device* pdev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> =C2=A0}
> =C2=A0
> -static int jz4740_mmc_remove(struct platform_device *pdev)
> +static void jz4740_mmc_remove(struct platform_device *pdev)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct jz4740_mmc_host *h=
ost =3D platform_get_drvdata(pdev);
> =C2=A0
> @@ -1179,8 +1179,6 @@ static int jz4740_mmc_remove(struct
> platform_device *pdev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0jz4740_mmc_release_dma_channels(host);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mmc_free_host(host->mmc);
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static int jz4740_mmc_suspend(struct device *dev)
> @@ -1198,7 +1196,7 @@ static
> DEFINE_SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
> =C2=A0
> =C2=A0static struct platform_driver jz4740_mmc_driver =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe =3D jz4740_mmc_pro=
be,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.remove =3D jz4740_mmc_remove,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.remove_new =3D jz4740_mmc_rem=
ove,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.driver =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "jz4740-mmc",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,

