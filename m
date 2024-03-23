Return-Path: <linux-kernel+bounces-112332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2586887881
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4079D1F23220
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD31A1B802;
	Sat, 23 Mar 2024 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU9xrwqE"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CE1C157;
	Sat, 23 Mar 2024 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711196255; cv=none; b=h0a6DBHIbtldYiOFAecRltDLilG1n24RVdIegbD72rskobwikqaH0ypPhDxoBIHTc3Xzi3np0Eew2rNk8FCM7lXHU8GRLOpAPwumZyK6eciaYh9Iha0DS0XnAUNSwLt5bn9KbMXnmIYRdeoUdzHHAUclZ7boS/3k+s26OFnQ5d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711196255; c=relaxed/simple;
	bh=IPM7SrXbcPNHecQTdTFyVqK8ijt6QdlNkXGPW1J/fE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ue0ILaGVmmzl1PSDI1e4FoIbl8JCQo+WQkF0qo6bo2TOorAZfhSSbRDp4eYbvYDt5q3cWjA7kGotflGdfYasMoyl5olVZbpi92QWXv/dIDWY79mBYbNiUtHPqIOMmjA4xuej7FrcFm+YgEM0tsYZ9Edx6quwxgImVxIYhRXiCdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aU9xrwqE; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60a104601dcso34184057b3.2;
        Sat, 23 Mar 2024 05:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711196252; x=1711801052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N9muYwrr5siQd/JSyRtkrxFkYsG9VIDfFrsB3T/A7s8=;
        b=aU9xrwqEESepGKVHB2aNoxMziLBcyf12m6LQfwJ0igaG7EgH9HqLACjcFTS7gSYgkJ
         bBJW9TR8FIdAQ0ZwgBt/vSQObjqk9/piP8HhSy/GIo4IKL5VxAhRqMeALE2TBZTlDIpz
         d2PxqhaIllcdk6ruWz5K7k8fDKtRfw4v9K0YfGuKX9TO7JIrQ70FY/ux7lPJBbf3vHZh
         ZfsS1A4YuRzofL59/qa+k+erFyA2gqd8xg0m6i5Q0JCEiWLil0P3xsJKnLWuIQ9eR4dj
         D732yEOPqNAjE8tDCOUglOyDk8UHvJeCHsvXbA4o8wo0sFXeFzSjY+obR2pO6SGkt7Ln
         bjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711196252; x=1711801052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9muYwrr5siQd/JSyRtkrxFkYsG9VIDfFrsB3T/A7s8=;
        b=tYkWzK/U79H/DiAvYsVDw2Iq2pybZv4piHXTafinb4SKBr4YkRgHUxMtLWtt5VHLKM
         Rhtxw6e01Wq8rUKBm4TAzrqvWAj9erSiy8zmlu0l0J2GIljOzG9lT0Lop3JSGohmkcnf
         x2xKeweVBOwZjKAmCJI5kvh0IvxhS1ZGC1bfzrswgB8VwwANHkX8te2PiijrbdbRAv5s
         YNhBlRIHRPgJrt5pI3K0r2k6vM6pjYO1FlnY+UqgO1iuU5QDdR55AnReDYOLId2SOdke
         aFOBS1yIv09IDwuWBURwCEEQQAbTC4dgGAIxXJIIXei2CJzy43Q2KywOeRYOAz6cDsRJ
         P3Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWzHihc0JJrAZShgJSROmTCtn6lsfekB0SxBH0HoZuijY1VDiAQWHblSrfaJeL7hnS1jb7/mmBA7igEXsg6fLVv/fvAucuF34oo3gzcxvSIM6fbbuzo2x2DwRWJtKqqytN1dwOt8kvKgr/i9j4QTRA4JXt0m72U3cIUPeCY280e6lGmEA==
X-Gm-Message-State: AOJu0YwEgYwqxPgKFXRf/bOCpC1ZWSfw6ljN64ClxRqEAV2WMKNioWY7
	CTP6y+CtSkIArFrX863FwLwa6v7xkp4uZytqIFRaLrqgRvjAXeYfW1LDIYLlfN14h/7apOMnona
	EYqOd4N5yCTnOWdX5nmWqeeGXv5c=
