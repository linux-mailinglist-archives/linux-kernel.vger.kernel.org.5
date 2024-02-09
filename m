Return-Path: <linux-kernel+bounces-59501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ED184F810
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87560B23948
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7CE6D1CC;
	Fri,  9 Feb 2024 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRrW5yS2"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402EB374CC;
	Fri,  9 Feb 2024 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490902; cv=none; b=hFNsi/Ao2W+huE+UbjRpN49DLiLgmJdYRUZU6AQ2H3o8KfCtMTfXY6o1sBnPufiPB5gc7FXqhYCuXZAMBqi4PmvC/kwbvNrMx4LwfiVkM3NO7regOA+WIMg8h48LLVVSRWxb8EyDmEFiGr72MwVWeEkv/bi7FM4KgQNKQbGBqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490902; c=relaxed/simple;
	bh=1O4u+GhlkOZiDsbASWskmjf2LYR3/pZHwDLQbk9WsJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir2lJBrLqK9t3nPEnJ71nreVFPYf2IsqKsoRbN64rE5xyZxYxJVHzJpYgZrWveHyzArcyx01wP8dIX1TeYZIBLF9xOnT0zoXExsAyCCnVG7LXCKnk78viwQr/jpojyy8lFXIe9uxNzTn3Ufr6RU1nl77PGyPnp0Ds47ijSA3IUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRrW5yS2; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e12d0af927so649283a34.0;
        Fri, 09 Feb 2024 07:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707490900; x=1708095700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sl0iYs91RSXEkh+s6/Oc0FnKucVhPk4Z5V9OL1byHYI=;
        b=fRrW5yS2SO3y/3M/JRzq9sRMQczuGI6G5doCr/YKraG7QJ25auSdTEqg+wQ6SCv2XG
         pwpaSlqhaNO5D0sudeWc36qC6v199cFHfOS2v0SYCP1Z+cxPB1GWVCSlZf/qAjiVLRZE
         SqQjvTd5pswjAzrZyKHfcaZWLvjScfUhrLCFbJPkZUgEUAj+Jty0sJM9j3UIVrqPjCST
         t/pDk1c5WOw8vGrZRYnSpABIZg02l9mjPIT70O8mR0euGr94X0Gft1j/2frpHuikCbBT
         ycVBDolEoDkSTptUXmuI7iFpOh6kOhBzfXxGNDb57E0CITfDBWlBxGGI9SsctG+r59Wx
         +5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707490900; x=1708095700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sl0iYs91RSXEkh+s6/Oc0FnKucVhPk4Z5V9OL1byHYI=;
        b=MHqNzN9oAkh2RJ3JfNIxmnF6xMOQKFozd9wnxdZlxfSl1m2wdumnTEenBxitr1mwgt
         lhGvT2+453mdy1ssZDobdy2oz6JK5vXXuuyI9iEDqir0/N1AVZeLpVfE1xIcUv0Lzrii
         61/ywGZr5jcRavd3G+g4HySjsdslN/hONxSMFUW6w3HG9l6I7+yh0B9XHhiwsa8fcKiK
         PgghuCCCyoq1uj9airSUj9GNs0/VBD7+SSvY76QVkaLi2wWRrpcieSAGSsNEouKbC2ei
         8OoWLvdnN7JHVI91SYNwU9i0w8kYhdzUun2+9GiikYdZqNn5ZLDfMAHDPuuZe286xy5V
         SkXQ==
X-Gm-Message-State: AOJu0Yw03WeSWvkKixyLbnKeIbqrsEvrQWh1rMGs980oTfyYavfwYBlE
	7zRh1tQ5BCAIq7T/lw2YDwXk8gZhYjVJhWCdCESfNF1dRboA7rwK
X-Google-Smtp-Source: AGHT+IFBlvksWx3flEKu0PAeGVCxJokKw3Inl6JFeIQI9RaHK0Y/0Ao70cA2LGvwKmjoyDWi50WIsg==
X-Received: by 2002:a05:6358:d38e:b0:179:272:6c5a with SMTP id mp14-20020a056358d38e00b0017902726c5amr2065308rwb.19.1707490900052;
        Fri, 09 Feb 2024 07:01:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8fxySuPlUu4r/neWiR79OUQXDPca6Cy29IS1V/YrE2oYEHPmAsunhfNSVgFzsU1u9zxrhVjgpo0Zpevg7EnOcMOdi2pFyonEltR4G8+T/ZOrT0pQUDVV0q6M0CuR6XrSTKXFc8II9Ky54+YseOmiKD2fYZ4wxEs8Nb7mcAr+NzZv++GqDbfeHsFv3Ui28B0lfRzTZIBse
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78510000000b006d98505dacasm593735pfn.132.2024.02.09.07.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 07:01:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 9 Feb 2024 07:01:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Sebastian Kranz <tklightforce@googlemail.com>
Cc: samsagax@gmail.com, derekjohn.clark@gmail.com, jdelvare@suse.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] hwmon: (oxp-sensors) Add support for Ayaneo Air Plus
 7320u.
Message-ID: <41928b42-4272-49a7-8c10-e63059fba72c@roeck-us.net>
References: <2a6ab115-9775-447b-adf5-d63043548c74@roeck-us.net>
 <20240209090157.3232-1-tklightforce@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209090157.3232-1-tklightforce@googlemail.com>

On Fri, Feb 09, 2024 at 10:01:23AM +0100, Sebastian Kranz wrote:
> Add support for handheld AYANEO AIR Plus with the same EC registers to add proper fan control.
> 

checkpatch:

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)

Also, there is no change log.

I fixed up the commit message when applying the patch, so there is no need
to resend, but please keep that in mind for future submissions.

Thanks,
Guenter

