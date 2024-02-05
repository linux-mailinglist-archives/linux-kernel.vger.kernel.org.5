Return-Path: <linux-kernel+bounces-52345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562CA8496F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD111C22647
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D04512E63;
	Mon,  5 Feb 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijych1Jb"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3092134A6;
	Mon,  5 Feb 2024 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126660; cv=none; b=iDxumTJ3j4oaAf0QYHhwiu5Pt1Dj7FdvJr1/WjjZJo5FDSk2I8scmhedD0MwaHzKQ47N7M+TuoNTyKnVAAJLxfdtalhpXLGOhF6SisUXcbiTYGFAsTJV9j+DCrro0LpYYeve2ilfaVP7XSpv3hvy4xLHreYh9QhUS8cs28c3264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126660; c=relaxed/simple;
	bh=CwrlIDMCEpWP0ZZehh8dEbpGIAchQCe6K4ZWhtbf6cM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fN4eTi6Nl6wr1Lw92sQkJtvq8KD1OXEwBZX8skz4KCNXr5rxv/IDOG9uiUdSW/S74tZT+If4XftIE/FIPnj21xBhmlga5QhIz0OU6GnKggMopvX92tgHa1x93exR+DiLoKEb4oA6UGJSVvQDW6kWQZL5eNUGlCeMmj+97Y5o9vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijych1Jb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40ef64d8955so38418915e9.3;
        Mon, 05 Feb 2024 01:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707126657; x=1707731457; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CwrlIDMCEpWP0ZZehh8dEbpGIAchQCe6K4ZWhtbf6cM=;
        b=ijych1JbCH/AvmOZlRrJr4PbQUigXjtSr98xkWFNhrvgVlxo3uo2rA350gLnZxfPbi
         ACHrL42nyQDWlsFvrLKp3NHlb5jk8B5wLQLRJw5IBBWTcFoaM8nVmw5YF+W+kXO5S4OX
         FFS++Uc3+7mOO3BkZeU8cKMkWpT5ydG2XNhUoteSpXsOgRv3FG5fBHKBvBZEADg3cPFi
         OEeZB/B6cDLXs71oR4JA6sk33uj0NmwjLG9GljEETO4xX1it4ptLIpmp73e3G0sTLd+w
         tSdMVYbGXgXiOyS85zLwSCsaS81swijjqCbkhyR472nsOhyFaF8IYurVYgxsMTFOIdLE
         e6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126657; x=1707731457;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CwrlIDMCEpWP0ZZehh8dEbpGIAchQCe6K4ZWhtbf6cM=;
        b=sSMaYP/KMkgPxsleaqLZv0M5rofWI9dewr62Xrf5OLRxry0wJwbsiEQJzI+x14e/Cb
         OwFl7OL1XejypKaiHNhiq87WD1N3ZzBthq0yyR1VsG1vI1OZN25uiD7qbhLGQqI/3Csl
         kuGSjJjA67/zoQokmkJiMgeCMnha7Vw8r930XUnCj3H9Q0bE6r+dN1CQ1ZurWz3SnvIA
         jRQCX4T8luRF3p4lRXNuLeOFZj7dRZKBfWN/O58hXwuTB6n+wjkaP3jD6W+EukpQegI7
         LHQd+C1ycB4TIT/kjDlTyQeO7PfO24N4YX+ItMCTHsjjtg+Ns089AsDcOGaq9GD9dLAU
         OTtA==
X-Gm-Message-State: AOJu0YzBoH7LGQyUxeI8D7BkhV2cNldU6ih4p/3Is5ccuOweJN/hBhPw
	DoP5ujoiYhTVgk653LYxKb0r8DzOpubWC8KIjC2MUJJza/ZG2JZ0
