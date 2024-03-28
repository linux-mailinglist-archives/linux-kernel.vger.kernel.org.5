Return-Path: <linux-kernel+bounces-123344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 042268906E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5C629FDA0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B655446A5;
	Thu, 28 Mar 2024 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4TOsC4u"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2AA3BBDE;
	Thu, 28 Mar 2024 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645646; cv=none; b=Xg3g0/k4E2EOinzgOsn8ZEzmu3kPuRaW0f5WvH1Or/pYdXtqpSwU84JpYaIy/zYWjo23F4dhajZK/cEuwAInav2Y4pYSRoeBJEN2jLCpxrBr4AKsQMMRIJi/onOzm0gOIqj4LA9N8kPyIUxTrOauxNrIVgf6uGWF5dZhJLdhbx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645646; c=relaxed/simple;
	bh=6RQDoGeT546Pixy+4SXFxoN5IeqOGhhfiLlcwZ1C7v4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XooakCZMl+YbESaDGiiLzG3RnTAGu/1HjbqPelZCZbZceKwxjxjlAhPDP4gVOD3J/JjcmTOOoRQYPlEHvPg5INZWoen/5hI0yWhrZVNR57J49nZ4o5jfhEn2yFVK3b0O0rPNCWR8n8sBzPr2C3u04wvA20LXlAcnEi8H92y99bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4TOsC4u; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d485886545so19131401fa.2;
        Thu, 28 Mar 2024 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711645643; x=1712250443; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6RQDoGeT546Pixy+4SXFxoN5IeqOGhhfiLlcwZ1C7v4=;
        b=D4TOsC4uazCP1AdIxcB83L5IkaZGM+PhyZFYEwFzGdui8Eizd2SEFek3PQa7Gjx5em
         t1yRgwcfClP7UzL0Hr5xOSG5nMl9pzQ9JVdGYwrB29AuKgJ5tI7N5iXt9GODb/iLrcDF
         gwhcX3zE4ayjlzgCHJ5skC7kKvGo7pgOPxjpsLptFC0FpbNwKIIrYUuAB3AlOPegJskB
         JezbJJ+h8RYesegqnxPXgP95wBNB/CxwuMij4c0FjA0F46zOmMz8CkAZdKAnCqjqFvWR
         U6b4L1wW5Scx52seB+NAyqnALElPK+QV0v7PzYKjU9ucgcQvmMBX51qx8OTpTfdUpr63
         sj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645643; x=1712250443;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RQDoGeT546Pixy+4SXFxoN5IeqOGhhfiLlcwZ1C7v4=;
        b=h6vc/cnmZwQAeBkIxkogY3EEmyQJcJlOD9pbqz1k2RqZZn2YB4wAjw97vqnFrZpy1+
         oVarEi4HDAQGfI5WE0anldNMgfiVzMZg4MIBggfwcs9wwwKW0K5+Yrs/jggBJnA3qg8Q
         iGur3+81TJSZ87QCU6+qxb2cLghhRrauXDCLW2wD7os8oYFpKO7Xh0qJLMiU/mxAiwnC
         FAGpdpSHDrB21cbKI2EYRpghuuvGwh2QuxKDwc8N/JQyHix3iA8ACSIAEMWYZxtC9yXN
         vzqd9ZL5Q43P5XdroeNoGKG87okcDjIUnx56wqCtWFaxyRAvUnWGaFMKvC+Eo7wyJXuo
         X3tg==
X-Forwarded-Encrypted: i=1; AJvYcCVeuXbDEtP3tENbNXkHQGun2YrlZlQpr4yWAmZchgcSqFaXRoG6E/c7YRRRvx6lvfEk808s45YuvGBOnrSL2KOsceR2reGCcmKANC7woPcOei/QP98T+Nts9Tq0XOZ+0IxaLpW09cz/FTA3FmbjI9vLr6Fs00ssXVMKBBW9xXWOajpEpw==
X-Gm-Message-State: AOJu0YzroxUvm0nnZGYPB1/9hEyb+fVTSO4KAHU+VxgWMaQL0twvwJc+
	/s/L62MpC08DpRZMm6GlYEEfHKuqPH79mP4zhdvYnzt5S7kUVMuU+iYJPl/ydlE=
X-Google-Smtp-Source: AGHT+IF19/bTSLmocLvHDNnbKFhlGwux/gbwAyZC0eU4UfCDTw3v32QFG8iLu+fAymtIhkqZwx6Fxg==
X-Received: by 2002:a2e:819a:0:b0:2d6:a11f:b4b2 with SMTP id e26-20020a2e819a000000b002d6a11fb4b2mr2996588ljg.25.1711645642712;
        Thu, 28 Mar 2024 10:07:22 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id bk5-20020a170907360500b00a46b4c09670sm942429ejc.131.2024.03.28.10.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 10:07:22 -0700 (PDT)
Message-ID: <f0f985b272af85aea912479ced50ff52f29506b1.camel@gmail.com>
Subject: Re: [PATCH v4 0/6] iio: temperature: ltc2983: small improvements
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org,  devicetree@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Jyoti Bhayana
 <jbhayana@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 18:07:21 +0100
In-Reply-To: <20240328165650.1d8d4216@jic23-huawei>
References: <20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com>
	 <20240328165650.1d8d4216@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-28 at 16:56 +0000, Jonathan Cameron wrote:
> On Thu, 28 Mar 2024 17:22:00 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > The v4 introduces an new dev_errp_probe() helper to deal with cases
> > where we want to return error pointers. The refactor in the IIO ltc2983
> > is an heavy user of the pattern and was the main motivation for this.
> >=20
> > Also added two new patches so we have three users of the new
> > dev_errp_probe() helper.=20
>=20
> Probably better to do this as 2 series. The other ltc2983 changes in one =
series
> and one with a cover letter title that will get noticed by
> those who care about dev_printk helpers.
>=20

That makes sense, yes.

- Nuno S=C3=A1

> From a quick look the content of the patches is fine.
>=20
> Jonathan
>=20
> >=20
> > ---
> > Changes in v4:
> > - Link to v3:
> > https://lore.kernel.org/r/20240301-ltc2983-misc-improv-v3-0-c09516ac0ef=
c@analog.com
> > - Patch 1
> > =C2=A0* New patch
> > - Patch 2
> > =C2=A0* Use dev_errp_probe() instead of local variant
> > - Patch 5
> > =C2=A0* New patch
> > - Patch 6
> > =C2=A0* New patch
> >=20
> > ---
> > Nuno Sa (6):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk: add new dev_errp_probe() helper
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: temperature: ltc2983: convert to de=
v_err_probe()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: iio: temperature: ltc2983: =
document power supply
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: temperature: ltc2983: support vdd r=
egulator
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: backend: make use dev_errp_probe()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: common: scmi_iio: convert to dev_er=
r_probe()
> >=20
> > =C2=A0.../bindings/iio/temperature/adi,ltc2983.yaml=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> > =C2=A0drivers/iio/common/scmi_sensors/scmi_iio.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 45 ++--
> > =C2=A0drivers/iio/industrialio-backend.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 8 +-
> > =C2=A0drivers/iio/temperature/ltc2983.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
260 ++++++++++-----------
> > =C2=A0include/linux/dev_printk.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
> > =C2=A05 files changed, 151 insertions(+), 171 deletions(-)
> > ---
> > base-commit: 27eea4778db8268cd6dc80a5b853c599bd3099f1
> > change-id: 20240227-ltc2983-misc-improv-d9c4a3819b1f
> > --
> >=20
> > Thanks!
> > - Nuno S=C3=A1
> >=20
> >=20
>=20


