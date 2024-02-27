Return-Path: <linux-kernel+bounces-83126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4F2868ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4E2B21DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4486B13959D;
	Tue, 27 Feb 2024 11:29:47 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC82A8C1;
	Tue, 27 Feb 2024 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709033386; cv=none; b=bnQkH8jDmfV1sBStdJFClniIy2cKIM35LqU8EjXkalHMbnIjBTd90WX28rB6OKykvfBbF4+OaXpu6DrHXPDVoa6+rhIKB4ZkLeCPdh9WW5LviFkta4l6p7DLMMJN2Pq+3azyHxBoicVqRCdBQTEpjTM4EMu0zGHqCt+tpdjunQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709033386; c=relaxed/simple;
	bh=V+F6zmbVlAoo9IrMGZI2jWHzXm7KbYmZjHdMSEjNVDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEx5k+uJ1htXc71nheImxLSRP2OahK6w97Z2QqPYrzAR19u3IzKKhmgViZFFubV//lRMPrlM/+TDLKELGmPfoxXccc58CR8DcF7EKrFx3kDLUr4EhwVFudwnJutT98srp0o23A06BMl8ike6CXHGvva918W7tqhAidZ70IDv9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3e8c1e4aa7so414395166b.2;
        Tue, 27 Feb 2024 03:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709033383; x=1709638183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9YKPmvIW+F1pUtkK1SkTjqUKaUVyqNEYRbY9iC7Xqc=;
        b=vXSwTUboGV6h2oAjVUNwWYWHRECueesL/8+AIA4WMT2LaPcInMUOqlr73Qq2gSpeiv
         cotc67q1YGOpQwXok8jfXEhTsnwFVBmuZe2ijnk1dYr0/w6RiXHlybQCbGI4fF0O4uru
         vcxwjHOtTR1mbonGBT8mfR1CslFYH20Rev6znX2itbJ5FvGPgDl+EZwCFZDkdaDL7DC4
         COS+xeKN3ZWpBl5RkHAmj7wBgeR0xPKdlQrpc6jGJdLNaD/4vwUo/sy8kUjbJtNQsdk6
         jPidpiObSZR0YdjcdvhedIH+fombqmcy/sznk6JHIt6kKHrFOqIhtAcr08aucB2ZeZ3l
         SP0w==
X-Forwarded-Encrypted: i=1; AJvYcCW0+0lgmgiHawr9q/VGF7WnfeKJUxxAQL0JGdhEmQe13RKtXTevMDn3IKNp0E7PXI9fs7uxidZ79F2/7JMsJV0c+cSzA6cyEMhMze412os=
X-Gm-Message-State: AOJu0Yx9CQ8G3Ly1n6eBncVTS6DLOp658zafE/IRIKjDdxy5HsszJcDf
	q2MIvM4KajM6QhnxhXYNtM35vW0stQ4zOze67OvYdtDO80lWTXxz
X-Google-Smtp-Source: AGHT+IEpqM4v4HjyD4sKb1dtIr4dD5w2+nisl65yLlL1PWP2zeRaEEXYRqX0Sv2IMIye1teOg/9bQg==
X-Received: by 2002:a17:906:114f:b0:a3e:9bde:edea with SMTP id i15-20020a170906114f00b00a3e9bdeedeamr5107971eja.5.1709033383433;
        Tue, 27 Feb 2024 03:29:43 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id c3-20020a1709060fc300b00a43389c8a1asm665522ejk.113.2024.02.27.03.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 03:29:43 -0800 (PST)
Date: Tue, 27 Feb 2024 03:29:40 -0800
From: Breno Leitao <leitao@debian.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
	Kalle Valo <kvalo@kernel.org>, Li Zetao <lizetao1@huawei.com>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wlcore: sdio: warn only once for
 wl12xx_sdio_raw_{read,write}() failures
Message-ID: <Zd3HpNvnICtlb4OS@gmail.com>
References: <20240227002059.379267-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227002059.379267-1-javierm@redhat.com>

On Tue, Feb 27, 2024 at 01:20:46AM +0100, Javier Martinez Canillas wrote:
> Report these failures only once, instead of keep logging the warnings for
> the same condition every time that a SDIO read or write is attempted. This
> behaviour is spammy and unnecessarily pollutes the kernel log buffer.
> 
> For example, on an AM625 BeaglePlay board where accessing a SDIO WiFi chip
> fails with an -110 error:
> 
>   $ dmesg | grep "sdio write\|read failed (-110)" | wc -l
>   39
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

