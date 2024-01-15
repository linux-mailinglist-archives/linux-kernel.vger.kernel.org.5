Return-Path: <linux-kernel+bounces-26283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF96D82DE0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100121C21917
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5E117C6A;
	Mon, 15 Jan 2024 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SIee+ekm"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B0818026
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-337984681bcso2631485f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705337847; x=1705942647; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=waVYuEFLr5NkCXBear1JEDXoIU+PxE6RY0fZ5JBOvHA=;
        b=SIee+ekm3vVU2462jO6uNkGCDHNEqXSv3XpQW5tSm5dCsoYBPy9gdNiyRxBEWMWuNS
         zVYJIph28cRm0G+ZdWpJV2P1nRyBIHwV0xrzkal5h1A2qfYZ5Uw6SC3r1Ld31tNp5hOx
         HYkdp/zHri/iUr9+2EZm0uTyRksrVmUeo1esauFfwBsoJdhBdVv7Vr6D8PE1oQix2Pwu
         1+7evc2HMmlR8j9e7PW7ill1UO64LCkdO+h+8SkLRvumsLBz+H5DHTvy85wmljQ0yDHE
         3pYMWxwB+ihWvlQWRZhq2YMSYH1VhCAv6aZ2LyoClNU7FXQ8UvawLMDBduU876Oq5quS
         lDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705337847; x=1705942647;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=waVYuEFLr5NkCXBear1JEDXoIU+PxE6RY0fZ5JBOvHA=;
        b=u1h61lS4sKMZLOk+HkT8wwzTDbvuiEye7pUy+H3CY8fZcoo+TsdDLfzih1Mwz59DPH
         35ouxbxyMyFsM/kQ86FKygvLgHxE9qu5q3Tcnju06DRi6khqj5qobG5+0qRdAYNr1FhN
         eMmVbh2sMvIL6VrMh6k21AzP+h480cSbbXVfm3ErbieW1Z1KcxNefadDHNks0Cj40QaZ
         1M7UNM1rEzCfszPhk75POpm/m7T0ldubOb84e5ABiBlzb5JywWwzMgLqux0pHnrb5Xz0
         1DjA/Qx+CFkMxjwmOOtdGKdVVRrJsTEUTr4lThM+4ZgX12Z9NCm+A7M2ByV8UA9l9bKj
         VM0w==
X-Gm-Message-State: AOJu0Yz6OvFiunn3sssDJkxj7sELlIuPJ1G41Rod1l60YNp0bP0ra0IJ
	LFjAia6wAQ1tL9jYPzp7zmD6ubrKAEI0CQ==
X-Google-Smtp-Source: AGHT+IGJF4gfnTFJEoZMfWW23QAZxJVZtUmkEUC/Xhcn+u8GzSWGIbVWoxWpuD5KVZfUv/M7SFYI3g==
X-Received: by 2002:a5d:4b8b:0:b0:336:779b:97a1 with SMTP id b11-20020a5d4b8b000000b00336779b97a1mr2818092wrt.74.1705337847642;
        Mon, 15 Jan 2024 08:57:27 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id dr3-20020a5d5f83000000b00336ca349bdesm12447947wrb.47.2024.01.15.08.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:57:27 -0800 (PST)
Message-ID: <8c5afb4e52e0c5a6dd88f6b7eaa7bc2e97ba31ad.camel@linaro.org>
Subject: Re: [PATCH] dt-bindings: ignore paths outside kernel for
 DT_SCHEMA_FILES
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Michal Simek <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
  devicetree@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>
Date: Mon, 15 Jan 2024 16:57:26 +0000
In-Reply-To: <ffd6f60e-fea9-4426-a981-badd3c68cd4d@amd.com>
References: <20231220145537.2163811-1-andre.draszik@linaro.org>
	 <170432630603.2042234.10993333941885772911.robh@kernel.org>
	 <827695c3-bb33-4a86-8586-2c7323530398@amd.com>
	 <bcd89ef7a43eb7d652f045c029d8e108adf7ba32.camel@linaro.org>
	 <20240115-fragment-clean-95ef01dd8b20@spud>
	 <ffd6f60e-fea9-4426-a981-badd3c68cd4d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-15 at 17:37 +0100, Michal Simek wrote:
>=20
>=20
> On 1/15/24 17:29, Conor Dooley wrote:
> > On Mon, Jan 15, 2024 at 09:40:37AM +0000, Andr=C3=A9 Draszik wrote:
> > > Hi,
> > >=20
> > > On Mon, 2024-01-15 at 10:20 +0100, Michal Simek wrote:
> > > > This patch is causing issue for me. Look at log below.
> > > > I am running it directly on the latest linux-next/master.
> > > >=20
> > > > Thanks,
> > > > Michal
> > > >=20
> > > > $ make DT_SCHEMA_FILES=3D"Documentation/devicetree/bindings/arm/arm=
,cci-400.yaml"
> > > > dt_binding_check
> > >=20
> > > It'll work if you drop the 'Documentation/devicetree/bindings' part f=
rom the path, as
> > > it is implied since bindings can only be in that directory anyway:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 make DT_SCHEMA_FILES=3D"arm/arm,cci-400.yaml=
" dt_binding_check
> > > =C2=A0=C2=A0=C2=A0=C2=A0 make DT_SCHEMA_FILES=3D"arm,cci-400.yaml" dt=
_binding_check
> > >=20
> > > both work.
> >=20
> > Requiring that is pretty user unfriendly though I think, passing the
> > full path from the root directory of the kernel tree would be my
> > assumption of the "default".
>=20
> I am using full path like this for years.

I just just went by Documentation/devicetree/bindings/writing-schema.rst
which doesn't suggest adding Documentation/devicetree/bindings/. In an
attempt to make it more robust for anybody following this doc, I opted
for the current implementation.

> I can fix my scripts but would be good to consider correct path inside th=
e=20
> kernel is something what this patch should also allow.
> Because path above is correct and it is not outside of the kernel that's =
why at=20
> least commit message should be massage a little bit.

I hear you, and I'll make a v2 to not imply the bindings directory.



Cheers,
A.


