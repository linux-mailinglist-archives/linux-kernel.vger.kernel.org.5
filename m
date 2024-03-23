Return-Path: <linux-kernel+bounces-112371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11E5887903
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFC91F2310F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E44405F9;
	Sat, 23 Mar 2024 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6WHMEvp"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966FDC2D0;
	Sat, 23 Mar 2024 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711203532; cv=none; b=uQiR3NwvpOgkIzEy/MLu4l1YXYv9YgMuBecLMoZk4vmhN8hnGAIkLN+4MAfC65yP9euzvDpaIPgEwk8aHQ9w0wcxRUZPh+RpZOs4HTm1eqPCIyyM53nvMaxnX43/JyAifMPY44vwLq6bqFEnkaOAR1SQugpsIYnsNMU/q+4d+Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711203532; c=relaxed/simple;
	bh=I8kj6dHkv4K2xsPgfWBE1JbJtKK0/NNZjAGCGtvG71o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqxjC24zqif56KUNGt/KqhpB5oFINSZFjMO+TIh8PdGy5L22fEQU6L7/GYURXKSLX/kUSIGk385UxD5rr8fzX4H9EN7+Ci50dJWJWJ9hUFbzXfTJSHsnHUJK4rNA/q/ZCFqa1aZLXOgnnJo47f4DnyLHFGAN/p1XEj47FGsL074=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6WHMEvp; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b519e438so1904479a12.1;
        Sat, 23 Mar 2024 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711203531; x=1711808331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgW1njvW4Wz+IGlNA3VNeEiCX2abnmGJkt4zaObGyJk=;
        b=X6WHMEvp1+yg+XlMScgNDR4os9Bl14mzM5aHWqxRHaBk4cG6d/tp2QkcSaggal9CgL
         awhOpTo1D/KmA+a2vdy+GlHUUbplgTjaZ9f5uM/AYfjaRsjkXqbYHCVpdFZuVOv2x/AY
         raYepwE8SjKJpCzTVk5p4If5xbAkKv7CN4a8f67jsTNfTH4MQQD4okgBlT54JoaInPwK
         AADnWIpAMox1U13Om+Ua+3gXG/GXMT64V3QYddkHltjhel00kNHMCubm2nIMJmdR7gMF
         kDlr3mjH256iJPe2kYnKrGienUoIS3NOO4kppntd+7r4l7A1qJyQ5FhkPMHtZ4F9ZEnW
         db1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711203531; x=1711808331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgW1njvW4Wz+IGlNA3VNeEiCX2abnmGJkt4zaObGyJk=;
        b=rkZXZBy+3oi+/SsqodVv/WqxmoWHr/dEcyA+ATPlN+FtpeBM97x8Q3XfTFt0y0yi2x
         fZh2tTAqx173LFR0/hdpGoXXgkysIK0e/ckNNPSiFHq5iPqy/TJmp1PrHnSVK6uQ0APB
         uRnt02skYFpzXMxS9CekLipMTtbw2PvpoL8bx/GobZ1oYKlYoMHZEh3z15m235FRpptc
         lfEKmRiWmURst/y70rPi4xJTpqesHW1wZHryb9TsqKIUCSOahmnAcgoVEI1NRTuCXIsw
         2qMw1O1/HJL5mvIYT6Y74P5+tHY3+sY1qwiuWTJm4rqznbIQWi/RFU46AgelKf4ZiRP9
         kxpg==
X-Forwarded-Encrypted: i=1; AJvYcCUtkNLvs1XCdnxR+9vt1/s3AimAktBPfvJgdxZUexXDbqs+QJb9EDuS5ea4nk63/9KM0e6fiCu9LviFxx+XitEhps4Df9sSfw2kdbBP13rzBcBWq32Zs+ZiFWGbDkl9Z7eoMYBV/Q3q4KPVd0fjcax3wG98f8znqDjm8eRoQTqrtf659d+P
X-Gm-Message-State: AOJu0YzB3dVxCM4pipNIvw6Lm47vRAjM5obJDIhmYobaiYsYSO/qKr3V
	pAK1GVd4Fqz9MMTJY4hRMc7zEdO3DgN6kSTD5w4bkwj5CwmrtLQh
X-Google-Smtp-Source: AGHT+IFGFxIRoqvGpXqMnnxrsXWZplVYwU/7PbCEWKy5oSpPf7AjWoIraV8DBpA54k91DPSWX32lJg==
X-Received: by 2002:a05:6a20:6a0b:b0:1a3:ab77:a10f with SMTP id p11-20020a056a206a0b00b001a3ab77a10fmr2712655pzk.55.1711203530856;
        Sat, 23 Mar 2024 07:18:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i63-20020a62c142000000b006e77d7edc56sm1474298pfg.111.2024.03.23.07.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 07:18:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 23 Mar 2024 07:18:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 5/5] dt-bindings: hwmon: ibm,p8-occ-hwmon: move to
 trivial devices
Message-ID: <79f53936-608b-436a-af9f-9f47b1ef16cf@roeck-us.net>
References: <20240322-hwmon_dtschema-v3-0-6697de2a8228@gmail.com>
 <20240322-hwmon_dtschema-v3-5-6697de2a8228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322-hwmon_dtschema-v3-5-6697de2a8228@gmail.com>

On Fri, Mar 22, 2024 at 08:24:39PM +0100, Javier Carrasco wrote:
> This binding meets the requirements to be converted to dtschema
> via trivial-devices.yaml.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied to hwmon-next.

Please note that the branch will be pushed after the commit window closed.

Thanks,
Guenter

