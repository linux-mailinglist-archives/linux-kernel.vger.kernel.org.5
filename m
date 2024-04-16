Return-Path: <linux-kernel+bounces-146859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E17B8A6BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75561F214BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50F112C46C;
	Tue, 16 Apr 2024 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLYWTcLS"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF612AAE7;
	Tue, 16 Apr 2024 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273313; cv=none; b=KEONEKusF6/AWwFR7t5/dW15gQVa3G21ESnoUtZ8/v3KKVIBU5Tvi6GOmHb3gaEj+wBkiIYXH59MgrwqPn6i+DrJxBFD7Ouk7l5aL+53bJ1aR4IflnKTe+rqTz3BJNImF9jC3n7sQvHCJqLh9So1mohuXmV/keVddJXZUNdQwqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273313; c=relaxed/simple;
	bh=95qgmgHUYZErFgMp0eZjWjn/3CMNGi8EBRcrj0SZWwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoQpUYusibNVDm1VbV66BSgN+y5tXR9Lkmq2Hw7qSjWq7otHnWFZKJE53soHTTeXO77riN+HbIo/mtLkY9R3AfqpYhPb+eJgQyAabtL7lPr9skUhFTu9EA2Tfzt9KegOO1XD2AbZLJoYqfG+ofT3dccUdDdQQ1MiXjjTMzk+1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLYWTcLS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so4015194b3a.0;
        Tue, 16 Apr 2024 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713273311; x=1713878111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Yy9XrpIiaWHQTbNCOcLKgeMrs2sYZTKB0g4eg56ddk=;
        b=TLYWTcLSsylOwU0qjazNbnQ8xjPJzyrn1DbOixr+1SkeC+ZpaLbaRkyvAEXMJV35zp
         qW0IQF1gcURZsTBWYXHz1HoUPUrmypgz8/n9iu/y1oAsmhA7SDcLNNOmYhQFOO9Q/XNy
         UeGE/9tWYuicSpvMZOXAiQck+iRXcZROtnzM1VQOFnx//jTmB462nMIZvz2VTtcb/48P
         ZgF+qGMvtRZc9kDsjKtDuNwKNfEBlVK3raGzkigwzi5FjQgWT/F+SOgy++UqH8s10g0p
         Gp2rD442vTOe7eRyeRhufOBQDmDjda+MOXqaiNtorWah7hGyedtExqJqi+QZVpiyGOdC
         n4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713273311; x=1713878111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Yy9XrpIiaWHQTbNCOcLKgeMrs2sYZTKB0g4eg56ddk=;
        b=ZVPfGstF82x/eLqQSmM6MZv0hlvxXYGPXuyVfKDrZ3rCpoX9Oxh8z0LIpLAN0WHxIa
         Zk4waB2dAB/+2jNcdiMxqou4KXmK6/q5DAHNFAa7AlaXNxWF265dhtjyQ+TPfU0IKTlp
         GVteZgYlFmY1PBrY7JheaBpJ1762/zsxJ3lcBDXLxR+MXQHOuMqwd/f+LhVPMhQ6qcCD
         3Y72Zhu8F4WcBQF7m8ndxrvSKXKJdukkVzkE92aChPDjNPJk2eFAdd8k8KvPRmfySohy
         FNoEgXM2pBc6D7LygoLpXSf9ErSZ7u5G5RMOez1RSWj1PKbdQ39+P3EpONu0CSI7XXID
         5D2w==
X-Forwarded-Encrypted: i=1; AJvYcCXZD4eWIlG5JoO1xYvjpO2jb/BPww4LNe2W1yhYrUz5mmaaeGQ5IV/2ksVvNo1rmlP3ga9gOmKtANAKfLkD1wIT1OLeN4FQeYawMljHF0tczu/lsqap3PVVG1hiKRgsRYVqhfCTs3V1PJZlsuk0Nv0XZlkcixMcoKhoeVFRQ1IfHHFrRx6yD0iQXiMpQggt
X-Gm-Message-State: AOJu0Yy6pfWui9A4Ew9gmRKdx8oJv9j/Ll+svBtsG/zyFMuC6hnjdqok
	ylUMqEHUR59U5qGx6Kmo+w1NMNSffB+Ilw1QbnRE6F6Ikg3OUMh8
X-Google-Smtp-Source: AGHT+IFrIWcQetiLJElYNq1t9nWc9jtfVc044PseO8FiMX3eEaHJ4Km6QvoAgH+9c+pj4eOhiQ9GeQ==
X-Received: by 2002:a05:6a20:9794:b0:1a7:a6f3:1827 with SMTP id hx20-20020a056a20979400b001a7a6f31827mr14997105pzc.46.1713273310646;
        Tue, 16 Apr 2024 06:15:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gh12-20020a056a00638c00b006ecc858b67fsm9201187pfb.175.2024.04.16.06.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 06:15:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 16 Apr 2024 06:15:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
Message-ID: <cb1599e6-635b-460c-8837-fd4d4a6e15a2@roeck-us.net>
References: <20240330112409.3402943-1-luzmaximilian@gmail.com>
 <20240330112409.3402943-2-luzmaximilian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330112409.3402943-2-luzmaximilian@gmail.com>

On Sat, Mar 30, 2024 at 12:24:00PM +0100, Maximilian Luz wrote:
> Some of the newer Microsoft Surface devices (such as the Surface Book
> 3 and Pro 9) have thermal sensors connected via the Surface Aggregator
> Module (the embedded controller on those devices). Add a basic driver
> to read out the temperature values of those sensors.
> 
> Link: https://github.com/linux-surface/surface-aggregator-module/issues/59
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

CHECK: Please don't use multiple blank lines
#189: FILE: drivers/hwmon/surface_temp.c:17:
+
+

CHECK: Please don't use multiple blank lines
#229: FILE: drivers/hwmon/surface_temp.c:57:
+
+

CHECK: Alignment should match open parenthesis
#311: FILE: drivers/hwmon/surface_temp.c:139:
+	hwmon_dev = devm_hwmon_device_register_with_info(&sdev->dev,
+			"surface_thermal", ssam_temp, &ssam_temp_hwmon_chip_info,

Please fix.

Guenter

