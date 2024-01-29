Return-Path: <linux-kernel+bounces-42300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DD483FF4D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5936C282F54
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB2851C37;
	Mon, 29 Jan 2024 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXy1dHJN"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0743E4F21F;
	Mon, 29 Jan 2024 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514747; cv=none; b=Qe3lW6Aj2ShkPN6Hs5fKY0xyWLc3qjWP3C5GOWrLXBlKwws332oLoDgeWCsllitozwzAGy9VYU05g2LLfK4EhWuWTwowVXWMyQP4Q6GCgtH1zdI71VYvI90JHVTn+2A1FwAsvaN4Et3rE5wOPyEbhVhIlMBRVkIMnWjes26KQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514747; c=relaxed/simple;
	bh=pwcgZHTKUrBHMyq34U7FHOUbnpLeMk1V/mq9JGQayb0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fPxtFIJTdXvH90yvjhG/D6+DvNHgsn9wGpoU5ji9HufV+kTPgamiRaJNd7c8gDRNfS4VGgcJcfD/+xdAdPXluUGTJ3jtoqd1MR49Jk3/WfAovM3oMnchIeCxVqqrrGcjVs8oSnowDQ/SycJdazaTddbWXIPja1NcLrnkQ/4/wng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXy1dHJN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3510d79ae9so227839766b.0;
        Sun, 28 Jan 2024 23:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706514744; x=1707119544; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pwcgZHTKUrBHMyq34U7FHOUbnpLeMk1V/mq9JGQayb0=;
        b=kXy1dHJNzrdHnvjUyvhesU36czmyrctH6d9hpHBB5YeudP1lzPXYBlLvsqpc1yUwpm
         i2rCaMTC7xlQmxEAHWEbD+pBFfKSFYGWEfl0O6U701FYbN/Ari6T5sfHjj0tOzfn7j3M
         8TtGvp7Nv7AM8kGfo1O8VuSVplW1SKFqwI0OREgr1Fg8JI4ygGghFHd8pKS+VtDsdQwf
         E5MM1NafXUrXFniqhaDhUz2JszfiqlcqDzkS/NCjDBZjEmTMyofJiUoKxCrAPGRt9OCF
         1ACIjePlPVX/9deB9F1NICr3nAKOZpR/Zoq+pIKoBOykxrXwiMnMqMuCoDG1aszzQldt
         IBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706514744; x=1707119544;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pwcgZHTKUrBHMyq34U7FHOUbnpLeMk1V/mq9JGQayb0=;
        b=rUDydyffgEONFai4wNpzxjNUj5frwnDj9Cyld7Uc7wRYyV9zukYeGgJSbYYjcMBz+C
         WfyG2f0gqEfiPfxt/lkqvhStom8x4NIUqh8G7XNMbqIoEcZLqfqZAaKgYZA/h36/sLgr
         Ite9asVWsTU7qVDOT0lZ4SNuLbdnjPK/LWQYlCJfi2+FrcmWOFcuSspYFi57L2Al78TH
         Ths9wD73e8yMuujaWqAzWRpEkRDdRXdx1vLFhojp75/Yz6tFl2Ztto05SrXHzHIGUmb1
         /fxsjQYCd07yYwR5u92dWkxEp8cCetQkPWp3s6hSlqX45hHfdHp0mzqfnFtqs1y62Z6i
         v16A==
X-Gm-Message-State: AOJu0YwIHFBz/T3PWBQ5/6x0pfQFz/1KykYQAuz2dFn4ZdMcKjtx9SjL
	MghFYKaiB7u+Z9jVfHzbo9NQ2CHl7CIXCiZUog6A/CPczY+dUcoN
X-Google-Smtp-Source: AGHT+IGe2Xb4m5k2Ojysw6hg1OnJCFDfbQ9jmsgb0PA154Ax0tq/GjsyywhwJcluG79bj6PCz0b8kg==
X-Received: by 2002:a17:906:f6d0:b0:a35:6a40:b4cf with SMTP id jo16-20020a170906f6d000b00a356a40b4cfmr2721797ejb.19.1706514743859;
        Sun, 28 Jan 2024 23:52:23 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906660c00b00a35b06fa7d0sm964940ejp.18.2024.01.28.23.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 23:52:23 -0800 (PST)
Message-ID: <84827fd6461c9650443608e33afe9eb011793656.camel@gmail.com>
Subject: Re: [PATCH v5 0/2] drivers: rtc: add max313xx series rtc driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 "a.zummo@towertech.it" <a.zummo@towertech.it>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "jdelvare@suse.com" <jdelvare@suse.com>,  "linux@roeck-us.net"
 <linux@roeck-us.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>
Cc: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-hwmon@vger.kernel.org"
	 <linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>
Date: Mon, 29 Jan 2024 08:55:40 +0100
In-Reply-To: <170c8d6b-3246-493f-8cd9-6ac580cabc28@alliedtelesis.co.nz>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
	 <147c92f9-b42b-4a51-a6f9-2d90bfe63aa0@alliedtelesis.co.nz>
	 <1b42866bb6f05b7d68e9b8304e42359fccdf2bad.camel@gmail.com>
	 <170c8d6b-3246-493f-8cd9-6ac580cabc28@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-29 at 03:28 +0000, Chris Packham wrote:
