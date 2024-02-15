Return-Path: <linux-kernel+bounces-66360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B65F855BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B47EB26BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF48FDF60;
	Thu, 15 Feb 2024 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIFKBHTF"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B7C11CB7
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707982019; cv=none; b=UBlGIAFL4WMCZrzdtFP0tg+6ib+ICzsp/ONN6ZDkn32xm8xTnxARoq6egn5rwxBz5ucCS0Xj/N2rZ/uNSJNf81MVlYvj0S7b7KMHUtyaE70jknYvi4Lem+a2JvmDmEmho5VINvzUyFRVDY06pF6aNzxEesrK5vTsjY0aoYOcgFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707982019; c=relaxed/simple;
	bh=tX2T39ISUQw/vyvVN+93v3yI3qpazDG1abG04lj82/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eR/wjy2ct/K1QHKBO5aD+Qz7mGv5BayucUeiN91GJzzgW04fv2OnIcDwnc3yCEq4vQ04ysP4APFL+lM5YhAoAwsvPiSE7+2NYkLk4EABPyVukwS05voYgI60Nr27DFwhSqB9n2ZDX3SFTJucuIDLKvgGwPXdYn67uj+R/FfBXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZIFKBHTF; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so575702a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707982015; x=1708586815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KX/sZUwUbNDRq9nZTjN2Cfp2iERfwU/mU1fLrQdNbuE=;
        b=ZIFKBHTFDkpMPMKzilZ79dxQz9ZhYWde7zarjgo3za5LaqT709Hb3U2gGRaRHRncYh
         rVkmLRgF6tBExatD/9XYUyYszbfV/fKaXbWNitIT0jmSPe1l+3Rd7M0TEMHtk65Ib8SK
         WFk0BJbxTyTitafzRDKr4W0IA/0l+JCb5SG3a1B9lxwqHuUKd2OyMXVtKZ7Z/+KAVC/j
         82+hjCp+sCM6RhOKkpsre2yiG0Uf2GeqPmALYqvPLzdaszgnFHEhuvX1djNgfQ91Amqk
         BafWYQhDjWv4pUCfgJogy/Jc0lblG3+44HoLpqcH2xgnH6CabiTKW5qmFCXBvcX6uovM
         Umhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707982015; x=1708586815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX/sZUwUbNDRq9nZTjN2Cfp2iERfwU/mU1fLrQdNbuE=;
        b=nA7JNLdh+kPwQ0Xdbv/Qq7t1sCkRIlZN0vcMsghlXzcFRD7LFvbb7GJLHGrCfoLVA/
         DZRLKeefqQoIYQsVEBDPbin++Rj9fNEr28KnxKHFgYQbV9lVtOP2X4wl3v/2aijqe1vt
         R2bJePBlUDdy22pnV7Jl/2ixb9rFZOsEWYN38h1XfxOMvXBW1rUzj7PEZSneQ2h6+Flu
         h3I1IIuOk0xa7MtITC5nl2SPJJVslqxp1XrXBkZCvOxM5DiM0O8vAAei9SoEZYrXlwre
         h/PUhTVboJoNJN1sAKhQuMFaHwESwMeDQsWX7eW3VAfnLJHXsjT4pZi/fiXyRj7oBpDP
         Y80Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjtlBWWLpXa9l6lHSEB2yL+9sk6rWZ6kKHgL3czNnnCiJTRGDtzZ7C6nC2rQ5iJF/KPj7mr8R8Qq/jBNekHKRSG7j0htfwN85lAil5
X-Gm-Message-State: AOJu0YzbAOPFrZL2Y8RCo3QguBKwse3E9iubgCVIrgfQueXqsx0pvT8m
	/h8VcvK2h1DF6+zPGrCcOnZAgBT9p3Ryk6NYIpUVUUIUQxlIrJV1EF/bbYpuUXtOlMq9dRYYIau
	f
X-Google-Smtp-Source: AGHT+IEMuhCruhQcLw2/vPbGIhXlZWSJj7ELpXFDu8cI3Q9ZhIElW1jZUNcWVdenlKArnFRRQBdTqQ==
X-Received: by 2002:a17:90a:f695:b0:298:a3b7:ee65 with SMTP id cl21-20020a17090af69500b00298a3b7ee65mr916303pjb.17.1707982015647;
        Wed, 14 Feb 2024 23:26:55 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id k21-20020a170902f29500b001d8f3c7fb96sm594699plc.166.2024.02.14.23.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 23:26:55 -0800 (PST)
Date: Thu, 15 Feb 2024 12:56:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>,
	Rob Herring <robh+dt@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Andrew Davis <afd@ti.com>,
	Dhruva Gole <d-gole@ti.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: cpufreq: Add nvmem-cells for chip
 information
Message-ID: <20240215072653.lscrdrmsges3psmc@vireshk-i7>
References: <20240206145721.2418893-1-msp@baylibre.com>
 <20240206145721.2418893-2-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206145721.2418893-2-msp@baylibre.com>

On 06-02-24, 15:57, Markus Schneider-Pargmann wrote:
> Add nvmem-cells to describe chip information like chipvariant and
> chipspeed. If nvmem-cells are used, the syscon property is not necessary
> anymore.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Acked-by: Andrew Davis <afd@ti.com>

Rob,

Can you please review / Ack this one ?

-- 
viresh

