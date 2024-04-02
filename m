Return-Path: <linux-kernel+bounces-128788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82374895F8A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378361F27D36
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4618515E81A;
	Tue,  2 Apr 2024 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRX11BvT"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7115E1FD;
	Tue,  2 Apr 2024 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712096256; cv=none; b=ATFVV97+EXf6evbGpQHv1EQkT8Ps0TuxUuS0+zpS/UqEwLW7qJAZM2FbjeJDlnlGUUnFmby86lgK1wzd/p1ROXqy33JOVp9/FXzb+vQBOzl7lhSVl6XBlCZGK7VS2BghlyyDCMt7JqrPw9nKLOksL+nh4fzzH2w1UMg3Gd+bRcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712096256; c=relaxed/simple;
	bh=I1SS2EYHeKThx7SBcEsrCukx4A/m3YQjVwFFscGKb7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVSbgpeBzDvx4Z0yx54sCoK/CvU9oX8Bw14yeZznt984G5xGIzgf6twhSPJ2QJBkXr0X/gv88AzBUtSl40q9tRJMhW1unh0LtySqzlkhKdLi2USH1jqJhou93e05Y8Nmna7K2cON03/mTaZydxSYo2N3EGputifIERuZJ9JcJ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRX11BvT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e7425a6714so4720479b3a.0;
        Tue, 02 Apr 2024 15:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712096254; x=1712701054; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fYOqDUYU14d+HKeuMfI8yAvYETR9CFmfgJMPALruc3M=;
        b=gRX11BvT/ecAERBJyuaeMbAbgpxbBK0/kK9qEolhuQPWeAfuYfrMonDXFi/JT7V+eq
         jQbNcEhPW0eBNBycOflieSKLEdZXznaPwEyOL7F506J8WEpmgp+EbMGf+N7DYH07cY//
         TE8g7oeZQZviTk6trhSI7UJUGMepBuEmZ2ZOG67/y1Q9cxUqLFxMeKpMl5e7qdVa730w
         hT6YVkhsCuw5z0x8ehJyD3iBLxDD3g7L87zddeKEE2UD6t7NbA6Bfi7kPtV2HZ/TWkZ1
         ljd/C+Mw51L3L9tVKPDCUSWSdHVuzJCxruUSDmEJ6N2CPDAuNnSWpgVp9VKgD0puD1L+
         GX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712096254; x=1712701054;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYOqDUYU14d+HKeuMfI8yAvYETR9CFmfgJMPALruc3M=;
        b=mrYlop1L0egnLClFY8UWYqLpbFlTS1F8innESx9G1SsI3cS/kv3Q350g1HgGDHkFFu
         QokgVimUDLOK2Qt4OjR/3UnPLRZlay8/M3Xz8bqe/s3+VpewaVtR3PjmgJCwqOnqKbrk
         NM5PIrfjWECoRGkh+a+KKnNE2AAcsZMG+Up+R4KL3RGK2yh5HTaKp/6wPx/4IVWY/ZmA
         g5V0/OD5lvZKU3S8auv4oy/NEP8svw3u9H/0fj669wqwIR0m3uzSRxhAEP4qp+A1sB5s
         0tWT3YpWIkoej+iK9lqcePAyRym+OGCxvqtxqniC96IEnsfs2Kd92Ig6mD/g/69nVICd
         Retw==
X-Forwarded-Encrypted: i=1; AJvYcCXk7fjCqcH8gDItP8htoXSjLZ+hpdhh4deSeJarsuTLgOe6gkcGNgjbOBNva1n5VAhImjQbL5EqsiX0fCPvNKKloj2xAFd4xygrmAmB/ptmMT1CzbyCzjJ1r5MXWJwbjwgQdvG4eGL6GAg=
X-Gm-Message-State: AOJu0YyaEYFGaEkGMRzQ/zy1NcPLgq4m1fLxCheXrsZgd36/1pgX4rau
	d2trnh8wd1CSwqpGLF3i9+i111zy1uxMcXmteiHMpR7ZhToDWKxq
