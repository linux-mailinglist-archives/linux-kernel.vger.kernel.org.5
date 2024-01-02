Return-Path: <linux-kernel+bounces-14934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DC48224A9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71321C22B5B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F327D1773D;
	Tue,  2 Jan 2024 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl0TtHe0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9ED171BA;
	Tue,  2 Jan 2024 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9ac5bd128so2475813b3a.0;
        Tue, 02 Jan 2024 14:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704234117; x=1704838917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e31awxvnUFU2mzL1bStxukrBXES4Vp8ekijyPrTWOWY=;
        b=Rl0TtHe06kkTcmVCV9mQKpAMeESgJL9FtPq5CzhQPgFQUvv1gbaU8uccg4OtMdR6mI
         VfRX7StpWxF8va5/2fPQh1LKFBgRsiR009J1uqf95uEhDghS4OZHk8bDqJKBJ2AISz5S
         6GBR+wyVaoLAuGlf0QE8A3oKMt0rLS50Sxgiizt1wi60LhmNN2h93JD+HxNd5rWF35uN
         vEEwlGYizSBhkij8JvyenvfocdT8n4NQYq2pCVahPHSaEyO4/DZLOvhksXeMf8f2yTSz
         j0bTtKwxCLY7pFtP1AiQAfmT45Hb4+sXptRUC/gKjBv9HVYvRAWBmHlukyAL/Rd0674f
         PNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704234117; x=1704838917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e31awxvnUFU2mzL1bStxukrBXES4Vp8ekijyPrTWOWY=;
        b=nm4d+2s17uPDO1twkQpvmuL5TAPgOVj0tEb1DS6CRrzcUpOM7A/uxACYGQ5EwMr9rp
         l8kPs3A8erZLmIIjRrNTImu7VPnrSKL1wxy9e4rjtHvC7uB1QifP97+m7ML6myP7nSzh
         ukYdK5+CAdzrr1e4G5Y4dUIu055BPO2BQSe7VBDS/6J84Tp2/GoC4cr+lHgX8ObcAb/5
         QqFQ3Ja+IFGZZdNoxFC4jsgygmrjF6t6p0PJfjKgyhdEPimjqG9I72puOW2/12S9pNFc
         bRMbnlqyKY9zbtWPsC72VA5g4SqL3ApZ/fMWitHGmO7vCRlVN0GMkxhGVW9hGTFWWlBU
         WvuQ==
X-Gm-Message-State: AOJu0YzVhxxW1LYg89nsDXyU8dg62E8YMzl2D3m/JsjBmYxzWHZNZ+IB
	scrS37Za1jypXXFPWqDyasBvRt/IaI4zdg7TRJM96n3NnSJFMg==
X-Google-Smtp-Source: AGHT+IF4q554b9sLQVLtVZ08bE6rxFhxwopWzqxMSE3grwFwt2Kc5KyI/G+0Qjk7LBoyfe8cXL6WefeuxRmg9a+xtXQ=
X-Received: by 2002:a05:6a20:f9f:b0:18f:97c:8263 with SMTP id
 ga31-20020a056a200f9f00b0018f097c8263mr6190446pzb.109.1704234117108; Tue, 02
 Jan 2024 14:21:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1704157631-3814-1-git-send-email-zhouzhouyi@gmail.com> <20240102194209.39dac963@jic23-huawei>
In-Reply-To: <20240102194209.39dac963@jic23-huawei>
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date: Wed, 3 Jan 2024 06:21:46 +0800
Message-ID: <CAABZP2y1ptNm2KMQ7tGttMgFFCMPS0=CjyfxYJkR8P1thEWA9Q@mail.gmail.com>
Subject: Re: [PATCH v3] iio: magnetometer: rm3100: add boundary check for the
 value read from RM3100_REG_TMRC
To: Jonathan Cameron <jic23@kernel.org>
Cc: songqiang1304521@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "zhili.liu" <zhili.liu@ucas.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 3:42=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Tue,  2 Jan 2024 09:07:11 +0800
> zhouzhouyi@gmail.com wrote:
>
> > From: "zhili.liu" <zhili.liu@ucas.com.cn>
> >
> > Recently, we encounter kernel crash in function rm3100_common_probe
> > caused by out of bound access of array rm3100_samp_rates (because of
> > underlying hardware failures). Add boundary check to prevent out of
> > bound access.
> >
> > Fixes: 121354b2eceb ("iio: magnetometer: Add driver support for PNI RM3=
100")
> Fixes is a formal tag so needs to be part of the main tags block
> (i.e. No blank line here!)
>
> I'll fix that whilst applying.
Thank you for helping us modify the patch, I learned a lot during this
process, thanks
>
> >
> > Suggested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > Signed-off-by: zhili.liu <zhili.liu@ucas.com.cn>
> > ---
> >  drivers/iio/magnetometer/rm3100-core.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magne=
tometer/rm3100-core.c
> > index 69938204456f..12c2e3b0aeb6 100644
> > --- a/drivers/iio/magnetometer/rm3100-core.c
> > +++ b/drivers/iio/magnetometer/rm3100-core.c
> > @@ -530,6 +530,7 @@ int rm3100_common_probe(struct device *dev, struct =
regmap *regmap, int irq)
> >       struct rm3100_data *data;
> >       unsigned int tmp;
> >       int ret;
> > +     int samp_rate_index;
> >
> >       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> >       if (!indio_dev)
> > @@ -586,8 +587,14 @@ int rm3100_common_probe(struct device *dev, struct=
 regmap *regmap, int irq)
> >       ret =3D regmap_read(regmap, RM3100_REG_TMRC, &tmp);
> >       if (ret < 0)
> >               return ret;
> > +
> > +     samp_rate_index =3D tmp - RM3100_TMRC_OFFSET;
> > +     if (samp_rate_index < 0 || samp_rate_index >=3D  RM3100_SAMP_NUM)=
 {
> > +             dev_err(dev, "The value read from RM3100_REG_TMRC is inva=
lid!\n");
> > +             return -EINVAL;
> > +     }
> >       /* Initializing max wait time, which is double conversion time. *=
/
> > -     data->conversion_time =3D rm3100_samp_rates[tmp - RM3100_TMRC_OFF=
SET][2]
> > +     data->conversion_time =3D rm3100_samp_rates[samp_rate_index][2]
> >                               * 2;
> I've rewrapped this to be on one line whilst applying. Make sure to check=
 for
> side effects like this when updating code.  If we don't tidy it up at the=
 time
> we end up with gradually worse formatting over a long period!
Thank you for fixing that for us.
>
> Applied to the fixes-togreg branch of iio.git and marked for stable.
I saw the commit on the fixes-togreg branch of iio.git, exciting!
I learned a lot from it ;-)

Thanks again
Thanks,
Zhouyi
>
> Thanks,
>
> Jonathan
>
> >
> >       /* Cycle count values may not be what we want. */
>

