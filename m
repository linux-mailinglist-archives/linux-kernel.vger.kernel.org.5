Return-Path: <linux-kernel+bounces-77009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E3885FFFE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BC6F1C23EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA38156963;
	Thu, 22 Feb 2024 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8bBJ6Zw"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF36131722;
	Thu, 22 Feb 2024 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624037; cv=none; b=nz9n9MKBNkF911miqSBojfUdfSCY8HP/K1sEw9tI8KxfhIx3NBk3hf6df9/G6SWDrC+u0Cp+cx+Uqxy8snh8uS590pk+d93CZA4CNG85Hc4ZrujsBBTOeXtUM3H2k48l4drHitqGukdTJhnVZocBWZcEKWhXNe6TBR8bODi9UWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624037; c=relaxed/simple;
	bh=pxj3JMHZFONWDKnKYJpje4WNhEx9Zd7DxubCa9x8R+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PC+HxlSVaAQfGA6sRoFmT/kZEeYH7WsAjXukofNFwtjv9hsGU40oH8J+NsOuoEX1mfUNB1PFcvcllPxErtVlAbFWqRj0t1VsazFuuOXPRIgAKH0Gv2xpEWDQnValge3HM1yHlqpX/jzce8ByvZC6VsEunYSxjZ91CQe1tFGl4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8bBJ6Zw; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512e39226efso83000e87.0;
        Thu, 22 Feb 2024 09:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708624034; x=1709228834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1vMzRY4ZdJC97RtaAcBXZtkJzfMV0ziR37O9+2OreJs=;
        b=k8bBJ6ZwqQPztJ5iWSF9xS0xqfkYefAOe+dFzKRjpfycRNkZvw0qOSbAZFmAOLqiXF
         GiTssslOJoycJdMG0obOfEnLPd5+3VRhAresH+SJ2bq10Mc5/yYzK5+nqaiBQoJJ+SKf
         3Kab/xHaNuUUvXcBDyYP41hkcJkP4ebINQsmJ9N9BONLnnqA/56wljJXhiDGbmufp086
         jZmPgkf/cAqDiklGFX4Sj2YaWGHBMwzS7AeNQndEZdTApbwAvjR+iOW3Xb8A00JtkdlH
         dOsVTfjmBBQ9WcWprp7+eCoocy+6bvE1p/KsroL4tVyf8ZeL70NT73uyjUiLZ3CksDsW
         MG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624034; x=1709228834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1vMzRY4ZdJC97RtaAcBXZtkJzfMV0ziR37O9+2OreJs=;
        b=NZYqTNEOyQ74pTibp6yyuDV0TE2JMwiXMAUsh36b6joebaszW7pGYLmvelI2aWDk/R
         fRRbtApCZTxAOQ0/7Q+DkUHJtPm0pqcnegVZFHZnDAqMQCmRSH0o2rTl1tD6T5kHydaY
         zapuqwDrsg66i6YyTTx81H7nipK4ZdvTZsowozzG3mEnHc0QOLK3Co49Ztv/L8M0kAjX
         eodXx1/2hOSE36LHZrzyQMX2ZCTIXIkvZ/eh41QK3hDXGDPU7zLVVgwRBXvtWjuxeu4T
         qFCMJ0bm7i4mCj2FJCIvKEmHNt7QqUG3OShssvtjl81Ak/KInLd2CeTePUcdcB0aGQvg
         k6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXV4HwWeGjnVKO30+oHkMLppTn7zQseZPpQgoM4uZigwkVPkRS3yr70ZlbhHC15UQjzUvElDcElcz8LVOGYAfQZptq0zhCvPKWE3h0mVa71+yCMzzrIgOcqTzi06GvG1W4BnAbSZUq2eg==
X-Gm-Message-State: AOJu0YzmxHFTXTPWOm7Cs+EJjgcZtuQwduNqwLYNHDcXHvE7T8rNK+1I
	ZK3z++3n1iD+1QT5BpBCEebaP0zv/ynk93tp1+WolTIES82uANRm
X-Google-Smtp-Source: AGHT+IGiugEEEwYB53ORSW0VA1gdJrv8sHxuyh9M9w4ejmOATIcCj/UM2+JKxQktNLdPnMuWWIo5iw==
X-Received: by 2002:a05:6512:3fc:b0:512:ceae:93d9 with SMTP id n28-20020a05651203fc00b00512ceae93d9mr3339347lfq.28.1708624033424;
        Thu, 22 Feb 2024 09:47:13 -0800 (PST)
Received: from [192.168.50.110] ([90.255.110.157])
        by smtp.gmail.com with ESMTPSA id ay25-20020a05600c1e1900b00411d3a414c6sm895267wmb.47.2024.02.22.09.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 09:47:12 -0800 (PST)
Message-ID: <79a4b60e-24f3-47fd-b3b3-7d207cec1470@gmail.com>
Date: Thu, 22 Feb 2024 17:47:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm: panel: st7701: Add Hardkernel ODROID-GO Ultra
 panel support
To: Jessica Zhang <quic_jesszhan@quicinc.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240221194528.1855714-1-greena88@gmail.com>
 <20240222164332.3864716-1-greena88@gmail.com>
 <20240222164332.3864716-2-greena88@gmail.com>
 <f9446923-acd3-41cf-92d4-676b946280c4@quicinc.com>
Content-Language: en-GB
From: Adam Green <greena88@gmail.com>
In-Reply-To: <f9446923-acd3-41cf-92d4-676b946280c4@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/02/2024 17:14, Jessica Zhang wrote:
> Hi Adam,
> 
> Just wondering, why the change to 120 here?
> 
> Thanks,
> 
> Jessica Zhang

Hi,

The 120ms is taken from the datasheet specification for the controller 
as maximum time it takes for the display to reset,

Kind regards,

Adam

