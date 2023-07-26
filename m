Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED08763F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjGZTQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjGZTQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:16:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A81C1FF0;
        Wed, 26 Jul 2023 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690398994; x=1691003794; i=linosanfilippo@gmx.de;
 bh=XtJKEwl+cc1nQ+vurQl0d32oGbJP4QDV2yIvd7ZPqs0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dplnZJIMnrIdh/gSEjhvNBNQsMptt4qN/OUF01q78qsYA0rW46BE/bLHokop0YWnVbjiPox
 /XbRc1OZvJa4zZseDk0M4YHwD6jg47/zXs5rqQ0znSYx67LMh63d2ftK6o+zK7fNPQFoEON2X
 YEdi9UlontscDa6heAa8E8/j4S3dLLWUzHI8r+oSfYroQNdiAVq09NCaw9nO9a1YY2PawCuMd
 KOE6DqUT6PYS6w/zVbvY5Jiwf+a/fVFn70y8zHEOnMtlfuPkCwfWatLoSTRV9+VPIqzaIUAWx
 oqKERFQWozTWA1tLK84m1/AB5gygPSymjVuv0pIUDT+L0RcYBuGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.62] ([113.53.91.195]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGz1f-1qcAGf1ZqN-00E2LQ; Wed, 26
 Jul 2023 21:16:34 +0200
Message-ID: <3f88771d-17df-fcf8-ef25-8813c6c754a9@gmx.de>
Date:   Wed, 26 Jul 2023 21:16:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH][next] net: ethernet: slicoss: remove redundant increment
 of pointer data
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726164522.369206-1-colin.i.king@gmail.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <20230726164522.369206-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AoC8OX8jnUVP4YKYXasQs7JkiMpGUGOGDMbE1u8ZVDQoJOJ17Bn
 ilfbkpeYu+t3/Ck2FlxgjGaA0SiLOTLMD6TTGB/hShJUyEMUtJ7GAcmXOCOkd0rGxOcbb88
 kcuOYYeyH2e8jcTgkn9Q5GJSu9P0U0Oruc+Nnq3XJkVFHlqkJOShhRgei3jTE8r2dUb+0q9
 DAMgW5ugcqeOJUVKc7dpQ==
UI-OutboundReport: notjunk:1;M01:P0:UOCVVL4dRLQ=;bNlu7v9O1dj5KH4akcoWPoKAb3+
 gletTswkxhLgWgesVvdtVauYQiRsHwnsDU4VDxLLdHKD8KoFiG9a83xs/6tt5H7F1D6WrMAYZ
 jvwqEdgdObMClNvlwO+5If/XuQg3Pyn1Iuv0LBZNO/C2oThIb4vNSQaOJ3cxeXvb2+AQagaYo
 LyBMq/E703ohR3uldFVmmq59M+RkwtDmPYWSZELZxebiMGIawj8tBqoIiDXp1PG+jtcgxXI/J
 vJoMzVXYU780i9etmHoy56G2SN7ijdsQtyQ/jWYnhiWGRpV+P/y5cT63Z6Y3BCSu3I/tLP5L2
 6UVGAkzJijF2MdEnp7oMwWiYOeTmFl1gt+4YElzIBSkAzLr/T/4jTAGj0lVbsBQFFJ+TWi7Pp
 3r0qlD5PoSFmwhpzr+6jPIL1SLvlUGmAP7bZJsWq7fnmbg/d9DEo1scsd05Re8wcIEgxnZ/Dl
 xxNT2pMfCds5eU6oIkdfrxZibHks5f70rCQ4vP/Ngxb7GN91z5mzDSZHBHnyFbkyWWUR2u/bq
 6CoAmTk6VIBaKRhq0V9fJM6yXOFXcN4qtkiWkAIXJ9elJMpihdEOXSZD/MYHU7Y52rnhzJ15+
 cII4uuM5MjgneY2y4ifx3VDj4PTBUFcLm8UYJJLcRd37bN7iBesgpiuBeGgRs8b7fn/vmb0VF
 ROyv55KCW5Zmrr+go3ztNpWCTvWyYCyILPu/OmJOItXSdBa/7Zt3TA2S2ebpn3PzjCMkDU/Ya
 ByLcXO22n3F2jW7RJMy8TrqCzHqm4Z6zShpFyk87VymoLXxdS5DWfddA3BBxF5SrLlftf8Wx/
 eogtdhxk2goeDuDMlkQ7aNOdditbxAIrfNRitoTPe9wzM4gUPnvWTDbvmIak4Vi/Xrw+v6YDU
 0+8rSacfVgEmCiCDGBVG6DS3znyhrg+AzeI3kgYjuNPppnA3Umfsf3GwdtkjIfgCJAyMOTB4L
 E+QgEXdQ2MQh3q15of04ps6cyR8=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26.07.23 18:45, Colin Ian King wrote:
> The pointer data is being incremented but this change to the pointer
> is not used afterwards. The increment is redundant and can be removed.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/alacritech/slicoss.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/alacritech/slicoss.c b/drivers/net/eth=
ernet/alacritech/slicoss.c
> index a30d0f172986..78231c85234d 100644
> --- a/drivers/net/ethernet/alacritech/slicoss.c
> +++ b/drivers/net/ethernet/alacritech/slicoss.c
> @@ -1520,10 +1520,8 @@ static void slic_get_ethtool_stats(struct net_dev=
ice *dev,
>
>  static void slic_get_strings(struct net_device *dev, u32 stringset, u8 =
*data)
>  {
> -	if (stringset =3D=3D ETH_SS_STATS) {
> +	if (stringset =3D=3D ETH_SS_STATS)
>  		memcpy(data, slic_stats_strings, sizeof(slic_stats_strings));
> -		data +=3D sizeof(slic_stats_strings);
> -	}
>  }
>
>  static void slic_get_drvinfo(struct net_device *dev,

FWIW
Acked-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>

Best Regards,
Lino