>=20
> On 26/01/24 20:51, Nuno S=C3=A1 wrote:
> > On Fri, 2024-01-26 at 02:22 +0000, Chris Packham wrote:
> > > Hi All,
> > >=20
> > > On 4/04/23 03:43, Ibrahim Tilki wrote:
> > > > changelog:
> > > > since v5:
> > > > =C2=A0=C2=A0=C2=A0 - dt-binding: add enum value "2" to aux-voltage-=
chargable
> > > > =C2=A0=C2=A0=C2=A0 - dt-binding: remove adi,trickle-diode-enable
> > > > =C2=A0=C2=A0=C2=A0 - dt-binding: change description of trickle-resi=
stor-ohms
> > > > =C2=A0=C2=A0=C2=A0 - dt-binding: reorder as in example schema
> > > > =C2=A0=C2=A0=C2=A0 - parse "wakeup-source" when irq not requested
> > > > =C2=A0=C2=A0=C2=A0 - remove limitation on max31328 irq and clokout
> > > > =C2=A0=C2=A0=C2=A0 - remove error and warning messages during trick=
le charger setup
> > > >=20
> > > > since v4:
> > > > =C2=A0=C2=A0=C2=A0 - dt-binding: remove interrupt names.
> > > > =C2=A0=C2=A0=C2=A0 - dt-binding: add description for "interrupts" p=
roperty
> > > > =C2=A0=C2=A0=C2=A0 - dt-binding: replace deprecated property "trick=
le-diode-disable"
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 by "aux-voltage-chargeab=
le"
> > > > =C2=A0=C2=A0=C2=A0 - dt-binding: add new property "adi,trickle-diod=
e-enable"
> > > > =C2=A0=C2=A0=C2=A0 - dt-binding: remove "wakeup-source"
> > > > =C2=A0=C2=A0=C2=A0 - use clear_bit instead of __clear_bit
> > > > =C2=A0=C2=A0=C2=A0 - use devm_of_clk_add_hw_provider instead of of_=
clk_add_provider
> > > > =C2=A0=C2=A0=C2=A0 - use chip_desc pointer as driver data instead o=
f enum.
> > > >=20
> > > > since v3:
> > > > =C2=A0=C2=A0=C2=A0 - add "break" to fix warning: unannotated fall-t=
hrough
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Reported-by: kernel test robot <lkp@=
intel.com>
> > > >=20
> > > > since v2:
> > > > =C2=A0=C2=A0=C2=A0 - dt-binding: update title and description
> > > > =C2=A0=C2=A0=C2=A0 - dt-binding: remove last example
> > > > =C2=A0=C2=A0=C2=A0 - drop watchdog support
> > > > =C2=A0=C2=A0=C2=A0 - support reading 12Hr format instead of forcing=
 24hr at probe time
> > > > =C2=A0=C2=A0=C2=A0 - use "tm_year % 100" instead of range check
> > > > =C2=A0=C2=A0=C2=A0 - refactor max313xx_init for readability
> > > >=20
> > > > Ibrahim Tilki (2):
> > > > =C2=A0=C2=A0=C2=A0 drivers: rtc: add max313xx series rtc driver
> > > > =C2=A0=C2=A0=C2=A0 dt-bindings: rtc: add max313xx RTCs
> > > >=20
> > > > =C2=A0=C2=A0 .../devicetree/bindings/rtc/adi,max313xx.yaml |=C2=A0 =
144 +++
> > > > =C2=A0=C2=A0 drivers/rtc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 11 +
> > > > =C2=A0=C2=A0 drivers/rtc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> > > > =C2=A0=C2=A0 drivers/rtc/rtc-max313xx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1053
> > > > +++++++++++++++++
> > > > =C2=A0=C2=A0 4 files changed, 1209 insertions(+)
> > > > =C2=A0=C2=A0 create mode 100644
> > > > Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> > > > =C2=A0=C2=A0 create mode 100644 drivers/rtc/rtc-max313xx.c
> > > What happened to this series in the end? It kind of went off my radar
> > > and I forgot about it.
> > >=20
> > > We've been carrying a version of these changes in our local tree for =
a
> > > while (and using it quite happily I should add).
> > >=20
> > Hi Chris,
> >=20
> > Also not sure.... In the meantime Ibrahim left ADI so if this is not in
> > shape to
> > be merged he won't be able to re-spin. If there's a need for a re-spin,
> > please
> > let me know so I can see internally if there's someone who can continue=
 this
> > work. I would do it myself if I had the HW.
> I've got a board with a max31331 so I can test that. I don't have any of=
=20
> the interrupts hooked up so I won't be able to test that. Looks like=20
> there was some outstanding discussion around the trickle-charge=20
> devicetree properties so I'd need to figure out what was wanted there.=
=20
> I'll try to pick up the last series from the mailing list and go from the=
re.

Thanks Chris!

- Nuno S=C3=A1

