Return-Path: <linux-kernel+bounces-16427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9948B823E54
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1039AB255B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BD1208B4;
	Thu,  4 Jan 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzzb0GUw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883CF208AD;
	Thu,  4 Jan 2024 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6dbfe3fe308so153868a34.1;
        Thu, 04 Jan 2024 01:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704359424; x=1704964224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CE7ZVwfqCf4qvRKSBIMzsEL7hrDljgpGVgOv+qGGIiA=;
        b=lzzb0GUwf1Ehrm45WAAtcFK2SBOi/3p0dbAyLrQGy50UAWO796I9FK2RWdMNeJY5yH
         sX2DnWnWVssO88F0De4yNQFL1GxE5esA3t31gOJTvJmtNrQLsiumdJ+1eh28250fiNgW
         TFZxqS5gMu1MExe1rRYMBRbV4KNfuKcrMseV6y6WeHeTw/WetGsFTZvX92WCQriaFPlM
         Pfja7eWQsSVXFApQjTLU6e8XKgYa1SfhVXMY5BOjPSUSMbs8egYxuUZZnsbTz+CJOESc
         QtKBl8gHWC8nIcvU+NOgmK2ZoO8WeNqwRhvmAvEOEBdxpizIpG+8cSlNs2DklXiIfZLz
         4x5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704359424; x=1704964224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE7ZVwfqCf4qvRKSBIMzsEL7hrDljgpGVgOv+qGGIiA=;
        b=vsxMKdwYn/EaV6wgC7xAebeNUpph8+hmNk69tAHIakZp7uDLLEZtL0xdJmWdAgPZtQ
         w83JG23syM5lHjSuW4rElVul0Jc7YrYZHD4VWJANS/uzGxpKM90YYC2cLD96ZbufWeO8
         yWx4alHavs69tuo+xAYkfl4OiJTW/xLTpw140hljdq3ju89rkmT85J9nsbzq2efxuY8q
         WhUSb/2t1kFYHLWWAePE+6QfwTgeQOCax5eguBd+3NKnkRKI6L/qYdKfoXCxZ+PaDQf0
         QRkH0AOA1FBaII0K0D1Kk++zkuv6cgdyab+NQxLdLU/is/f5kFDs+UmXvd3LL0Rlb8/y
         H4LQ==
X-Gm-Message-State: AOJu0YzFBglRofKakMllJNSCdZ6B+FnXndiDfaoN62YvEtXOY9Jw3s0B
	bk7yucs5mHFpIfJWPRdkIcsWC3nymKis9lEFdnParAV8gfA=
X-Google-Smtp-Source: AGHT+IHaWSQ6dab/i9XxEgE12EvITOybHXfLxz+hdbS4qbMFLz9rWg02ON6uM9VH9nsyc1dIVX4yMVK5kZpwX/ysRPg=
X-Received: by 2002:a05:6871:8014:b0:204:2eb4:2c98 with SMTP id
 sk20-20020a056871801400b002042eb42c98mr263125oab.30.1704359424510; Thu, 04
 Jan 2024 01:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229085156.1490233-1-chunyan.zhang@unisoc.com>
 <20231229085156.1490233-2-chunyan.zhang@unisoc.com> <3a290bf9-928d-4d21-9c93-0d1db59d6fff@linaro.org>
In-Reply-To: <3a290bf9-928d-4d21-9c93-0d1db59d6fff@linaro.org>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 4 Jan 2024 17:09:47 +0800
Message-ID: <CAAfSe-stvoKSVynTnoy87CUK3NM+ZEwfTMazO0tfwcx5BXG0Og@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: clk: sprd: Add UMS9620 support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 4 Jan 2024 at 16:46, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/12/2023 09:51, Chunyan Zhang wrote:
> > Add UMS9620's clock compatible strings and descriptions for clock
> > and clock-names for UMS9620.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  .../bindings/clock/sprd,ums512-clk.yaml       | 79 ++++++++++++++++---
> >  1 file changed, 68 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> > index 43d2b6c31357..dcad41a1fea7 100644
> > --- a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> > +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> > @@ -30,25 +30,38 @@ properties:
> >        - sprd,ums512-mm-clk
> >        - sprd,ums512-mm-gate-clk
> >        - sprd,ums512-apapb-gate
> > +      - sprd,ums9620-pmu-gate
> > +      - sprd,ums9620-g1-pll
> > +      - sprd,ums9620-g5l-pll
> > +      - sprd,ums9620-g5r-pll
> > +      - sprd,ums9620-g8-pll
> > +      - sprd,ums9620-g9-pll
> > +      - sprd,ums9620-g10-pll
> > +      - sprd,ums9620-apapb-gate
> > +      - sprd,ums9620-ap-clk
> > +      - sprd,ums9620-apahb-gate
> > +      - sprd,ums9620-aon-gate
> > +      - sprd,ums9620-aonapb-clk
> > +      - sprd,ums9620-topdvfs-clk
> > +      - sprd,ums9620-ipaapb-gate
> > +      - sprd,ums9620-ipa-clk
> > +      - sprd,ums9620-ipaglb-gate
> > +      - sprd,ums9620-ipadispc-gate
> > +      - sprd,ums9620-pcieapb-gate
> > +      - sprd,ums9620-pcie-clk
> > +      - sprd,ums9620-mm-gate
> > +      - sprd,ums9620-mm-clk
> > +      - sprd,ums9620-dpu-vsp-gate
> > +      - sprd,ums9620-dpu-vsp-clk
> >
> >    "#clock-cells":
> >      const: 1
> >
> >    clocks:
> > -    minItems: 1
> > -    maxItems: 4
>
> No, constraints stay here.
>
> >      description: |
> >        The input parent clock(s) phandle for the clock, only list
> >        fixed clocks which are declared in devicetree.
> >
> > -  clock-names:
>
> No, you cannot just drop properties. Widest constraints stay here.
>
> > -    minItems: 1
> > -    items:
> > -      - const: ext-26m
> > -      - const: ext-32k
> > -      - const: ext-4m
> > -      - const: rco-100m
> > -
> >    reg:
> >      maxItems: 1
> >
> > @@ -57,7 +70,43 @@ required:
> >    - '#clock-cells'
> >    - reg
> >
> > -additionalProperties: false
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            pattern: "^sprd,ums512-.*"
> > +
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 1
> > +          maxItems: 4
> > +
> > +        clock-names:
> > +          minItems: 1
> > +          items:
> > +            - const: ext-26m
> > +            - const: ext-32k
> > +            - const: ext-4m
> > +            - const: rco-100m
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            pattern: "^sprd,ums9620-.*"
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 1
> > +          maxItems: 6
> > +
> > +        clock-names:
> > +          minItems: 1
> > +          maxItems: 6
>
> Missing names.

The names are fixed, but the order are not.

For example:
clk_a {
    clocks = <&ext_26m>, <&ext_32k>;
    clock-names = "ext-26m", "ext-32k";
};

clk_b {
    clocks = <&ext_26m>, <&ext_4m>;
    clock-names = "ext-26m", "ext-4m";
};

How to list the names for this kind of case? (Please forgive me for
being lazy, didn't find a similar case after a fast search)

Thanks,
Chunyan

