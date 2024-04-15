Return-Path: <linux-kernel+bounces-145082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2188A4F53
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334D9283E15
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C996F520;
	Mon, 15 Apr 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvBotyMI"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B73F66B5E;
	Mon, 15 Apr 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184941; cv=none; b=cBW9WrMfPJPdNchFjMHCjUgOagA0g51JvsdPwGYTB0zOmJwvPMMyNC5oM87xL4FDzzQ+zEJFzfzkprfVV9IrBnbDcAgRrvhVDpGw0jSoM9g13SfiXl44UYlJKl33JnCEpVTfZKE/0Wwr8cRxmtY4nYGIFn632+EQoyd2QFLhW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184941; c=relaxed/simple;
	bh=sXylBYaSW/BDvQPnqfB0OHpOC30ZESgqCoGyPH7MMq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eSqWcHN6s71Be763J0HLh0iqxUpJxTz1H31JphKE8Bn0JLQOgjw42LAkD9mN+m0Og/oBjzMGjPItSikYFkJ1s/aTLNz/1isGsU172fKE5+r2D5cUkSbBSCHF/0QFpprV5Qck2aCKZIslskBIedkPsc8f41KuKNkJ3KI1CkU7k3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvBotyMI; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so3385565a12.3;
        Mon, 15 Apr 2024 05:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713184938; x=1713789738; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sXylBYaSW/BDvQPnqfB0OHpOC30ZESgqCoGyPH7MMq0=;
        b=PvBotyMI5wqjPyIZyWanSaibngruEpc+V3w/HoU8/vF50wrk4eAyqmrsL39rQ9nxOK
         Jy166WLPE2ZDCuqyVs72YderVvr2yWdhbzEA/NtQM+CtdXXvY6hgRpyNbqSnS7NqMNJA
         f+MYfX6GdrTG3OxeIAtPr0VJ0UJ/AWZah2U+vh8uu40Dw17iOnQSs7yqHh+flr/0fFfZ
         pScQYdFdFRZxQc+Zd/pQ0brpxPZbRKMBp3o3Nhy8YAGi7E+zM1/Z9PH8AW8rmoQN32xg
         h5C+9UrvrtCOnz0WyfPCQetYRelI5vHyDGYaF4ymNwZUtm/NNpnKz22KqAlPNyOtpJ82
         1gQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713184938; x=1713789738;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sXylBYaSW/BDvQPnqfB0OHpOC30ZESgqCoGyPH7MMq0=;
        b=V095fI98ba5kMDMwlyHfFCHEY3UnrB5lLSy6/MIPy7+is9ebgyKC0TRj7s4sC3cfK2
         rJROEzyKpzDiFJzIrUvtIPm2L0Ou+Z6YNaw2gHZLU9OBAWqbouTyBjWhjAW/S49MPtf5
         /0QCdl+N6NrvVhH83g9VHJNvWb/wYp971QGbqAo7rT7vwghz4L9D/C2f/qlto3CBs0Iz
         KSwh/fH0V+J0pWIGKhR2t8VdyarImAJopgUCJl7qkQfGl/wnjWou+IjUmwXnV698eGV6
         s3qy03ehTPiWowejyB91jz+dl/XGFllQmbnDTzEEVVh0jgdSx/Km5ojCLkGZo+2gEY/t
         PRvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSZNFrinT15M7yibYSQVodB84aTMA6xwyckRoOZ40jdawTr5nmQlEZ8JrN+7DP4aAyxMc9BmC/0fiUgwziWQbL9YNI25gON7grxTyNbSv9dNDKddCJQCsVVuz2v8DT3IK5InsJvlcQAOBd+jHlfwU6//DoS0U5CfKR0LkUvFqd4Go+VQ==
X-Gm-Message-State: AOJu0YyfBg0mlKSsQdPjxEaZ5c0X0u+TH9rdt8gDJm6+QdA84OFRErpl
	56/FgDIU87OOhf/fQz2xUw7aypkRvJnQAhxqTDEZXhSvDdwbpK0y
X-Google-Smtp-Source: AGHT+IGzRcXhZcYEmuMILO2oU7FX3lfUDPciNavouyA0BQlqX1Hl3byVK7BhzsRccYlUwLxfuaFLtA==
X-Received: by 2002:a17:906:c78d:b0:a51:ae39:d385 with SMTP id cw13-20020a170906c78d00b00a51ae39d385mr5755005ejb.1.1713184938379;
        Mon, 15 Apr 2024 05:42:18 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090640c800b00a51a34eba63sm5401690ejk.85.2024.04.15.05.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:42:18 -0700 (PDT)
Message-ID: <79734a9f54e320cd09aab83015f1c0e6d93e700c.camel@gmail.com>
Subject: Re: [PATCH 2/4] iio: ABI: add ABI file for the LTC2664 DAC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>
Date: Mon, 15 Apr 2024 14:45:52 +0200
In-Reply-To: <20240413162517.4644b649@jic23-huawei>
References: <20240412032102.136071-1-kimseer.paller@analog.com>
	 <20240412032102.136071-3-kimseer.paller@analog.com>
	 <CAMknhBE9XihK27pRhyPwTNM3VQX=osYdDyCmjNspz1aqe_NVTw@mail.gmail.com>
	 <20240413162517.4644b649@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-13 at 16:25 +0100, Jonathan Cameron wrote:
