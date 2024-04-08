Return-Path: <linux-kernel+bounces-134986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6709D89B99E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B85AB20D13
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF202C695;
	Mon,  8 Apr 2024 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS3bDvFl"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742AA1E52F;
	Mon,  8 Apr 2024 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563316; cv=none; b=m1zhC5SumayBVJCc6xWimODQbvFu5BkHarxegFf9z1ukAQUKLuo2aQvlpdwoDTsqm3W2MuwDdM7PcYesOjUWBGtK6dN4cfz5NwIB4aVjIhMTO7Y9WPUSeF9+tHkGIhfwawQ36JN36il/ZZeIC2zm4hwmzRGhPbdgyv44XyKDD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563316; c=relaxed/simple;
	bh=TiFOgc2oAgSwbqK688qnJnLQqSOcAVNWdpjOqSnMCVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jz/KMBINr9UaN1x5Oc9TaM2aT3SrxuGoQbflTiX5bMjnGwvJuJ06ukkIr4dEgO1DPcLY+YxPa7h2AEEHjfnqR2Ht/HO7Y1tLSbxYSQDI95f4cPC//auK577ZKeBsE166mzrj4BDYrUdxMwFHj9/W7fMLtq1MKgdVD9GV9Q29lzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GS3bDvFl; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36a23d5c31bso3525045ab.2;
        Mon, 08 Apr 2024 01:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712563313; x=1713168113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDxZaL1eNz/pYsN2HsEFyRR/2Zct5H5ENMhocXCfR6w=;
        b=GS3bDvFlzi4HZ5FgYEVlIN10Z1p5OUmi1GzqX4J3QV4V/vbFLNs5ixGu6vIkPw29u6
         1dZ2l+bjpfUrIX9b1ifuoAs1HCIEJK2ozuRjG5EIPufiVtzRZSE5LYVbbWK5Be2rtACX
         cr0l60/E/wMZTmCyL9I88xjYu9aGNcZUK9xkspCUnS/zOR9D2TXhSUiFL6AzSj8DN7Pa
         ku28TDTBpmtj7FOYUvz+u3AmgDK6dEPiG5y1Jh7NMfgkxI+PfJsK9Uysk2752Fmh+x+t
         BC7VL7lkxP461S+piQLDeRtC63HVGYFbyuCpmuXeYApU3qatLuCHOomVv1oVSalcEe/n
         gJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712563313; x=1713168113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDxZaL1eNz/pYsN2HsEFyRR/2Zct5H5ENMhocXCfR6w=;
        b=P6PbN2iWnvYw6c9/NBnVIDJ1qGxsiosG/2ZgM5PhGYlzCnQm3npJuybm4vmSSh8IG2
         OMgExeuzLodo5JzJhiNTAhpEqAIRfIgAY/I5RyP2zcT91zVFesZZJMdxKquRShUx1Xb4
         V2FSF58T9VWBQglGytGXEWs8IfheMfyI6S5sOjiTzCy75/y5R12+IsFuwGE+/yMiNaJr
         RLCMsUFGTbeZ7F/a+VVMfZ6pbZOUVGUARuiUdNC2YKTx4J4XtMMTGe/B/0YR/aABI8zx
         5KDvCa7eEFfR5TNJtrDdK5WC6g0oC91Bw03SC7SzW5e9/nyzObpQWYY0OiW48c47FSX9
         kFug==
X-Forwarded-Encrypted: i=1; AJvYcCWfR2WSSRXxaLaRdKZjojO22bQwc1gp5L7f4JyTKaE+0vs86IzCefgYZAcuWmBmxXVTQ6oDuFtc0ZAA3RRCgIyl9sqmK+MMcOC7zmsLocSBYersMUNWGXj6o60xso5fUCfsuwcDZoL3RlXvlvgrbChXxtmY44FJ4JAdbhXlm+p+YQX2GH+H
X-Gm-Message-State: AOJu0YxLVdtH9CXXoMzXgk6rDrRG2fN7nGdm0NvnrxX2onDUR6WgIipj
	Lv0rXp73jhn+bzK/eS4oJ5IW6TEB2k9P0nYes2sWcCYmlMQVzToZE5nh0Vvf/HzltSNQcejnZq5
	4EfGsgjm0cvlJb+tshYgG7FUBw7zSjAZlpBvJtQ==
