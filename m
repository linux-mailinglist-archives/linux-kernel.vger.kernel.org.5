Return-Path: <linux-kernel+bounces-152376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F71D8ABD2F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 23:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DDA1F211E5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 21:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C14C482D1;
	Sat, 20 Apr 2024 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6Qo3aZn"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB32C205E35;
	Sat, 20 Apr 2024 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713649582; cv=none; b=lOC8soF4IwMULEVlchXdyEDUDhLyW1s02vpJtiInLMiQv2caDgjkswG+tDTapOVOFsfnEEBaq/j14u8iba/w+LwMW0s5VVk/QH0rrxYbiYC5H3huASUDZ6qUTESa2EjSu4hc9hC6ddJRvP/n1RAAVWlcSrSRd7+4xQAT59Lu/Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713649582; c=relaxed/simple;
	bh=q/Yzy9jb71UhbLs10JyY7ONYcI4dKOEu3Im2kVjHUHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tt04EtrDx9/W2aHCwgirrsmLTlxh72OA1IvUgT0AJKbvrt0xDl0sBgxkJD8muIpOFBNm/t40Cr8zWBeKT1vqfI6UWB/4i4NKUFFI46NGTJgvo1hmHKD2U4EfGzQYU07aNdjmAhozM3KV4tbwGjWaly94TTrcRXP5dALuC9o/ffs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6Qo3aZn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e2bbc2048eso27241415ad.3;
        Sat, 20 Apr 2024 14:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713649580; x=1714254380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcV9o22lvrbCiGocoNoN+ENYYHxL1F3V96+s5Tsv6z4=;
        b=W6Qo3aZncECfXNjQfVz5XCIEOIgmzJ4TQC4q8sCkV7h53yptyWLHu3zPxkItTT9l4f
         RHUBNi+jqwm10XfP1rFMgkGezyljlxEIMIBveyAVvfm0XpRUypF5CJGVvZ0zYMZoBDp5
         WpefAGbzGpuoYk/vb7EFmjDT6SoW+oxOKosfSAMTwV+GhIa7It4uYJCUJzZjjSMksVhB
         d5h5sH29+0nIZEjir9q/3Y8/KmGuIKGF3qrB/AzPXSZEhZHT8F4Ku6YKr5Oo34g4szth
         QezD+pNR80oInPKSI3yjUBGEeiaPnubISlJ4jZYtJwBu2RMg2gtG5dh9vdTAF2IU3JY9
         oakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713649580; x=1714254380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcV9o22lvrbCiGocoNoN+ENYYHxL1F3V96+s5Tsv6z4=;
        b=Y8BFlVnWvZVKikDDrCunIYSTMk+/YtgzqmclBCEdufk0nVA6+uyITq2zqJKWXD0+Cl
         pDM0xkbYRxr7Q9MZnInN0l4XwCfL0Hz86yleWOS8sa4734iPh6CtFkw1MdxhAgL0xjCQ
         OgX/cvZmFrGG0hk7GBJNVaHyPKhwcYZU4Xqs7VPO80KUF1d2+DVkr49ZhSQKdm+hfGiC
         Jp4dNj1QodNDFWNTnPtkZkYJ469PP5A7yA84KbdBaDEawBgyPJ+oWAHH5uCpy/rQPDJT
         Ght7UQoQxBpKVVrXFlFFZY+zx6wwbYEWyjUjOvXrgmhgkfHLqC3ln7J+XzRTCMVCLOTB
         ZFCg==
X-Forwarded-Encrypted: i=1; AJvYcCUkQudo/MBmIMH4oAUBsd8k079ywAmZocZyPqeO4IRtYjLD2RbfB4PGcAI59jmHpia2mQqgo07qoeWW+mTEB4YN3TYfFCkG8LLyYxeDpG4HgGuLkdtiTWM4SxytpI8SZL9sE+pf33q9vHs=
X-Gm-Message-State: AOJu0YyoXymw64U5E9DQngNLXwm0d7A+UdUFg0BZ3tRBsvIk+GQRNTYA
	eArmF+VucyB9waFnf0ugBpCald5h4QdH30/fBUqOPnzOxwGgp9Psm4ca5Q==
X-Google-Smtp-Source: AGHT+IHmOKv+RkYN6u/zS0vAhgvZkveZBvsqaWLTMZVHY5gNwF03jrcagZDdmMmJBmcU/YA/t84gbg==
X-Received: by 2002:a17:903:120a:b0:1e4:70d0:9337 with SMTP id l10-20020a170903120a00b001e470d09337mr7584055plh.45.1713649580213;
        Sat, 20 Apr 2024 14:46:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902c41100b001e00285b727sm5454110plk.294.2024.04.20.14.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 14:46:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 20 Apr 2024 14:46:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/6] hwmon: Use device_show_string() helper for sysfs
 attributes
Message-ID: <516b5760-eb81-44a8-ab95-29e8717be493@roeck-us.net>
References: <cover.1713608122.git.lukas@wunner.de>
 <23c2031acaa64f1c02f00e817c3f7e4466d17ab2.1713608122.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23c2031acaa64f1c02f00e817c3f7e4466d17ab2.1713608122.git.lukas@wunner.de>

On Sat, Apr 20, 2024 at 10:00:02PM +0200, Lukas Wunner wrote:
> Deduplicate sysfs ->show() callbacks which expose a string at a static
> memory location.  Use the newly introduced device_show_string() helper
> in the driver core instead by declaring those sysfs attributes with
> DEVICE_STRING_ATTR_RO().
> 
> No functional change intended.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

