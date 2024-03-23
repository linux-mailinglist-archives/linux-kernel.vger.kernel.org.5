Return-Path: <linux-kernel+bounces-112370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95FF8878FF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB881C20F70
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB6B405C7;
	Sat, 23 Mar 2024 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKOAtrVQ"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643442AD1A;
	Sat, 23 Mar 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711203500; cv=none; b=uYx0UjRC5fUdlNQczfLaI9fYcxh73RDuX4cj+oS55dM9zbqPBs9TEIgh1YnPfG5R6FHe1rR1MIrbRAdvuK1p0WOIAkthY8LNj4oiSgA2jRqmJw92quH/LCaNc0WKX6qUrcqxu2tK3S0xznlTwefiPbqXR5JbKf+8Y7RcBQ0bWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711203500; c=relaxed/simple;
	bh=GPNCK9ionhj9R/xnliiKQwqrYYQbwr5J8sNcjtZp5Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1k5HclYybiUBaX3xqeoppjFu2Y9JGqkCoWlO+ElHI6dcPrGzDCFecBvDhrGlBQPWPHv9+/2TQ0yr2YzTTfQF3fIaNZspy7AKcTYZvPuME3DfVmFwwXlApliOkC2fOc45L3hKsa3giU+Iazv47CIPhJxsNEOBsa3msZszOlVUxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKOAtrVQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ea9a605ca7so194211b3a.0;
        Sat, 23 Mar 2024 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711203499; x=1711808299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2oi8/Av41/0O7sn+va1z3hC3DhZlIeMcum4Cd0IBRc=;
        b=bKOAtrVQf2zqVTRHa9UHSFXiHF05Ixpp0ylIztgd7uUOT1tVJzH+Olrmxp0Vpdi0/5
         EtpDzkoS6x3yqxwpk3VkqC0LI4+DhUuglp07u7exEXCXLJzNLq8Mp5+GBG9Xfx988F72
         WEyYO5PdDkrapi+OVqCtvGjvNOZZUTNwDvthHb+ELgjqFBrfOr27TjraC5mTQUCXpWoJ
         gAWdaA+jDyOEz/VPRLOCJ10u9sOxPdSiRed3tW9+UsNUs6BYSmNxkOVWhx7uznaJqwgy
         94lDyx5PO8X+VwIY1aZsK94ttc3Ze0HOtAgz7dWRM9uh7WNRRbruNRjKmM1YRP103MEE
         0qQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711203499; x=1711808299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2oi8/Av41/0O7sn+va1z3hC3DhZlIeMcum4Cd0IBRc=;
        b=ZyBWfHhG+nJhVrZ0M4Y85os7p91Msug3NKV9NvZiXay7JwTnvpuR9LH7Pac18ni63j
         VZAudCE2EVaQzbB+vYhK89QzUp6xhOImaPpBDsy4+62PmZIaTM6lZzE7B7Riub3OPr20
         OXS515VzHxsC4iXCeNL3rCklGCRFS6MHrbR6Fo95tYKdasVIDW05WVtd04bVKbwp7FNP
         8xRHbiISxhmiiYxVV1Be2M2GFSxW0jDSZO3rFoyBZN6mZhF8AuqAWKubKPime1sfgBJ5
         JfiC/udPHvZftKIkLBxVQzT5dOm4heUUgxTpD13Uhj1USOhvrdsMSMptul5Oou6wYv6M
         VBvg==
X-Forwarded-Encrypted: i=1; AJvYcCWYhj4RSQZcJtYmH+j22SkaBwsCvTD+glcS5794fWzEu70f815xpJD2hnKSCLoJjoorV2z4gdKufi29mZg2r8xpOzWWKy+HjIMlu52/7d2LdU0e/YMPrMKYDsJQjxWOAZQYID+I/cRxx2l4xjC4UFsUwDH94alXAymv52asCw6CW6INZmzx
X-Gm-Message-State: AOJu0YyM5IGZjiaAX0+22SNIKdqZVdJ0m6Ke9oePps5KwX1UD3GFd+LV
	17XZtG2eBeIdhwgaBO7SVXuNMuvi6XzNCdSxV+L9DXfWJVp2tlMm
X-Google-Smtp-Source: AGHT+IHU7RYX/NffMSkoOzcuHzU2HMiSmyhPHK0+serzkUgaC0dwwzvBwrG1X6ZXGH0gZ+VzSWOqqw==
X-Received: by 2002:a05:6a00:981:b0:6e6:57a9:f8b1 with SMTP id u1-20020a056a00098100b006e657a9f8b1mr2781759pfg.9.1711203498669;
        Sat, 23 Mar 2024 07:18:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fb6-20020a056a002d8600b006e7008bce11sm1422976pfb.26.2024.03.23.07.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 07:18:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 23 Mar 2024 07:18:17 -0700
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
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: hwmon: stts751: convert to dtschema
Message-ID: <bc2af486-4edc-46f2-bf0d-abd94538d003@roeck-us.net>
References: <20240322-hwmon_dtschema-v3-0-6697de2a8228@gmail.com>
 <20240322-hwmon_dtschema-v3-4-6697de2a8228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322-hwmon_dtschema-v3-4-6697de2a8228@gmail.com>

On Fri, Mar 22, 2024 at 08:24:38PM +0100, Javier Carrasco wrote:
> Convert existing binding to support validation.
> 
> This is a straightforward conversion with no new properties.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied to hwmon-next.

Please note that the branch will be pushed after the commit window closed.

Thanks,
Guenter

