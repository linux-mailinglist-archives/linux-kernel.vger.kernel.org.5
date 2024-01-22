Return-Path: <linux-kernel+bounces-32417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0842E835B78
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595BAB250AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD90F512;
	Mon, 22 Jan 2024 07:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T1a8kOao"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDAD17C80
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907726; cv=none; b=O5cVG7Xc5OZtCWKUXnjP6VtSSmz1BvJY826XSkRVtl5NCzUwGrhsoUxoQiWrsw2DaNcpEWBI6u5FaZUac5E/Nk1E3l9pZ8qX0EZ0ffv2b4+jMhQeG2iA1QXw6+vfv4+L5N44wWxdBQ+JLbB7iZBIBsKovf/RcB0o55/ciGZVEeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907726; c=relaxed/simple;
	bh=YCFZKMxT5pftMLplwAg4YBXUQE31/i4Ak24i9qQ3Vi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxoYXtyvsXivrhWjaC2Bd5+qV3PeERIwHnf8HXB0iqychzGkSNG2liRNr4kVrRhrcPhaGz2NeIYsfE8TP7TYcMWGkyV8M69linYznJqAXh3lFte4NTNbLN/mS+0eqthvbzwXMTCWYhvcB6jLs9yuGepzHVeFP4pWpoQ6hoo/aX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T1a8kOao; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e9101b5f9so32924715e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 23:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705907723; x=1706512523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lHP43ExYfIoYQZnh2Pw1TOnG0wcXeFiwfIKZwpRcOpg=;
        b=T1a8kOaoYhGotn1q0+RJ62WdYZnxImOo4g7Ox+9L1AKwZIij2twARSPijBh5BakNea
         pgZa4g8sRzZFii0eN0QnxIoEeztHGL/+npjarAiBJm5+Ac2NNDHl4bVgWRnkwdW77iAa
         n+yYYkDxCm9QDAgriaadCGdlQa7GgmpqAyVN08a/kX71DEXSNSOZcuIoW9FMovJ5yjNF
         NAWM5UZZDcwd9G7nf88JDaqefG/DiUkxFlmdFXYo9bY+W5DaTSrf6QkvXcHI/PReWN8l
         gDJRD8q591AKuHtVY7rF4B1AszyYMybgIY/dXFH7b3jzNmOa19PNYvoBWFEqlN76+SWu
         vdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705907723; x=1706512523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHP43ExYfIoYQZnh2Pw1TOnG0wcXeFiwfIKZwpRcOpg=;
        b=JVp24ArK8QQqegoJ6LQUQ7SM9YWBzWZm3/NQMcdxFd27hYfBF53dDnw8CXsCGAQR6s
         RreRinmFIjWw8X6YV4W1RvdPmcRzltWltcyKuYS27p7iTXWwZo1+nzUpaQMOUjOgm0UT
         pXABW9H6N0boy3XsTXVXwzxVJz+iQDiJAjg4btTqpzmX1Xtxtqtmy0IhktyydxrF9WD2
         cJbtfhwIzRY5PbCP1t7sfbbQgI7WiAz5oqTTenDa04im3w/9wo+E/+ap0nybUPebaGEO
         odp3ZHajJ/r1HQq3F6N0PE9vm5LywF1G7QTmRdmx4xRB2n6GZDhBCq1xMStryaN+hNTq
         4Yag==
X-Gm-Message-State: AOJu0YxHYISiWOqP9aSCdqqknfS0HfpEnrptEIvO3FUY1+gV6U7p0dnL
	X9rd7c+Trk5NSDcJvDgSsOyVxI2K4ELwynK51oo3xd15v7LbTfXQmXyKxh96fYU=
X-Google-Smtp-Source: AGHT+IG5Alz3MHBgjGmE6oE6CLb/yvjcodQR+lNTfG+1BAcFnW7rpEcukUwXKZxigVRf06Emw/Yw6A==
X-Received: by 2002:a05:600c:498a:b0:40e:5a80:6177 with SMTP id h10-20020a05600c498a00b0040e5a806177mr1997539wmp.69.1705907723421;
        Sun, 21 Jan 2024 23:15:23 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id w4-20020a05600c474400b0040d5ae2906esm42185282wmo.30.2024.01.21.23.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 23:15:23 -0800 (PST)
Date: Mon, 22 Jan 2024 10:15:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Erick Archer <erick.archer@gmx.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: ep: Use kcalloc() instead of kzalloc()
Message-ID: <43614a09-d520-4111-873a-b352bd93ea07@moroto.mountain>
References: <20240120152518.13006-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120152518.13006-1-erick.archer@gmx.com>

This code does not have an integer overflow, but it might have a
different memory corruption bug.

On Sat, Jan 20, 2024 at 04:25:18PM +0100, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> count * size in the kzalloc() function.
> 

This one is more complicated to analyze.  I have built a Smatch cross
function database so it's easy for me and I will help you.

$ smbd.py where mhi_ep_cntrl event_rings
drivers/pci/endpoint/functions/pci-epf-mhi.c | pci_epf_mhi_probe              | (struct mhi_ep_cntrl)->event_rings | 0
drivers/bus/mhi/ep/main.c      | mhi_ep_irq                     | (struct mhi_ep_cntrl)->event_rings | min-max
drivers/bus/mhi/ep/mmio.c      | mhi_ep_mmio_init               | (struct mhi_ep_cntrl)->event_rings | 0-255
drivers/bus/mhi/ep/mmio.c      | mhi_ep_mmio_update_ner         | (struct mhi_ep_cntrl)->event_rings | 0-255

The other way to figure this stuff out would be to do:

$ grep -Rn "event_rings = " drivers/bus/mhi/ep/
drivers/bus/mhi/ep/mmio.c:260:  mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, regval);
drivers/bus/mhi/ep/mmio.c:261:  mhi_cntrl->hw_event_rings = FIELD_GET(MHICFG_NHWER_MASK, regval);
drivers/bus/mhi/ep/mmio.c:271:  mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, regval);
drivers/bus/mhi/ep/mmio.c:272:  mhi_cntrl->hw_event_rings = FIELD_GET(MHICFG_NHWER_MASK, regval);

That means that this multiplication can never overflow so the patch
has no effect on runtime.  The patch is still useful because we don't
want every single person to have to do this analysis.  The kcalloc()
function is just safer and more obviously correct.

It's a bit concerning that ->event_rings is set multiple times, but only
allocated one time.  It's either unnecessary or there is a potential
memory corruption bug.  If it's really necessary then there should be a
check that the new size is <= the size of the original buffer that we
allocated.

I work in static analysis and I understand the struggle of trying to
understand code to see if static checker warnings are a real bug or not.
I'm not going to insist that you figure everything out, but I am asking
that you at least try.  If after spending ten minutes reading the code
you can't figure it out, then it's fine to write something like, "I
don't know whether this multiply can really overflow or not, but let's
make it safer by using kcalloc()."  You can put that sort of "I don't
know information" under the --- cut off line inf you want.

regards,
dan carpenter

