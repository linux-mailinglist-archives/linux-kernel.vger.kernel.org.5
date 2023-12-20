Return-Path: <linux-kernel+bounces-7335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E591C81A5F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16E9283E39
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180BD46B99;
	Wed, 20 Dec 2023 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBICEXf0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCDC46B86;
	Wed, 20 Dec 2023 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-781120575f5so58218985a.0;
        Wed, 20 Dec 2023 09:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703091929; x=1703696729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5puDNbS5h8yPDhnQyFTYthYdD3tPGlaiQXwUTgRM5zo=;
        b=FBICEXf0MZJPi1HZUTYUTW+scpmErVd+rE9b+wQoQChlge1r9B/0MGYiirwyw/K+NE
         Y9FBECXgqf4485SBQR+Nm0ww6Akb/r5O6gCIBrxhmxNtWlRwkCDAbQdVu5Z46Ife4WlH
         ZgdjLRoaYjsf0Q/T3cd7cMVYnkZx39EwHLsiy5Wq3sW65RYcVB1B9fptGeVhFRoMHaRI
         Usw8pmCDeWSMJa/BNV9cgwuY0OthKMWopvO9m52xzsN7HyFjdwEqVqDTHnMNNt/VSjWP
         aWLp8Sdt5FTNAy2W7P29mK1RQpy9gtD0+U0I7RotJLjLqLn9ET3GIzxwlh9gslEzQtIc
         5jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703091929; x=1703696729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5puDNbS5h8yPDhnQyFTYthYdD3tPGlaiQXwUTgRM5zo=;
        b=nMk0zztKJ5q69wtS701lSgLL9UrGtewa7as004teFJZgps6bNlLLPXUGCe9IaLSDQI
         2UyEUBLmAs7FEULEvW+QZJTY6QJXBFpiHRhXYA9UnlKyBoEMcQsiUlJs39oRYvNJ7A2E
         FgM2kpK9WLR2XX6MQlERawGAfNbaMN9tM3nC/ytezbR+2dF7dLyfJX3Bd8O5e5m+0tQa
         fBu7dBgCk3ISuck44s2NzWiGDGfqp+I/b4cFrJUM6zF2K8Yaw1jdk/j/75Gm79zHV2Wt
         BbJrJLEMWBxFuauzzRYxMjNUibKFYLPVPCEHphF+T0EGC2zVx/uEC9SHQnya2t8iP/GB
         aM9A==
X-Gm-Message-State: AOJu0YyFkHeEKAhv0UVjMY00A+FtTWXSzLClGkJggfC19s3wujbuNoY6
	m/ti2Pw3FB5pADpckCy6xt8aJm+cZb3KNw==
X-Google-Smtp-Source: AGHT+IEWuxQbO/1DD4MjAMOm0X5S4M1feBKz+j/m/1urHbHzHcCBBjyiyMItrLamQwxZ/1+jf7mNcw==
X-Received: by 2002:a05:620a:439f:b0:780:e283:314e with SMTP id a31-20020a05620a439f00b00780e283314emr7460463qkp.105.1703091928540;
        Wed, 20 Dec 2023 09:05:28 -0800 (PST)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a098800b0077efd1e3e52sm64199qkx.24.2023.12.20.09.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 09:05:28 -0800 (PST)
Date: Wed, 20 Dec 2023 12:05:17 -0500
From: Abdel Alkuor <alkuor@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: (lm75) Add AMS AS6200
 temperature sensor
Message-ID: <ZYMezZbvgtsCW07j@abdel>
References: <89fb5eec30df734ee8fc58427cf5d94929076514.1702874115.git.alkuor@gmail.com>
 <20231219-mascot-semester-7d2c492b99bc@spud>
 <ZYHEcfB7b+k2g9Ge@abdel>
 <20231220-gristle-renovate-557b8c330e4e@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220-gristle-renovate-557b8c330e4e@spud>

On Wed, Dec 20, 2023 at 04:25:15PM +0000, Conor Dooley wrote:
> On Tue, Dec 19, 2023 at 11:27:29AM -0500, Abdel Alkuor wrote:
> > On Tue, Dec 19, 2023 at 03:18:24PM +0000, Conor Dooley wrote:
> > > On Sun, Dec 17, 2023 at 11:52:27PM -0500, Abdel Alkuor wrote:
> > >  
> > No, not all of them support the interrupt. Just tmp101, tmp102, tmp112, and as6200.
> > For now, I'll add the check for ams,as6200.
>
Hi Conor,
> If multiple devices have the interrupt you should document it for all of
> them IMO.

The interrupt hasn't been implemented for tmp101, tmp102 and tmp112 yet.
Should I still add them to the interrupt property? They might be two different
things driver and bindings, but I just wanted to make sure.

Thanks,
Abdel



