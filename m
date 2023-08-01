Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064A276B8F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjHAPqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjHAPqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:46:43 -0400
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB0EDA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690904800;
        bh=eYwIMN8zci6nGIsOM5BuWbHyBjNGPZrgg1JUL0HjpGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WWBdyiLfmVzUhhtq9II3H9qx7ncMWRZz9Dql31Zcw2dWADGnbCt5NyKrbWsNsg9OW
         4boZ6YpWPa16GH4WWLf0n43045kHlJCr34uVaDw3Xf5zvZHUfTvPt/wCm9eT71QYcz
         VRgi65+R7JjTclKtVRdRzrPPtEU/u89yCx3JEhKM=
Received: from localhost.localdomain ([220.243.131.5])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id BA435424; Tue, 01 Aug 2023 23:46:36 +0800
X-QQ-mid: xmsmtpt1690904796t7m92r9cy
Message-ID: <tencent_5E8D53EDF5D61E189A478942372A8C44CA06@qq.com>
X-QQ-XMAILINFO: NjrIpkS4KCMdr4uqZA74WgL3EmQd9D9SmzEtXpV7fIEb5MP5yID6FD9jVKYS3+
         R1t54ffXFzzRN9RZ5E/UJHxSEX+uLhl3EG4xGUXfhqelewg1z8kN+LHH2V1NVfU36hsgXZFwwG4J
         QTp0QcJonGBXQDntKLBP80Mh/ykdmmDIXf87g/UywL1Bs2bEn154xCgYRYS4WuLT/0gFxyqycFPc
         A+lskCcQ+2a4CjTUAuSCZUZegHW4OvG6c9RAYCNi6g4MkzhE2B6PK1XWD+VYdQVl8XfSrKR7rfx6
         qAHWLYvgfj1zdOUGWxNxEOTlqwYR3QMivPjiwtDj68lXNg2AeZXzLmAjkeKRDzshA8NL6fPCxAeD
         lKJmhc5NuI0oQXnKtIdnA02JRm/yrdU3QKUXLqUon6IdGUxOj0klrfdjwjMQdP+pHUY7bfXlVtOe
         huRxciisgNAmTD4Q+6xDXAXDIOOpn++CPr14niWkXNBK50Zm8WeCicbf+RRgqRG4q2b3MC4jn9Kd
         0o3gEmGtgxwVVF45UOAkxCi33T77Pq9MoYnRFcQ9ELhCW3sOD4j2y308h7t6h+fO0oMroYZrNsQQ
         jNoQ9PhxCyA2EnCzWoIrwP6B+LhgzHG9NhDPNU9XmqEcT3NQW4+X6xSFnnM79cHqQwS5K2hxWCK4
         CFxP8BP+CMKKdbD19cAFuPp7m9hhQ6dkyghWmaWD4b7vwHwQKCZHpRGtRA15sxwDEYlcrERwhDuB
         07N2Puauzy4gs9JG3BQoAJQ1R5YUe4nq5Lhhupy059up/qDAPXOaFxKaT88fjSlCFzpnwqYVz7mo
         YCcNpgx3hqyCTeY0BdrFZZ2msJ8UxzoJl4dw3VIhHzbVhAQQOClqTg3CQwnOVyQuVKYk2Cyp3WBX
         mTWi9s9lw0vNSEjL3RJQPfBr9axszOCchjYsRojMudYUI7DXnAVT5UEyTbkgyHmOiJlOYonKJIs4
         Xq03XffGaYFY55r/oa4lypgUl8DZzCRXClnaOLv0+CbcJ77JtzASFVcr5OvxBA
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: rt5665: add missed regulator_bulk_disable
Date:   Tue, 01 Aug 2023 23:46:36 +0800
X-OQ-MSGID: <2712364.mvXUDI8C0e@localhost.localdomain>
In-Reply-To: <ZL1DUWAeBbArQL1f@finisterre.sirena.org.uk>
References: <tencent_AA66A80A12D4372BB57E5B7A60471EB00A08@qq.com>
 <ZL1DUWAeBbArQL1f@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023=E5=B9=B47=E6=9C=8823=E6=97=A5=E6=98=9F=E6=9C=9F=E6=97=A5 CST=
 =E4=B8=8B=E5=8D=8811:12:17=EF=BC=8CMark Brown =E5=86=99=E9=81=93=EF=BC=9A
> On Sun, Jul 23, 2023 at 03:07:31PM +0800, Zhang Shurong wrote:
> > +	ret =3D devm_add_action_or_reset(&i2c->dev,=20
rt5665_i2c_disable_regulators,
> > +			rt5665);
> > +	if (ret)
> > +		return ret;
> > +
> >=20
> >  	ret =3D regulator_bulk_enable(ARRAY_SIZE(rt5665->supplies),
> >  =09
> >  				    rt5665->supplies);
> >  =09
> >  	if (ret !=3D 0) {
>=20
> This will attempt to disable the regulators if the initial enable fails
> which is a bug.
You are right. I will move this to rt5663_i2c_remove() in next version.



