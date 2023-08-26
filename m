Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A429378975D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 16:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjHZO03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 10:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjHZO0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:26:16 -0400
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9541FC7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693059970;
        bh=bBm3JZWtV19d5mTvY144XG0VpJxbcD0Lb6oNpBSzTKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WWBKon/U5DoGDM0Yjpjf2hUXTIlCIRI2ppxbYBc1j8D1SMkXtmveeS7Slwzc6WH5F
         1EnXEKHWzaJPakQELU6pO5vo+Am0ARopGGA4W6jHeIQi8tg21Qx1qSEbtAKlfHgMY0
         TzedT3+MExcU5YQqpCaNpBqKDKv7gOwTUXqvTXU4=
Received: from localhost.localdomain ([220.243.191.34])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 46A86A0C; Sat, 26 Aug 2023 22:17:42 +0800
X-QQ-mid: xmsmtpt1693059462tjsabkefh
Message-ID: <tencent_D0AA2D25300E0F108559545E899C9B8EDA07@qq.com>
X-QQ-XMAILINFO: M3X79PAqfpWTsaSODfveg0gn1w+AdJXCvBs4ZojKWmplo/bKlgY+Naa/Oa1kR9
         iRth/98V87fdTt3810GEHAT/zmy9LZi0y2GANFUrBP1a2Rr0c/OuAGsLFSeSsQH8g+RKJi+uvRAb
         MamYUOZUIV/3ag0vwguLtMu4OST5QeNWUkHT+cp5i6idQVWw0Lu6NWr87xSVgeT/NurrG0Vpzg9x
         OeKAp6VkydQrFCH0t6NQAtxepVj/dH1+bglVrM3o2wRH1f8o2j+Dn2OY48ZJe35eFaK5t6GBIWbp
         XtUA21+moSODPBt4DqYi0cIVgzRE0TP4JutrLJVC2Sg4DTBS8/2v/0RMGbRc/A/hdPFHhH5ENlEP
         m2P2IipjG70IiKd7Y6jxt+6F+uCoKx12uxNxV8PwrTjOhWhg1dlb6/LCr/EsM0Q5u3nzKM538Mlg
         b/MDeAwNtg/KrpCpJtY42uktniFiIBdVp/L9GpfzO0ipKwcjMHnsXOllR0RUwm0PIyne2UCBnSsm
         bG/0jtj5yU571vHTjMSZjjhkThMJdtlUd/aFNz9nxqMyvAXXWLtXo7rkLldvfUmi3MKWEatWHGg9
         yYQio28hv2wgabtO+48CucW/thjRivO6D21F+1GUN0B1v80zgBmDF/4+O4VvK4hUautQN6DxJxeU
         BxTjMcM+w2slLrADMCK38eJoXoKxWw3020DooGOuNbFIPQfimYlWjV37Z2rKdLpb3Z6cyrrpt8qM
         gQyoFhmegjDXhMcTMJ7ZcXj4ZJeXGSKlte2VIZYZAVvbOZZ2VqrIneI1EdMJgkciGmo/kUhBFy8l
         YRA+UsJ8agPD2NsyKJ1PHwkbAEckIjxOQSHHo4HhxB2Zw0DKL0wKDwV8ys3Od0Fdw9wLCSRVB4el
         kV78hU9GX8YKj8v/bAgsPA0GlUmWgoaGgzYetW2krNUh9rc5RKEA2k6TQRmQQDuKtOMKgcrbuWZf
         JU8X4wiHnE3pk2AnQ6pSD27Wlb34W5vpe8Z4dGdpjBkdhv6nYiWRy7hpXA9ldlufkd20f1eRxJlV
         jUmUzqoqufUHmOBRJIm0ckp0kgAPpM8KQGQ8TMlw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     quic_schowdhu@quicinc.com, agross@kernel.org, andersson@kernel.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: misc: eud: Fix missing IRQ check in eud_probe()
Date:   Sat, 26 Aug 2023 22:17:42 +0800
X-OQ-MSGID: <4832339.GXAFRqVoOG@localhost.localdomain>
In-Reply-To: <f9df2e02-9fae-4e16-9412-d378ef168903@linaro.org>
References: <tencent_C40B301A0F71853A540809BE1BB85AB12D07@qq.com>
 <f9df2e02-9fae-4e16-9412-d378ef168903@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023=E5=B9=B48=E6=9C=8826=E6=97=A5=E6=98=9F=E6=9C=9F=E5=85=AD CST=
 =E4=B8=8B=E5=8D=886:49:27=EF=BC=8CKonrad Dybcio =E5=86=99=E9=81=93=EF=BC=9A
> On 26.08.2023 12:47, Zhang Shurong wrote:
> > This func misses checking for platform_get_irq()'s call and may passes =
the
> > negative error codes to request_irq(), which takes unsigned IRQ #,
> > causing it to fail with -EINVAL, overriding an original error code.
> >=20
> > Fix this by stop calling request_irq() with invalid IRQ #s.
> >=20
> > Fixes: 9a1bf58ccd44 ("usb: misc: eud: Add driver support for Embedded U=
SB
> > Debugger(EUD)") Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> > ---
> >=20
> >  drivers/usb/misc/qcom_eud.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
> > index 7f371ea1248c..b33c615a2037 100644
> > --- a/drivers/usb/misc/qcom_eud.c
> > +++ b/drivers/usb/misc/qcom_eud.c
> > @@ -204,7 +204,12 @@ static int eud_probe(struct platform_device *pdev)
> >=20
> >  	if (IS_ERR(chip->mode_mgr))
> >  =09
> >  		return PTR_ERR(chip->mode_mgr);
> >=20
> > -	chip->irq =3D platform_get_irq(pdev, 0);
> > +	ret =3D platform_get_irq(pdev, 0);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	chip->irq =3D ret;chip->irq =3D plat..
>=20
> if (chip->irq < 0)
> 	return chip->irq
>=20
> ?
>=20
> Konrad
Thank you for your thoughtful response. To clarify, are you suggesting that=
 I=20
replace the usage of `ret` with `chip->irq`? If that is the case, I will=20
proceed with creating a patch for version 2.