X-Google-Smtp-Source: AGHT+IFUuET2kH1Eihd9g4y1585pgzr2R9iU6IYcNA4yZUeVLHoWOnLqlugXCo0lssdNEZbcxPPvRQ==
X-Received: by 2002:a05:6a00:9295:b0:6ea:ad01:354f with SMTP id jw21-20020a056a00929500b006eaad01354fmr14121172pfb.18.1712096254022;
        Tue, 02 Apr 2024 15:17:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c21-20020aa78c15000000b006ea8c030c1esm10297976pfd.211.2024.04.02.15.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 15:17:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 2 Apr 2024 15:17:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "jdelvare@suse.com" <jdelvare@suse.com>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: hwmon: label vs temp%d_label
Message-ID: <2dabfc85-3f87-4dfc-a7d4-9c11bc5b357e@roeck-us.net>
References: <9a09bf46-d097-4e5b-bdb3-cc9dc6f5d01c@alliedtelesis.co.nz>
 <fdd952dd-2f3c-4f66-8e73-68f1dadde237@roeck-us.net>
 <448b5cfb-b433-4b38-98ae-066bda44f1fd@alliedtelesis.co.nz>
 <9f58389e-0eb6-4ff1-9152-aa38dbfc5f8b@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f58389e-0eb6-4ff1-9152-aa38dbfc5f8b@alliedtelesis.co.nz>

On Tue, Apr 02, 2024 at 09:57:44PM +0000, Chris Packham wrote:
> 
> On 3/04/24 10:22, Chris Packham wrote:
> >
> > On 3/04/24 09:59, Guenter Roeck wrote:
> >> On Tue, Apr 02, 2024 at 08:24:37PM +0000, Chris Packham wrote:
> >>> Hi Guenter, Jean,
> >>>
> >>> I've got a requirement to add some meaningful names to some hwmon
> >>> sensors (LM75 specifically) so that we can provide some indication of
> >>> where on a board the sensor is located (e.g. "Intake" vs "Exhaust" vs
> >>> "Near that really hot chip").
> >>>
> >>> I see that the sysfs ABI documents both "label" for the chip and
> >>> "temp[1-*]_label" (as well as similar fan and Vin attributes). The
> >>> latter seem to be supported by the hwmon core but I don't see anything
> >>> for the former (I'm struggling to find any driver that supports a
> >>> chip-wide label).
> >>>
> >>> Assuming I want to have a label added in the device tree to a lm75 
> >>> would
> >>> something like the following be acceptable
> >>>
> >>>         sensor@48 {
> >>>           compatible = "national,lm75";
> >>>           reg = <0x48>;
> >>>           label = "Intake";
> >>>         };
> >>>
> >>> I'd then update the lm75 driver to grab that from the devicetree and 
> >>> use
> >>> it to provide the hwmon_temp_label attribute.
> >>>
> >> Have you tried just declaring the label property as you suggested above
> >> in your system without doing anything else, and looked at the generated
> >> sysfs attributes ?
> >
> > I have not. But in my defense I'm also using an older kernel LTS that 
> > doesn't have commit e1c9d6d61ddf ("hwmon: Add "label" attribute"). But 
> > now that I know it exists I can carry it as a local patch until we 
> > next update.
> 
> Related is there an lm-sensors change that uses this attribute for 
> display purposes?
> 
Sorry, I don't know. I stopped paying attention to the lm-sensors package
a long time ago, and I don't know its status. I just don't have the time.

> I do have a couple of PRs open on the lm-sensors github project I'd like 
> to see merged but given recent events this should absolutely not be 
> construed as a criticism of anyone maintaining lm-sensors merely a query 
> as to whether PRs are the right path for changes or if they should be 
> sent to a mailing list somewhere.
> 
I have no idea, sorry.

Guenter

