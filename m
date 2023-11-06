Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59637E20A2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjKFMDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFMDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:03:07 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF13992;
        Mon,  6 Nov 2023 04:03:02 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso27613465e9.3;
        Mon, 06 Nov 2023 04:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699272181; x=1699876981; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hWopxWat4tLgBobBQDVXcqZrUI2NXNoROsWDHLeZdno=;
        b=V+FfS4qCdEIov7k+Zs2aFCATb297XOGDTElieh4eGYkIvcsCiVBheeH+BqeVR+NtgO
         q/aRFYboJt+Al9OlTIpxsJm3TRITB+RSbK68MiT1GziLD6zT0GgnX7+SV+Z5zh6d+wI/
         ckVOvfTE+2JwWlLW0/hnAyHu/4WBe1hS2s9pjkAezceuPcxUN2N5ymgnbv15/j1JyAhL
         P3s3iKX52qcQE2e0QEgw+An3FhELpDQchJx8RzzLCIoWA60Yyquqvh/4qpcP6B+EXznT
         P0BtRKLcZU6drqcc7LOoSDCZ3/7YydTxvHfO2GPR06yLVL/s3fUZrK/Ahwg/BEU0pTXN
         TS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699272181; x=1699876981;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hWopxWat4tLgBobBQDVXcqZrUI2NXNoROsWDHLeZdno=;
        b=PRytnuRI1nHZuKyAIWwGLa/rQ+yiMDrmZWwn4BZT1+wfc59NhZmBCojteHtmcD3+ID
         r9jmrKwu39gc/VnFSVmruP+v2Jurd3a3eOYTFkyKUO4R+yyh0CQV85PLCbRUDFNUXfU9
         s3FP+7TkciiuFjZpmWoNQ+hKUlJa7GCfLSo3OOKVQq8Aj/ok9Ql2TeM5pSnRO7Yxogyk
         8Lit4Ox65yPb757ogaFl360kbPA5oLaHZMDlP7Fx7wp4w9gnseIwCplu5k1CTFvWgwTH
         WuTJp8fAcrOCVN8T5f57akKS762YrV2XUcq+1I2w5o+4YKRMPtVmpfdh9gsbaG20OgFY
         pVcg==
X-Gm-Message-State: AOJu0YyORJNVl2btfz0KgNNnK78c21akHXg5vQJTMRB3jdXlYrJ7jI7h
        pyCfW51ihpQ7pOGbGiAXaTw=
X-Google-Smtp-Source: AGHT+IH9FobnFTnv63i2OrKL8vKRgqitZ6hOKWrbkAF49g6T/yEJYZwAbEjl3pE2dmEh0q9KzcBzbg==
X-Received: by 2002:a05:600c:5488:b0:405:9666:5242 with SMTP id iv8-20020a05600c548800b0040596665242mr25163556wmb.31.1699272181008;
        Mon, 06 Nov 2023 04:03:01 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id r22-20020a05600c35d600b003fee567235bsm12088863wmq.1.2023.11.06.04.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 04:02:59 -0800 (PST)
Message-ID: <e29dc510c78205d87b573e0fe185dc7c7d509310.camel@gmail.com>
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
Date:   Mon, 06 Nov 2023 13:02:58 +0100
In-Reply-To: <bf2b6899-fad0-4ac7-a906-e8d361e5a46d@intel.com>
References: <ff4ef031-774e-4e4d-a009-31f242bf6aee@kadam.mountain>
         <5b0f8705-71cb-4c4c-a70c-d9d3a15886cb@intel.com>
         <f040255ef1b3be87050b8255c947b4b375e75a02.camel@gmail.com>
         <bf2b6899-fad0-4ac7-a906-e8d361e5a46d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-06 at 12:18 +0100, Alexander Lobakin wrote:
> From: Nuno S=C3=A1 <noname.nuno@gmail.com>
> Date: Mon, 06 Nov 2023 11:07:16 +0100
>=20
> > Hi Olek,
> >=20
> > On Mon, 2023-11-06 at 10:31 +0100, Alexander Lobakin wrote:
> > > From: Dan Carpenter <dan.carpenter@linaro.org>
> > > Date: Mon, 6 Nov 2023 11:50:03 +0300
> > >=20
> > > Hi,
> > >=20
> > > > tree:=C2=A0=C2=A0 https://github.com/alobakin/linux=C2=A0pfcp
> > > > head:=C2=A0=C2=A0 89565e300e3d4033b8bb568774804fdc09d4f3cc
> > > > commit: 945a0d6e86d97bf60f2fae88ee557ed3eae18b94 [5/20] bitops: let=
 the
