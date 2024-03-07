Return-Path: <linux-kernel+bounces-96028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B45B0875646
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E75C2814A9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BE413540C;
	Thu,  7 Mar 2024 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+RIhoxA"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B6C161;
	Thu,  7 Mar 2024 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837212; cv=none; b=V/ARulZ/qpp6xHU32DgZD/FeT7fMZv4/ThyRP82MuiX0vl8KArm0TmVFIX02zdDW7bujkF7UVZJydY64QYMeVFlfM3QOMxdRJiVNm6bfAirHp/IAWg6rQ8ggVCYVuqt+qJweNVZn3Yg4DfaII+1txN7+z2U8DLKBJJF+jnsLoMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837212; c=relaxed/simple;
	bh=6Te2Uqo38c5XDlKMUK1IPMvLZguublo+9oaHUlFD2eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWGCnwjTun2AxYRNhxZZUhjtUdr+/mINADEdvT2njS+YMp73sL0tzXOOqHfNtEAi6RSj1SsH0ev/iXDSwNTv0/PHwWLYQp3gOeg+e5avUCkVrioG3f6sihuNoErulwIKzRWvi6EMl6XYkUv2a2QRt9vj7k7js+bkv0gyXLEpPJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+RIhoxA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e622b46f45so24525b3a.1;
        Thu, 07 Mar 2024 10:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709837210; x=1710442010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcSPzX8M+QJFBTpk7kbACEk4HaTU8e+pItsUzx7AYC0=;
        b=F+RIhoxALiezzkzuPBzVnTFEtpENgOIo5Yaa2lL5+Ot/fvOfOPKUlStHMVkDf+Qk3I
         gP9aKReLZ0Tug3FsX0uFqtu6JpHm5n7fMv3FHzj/CAXvhWV2rHq0t15HmxFDIRnj9CGR
         qfGkapIcRaZSVIKO/thOVyIj/nEEYDSALyu9EJpIlYJe1SIAIvl/DheNHO8Q/17VWNSl
         soV2KO+YBMn1L2qwOa9oB0GVzyPO3HbChEf/3lZzoPAO+DD9lLPXu5O8Xe0bfyb3ptGb
         US94DtIVnnx95nj8Sb014X8HR/EIpup9a4F1nYCLEpbgiJSHWqYPHeGTbhp5K1N6ad/k
         jlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709837210; x=1710442010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcSPzX8M+QJFBTpk7kbACEk4HaTU8e+pItsUzx7AYC0=;
        b=LO4qQgF3P13/zRb6fVNLNdA+1BVaOw0Dc0MCT203tKCgCesDJlHd1fhCdI6kNzDA95
         sjszbFqn3mhjlejoMrNORFaMah7JraC2ky4yeWqYuG4OMcyokChyJ2AHkli/QQL1mdlu
         Jj4Fn/LRfKdN9rJxwhcdt8cL76UZPejW/cpHfd1uCsHbk2MNn7yIzDA8AdbXictr0Q7D
         nuWjyDleM10dgWMk4QA2s9RBKk8SiGpbXnNRNSEQNeF3w/Og9KLRwxtNIs1+K8SdyOn8
         Bz8MBiPXSDB+gO2yd6g1ocEbd8bGzn2S+kcpzpnh3rE/nabH7cS91oF9W9XXIqWn1qPv
         2Cfw==
X-Forwarded-Encrypted: i=1; AJvYcCUojbpbs+pbUnnP92kw402ceyn7AILMFLMqtWVoSSWyFmtWRq45qGa5QoYe4acFyDiSWMvqi/ikNe+jEkeINfnKl5gPNiLfyWgsvWdHpUjoF/EN+c4xIY6Nd0pWKQW5cnNhVt0135libTqhONhZncxn9IDQou8Sc2ZKCKK3LPr1cr+qXGxLIlFgyZkSJ0LVqtPhAXJz5zgQEgU+PlhroDNUt//Bw31wBVHlbumMPuJwbdegT70vvXbnALmB
X-Gm-Message-State: AOJu0YwwL0pPXqYzPhoxBwYYd3o3n8y2tj7oH9L/NaqlewC5N4KV9XMm
	qa0wJOnq5x3oajx5kf23frFA+Xpv0wXd3CA/waehb8Lw95taKBJN
X-Google-Smtp-Source: AGHT+IEBJSEWz2wy7Dv0K1kwfxrU/6G1C8RKBk1lDzsP1RDNJGc2mXNjfYg/byRXJBjvJK4Pk11AUg==
X-Received: by 2002:a05:6a20:d48c:b0:1a1:4757:927e with SMTP id im12-20020a056a20d48c00b001a14757927emr10795472pzb.33.1709837209646;
        Thu, 07 Mar 2024 10:46:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j20-20020a17090ae61400b0029b2eccd158sm1885043pjy.48.2024.03.07.10.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 10:46:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 7 Mar 2024 10:46:47 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: jdelvare@suse.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, corbet@lwn.net,
	u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
	naresh.solanki@9elements.com, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
	BMC-SW@aspeedtech.com, patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v14 1/3] dt-bindings: hwmon: fan: Add fan binding to
 schema
Message-ID: <11ad14bd-bf25-4c07-b704-46a744071ead@roeck-us.net>
References: <20240221104025.1306227-1-billy_tsai@aspeedtech.com>
 <20240221104025.1306227-2-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221104025.1306227-2-billy_tsai@aspeedtech.com>

On Wed, Feb 21, 2024 at 06:40:23PM +0800, Billy Tsai wrote:
> From: Naresh Solanki <naresh.solanki@9elements.com>
> 
> Add common fan properties bindings to a schema.
> 
> Bindings for fan controllers can reference the common schema for the
> fan
> 
> child nodes:
> 
>   patternProperties:
>     "^fan@[0-2]":
>       type: object
>       $ref: fan-common.yaml#
>       unevaluatedProperties: false
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Applied to hwmon-next. There have been a couple of questions, specifically:

- min-rpm of 1000 seems low. Fans with higher minimum RPM
  are known to exist.
- A default value of '2' was suggested for pulses-per-revolution.

Those questions can be addressed with subsequent patches if needed.

Guenter

