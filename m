Return-Path: <linux-kernel+bounces-161540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E868B4D74
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A48281412
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EE756B60;
	Sun, 28 Apr 2024 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpxPAdDH"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E8637;
	Sun, 28 Apr 2024 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714329051; cv=none; b=aOn1IHNx87zfISCnPio+Hn3TdNWhCHnlTkCuXWiM0tX+xSc3/3m2o8UZKIJgfADrAmka5uzSEsfLaAJcPfF321BJulB0XavwTSwZh9/b8jnuqe6O7zJFs7fqwmykvoAOeFPVVH1UacukB9jkMHv1jeY8kO5uVpjRoaNT6RHBB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714329051; c=relaxed/simple;
	bh=sP/twd66uXEgebXmHlwxIAgQKR/4gJkbXzqxNukJMAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlsNM+6puX9HsAabsl6UVgj64A30GWwE8mskZSJoLE7BYnlBivlrZYF4EuWfWB6eS7pFHrXWIgwEQyAO75VquZjy0Zyq6ohvXyp763LJqezIVAntCIzQBv+UXao1jLnRP74N+0GN9z+9dfVTYHkr8ys3t7ZbCo54LCZi9jvSKbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpxPAdDH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso3421845b3a.2;
        Sun, 28 Apr 2024 11:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714329049; x=1714933849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PthvQh7l5HpiOMPvQkb1YYiy3S5ERgRUU01bN/c3Q8=;
        b=SpxPAdDHGAR8x010gtYm0oUaLHWsL6M73p4FGSi56ljb9A/ByW2ZEZ4NQj8a1n4Vsi
         rcSQ61mb6kXDC+uCyo9zduYaw3FkITXywdJ7vo09my41RZuMtyuy9EC1VeAOo46sOW5V
         EVOBwJKh9kVf+sOGUwurLR3vK82LjKzLnyxbQWZrexWFZ9HTmArn27uwN++cnxzowWw+
         2vvMrxpmiz6DzpJZKdJGCP0vo95kMwyFkZPnKRLnQdp6Rwuah9Dwn4Lm+bnO4pnY8Liw
         3yzIafXeWSXcBX8O+eS46eigGZR0LiFJ9BsQj8mTSRxP8ox8cy2P0jKLQNIouklvycWd
         tStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714329049; x=1714933849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PthvQh7l5HpiOMPvQkb1YYiy3S5ERgRUU01bN/c3Q8=;
        b=b/7f2DFXp0sSByNXTcRcLMvQ2vXu1Nr9p+psV5NBIqJIYzl0D2j0gpRuLZYgDr2gGD
         SaWk+NLIV38EnAUiE7cnB8Qv4vk7oDRhpGqqsAzRnC1xQE4MiJiqV1Lq7JkjSDJM+2B4
         0v+Lu9lDzmeozlhRiZQDaYhDI7ChcJfyqqX7mwnSMvxxKoPXF23tEWQ6bUhA/JthR5tv
         fxK6pKOxhl/kpHG9uV8vWp8dLLMhfOCHQVtGAc7Gn4mhWz6U9sAhDU3sk8LhQl7COUnJ
         4UP3U4KVvS1ATArY628ff7udYWsar7oX00hZjHXcROJtXpVymbQgt5uScKE1gfGVWBB+
         x31Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSocGp95wfFSj6c5JSmiBq8+n2ImLPK1UX15/KZ33XUTlOPlROz5rcSWAB7g7K5Z82iBgt/WCeoPVBXS1ENHC7jv+OLvTq+4l9zyotK8ED1Ju3fBBTQ+akjyFg5cFCtTa6RXbn0m7VYlw=
X-Gm-Message-State: AOJu0YyekioIx1Tl7EiygvVv4rkdqx39IVqoK8YqS4XRjz+KZWvxEK6e
	zG5eQSwUZx5I8hAaRu3xtPcK+9vNDtF9SLZ2lzSjziaRYvvStBDK
X-Google-Smtp-Source: AGHT+IGov+XxEOPRES7Nu4koLBIFk0zX+XPhCzGajRQdYcpIoxx8KHrMNwK/MzPsyZ4+P9OAmoJPSg==
X-Received: by 2002:a05:6a00:2315:b0:6ea:f4ad:7298 with SMTP id h21-20020a056a00231500b006eaf4ad7298mr11998670pfh.34.1714329048968;
        Sun, 28 Apr 2024 11:30:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k4-20020aa79984000000b006f3e3d928fesm3918086pfh.220.2024.04.28.11.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 11:30:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 28 Apr 2024 11:30:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: patrick@stwcx.xyz, Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: max31790: revise the scale to write pwm
Message-ID: <062ac1a4-7cf2-454c-ba4f-b19695f1c2b4@roeck-us.net>
References: <20240416022211.859483-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416022211.859483-1-Delphine_CC_Chiu@wiwynn.com>

On Tue, Apr 16, 2024 at 10:22:11AM +0800, Delphine CC Chiu wrote:
> Since the value for PWMOUT Target Duty Cycle register is a 9 bit
> left-justified value that ranges from 0 to 511 and is contained in 2
> bytes.
> 
> There is an issue that the PWM signal recorded by oscilloscope would
> not be on consistently if we set PWM to 100% to the driver.
> 
> It is because the LSB of the 9 bit would always be zero if it just
> left shift 8 bit for the value that write to PWMOUT Target Duty
> Cycle register.
> 
> Therefore, revise the scale of the value that was written to pwm input
> from 255 to 511 and modify the value to left-justified value.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>

Applied.

Thanks,
Guenter

