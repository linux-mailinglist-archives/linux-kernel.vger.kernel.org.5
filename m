Return-Path: <linux-kernel+bounces-20630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540228282B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA2EBB254D7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568F62E84A;
	Tue,  9 Jan 2024 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwCvysMn"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CA32E828
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e4d778e5eso6489455e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 01:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704791282; x=1705396082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jj5iNAb0vOYUNWOsVLfq/Kug7eJUVIVzh2hyRWQ9KUw=;
        b=AwCvysMnVtsr48eVgqGW/PjoXAEIMAVqxjxtgNU488yAk3Emg2FaAirTIL4vF99jKy
         GVbJqP44qutP2j8L+QCu1D080k9cedMcScSVuwrmtLIXgbyVRY0U4mousSVKDs3/GVHN
         8X7103W4uytsOMZwextInwpNvHJk5eBqmunefOKluAsiFwiVo45XlV3AmzSS4GiNYKnA
         6daDPp35WIl6ZX9IHNImLnErQKkm6RZLp6saf4eCSUoCG3ULYePG7XEFQh9FHtE+Qif7
         AsTQ/uWNvYyB27unCU3ieThkecAocXcQLZ69kChQ78mSrBCajfNPzJiN2fNyJLr7fjvf
         Lv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704791282; x=1705396082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jj5iNAb0vOYUNWOsVLfq/Kug7eJUVIVzh2hyRWQ9KUw=;
        b=ZyGlD/NRjj+sRQBxsI3lv/W1D5EJ2nuzBUpIe6s7bS1bID8UHhoTzHEBXPA5gZvmq2
         pDWXOrFB1uuXua6/tDQ9ydEgp+Y09S9St6qAfcuK7PvNNv8N7JdBcyQWFrB3VUtmrGLL
         WIH0+psK+IcEDURk4Pz9C5HlI7ErhPhy8GNO/JE5dGgNdBPZ7sw3mt5sLy8yCL/FJLFB
         4SblfGh2PtoBQ7rAadeKBHxnwXY7oSBJj5S8KEpwNYLck1FGCeoHsbi2qPEhw+VNXDtc
         EOiIRQgfcNjhXt7ormX075QUTv4FQe8RpVlTdPK7bYITnhmQHUYEuACwknh+eY7P4ABC
         KDKw==
X-Gm-Message-State: AOJu0YzmJcTjIUGkv6YaQ3yn5qHZz3wQnsKLs8zqYq3/Ir/KdcUmhloI
	y2FuEbd8+TqLlqnPGN2Q4UAP2ujDqsfdZw==
X-Google-Smtp-Source: AGHT+IFHr1mJqGahwdyos7RzxqemoTzawy21RafqWjIQm4z1Kiyj0E+rFrxLMMz8BuQYnHZmcXR9dQ==
X-Received: by 2002:a7b:c34d:0:b0:40d:88c8:25ac with SMTP id l13-20020a7bc34d000000b0040d88c825acmr2507343wmj.48.1704791282280;
        Tue, 09 Jan 2024 01:08:02 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id cw16-20020a056000091000b0033753a61e96sm1828362wrb.108.2024.01.09.01.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 01:08:02 -0800 (PST)
Date: Tue, 9 Jan 2024 12:07:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Kees Cook <keescook@chromium.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	linux-hardening@vger.kernel.org, error27@gmail.com,
	gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
	Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
	darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in
 dg_dispatch_as_host()
Message-ID: <79ca2f85-1f8d-4a12-aa5a-09137033605f@moroto.mountain>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <202401081430.9DAB37B46@keescook>
 <9c742547-0021-464b-b7a8-7af46b0a4afa@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c742547-0021-464b-b7a8-7af46b0a4afa@embeddedor.com>

On Mon, Jan 08, 2024 at 08:05:38PM -0600, Gustavo A. R. Silva wrote:
> > > Gustavo quoted:
> > > "Under FORTIFY_SOURCE we should not copy data across multiple members
> > > in a structure."
> > > 
> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
> > > Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > 
> > Thanks for getting this fixed!
> > 
> > Yeah, it's a "false positive" in the sense that the code was expecting
> 
> It's a false positive _bug_, and a legitimate _warning_ coming from fortified
> memcpy().

It really feels like you're trying to sell the cost of this as a good
thing...  We've already merged fortify so why are you still fighting
about this?  Now that it's merged, let's just all admit that false
positives are bad.

I feel like once we recognize that actually false positives are bad as
opposed to good then that's when we start looking for solutions.  In
Smatch, I have code that silences warnings about cross member writes
because it was a common source of false positives...

The Kconfig entry does not mention the risk of false positives at all
and it doesn't say anything about turning on fortify along with
CONFIG_PANIC_ON_OOPS is probably bad.  There are simple things we could
do to make this less risky.

regards,
dan carpenter


