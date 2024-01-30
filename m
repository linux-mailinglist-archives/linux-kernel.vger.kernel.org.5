Return-Path: <linux-kernel+bounces-44063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BFC841CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDD21C237D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A18F53E3D;
	Tue, 30 Jan 2024 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="HiGPYP4d"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F15380F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600824; cv=none; b=bPoNiSiunb9rJgCIchHlDMtIa84pAfeHK9aG68vcrU37dHVoRpSBggXksGHrOYd1RKrSAWxXN8yX5d8X4pCtNkPAQpz5ClnwKJTPiyB7wrcYXq3RGA3XuPbn+3Z/cwuZwdEywJEsuQaxOxvJWDAp55OfdXf6TCmuUBO/WnjIspw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600824; c=relaxed/simple;
	bh=6wF3pjl+xGSbuQROF2HwbVRfOfePnmBeqT9YPU+Cd88=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=NY3kAGjan7jyauLXSZR/P+06xwiuNDVxr0f3pNhlU0uFqxgPoKxnTibGR0lV+aI8WT57QNOKEQ0E0r0u459udg37TMwxdZakY5rR7AsLPzv8/5dgmh/leaaPXhG7pJcLAlF3wYi4bbOxSmG4oHJ7g54hZpL7+z7eya8FX2ZPAuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=HiGPYP4d; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55ef0465507so2569689a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1706600821; x=1707205621; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlGtGfNm9kPhTsKQ1zfGwKYIV+yyIvsTE/Mjc0NVPIk=;
        b=HiGPYP4dYhUZByAnXCCfDyML/k5Tvd6nNZeKOF1+AtmmNXus/UUnslfILqa8rUm2gJ
         9HBwMHR8Zcrj3Jidevt7zIlYx4IqEC20W8ys7x1PWXZc8BiZLfqmP8RpF0px0ytZQWko
         I+FkP2gEYOyHXLrRqAV16brvLen0EWVDspuM1j+RdoedCPtTagGBCXKIc7ymagE410bC
         C13k39T3q33FXUvZrEwyzUmM98bmvllEzzg2HN/RccxvNRWz9G5aBadfgBa3hgcpMCco
         IIkUJc2qWddJXXBRnYcuFhDo0MdGaTj455hVkVa8mbINkt6Z1IMVGlfAB7bvJVNU6iCF
         N3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706600821; x=1707205621;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QlGtGfNm9kPhTsKQ1zfGwKYIV+yyIvsTE/Mjc0NVPIk=;
        b=V5GaGt431TsIUy7whlqfd3MA85nhiKULCf4eUkgQCiw8JYS2fuGJRo71cMXds/GWyL
         QVW1+Dkm3diXhivPGhgYbUhBA8jxEFG3h7pdj/Y6VjeCp5tHb0P/4yIaIQLZE/3uJEH9
         P1M0h2iM29zv7VAbeSfFlJamTqJvtmGR6Y7mBouknjmph75drFG0558WHwf+1sgscBsT
         /fKuzVlzs7It7B6Xmc7evx6lwbVTCQb0AnPSFNhq7V5IEnV1IjdAHdvz0qLujmABLhes
         4gGyDeA2XIPYxAXM597fqtYqC7qxtqUXrZWSuA8YVwsz3n3+mYzsnur1RJduVYhlQ1pw
         YK3A==
X-Gm-Message-State: AOJu0YzN56HjnJwpUnvckAOEpjRIRCcs9wKzlG+xzlqqMvNtmY2IATji
	gG+GUln8EBCOOq9qZwwFg+WVop2ZRI/9LOEcPBypP62H+bVo0Jgykbjv8K4XhD4=
X-Google-Smtp-Source: AGHT+IE7X9hDipYR0YX/csSCqzOnet8vdLtg+tkdmtHjx4F4Cc1elveRWT2+rBnQl0qvijzggQV9ow==
X-Received: by 2002:a50:ed90:0:b0:55f:43af:4a29 with SMTP id h16-20020a50ed90000000b0055f43af4a29mr420603edr.18.1706600821066;
        Mon, 29 Jan 2024 23:47:01 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7cc0a000000b0055ef56f4575sm2182091edt.39.2024.01.29.23.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 23:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jan 2024 08:47:00 +0100
Message-Id: <CYRVI1IQ2UKE.15ZGCYLRT3ND3@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Conor Dooley" <conor@kernel.org>, "Vikash Garodia"
 <quic_vgarodia@quicinc.com>
Cc: "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konrad.dybcio@linaro.org>, "Stanimir Varbanov"
 <stanimir.k.varbanov@gmail.com>, "Vikash Garodia"
 <quic_vgarodia@quicinc.com>, "Bryan O'Donoghue"
 <bryan.odonoghue@linaro.org>, "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 "Stanimir Varbanov" <stanimir.varbanov@linaro.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: dt-bindings: qcom,sc7280-venus: Allow one IOMMU
 entry
X-Mailer: aerc 0.15.2
References: <20240129-sc7280-venus-bindings-v1-1-20a9ba194c60@fairphone.com>
 <20240129-numerate-brought-4660c2a89719@spud>
In-Reply-To: <20240129-numerate-brought-4660c2a89719@spud>

On Mon Jan 29, 2024 at 6:37 PM CET, Conor Dooley wrote:
> On Mon, Jan 29, 2024 at 08:48:54AM +0100, Luca Weiss wrote:
> > Some SC7280-based boards crash when providing the "secure_non_pixel"
> > context bank, so allow only one iommu in the bindings also.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>
> Do we have any idea why this happens? How is someone supposed to know
> whether or not their system requires you to only provide one iommu?
> Yes, a crash might be the obvious answer, but is there a way of knowing
> without the crashes?

+CC Vikash Garodia

Unfortunately I don't really have much more information than this
message here:
https://lore.kernel.org/linux-arm-msm/ff021f49-f81b-0fd1-bd2c-895dbbb03d56@=
quicinc.com/

And see also the following replies for a bit more context, like this
one:
https://lore.kernel.org/linux-arm-msm/a4e8b531-49f9-f4a1-51cb-e422c56281cc@=
quicinc.com/

Maybe Vikash can add some more info regarding this.

Regards
Luca

>
> Cheers,
> Conor.
>
> > ---
> > Reference:
> > https://lore.kernel.org/linux-arm-msm/20231201-sc7280-venus-pas-v3-2-bc=
132dc5fc30@fairphone.com/
> > ---
> >  Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.=
yaml b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
> > index 8f9b6433aeb8..10c334e6b3dc 100644
> > --- a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
> > +++ b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
> > @@ -43,6 +43,7 @@ properties:
> >        - const: vcodec_bus
> > =20
> >    iommus:
> > +    minItems: 1
> >      maxItems: 2
> > =20
> >    interconnects:
> >=20
> > ---
> > base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
> > change-id: 20240129-sc7280-venus-bindings-6e62a99620de
> >=20
> > Best regards,
> > --=20
> > Luca Weiss <luca.weiss@fairphone.com>
> >=20


