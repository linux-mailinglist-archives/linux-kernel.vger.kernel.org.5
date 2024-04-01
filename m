Return-Path: <linux-kernel+bounces-126461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C834893853
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9835B20FD4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1859454;
	Mon,  1 Apr 2024 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AV5u/VTT"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561038F51;
	Mon,  1 Apr 2024 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711952463; cv=none; b=No6DpMZGw0PTg0rQQgPwyL9Ujdtj4az6M7bUlfFiwXjUnfqn59y2YTDfDA8iNSvvXKTS0BUooZh+LeXjuaptpGDXhuNe99kywwvrV46zTdtq6sfcA5PrHZPSWyjxIk5+esvzQp44boweiTc702qzDAM72z0FNdZB+slyfDe2Yn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711952463; c=relaxed/simple;
	bh=Lf2dD3nRXEM3QKLcinOUWGrZNiSWMEAx6xFjKwZTZuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Unz5nQdftBROxN6QED9JnyIp85lCOsC3x2mGAcGHHyaYD3DwqX+5dexMVNEZO/QtLX0r7ScnR5NDH7FeVmHT/gB+WhkhZRM+bYEUb6dGjK1fCO7dKWdRjo+iZ9AvN8vXHGeCyqaKaayMAOp7VnDRzolYSnr/cfK5YP2mWkQ0zQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AV5u/VTT; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7cc77e74b5cso175448239f.2;
        Sun, 31 Mar 2024 23:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711952461; x=1712557261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMMohnAWMK6m3tG9gNhC20ZEygwyJguxL99B9xnGWG8=;
        b=AV5u/VTTWJYcGIO3YwSyLj1AmfLeIQHcSePw9JK0F57Eorjp/XW5t9AP30djqEZ+UV
         AG0sYnkkcD1iLRP/JSgHE2h1cMHWlmYWN1o2Fg4bB2lCBapiZfzz+5Wztmx/l3h7CFcc
         u2eS6VI+yKDeckF/u1Ekm/u755SlTA7ZYuTuf83qNtKeaDCwEEOUVsxmIH1YI2A1ak5I
         PEAYxcpq6xBQbAkKyJ2tiRH89ywRwpNEWveZgqxNrqei9QIwjIFK27Nsfmq96zeH3E5P
         wvewsFOMraFQSWbvlQXj7Gz1mBRyAakknOwvo12cHbUyl0Q0H0QBE7EZcnElKh07oWYP
         PljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711952461; x=1712557261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMMohnAWMK6m3tG9gNhC20ZEygwyJguxL99B9xnGWG8=;
        b=MTDxLaA2EVZy5e5bcSb+T5UJbR5ei4WaLNWG4DcqW7PmPyY5dwuBB4OS4fiQYhnYNy
         Qz27vIjvxcz+HRQoQiAJaSPR71Zl99sxPM5c88JDT+MEIKUA1/r1Wf0yTu+b+v+8GicR
         n4iJgYWidTwWsFHdGPV4WVmU6x4gFFC8GkGjV3wrSLJgN54Fnr+pF5BZhD8CwF0DuKZr
         WiFcl87AYO8ziu75AsCJ9QAeddzJw50YVARh7Ac/NQEPH0UthmTaNuhIUbC3oFMxhuLJ
         verNUzTGvnxJ82mYcBGRA49ChG1yc9ux4O0REHlP67k4Ng3rgaoMoHunI5ZdG6Rv4cQb
         2zxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUny0raQFzsM8ZIcau0rbJ12NOPOlT/DXpnUGh6SEd33FoWbDwxWFad54ANBnocbRokdQu/Q7qZ9lPqxNCywDKf3lWZEklheWUcQDN5M2zE6rBCv+ATtTW+ynf1SnGAhPkFbDzB0N+UUJrJlqSY8BJPaWCLR0LiVN7rrGw/Fa/qevY+qkSwONUYoRONr0/sD51bTWK3gBUDPruedupwxPh1
X-Gm-Message-State: AOJu0YytMbKv/InyIrF31TqP71yzcGSLXH5Z3LtBonfqyczc0QHdP4pp
	ZIthghVLvzVdDBZ0qPHjVzjN5ssyvwXvpYy6dMr6SGnzlY1ihzCci1VQwvQasavrcome6ZxVEsj
	m3ynYfkgBYeTUA36LUdIGDG1WNYc=
X-Google-Smtp-Source: AGHT+IGqrP3UbKuIe1tD2jwC4HaMuI/kdKXkvDhRJ+AWyQfCT0kCIFRqJPOXLpW67XqZ5jBlSE9DEP3cTjA6OoqADbE=
X-Received: by 2002:a5d:8986:0:b0:7cf:1c5c:681e with SMTP id
 m6-20020a5d8986000000b007cf1c5c681emr10205960iol.17.1711952461453; Sun, 31
 Mar 2024 23:21:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322081158.4106326-1-kcfeng0@nuvoton.com> <20240322081158.4106326-2-kcfeng0@nuvoton.com>
 <171109961635.307786.7810067768607811171.robh@kernel.org> <22fcad13-dd9b-4e9a-90aa-d20fb78e6a0d@roeck-us.net>
 <e1102a00-0c94-4d35-8de2-1173ee417bdc@linaro.org>
