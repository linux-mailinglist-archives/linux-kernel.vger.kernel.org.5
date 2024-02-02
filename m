Return-Path: <linux-kernel+bounces-50002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9358472D9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4B01C212BE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71E1145B04;
	Fri,  2 Feb 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGKmNw+c"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466C5FDD3;
	Fri,  2 Feb 2024 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886921; cv=none; b=F2Zv33ZQ3eeulPLnKynTT9rYQUHcOSusdyM0Kzq0eyU5lIu9EvtRSmDqnNL0QeU7pdeHGR4lveF8Jpk7z0wfuXfwikhZdrZq7gX0I481TB6K+SGPaHzloGPK1PBdBOsB3C0HlYxyD10pp9l84uUkYcvmP7X17dYgoM0Bp1A+r8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886921; c=relaxed/simple;
	bh=bb6JJ8DGIU+YS8GDuF1NbPbwT5kWXHlvXEbDqtB+XvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwR2wOkVKeAJuOe+N1I0vTxOGjprl+mGX/LuRfgHexkkGBosBFXfBFwEjCedHjwcZ32ZxwpfHS98Vz0o1bj59OnYolRL6sFY6FpW2dlPrjboqfaTwoXZZDN9qGH6FXdqVTwG7W7qexxpvzY7/moMpzwOpqYqqxt84XtRshToa8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGKmNw+c; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-290ec261a61so1373452a91.0;
        Fri, 02 Feb 2024 07:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706886919; x=1707491719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3hbLG6X/DntHPddDHhK9VeKaxqSP8Xz0NQInETgw1Q=;
        b=PGKmNw+cY8IHw6JEG6+3ezCy5+xc13wP64omJHJTbYkHzNSF+sTd8tUU9j7GeCRsnZ
         4IIw1v/hy1+ojBp9vgpO53VQpoknTEdPoHG2R3OCfvz39Ha/qlJUzfbAP8yDlCTSInu/
         A0tCpWzEmSAIrf9TVwV70sLk4ltZqsPxreKAmKTyld116czeQ6XkzAgDDRaTShPX+M8k
         mRPZh3K2xtNtOKeDLChB3XTdiLl8K09w9HMyCJbLPex5IUSci3JQCkyV12/KTEqZ4imR
         FQABfvjoN85Da/XtfFBqEHMO/ROZRIS6BZLB+mnIClHBm1hVTyHgI97JFTKeGX2xL0sa
         zY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706886919; x=1707491719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3hbLG6X/DntHPddDHhK9VeKaxqSP8Xz0NQInETgw1Q=;
        b=oVqmg34b8r0O8Ozdty8DCgIjH8Ir3t4rbDjuhH1PQsQ8/8jVfz6FaC9Y5HdP2cnsus
         lS27bvHNZfmbRMUQE8U6nZVlJpzdnnVjDYpjNV7lqEb7qndRTPvK0oGANDv7UYJDag31
         NyaOlJReWnIRIl++2Z9ktoqFp83d/t44glNyiCRbfdAcmagJsKslq/tknIvbhJeDCaFP
         mneIkNCJDTbT3ArUfAKkAXtGDf7miJZY48UYaMm42dWJ1pDM1OEQ8hfNOx1WV4RUJ5lk
         935XVyj5Wm+GUkhsQjpCFNNGwgQyz5sVEe2gPWAD4jrKenZanYRorIwi/Fb4SUHnmoiu
         moZQ==
X-Gm-Message-State: AOJu0YzSkbXxFuGc+eR9/lacrBIrR/jVrNMllWK+T7yJiO0viOiC1wAJ
	kjS8sk/JYcZFsQk91TVeCCfYY2vyy69/cMLJVzicGp7VHqZQycELCxptD4sp
X-Google-Smtp-Source: AGHT+IH07ZtDoocRy3yBjkccyU7UWOy9iS+iNLhy/e5CWCGd16TlKoZXQ3zA9Y8uc4K+OpMQtNLwKA==
X-Received: by 2002:a17:90a:17a6:b0:296:14e5:1423 with SMTP id q35-20020a17090a17a600b0029614e51423mr5648693pja.13.1706886918624;
        Fri, 02 Feb 2024 07:15:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUPetBg+6lQxcwpYdWTK4R61znscJMTXpOP4t52+tt3OQ3ec5hAJbls4FZa0zbE4BBLD/wuIpNVfYi475Bdd0OdRiEwbFK47e4wULipMwiz9GwhXTdHYHXWu7yBc3n0GrnyxNq1Q0lHmxhGPgJ21ERkpXSHwOSfAkU7s8+iJfxKfxq/qCcEK+y8IpPxfIIKCUvg6DPbtCPeywfvZh+fnw==
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902dcca00b001d94c709738sm1713444pll.217.2024.02.02.07.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:15:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 2 Feb 2024 07:15:16 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2 1/1] tpm: tis-i2c: Add more compatible strings
Message-ID: <d2a962c6-9c15-479a-b0c1-475ea1030862@roeck-us.net>
References: <20240116181754.3905754-1-ninad@linux.ibm.com>
 <20240116181754.3905754-2-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116181754.3905754-2-ninad@linux.ibm.com>

On Tue, Jan 16, 2024 at 12:17:54PM -0600, Ninad Palsule wrote:
> From: Joel Stanley <joel@jms.id.au>
> 
> Add a generic compatibility string for I2C based TPM 2.0 device.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>

FWIW:

Tested-by: Guenter Roeck <linux@roeck-us.net>

with qemu and tacoma-bmc.

Thanks,
Guenter

