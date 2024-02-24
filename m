Return-Path: <linux-kernel+bounces-79757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 318AF86264A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7CB1C212FE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97C547A6A;
	Sat, 24 Feb 2024 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loyfzEqo"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E23E493;
	Sat, 24 Feb 2024 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708795344; cv=none; b=W//ScNJ0uDyO7mTtxOSQ790ufTIE7BXilMpOYXdMi9RnNYm3L7LPpiISLril/MXY0Vi8iT6bC9I8AhDZWgvC1vkS8XTwp/MY9gIhEr9YH7xdEo0Z3UJU1sfQaCNNiPwFRQGXxWTs4tgNj8RO/i378qVdErnUQ5Jxox8eINwjs+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708795344; c=relaxed/simple;
	bh=riz6Xex6+r7bkRBfwqFfExsQZzaMsAuLMy8VUuAlfqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAtgP3AvWgjXeCSvQIRD9ytChbzLtaFifzc+3LddNAJpdn0XU6dJ5qS9DummAGqkx6NDxvCY4fpDq0lHsqGOUmL6GT/v/cP3A8w4zqXMJJzMSurbPjG1SKRN1NJyX1Ov3xEvkyT6BPpj8FlZvYgXXS3jf4KIadtX3MXf5fPrezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loyfzEqo; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a027fda5aeso1010251eaf.1;
        Sat, 24 Feb 2024 09:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708795341; x=1709400141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjI3fDhJdgaf2sbT9CybcTVjHLtvdodJIpInpRlIJHk=;
        b=loyfzEqogG6zhjLt7d5a975pyVPKm/5u81X4n7XC1uIAWYgpa+b9VWM8dkzpnL/hHo
         bQZiDKBaPWpK4EY7iC0xddt3yqh03m4PHeB16rAeWvxwyxXLE9a2FztI/Ri1wzD4S1vx
         EAMvvfd1+29Imf+B6uTuCoJOxK422iLYlA7ztAG3WBT6K7E6DUik+SJEoCRoMYMOjdXC
         W1TcZjFdrkFSA/DSF7yhkQecWSECPPHRRp4VMZawPnqzm2wkyRi/2CQSqtCDb7CrFfjx
         gZLyLw93XSBigbN8mXg71i0CjZREwyGHbYJynZ1xHyZpWhl54A6G3Ml8hz5lsDS1BT2M
         KWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708795341; x=1709400141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjI3fDhJdgaf2sbT9CybcTVjHLtvdodJIpInpRlIJHk=;
        b=u2C9liFg1Amudo+8UB5EXUJNtkCDYIcbhv1SAPVuiftozWUuDPevOKFc3Zth8Zr6Y7
         1W6SIFajroXZm26NmfzODvoCsWgjUir4tNeC+eQb2PUD4qwAO3IDRZG1Cprka4QimGpg
         o/tllWEANZZzm/kT5vsMM4FgoNqHoRWeehqtRsekxgXusUvOIxXjM5KLUs9LSqHEXeZK
         bsN6AX1WFwJPWyuryGKTpl7y1c23FZsmd9VB1gGMaKEg/o79BDlizeMrrMoZJeDbYkcT
         4FYq8RBbjCSf7vMvxmCwkUjUlb6U/GJ9YunX/HMyxPdoVc7whAKoqynDcbsVEfn6ZN7E
         5xZA==
X-Forwarded-Encrypted: i=1; AJvYcCW7HQxblnf/7xpoUewwjLp/1NGz48yb2H/hhekWc1kqD1eAik/95uENlRYqWkSvO/GBDuwjBrSaCs0oANECcJUmrFzI5GOXw67rptlOQJhrDI3ohDgQgmQSz8BzEqyWnveWDW0vPChvfr/OW/eZM08MHIA2iDI08/D+1lg+V+kBetNVaQbf
X-Gm-Message-State: AOJu0Yyy9IdhpQ27qg36dNLP9BAbNi1Y/2habcOxDGf9z74cnS1Y3TiT
	aLYe0Dyq3IgayYqn/6cLQSXQpDz55na36kkq5T+zIugydwq/N5fA
X-Google-Smtp-Source: AGHT+IFQRJOjjl0t10c32jJpjOHMVYdDwG/FtpXvQKL+er2fcNcQjPLQdEB/eznmrJ6WRnG+xAUHkg==
X-Received: by 2002:a05:6358:b3c8:b0:17b:583c:c4b7 with SMTP id pb8-20020a056358b3c800b0017b583cc4b7mr4514685rwc.3.1708795341453;
        Sat, 24 Feb 2024 09:22:21 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i5-20020a635845000000b005e4666261besm184793pgm.50.2024.02.24.09.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 09:22:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 24 Feb 2024 09:22:19 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Zev Weiss <zev@bewilderbeest.net>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] PMBUS Regulator cleanups
Message-ID: <1a120a6c-ca15-4ff8-884d-d98fa28b7f68@roeck-us.net>
References: <20240223-moonrise-feminist-de59b9e1b3ba@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-moonrise-feminist-de59b9e1b3ba@spud>

On Fri, Feb 23, 2024 at 04:21:04PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> A v2 of Guenter's series that changed the name of regulators registered
> by PBMUS. The documenation (offical, not bindings) doesn't call the
> output Vout0 and there were no bindings for these devices that allowed
> regulator child nodes.
> 
> Document the regular child nodes for the TI devices and allow regulator
> properties for the infineon ones.
> 
> Naresh is already working on the tda38640, so there's nothing for that
> here DT wise.
> 

Series applied to hwmon-next.

Thanks,
Guenter