> > > > compiler
> > > > optimize {__,}assign_bit()
> > > > config: i386-randconfig-141-20231105
> > > > (
> > > > https://download.01.org/0day-ci/archive/20231106/202311060647.i9XyO=
4ej-lkp@int
> > > > el
> > > > .com/config)
> > > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > > reproduce:
> > > > (
> > > > https://download.01.org/0day-ci/archive/20231106/202311060647.i9XyO=
4ej-lkp@int
> > > > el
> > > > .com/reproduce)
> > > >=20
> > > > If you fix the issue in a separate patch/commit (i.e. not just a ne=
w version
> > > > of
> > > > the same patch/commit), kindly add following tags
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > > Closes: https://lore.kernel.org/r/202311060647.i9XyO4ej-lkp@intel=
.com/
> > > >=20
> > > > smatch warnings:
> > > > drivers/iio/imu/adis16475.c:363 adis16475_set_freq() warn: set_bit(=
) takes a
> > > > bit
> > > > number
> > > > drivers/iio/imu/adis16475.c:363 adis16475_set_freq() warn: clear_bi=
t() takes
> > > > a
> > > > bit number
> > > > drivers/iio/imu/adis16475.c:416 adis16475_set_filter() warn: set_bi=
t() takes
> > > > a
> > > > bit number
> > > > drivers/iio/imu/adis16475.c:416 adis16475_set_filter() warn: clear_=
bit()
> > > > takes a
> > > > bit number
> > > >=20
> > > > vim +363 drivers/iio/imu/adis16475.c
> > > >=20
> > > > fff7352bf7a3ce Nuno S=C3=A1 2020-04-13=C2=A0 357=C2=A0=20
> > > > 9da1b86865ab43 Nuno S=C3=A1 2021-09-20=C2=A0 358=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0adis_dev_unlock(&st->adis);
> > > > fff7352bf7a3ce Nuno S=C3=A1 2020-04-13=C2=A0 359=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > fff7352bf7a3ce Nuno S=C3=A1 2020-04-13=C2=A0 360=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If decimation is used,
> > > > then
> > > > gyro and accel data will have meaningful
> > > > fff7352bf7a3ce Nuno S=C3=A1 2020-04-13=C2=A0 361=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * bits on the LSB registers.
> > > > This info is used on the trigger handler.
> > > > fff7352bf7a3ce Nuno S=C3=A1 2020-04-13=C2=A0 362=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > fff7352bf7a3ce Nuno S=C3=A1 2020-04-13
> > > > @363=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ass=
ign_bit(ADIS16475_LSB_DEC_MASK, &st->lsb_flag, dec);
> > > >=20
> > > > assign_bit() takes a bit number like 0.=C2=A0 But this is passing B=
IT(0) so
> > > > it's like BIT(BIT(0)).=C2=A0 Which is fine until you get to 5.
> > >=20
> > > Is this intended? There are 2 places where you pass
> > > %ADIS16475_LSB_DEC_MASK and %ADIS16475_LSB_FIR_MASK, which is `BIT(0)=
`
> > > and `BIT(1)` respectively, to assign_bit(), which takes 0, 1 etc.
> > >=20
> >=20
> > Sorry, I'm missing the point in here... This should be a simple mask as=
=C2=A0
> > GENMASK(1, 0) setting/clearing the bits when appropriate. Obviously,
>=20
> assign_bit() does not take a bitmask as a first argument, but a bit numbe=
r.
>=20
> I.e. if you want to switch BIT(0), you call it like assign_bit(0, ...),
> not assign_bit(BIT(0), ...). Same for the bit nr 1.
>=20

Yes, I know... if you look at my reply to Dan you can see I realized that a=
lready :)=20

I guess by the time I first sent this time I didn't knew or maybe just a du=
mb
mistake...

I'll send a patch later today removing the BIT() from the #define, thx!

- Nuno S=C3=A1

