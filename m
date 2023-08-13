Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC0E77AE26
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 00:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjHMWIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 18:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjHMWIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 18:08:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEC81BEE;
        Sun, 13 Aug 2023 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1691963935; x=1692568735; i=j.neuschaefer@gmx.net;
 bh=MyejiVwol60hEEL/Sj0XYSSEOB2BnWEX72RuhsubBVY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OmhGlZT9kO3NG/691pb8CwWsqQTA44ICNq4nXhekqaZF1KZG0ToWGeO5Y1VNSJ+Yz1yzN0n
 JFRX5Nz6j0zFg3W/0VR23KsmQ8puZJhxewZsfMjj1anSpXTyzzNfvmjwiAbKq6OcrBwBQ1KFK
 iZUadvzEZ2jD2Q1xFieaKD4jqHx45eEh+La7+705XTNqGuu7yLEy5EEZIqlDalY6XG3uYCezk
 FPnjCcrdv5j6es60G1dZK1nSLEXKBZE+DOU817l919J/3CZFoUOElImSDAw5y3FckHE0Gat6a
 IExS25gGPgzqBhF9jaXtt2GfjvBbUahckyR3gs3SHC2hL7NXvRFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([151.216.152.144]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6sn7-1piBSy2B7n-018MQM; Sun, 13
 Aug 2023 23:58:55 +0200
Date:   Sun, 13 Aug 2023 23:58:55 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Tao Lan <taolan@huawei.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, j.neuschaefer@gmx.net,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: fix memory leak in hisi_clk_init.
Message-ID: <ZNlSH+eWV8Sk3FYn@probook>
References: <20221222091221.28308-1-taolan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a6iDqMC9Rx98SozQ"
Content-Disposition: inline
In-Reply-To: <20221222091221.28308-1-taolan@huawei.com>
X-Provags-ID: V03:K1:zL8f0oHy0YLXJqtaYZ0ppZSPXqYJcTdo8zSUSRRTo22kCS1sL6y
 tF6gBs81yiE1A9agmP550Lx+s57p1fox6sEmVF0A9MAP8v4p3J+WnX+xBe6Rv/s4Y+civIj
 gxu5UFH4FnEhh29cqvS2xTqFJFNBqg6wjarZ/UwJ9ZtcBEYvKyUqXzTG5tjo4z49C3sz1Cn
 2LSN8njeeOh63Gpocp0vw==
UI-OutboundReport: notjunk:1;M01:P0:m72hZOWJZfo=;75TnQhajGaIKcxvkM/83FTS2SKE
 DJupgVeAaRnsEY7sxEvtPVl98PzLtejdMJkY1EweVd6ITB0ViGwhXbpjD3YFTxr7DBjJdlMom
 9jdj4sUFl3loIUbZObNclniDb0ReOdGGxl8wr6U74Vjo6O8ybvLG8acJrt/vuJc+/m2qWIJF5
 y4+cE7oHDkasxZf75YO6ottNKuXQodzEUokbX4PQfRBXsOBsRH6AR9CGNyU5TeHa8Ixf1+xVp
 u3NWwVUVE4OlnoQ3Si/ULgm0Vrourb1oAYLHwtnbO+6q/Js+mEg5na32K28/LzPW48sIdRmBP
 gync/57WsYl5pBEdILZ/XWDudhXntcL5Pg5H3CmaBeduGITPwiRpPf6d1mX2V+lDsjSzdRks/
 WUIJtrCYQ6YFbGCZAqtC3RIbsPm0rSJJnGbF/juTD8drZG5bYXEVGFS2nkWb8xZW6AueBHOB2
 B+tWadBaEEwKpHRf+XdGGr9deqwJa2lZrGAxr3MU673Df2aCB6qWXTXytsXuvvvggwMMv5h4Q
 5iaGw35cp7ojBJJKZ884YxvaMJtriTmYPGa477apHLtynoPaHaq3lAHLDElXuxkmS19GUr30Q
 BVXLF4M3RIr3/zkmcRX3ntZvkPutvc/2uWg9CGxVL9RwwvvPT/9u7Axziim4FanGakSuyi+eS
 dWFeyNxJRr/YWuGkPw89NmNTom8vGkGlR0q93l8Tbu1Wa38LKwobUf7BD612+t5zVLOGl9njO
 fjXOKLnhXBg90wYLBLk8TBV/v+TZ6V4nz4UzAFU6rNVO8GvTgum+aQCfsY6IjJPhtFYmycfaj
 gXm1z42SQpBV/pc2PyBJh6EBT5jE60qnYLeG9sQQ8qdEJwc4Fc5hcjG0O7MgGl/KuAvrYFhcP
 F1Os3DbJSxiUUq+3MtY8/kJ5qIO80OV/DtmF/xiOVNPsQFzMHo4Wewprvn73+KeEwoThU7UDy
 x+I5CO0gMNgeG5ff1yZEaELEekM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a6iDqMC9Rx98SozQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

sorry for the delay, but I found this unmerged patch while cleaning up
my mailbox.

On Thu, Dec 22, 2022 at 09:12:21AM +0000, Tao Lan wrote:
> From: taolan <taolan@huawei.com>
>=20
> when clk_data create fail, we also need to release base.
>=20
> Signed-off-by: taolan <taolan@huawei.com>
> ---
>  drivers/clk/hisilicon/clk.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
> index 54d9fdc93599..9ca4fc05fa57 100644
> --- a/drivers/clk/hisilicon/clk.c
> +++ b/drivers/clk/hisilicon/clk.c
> @@ -82,6 +82,10 @@ struct hisi_clock_data *hisi_clk_init(struct device_no=
de *np,
>  	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data->clk_data);
>  	return clk_data;
>  err_data:
> +	if (base) {
> +		iounmap(base);
> +		base =3D NULL;
> +	}

This is inaccurate. Consider the case when kzalloc fails:

	clk_data =3D kzalloc(sizeof(*clk_data), GFP_KERNEL);
	if (!clk_data)
		goto err;

base has already been mapped, but the code jumps to 'err', which doesn't
have the iounmap.

To address this properly, you'd have to add another label between
err_data and err.


>  	kfree(clk_data);
>  err:
>  	return NULL;


Best regards,
jn

--a6iDqMC9Rx98SozQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmTZUfwACgkQCDBEmo7z
X9v5KBAArTSZfCeWFE+wvW+7H3bcqhQzz1HuFXIcWRP/7l4QxZfSrTseScsxx1tt
65fD9mDm9etWw8lnuwHXpwx4KVkZf09eWh+H6LEGcm1x4BfcozFmeBiVySUJ81cO
/UddTJBlXKYLI8wbIiVfIwDzLCGurJkSHNDJBrkgk/U/eV78AethhfP20qkGNChH
Z1TF/4Xc64gcBC1SKHrCALNlB+ICTtQCwehR2DFbmjBtY3FREda3g5Z+xfjENVnN
0dweiJ8ksBEfmAWFevogpDdcJkA+5XqUu9klH7svnm4k45LFJj6KVNQIotxGQJs5
OhfFJ708uzuzNaRlb/GL8dUBQkH/zhS+9+lNn+jKcKgY6yKl9YrtZeOUG2u9ZMjJ
8hPN/2FgpAkaY5pqCyOgDvcxOHyYmM2Vdyg0n79C7HRWqpRCPKezcemsQRMyqq+4
Nlt12FqDMe4z8VDXGqE8gK8UhTZsGBrx+6niH/TYcWZrWZ4CG3Frz6SSOP/NF62r
8h6quL5SbROq+fHpB2sXKj5k9HilQOhJSHvY+X9NB2F62PImXvMX7GGZKnRcAZXw
1CB7aAMPUeqvNozcfO4iLABGpbIuumKTO/pgZ6B00QYExDcxTkDgao0bVZnjUber
KgnGBrmdUv5gb3gYkchGVOST2dHygO1b3DxywiD+bYulbgJMP+4=
=h3d+
-----END PGP SIGNATURE-----

--a6iDqMC9Rx98SozQ--