X-Google-Smtp-Source: AGHT+IHnoiDiQMiEplIMllv8uUcrOQqfBT1/SHpRch47p55g2nnS7+PqK3vLgbbllMYGzDN9aGU7v+olCYhiyYSgNuA=
X-Received: by 2002:a25:1941:0:b0:dd0:2076:4706 with SMTP id
 62-20020a251941000000b00dd020764706mr1328550ybz.31.1711196252566; Sat, 23 Mar
 2024 05:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322003713.6918-1-l.rubusch@gmail.com> <20240322003713.6918-2-l.rubusch@gmail.com>
 <51e3683f-be53-4bb7-a994-ffd05744a745@linaro.org>
In-Reply-To: <51e3683f-be53-4bb7-a994-ffd05744a745@linaro.org>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 23 Mar 2024 13:16:56 +0100
Message-ID: <CAFXKEHYUVoiW6MthJokV2=AYcZnqw36jETL=-m6kpDCP_UNHAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: accel: adxl345: Update adxl345
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"

(...)
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345.h      |  44 +++++++++++-
> >  drivers/iio/accel/adxl345_core.c | 117 +++++++++++++++++--------------
> >  drivers/iio/accel/adxl345_i2c.c  |  30 ++++----
> >  drivers/iio/accel/adxl345_spi.c  |  28 ++++----
> >  4 files changed, 134 insertions(+), 85 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > index 284bd387c..01493c999 100644
> > --- a/drivers/iio/accel/adxl345.h
> > +++ b/drivers/iio/accel/adxl345.h
> > @@ -8,6 +8,39 @@
> >  #ifndef _ADXL345_H_
> >  #define _ADXL345_H_
> >
> > +#include <linux/iio/iio.h>
> > +
> > +/* ADXL345 register definitions */
> > +#define ADXL345_REG_DEVID            0x00
> > +#define ADXL345_REG_OFSX             0x1E
> > +#define ADXL345_REG_OFSY             0x1F
> > +#define ADXL345_REG_OFSZ             0x20
> > +#define ADXL345_REG_OFS_AXIS(index)  (ADXL345_REG_OFSX + (index))
> > +#define ADXL345_REG_BW_RATE          0x2C
> > +#define ADXL345_REG_POWER_CTL                0x2D
> > +#define ADXL345_REG_DATA_FORMAT              0x31
> > +#define ADXL345_REG_DATAX0           0x32
> > +#define ADXL345_REG_DATAY0           0x34
> > +#define ADXL345_REG_DATAZ0           0x36
> > +#define ADXL345_REG_DATA_AXIS(index) \
> > +     (ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
> > +
> > +#define ADXL345_BW_RATE                      GENMASK(3, 0)
> > +#define ADXL345_BASE_RATE_NANO_HZ    97656250LL
> > +
> > +#define ADXL345_POWER_CTL_MEASURE    BIT(3)
> > +#define ADXL345_POWER_CTL_STANDBY    0x00
> > +
> > +#define ADXL345_DATA_FORMAT_FULL_RES BIT(3) /* Up to 13-bits resolution */
> > +#define ADXL345_DATA_FORMAT_SPI         BIT(6) /* spi-3wire */
> > +#define ADXL345_DATA_FORMAT_2G               0
> > +#define ADXL345_DATA_FORMAT_4G               1
> > +#define ADXL345_DATA_FORMAT_8G               2
> > +#define ADXL345_DATA_FORMAT_16G              3
> > +#define ADXL345_DATA_FORMAT_MSK              ~((u8) BIT(6)) /* ignore spi-3wire */
> > +
> > +#define ADXL345_DEVID                        0xE5
> > +
(...)

I think I see your point. My patch has more noise and lacks a logic
structure in proceding.
I will resubmit, but may I ask one question in particular. I moved the
entire list of register
defines from the adxl345_core.c to the common adxl345.h.
For setting spi-3wire with my approach, only two of those defines are
needed. I think it is
nicer for readability to keep the defines together, though, in a
commonly shared header.
Nevertheless most of the defines are just used locally in the .._core.c
Should I move them for refactory?
I feel there is no reason to move them. On the other hand I see many
drivers keep them in a common header. Hence, is there a best practice
which justifies moving them to a header?

