Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A0078E6F4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243663AbjHaHHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjHaHHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:07:43 -0400
Received: from mail.confident.ru (mail.confident.ru [85.114.29.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56521A3;
        Thu, 31 Aug 2023 00:07:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.confident.ru (Postfix) with ESMTP id 2D0D23FC0923;
        Thu, 31 Aug 2023 10:07:34 +0300 (MSK)
X-Virus-Scanned: amavisd-new at mail.confident.ru
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.confident.ru 96C7B3FC09A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=confident.ru;
        s=54152002-4729-11E9-BD92-62EA33CD6873; t=1693465653;
        bh=/rJyR8b26n4mvChUQUtfkBMvBmQrW1t8y4UP7Sz0/NQ=;
        h=Date:From:To:Message-ID;
        b=Mh5exTFXuDd5Z1KJdp2cgPKy+2FLC34anzpdic1xOTeIaobeeRYY/q2gwQZ7Bk0o1
         LCePzaWCDQyoaHFXqd4ovGNYukL5PRPtTh72YffvEAL1ghJEvmkQxllT6NlyHSFJMI
         DJRPMMPWqVsxG+8kdYKJ8rTIRcWjGbQ7EalWN21CyISwM1reiHjyhzgvvL/5remblm
         /LlHFLXNjjGbg8ydwNCyCtVzduMU8n/LPwMChKNLWPUIEp0no0BwvsK4XdL9nCvS4H
         +gJodaQ2kBU/Kx0V5IEoHTlnEeCdZUQZTbuh3hkSxyVCbQhTMbMZBOvsSa3ImixW7V
         1KzrTpOtguQMg==
Date:   Thu, 31 Aug 2023 10:07:33 +0300 (MSK)
From:   =?utf-8?B?0KDQsNC90LQg0JTQtdC10LE=?= <deeb.rand@confident.ru>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lvc-project@linuxtesting.org,
        =?utf-8?B?0JLQvtGB0LrRgNC10YHQtdC90YHQutC40Lkg0KHRgtCw0L3QuNGB0LvQsNCyINCY0LPQvtGA0LXQstC40Yc=?= 
        <voskresenski.stanislav@confident.ru>
Message-ID: <531722477.1139813.1693465653233.JavaMail.zimbra@confident.ru>
In-Reply-To: <4c6d01bf-1a0f-27de-54e1-4afdcf4bc8d5@lwfinger.net>
References: <20230830082759.23336-1-deeb.rand@confident.ru> <4c6d01bf-1a0f-27de-54e1-4afdcf4bc8d5@lwfinger.net>
Subject: Re: [PATCH] ssb-main: Fix division by zero in ssb_calc_clock_rate()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Thread-Topic: ssb-main: Fix division by zero in ssb_calc_clock_rate()
Thread-Index: 8V3LNCgbCW1nPh++F4l9+4bHupsy4Q==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Larry,=20

1- Yes, I agree that your solution is simpler, and I thought about it, but=
=20
I thought that the one who set the value zero put it for some reason, so I=
=20
did not want to change it.
2- It's first time to send using this mailer, but we tested it by sending=
=20
the patch to our personal emails (gmail, etc..) and it works perfectly! I=
=20
don't know why this encryption appears only when we get a response from=20
you, but we're still investigating. We will fix it, and follow all the=20
recommendations in the future.

Thanks for your cooperation.

Best regards,
Rand

----- Original Message -----
From: "Larry Finger" <Larry.Finger@lwfinger.net>
To: "Rand Deeb" <deeb.rand@confident.ru>, "Michael Buesch" <m@bues.ch>, lin=
ux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lvc-project@linuxtesting.org, "=D0=92=D0=BE=D1=81=D0=BA=D1=80=D0=B5=D1=
=81=D0=B5=D0=BD=D1=81=D0=BA=D0=B8=D0=B9 =D0=A1=D1=82=D0=B0=D0=BD=D0=B8=D1=
=81=D0=BB=D0=B0=D0=B2 =D0=98=D0=B3=D0=BE=D1=80=D0=B5=D0=B2=D0=B8=D1=87" <vo=
skresenski.stanislav@confident.ru>
Sent: Wednesday, August 30, 2023 10:50:42 PM
Subject: Re: [PATCH] ssb-main: Fix division by zero in ssb_calc_clock_rate(=
)

On 8/30/23 03:27, Rand Deeb wrote:
> In ssb_calc_clock_rate(), the value of m1 may be zero because it is
> initialized using clkfactor_f6_resolv(). This function could return
> zero, so there is a possibility of dividing by zero, we fixed it by
> checking the values before dividing.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Signed-off-by: Rand Deeb <deeb.rand@confident.ru>
> ---
>   drivers/ssb/main.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
> index 0a26984acb2c..e0776a16d04d 100644
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -903,13 +903,21 @@ u32 ssb_calc_clock_rate(u32 plltype, u32 n, u32 m)
>   =09=09case SSB_CHIPCO_CLK_MC_BYPASS:
>   =09=09=09return clock;
>   =09=09case SSB_CHIPCO_CLK_MC_M1:
> -=09=09=09return (clock / m1);
> +=09=09=09if=20
> +=09=09=09=09return (clock / m1);
> +=09=09=09break;
>   =09=09case SSB_CHIPCO_CLK_MC_M1M2:
> -=09=09=09return (clock / (m1 * m2));
> +=09=09=09if ((m1 * m2) !=3D3D 0)
> +=09=09=09=09return (clock / (m1 * m2));
> +=09=09=09break;
>   =09=09case SSB_CHIPCO_CLK_MC_M1M2M3:
> -=09=09=09return (clock / (m1 * m2 * m3));
> +=09=09=09if ((m1 * m2 * m3) !=3D3D 0)
> +=09=09=09=09return (clock / (m1 * m2 * m3));
> +=09=09=09break;
>   =09=09case SSB_CHIPCO_CLK_MC_M1M3:
> -=09=09=09return (clock / (m1 * m3));
> +=09=09=09if ((m1 * m3) !=3D3D 0)
> +=09=09=09=09return (clock / (m1 * m3));
> +=09=09=09break;
>   =09=09}
>   =09=09return 0;
>   =09case SSB_PLLTYPE_2:
> --=3D20
> 2.34.1

Rand,

I agree that clkfactor_f6_resolv() could return 0, but we have not been ove=
rrun=20
with reports of divide by zero errors, which suggests that the branch is ne=
ver=20
taken. This patch will make your tool happy and is much simpler:

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index ab080cf26c9f..b9934b9c2d70 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -837,7 +837,7 @@ static u32 clkfactor_f6_resolve(u32 v)
         case SSB_CHIPCO_CLK_F6_7:
                 return 7;
         }
-       return 0;
+       return 1;
  }

  /* Calculate the speed the backplane would run at a given set of clockcon=
trol=20
values */

Your patch has some technical problems as well. The subject should be "ssb:=
 Fix=20
division ..." In addition, note that all your if statements have an extrane=
ous=20
"3D" as in "(m1 !=3D3D 0)". To me, that indicates that your mailer is not s=
ending=20
plain text.

Larry
