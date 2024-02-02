Return-Path: <linux-kernel+bounces-50454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14F7847925
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9A71C281B2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D5613249A;
	Fri,  2 Feb 2024 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srjx66cE"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AAF132467;
	Fri,  2 Feb 2024 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900250; cv=none; b=DhzR1xuU9NQVZzFo4wv+hfDp8ykBZheGfC/9iLJ7oglpsMCcoJcktBwCOrIJQ5jCdyHnC2BrKvecPUmqb+IEa0SMUZVsTISHCCh2xDfJCgcMVPDikbQItilfnw9lsNje0fIQJGfYMXeZJvc/mnKI+R6agj3vE9koWWkUuy4ZnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900250; c=relaxed/simple;
	bh=xgVwURmpaREbuGNTt6tFNB8wnCoZw+LAgbWTnUdRC/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+PlxieqPouEyF7AdGJKJUbmay+QzGBHwIfsP6rKmcnp+uq+jnDr1CXOI2P82e5jeXo0asYR5XyQykSD93Un1NBtlBnWC4p+4o/sQDKVO6dZAcGdOlFEGqnYyZnvQErxyMj+hr8p9sKaxOPViQ90yOw3K6mXeHnlGwKDsfEiUY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Srjx66cE; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e114e247a2so1220921a34.0;
        Fri, 02 Feb 2024 10:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900248; x=1707505048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQm6u9cjTCPN73horp5oOw8hLR1Lrz8hvezbdiCBsgA=;
        b=Srjx66cEc6VXCa92enh5yyluQSJ9Y660I1CWZHKRnx4KDNSY7oL1jluYHuVWV4C1o3
         5WSqoxlaX3v5/1JblfKMtE7ssGix2mO+utX9xPMmOcjNJ4IhswPvcQh0V+OY7knjaDCA
         j5WvuXMWZSW4w7ZSl/k/1Aw+vjJ2dTi16NX5DhRgkbwPt32XP+vT/JSYFOc9KvhuO5yp
         6F2XomW3UJ9LW/CSq1oGc4P4STLPehPbrQVqs2NRi8QpUNlS2HVaXM/7UlMSi4fwBoAy
         kpDj6rB5LRTk40SDHejwH0tsZLeorPX8lsxAlHjtrC22Me0x+ed4WFujun3dip76+zms
         O81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900248; x=1707505048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQm6u9cjTCPN73horp5oOw8hLR1Lrz8hvezbdiCBsgA=;
        b=iRAti+vJRu0M4nN+y3nnHPstZTaRheK8HZ0gBCKJoxLPZYA4/FTL3ObHVU9txvt2PI
         D7REHy5onwrWpXfoPOPQabIE5edAlB5PgN13gKPhyuDaQCA+ed5qmvdcYDrOONeiPZcO
         pTEWmOZcNZvWAcQCLdzwhJ29msjwk2S5JuWAH70ET6T9jBOO5ydEWazVSAk33f/corZG
         mXxgEd58/B2RW6OBY3BRQO+Jrhtmh0BUZzmrBN/novS2AWxVwG2vwFKpNaA3Opd2wKOA
         TvpaNeTlvm7WI5RnIEaM4v2V5WCYh2o9PBQ0MezliMhw7XpHKss2kYxaMH5Fta8kh3A1
         /sAA==
X-Gm-Message-State: AOJu0YwbxFca0ODyi4cduvtixw2zpZJXsw00DlfpyqoyYZXWNnlLSDhg
	Nqx6tRfkkxig5BNU5OKZuScCFF0wkVWvQ+WoFtu/A+1gSYtgR8cR
X-Google-Smtp-Source: AGHT+IGIq3Wen03Tle51t27DFumWC4SUQBb9wygoWvxIZcR4Rb/kKgrnnEN6ISQKT8y7qYXsBmBRUA==
X-Received: by 2002:a05:6830:1306:b0:6e1:140d:2747 with SMTP id p6-20020a056830130600b006e1140d2747mr9684333otq.21.1706900248029;
        Fri, 02 Feb 2024 10:57:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWe0uwLt5hBb9MgiPcHc0H2vpGehtaaqmK4IXjtE8qUZTvfQEGw8KxTAlxFqAafH6sDpRka9I2y9is0YWcskXgCv6/LHWw9JA2ZveYtgD2Jb7mI2CzYDFPanEvFgk1JkVXTbI9SA2GI5XxDZtPxteuOQ9X3NDPZvriGmUWsnWfwT8EoJ9ev8LRUShGPeCard8mvTVeyqecXubOnhdWm4TYZpVewXFHGvyjpMV37wOR3AEtztOlg4p4Gnt3kmsHmq2WkWOOp9T55kBbVaQELBcx/o5RS7emDFl4cPoVMzaZREOQDxqPuN0Gs9+zJtgxNlgv+/e1ddiCRFyu9GkB1AoU92q52QclBInR5RGWO67NxtOT9zy7EcM1rFp9vgdvdSGYKGoQ+
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ca15-20020a056a02068f00b005d5445349edsm1843061pgb.19.2024.02.02.10.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:57:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 2 Feb 2024 10:57:26 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 5/5] hwmon: Add support for Amphenol ChipCap 2
Message-ID: <2b799fa3-a7f3-4077-a605-0cb19df4fc82@roeck-us.net>
References: <20240130-topic-chipcap2-v6-0-260bea05cf9b@gmail.com>
 <20240130-topic-chipcap2-v6-5-260bea05cf9b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-topic-chipcap2-v6-5-260bea05cf9b@gmail.com>

On Tue, Jan 30, 2024 at 10:06:48PM +0100, Javier Carrasco wrote:
> The Amphenol ChipCap 2 is a capacitive polymer humidity and temperature
> sensor with an integrated EEPROM and minimum/maximum humidity alarms.
> 
> All device variants offer an I2C interface and depending on the part
> number, two different output modes:
> - CC2D: digital output
> - CC2A: analog (PDM) output
> 
> This driver adds support for the digital variant (CC2D part numbers),
> which includes the following part numbers:
> - non-sleep measurement mode (CC2D23, CC2D25, CC2D33, CC2D35)
> - sleep measurement mode (CC2D23S, CC2D25S, CC2D33S, CC2D35S)
> 
> The Chipcap 2 EEPROM can be accessed to configure a series of parameters
> like the minimum/maximum humidity alarm threshold and hysteresis. The
> EEPROM is only accessible in the command window after a power-on reset.
> The default window lasts 10 ms if no Start_CM command is sent. After the
> command window is finished (either after the mentioned timeout of after
> a Start_NOM command is sent), the device enters the normal operation
> mode and makes a first measurement automatically.
> 
> Unfortunately, the device does not provide any hardware or software
> reset and therefore the driver must trigger power cycles to enter the
> command mode. A dedicated, external regulator is required for that.
> 
> This driver keeps the device off until a measurement or access to the
> EEPROM is required, making use of the first automatic measurement to
> avoid different code paths for sleep and non-sleep devices.
> 
> The minimum and maximum humidity alarms are configured with two
> registers per alarm: one stores the alarm threshold and the other one
> keeps the value that turns off the alarm. The alarm signals are only
> updated when a measurement is carried out.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

