Return-Path: <linux-kernel+bounces-16441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99324823E9F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241701F212FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C526208C2;
	Thu,  4 Jan 2024 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3H7TDO1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016D208A3;
	Thu,  4 Jan 2024 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-20503dc09adso164813fac.2;
        Thu, 04 Jan 2024 01:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704360416; x=1704965216; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0h9kuRScT9kVsqYAA3c2uC8aUqD/cJ0p7vFJyFynoIg=;
        b=M3H7TDO1NKw4HN0Wq6sc9ctGezvZTu1w0g2jnbaSUoq3B5c1I1t6B1zPDWXwx1xBT4
         sC43d+c5/vqZQBxQywQW8ApZatJCEIGfFaRmy3EnMgOCkKEVbOZFtKW5HvabAEhmRyO3
         PPWckrXT9ByJ+UTa3p/eU/6yO+CCuX833jkftN2iTLbVkTNIZ26iEsU8zwad8P/OuDd1
         tuXCuTckX2b5CPbqDA2OJ5z45wCavL2HFVByAsGRSc+hzgjOkGiGhKMCNb7v4y+6uWSH
         KtHT3UMPIuGYLdBHH9wORiUXEIb+UdaM0mIn5g6/+/xU+BPglHL13fPiA4+27FblFrpf
         rhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704360416; x=1704965216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0h9kuRScT9kVsqYAA3c2uC8aUqD/cJ0p7vFJyFynoIg=;
        b=X3+W0VYiYYXmEUHiI+lUZxKOyTR21dnCEU1ej6iHcic4oQx7hiMg8I09K6BGD0JjQG
         ly52duy/KncQ7gLapd+CMjgGaJmJ9KiWYKJRne/j0jGJh7ON7aeWRSwd35F3dGAciUF4
         sxb/xsWgrcQL/NsIktIeaLudnghDJtdZ6osfRjAqZXT7QYyweC4Qh/ApTVgnBIaJW4aB
         lUiO3ETqjmVGoDQ8d+OJ+aWFwtO/sy/b7DpFxQtdUFP8nHccdwkTGIN+jwG8DJFpsj4x
         GYKDL5BX9ab5bhc0LAWY4RYqcMHgbxjUToaL9VgOnTFyyNLebnjckO+3LLX5cubepf70
         r9lw==
X-Gm-Message-State: AOJu0Yx/I6pd/XXO4PMFweMwhW4uiJAklUOHvz5CU8rVrYmtWGNEVtRs
	Q57HmdJqkx5GX7L5BhuJ1e+rspwlu+MHkR9luyfnKSKR7sg=
X-Google-Smtp-Source: AGHT+IGPkMV23w0ByjANtZKNOicFbKv6lm+/y40yTKTtQuNKEB4yZIfFSLdxw3FQ5JOkAFhJxuueS7zQNMzdERIj2rs=
X-Received: by 2002:a05:6871:a583:b0:203:a48b:6ad4 with SMTP id
 wd3-20020a056871a58300b00203a48b6ad4mr335903oab.93.1704360415997; Thu, 04 Jan
 2024 01:26:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229085156.1490233-1-chunyan.zhang@unisoc.com>
 <20231229085156.1490233-2-chunyan.zhang@unisoc.com> <3a290bf9-928d-4d21-9c93-0d1db59d6fff@linaro.org>
 <CAAfSe-stvoKSVynTnoy87CUK3NM+ZEwfTMazO0tfwcx5BXG0Og@mail.gmail.com> <b8fdce9e-50d9-4b43-a018-c35350bcec0f@linaro.org>
