Return-Path: <linux-kernel+bounces-146673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F23A8A6913
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C874E2839B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173D9129A68;
	Tue, 16 Apr 2024 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wclPlGpv"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392D71292C4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264764; cv=none; b=i5XblvCAR50i30yyamvHHKPXCTog/gSTkfJbLqbBokUuxRccOhO9E9BfoPpAXdCncVP6aWIHEjepdvnv6aaxWCWeMtpZs5DxtMkk1u8mkGBozbcSli+Sqa9GwB8dqpPNt03+iEBm963Dzq4IYJVw/fnLyZJB4JE5XQx/a58bccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264764; c=relaxed/simple;
	bh=jpcWEFpjeFpqj4mlg7734V1qNoTx1GGeLMyhzIC8jTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j40hfS9tK6fTIrFIejkv1X6H6FfEckhXNELi6jKUurbIv4POItbrV3sMaHFfJpyE0al9B/1zaNGToWwWwWE1S7pWOK09L1VHUbxFDN0XGiDhjxLiT4hdiOO31VDS3MLT98kyU+nWHxBlSOdHAVhImpdY2jiQ4hj1fPK4fa4F4Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wclPlGpv; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5aa1e9527d1so3026306eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713264761; x=1713869561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0TxxrwK3iCE49uLbQ7sQ5tDEvF/HbWHLGi4XWFVqlw=;
        b=wclPlGpvY+oztbeNpgoJ4mU+4bHlRx1Jq8mzNA9YLYsoUzGWAAqVEoDYgR0C3ZDV2v
         XvAyuG1yY7sgXsCOtK66cOzKhcGsnk/cgCrOkpDUn0mt3rRFzjTwcyyyOGOzL9fZcPS6
         BVvI5SzwXrNUv7idZgf/bBaCjZOdEiVePaN+L/QH3rYtfLmBiNluht4bI5+ZSX6mU28j
         xx6hCYv+0j6F2RB2sUZrSuzYazBEqFlQUWOobHvqqjCdtnO5ynnCepD1T9pYtyctkpGj
         6NXFp5fruJ0rGK8CVQAFRkl8rHHyEG4YiO3QNdmVp0wp52tlmJrQoo6c0+ZgjA04SvJV
         JcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264761; x=1713869561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0TxxrwK3iCE49uLbQ7sQ5tDEvF/HbWHLGi4XWFVqlw=;
        b=l04GWrk9ESb8Arlg9kAOSSyT/RiUgHG1SNvmv3A/zQQSCQhtlUEWCrDqkQpISMHc8e
         wwQ4m1gsQJCoqKRtCgKgxF91PSKmKAV0SJfguUl+Ngre+FrD62h/XVTpj0JpfIfgLbwd
         9okYEqVwuRLT1yeb1VuA0ML++h8Ec6xVqBlXt/lFot1JfeKlTHu0oz+GZtjNjYVhh4pl
         FIFMmSQMfAgQ5la8JoX8V4ksP21PJ70IJWC55zBIgs2LP1n5DHren9hTVjE/Dc2aooLM
         wRuEwTfw0uzkTqNSIv6/1Bmc8Ci41MnOisfCo6skQxX4WlqvZAk1oCkCV2Rxc+YlFrd7
         8iBg==
X-Forwarded-Encrypted: i=1; AJvYcCXNNwiDUmI7kYwFS/o6RIE2rgbuUglhskaln9D0/SzhsDGaKWgng02tFtLz1mn8vDIU39RxENC8cOvWqgmGFMI/yc8mNe7ERwT8Tgoj
X-Gm-Message-State: AOJu0Yzq/4dkdUtOcZeS86xiwv7O6JsNJaVf8WGw20LZQt9RtyWQhVpN
	HfUc8ZE7wq79i9EM0zrzDh3Egb3ZGDNHWlV+lEbXdMHK3ksHYPgIyo6WO90kHLIVlB8GH+2C0L0
	YTkZOHmuNP6gqEk4WKM322hzYhL/KnHIhxgsvkA==
X-Google-Smtp-Source: AGHT+IEqEeJmQdQehCPTNQQMD/tcR6Uw0Nol676WtmyqwgXlvaaJnzKAMXtuWis/RQBtHTHTt/sD2iWj7telCINa9U0=
X-Received: by 2002:a4a:aecb:0:b0:5ac:9efc:3b02 with SMTP id
 v11-20020a4aaecb000000b005ac9efc3b02mr5382919oon.8.1713264761347; Tue, 16 Apr
 2024 03:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404122559.898930-1-peter.griffin@linaro.org>
 <20240404122559.898930-2-peter.griffin@linaro.org> <d1aaa3a350315b8eb60aaee416fad4382385ca3a.camel@linaro.org>
In-Reply-To: <d1aaa3a350315b8eb60aaee416fad4382385ca3a.camel@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 16 Apr 2024 11:52:30 +0100
Message-ID: <CADrjBPoMWDqUQiW3YUxKxCRJAXzJb=-eL_kfpeMHgaqg8c1HJg@mail.gmail.com>
Subject: Re: [PATCH 01/17] dt-bindings: clock: google,gs101-clock: add HSI2
 clock management unit
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org, 
	s.nawrocki@samsung.com, cw00.choi@samsung.com, jejb@linux.ibm.com, 
	martin.petersen@oracle.com, chanho61.park@samsung.com, ebiggers@kernel.org, 
	linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, tudor.ambarus@linaro.org, 
	saravanak@google.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

Thanks for the review feedback.

On Fri, 5 Apr 2024 at 08:15, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> Hi Pete,
>
> On Thu, 2024-04-04 at 13:25 +0100, Peter Griffin wrote:
> > Add dt schema documentation and clock IDs for the High Speed Interface
> > 2 (HSI2) clock management unit. This CMU feeds high speed interfaces
> > such as PCIe and UFS.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  .../bindings/clock/google,gs101-clock.yaml    | 30 +++++++++++++++++--
> >  1 file changed, 28 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/google,gs101-clock=
yaml b/Documentation/devicetree/bindings/clock/google,gs101-
> > clock.yaml
> > index 1d2bcea41c85..a202fd5d1ead 100644
> > --- a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
> > +++ b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
> > @@ -32,14 +32,15 @@ properties:
> >        - google,gs101-cmu-misc
> >        - google,gs101-cmu-peric0
> >        - google,gs101-cmu-peric1
> > +      - google,gs101-cmu-hsi2
>
> Can you keep this alphabetical and add hsi before misc please.

Will fix

> >
> >    clocks:
> >      minItems: 1
> > -    maxItems: 3
> > +    maxItems: 5
> >
> >    clock-names:
> >      minItems: 1
> > -    maxItems: 3
> > +    maxItems: 5
> >
> >    "#clock-cells":
> >      const: 1
> > @@ -112,6 +113,31 @@ allOf:
> >              - const: bus
> >              - const: ip
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - google,gs101-cmu-hsi2
>
> this block should also come before misc please.

Will fix

>
> Once done, feel free to add
>
> Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Thanks!

regards,

Pete

