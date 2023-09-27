Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF8F7B00CA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjI0Jnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjI0Jn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:43:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951E2EB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:43:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-317c3ac7339so10269818f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695807804; x=1696412604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/Vciu3+yHbE6O47q6hpt2TsbRbklZJdjV+A597c9zg=;
        b=3bGtPrA0BXIENl9oSRbaaIxz9qEYmLKtFI7xo7Z0YwgwFkZu5nM79HQHyVwpb67IG8
         ApFIN1W2f12eH/Ul5nUxtXTxGD46vwoicJMibSG8lqxJT7ZNalmOY6S4YjvONpfsf0PK
         yobND6Uar5vtiisBpwejj8/bPQqEDZQKEkhw7KoBj4YEbDGnR+88GlNiuPHiZZo1bd3R
         B4z4CSV5WeF3dSWdEcxGOFF2PB6mTGvWokN3yOKVjxpbo6Bp3LDAx6a28FdUekVvsbMR
         PHD0ircKI7WiiY4S12yT8WXKBRgB6JT8rhlubWKCmt4lUC4EojC38AkzIIoUccFCDbVI
         6SLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695807804; x=1696412604;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c/Vciu3+yHbE6O47q6hpt2TsbRbklZJdjV+A597c9zg=;
        b=VfMhr6gGAi3Qn8FcTKn6SHV1RiCcnfqJzMiHVpmu+QL8bUXDXgVngnG5ThFylMqW9m
         Y79/+B1wQCgbMfVqmoNSSLr6Q/90QmAP+obWoRXsmouJ2gWoBPX+iDI0ui5IWoB9Dga+
         x0+esd66Wrn+t6uFAUQs2y5MCr44hUZodLOzGQqIFn01iMImVn8714pS9xvvmUaOyfFC
         TAux3Fk9yE+XKzPvE/hn6j24C6YuaU3g2xmd5ke4FtQKBR6eddBejkUUr851JUf+JHuV
         Pv3nHJwVY02iU+Bynjm8QtBVQ7eaLdKL469YQP127MCQSDb2WnPJDOWg1ffn/UPZjgYb
         B1jA==
X-Gm-Message-State: AOJu0YxCYeBdLcRl5V5oWTuScDfGIYB/LiAr3KSe9vZS6b0f+BnaXxio
        yFI1rll5CtvksQVv41HzGc268W1Z6aAvmBW4xmIMeA==
X-Google-Smtp-Source: AGHT+IGGV6+4F4z4U+nloZLbx1bb64PnR6aspmMiWtP8Fw3PjRsqTIUVvuvyt37IYY4jaWlUCSXjww==
X-Received: by 2002:adf:eb82:0:b0:31f:a259:73c with SMTP id t2-20020adfeb82000000b0031fa259073cmr1241534wrn.27.1695807803801;
        Wed, 27 Sep 2023 02:43:23 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:99be:56aa:a730:ad2d])
        by smtp.gmail.com with ESMTPSA id g16-20020adfa490000000b003232380ffd5sm8660245wrb.106.2023.09.27.02.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 02:43:23 -0700 (PDT)
References: <20230927072544.764285-1-Rong.Chen@amlogic.com>
 <202309271651027503622@amlogic.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     "Rong.Chen@amlogic.com" <Rong.Chen@amlogic.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: meson-gx: Remove setting of CMD_CFG_ERROR
Date:   Wed, 27 Sep 2023 11:30:37 +0200
In-reply-to: <202309271651027503622@amlogic.com>
Message-ID: <1jil7wkl39.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 27 Sep 2023 at 16:51, "Rong.Chen@amlogic.com" <Rong.Chen@amlogic.com=
> wrote:

> Hi Jerome,
>
> Socs containing previous controllers are gxl, gxm, gxbb=EF=BC=8Cg12b=EF=
=BC=8Cg12a=EF=BC=8Csm1=EF=BC=8Caxg, a1=EF=BC=8Cs4 and t7.

That is mostly all the SoC we know of in mainline ... This why the way
you explained is confusing.

And below, you say 'on latest controllers', okay but which ones ?

> The bit CMD_CFG_ERROR is used for selecting SG LINK of data address on la=
test controllers=EF=BC=8Cbut
> data address don't use SG LINK at present=EF=BC=8Cso it will cause an IRQ=
 and stop working on latest controllers.
> Therefore, remove this setting.

Not totally sure what SG LINK but okay.

While the change itself is fine you really need reformulate the description.
Based on your explanation, something like:
---
For the t7 and older SoC families, the CMD_CFG_ERROR has no effect.
Starting from SoC family XYZ, it will select SG LINK on error but this
is causing a problem with the data address ... blablabla
---

Please expand a bit on this, try to make it clearer.
Also, please insert the proper fixes tag

Last, make sure tp reply with plain text emails, otherwise lists will
drop your reply and please do not top post.

Thx

>
> Thanks.
> -------------------------------------------------------------------------=
------------------------------------------------
> Rong.Chen@amlogic.com
>
>=20=20=20
>  From: Jerome Brunet
>  Date: 2023-09-27 15:43
>  To: Rong.Chen; Ulf Hansson; Neil Armstrong; Kevin Hilman; Martin Blumens=
tingl
>  CC: linux-mmc; linux-arm-kernel; linux-amlogic; linux-kernel
>  Subject: Re: [PATCH] mmc: meson-gx: Remove setting of CMD_CFG_ERROR
>  [You don't often get email from jbrunet@baylibre.com. Learn why this is =
important at
>  https://aka.ms/LearnAboutSenderIdentification ]
>=20=20=20
>  [ EXTERNAL EMAIL ]
>=20=20=20
>  s
>  On Wed 27 Sep 2023 at 15:25, "Rong.Chen" <Rong.Chen@amlogic.com> wrote:
>=20=20=20
>  > From: Rong Chen <rong.chen@amlogic.com>
>  >
>  > Setting bit CMD_CFG_ERROR has non effects on previous controllers.
>=20=20=20
>  Which previous controllers ? v2, v3 ? Can you list the SoCs please ?
>=20=20=20
>  > However, it will cause an IRQ and stop working on latest controllers,
>=20=20=20
>  Isn't it desirable to stop on error ? seems like a sane thing to do.
>=20=20=20
>  > This bit is used for selecting SG LINK of data address.
>  > Don't set the bit CMD_CFG_ERROR anymore to resolve this issuse.
>=20=20=20
>  I'm not sure I understand the actual issue being resolved.
>  Could you provide more details please ?
>=20=20=20
>  >
>  > Therefore, remove this setting.
>  >
>  > Signed-off-by: Rong Chen <rong.chen@amlogic.com>
>  > ---
>  >  drivers/mmc/host/meson-gx-mmc.c | 1 -
>  >  1 file changed, 1 deletion(-)
>  >
>  > diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-=
gx-mmc.c
>  > index 9837dab096e6..c7c067b9415a 100644
>  > --- a/drivers/mmc/host/meson-gx-mmc.c
>  > +++ b/drivers/mmc/host/meson-gx-mmc.c
>  > @@ -801,7 +801,6 @@ static void meson_mmc_start_cmd(struct mmc_host *m=
mc, struct mmc_command *cmd)
>  >
>  >       cmd_cfg |=3D FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
>  >       cmd_cfg |=3D CMD_CFG_OWNER;  /* owned by CPU */
>  > -     cmd_cfg |=3D CMD_CFG_ERROR; /* stop in case of error */
>  >
>  >       meson_mmc_set_response_bits(cmd, &cmd_cfg);

