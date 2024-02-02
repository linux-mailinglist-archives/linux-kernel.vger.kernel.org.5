Return-Path: <linux-kernel+bounces-50453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F14847922
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140F528CEB4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A320132477;
	Fri,  2 Feb 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIKaiWko"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C083F132468;
	Fri,  2 Feb 2024 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900194; cv=none; b=JYRd1+HfHDgZ5GQoUmkXsl0l+FAQpvnVM/NjlplCF8EmZckLnLjS4TLmL04ptTwjei1szpB8PDrOEW1uXzAiZiADs88UyXbHsP1Td6SVw+Vp58NrAsRC4uKJNhIedEViskN0vEHk1SOoufPCOictwecgejaBjR9tV0DAUqEc31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900194; c=relaxed/simple;
	bh=QX3c/eb7FMqoCbSfld9B0mOGqsan/HRmSQt/6mnuXcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFNEGThasojz7UGmVikE8IrtBxo0QxJcems+06L5iHdwUDD9y4MDNvIHu9UpebS5gDjpW024GPIMreCBmi92iNUSwSDpEZKFPrZYPIjrnbbm3SaSkI7c/jlpo1qvZj7HVHzDVId6agC/GxjZcHYIj3f1pnmxu3Fbh0mbos9kktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIKaiWko; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8df2edd29so1982248a12.2;
        Fri, 02 Feb 2024 10:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900192; x=1707504992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jySYyCMCcqa1DHsUvN3ihLcnzuHGfu/pYWLzJr7EF0=;
        b=VIKaiWkowyL/iyPvw2dHEHmdnj95QFz++2uDlRzASr/GbbB+JqWW8jflIxYxdW35zp
         cHkT8BI251dHKTEzqDZuKJitoEbSDqVZSXAv5cXdOHB9CBbR7HkUJ59b9AuOxj8WvvD2
         wtXEPHjxyw60vfYUi3/za6n2vz/grzX4zPG+kKJ5VFDt6oJ+mS0AN0HjEYxJzlYeJiEz
         ZPatiRwvpmiL3Vhc8xmasmWUSbLI/7oCTEezlQxDHq6UhthO/+Kmmiu1Y5ZAWXRc7d/n
         8JP3Rk6wMSmX+OxgyoVy9Hd5EPMDYufMfBYhIyuUuDFaJkgECIG/fvRQj1VXXjBRLnvy
         L+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900192; x=1707504992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jySYyCMCcqa1DHsUvN3ihLcnzuHGfu/pYWLzJr7EF0=;
        b=NTqjia1O/dSSnb02MiWCeO+IRgfLdWMKGPRpjBOBj9Gp8zYYauCzlQY+74js1zYkmb
         2EhJ2wqJaMq9D+D+fL4Nq2uht8vAZM9nPy856Z+V44F/x3EvaeWcKj9mxKlXenOOHWxz
         NuKgKvJdG07O3agiiZs/oNvLOdThqB35oYEN0FYTldlTu5WaDf0eHN6DxXmFb1iz2B3h
         iUNnkigfc27zxWdFwIBFxmNdTSeuLamA3xxr9J0iVsdOIrKhfwSC100pu0T9KquyL+3e
         FRQHpn2dhHCB+zQC7c96mVpRpi7vDfR/w7o3f5A5fN+gbGQV0rqx3efYqXpcy+qBDsKf
         3CGA==
X-Gm-Message-State: AOJu0Yxv76HqgTIXCxSm9rMpkcegGQ2DFUzcspsr4fqrZ5vtydLpYxMM
	85JZGMsYVKcKAWIoL/Ek8yezWYuEV9kMlvHE01WGgCRvtkALSd00
X-Google-Smtp-Source: AGHT+IG99nM3xmRqiSFxiwUhgQAu/1Nfq9rZa6CDp+5zi7NQ9wcHXJw8rsS+IKLRp9xdkIyEIHX9nQ==
X-Received: by 2002:a05:6a20:4f99:b0:19c:9b3c:cdb3 with SMTP id gh25-20020a056a204f9900b0019c9b3ccdb3mr5664778pzb.48.1706900191814;
        Fri, 02 Feb 2024 10:56:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXBS0LnYRLtACPoorcEiUhMVqsbX+hTHIcYUFeZG9T1CmMS0bPbv/1YSd9Y7j+ZnAkewN+qvtHovNfWRbniW1Cw1YmLr7XZgW8DkPlrnKey5wZrmR97ALJM5MtcFpdtvtRnchq/KZylyLq0VfehqSwrEuM3q2pdFNybTP4ivRXALhunWnPTXadcEWZpEspg4iKlH3VPuGSVo3+lK3gzXAeB1TWt1eGGubiiEUx/Q4GUSrVku6yT94DK59/TJ9HV0c7BNqgJubrbyHJ3/i3p2sY6yWBiZOCN0h7jhGxsrQj0Kd+ltODfoHzSwYETj6d6ZC8qgP99fEAJZP1riyTJmPr/RQgw0VbTCn5pQKtgPEKeokk2f4m8xHtdl/ycdTe/dzjKwUF+lfrPJqWScd/TePgGMmFTD3KozWSuOkHxzhtigw==
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h15-20020aa786cf000000b006da8f6650a2sm1965532pfo.155.2024.02.02.10.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:56:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 2 Feb 2024 10:56:30 -0800
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 4/5] dt-bindings: hwmon: Add Amphenol ChipCap 2
Message-ID: <d008cf00-317a-4498-9dd2-f62a3ec0efb8@roeck-us.net>
References: <20240130-topic-chipcap2-v6-0-260bea05cf9b@gmail.com>
 <20240130-topic-chipcap2-v6-4-260bea05cf9b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-topic-chipcap2-v6-4-260bea05cf9b@gmail.com>

On Tue, Jan 30, 2024 at 10:06:47PM +0100, Javier Carrasco wrote:
> Add device tree bindings and an example for the ChipCap 2 humidity
> and temperature sensor.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