In-Reply-To: <e1102a00-0c94-4d35-8de2-1173ee417bdc@linaro.org>
From: Ban Feng <baneric926@gmail.com>
Date: Mon, 1 Apr 2024 14:20:50 +0800
Message-ID: <CALz278ZdvJhtDhBaKMg_nP+sS0HQVvAjidKAGkeqG8Cu4ftb+Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add NCT7363Y documentation
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, linux-hwmon@vger.kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, conor+dt@kernel.org, 
	corbet@lwn.net, jdelvare@suse.com, kwliu@nuvoton.com, kcfeng0@nuvoton.com, 
	Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Bonnie_Lo@wiwynn.com, linux-doc@vger.kernel.org, 
	DELPHINE_CHIU@wiwynn.com, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thanks for your support.

Best regards,
Ban

On Tue, Mar 26, 2024 at 2:29=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/03/2024 18:09, Guenter Roeck wrote:
> > On 3/22/24 02:26, Rob Herring wrote:
> >>
> >> On Fri, 22 Mar 2024 16:11:57 +0800, baneric926@gmail.com wrote:
> >>> From: Ban Feng <kcfeng0@nuvoton.com>
> >>>
> >>> Add bindings for the Nuvoton NCT7363Y Fan Controller
> >>>
> >>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> >>> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> >>> ---
> >>>   .../bindings/hwmon/nuvoton,nct7363.yaml       | 66 ++++++++++++++++=
+++
> >>>   MAINTAINERS                                   |  6 ++
> >>>   2 files changed, 72 insertions(+)
> >>>   create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,=
nct7363.yaml
> >>>
> >>
> >> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_che=
ck'
> >> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >>
> >> yamllint warnings/errors:
> >>
> >> dtschema/dtc warnings/errors:
> >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/binding=
s/hwmon/nuvoton,nct7363.yaml:
> >> Error in referenced schema matching $id: http://devicetree.org/schemas=
/hwmon/fan-common.yaml
> >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/binding=
s/hwmon/nuvoton,nct7363.example.dtb: hwmon@22: fan-0: False schema does not=
 allow {'pwms': [[1, 0, 50000]], 'tach-ch': ['']}
> >>      from schema $id: http://devicetree.org/schemas/hwmon/nuvoton,nct7=
363.yaml#
> >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/binding=
s/hwmon/nuvoton,nct7363.example.dtb: hwmon@22: fan-0: Unevaluated propertie=
s are not allowed ('pwms', 'tach-ch' were unexpected)
> >>      from schema $id: http://devicetree.org/schemas/hwmon/nuvoton,nct7=
363.yaml#
> >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/binding=
s/hwmon/nuvoton,nct7363.example.dtb: hwmon@22: fan-1: False schema does not=
 allow {'pwms': [[1, 1, 50000]], 'tach-ch': b'\x01'}
> >>      from schema $id: http://devicetree.org/schemas/hwmon/nuvoton,nct7=
363.yaml#
> >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/binding=
s/hwmon/nuvoton,nct7363.example.dtb: hwmon@22: fan-1: Unevaluated propertie=
s are not allowed ('pwms', 'tach-ch' were unexpected)
> >>      from schema $id: http://devicetree.org/schemas/hwmon/nuvoton,nct7=
363.yaml#
> >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/binding=
s/hwmon/nuvoton,nct7363.example.dtb: fan-1: tach-ch: b'\x01' is not of type=
 'object', 'array', 'boolean', 'null'
> >>      from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> >>
> >> doc reference errors (make refcheckdocs):
> >>
> >> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202=
40322081158.4106326-2-kcfeng0@nuvoton.com
> >>
> >> The base for the series is generally the latest rc1. A different depen=
dency
> >> should be noted in *this* patch.
> >>
> >> If you already ran 'make dt_binding_check' and didn't see the above
> >> error(s), then make sure 'yamllint' is installed and dt-schema is up t=
o
> >> date:
> >>
> >> pip3 install dtschema --upgrade
> >>
> >> Please check and re-submit after running the above command yourself. N=
ote
> >> that DT_SCHEMA_FILES can be set to your schema file to speed up checki=
ng
> >> your schema. However, it must be unset to test all examples with your =
schema.
> >>
> >
> > I am a bit puzzled by this one. The patch has a Reviewed-by: tag from R=
ob,
> > but then Rob's bot complains about errors. hat am I missing ?
>
> The warning is a result of missing fan-common.yaml in the tree used as a
> base.
>
> I checked now and I don't see warnings on next or v6.9-rc1, so it is
> safe for you to apply it.
>
> For the record:
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>

