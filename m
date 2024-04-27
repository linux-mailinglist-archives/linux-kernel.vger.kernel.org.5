Return-Path: <linux-kernel+bounces-160877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FF08B43EB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 05:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C30B21E4E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 03:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57513BBF9;
	Sat, 27 Apr 2024 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFS/ULaX"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB874374C3;
	Sat, 27 Apr 2024 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714188119; cv=none; b=ZSsxq0O1CookP+jcISLINHF/EZA+z/wrsmvDI1WtArCHlS9LY3yM/G7jWvJ3MiIHLIxXYZOKOc8lwMXeHUU9G8FNguQ/dPY8qrqc6k3wns/qs6JNJw3yVhWAwAkT0ngQNzMelt/Y3bky+Nztny5LcXyaegPQH75sFZrQFmSkYl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714188119; c=relaxed/simple;
	bh=hIwZF+sC085Vr0r9GvhS9ISzHFgm7sRbQ+ivQ3g0R3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgzptsuqWCjisaEJulR/UcVMkeasqMwrctCsV2HumCDRaCQujHvP1iyIJmwtWqrMNg8fdon7e0TTuADc7rASPA+AAZpc/YFvmgYyqBciDT8nR7ldg1RckKKjJN64qaEzUOJz473KzTlgc1fIJj/6pXwEErbCCAzklzK82zEUSak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFS/ULaX; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61587aa956eso30524837b3.1;
        Fri, 26 Apr 2024 20:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714188116; x=1714792916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RUUuVGg/SnTpcYpDAcB9MZTXxuDZ2REJ7oy7ikLy09c=;
        b=cFS/ULaX7rSagTzi+ayGdDxql2g3ElsoHbeVI+2cLpTifymH5XiI+3ZgH8jWp9zugc
         aZGIdei4JNPWMJtN8FWeAhMRsT1sH439eCFcABIKApJCYdaVILqqKhARNus6mflTQtSJ
         h2A55S3PTdBgtxfp7dXzd5T1aCQQZGZxC7I/AsgIy/BqQeYPCdnhoGhRGqPNqQVC6mj+
         Zw1bbCQdCJqPhSqvDZKL94yU5a3D6nvq1OMQYHCBrNtHSjQjOI6dWP5qAlbKrMRjkUNf
         b8Lv1gnomILpskFjQf1UGRTfVQvN0fKR+GI5IfuT8kWAiDxlTNPyFznxPjhKTZtUMRP0
         qI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714188116; x=1714792916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUUuVGg/SnTpcYpDAcB9MZTXxuDZ2REJ7oy7ikLy09c=;
        b=DbiZ3VbtWZLjs0bMWi6chi/4pk3LjTMN3sX6FTdft07GKyYxqpuhyq8TTlwFSTUAEQ
         dDGxB/hlTsKECaHdpc3KkpTcBzTy39AXO7AvES1hMCIxUmkvoU7ALMpGdQSyi44uObIq
         qHXnG81XUktN85YOpob4LAAZXxLtly18Q4BgcoMVA02keXhwIj/EhSieC4catyvHIO/E
         rjaTlHi95BhQ1qA23+vqgtkbypPSJ+4SPoeoSrI7V6oDYOoJn3ty3CTPD3BsE4Bh5lCl
         LPj4cS1944jrk6Yk8Kblbh0O7tpRTybFigeFJO4xV34dsCPsRBEXOfHBLh/3nV/B+A2t
         wG/A==
X-Forwarded-Encrypted: i=1; AJvYcCU60UEdEntjWqYg1vstgLMlEhb0dgHD5kUg0xouCu+KPFXnuABQkltWoKuBjcBCCFWP0/kxRMP0YBJAgiUxbIlb/Jtjs5POlMYah9jtipGI96BkwtXl2KHVUOui7EOwr2lsN7FgrgKuDOo=
X-Gm-Message-State: AOJu0YzEzxGDVLVhWtRnw0siAcCySTJ7mO+XvGOXT/39Ax+wR7oK0wD9
	aqSyayW5XitMxk35lWehTNnamuWXohHip2H/ssu5CWBacgPt/vlO
