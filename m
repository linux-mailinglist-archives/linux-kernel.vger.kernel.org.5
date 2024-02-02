Return-Path: <linux-kernel+bounces-50450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ADE847918
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CA21C272B0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B912C12F385;
	Fri,  2 Feb 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ro6UE5jt"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872DF12F374;
	Fri,  2 Feb 2024 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900074; cv=none; b=dZve1ufkEvUfPXrXN/ZyeEigN/pMO9K9IvhpjkJX4Ei1lTN4kwwwTesmw5Tm9P2E704iRzy3txetyfGcemYArG1d6BiDHm0MRMJKvx47dQfTq8yKI9DLJCj3rjcCyidofOh1hTliGGHYk7BicCG4TZkSCuW0BafNNjqz6v5Zias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900074; c=relaxed/simple;
	bh=jo+FWGe+oR7bSCoGGVbo+SEtmwAqP81B6x0dU3BHZRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTCkqtkFqbfo5tF8FojhI4v1u4/QkheBN/wP8bguUby8WjMUMVY9hQBzpVbhehJUyBGAlSjP2pmkHC1NbsbQtnxR0DaHGVnRTaihDSf/tVVzk+Lx0fHGJJJk+z5w0t08pySTYbmEjIaAqQmckYZtSozM9Lw9EbFV4aQUD91nN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ro6UE5jt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d71cb97937so22832955ad.3;
        Fri, 02 Feb 2024 10:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900072; x=1707504872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeSCHAy3VJzuhlqFkWOWdVVAJVTWx5SZIKFlnniBmYk=;
        b=Ro6UE5jt152SSIvbOSzdfB4jX5QHbJdcpcj6WvhwaaypLec558pcHRyZeoDFEhEsym
         SbQztnz76PD23hBrD2JFeGClB6FD5EZ40Lew69flxH06H/DBI388qVXqcaEMTFdjp21p
         PJqcKfyV1Ka1QzVL60cyOK3TE0pCbQJTKrORmBct8QmrcglKv/klvpjvYdfbbf3hwCgf
         5qROH3K5v6X0FlYQmgdvUGqHpgrpOj2+naDPdOeECDa75LtqTLswq00vZA826q3FvIxE
         HDaCN6hLDvIuibUigW6b1mjKQchZ6IeozhDDawMFZN/eUIaKT80mnQCQFkdy/BAMw6el
         f1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900072; x=1707504872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeSCHAy3VJzuhlqFkWOWdVVAJVTWx5SZIKFlnniBmYk=;
        b=WD8uD+RbSUZgnZkryNYQiR0vfVYXqeSPIpRkjyngNi47Gpbp2wH2teFi5sr65w+IbJ
         79ibFgW1qxWO/iLmwOKMU1Y9jmQXHrQq3hez5ROyx9ry2Vsmi/qlb8LKK6FaX7Q9YA6c
         LTTCPymJM3tNYOATYkolTqvb1dt7lU4+o+t86j279HrAIc0Yppu2Wk5Ca4CWk3c6MNSZ
         u/buM9jzfZ4ueMvpfz92lO/9aiBb+Km2hQ1McnQCZs2DngdgdECw6nhErS8dxyTw8Qcu
         hv+4wQppaf38+j3UEqegSiwdd0JIyYiae2rvzGLlnnHUiHB7MJrEy3RZEnzYtuX2nWGo
         HAGQ==
X-Gm-Message-State: AOJu0YwViKhrfSGfIt9mwK2a2Th5JQlHWUgkPIdhWREWPG1dwLcy/kSC
	wYdQAA/YXHqh8R7PD+TSRW7Wd+/XZgftHdE7oC+24h2KV8CihSuQHHlm37up
X-Google-Smtp-Source: AGHT+IFcZQemFSdmcEK9i4IsX7bisc15TiKjCHoB4bg5gBSwHBOW06rHkGoT8HX+PDKFtcYYd5XT3Q==
X-Received: by 2002:a17:903:943:b0:1d9:8832:f800 with SMTP id ma3-20020a170903094300b001d98832f800mr215664plb.8.1706900071874;
        Fri, 02 Feb 2024 10:54:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXhtYm5bifoXUxUvTc+M2Vo5X4YrXPoXCmMK1UlWBscbUoGwho5tCSKPqWmg2v0D5vuQnzUsa7UlaN8MRrRTRNgF4LclPFVjub2NIflv1YziPg9KdhUYS6R3jbE1Wq96LMdZuyngHnaSLu6JB09Y0dkejvAm4PxDJ5ZT5MSYa6xc03VBhOzxdJoZoPeRMYkDugOUcfcdbrWDOt5pbfMUhdYHAR4Wa/Q0UqEttxBo3YCdBm0KNn++Ud13FoW6VFyJFmSqtSUJTrplxYj9F6IXXhJBmkD2DaNHAbEzh66J+OcTv+m/mTl0lR3j1weYAZJN5yJUX0cQuJqpva/XjawxIzyc9jAzKxKDxbeotPSz3OUDrzaT3zQ4E9VE7NhSxakiHcHGtc+wvEpF0wAPmMGfNaT/Y25JOiRdvmZ0KFrInDxiAcYWa4=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iz5-20020a170902ef8500b001d8f111804asm1929010plb.113.2024.02.02.10.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:54:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 2 Feb 2024 10:54:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 1/5] dt-bindings: vendor-prefixes: add Amphenol
Message-ID: <fa215ab8-0b0a-462e-b205-7b2288df263a@roeck-us.net>
References: <20240130-topic-chipcap2-v6-0-260bea05cf9b@gmail.com>
 <20240130-topic-chipcap2-v6-1-260bea05cf9b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-topic-chipcap2-v6-1-260bea05cf9b@gmail.com>

On Tue, Jan 30, 2024 at 10:06:44PM +0100, Javier Carrasco wrote:
> Add vendor prefix for Amphenol (https://www.amphenol-sensors.com)
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 1a0dc04f1db4..25158559471c 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -107,6 +107,8 @@ patternProperties:
>      description: Amlogic, Inc.
>    "^ampere,.*":
>      description: Ampere Computing LLC
> +  "^amphenol,.*":
> +    description: Amphenol Advanced Sensors
>    "^ampire,.*":
>      description: Ampire Co., Ltd.
>    "^ams,.*":

