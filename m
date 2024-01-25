Return-Path: <linux-kernel+bounces-37922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A1E83B7C7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDD31C22EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248EB6FCA;
	Thu, 25 Jan 2024 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxS3a7e7"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7C263AE;
	Thu, 25 Jan 2024 03:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706153236; cv=none; b=B+iHrbvqv2xN0BROtYM/57ho8tzAxdxlTQvw1exOWa5LUNrnNGQ9o/Bpy4cttodSVpm3p3lZtb6j0kbGrb5WJ9ZdxZUV7q97Ijbn8JbeEZOmC+1/BVA070DGekR6jjUAhrY0xRyLjjD3Jg8mLQ8sbW1aBU2tu1AKhMXRgWaDrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706153236; c=relaxed/simple;
	bh=yEQFIzW7vfaJ84CN+Hu3kbRoq6YvXr1DdEZcM3eLG3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n78N5x9N5GJH6dmDnmCV2//7ow3xTUURyzc9QqcmymCT5ukTg6tHzod+VVRWdlFQrGmUmU0OD6Pg+wT4mfjqMU8dR6c1s5+ivYghbc8kXE6sREyP7E4s1IAaw14Ijn40x1jJWs/zgCkalY2+xWmoCrvoZ6WTVzK/vlEoVLmHOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxS3a7e7; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5997edc27ccso508469eaf.0;
        Wed, 24 Jan 2024 19:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706153234; x=1706758034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Jod44M1hOidJ68nqDYC6ddWYkrlEE09my6U9pz3NCg=;
        b=dxS3a7e74YQdRYW0ZP4gEx2w+wzMatkFXDCYDkwCfU4qHuVl21AvJpqMTf75lt2U4x
         r9tnBYL8MR9mff11MAQIzA1/AU6AZFxp+kwu/+IFfl8QRmD/co40POYDzKO526CGu11j
         jHVq4oT9aQ2sdPz3+Equ9QRg3I5n8pj3K4hngaOglFXrP39NIKE9/BoW17Oim8rsD43D
         JGJkHZlgSPER5OADJ63rWbiL/vpP/iyfy/RTNqOnI0hX3JmsDP3jP28+YlzIHdEn5k/r
         qTBls9HiTq9LTEQJUKpvAIbpMNK5rARLD9uaYG7LNOgdNgG1EfyqgbZcCNA8awwYrTyM
         MinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706153234; x=1706758034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Jod44M1hOidJ68nqDYC6ddWYkrlEE09my6U9pz3NCg=;
        b=LQRehkN7Yt9/2Uuj/3BO7WSPswhIE598/DI0VibbRJ8DV5ih+5e7cLJ73rGJwwpkgq
         vM+6ez1tFYPjaqLmjSbgz/ejlFwoeSvzx1FFv2o5j7JpFqAsV7I+89koMf1JjRtC4XQu
         4Yw+GDX4QVMWl6zG5UV8t83n0lTbXfHbGh6uErx0CPfm+7blgGFkZtkaxNSwgBYQxdFy
         pSBzbpqlSZe+6w1DdQAJBfV/V6Jw18yi036TqgyEaugXjYCkL8oztISPnXxz/xjas/CB
         Jr9ZFd+rdg/QFCp+5PyYsRG4x0jEIwnFpu3RIszxz5KxbNIxmQGBn9cekVawYmD2st8o
         v2Xw==
X-Gm-Message-State: AOJu0YyENrPrkglnQ2zEZaq8YNFViXxl9pxBYeL5QGHesVtjrDa5Mkdx
	kzDW1OPx6iVqHMfDRvteUnhm+rAio2gMoN1X3xUyahPcHe7HhDYH
X-Google-Smtp-Source: AGHT+IF8A8h7L4AGqkhVXFE1PfvRfA20seFFacmDWLkms4xRIytLXhni/4T3a6EE2qBZHZQxGYPh5g==
X-Received: by 2002:a05:6358:5912:b0:176:4921:21c9 with SMTP id g18-20020a056358591200b00176492121c9mr714040rwf.3.1706153234043;
        Wed, 24 Jan 2024 19:27:14 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:f69e:ce0e:5564:9caf])
        by smtp.gmail.com with ESMTPSA id a5-20020a5b0905000000b00dc256eab936sm3169265ybq.52.2024.01.24.19.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 19:27:13 -0800 (PST)
Date: Wed, 24 Jan 2024 19:27:11 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] drivers/ptp: Convert snprintf to sysfs_emit
Message-ID: <ZbHVDw6vUQ_-xyB-@hoboy.vegasvil.org>
References: <20240125015329.123023-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125015329.123023-1-lizhijian@fujitsu.com>

On Thu, Jan 25, 2024 at 09:53:29AM +0800, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
> > ./drivers/ptp/ptp_sysfs.c:27:8-16: WARNING: please use sysfs_emit
> 
> No functional change intended

Acked-by: Richard Cochran <richardcochran@gmail.com>

