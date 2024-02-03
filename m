Return-Path: <linux-kernel+bounces-51141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC647848707
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8AE1C21768
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76DC5F482;
	Sat,  3 Feb 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKLifrvG"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EECB5EE93;
	Sat,  3 Feb 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706973192; cv=none; b=StIN976ZCmuzqSeL9D2Tl9RRJQMFUIQbdNJViRLRduHbXZYMAjUpybp7Dci6k5CylSkBqOWX95XigSctQYk0TSz0yf2On/GDYjMGgoBpEpWLiJNbQdfQ1quRY4IsVqMyH65/xHpEaAZAm9RCMk/vI0KQraIpYwZ0Th4ZWQ257YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706973192; c=relaxed/simple;
	bh=JL+PSRmvVzKSLfAoJ77lkRIiOVNvdMZicj1Fohwv15Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDAzVSl5I0b5fIJQxnHVakDfVw/7SBjAQqKVtTeSGLfhbYTy3e7CmxXS985LwvhUQ/Gd5KhBDTLUcecCm1D2w91iEQiiXK/O1HURq2+rie7oufCsDvo6f55IApNfF6gyDjDU6StwbdjnN9A5/X9JtZAarAwvqjmtrYh78iVq5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKLifrvG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ddc0c02593so2218488b3a.3;
        Sat, 03 Feb 2024 07:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706973190; x=1707577990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xN9WkJF6hYDK+c2hghOyEcly1TR1Vl/4IjxK+gN4NfY=;
        b=iKLifrvG1R8gJKfxMY3GybZae1WvWo+ir4mzrpA8Zzz5riK8/FAV+giD/nKT/cqfan
         3RlSXFT0nH2Hm1JIC6zhqaQHCSdlyfMMft/zuP/b7SV6Ms17hcXfwLydJ8XFunq9kMEg
         Mp4BrN9kFDALCblRYIbtcLckABx0wq7y7CSVNn+t61WPtNBR+/XZj/sfinwoPWjfk99j
         umFAd4qAA0kf89UF2aZ5VXh27qAAsKYlaqn+YQIJYd0yIRU6BaKJHKdZlZIBqNTHMxyt
         DdhEgxvmOx5WEdd4r3YkYrB+TPDIDj4sMETk54955O49stLZE+/4/v9x3P5pJSPeAH58
         nvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706973190; x=1707577990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xN9WkJF6hYDK+c2hghOyEcly1TR1Vl/4IjxK+gN4NfY=;
        b=THR/HdlGa4RzDLSKkzeHnZrukJ4e/MgBvRxBiWLyXrJ6oNfukrsogPZIBeLzk51o00
         HHbczgA20AyJJPmgQXslg/qmZZaDGNvx54oDIk5pMzYJdIEKz2SyLWhxHvvp3upyOLYV
         IQF25sqW4ZfTsq/Sxpqshqqzm9K3gPuyFoApJYK2EDUTO5AYd/EZr4yzXRMvHgfwknqv
         CmyKU6VOa2xVNu8QAszLlfQJ42bEziwKlx+oKgFz4tILElTKpT4zbM2N6IK/js3pLmRY
         9GFiPgZ/r3dpRVQvA8L3O/JXQJG64qbW6I76BuogIo1g+3jlGZ/8yyJ3TFIimw/ydcma
         yKTQ==
X-Gm-Message-State: AOJu0YxHYU9b9cizGRXfHFP2wAN8t++SIlbyUxjyOdM9VhpG5XrrqTz3
	iSPS1hDsXehkw/1V85PxeL2ezKrhd0usaMciYUOMIJygUR6xJrlM
X-Google-Smtp-Source: AGHT+IGzclwUEWMRrB7qUW7wMZUYvN4KbDaWuMK5T/g9+YsyjQ0OdD5a6sVLWIN+82c2yQmSgWYBeQ==
X-Received: by 2002:a05:6a00:1407:b0:6df:f634:4f83 with SMTP id l7-20020a056a00140700b006dff6344f83mr6028980pfu.2.1706973189541;
        Sat, 03 Feb 2024 07:13:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUqYJZtF0397o79UzP467rq+EAXWG13ZCkuGdHXaZvG71bKhtaZ87yr7V3NXIZ4NLnCp5BZJCtLrJoXZAvzCQja+f1KOfybqtNT3eANB/oh3C1NGHWrKwehgCcO1ZoJWFzCG8l9NENaMXsUitkqyCf+tBUR8DPmy0MzKRMF+fceGoyC07gWeQIC/+j8+A9AY2PUVsF/oR5RJG2OiYXEtUeAn9txBrXtmxbbctnYemk8oyh5Ds1FoopUbq8VbebCQlvPAMdoP1SL+8aMgJzY4bn8Y906L7Ln31LNTfXN32Y/7cLg/RtQN54lUDUCa59F9HSRZWMxOvy/E5NQf9HvxxK8wFMxgvAksmEkf59tqFRV3Z2NYW+G73xa3vhzLN3x8wMHUy36RY81K4pEVeHwaPF2m3jCz70uno3P3cGWYzD7w6WbTsfyh5+Y4k1QcnWMyTsaTp214+GkWDcqFV0LYvNpHTpn028grAIXbj05NYX5kjklvxeBjCPgndBnHoKVcRCDnnRqSzIUu51mTEdzgvI1Q2nZjBdDxkTvpNq07AsalOaiJ1/HqSt0PGeI1zEQOfauB6xDTFgRiBP1M4kuWN+uKOY4VEfi4oA22jZ4Cmb+NicUk9EJt4J85246qjNKaH1aRLitgP0sJQ4VlP8CuzyKJtZ91RcILRYmL1NxX7ZW0w0nuBUyRqKtYA==
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b129-20020a62cf87000000b006dfe45dfdb4sm3671627pfg.74.2024.02.03.07.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 07:13:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 3 Feb 2024 07:13:08 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: jdelvare@suse.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, corbet@lwn.net,
	u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
	naresh.solanki@9elements.com, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
	BMC-SW@aspeedtech.com, patrick@stwcx.xyz
Subject: Re: [PATCH v13 1/3] dt-bindings: hwmon: fan: Add fan binding to
 schema
Message-ID: <e1b1c69f-a2ff-4fa5-80a6-3ff0a3de6ce6@roeck-us.net>
References: <20240124060705.1342461-1-billy_tsai@aspeedtech.com>
 <20240124060705.1342461-2-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124060705.1342461-2-billy_tsai@aspeedtech.com>

On Wed, Jan 24, 2024 at 02:07:03PM +0800, Billy Tsai wrote:
> From: Naresh Solanki <naresh.solanki@9elements.com>
> 
> Add common fan properties bindings to a schema.
> 
> Bindings for fan controllers can reference the common schema for the
> fan
> 
> child nodes:
> 
>   patternProperties:
>     "^fan@[0-2]":
>       type: object
>       $ref: fan-common.yaml#
>       unevaluatedProperties: false
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

v12 of this patch got a Reviewed-by: tag from Rob.
The tag is gone in this version, presumably meaning that there
was a substantial change.

I don't normally do this, but I downloaded v12 and v13 and did not
find a single change. Why did you drop Rob's Reviewed-by: tag ?

Guenter

