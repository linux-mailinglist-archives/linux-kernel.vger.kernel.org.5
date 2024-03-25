Return-Path: <linux-kernel+bounces-117467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0750B88ABBE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7C02E1694
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ADB13958D;
	Mon, 25 Mar 2024 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMJ5D5GE"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2795476B;
	Mon, 25 Mar 2024 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384154; cv=none; b=luZD3n/HB8qvmqd3kw7iSsPHs0YswpzR9aZKiB1rgh8CF7Q5YOUWuxY+rGiP37vYLy9tJwx956Mo6tWEEdWkkBVrBK7my0JtzDZ6xMYBEVIefYWLzLvewarKqNaOqRCmr/cwRxuVmXHVHMohUM5Cfye4VQwJ/H2DQOtxTAyCqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384154; c=relaxed/simple;
	bh=/8oM3Th917fAGpmCBXiZiJmrfaImWwewXythWh0e4F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFzIzb5hsp5to3muTD7+mSb1i61T+fX1GY8GZJKFG9hGY3FYPc8I5irxHPwMd0hPm/xpu77c4NzBjY1GVxYvU0UzLDYegWffHoE77H5r15CpemnW5CA6zHkRdbyR2G2E+155d553qG6ID+ylPdaBOmfDC7kdXMSJs5AGbOpPiww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMJ5D5GE; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dca1efad59so2618370a12.2;
        Mon, 25 Mar 2024 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711384152; x=1711988952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bpj/BTgaJx8z0GaPglQBytrZ4ywz+wiusioKZQh7BT0=;
        b=TMJ5D5GE06R8ylYtYLWCmCKRtCh1Y9CUsOoXB3nS3/BjQkZ9hFeG+MBlWefGHNR6sg
         v2onGFdYLXaLQoRch2k73G2qvDOh6uhFaQbd77OBvsenXx4yoo66v1xA485i4J/Pwk5K
         x47Jnzc5W/shEgfmaLegXxS6tyL+QF5yh5J9e0F0w4K7M5Zo0tHhy9aG8uLhQKxpLe6u
         igY57qix2cHq8rre5qIlWqUfd5xt4bgA/XuYDyrAH18qQvazoPVJDyhjQ2u5ElLsFFhy
         LczU4VUuFk5CenEs5F+I5eVFBi1sJj5yhfq85vNVbFue0ptwcUGp8n+6DC50hmSCcB+H
         0ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384152; x=1711988952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bpj/BTgaJx8z0GaPglQBytrZ4ywz+wiusioKZQh7BT0=;
        b=k+Xt12y8Qni83hKhLowbavVVsJfOFhE9REzFrPo/InofSQ2mJ3ewn4eTgSxUUTL+9h
         CGG48gRK6wdATerhE0MJMauGo6M7gCxxaXv4J7Zxq0kWUKXnQZnVVnkCY0Kn5fVv+4ib
         o62DV8XKvxD1G5f0yy/SmPCc2RuS4aAlgqR3OQzu8cCIr7D8bRdsYYi/ueqXYKBRWxg4
         I42Nu0SZi3HY6JrepFLOlNftQSvckecaKhU7Zux7py4Y2uvzU8EZFttzfTDfSfzeE+jn
         Q5EDijbzmVmX4pTRyaKDT+pt0CmpyUoZr6CcnBvxpn9ceQ6JCvYn3A/d32ebrUD0y5Zo
         cnKA==
X-Forwarded-Encrypted: i=1; AJvYcCWmcML+Msf78ApnL1SdBPnS0CVIU2L9xDqiMbBASNQZjL/5M+Wx/jouMxaivCuyYmQfj2aGUkZwPsn42eUgeylSMN9xLrqk7709bBId+KiZQ8mpzMocczfsRJvFMX3Cntn2bFNahvayZck=
X-Gm-Message-State: AOJu0Yxf+/B64spmgh/fTAfFFw6GcR7UCpB0tiINpH0LBnpNfIm2OJAm
	jve6+OCDTDJTHN4F7JmuUOBqtdpA1rhsrpvGxCD4R/C1CS0imgaj
X-Google-Smtp-Source: AGHT+IHLmjLLjNqhbSMtyyvmamYDAgX/19CIZbN9P2HWv65RBw8fZjQCPkSqlFTzRLtTHaAfl3gD2g==
X-Received: by 2002:a17:90a:db91:b0:2a0:3dc3:8a8b with SMTP id h17-20020a17090adb9100b002a03dc38a8bmr4694096pjv.47.1711384152410;
        Mon, 25 Mar 2024 09:29:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id nr19-20020a17090b241300b0029beec8e86csm10417686pjb.36.2024.03.25.09.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:29:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 25 Mar 2024 09:29:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 1/3] hwmon: (pmbus/mp2975) Replace home made version
 of __assign_bit()
Message-ID: <e04c9300-b9e8-4ea9-8d4a-464f82cbdb0c@roeck-us.net>
References: <20240325120952.3019767-1-andriy.shevchenko@linux.intel.com>
 <20240325120952.3019767-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325120952.3019767-2-andriy.shevchenko@linux.intel.com>

On Mon, Mar 25, 2024 at 02:07:42PM +0200, Andy Shevchenko wrote:
> The newly introduced SWAP() macro is quite generic by naming, but
> moreover it's a repetition of the existing __assign_bit().
> With this applied, add a missing bits.h (via now required bitops.h).
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Not sure if I like __assign_bit() more than SWAP(), but at least it is
"standard". Applied.

Thanks,
Guenter