X-Google-Smtp-Source: AGHT+IFRCXQq0LR1NVgLKhfkiN+fon7vvAmErPX4sJrlb9HVcw7tWFqTXBKnFQhlftZOhIYXIpKzAA==
X-Received: by 2002:a05:690c:6089:b0:61a:ccfc:4543 with SMTP id hg9-20020a05690c608900b0061accfc4543mr4233674ywb.47.1714188116469;
        Fri, 26 Apr 2024 20:21:56 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f5c4:246f:8229:da0])
        by smtp.gmail.com with ESMTPSA id d14-20020a0ddb0e000000b0061871ed807fsm4407114ywe.32.2024.04.26.20.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 20:21:56 -0700 (PDT)
Date: Fri, 26 Apr 2024 20:21:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kenny Levinsen <kl@kl.wtf>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Radoslaw Biernacki <rad@chromium.org>,
	Lukasz Majczak <lma@chromium.org>
Subject: Re: [PATCH v3 1/3] HID: i2c-hid: Rely on HID descriptor fetch to
 probe
Message-ID: <ZixvUNooESC02cJK@google.com>
References: <20240426225739.2166-1-kl@kl.wtf>
 <20240426225739.2166-2-kl@kl.wtf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426225739.2166-2-kl@kl.wtf>

Hi Kenny, Lukasz,

On Sat, Apr 27, 2024 at 12:47:07AM +0200, Kenny Levinsen wrote:
> To avoid error messages when a device is not present, b3a81b6c4fc6 added
> an initial bus probe using a dummy i2c_smbus_read_byte() call.
> 
> Without this probe, i2c_hid_fetch_hid_descriptor() will fail internally
> on a bus error and log. Treat the bus error as a missing device and
> remove the error log so we can do away with the probe.
> 
> Tested-by: Lukasz Majczak <lma@chromium.org>
> Reviewed-by: Lukasz Majczak <lma@chromium.org>
> Signed-off-by: Kenny Levinsen <kl@kl.wtf>
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index d965382196c6..6ffa43d245b4 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -872,12 +872,11 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
>  					      ihid->wHIDDescRegister,
>  					      &ihid->hdesc,
>  					      sizeof(ihid->hdesc));
> -		if (error) {
> -			dev_err(&ihid->client->dev,
> -				"failed to fetch HID descriptor: %d\n",
> -				error);
> -			return -ENODEV;
> -		}
> +
> +		/* The i2c drivers are a bit inconsistent with their error
> +		 * codes, so treat everything as -ENXIO for now. */
> +		if (error)
> +			return -ENXIO;

I really think we should differentiate the cases "we do not know if
there is a device" vs "we do known that there is a device and we have
strong expectation of what that device is, and we do not expect
communication to fail".

Because of that I think we should have separate retry for the original
i2c_smbus_read_byte() (if you want you can make a wrapper around it,
something like i2c_hid_check_device_present()", and if there is a
concern that we will run into similar issue on resume (either from
suspend or from hibernate) then we can have similar retry in
i2c_hid_fetch_hid_descriptor().

But I do think that i2c_hid_fetch_hid_descriptor() should not try to
clobber the error but rather log the true one.

>  	}
>  
>  	/* Validate the length of HID descriptor, the 4 first bytes:
> @@ -992,17 +991,9 @@ static int __i2c_hid_core_probe(struct i2c_hid *ihid)
>  	struct hid_device *hid = ihid->hid;
>  	int ret;
>  
> -	/* Make sure there is something at this address */
> -	ret = i2c_smbus_read_byte(client);
> -	if (ret < 0) {
> -		i2c_hid_dbg(ihid, "nothing at this address: %d\n", ret);
> -		return -ENXIO;
> -	}
> -
>  	ret = i2c_hid_fetch_hid_descriptor(ihid);
>  	if (ret < 0) {
> -		dev_err(&client->dev,
> -			"Failed to fetch the HID Descriptor\n");
> +		i2c_hid_dbg(ihid, "failed to fetch HID descriptor: %d\n", ret);
>  		return ret;
>  	}
>  
> -- 
> 2.44.0
> 
> 

Thanks.

-- 
Dmitry

