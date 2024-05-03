Return-Path: <linux-kernel+bounces-167891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D148BB0BE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731A3286DCC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F990155342;
	Fri,  3 May 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjsYf6fQ"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6750621360;
	Fri,  3 May 2024 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753200; cv=none; b=I0fUljm83PejGHhkx+v4Qdf635DBdgbfDSSwt+Ip0NT3LbY0gzv1xv7hMDGj9lF/EO6QWcOwCaM68+ItEbBaZ4/CkjLEL0Wd93o0W0arWRp41WyKYpMJrzYG23bXLaiKWo1TPNz3jOxjrruKHGy1Ga+JGzjhx82qPFJhuJ3zyOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753200; c=relaxed/simple;
	bh=b1M06R6Oi0ov65yizrGQbpOroCfPdVghawNVfym9d5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxHJNZ5Fo267es554PWwPoRG9E8Vw1Bv2nKG9830AeRoX/B6YIp9JRUTQyqxF9W0zoU49+Pm1G0XLWDV+iwghhaQowRLmD1ZVhV1hifVqt8O3Eu+Rt+NYT2UEkm9degGm257Nfxl4rH8+aQvNC2xec3wITAqcadeAjVGIrvoqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjsYf6fQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so69127565ad.1;
        Fri, 03 May 2024 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714753199; x=1715357999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlUESLHZzkETNTR+DD4DAaRneRx9fqKtb5x0pcHBMnc=;
        b=HjsYf6fQf5JkekxzCRqQRckr9CSsfU6sdg8UZe2uTL11AiBkwkCOi3Y2dRttr0IzkQ
         S+yWFVF7YmGhF0FUtnonJwR5Ebca8qjqJwUfPk9EW6HaxyYacVeIQKzGFb2sYD0orP5a
         IQhIkwgCX1Tynqr7rVPLs1QqXTzMqav6ogDb18wJiBTd27SPWI68gB6BxG0ZxHbXL0C8
         tsgRwsQcOfhFf/ZM9Zld64LJqCIUSeaRas8Vn5XcoSH9D2nC/AKE2EzWDcknQe/bKQw4
         mSVyE746YnhTwzRlWFVFjl1Q9XzL+VyCB9J5fBWOjq6uRHIV9xnIwTHMWKryjYiftrLh
         O/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714753199; x=1715357999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlUESLHZzkETNTR+DD4DAaRneRx9fqKtb5x0pcHBMnc=;
        b=tAETrmZpANUPGqBR/5b0i/iAkxn0fjnL7Su4cR0vUxTvTEr4PLbC+OhViUyiGTDt0S
         TkaQrF7SwhHu0+T7iAjvn0qjOlkITZYQZzWr29ZY9SksMksQZn5HWLclipmWPQZdURg9
         BYYMEkPr9Lp19Nz2DqgyVk2FtO3TGJbAoPrWLY5w+eLvniGbmEmjy31dQJlrQaYungAN
         c2kcoPxiQEBTN/S9kLWwPuvk3jPkKHYKE/iMOM6egW4Zg3Q/HkmL6aDpCrLRCOXIMJyb
         xb3ku8Jf8AZyi0kFBHiIZvAHebvE/F88gxhwDXr/vClfnW27gCmPJKqKPyZ3mGcx7mBX
         mBZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW27dzFhiYeiF6f9L6/AQP256MGHjN6wI7/+mFiciXrSf75oeNiVA9HlybXdYna+Q+1OukY136gaUHWiLGT9R5dLGuKRoLqlklM+exWQH4+bBVEOcRvwEQbajNrxZ70NXW0gpONGLYNUT8=
X-Gm-Message-State: AOJu0YyTB5ABhdNCJ00UU59nM0PxBORhyNaxziwQNjgJ9kdMLNm7jvjp
	0euK90KY2wsunAYou3ib40SWJ+TG6cz+BeV3PS5k9Kd7NbKryNtFsTAYSQ==
X-Google-Smtp-Source: AGHT+IHI1lDf7Mw7VCfAkp2aw6hrM16OSSyjKp12iSWqPEWGUC5DXviqKnnnw4MlZwTfvCyytB3Y+g==
X-Received: by 2002:a17:902:b186:b0:1e2:9066:4a8b with SMTP id s6-20020a170902b18600b001e290664a8bmr3398989plr.26.1714753198765;
        Fri, 03 May 2024 09:19:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902da8100b001e509d4d6ddsm3444220plx.1.2024.05.03.09.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 09:19:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 3 May 2024 09:19:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] hwmon (max6639): Use regmap
Message-ID: <23dd1bc2-1dd0-48b9-969e-725a5929f9e0@roeck-us.net>
References: <20240503120020.3450972-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503120020.3450972-1-naresh.solanki@9elements.com>

On Fri, May 03, 2024 at 05:30:19PM +0530, Naresh Solanki wrote:
> Add regmap support & remove local caching.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Applied.

Thanks,
Guenter

