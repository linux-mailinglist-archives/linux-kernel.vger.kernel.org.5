Return-Path: <linux-kernel+bounces-109253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9098816D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DD01F22FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFA66A34C;
	Wed, 20 Mar 2024 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8YKX0QD"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803221E516;
	Wed, 20 Mar 2024 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957082; cv=none; b=Gj2MbIVWL4a2k0ZB918x5GgF4CK0B46fm2fZ+4bTixNYQidw1ukG1kWmxjH9bJ+MNwAo6w1RwQhGkixKuPnfCdcEjyBNKUMl2VIcUgptxc9k4akzdx2TkN3iaQ/Fn0GlX5M939mJlkkjSGFlyCFtR2MV+/kC61PttXxZFNOlPEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957082; c=relaxed/simple;
	bh=HxM0U7FyRinA5IzYzu/aYxVdoZj67DjEBCsC/59T1zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9FPS25y1sWyfrzg44tEdxjgPejnx6Lx8r2cfrJL8kkc5uHb6yd4nSvhcHEWFSZV6MlcNgaw5j5HgWsnrJZZTViNxwV+ul/UicBSTHRp58aIa7pbNzieoY2L50x+ZCbKlb+5btRCTl/ZKbM9fZilwRgzF8FpZFOTSZv8EDGKUVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8YKX0QD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29a5f100c1aso158410a91.0;
        Wed, 20 Mar 2024 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710957080; x=1711561880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcUuhuxSVebK/M2k/MuWZM4jNcLrTIAiCmUPjTXRtpg=;
        b=k8YKX0QDn/6UeLzUiadWu1UOjj+NEytrJX/8qDhyBCRhnmdCBGXeAAk0PLsI0LgwDt
         W30ZQvLdWc+jz5CpSjX3/7lx+2Xr/NyAu66zOfNu0XYx00eM1mMqyLRjMwJUExTLVV0l
         BCcY81QqyFOOf+S0ajnd6MEae8Dv0BCbke0hj4sfVYCz0cH2EcuWtUP7FYUdAbwATvbT
         AuQjDJ/laoTRiQKg6CM1F2vwAs3xghLxRJPCc2hQDx+oe+qIDYp4dG+AQmufA+BhlFLW
         nuY/+JVzD5Q0+SDIZoyl13clS5AavwRpn+1rb3SfSSKuma/G7nzMGvdWCQoGt4yqfq9H
         6F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957080; x=1711561880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcUuhuxSVebK/M2k/MuWZM4jNcLrTIAiCmUPjTXRtpg=;
        b=L2+9wnN7d5gudFZGDjRzqlb9OmBgeDz4LzYTyrdl9aWwXvaBvjmMNxFSl1h53wR2JX
         GKf0vFXWqdw8XNR/0gXc/jFswpvLAW/3enVWFW1mBPkKhc9MnZmdbejgXwo9+hO97xXL
         fjusj4gzLF3ekB1qIyCEbodIa8pXKCwBooG8RWUdGr6ZH8ThB4zME3QYDBYq7vAZlHC/
         BQ61+PUGsKViFMJ/r836r1JGxkr/oVLCT7nUaHPIx+nMftjAZ5zfTckOSm+1SEUZYbZ/
         tJ2s/NZHIqykiOLku39VMffwUUnu+Ez9SP/5VI+s3IkTzLIxvEjNZEfR4fbtHjA9DOpu
         7twQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL+6KH2G3hSTJ2uWS1OcGeNyhPHDYjuBJzupDmgxX1nH9nmZKwvZgEdKgwEqP3LSNF5olo8QXTmKEFv8g5eS5gnUqtrv7e2Txe0O1B8SYl/ErTuwon3oJ7AscyzTRE2C/vlh/2eAG9ggA=
X-Gm-Message-State: AOJu0YzuPVMPy2LVYF2Efglw2tmWGYfaNhgER8oYv6T/EJoIui3NfQ7Y
	TvTj1vw3Drs2Iw30ztgGFWhPlFXc7MhBEL7SeR11oj7nqiW0Sclk
X-Google-Smtp-Source: AGHT+IGb3EHBbz6idiwb4aNKpTCcdDPXGtm1mLxZGnzM99YTzfwFzIjs65Q+njOSKlIsRDnqdr6TCA==
X-Received: by 2002:a17:90a:628c:b0:29b:82ee:13f with SMTP id d12-20020a17090a628c00b0029b82ee013fmr16113557pjj.11.1710957079383;
        Wed, 20 Mar 2024 10:51:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b0029b59bf77b4sm1888396pjq.42.2024.03.20.10.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 10:51:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 Mar 2024 10:51:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: tjakobi@math.uni-bielefeld.de
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (dell-smm) Add Dell G5 5505 to DMI table
Message-ID: <a2f16f5f-1614-425b-88ac-5e9d30266658@roeck-us.net>
References: <20240310220710.896230-1-tjakobi@math.uni-bielefeld.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310220710.896230-1-tjakobi@math.uni-bielefeld.de>

On Sun, Mar 10, 2024 at 11:07:09PM +0100, tjakobi@math.uni-bielefeld.de wrote:
> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> 
> Enables reading the speed of the CPU and GPU fan on the G5.
> 
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Applied to hwmon-next.

Please note that I'll push the branch after the commit window closed.

Thanks,
Guenter

