Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273A378EF8A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbjHaOZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjHaOZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:25:27 -0400
Received: from mail.confident.ru (mail.confident.ru [85.114.29.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5CECF;
        Thu, 31 Aug 2023 07:25:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.confident.ru (Postfix) with ESMTP id 1F2FC3FC11FA;
        Thu, 31 Aug 2023 17:25:19 +0300 (MSK)
X-Virus-Scanned: amavisd-new at mail.confident.ru
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.confident.ru CF2623FC1229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=confident.ru;
        s=54152002-4729-11E9-BD92-62EA33CD6873; t=1693491918;
        bh=byOPYdxPcvNp2QIzjeg02VM5kg3iF7RgVc2ncBv29xE=;
        h=Date:From:To:Message-ID;
        b=UV3p8BG8YLvf3RuU0wyMYGZ08GpAXcYl6oEDpWM3AalQ4X5aZMw/0K7nWEjj+avNV
         IzwEBlua6JaTk09O+pj2ODFMVzlJk9AEwYOrBoxkO6vltV4soD/h3l5lg9zA1jsdip
         g0k8PF9uzzmKEDNrbm+hB4+ibojNdZHDV6nx/i1f+vSgSzqSWzZx6BoKrT2BBYq8IL
         wNhwrovOye1Tt45RIHqQpDLh7hfuW3emEklrWtM3XahdB+L/0I8tcFfeAA04/4r4Gu
         ta0Wkrl3x9PadjugzwuawBckaQiimSUk1XHSUUpnbt3fkWymHhecxNYIRYm8TtKUDI
         TNW8IN1Rd8+Qw==
Date:   Thu, 31 Aug 2023 17:25:18 +0300 (MSK)
From:   =?utf-8?B?0KDQsNC90LQg0JTQtdC10LE=?= <deeb.rand@confident.ru>
To:     Krzysztof Kozlowski <krzk@kernel.org>, Michael Buesch <m@bues.ch>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     lvc-project <lvc-project@linuxtesting.org>,
        =?utf-8?B?0JLQvtGB0LrRgNC10YHQtdC90YHQutC40Lkg0KHRgtCw0L3QuNGB0LvQsNCyINCY0LPQvtGA0LXQstC40Yc=?= 
        <voskresenski.stanislav@confident.ru>
Message-ID: <763366419.1280837.1693491918477.JavaMail.zimbra@confident.ru>
In-Reply-To: <ac040329-25a9-121b-b2b4-843b6a8d2a29@kernel.org>
References: <20230830082759.23336-1-deeb.rand@confident.ru> <ac040329-25a9-121b-b2b4-843b6a8d2a29@kernel.org>
Subject: Re: [PATCH] ssb-main: Fix division by zero in ssb_calc_clock_rate()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Thread-Topic: ssb-main: Fix division by zero in ssb_calc_clock_rate()
Thread-Index: 3oX7rNxnF1lDTiTKvuHauk/peINrWw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,

Thank you for your response, now I see, but we already used the standard=20
tool git send-email to send the patch. It seems we have to set the=20
transfer-encoding manually (not default), we will fix it next time.
It's our first time trying to send a patch.

Best Regards,
Rand

----- Original Message -----
From: "Krzysztof Kozlowski" <krzk@kernel.org>
To: "Rand Deeb" <deeb.rand@confident.ru>, "Michael Buesch" <m@bues.ch>, "li=
nux-wireless" <linux-wireless@vger.kernel.org>, "linux-kernel" <linux-kerne=
l@vger.kernel.org>
Cc: "lvc-project" <lvc-project@linuxtesting.org>, "=D0=92=D0=BE=D1=81=D0=BA=
=D1=80=D0=B5=D1=81=D0=B5=D0=BD=D1=81=D0=BA=D0=B8=D0=B9 =D0=A1=D1=82=D0=B0=
=D0=BD=D0=B8=D1=81=D0=BB=D0=B0=D0=B2 =D0=98=D0=B3=D0=BE=D1=80=D0=B5=D0=B2=
=D0=B8=D1=87" <voskresenski.stanislav@confident.ru>
Sent: Thursday, August 31, 2023 4:45:15 PM
Subject: Re: [PATCH] ssb-main: Fix division by zero in ssb_calc_clock_rate(=
)

On 30/08/2023 10:27, Rand Deeb wrote:
> In ssb_calc_clock_rate(), the value of m1 may be zero because it is
> initialized using clkfactor_f6_resolv(). This function could return
> zero, so there is a possibility of dividing by zero, we fixed it by
> checking the values before dividing.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Version your patches and provide changelog after --- .

>=20
> Signed-off-by: Rand Deeb <deeb.rand@confident.ru>
> ---
>  drivers/ssb/main.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
> index 0a26984acb2c..e0776a16d04d 100644
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -903,13 +903,21 @@ u32 ssb_calc_clock_rate(u32 plltype, u32 n, u32 m)
>  =09=09case SSB_CHIPCO_CLK_MC_BYPASS:
>  =09=09=09return clock;
>  =09=09case SSB_CHIPCO_CLK_MC_M1:
> -=09=09=09return (clock / m1);
> +=09=09=09if (m1 !=3D3D 0)

Nothing improved here.

Don't send patches as quoted-printable via some weird mailers.
Recommendation is to use standard tool - git send-email.

As you can easily see on the web - it is re-formatted for quoted-printable:

https://lore.kernel.org/all/20230830082759.23336-1-deeb.rand@confident.ru/r=
aw

Best regards,
Krzysztof
