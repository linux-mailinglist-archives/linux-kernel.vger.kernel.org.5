Return-Path: <linux-kernel+bounces-110994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36178866C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B381F21233
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABE079E1;
	Fri, 22 Mar 2024 06:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex6oiauM"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C699637;
	Fri, 22 Mar 2024 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089227; cv=none; b=pRfLfEzCscMIutxa5o3hqFzsIkp6sexVeO4+2f6wcLC3S5P26AoZzD5jxqOPOksAIDeF5Dx6aBL6TCcuk59HqzFt4qo4UoJVDQD2Verw1cDPBcb6UA9wlMGhxuu1gtQhbBHKDwmIMdyXshYtAQQonh6So8nTfCBP6+YGYsTwJi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089227; c=relaxed/simple;
	bh=pFjf9Df4wwDPKhn0yhjwjZPx1kJbOSiw5Ij8oYOXqx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsydhJzbT+QcfYNgRWMlvDE3voGw0TzfrawbLPOkMaFm1uaI9G4Wq8W7E2Vl2HcUfmMdQ70xA+Z9y3r5r71WUS/M4saBJngYZqRlQH+G3z2vkCvEstYBY65XyrO4vxBSHO9/b+BmNh1Q6pTx0t1vDpk5udzGIND8qhbLeke5YgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex6oiauM; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d4404fbdf5so774480e0c.0;
        Thu, 21 Mar 2024 23:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711089225; x=1711694025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QCNuqw9sQgUOoxa56a5LG/IMC4TqXM0PQ+fRoXn0WFE=;
        b=Ex6oiauMNk1lrdjWrcqIldOcoMEL6xTc4JC89mUahQtgvMdWYcACL/5MPGaK6RZFuE
         ikZGI40my0Wlog5do0icEp71I2h+fBofOqYtAnRFF4ndY+FYyeFZqgWiXxLEUdlPaq9h
         mRRcc6XQ8lIh5F7MiPWF5jKva3dcQ0NkleeSKu9rGq0PmltZHlI0J2JWRC74arzD3ZP/
         cgPmKwmvpq/Thnb7BKnhhgmX0vfzl8krq3+9pjp1tekKoTKarOsK/qTKxS81y5K+2aJ4
         WyQZ57ghl/O6OJlIAfmnMvKrAi7T2njNHMoPRQb6G3dD5cMpXo4OwNPwqBH7TMpIKoP0
         l/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711089225; x=1711694025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCNuqw9sQgUOoxa56a5LG/IMC4TqXM0PQ+fRoXn0WFE=;
        b=Md1rdmGXja1mX7OlqZmSbtriMpctoqtp82Fzfl4MNbKMRDKpCbM1rsj7ppp+QIjLbA
         AvkZzgEb2xCdw4x4xyw6LhQNRYe+0jSLn0seTcAN/Z7XvGjmjqixhOJZ3uzPy/D6gLQS
         4EYF1L7VhVh49Rl6UQjJr86wvhJHMFqsAKIMg85qA+lYdWncVodFVH3EKfoOJhn2wgms
         VAxauXQ/N29/Oa0pNRU7hFntzHUjr9+UsRH3dfRmqM4peTT2MU0SeeihH9Gp9VURrarh
         M8GTSNBLIYDQVwd/hgGR1/TgD+SM1Wqr4vMnw0666pPn18N6Tgm1fEOBLYcODsIfzSBs
         y1uw==
X-Forwarded-Encrypted: i=1; AJvYcCXSWbL3PNc/AHAE6xsVe0xLA39UsCZZUitzskQ2E7gGdjLVVP0fK+FMYuLToOEgpf31QKEyPkrzfMYmmW0n+FeKwh3hFl5f+QyAc4X35QPOjWbQRLEXWpfu8u/MlhCMDHnnX50Viw==
X-Gm-Message-State: AOJu0YxCx20NeCPqqYeQrK2iGxUUAhcazBWCIaExW54sca4CRTHtpRKv
	N6tvZAOoLlpRc1EPayasAP7OBE8s6pq/3Q0k3yDMK+p2dA1jjePpofNWfLgF9hdhtU/qIruP0wR
	n5zloNVkd+EGDmOT0PyAUe/krCn4=
X-Google-Smtp-Source: AGHT+IHhydvvm+GhcEjdhzxxlkkJ9yGeDENsvXzVO87njp+ULtrMjbzdy2YaBLq7fqygmEcys0krhxARiZ35nQuF+CI=
X-Received: by 2002:a05:6102:ce:b0:473:241b:f030 with SMTP id
 u14-20020a05610200ce00b00473241bf030mr1767883vsp.22.1711089225177; Thu, 21
 Mar 2024 23:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321180617.35390-1-five231003@gmail.com> <affc1b03-7a23-4fd8-bf85-4155bcd41df1@linaro.org>
In-Reply-To: <affc1b03-7a23-4fd8-bf85-4155bcd41df1@linaro.org>
From: Kousik Sanagavarapu <five231003@gmail.com>
Date: Fri, 22 Mar 2024 12:03:33 +0530
Message-ID: <CAN19-EdU5OPb=0Qz0_b3GxAJsjD_DAoVRrQM1+38p2SGVTAOgQ@mail.gmail.com>
Subject: [PATCH v2] spi: dt-bindings: jcore,spi: convert spi-jcore to dtschema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024, 11:33 Krzysztof Kozlowski,
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/03/2024 19:02, Kousik Sanagavarapu wrote:
>>
>> +  spi-max-frequency:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>
> No, drop. From which other SPI binding did you take it? I asked you to
> look at existing code.


Without this, "make dt_binding_check" would break though, right at the
position in the example where "spi-max-frequency" is used.  That was
also the reason why additionalProperties was set to true in the last
iteration, but after reading the doc more carefully I realized that was
wrong after you pointed it out.

I followed along bindings/spi/nvidia,tegra114-spi.yaml.

(Sorry for the HTML mail ping, I'm replying from mobile)