> On Fri, 12 Apr 2024 16:26:17 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > On Thu, Apr 11, 2024 at 10:21=E2=80=AFPM Kim Seer Paller
> > <kimseer.paller@analog.com> wrote:
> > >=20
> > > Define the sysfs interface for toggle capable channels.
> > >=20
> > > Toggle enabled channels will have:
> > >=20
> > > =C2=A0* out_voltageY_toggle_en=C2=A0=20
> The big missing thing in this ABI is a reference to existing precedence.
> You aren't actually defining anything new, it just hasn't yet been genera=
lized
> beyond 1 device (unless you include PSK / FSK DDS drivers that are 'still=
'
> after
> 13+ years in staging!)
>=20
> This patch needs to be generalizing that documentation from the ltc2688.
>=20
> Probably in sysfs-bus-iio-dac
>=20
> >=20
> > It looks like there are 3 toggle modes.
> >=20
> > Two involve the notion of "enabled" outputs that I assume this attribut=
e is
> > for:
> >=20
> > 1. Toggling all enabled pins at the same time using a software trigger
> > (global toggle bit)
> > 2. Toggling all enabled pins at the same time using a hardware trigger
> > (TGP pin) and toggling pins
> >=20
>=20
> This is presumably the tricky one as that hardware toggle may not be in
> control of the host CPU.
>=20
> > The third mode though looks like it uses the same toggle select
> > register for selecting A or B for each channel instead of enabling or
> > disabling each channel.
> >=20
> > 3. Toggling all pins to A or B based on the toggle select register. No
> > notion of enabled pins here.
> >=20
> > I haven't looked at the driver implementation, but it sounds like
> > out_voltageY_toggle_en and out_voltageY_symbol would be writing to the
> > same register in conflicting ways. So maybe we need yet another custom
> > attribute to select the currently active toggle mode?
>=20
> This one feels like it could be handled as a software optimisation over
> just changing the DAC value directly.

Things may be slightly different in these devices. But for ltc2688 and AFAI=
R,
the symbol attribute is about toggling between A and B through SW (not real=
ly
enabling the mode). That interface will only pop up if there's no HW (PWM f=
or
example) toggle present.

>=20
> >=20
> > In any case, it would be helpful if the documentation below explained
> > a bit better the intention and conditions required to use each
> > attribute (or add a .rst documentation file for these chips to explain
> > how to use it in more detail since this is rather complex feature).
> >=20
> > > =C2=A0* out_voltageY_raw0
> > > =C2=A0* out_voltageY_raw1=C2=A0=20
> >=20
> > I guess there is no enum iio_modifier that fits this. It seems like we
> > could still have out_voltageY_raw for register A so that users that
> > don't need to do any toggling can use standard ABI. And maybe
> > out_voltageY_raw_toggled for register B (question for Jonathan)?
>=20
> There is precedence for doing it like this (ltc2688)
> Note that we should only see these attribute for changes specifically
> configured for 'hardware' triggered toggling.
>=20
> Note that we cannot have duplicate documentation so we need to create
> a common docs file covering this and existing ltc2688 ABI that overlaps.
> That may need some generalising to cover both parts.
>=20
> >=20
> > Or just have 8 channels instead of 4 where even channels are register
> > A and odd channels are register B?
> >=20
> > > =C2=A0* out_voltageY_symbol=C2=A0=20
> >=20
> > "symbol" is a confusing name. It sounds like this just supports
> > toggling one channel individually so _toggle_select would make more
> > sense to me. Are there plans for supporting toggling multiple channels
> > at the same time using a software trigger as well?
>=20
> Again, precedence should have been called out.=C2=A0 It's not great ABI
> but it corresponds to earlier work on Frequency Shift Keying DDS devices
> (and I think Phase Shift Keying as well) in which this is call symbol.
> Hence the name.
>=20
> >=20
> > >=20
> > > The common interface present in all channels is:
> > >=20
> > > =C2=A0* out_voltageY_raw (not present in toggle enabled channels)=C2=
=A0=20
> >=20
> > As mentioned above, I don't think we need to have to make a
> > distinction between toggle enabled channels and not enabled channels.
>=20
> Was a while back but I think that last time this turned up we concluded
> we did need a different interface because the current 'toggle value'
> is not in our control.=C2=A0 Hence you are programming one channel that
> does different things - think of it as setting the Max and Min values
> for a generated waveform - perhaps the toggle pin is connected to a PWM
> for example.
>=20

Yeah and for the ltc2688 we also had the dither mode that has it's own uniq=
ue
set of interfaces. Trying to deal with it all at runtime could be more conf=
using
than beneficial I guess.

- Nuno S=C3=A1
>=20

