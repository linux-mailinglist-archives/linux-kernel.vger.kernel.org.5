Return-Path: <linux-kernel+bounces-50090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A517E847414
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B6AB2CB66
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566DB1487EB;
	Fri,  2 Feb 2024 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hoin71uz"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9616A148319
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889590; cv=none; b=MYGb3mzceZeidYx95DA7j9kkk7dDHST/TO26TcF/NlfdcRSrGifcP8ebe+WYJXexOnuzBV0uR6rxI3Mz3Gd0vWP+vKTBkNiESbXSGsj0iaLsughl/QW5dVBxZxugeJjb4FGQq49Ih4WZgj6WkzQY8Gigs2xm50f7i6fpi1N21J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889590; c=relaxed/simple;
	bh=m8vYlSSs3FxLJgMcW9FZQSGwwLINUHgP3ltCZQH00t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHlQb1m5qQyMdX6DBswQ+56APF4NOhqoc+a8zIKSBdzpzoE9BN5RTkTJKfEgmBQRY7WxQWYwA8UIOGG95M0nZc2drsAV32m8K8SzCsWjY65LVtxdk7ZUvXVXvSLhWtRz3VgymwDW6P9YE0YlQ9RhKztLGU8JjdlF7+GYAEyFAzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hoin71uz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d93b525959so21136935ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 07:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706889585; x=1707494385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XT52cwwq/CkEwbgIUk5BCzuEf7NPwK2h7QOsy182JLg=;
        b=Hoin71uzvPWDzVWkveqtsgeFhnR5yHogXhyt+HYfl2Zah1O82mYsoHnA+7fqp2AUnR
         zpFOVm0AOwwU63PZp0/ZK4t1uGMMCVcXxbwimaDi/54u+D3ZxliQUgD6MiL5nMwR4Jo0
         i4EtP7bSIqPPUv+X4awNCewau6Wlj1ywWSUCuyzAkCRH2w0O2WZ5zI7NmYIPghhBaAUF
         GZ12guqQGse45OI0Jmgx2fufKlWBZiDP+Ez7fQyUhLM/ywcpHWMW0djzBMDkHdgQDJRt
         qCHNS6fOcTrhAs3kLme7XgcHM9+R9F8UYOTrjWuRBEwg2OIxMwrgRGdGDiv0PpPOmZ/0
         AmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706889585; x=1707494385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XT52cwwq/CkEwbgIUk5BCzuEf7NPwK2h7QOsy182JLg=;
        b=IDKeOTl8glCqv8rfm7wW8X8p3kbyotf8QpS+r1Sjc7G/pVk47eCQIR0/iPOxJpc0vp
         SDGA+MfkFpnh8mKqZjMNBNP9CfnWkV/5ayw+DE4CxEgFMQEALcfO2zXYdUOqyCgNwozt
         jWEeLM9ftkZfCS5+Mp+bS2TcXbXeqfg7I61Dsx/f+buATvuy9GNK/4igvDRtxKfFsRin
         /kIHSGgeQXF3K+MQgZmeqgo27CqqG2FLEk/wI9R1YUeaN98IoRQenacgsZSPF06nD9pi
         wtzYfOKeXLaiKNP/+35i07kj5ejP12f1xDbEsr+6CWTUUeQE9I0Zg60HHuqMW6UcvSfM
         GQ7w==
X-Gm-Message-State: AOJu0Yxt/F49cGs7REhM+/wqg5usKczBfdnx60cjzidFxc/5ORpbSFd0
	cLQQVway0g16x3UQ0u/ilEPsByPn/oz58A7K7X738lqT/pqZPi1B
X-Google-Smtp-Source: AGHT+IE+shq9kHmYnNmgWR5DIIkK9UZYHcvUGhl3ADIY95qW//uTo8VNzJr55Kn3Bov9a3IDSZngSw==
X-Received: by 2002:a17:902:da8f:b0:1d8:d225:699b with SMTP id j15-20020a170902da8f00b001d8d225699bmr3746625plx.24.1706889584507;
        Fri, 02 Feb 2024 07:59:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVKoss2r6T4jSKMc39BOO8sS1wlQeZKNUqGbnDx+Iq5lFsQ28zOed/gzxjtdN9vZ2G6bMfSBoiWuNYcuyQI/wZHYHkynz1B/H4ocSX8Vzdb3CL19Mle04HOVI37dltZVSNp12S5rGix1waKInuRVbusXh2fGWmITUof2M0H+kQzSZiv/ok3
Received: from five231003 ([2405:201:c006:31fd:1211:e094:36ee:c800])
        by smtp.gmail.com with ESMTPSA id 34-20020a630f62000000b005d8e30897e4sm1834628pgp.69.2024.02.02.07.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:59:43 -0800 (PST)
Date: Fri, 2 Feb 2024 21:29:39 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] gpu: drm: display: indent fix in comment
Message-ID: <Zb0RayxXCE_kNoGc@five231003>
References: <20240124183659.511731-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240124183659.511731-1-five231003@gmail.com>

On Thu, Jan 25, 2024 at 12:05:56AM +0530, Kousik Sanagavarapu wrote:
> The comments explaining the function "drm_dp_mst_atom_check_mgr()" had
> uneven indentation which made "make htmldocs" complain:
> 
> 	Documentation/gpu/drm-kms-helpers:296:
> 	./drivers/gpu/drm/display/drm_dp_mst_topology.c:5496:
> 	ERROR: Unexpected indentation.
> 
> 	Documentation/gpu/drm-kms-helpers:296:
> 	./drivers/gpu/drm/display/drm_dp_mst_topology.c:5500:
> 	WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Fix this by getting the indent right.
> 
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>

Ping.

Thanks

