Return-Path: <linux-kernel+bounces-107971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBEF880448
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BFF1C2302C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB3A60253;
	Tue, 19 Mar 2024 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2abpvA9"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537235FDD5;
	Tue, 19 Mar 2024 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871272; cv=none; b=ndWP7Y3zuKRnTLeKCIppTH4C/LC3mrw5wsLwJgjLPeZ+/BR8DAGXEuHDhGCT2TQAZVLxBCPIkkuEU+LlB3BaPcmFEu6TS/I34wUUYpGF2EZuJtOTYU6J1c2hRm5ZZr4RJMvFl9RZMtM79qA5tQG25UplX6E6BzvwN3NgTaJtwEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871272; c=relaxed/simple;
	bh=fURqETKu8mthWcz2QdEl07SUDYEre4FagvpPaVAfaU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2X3PKHOLDK76j9MlSRxU7BUXm0GTkF5LWSKS9/zO/xcME2P3M9WQceS0vuRIQNzu20RvD/+dGsu3nDS1IfJJti36iiztDFRXJ5uvSGBMXhxsTCQGmBNYYSUbaX7s1+K3rSwxsD7GkKL2Xcf4zKAMINykJ5FA9LRv2Nyg+9hyek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2abpvA9; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d4a901e284so50439661fa.1;
        Tue, 19 Mar 2024 11:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710871268; x=1711476068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFqJ9v2zgUJwbKbtJortrw7B6iqBove/bjKEeSOHJg4=;
        b=a2abpvA9lKAQ5M7yuSiWFkXUDbidlYup9mVykTvej9QldKCc71bMcIhuuV6qSxbsYs
         qGIrKWMxmfj+LiJe1qItkF3zIze+HUz1Y2EcLZrYsYZn/W0dAdXIPKNp1S4+cUfKgup+
         FHnoTKGtYxLHfKt4NmX9fwX8AzQ432G8mcVjnSqRU1csxrsig2mx3Y+Bm/+H1ejmId2H
         OpDLJTauHVcDHYDKg1mu9c2pXE0wqdo+EvX6HmRHbpakA8rF97c70CoVhOKvCYEp20NK
         OOGns4aIaeGMS4ZCk1FyYTUHr7xGDwyf7Fy3nMUai0AHZqgLTjAB5I1eYDYnXyQHBfNM
         o/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871268; x=1711476068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFqJ9v2zgUJwbKbtJortrw7B6iqBove/bjKEeSOHJg4=;
        b=VwoZXq++Uy94TyiKuI1L5OlOYgpiWzFEzvjgH/QBlFtxN63xEl7PMhxntWZIRRYoa6
         TubeiqpiEKlnrbKKnMagbQoRQaX+L3TQaBmO2hdn9njIv9jNqeQ/sumiaJysFYlelLtn
         Kvdphc1RUAhiGrwF0qsl7Yz7Zcm5Xv5a3HYOJxp1VLMrZ3Au2sveTdHETWLd0EiBAaxc
         MKkcZ44YW0Ruaokp6uMc5EIT1vZ9KWXnw4kFEVX7Gv3NxK5OY0j4mXlioCN7KXHTarGp
         RmCC5G9NWVDxIUh36XFEBP9Tth0wpQC5nx8FUECBSKTAK2uAJHKwt/6Pyh7oTDobfG1X
         D5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXffgXfXSpLGsdcxbFBM/AwT8Mgg7DaAyuZHnH6Z3DO3O96p0ev2HnKCYqk8wk/Qj499WeOzS1iWdpPqzfr6tbME8BYWK804ISBwTJetZjhQuJgfXHxETvNpuiSGywhmC2DFDO6u4ExAA==
X-Gm-Message-State: AOJu0YxgTyu/59Pm+ny/cpNOihLQofgH/h+wqBPYjK7SxjmziTEKhWhv
	MPx0CHk0RQwFVbMCICgBnIu+1kj/BDuP/Ja9MgfgetPEpBmdUPPCi0pReK6lrIQ1Nw==
X-Google-Smtp-Source: AGHT+IH0wFJ4592JDW/65IORR4qqB7fVXRxiU1BJVdjEM8SP91uo7X5gC1S4P1w5CR0U9QhO74npjA==
X-Received: by 2002:a2e:8e99:0:b0:2d6:84a4:99b4 with SMTP id z25-20020a2e8e99000000b002d684a499b4mr2261330ljk.20.1710871268053;
        Tue, 19 Mar 2024 11:01:08 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-76-118.kaisa-laajakaista.fi. [85.29.76.118])
        by smtp.gmail.com with ESMTPSA id g6-20020a05651c078600b002d0b21bf81esm1946002lje.43.2024.03.19.11.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 11:01:07 -0700 (PDT)
Message-ID: <6e120eee-5cec-460c-87d2-40ef776efc3d@gmail.com>
Date: Tue, 19 Mar 2024 20:02:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] ASoC: dt-bindings: davinic-mcbsp: Add the
 'ti,drive-dx' property
Content-Language: en-US
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-13-bastien.curutchet@bootlin.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20240315112745.63230-13-bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/03/2024 13:27, Bastien Curutchet wrote:
> McBSP is able to handle capture and playback stream.
> The McBSP's DX pins that outputs serial data during playback streams can
> be used to output a chosen pattern during capture streams. For instance,
> this can be useful to drive an active-low signal during capture streams
> (by choosing <0> as pattern)

or configure the MCBSPx.DX pin as GPO and use it as a GPIO?

Quite novel use of the hardware, no doubt about it. If you don't have
DMA servicing the TX, it will just re-transmit the word from from the
DXR register when the transmitter is pulled out of reset.

Interesting, but I'm not sure if this belongs to DT.

> Add a 'ti,drive-dx' property that can be used to repeatedly output a
> chosen pattern on DX pin while capture stream is ON.
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---
>  Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
> index d8d4e7ea6e02..f4d1fc6bcd61 100644
> --- a/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
> +++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
> @@ -80,6 +80,13 @@ properties:
>        Enable synchronisation error detections when an unexpected frame pulse is
>        received. If not present, unexpected frame pulses are ignored.
>  
> +  ti,drive-dx:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      If the property is present, McBSP will repeatedly output the selected
> +      value on DX pin during capture streams. For instance, if set to 0, this
> +      can be used to drive an active-low signal.
> +
>  required:
>    - "#sound-dai-cells"
>    - compatible

-- 
Péter

