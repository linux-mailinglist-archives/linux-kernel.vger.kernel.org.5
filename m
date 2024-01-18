Return-Path: <linux-kernel+bounces-30063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5CD83189A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4EA1B2132A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4247D241F5;
	Thu, 18 Jan 2024 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2erxiN+a"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF97024A16
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705578251; cv=none; b=Qv1/SnEqfg5syAXrm3LoQ3Kn99REcpx6mnBXBUsWaA1eNo0+V/CYcaZ6TBPoseZ2AFz+EdUid31Oelzg7J1wC8JAHAhzFcDJpCSTqbgLrQVaJOkKcsBh75e3UbnT/KDT3Qnm4HPrcPjg3+iq5A16cXdT4qVlVNavXGBdccp1y20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705578251; c=relaxed/simple;
	bh=TXhzczoo35a+K5387LOUu85eARm780theDy+utDYSSc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cbXHtV/aPlR6t3r1qPJDJLsEVRrGaW4dD741qmluvqGw/rmeWJm2BJUtILMHqjTWeEx7dn8mPe1xMJRKkdCir1YbkGyPWDIxcimrSjdrkdKynTv1+Za7Q0ek6IlJb/US/Q9CSmFihJb+eLQyIH92ddMAbXTk6SH8ClCbEn6WMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2erxiN+a; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e775695c6so34878845e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705578248; x=1706183048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9DkW5uoEoUxrAMeFqmakm3WJjGOpUAJrCM6+jSD1194=;
        b=2erxiN+a7JjJ7kproTTBLEPXwarsPSlUTBfFZj0GjVpp9FWYeJe2viziLTPuVMQLvi
         dP6lXKRGYwXgS5yLxU2exjMoDfBVtaOJUas52U55jZoLwi6D8bEdwtX82i+BEeNin4o0
         Ujv/if/kir0tBZoUGqJPQISeoxJNx8VN/bJNQ9Fd6+tPsJh3v+jDCcdxdmpes8ig0bbz
         f6mIqmZaEGMr9OhLD4RXNnWUFm/3Xf3bGuE4GlP0i4d2ZvV+MsxDcfZWtM/pWVspy/T3
         boUg30NcI4zZxGv/aSEJEwC1d7JOcHhkgmmATTc3gOB6kw+FrH67yOX76JnXiJ0bDzwo
         TmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705578248; x=1706183048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DkW5uoEoUxrAMeFqmakm3WJjGOpUAJrCM6+jSD1194=;
        b=AahUue+N5ZLNDm3vyJr+Kgi8Whnyomhcj3KcBMmc02bxxqtOdZq6zO/H82oSj3D5+W
         NmoHSiCFcJBv+6cOF5xwbVBg2kCEUDR66jL8ua40JzDujqcyAy5MYtu1R/4slYvVExV2
         v4KtryEWxRnpjfhEYqxBGe+cLZnyEejnHw5en9H2IkuABu86BYFJYX4sRoGTq06D16TK
         IVd+e9Sg3Tn5sNgSlSpuWZ1p76r7tuGLxGQYCdjsu+VOn27pdjmXXjYQV+397pO8/Svj
         /P1lIjAq6dYY7PpBX6esegMdAFQ4U9PTjC6FND2m8hXR6XdP54RU4CpvpY1ABMmiCB53
         sPNw==
X-Gm-Message-State: AOJu0YwO/lOl7y/Puea1GQ0x4NZCrAHl9iML7X3+Sq/lLY3LqYbvi48R
	vsCPEkUWemvTHjEIslA3uYbZFn1M4Kz/jVtEOKKRI9Fx706tZKpwteJuHznY6xQ=
X-Google-Smtp-Source: AGHT+IE3kgrKcFo10agh5B8BtEjSfObTeRYqoqAXsWfdjxOX7R8rTE30te4cQgydhlEGgLacjZkyUQ==
X-Received: by 2002:a1c:7c0a:0:b0:40e:66cf:81a9 with SMTP id x10-20020a1c7c0a000000b0040e66cf81a9mr477315wmc.111.1705578247918;
        Thu, 18 Jan 2024 03:44:07 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u21-20020a05600c139500b0040e4a7a7ca3sm25610137wmf.43.2024.01.18.03.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 03:44:07 -0800 (PST)
Date: Thu, 18 Jan 2024 12:44:06 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, davem@davemloft.net,
	milena.olech@intel.com, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, mschmidt@redhat.com,
	Jan Glaza <jan.glaza@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v5 2/4] dpll: fix pin dump crash for rebound module
Message-ID: <ZakPBmakH8BTv8Cz@nanopsycho>
References: <20240118110719.567117-1-arkadiusz.kubalewski@intel.com>
 <20240118110719.567117-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118110719.567117-3-arkadiusz.kubalewski@intel.com>

Thu, Jan 18, 2024 at 12:07:17PM CET, arkadiusz.kubalewski@intel.com wrote:

[...]

>@@ -443,7 +490,9 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
> 		ret = -EINVAL;
> 		goto err_pin_prop;
> 	}
>-	pin->prop = prop;
>+	ret = dpll_pin_prop_dup(prop, &pin->prop);
>+	if (ret)
>+		goto err_pin_prop;
> 	refcount_set(&pin->refcount, 1);
> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);

You are missing dpll_pin_prop_free() call on error path. It should go
right above "err_pin_prop:" line.

Haste makes waste..

pw-bot: cr



>@@ -515,6 +564,7 @@ void dpll_pin_put(struct dpll_pin *pin)
> 		xa_destroy(&pin->dpll_refs);
> 		xa_destroy(&pin->parent_refs);
> 		xa_erase(&dpll_pin_xa, pin->id);
>+		dpll_pin_prop_free(&pin->prop);

To be symmetric with dpll_pin_alloc() order, xa_erase() should be called
first here and xa_destroys() in different order. But that is a material
for net-next.



> 		kfree(pin);
> 	}
> 	mutex_unlock(&dpll_lock);

[...]

