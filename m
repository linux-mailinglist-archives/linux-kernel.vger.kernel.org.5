Return-Path: <linux-kernel+bounces-51142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F368684870A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B29E1C20444
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335925F479;
	Sat,  3 Feb 2024 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi17I5i/"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381B5D73F;
	Sat,  3 Feb 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706973302; cv=none; b=ISiylRGaavFKFdNXXInyQRWYwz3ERB6trLTK4V9Hk+y1t7NDBHXTYI+cAvnYgHNPDs7SGcJ+tBgoDoIZPrERbxUHdV5dIXQ57dahALZhXOdDW6Ma7aqDK1aa/xXxiRTlSt5TsddnG/KEb28u9e8tYonwuOo8KcO1v3yOLlUOOeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706973302; c=relaxed/simple;
	bh=puqAONUd19UjQtLo17T/xtpxnued5tKsUnTK819XQbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0eVh1z3J3ciGP6BEk2oDVCgNZu3fq5WMOq+X6JfMghjgHlEOuwz07BXBSHDvnTAn/gv6uKPqTLvtTlAF5TS75NCG6zekbZqWugRo3rLKHfR5p6J9WvMxllSHOr09zu/Np9vdMvxK3Y0vd3bbMb3v7rBc4BPFw5QmpgeQR6mekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xi17I5i/; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5986d902ae6so1857256eaf.3;
        Sat, 03 Feb 2024 07:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706973300; x=1707578100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFuXP3UV1xnywaTqFOinvyF6IAzq5e2/c/XsGf493CE=;
        b=Xi17I5i/Lfz7l3sbVF/NbYRrRWsZ/CYbf7Mwp37aNwkuMnLgyyU+kdMOm/2QROjn4x
         43bAtuHuPa5KKfBHMjgrNQ6GatY6XqIVFVl/dsjgDahJ0TjpU0/iuWTYKHXEwBOWqbbg
         tFYea5Re0fo6ftSU++qL0/OBg9cOhG6wqgd5W/8CVVXua8HZxXBtaKORTMcTzaNapvuq
         qmhJymq5yJzDm/b8oZ/nc+OHz4yC310PBQv/StZauNdldGX5oVKPN+mUutBSHCJ0DSWn
         unQl9AfZCt8khTmejXPOtsflPR2et8TE6kA+zYf47S2rolQe1G0QCLe5feJKS2eu3fsf
         l9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706973300; x=1707578100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFuXP3UV1xnywaTqFOinvyF6IAzq5e2/c/XsGf493CE=;
        b=GnNLFkbvjGkEGCI7q4+lM1YU4xRZ9UGyDKe/eZXQx95Db67m4zKj0D3YkFduW884Vv
         VG4857g6RnlK/lRUQ4Bd9W7PljYjEPVdlSZcTfio6IeYTlb0JSZ9B6Fj3G/zgX4+tgCD
         O3W10SVdrRpxyInkJHKTdaaLIaORllOg0gJfDTZWUNHGeEGSBm7rZKgR0e0NZYorQe9F
         EeOABd7exBV4M4ueWPYS6dHpv5ie2AOKg4n6D3s2smcHxLy90xSFfsBfA5Ce8qrDJPy0
         mSczDIkQrWlihfbKMnOTBXiu22f1pjBeL4kvBb2SNhuRyTo38lwZdgn+0URWjlZ27i1Z
         O3kw==
X-Gm-Message-State: AOJu0YwHw+hSvV0w2KGL/g6+FtEyzuFMvzx1gvlUSHo7G7XVg+gutln3
	JqiNfcDuWPl+2Qw7kti2wnWzb9N4g4qkE5y/szd1cwz9OEyiPWPZ
X-Google-Smtp-Source: AGHT+IF40Z0pjbJVzRvxEw7OzgOmlZu9RvZZEAgaSfdBvk8bmmqKo0Aew1Kh+sLESnM1+9BvKO/F3g==
X-Received: by 2002:a05:6358:3a0a:b0:178:99cc:e52e with SMTP id g10-20020a0563583a0a00b0017899cce52emr11976858rwe.20.1706973300201;
        Sat, 03 Feb 2024 07:15:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXTS+Z3mcZ6h5OmaPznlOk7RjwoMElBSaLMG1YBYjQQ6o4PoiF+thK+DxD6vnP0WDdwlJcYAacZ070/13N631A0eQ13jBD3PxkyosoPkmu1XM8Q6IxFJXbbBwWEgmlQqoKVsOinluo6CwyRfvX0cjnAdzdzJrEGArzZVF9UWlrXf8/Ny2jMytCD4ORWzgFw1PtTati5JUiT3q+HCu0raH2R5Bu0CD4ctRKqPRl846UVu/0ji9It8ABe6m1Dmy1pu2x9BJTORKcrgrA3LOVGSY705xu9UchNnkG4By/PJuFFfogeb4k=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bs10-20020a63280a000000b005bd2b3a03eesm3658342pgb.6.2024.02.03.07.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 07:14:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 3 Feb 2024 07:14:58 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Hansen <alexander.hansen@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>, Loic Prylli <lprylli@netflix.com>,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] hwmon: (aspeed-pwm-tacho) mutex for tach reading
Message-ID: <a70d020a-6289-4087-81eb-a4d6ea339b92@roeck-us.net>
References: <121d888762a1232ef403cf35230ccf7b3887083a.1699007401.git.alexander.hansen@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <121d888762a1232ef403cf35230ccf7b3887083a.1699007401.git.alexander.hansen@9elements.com>

On Fri, Nov 03, 2023 at 11:30:55AM +0100, Alexander Hansen wrote:
> From: Loic Prylli <lprylli@netflix.com>
> 
> the ASPEED_PTCR_RESULT Register can only hold the result for a
> single fan input. Adding a mutex to protect the register until the
> reading is done.
> 
> Signed-off-by: Loic Prylli <lprylli@netflix.com>
> Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>

Somehow this patch got lost. Sorry for that. Applied.

Guenter