X-Google-Smtp-Source: AGHT+IE58VI1i2AZCZyBk4GtGu0jrv3ltSwUgr2InXPyKyXC7ufzmeUrkWQiug7b9IqRUScsFzwuMQ==
X-Received: by 2002:a05:600c:3109:b0:40f:44b5:1135 with SMTP id g9-20020a05600c310900b0040f44b51135mr4707137wmo.16.1707126656849;
        Mon, 05 Feb 2024 01:50:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUjB4M70lydv7DZ2wRUuVr9p6PWcGHesTGdrBm97W+nLnzO+Zz85D118U+zu0RsJ9NIwFaGBI+4j+5G7uJcDpgviQFHDZunPuwLGzccMQ6ZSjquPFf/K+ex9MzRFIf+A9Q26xy0YEWAvoLLHBGJp7Z7PXIcuXoUcc7+EX6feJjDtmkxuobfCNvNNPqvc8Ex6P8n8bVGpt8gZ3q37n8O0HzwrhAPb9buz+VY504rpz9+M2IRO0IaaDwcEFMgROlhuDkZFuGUPM0o8LLqJuRDKG/OT8Rn2fBcOj5CK18e/ZceAYwCA+Eeo7Ij9MscpAHa9ibj+xzeRh6C1L9JiS6dy7kZVcBZ1Am6tDJ8XWO1hkAOl0UyCsHwjSGMZkUcObYtdk7Qjej50ZQNWMiXyVmHZ8wSYqg7XhzOfbHvnz4Sz3HaBn8TzYoBLw6UtK/xuRDd/jBE0xegOA==
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05600c3d9200b0040fdd407fe5sm1138894wmb.16.2024.02.05.01.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:50:56 -0800 (PST)
Message-ID: <b319f01721fba04cb91d4bc61db69894d0e9a0c9.camel@gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: ad7192: Add properties
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, David Lechner
	 <dlechner@baylibre.com>, Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Michael Hennerich
 <michael.hennerich@analog.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Alexandru Tachici
 <alexandru.tachici@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Ceclan Dumitru <dumitru.ceclan@analog.com>
Date: Mon, 05 Feb 2024 10:50:55 +0100
In-Reply-To: <5bc2bd1e-16a8-4de4-bec6-9391addacc89@linaro.org>
References: <20231114200533.137995-1-alisa.roman@analog.com>
	 <20231114200533.137995-2-alisa.roman@analog.com>
	 <c6ca5a25-2d41-4a46-95a5-eb994c4cf529@linaro.org>
	 <09cc2ecb-b73f-495a-9196-dbb4899f4c85@gmail.com>
	 <CAMknhBFhr=qTd=nioq_m=icZZUfYWSq8Moy4A4RssvbcNoLNQg@mail.gmail.com>
	 <5bc2bd1e-16a8-4de4-bec6-9391addacc89@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-05 at 10:28 +0100, Krzysztof Kozlowski wrote:
> On 02/02/2024 23:20, David Lechner wrote:
> > > >=20
> > > > And this should be input clock.
> > > >=20
> > > > > +=C2=A0=C2=A0=C2=A0 type: boolean
> > > > > +
> > > > > +=C2=A0 adi,int-clock-output-enable:
> > > > > +=C2=A0=C2=A0=C2=A0 description: |
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Internal 4.92 MHz clock available=
 on MCLK2 pin.
> > > > > +=C2=A0=C2=A0=C2=A0 type: boolean
> > > >=20
> > > > This should be clock-cells and clock provider.
> > > >=20
> > > > Unless you are just documenting already used interface which you do=
 not
> > > > want to break...
> >=20
> > This property is already used in the mainline Linux driver, so sounds
> > like the "don't want to break it" case. But it would make sense to
> > deprecate this property and use standard clock provider bindings
> > instead.
>=20
> One could think like that, but what type of process would it create?
> Send driver changes WITHOUT binding, then document whatever crap you
> have saying "Linux already supports it!".
>=20
> Whenever such argument is used, I am repeating the same.
>=20
> Let's be more clear: NAK if this is clock provider and the only argument
> is that someone sneaked undocumented interface bypassing review.
>=20

Fair enough...=C2=A0

Alisa,

I guess you have two alternatives then:

1) Drop this patch;
2) Add proper clock provider properties.

I would obviously go with 2). You can then take care of backward compatibil=
ity in the
driver. Like, if clock-cells is present, ignore the legacy properties and p=
roperly
export the clocks we have in the device.

- Nuno S=C3=A1

