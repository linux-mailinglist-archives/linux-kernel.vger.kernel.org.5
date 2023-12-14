Return-Path: <linux-kernel+bounces-54-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5310E813B54
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC862819DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F306A324;
	Thu, 14 Dec 2023 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO7HT/kz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF56A021;
	Thu, 14 Dec 2023 20:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C24C433B9;
	Thu, 14 Dec 2023 20:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702584798;
	bh=DE5oZHxnY2FnfLLm9CrhQ8lZCYG3nLE1BorF38WzfFU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jO7HT/kzC/0e5zyKvEwCgBKNFSmhYNZle6KooVc59NDXQjgb6obiFUHPgs1uAvAwy
	 ZXJDNqAUwphT0pfOMqJ5eJc0veFLExwNXzexEdgyieZZ+n7IJMgqFRNxSA/DwRG3d6
	 9kGZzpRtlXzpcPVJHI35wuNkkBUl0qS3UsQO2FPvLm91jrODGUs4/7l7bHTQkJj4Qh
	 QuvhvmXGu1EdenVwO+q1Dz6wmqlmY6aAXXi0pxaD5stWd/rnUYpRai9ywnm3YDcBoH
	 88J4pxvCl4JHz/VHDmT2RnJX3stj7KpK3Ip5xxNpOY2HDyjSSv0lIU84UAvQA7lYFl
	 dO9yozw8KXuJg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50c02628291so9176102e87.0;
        Thu, 14 Dec 2023 12:13:18 -0800 (PST)
X-Gm-Message-State: AOJu0YyDGdIhxQYTGdNwHf5a9XQm9Vnud9OpEbbE6rqyDVAQLPdHkxoM
	UiBuS+D9Q/qRoMQ0ksBQ5z6Cjw0f3O4ZTApV8Q==
X-Google-Smtp-Source: AGHT+IHDKZo8Iz9evcWsSlbRyWsjf9ZmHonlKRtMaMEtFTEvbkKWDgkxQU9xVlEHJQrHQKr9MJyv9JPsWzfEzSGK/Wg=
X-Received: by 2002:a05:6512:2019:b0:50b:d764:8046 with SMTP id
 a25-20020a056512201900b0050bd7648046mr4254179lfb.121.1702584796440; Thu, 14
 Dec 2023 12:13:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212164004.1683589-1-ninad@linux.ibm.com> <20231212164004.1683589-3-ninad@linux.ibm.com>
 <20231212-amusement-elevation-28e42bcccc35@spud> <d8b5df1c-c732-4cf3-ae28-cc2017d3b0b6@linux.ibm.com>
 <20231214-stopper-bounce-ca9002869293@spud>
In-Reply-To: <20231214-stopper-bounce-ca9002869293@spud>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 14 Dec 2023 14:13:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJCbRREnUyKkvkutyWP2GYK2ZqzfC1TS1pwQ=4xY_1J5w@mail.gmail.com>
Message-ID: <CAL_JsqJCbRREnUyKkvkutyWP2GYK2ZqzfC1TS1pwQ=4xY_1J5w@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] dt-bindings: tpm: Add schema for TIS I2C devices
To: Conor Dooley <conor@kernel.org>
Cc: Ninad Palsule <ninad@linux.ibm.com>, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org, 
	tony.luck@intel.com, gpiccoli@igalia.com, johannes.holland@infineon.com, 
	linux@roeck-us.net, broonie@kernel.org, patrick.rudolph@9elements.com, 
	vincent@vtremblay.dev, peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com, 
	bhelgaas@google.com, naresh.solanki@9elements.com, 
	alexander.stein@ew.tq-group.com, festevam@denx.de, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-hardening@vger.kernel.org, geissonator@yahoo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 10:35=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Thu, Dec 14, 2023 at 09:34:39AM -0600, Ninad Palsule wrote:
> > Hello Conor,
> >
> > On 12/12/23 11:14, Conor Dooley wrote:
> > > Hey,
> > >
> > > On Tue, Dec 12, 2023 at 10:39:58AM -0600, Ninad Palsule wrote:
> > > > From: Johannes Holland <johannes.holland@infineon.com>
> > > >
> > > > Add a dt schema to support device tree bindings
> > > "Add bindings for..."
> > Fixed.
> > >
> > > > for the generic I2C
> > > > physical layer. Refer to the TCG PC Client Platform TPM Profile (PT=
P)
> > > > Specification for TPM 2.0 v1.04 Revision 14.
> > > >
> > > > This includes descriptions for the Nuvoton and Infineon devices.
> > > >
> > > > OpenBMC-Staging-Count: 3
> > > I have no idea what this is, but it needs to be removed from the patc=
h.
> > Removed.
> > >
> > > > Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> > > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > > Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> > > > ---
> > > >   .../bindings/security/tpm/tpm-tis-i2c.yaml    | 50 ++++++++++++++=
+++++
> > > >   1 file changed, 50 insertions(+)
> > > >   create mode 100644 Documentation/devicetree/bindings/security/tpm=
/tpm-tis-i2c.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis=
-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> > > > new file mode 100644
> > > > index 000000000000..de1e34065748
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.ya=
ml
> > > > @@ -0,0 +1,50 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: I2C PTP based TPM Devices
> > > > +
> > > > +maintainers:
> > > > +  - Johannes Holland <johannes.holland@infineon.com>
> > > > +
> > > > +description:
> > > > +  Device Tree Bindings for I2C based Trusted Platform Module (TPM)=
.
> > > s/Device Tree Bindings for //. Doesn't dt_binding_check now complain =
if
> > > you have this in a title or description?
> > Fixed.
> > >
> > > > +properties:
> > > > +  $nodename:
> > > > +    pattern: "^tpm(@[0-9a-f]+)?$"
> > > > +
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - description: Infineon's Trusted Platform Module (TPM) (SLB=
9673).
> > > > +        items:
> > > > +          - const: infineon,slb9673
> > > > +          - const: tcg,tpm-tis-i2c
> > > > +      - description: Nuvoton's Trusted Platform Module (TPM) (NPCT=
75x).
> > > > +        items:
> > > > +          - const: nuvoton,npct75x
> > > > +          - const: tcg,tpm-tis-i2c
>
> Also, another thought - the bus is not usually encoded in the compatible
> string, so it would be good to remove that.

True, but we already have 3 different bus variants in this case. So
that ship has sailed.

Rob

