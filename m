Return-Path: <linux-kernel+bounces-50468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FDC84797A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D362328651E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F183E15E5B3;
	Fri,  2 Feb 2024 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsJ8bUb7"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB28315E5A6;
	Fri,  2 Feb 2024 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901106; cv=none; b=YBs9BG7YDRQ40Glqj993qNUoP84l0myWJmGikY56P7Up3xH0fBq8fWpcQTagCfVnSfHJ2K5S0G/7iPYZmyBIK/jv0oFgTS5r+zK8OHW5k9S3yD/cyA/h2aDVbegZOhiAr3I/kSnMdA287VnTMLo+QIjPyYbKgb9Zoh7V40ARG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901106; c=relaxed/simple;
	bh=q5KNBqqcafn3ahNbkQbhyCw09Yh+OzUNGZh8tX0xvNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpj6fvTGxNOE+BD4PX3k4QaB1jT7nF45fNubHSfVSiqBCY/1UbMqEQ2uCkFA5WrL+FsGSwTZ9Pn7vwZ3XmQZfMfssJ9/C3n4m0Q7OgegQs0sxucMC75MA5dqMTpwKw7z1tJ+/7DTtrigELW+xc8qZTM9mQXQLrZYae9wz9Qg/G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsJ8bUb7; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c66b093b86so2687631a12.0;
        Fri, 02 Feb 2024 11:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706901104; x=1707505904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8voAivQCcRHdUqrKRkKtyLZ7LbVIcLKqD0u5mJXYGk=;
        b=GsJ8bUb7Z0pOy1VUf42JkEilttGwCPF3MDtBmEeIujKAqavTm6r9i6NcieKIAVlga+
         +AWmhX+b9PUqAp5K1/FaSE1UCHb1pbGN0OxWnWFv+udGNnCQD0qyAfZ1Wec+jXWDMvM8
         jU+Ry9vE1AeIxSBADPX1TszXIubo9OfTVPC9Ajvw3u2MaZPrPVJoXMgN78AldbeqKGnI
         jYA1WvjPZ/CuEEcJOILFvuWeF+aoGjAGs7j5NxydBV7cHfqIsRm7Q5oMT6IH/DmqfBPN
         2KV2AZAPo8WIi3UTW9d/Av4rFnpNJ/aIJ3sX7+RfAcgejwblcBxhsVJA6b7xsWV0KVWH
         ZwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706901104; x=1707505904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8voAivQCcRHdUqrKRkKtyLZ7LbVIcLKqD0u5mJXYGk=;
        b=CtNhrTRkjd5RF/+GkwLy5XUNXPUP4Hpog/eATBlKpTGVB5N3A+ZMAUbqwh3NyCzMOy
         KOYqo16RJIJuhW9QUKYfDi1vX+3bpzdq9lzrF4ZZuVdgsWISffL+NLhIeHEyC2hulQkN
         pUkrD9R98vf4deJO3WaipapGrMrYnWiwGJobyVyskTgrIZD3EgfZcAz3Sa1QNmNzUQ2S
         OXZ00HRqc+aSwqGCv9hj5uVpE5Pin243VgEuz1i9nnlUTsgonueQ//ca1tvKpxrYlvJb
         mRIcGjErJZsfSyJcQglA1Ah7PsQHod6jhLEJxtSBq+AAmtl6SBM+0axH+c40B9C434Wn
         ZaWQ==
X-Gm-Message-State: AOJu0YwnTDoUdj6Y2m6hTgpWm9mgGndMBwpppH5avVfVEuLuzJup7upn
	Il9SF4HOZJNhGOu7X1F6vkA8A3vOI3E8Gj98NDgyViGLXkFDDOm3
X-Google-Smtp-Source: AGHT+IE7Y/272LUKics1gOG+Sa7eg9AZ02PIKd/Sk7i9JURQY8sh7zd4/dFrXvR6p9oipOIcFUiUeQ==
X-Received: by 2002:a05:6a20:e607:b0:19c:9e7d:3f4e with SMTP id my7-20020a056a20e60700b0019c9e7d3f4emr4713399pzb.1.1706901104098;
        Fri, 02 Feb 2024 11:11:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXJnXZsM1mPCjRjsd+jkzFcZqyaix8Kk9oP6VrHHuYg7ykBXnlUmjp+XPLU0XnSkIjCUsA/5OWepdj+JOJzIMvAcqISesMoxMY7YUD2Vxi2mP2CRdLDRXkYgH6sKS965CpQWRY+eyqRQ75xDO9nFNmGILRfuaUCaYJzNGgfcBJEVMVTGsKCEWPFtv/oCa2YVkZMrdEQKNuFxXaCB6WNgwy+Nn4y8bDhMQ==
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g19-20020a056a0023d300b006e025030700sm292981pfc.190.2024.02.02.11.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 11:11:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 2 Feb 2024 11:11:42 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Aleksa Savic <savicaleksa83@gmail.com>
Cc: linux-hwmon@vger.kernel.org,
	Florian Freudiger <florian.freudiger@proton.me>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: Add driver for ASUS ROG RYUJIN II 360 AIO cooler
Message-ID: <903cb262-719f-46f7-9029-43dd5be5c798@roeck-us.net>
References: <20240108094453.22986-1-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108094453.22986-1-savicaleksa83@gmail.com>

On Mon, Jan 08, 2024 at 10:44:50AM +0100, Aleksa Savic wrote:
> This driver exposes hardware sensors of the ASUS ROG RYUJIN II 360
> all-in-one CPU liquid cooler, which communicates through a proprietary
> USB HID protocol. Report offsets were initially discovered in [1] by
> Florian Freudiger.
> 
> Available sensors are pump, internal and external
> (controller) fan speed in RPM, their duties in PWM, as well as
> coolant temperature.
> 
> Attaching external fans to the controller is optional and allows them
> to be controlled from the device. If not connected, the fan-related
> sensors will report zeroes. The controller is a separate hardware unit
> that comes bundled with the AIO and connects to it to allow fan control.
> 
> The addressable LCD screen is not supported in this
> driver and should be controlled through userspace tools.
> 
> [1]: https://github.com/liquidctl/liquidctl/pull/653
> 
> Tested-by: Florian Freudiger <florian.freudiger@proton.me>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter

