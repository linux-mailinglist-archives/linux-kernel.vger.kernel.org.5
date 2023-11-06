Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B6C7E1DDD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjKFKHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:07:22 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FB3B6;
        Mon,  6 Nov 2023 02:07:19 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32dc9ff4a8fso2471156f8f.1;
        Mon, 06 Nov 2023 02:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699265238; x=1699870038; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yXaH60OXLA944yqNjhnmnFs2o9Uym/cHZ9fIZjVIilg=;
        b=WuWliTznxRMMg27mQF+GSJTcNJFSWkbOyCJH7KDZOC3hweue05APfm3JUjU91pn18m
         bRN5xDL51TZiTe1hAUpMWeSnjhuxkFkiJ4DhvD+O6hpsCgd52UhdU6ZYULvA2FQtrj5z
         5h6qc9rVPnFJ3rQYdlv1eYXwUBy097sdPrCZIsOLFI/VaEDBuawgGMWX3kqSFISVmKMe
         1nZDpthso+j2rPj7bzG9NWiYvSEfAytS769aInZB6r0v5B4XnOUh4yxGLgAAr0GTqfbl
         npjJpsXoEE+w86pQ62XBjJdUOkGlM/dGbqdyMIDgQB8iZceuN1e5+J3IgMbJO4OnUcxi
         sJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699265238; x=1699870038;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXaH60OXLA944yqNjhnmnFs2o9Uym/cHZ9fIZjVIilg=;
        b=iyfh+zUUbPMsQTJUR8b+AQN2KCoYPsWJWtpf08t9vMEb2GPyMYwL+KTlmGdrHnnmcj
         mMI6nfdTFiQoKXFKYaHSnlg+94WYr5XDQITLf2DvjLPk+J5DAm0mPHo+0RsezPqQuKlD
         sNg2mvlH6NKXx3qZeH9n0PFkIaHzdH9ArwqG+lR2cwhMRHvT9UoaTeTKtYAtXF6WyDhb
         fthhXBl446y0wD3y6Uo9aEJbkP34HcIlmOEKcVi3V5aJ4Tt5eSAV8JPDeuVkTBpm2YGJ
         duH7cc4UwQa2EnRosD+xrFXeUTNIoJhTJr5MiQhFMnGDpj4vmxOK71aglxK1jZtUbd/O
         kSeQ==
X-Gm-Message-State: AOJu0YzfgrW2pvI0H7febVwTt8Ei0YlP/j4UExVkF2hhef2Z/xgEp+S6
        fNr6y0xo24VUR36Q79U3qfyabAkvipKvwg==
X-Google-Smtp-Source: AGHT+IFJeY3VYgc4qugk09KMU8myylq6CYIxrFpb9Lz5TnPJnxxG3RL3CSmXBkxz8lIfciDav5gB1A==
X-Received: by 2002:a05:6000:1f07:b0:319:68ce:2c53 with SMTP id bv7-20020a0560001f0700b0031968ce2c53mr25520550wrb.25.1699265237765;
        Mon, 06 Nov 2023 02:07:17 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id j5-20020adfe505000000b0031fd849e797sm8606006wrm.105.2023.11.06.02.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:07:17 -0800 (PST)
Message-ID: <f040255ef1b3be87050b8255c947b4b375e75a02.camel@gmail.com>
Subject: Re: [alobakin:pfcp 5/20] drivers/iio/imu/adis16475.c:363
 adis16475_set_freq() warn: set_bit() takes a bit number
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Nuno Sa <nuno.sa@analog.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 06 Nov 2023 11:07:16 +0100
In-Reply-To: <5b0f8705-71cb-4c4c-a70c-d9d3a15886cb@intel.com>
References: <ff4ef031-774e-4e4d-a009-31f242bf6aee@kadam.mountain>
         <5b0f8705-71cb-4c4c-a70c-d9d3a15886cb@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olek,

On Mon, 2023-11-06 at 10:31 +0100, Alexander Lobakin wrote:
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Date: Mon, 6 Nov 2023 11:50:03 +0300
>=20
> Hi,
>=20
> > tree:=C2=A0=C2=A0 https://github.com/alobakin/linux=C2=A0pfcp
> > head:=C2=A0=C2=A0 89565e300e3d4033b8bb568774804fdc09d4f3cc
> > commit: 945a0d6e86d97bf60f2fae88ee557ed3eae18b94 [5/20] bitops: let the=
 compiler
> > optimize {__,}assign_bit()
> > config: i386-randconfig-141-20231105
> > (https://download.01.org/0day-ci/archive/20231106/202311060647.i9XyO4ej=
-lkp@intel
> > .com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce:
> > (https://download.01.org/0day-ci/archive/20231106/202311060647.i9XyO4ej=
-lkp@intel
> > .com/reproduce)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Closes: https://lore.kernel.org/r/202311060647.i9XyO4ej-lkp@intel.com=
/
> >=20
> > smatch warnings:
> > drivers/iio/imu/adis16475.c:363 adis16475_set_freq() warn: set_bit() ta=
kes a bit
> > number
> > drivers/iio/imu/adis16475.c:363 adis16475_set_freq() warn: clear_bit() =
takes a
> > bit number
> > drivers/iio/imu/adis16475.c:416 adis16475_set_filter() warn: set_bit() =
takes a
> > bit number
> > drivers/iio/imu/adis16475.c:416 adis16475_set_filter() warn: clear_bit(=
) takes a
> > bit number
> >=20
> > vim +363 drivers/iio/imu/adis16475.c
> >=20
> > fff7352bf7a3ce Nuno S=C3=A1 2020-04-13=C2=A0 357=C2=A0=20
> > 9da1b86865ab43 Nuno S=C3=A1 2021-09-20=C2=A0 358=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0adis_dev_unlock(&st->adis);
> > fff7352bf7a3ce Nuno S=C3=A1 2020-04-13=C2=A0 359=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > fff7352bf7a3ce Nuno S=C3=A1 2020-04-13=C2=A0 360=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If decimation is used, then
> > gyro and accel data will have meaningful
> > fff7352bf7a3ce Nuno S=C3=A1 2020-04-13=C2=A0 361=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * bits on the LSB registers.
> > This info is used on the trigger handler.
> > fff7352bf7a3ce Nuno S=C3=A1 2020-04-13=C2=A0 362=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > fff7352bf7a3ce Nuno S=C3=A1 2020-04-13
> > @363=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0assign_=
bit(ADIS16475_LSB_DEC_MASK, &st->lsb_flag, dec);
> >=20
> > assign_bit() takes a bit number like 0.=C2=A0 But this is passing BIT(0=
) so
> > it's like BIT(BIT(0)).=C2=A0 Which is fine until you get to 5.
>=20
> Is this intended? There are 2 places where you pass
> %ADIS16475_LSB_DEC_MASK and %ADIS16475_LSB_FIR_MASK, which is `BIT(0)`
> and `BIT(1)` respectively, to assign_bit(), which takes 0, 1 etc.
>=20

Sorry, I'm missing the point in here... This should be a simple mask as=C2=
=A0
GENMASK(1, 0) setting/clearing the bits when appropriate. Obviously,=20
ADIS16475_LSB_DEC_MASK and ADIS16475_LSB_FIR_MASK are not properly defined
:sweat_smile:

- Nuno S=C3=A1
>=20
> >=20

