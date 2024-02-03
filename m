Return-Path: <linux-kernel+bounces-51144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE088848710
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7547FB2571A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C504B5F47F;
	Sat,  3 Feb 2024 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM7Gvylb"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B375EE93;
	Sat,  3 Feb 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706973419; cv=none; b=joe23Hw2WGBxGSXlNMaWvzRF5wKji7r7Cck155ukv3mz4yhUn8xpabAeDvwVxdTx9B6zixBVbE+sQ+DbJ4tvlAhw+kXOgrIouHxq5q1fidvWZSfYIlKBwx4d/wqfQUpzES+o5wTUrvsIixPeNKpZNxDeRkgFOmClIms2sYwlkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706973419; c=relaxed/simple;
	bh=2Xp42R+bUMSJBGR1+TFAh3jQWwWrzM0UtoWaeJTvGRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOW5AXI0rT8rZ+GyTVhYvLUxT7bE+QGM8FdQ4zwnsoEl2ljFLJjU4dFBjIaQbe18tYx9RFEubrzJjz15vIDHnLEZ0cSG58XsQSfk/wVje8E6I059jp0zXkNrSx0IozDXJ+UFPMYm6RB8A557WwtWXsPK7N9+fOqZzwfJasDXYO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM7Gvylb; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so3061541a12.1;
        Sat, 03 Feb 2024 07:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706973417; x=1707578217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6G4UutG5LlRpQsaWdrVXJt92ktptJvAmhEIRIq5lY14=;
        b=jM7GvylbzhuzgDUMN2c5wMl6EM5WATzZtUElXw3SF/5Fi+lMnxbCgg5uNKY4mldo8J
         m2zVojNKEhrsR3OlwJielyjRfqvhmHJ4YxuEiJbnCJubpy216OrtON8MWDf2jqMBdwmT
         HfktizrdaVXmvfLVoeDIpCtgleosTxaHw6PaGUlDdtyNmgZsZ+4ypw0wDHjqoh7tvFkx
         PIpG/rcfXZ6FSX9TVwwiP9rRS2mMqiy8YXJDGA6v1LiZ/iSSGHD2ORJEsQmVPs0Z+v+g
         153OUYegkvGQFryrxdX9XHlUxnyVKKrxDbWeplIUin2Bjp9M8dX4dNLU3rtjNfVzLWyr
         UYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706973417; x=1707578217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6G4UutG5LlRpQsaWdrVXJt92ktptJvAmhEIRIq5lY14=;
        b=XeBiViXHyXaNn+w2yCTiHF6IvqKgduaFWIJqKXKvhhOvzFuL9om437j+dgEIDrNE7u
         WOA9E+WrbnQU7S9WUAFip1y1cZiCn9Pxjb2S+UL8AwlRudTxu4/8xSAuM2TdFLwzn/x3
         9YiiQon+6uUyna1FknQrekzaze4GF//NkQ6gfQ7A9/zBXRTLr4Q1opNWxxHjkzYxJ6q+
         BzQm7lJeHRk81qYA91dOyPU5KIK9kQlxDFwY7BaUXs7LXtY1C/vif0zicHxckg9H0Wcw
         w5/tms8kaddY9z22A4LBhGWdr0r4O02w0cW3by43v5F/nHr2y6O6CoCs/YIWxXB5ZS2d
         jSRw==
X-Gm-Message-State: AOJu0Yzk2+KjKqHB0H3olV5BNnPdZunKq6QHWs9QQG38XK42fX9ag3Wz
	oM4fqWtaKW6iD0b/C/HGY6bus8lCpDlnEllt8SigUcyVvUV4bcPy
X-Google-Smtp-Source: AGHT+IFqjUMS+vD5OsUCxKNNmpd1K9urziAG5ucP65c/TKckWf3dmFLniHyOhcTCPhkKcpKvARrI/w==
X-Received: by 2002:a05:6a00:99d:b0:6d9:955a:d3bb with SMTP id u29-20020a056a00099d00b006d9955ad3bbmr2486203pfg.10.1706973416892;
        Sat, 03 Feb 2024 07:16:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVhuj0tc4ntpNk8y5TQ34DmLusagL4+VYiBB2qEenO8pXU84KhkPBCqQ05sxi5ck/hiEhoZkhSBPXnaFStVOAgPdI7fVQ8bv5vg2syb4uZ2OCBIn2kqiZ67EVR47fnqCXtPkJDycsIVznbw2CA4jKp3PVwP7Lhfw0K2wYovJt3S
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q7-20020a056a00088700b006d638fd230bsm3615942pfj.93.2024.02.03.07.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 07:16:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 3 Feb 2024 07:16:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Zhang Rui <rui.zhang@intel.com>
Cc: jdelvare@suse.com, fenghua.yu@intel.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 02/11] hwmon: (coretemp) Fix bogus core_id to attr
 name mapping
Message-ID: <70ca3e55-036b-4603-b744-f367f4de6344@roeck-us.net>
References: <20240202092144.71180-1-rui.zhang@intel.com>
 <20240202092144.71180-3-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202092144.71180-3-rui.zhang@intel.com>

On Fri, Feb 02, 2024 at 05:21:35PM +0800, Zhang Rui wrote:
> Before commit 7108b80a542b ("hwmon/coretemp: Handle large core ID
> value"), there is a fixed mapping between
> 1. cpu_core_id
> 2. the index in pdata->core_data[] array
> 3. the sysfs attr name, aka "tempX_"
> The later two always equal cpu_core_id + 2.
> 
> After the commit, pdata->core_data[] index is got from ida so that it
> can handle sparse core ids and support more cores within a package.
> 
> However, the commit erroneously maps the sysfs attr name to
> pdata->core_data[] index instead of cpu_core_id + 2.
> 
> As a result, the code is not aligned with the comments, and brings user
> visible changes in hwmon sysfs on systems with sparse core id.
> 
> For example, before commit 7108b80a542b ("hwmon/coretemp: Handle large
> core ID value"),
> /sys/class/hwmon/hwmon2/temp2_label:Core 0
> /sys/class/hwmon/hwmon2/temp3_label:Core 1
> /sys/class/hwmon/hwmon2/temp4_label:Core 2
> /sys/class/hwmon/hwmon2/temp5_label:Core 3
> /sys/class/hwmon/hwmon2/temp6_label:Core 4
> /sys/class/hwmon/hwmon3/temp10_label:Core 8
> /sys/class/hwmon/hwmon3/temp11_label:Core 9
> after commit,
> /sys/class/hwmon/hwmon2/temp2_label:Core 0
> /sys/class/hwmon/hwmon2/temp3_label:Core 1
> /sys/class/hwmon/hwmon2/temp4_label:Core 2
> /sys/class/hwmon/hwmon2/temp5_label:Core 3
> /sys/class/hwmon/hwmon2/temp6_label:Core 4
> /sys/class/hwmon/hwmon2/temp7_label:Core 8
> /sys/class/hwmon/hwmon2/temp8_label:Core 9
> 
> Restore the previous behavior and rework the code, comments and variable
> names to avoid future confusions.
> 
> Fixes: 7108b80a542b ("hwmon/coretemp: Handle large core ID value")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied.

Thanks,
Guenter

