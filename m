Return-Path: <linux-kernel+bounces-51722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B63848E98
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BA01F219C5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91706225CE;
	Sun,  4 Feb 2024 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoLone4T"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA1A22F11;
	Sun,  4 Feb 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057985; cv=none; b=ExCQ3GGWqsbgCCe12jCmdmv2KE74iLL5IdQGDBaMox9UztBqFv1TvPDPqgHP1pEqu/oVmaOAELiXAkoLiuz8wFnjL6qoO8tSYohpx5JLsnHD1+3iGGRBhpK4ohsxOlpM7c6aLnhMr+NYRfmgLd5ayHmgA5uNulmRmhDEVS8UYq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057985; c=relaxed/simple;
	bh=X22SnXW/uF/eSuiJoD0OHr1mx+u3OZ2M05RHDaQVDhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RI8LeeD8Zje84mjYYe635Iz7JuSLfHk8lWv+XuLWjNGaOrATOS4lg2ZkYwKGq2RQZ4KDD3CHaV7p8ExdI+rYaXu3am6dBCf+Rfhy5IeX7W55BwasZDjoVQLNX8rPyYu25ZyIIrtEeXr9+9PugRmysan99NYOkHeVkzNfUxEA6iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoLone4T; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d8aadc624dso26983805ad.0;
        Sun, 04 Feb 2024 06:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707057983; x=1707662783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmVTVOb29OCBo6DzPgpShqI2yG8w6eNaM6hPLe5kOQc=;
        b=MoLone4TchH5XEh8/fknBsnGLZHRLuJY+9RSWUpYwmLM7XzcApZ3AiWYRvRkoLG91i
         dAExzomt7Okk4d+0NySv0U46FHazlZudPV5DJhx5kJPr8m3WuKg+6YtmaejIYSbhlCF/
         bKiQkE32IJaifGuDH0gj/t3rykvIMKPVneGtEI9A/PvkZNrZ3mVjg7QzMVFT+xLhUUeN
         1e6tBA4n+hrwX5o0d8ST35W7cOK0mJxc4ExB/tEgY6rPhyURwyAQdKlGittVl/+ZJtJq
         nseoEN+dDqDj53HlQoAz46NmPmlkNGFzc7iOTu2QAgYN+9MbozuxgvKS/nVIz/TbvhOx
         vDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707057983; x=1707662783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmVTVOb29OCBo6DzPgpShqI2yG8w6eNaM6hPLe5kOQc=;
        b=TfFFtG5kopUTcOXHNarwlcjshffNeOeG6AVByeIXUmME3khEBXl9PVSrib/Brpy8h8
         BmUQWGq7fnhZXzWLkZLz4m77S3Ez8pOkALuWZAvgxtfbsDSmJtTSVMZs3udd2naz1TTa
         0W/Q0nGu3LejWewp9BhpFy5K7HOvp6m9yhrptadXfeDabiKgaDzbqsXZXKV0DC6cGewD
         EEwMBya/nKXp74V34r++df/xF0hoZ6pmL/w0iiwc84n9cmqUw59U35Tef8BmPzHp31x9
         r8720ZayktLQ+bc/1DSpkybcuCX4e0fzsrrqj7cnMeDMzREUm28W2cTIFacSiHU1ywFg
         dr8g==
X-Gm-Message-State: AOJu0YzE1F9t5ObWEF8Kwcis4+59niTZWtGlz4MH/7r9Jvbl4NjG2tAp
	B7tNh/LMD8DsXP5LrPIYLQFGQjVozqoV0/PWaH799ieIMpHT3udLSyysc+fJ
X-Google-Smtp-Source: AGHT+IFt9Lupka41d6hgk5OpSTyZ7ZKPTCxQlxjogROB+3YnayB81uxcCjJTCPRpHti6s5Gu0ue8pQ==
X-Received: by 2002:a17:902:b283:b0:1d9:196:4dae with SMTP id u3-20020a170902b28300b001d901964daemr6908220plr.8.1707057983574;
        Sun, 04 Feb 2024 06:46:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUI0dPvek2OBKWPdpV2Sk+pggaGAbvW48zfviczM0Q8rtYXgjl4NrLvtlvI1KeBYI3hnVNVFft9TyaFR2IfGOv7MGr/KmUtcUTEhFLdA3jMwMP4p2DJlidqFLuRnMRHpE0AleT8cbylh6mQFjFyvMhgqLiAWpECBAGU4jrDXsUs
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001d9176f56f2sm4620965pld.71.2024.02.04.06.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:46:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 4 Feb 2024 06:46:22 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Zhang Rui <rui.zhang@intel.com>
Cc: jdelvare@suse.com, fenghua.yu@intel.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 05/11] hwmon: (coretemp) Remove unnecessary dependency
 of array index
Message-ID: <3e46dd83-9711-4336-93f0-4562a80afc55@roeck-us.net>
References: <20240202092144.71180-1-rui.zhang@intel.com>
 <20240202092144.71180-6-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202092144.71180-6-rui.zhang@intel.com>

On Fri, Feb 02, 2024 at 05:21:38PM +0800, Zhang Rui wrote:
> When sensor_device_attribute pointer is available, use container_of() to
> get the temp_data address.
> 
> This removes the unnecessary dependency of cached index in
> pdata->core_data[].
> 
> No functional change.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied.

Thanks,
Guenter

