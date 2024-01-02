Return-Path: <linux-kernel+bounces-13986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77723821686
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A47B212C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1CC10EC;
	Tue,  2 Jan 2024 02:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krfe4pHj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F005BEC0;
	Tue,  2 Jan 2024 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so505534e87.0;
        Mon, 01 Jan 2024 18:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704163006; x=1704767806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZgJ/hO0BMuiFsKeH5YQSYQg6eAF+eBUJTKBunwuY4w=;
        b=krfe4pHjnnk3NP8USotYLpIoQSJkvh1wvJ1VKmRAUHCLPEaOb/c1LuGwuoU1zISRUl
         rOyjEyCWh8jZya0d7eqnTDlHjgXnn0xvwylj6c8x28pZAeu5dTQKG5liGppT5L8M+AfT
         k0KUlnRezaq/mTO9FW98fsu73Nr4pN/O1Drbt0fuBncXBUvYFUoXU7sNxebbhfy2P/rc
         ddeKEovMHhRrUnv6rfRlgj21g447Ax8Emj1jD2+IT4CrnYchlWB02lokqNqwDbq84iFv
         Ybc9+isv3bDID5ju5l6mxiYiGiDC8bj+HPkludcFRe+V5DhYZWc5V8dHsNvZs7WUiRSy
         RiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704163006; x=1704767806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZgJ/hO0BMuiFsKeH5YQSYQg6eAF+eBUJTKBunwuY4w=;
        b=XWf3a08kWKzjXINZQHNgQ+FTG7BubGzvmvSXn2EO1DcpW31C7pPswbSjHr3nYQ6OLG
         8J++SSQcPCZZs5Si3RpHlg/l5HHOuW+6V5XLkW0Cx3B9lYv4JeEwFoO+7oannqFTMGaQ
         uuYcrH3NlMbUQxQVkg5qry8xZBKmNdnSc6ISHbrGqyJmTLd3DjmtGhV9f3xI+hSjcN00
         XVa8s24CP8PlR29VePjIZZHkYpWm8K3cYYKcxFkOyw2Omy4zFpMaD5geIdVALZUJL7na
         WSXEy6T0puL+bRkdJloBkYIEOZA8mRJC6gj/iNcAd7bTQYNeRLj9daLLOKAMbEeYo84g
         oTOQ==
X-Gm-Message-State: AOJu0Yxjtp0+hvNbT03luC59pRIiqjHRNZFiRRtljibkoEkGW+FqTEwb
	iiODW7Tt7lcCY2zNOQUaXijZpznw1nHrguxJzzo=
X-Google-Smtp-Source: AGHT+IFQWwkDdfr7Zg4c6GAHGBte5cyFLdsroKWwL5kjddtoMkmRM7PTWR7k2nJpGsIf2S1vn9VuCo5fc468ckbX/CM=
X-Received: by 2002:a05:6512:3d29:b0:50e:8ecf:4100 with SMTP id
 d41-20020a0565123d2900b0050e8ecf4100mr3309705lfv.112.1704163005510; Mon, 01
 Jan 2024 18:36:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227053509.894642-1-allencl_lin@hotmail.com>
 <SEZPR06MB56080820EE51CBAE9C6B6B3E9E9FA@SEZPR06MB5608.apcprd06.prod.outlook.com>
 <08623087-bf1c-411e-87de-d40ffab6e2bc@linaro.org> <TY0PR06MB561188EBD127F8ECF4A7052B9E9DA@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <0a817121-620c-4630-93a3-5cf3173b924f@linaro.org>
In-Reply-To: <0a817121-620c-4630-93a3-5cf3173b924f@linaro.org>
From: Allen Lin <mytest7890t@gmail.com>
Date: Tue, 2 Jan 2024 10:36:38 +0800
Message-ID: <CAEr79DXTLTsan3dQvCx-M6aUc4CAHJ6aJbp+GiC+MA4K=qdPew@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: input: Add Himax HX83102J touchscreen
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Allen Lin <allencl_lin@hotmail.com>, dmitry.torokhov@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2023=E5=B9=
=B412=E6=9C=8830=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8810:19=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> On 29/12/2023 10:08, Allen Lin wrote:
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2023=E5=
=B9=B412=E6=9C=8828=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:36=E5=
=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> On 27/12/2023 06:35, Allen_Lin wrote:
> >>> Add the HX83102j touchscreen device tree bindings documents.
> >>>
> >>> Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> >>> ---
> >>
> >> Where is the changelog? There is no cover letter attached, so changelo=
g
> >> is supposed to be here. There were several comments, so does it mean y=
ou
> >> ignored them?
> >>
> > Cover letter is not in this mail but in the mail with this title
> > "[PATCH v3 0/2] Add HX83102j driver for HIMAX HID touchscreen"
>
> There was no cover letter attached to this thread. Don't send cover
> letters in separate threads.
>
> >
> > Hi,
> > This driver implements for Himax HID touchscreen HX83102j.
> >
> > Using SPI interface to receive/send HID packets.
> >
> > Patchs notes as below
> > 1. Add the Maintainer and devicetree bindings document for driver
> > 2. Add the driver code and modify Kconfig/Makefile to support the drive=
r
> >
> > change in v2 :
> > - Fix kernel test robot build warnings.
> > change in v3 :
> > - Modify code according to review suggesions.
>
> Not detailed enough. What did you change exactly?
>
1. Remove function pointer coding style
2. Remove unused code/variable/structure
3. Use devm_kzalloc() to allocate memory
4. Use gpio descriptors to control gpio
5. All functions are changed to static
6. Drop all global variables.

>
> Best regards,
> Krzysztof
>

Best regards
Allen