In-Reply-To: <b8fdce9e-50d9-4b43-a018-c35350bcec0f@linaro.org>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 4 Jan 2024 17:26:19 +0800
Message-ID: <CAAfSe-vRLaCZca2anp7iBnHDPUr-oVexSVy7PKYhNDUZ8GGgaw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: clk: sprd: Add UMS9620 support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 17:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/01/2024 10:09, Chunyan Zhang wrote:
> > Hi Krzysztof,
> >
> > On Thu, 4 Jan 2024 at 16:46, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 29/12/2023 09:51, Chunyan Zhang wrote:
> >>> Add UMS9620's clock compatible strings and descriptions for clock
> >>> and clock-names for UMS9620.
> >>>
> >>> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >>> ---
> >>>  .../bindings/clock/sprd,ums512-clk.yaml       | 79 ++++++++++++++++---
> >>>  1 file changed, 68 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> >>> index 43d2b6c31357..dcad41a1fea7 100644
> >>> --- a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> >>> +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> >>> @@ -30,25 +30,38 @@ properties:
> >>>        - sprd,ums512-mm-clk
> >>>        - sprd,ums512-mm-gate-clk
> >>>        - sprd,ums512-apapb-gate
> >>> +      - sprd,ums9620-pmu-gate
> >>> +      - sprd,ums9620-g1-pll
> >>> +      - sprd,ums9620-g5l-pll
> >>> +      - sprd,ums9620-g5r-pll
> >>> +      - sprd,ums9620-g8-pll
> >>> +      - sprd,ums9620-g9-pll
> >>> +      - sprd,ums9620-g10-pll
> >>> +      - sprd,ums9620-apapb-gate
> >>> +      - sprd,ums9620-ap-clk
> >>> +      - sprd,ums9620-apahb-gate
> >>> +      - sprd,ums9620-aon-gate
> >>> +      - sprd,ums9620-aonapb-clk
> >>> +      - sprd,ums9620-topdvfs-clk
> >>> +      - sprd,ums9620-ipaapb-gate
> >>> +      - sprd,ums9620-ipa-clk
> >>> +      - sprd,ums9620-ipaglb-gate
> >>> +      - sprd,ums9620-ipadispc-gate
> >>> +      - sprd,ums9620-pcieapb-gate
> >>> +      - sprd,ums9620-pcie-clk
> >>> +      - sprd,ums9620-mm-gate
> >>> +      - sprd,ums9620-mm-clk
> >>> +      - sprd,ums9620-dpu-vsp-gate
> >>> +      - sprd,ums9620-dpu-vsp-clk
> >>>
> >>>    "#clock-cells":
> >>>      const: 1
> >>>
> >>>    clocks:
> >>> -    minItems: 1
> >>> -    maxItems: 4
> >>
> >> No, constraints stay here.
> >>
> >>>      description: |
> >>>        The input parent clock(s) phandle for the clock, only list
> >>>        fixed clocks which are declared in devicetree.
> >>>
> >>> -  clock-names:
> >>
> >> No, you cannot just drop properties. Widest constraints stay here.
> >>
> >>> -    minItems: 1
> >>> -    items:
> >>> -      - const: ext-26m
> >>> -      - const: ext-32k
> >>> -      - const: ext-4m
> >>> -      - const: rco-100m
> >>> -
> >>>    reg:
> >>>      maxItems: 1
> >>>
> >>> @@ -57,7 +70,43 @@ required:
> >>>    - '#clock-cells'
> >>>    - reg
> >>>
> >>> -additionalProperties: false
> >>> +allOf:
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            pattern: "^sprd,ums512-.*"
> >>> +
> >>> +    then:
> >>> +      properties:
> >>> +        clocks:
> >>> +          minItems: 1
> >>> +          maxItems: 4
> >>> +
> >>> +        clock-names:
> >>> +          minItems: 1
> >>> +          items:
> >>> +            - const: ext-26m
> >>> +            - const: ext-32k
> >>> +            - const: ext-4m
> >>> +            - const: rco-100m
> >>> +
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            pattern: "^sprd,ums9620-.*"
> >>> +    then:
> >>> +      properties:
> >>> +        clocks:
> >>> +          minItems: 1
> >>> +          maxItems: 6
> >>> +
> >>> +        clock-names:
> >>> +          minItems: 1
> >>> +          maxItems: 6
> >>
> >> Missing names.
> >
> > The names are fixed, but the order are not.
>
> Order must be fixed.
>
> >
> > For example:
> > clk_a {
> >     clocks = <&ext_26m>, <&ext_32k>;
> >     clock-names = "ext-26m", "ext-32k";
> > };
> >
> > clk_b {
> >     clocks = <&ext_26m>, <&ext_4m>;
> >     clock-names = "ext-26m", "ext-4m";
>
> And here the order is fixed...

The order is not fixed, 'clk_b' will cause dtb_check error, since it
skips the second one i.e. ext-32k in the clock-names list.

>
> > };
> >
> > How to list the names for this kind of case? (Please forgive me for
> > being lazy, didn't find a similar case after a fast search)
>
> The same ums512 lists them or mentioned other bindings. You somehow cut
> the quote...
>
> Best regards,
> Krzysztof
>

