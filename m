Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A45757D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjGRNZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjGRNZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:25:06 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0D2137;
        Tue, 18 Jul 2023 06:25:02 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b708e49059so88957461fa.3;
        Tue, 18 Jul 2023 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689686701; x=1692278701;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kji3NHZ/u0WcOPGwQMfakUnOBLU6uV+khPNtxxTA/2E=;
        b=sY+NPODTv4711TolEVIr05g9scK/6qu/UxpFs+pA8h/ciggmOSv2JCqIqZCr2TN6RU
         hD+lnNxNhcHYvOPhNR3O93uZt2JsOr5HYok29qBXst/k8K9BonshRMmA0zmSqvedAPyu
         1l+2hpPbUOUOUUW9jgkkudPGuAmS7w8w+ToSFWK9TIMNOJ7GBdjvqP3WMwbA3IL7S9cU
         KZaJ4pCLvM9TsO9jKPYSdre0T3ZJDu5Fsv6fk25YMwAyciXZxYfIoegiwI2SWwD9fwjp
         NRbgCyI25oOOcXTmKP1WHF5Bvlh1yTd2k6vg4HNDUf29sSLBUFs/6hssie4shJRb2pfL
         fliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689686701; x=1692278701;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kji3NHZ/u0WcOPGwQMfakUnOBLU6uV+khPNtxxTA/2E=;
        b=Km7xU2RFv1aXVTRRWVb80D47tzYXFA6GfOYfqs04UyZk2dLJptdGiWXwb/vrJYSSL/
         OcnlV1B0WgPmFoarUbo82FLEw/wlc//VVqk+UHoeO6asBFJbsYXtC0O8BrVVZHDxpSaZ
         LvIHBfoJBr/fXHGRlI3eGQSabq8WG1EAbQlkq+kPxqjLV7wQLsioHCdePkaCnV49HGha
         pgUouUQxskwYyWkEwnMTalvdny2AevLWMPiIXvPit/m0WmKC7UyKfcBjhWq9eOYQlZgJ
         co6jZtT6ekf/IraNjd/bQ64iT6GTDMbYzdJEyNKyvLqf0EOuDy5a5dJ+Ik99NNY7q5GC
         7tFQ==
X-Gm-Message-State: ABy/qLbd4KX/XUk2QINWdS3E9lfHl+jPWLAWxiG8cq8uvfaEPC4TPHuG
        BXKpcnzAadm4PtIWfm/XfdQ=
X-Google-Smtp-Source: APBJJlFJBCYCEw/T1eesusdKpJnG04ctuUTDZwBkKmocildT0EqZN47eSvxkdG250M3IzfW5eO0Yew==
X-Received: by 2002:a2e:9184:0:b0:2ad:a78a:df0d with SMTP id f4-20020a2e9184000000b002ada78adf0dmr9298943ljg.44.1689686700502;
        Tue, 18 Jul 2023 06:25:00 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id gj19-20020a170906e11300b00992ea405a79sm1004701ejb.166.2023.07.18.06.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:24:59 -0700 (PDT)
Date:   Tue, 18 Jul 2023 15:24:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Message-ID: <ZLaSqhsJr2qH5Y6E@orome>
References: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
 <CAMuHMdV-wu_XHy_qYGM+_UOAXN8etip731WxmgEmbQdv+SPwbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vG5bQDXGZvDGeDiV"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV-wu_XHy_qYGM+_UOAXN8etip731WxmgEmbQdv+SPwbw@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vG5bQDXGZvDGeDiV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 02:05:42PM +0200, Geert Uytterhoeven wrote:
