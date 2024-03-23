Return-Path: <linux-kernel+bounces-112365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD3F8878EF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBDC1C2102B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C1E3F8C2;
	Sat, 23 Mar 2024 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW04hMgJ"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB89B1B95C;
	Sat, 23 Mar 2024 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711203338; cv=none; b=GLrKnMbNVmEgk+mywzEFvzkUcp25/sMFqYvEpzk17jMKYJXznHZZzQZ2dCkveYeKaqdYS3eayEIucLiF9xWM3FfJpLF0m6v0+6OE53lEwYgkbxiGPeRtB4EistYyhHaAoP1g7cxvYlX5OTOjIpo9IbatGGskb09VzyMo3Xo+6Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711203338; c=relaxed/simple;
	bh=/2rP2NCZYEibjErMT+bFvN9pYgRHUm5yc0VMok5z74o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDI2U7qeiGmOrM9eo+KaTLNWXmCo6Vo0ksZVlfgks37UMX/Qpp6+KWfoLqrS+EseFRW4a7zayfHuC3CAh296PfbmeyLzpjTKZXH4HNtZzAkW58O3gTRkgOW8385j9dIfN9HDKxe6XFAv9jgXtRwg+AdSieKULdCKJjk/sxTYCMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW04hMgJ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29f749b6667so2249435a91.0;
        Sat, 23 Mar 2024 07:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711203336; x=1711808136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6HGrBZ7lr6jmzr5N2I7wdTvAdnswv+NQ/+myY51oNA=;
        b=RW04hMgJacOeHntDH2E+BQzNfK6rQd43fhYCi9E0oHy1/ciP1kgs3MiGoi3L+TcEdU
         Z3f9PDlTzdqSMxQCVU9Dpl4lAd0aWq+/5CKPc+guPIY3XlIS8WKBQWLeqXaLbrba2dEN
         /P05+4SOWIb2h5fOM6JoDQjki9u5ksaSmSs3EjK+AkA41YD0u0wlshLsfNko8j6N4h2C
         JY2zwKqpp5QtRmpRzoyXo4dk+X5aeEccaxZCiy0LtFIT3NgmvaNsG1p6jkvDHWTxCyP2
         NEJhKi75Ob+yOeZ2TWfY9fWBoO7lU3dWzsEGj4XEXWEgBg9NmORzYFsia03dnJs9swpC
         Wzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711203336; x=1711808136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6HGrBZ7lr6jmzr5N2I7wdTvAdnswv+NQ/+myY51oNA=;
        b=eS3ue7MSPA4ZFmyGEufZ0LzAZ9Jy0oqNb6VTT7zORRe7i3nCY/niP6WHoypQ4jsMCT
         repbnt9ytGybcZOQEig3he25or3rcXR2+JoBCiAlgh9dGl/Rxe+8q9LuRviz5Yth3qmj
         AavD2uAgLnUCHV9ieiH58Jb5vy4BFxSiFsDi0LFcDw1aa7/TFTTKnOkkrz5t+ZaMyJPy
         bMTsdV3qpCs9BoASYq2l7vZ7IllJZYwzweZ9rdCLdiPbQy2c+DVpph9B4gcszMbEurUC
         fa7pltGdCioKbRSdwtu2BDmP2sMwtszl8Qqyr7FMBLZK7fRqHqIKP+urCTEV9Axq6XhH
         Zh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUY2MBMYCXbwdKFfTNtyk7boWefxfxY0QpvtcxTSxOwFkAQlpGFrenXFhuWkl03W0FG+GCZ41QrG21oVHZL0MXhLph/PpDjUhoc2v0/R5KDsfpXWrwPGABdJXQPXi/MARHdnblE27xkc4NRxBa/8jS+uMpH+kZrB7Cf+bS2+pKvxaxfNWE6
X-Gm-Message-State: AOJu0Yzmgt2VzGR24Smx5j3a2FImzrjG2AkxlbLNNFEJm7KRQ2xo1izm
	7OHPnWK5x+2GDlERK64CrDlTpQ92803a/dEn5yHYL9+aTHY5cG/krmA+2727
X-Google-Smtp-Source: AGHT+IHkr9pls9zsekeBxOPd/1818mdgK+5rIXEBs5KuZE7VQWkJRzPfO4NsM/O+NLgnZ5A/2xBJTg==
X-Received: by 2002:a17:90a:bd08:b0:29f:ed40:4a8a with SMTP id y8-20020a17090abd0800b0029fed404a8amr2275027pjr.29.1711203336178;
        Sat, 23 Mar 2024 07:15:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b0029b59bf77b4sm7203925pjq.42.2024.03.23.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 07:15:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 23 Mar 2024 07:15:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, peiyu li <579lpy@gmail.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: max6650: convert to dtschema
Message-ID: <28756dda-2475-42e5-99a4-fd97254391f4@roeck-us.net>
References: <20240321-hwmon_yaml-v2-0-74fa8eb60ec9@gmail.com>
 <20240321-hwmon_yaml-v2-2-74fa8eb60ec9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321-hwmon_yaml-v2-2-74fa8eb60ec9@gmail.com>

On Thu, Mar 21, 2024 at 05:33:18PM +0100, Javier Carrasco wrote:
> Convert existing bindings to dtschema to support validation.
> 
> This is a straightforward conversion with no new properties.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Please note that the branch will be pushed after the commit window closed.

Thanks,
Guenter