X-Google-Smtp-Source: AGHT+IGmitR2sfI1XGgs4E3RjDYYX2R9JX0br64X+lHpxBgQOLGozFRPqRUTMIqDQViAk6dxwQiaWeeYM9obmjpPAn0=
X-Received: by 2002:a05:6e02:15c7:b0:368:7e1e:7e00 with SMTP id
 q7-20020a056e0215c700b003687e1e7e00mr9956372ilu.7.1712563313596; Mon, 08 Apr
 2024 01:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1712561233-27250-1-git-send-email-shengjiu.wang@nxp.com> <01734d96-bed2-4f7e-bbba-7068f14c822b@linaro.org>
In-Reply-To: <01734d96-bed2-4f7e-bbba-7068f14c822b@linaro.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 8 Apr 2024 16:01:42 +0800
Message-ID: <CAA+D8ANiKH7Oc+KAjD_BMp9P2EVeM8Q6dLGFCC8a83bJXUpPEA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: imx-audio-spdif: convert to YAML
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com, broonie@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 3:55=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/04/2024 09:27, Shengjiu Wang wrote:
> > Convert the imx-audio-spdif binding to YAML.
> >
> > When testing dtbs_check, found below compatible strings
> > are not listed in document:
> >
> > fsl,imx-sabreauto-spdif
> > fsl,imx6sx-sdb-spdif
> >
> > So add them in yaml file to pass the test.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> > changes in v2:
> > - change file name to imx-spdif.yaml
>
> How does your compatible look like? fsl,imx-audio-spdif, so use that.

Oh, it seems I misunderstood your meaning. you think the name should
be the same as compatible string...

>
> > - remove |
> > - add anyof for spdif-in and spdif-out requirement
> > - change example name to sound
> >
>
> > diff --git a/Documentation/devicetree/bindings/sound/imx-spdif.yaml b/D=
ocumentation/devicetree/bindings/sound/imx-spdif.yaml
> > new file mode 100644
> > index 000000000000..beb214b51a50
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/imx-spdif.yaml
> > @@ -0,0 +1,70 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/imx-spdif.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale i.MX audio complex with S/PDIF transceiver
> > +
> > +maintainers:
> > +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - fsl,imx-audio-spdif> +          - enum:
> > +              - fsl,imx-sabreauto-spdif
> > +              - fsl,imx6sx-sdb-spdif
>
> This does not make much sense. You have mixed fallback with specific
> compatible. I suggest you to fix your DTS and submit proper bindings.

ok.

>
> > +      - enum:
> > +          - fsl,imx-audio-spdif
> > +
> > +  model:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: User specified audio sound card name
> > +
> > +  spdif-controller:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of the i.MX S/PDIF controller
> > +
> > +  spdif-out:
> > +    type: boolean
> > +    description:
> > +      If present, the transmitting function of S/PDIF will be enabled,
> > +      indicating there's a physical S/PDIF out connector or jack on th=
e
> > +      board or it's connecting to some other IP block, such as an HDMI
> > +      encoder or display-controller.
> > +
> > +  spdif-in:
> > +    type: boolean
> > +    description:
> > +      If present, the receiving function of S/PDIF will be enabled,
> > +      indicating there is a physical S/PDIF in connector/jack on the b=
oard.
> > +
> > +required:
> > +  - compatible
> > +  - model
> > +  - spdif-controller
> > +
> > +anyOf:
> > +  - required:
> > +      - spdif-in
> > +  - required:
> > +      - spdif-out
> > +  - required:
> > +      - spdif-out
> > +      - spdif-in
>
> Do you need the last required block?

Yes,  one of them or both are required.

>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    sound {
>
> That's a random change...
>
> Instead of sending two patches per day, please carefully address the
> feedback.

In v1 you suggest to change it to spdif?  but spdif may conflict
with the fsl,spdif.yaml.   so which name I should use?

best regards
wang shengjiu
>
> > +        compatible =3D "fsl,imx-audio-spdif";
> > +        model =3D "imx-spdif";
> > +        spdif-controller =3D <&spdif>;
> > +        spdif-out;
> > +        spdif-in;
> > +    };
>
> Best regards,
> Krzysztof
>