> Hi Randy,
>=20
> On Tue, Jul 18, 2023 at 8:44=E2=80=AFAM Randy Dunlap <rd.dunlab@gmail.com=
> wrote:
> > From: Randy Dunlap <rd.dunlab@gmail.com>
> >
> > When (MFD) RZ_MTU3=3Dm and PWM_RZ_MTU3=3Dy, there are numerous build er=
rors:
> >
> > ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> > drivers/pwm/pwm-rz-mtu3.c:374: undefined reference to `rz_mtu3_disable'
> > ld: drivers/pwm/pwm-rz-mtu3.c:377: undefined reference to `rz_mtu3_8bit=
_ch_write'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
> > drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to `rz_mtu3_16bit_ch=
_write'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> > drivers/pwm/pwm-rz-mtu3.c:382: undefined reference to `rz_mtu3_8bit_ch_=
write'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
> > drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to `rz_mtu3_16bit_ch=
_write'
> > ld: drivers/pwm/pwm-rz-mtu3.c:111: undefined reference to `rz_mtu3_16bi=
t_ch_write'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> > drivers/pwm/pwm-rz-mtu3.c:397: undefined reference to `rz_mtu3_enable'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_disable':
> > drivers/pwm/pwm-rz-mtu3.c:259: undefined reference to `rz_mtu3_8bit_ch_=
write'
> > ld: drivers/pwm/pwm-rz-mtu3.c:264: undefined reference to `rz_mtu3_disa=
ble'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_enable':
> > drivers/pwm/pwm-rz-mtu3.c:230: undefined reference to `rz_mtu3_8bit_ch_=
write'
> > ld: drivers/pwm/pwm-rz-mtu3.c:234: undefined reference to `rz_mtu3_8bit=
_ch_write'
> > ld: drivers/pwm/pwm-rz-mtu3.c:238: undefined reference to `rz_mtu3_enab=
le'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_is_ch_enabled':
> > drivers/pwm/pwm-rz-mtu3.c:155: undefined reference to `rz_mtu3_is_enabl=
ed'
> > ld: drivers/pwm/pwm-rz-mtu3.c:162: undefined reference to `rz_mtu3_8bit=
_ch_read'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_read_tgr_registers':
> > drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to `rz_mtu3_16bit_ch=
_read'
> > ld: drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to `rz_mtu3_16bi=
t_ch_read'
> > ld: drivers/pwm/pwm-rz-mtu3.c:103: undefined reference to `rz_mtu3_16bi=
t_ch_read'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_get_state':
> > drivers/pwm/pwm-rz-mtu3.c:296: undefined reference to `rz_mtu3_8bit_ch_=
read'
> >
> > Modify the dependencies of PWM_RZ_MTU3 so that COMPILE_TEST is
> > still allowed but PWM_RZ_MTU3 depends on RZ_MTU3 if it is being built
> > but also allow the latter not to be built.
> >
> > Fixes: 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
> > Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com
>=20
> Thanks for your patch!
>=20
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -505,7 +505,8 @@ config PWM_ROCKCHIP
> >
> >  config PWM_RZ_MTU3
> >         tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> > -       depends on RZ_MTU3 || COMPILE_TEST
> > +       depends on COMPILE_TEST
>=20
> This makes the driver always depend on COMPILE_TEST,
> which is definitely not what we want.

Honestly, do we really need all of this complexity? I have specific
configurations to test all of the PWM drivers to make sure they build.
There's probably edge cases that don't get tested, but sooner or later I
expect some build bot will encounter those and then we can rectify
things. But in many cases that I've seen COMPILE_TEST just happens to do
more harm than good.

Thierry

--vG5bQDXGZvDGeDiV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS2kqoACgkQ3SOs138+
s6GEOQ//VtNdm+2x3n6p51On9dx6Gf3lyf3PYkQRuysyun3013E1AidkmKW/pJIt
6h9hTIRmrlK36r+vmNYd0HmDavF+d7t5Bo5MVvO8nTuHEz6TgyteNLeFY2+35lwf
UVlojoYV50PZPaCF+lt6IC3GFJSMqD7hsbjtk6aMLo0thovgyzuLMaTGI6+iQPMk
grhbGnmHe/JD7r5hFVaMhi0ewfBSJkncKeXjQ6hOyXOqUpOM6YpkM/HeWTOuiRcS
akNXMlsDxMv9zribgOlHRxji6ZQCHmMzQCkG9ZT9AxiSAdUyiXH5tgQfiQTWCNQF
SuCmoD+5qyeDXSMwnxHPRG58WWhppXznNO/lwSPz69KBAoX5oGvLVtOq2iRlYM/S
Vcr61u3Si6X5Aiah111m18dZB3EpI/Jz/Er4rsWovvhzjtx06TF1PtZce6zsBI+F
gHC8tBOEA74PBGeylyNjt9EmDSHtJ4c2J8aokYSCgHjkbV4FwsMCDz+IcX1UN1uA
5MQOPOHVWD8smQljJpRv0pKWEmIUfYgFnHGmq4MaglkPCSXrf/Y2iBT80pqkRjyn
AJKi0G6dl3fBZPK4CQQsdl4qiNPSWv415rJxlXfirV3kHreypxiQbka/e5/kkz+f
qyXylxDLlE/orSnwQ7bseNnQhplt6EmgN0JXzL8PdZf5L68HcOk=
=dql7
-----END PGP SIGNATURE-----

--vG5bQDXGZvDGeDiV--
