Return-Path: <linux-kernel+bounces-126841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B90893E51
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823691F22A90
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0707547A57;
	Mon,  1 Apr 2024 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPjhSYV3"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5321CA8F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987317; cv=none; b=WSzmxJBfnKte2K4Xgos7qUy/C5oEXefYLEwC94VjctWYQLgbS6mSSF+u5qThG5jJtMNNYvmmCkUvJH6jOEIakbK3vkBBCkyi0PwUqEr+9eYi4jXACVVBzu/WDWIrWZjsHdtRkMkf2BDI9I6rXEx6Q0wCJFn6bTPQd9n8tOOrOBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987317; c=relaxed/simple;
	bh=3jY/J46RZtli8mScReLicmAc9lElr0SHi5G+SHCPV0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mY/AXtJBRgOSLarJ5v3XxsFOgu+a6G8iPcscToboFmKmEa5NrI3JbXP7wZQSJ5Xw0d7cIP+Q0XfSPBS/JJNw0zym+8Yqbf7aROBoDgea88Nk6832+v1OJcQLl2LuKiCWBMOGhhJFYJPtYUXmK4O09wE2Icr4YAEr58Or8R8vpBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TPjhSYV3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0edd0340fso37685375ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711987314; x=1712592114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iFnuB6vS67T3Bx2L10cFFT7Mq1afjPSG44HJZCE7BdQ=;
        b=TPjhSYV3goylMPbwtoV9tWPNmBVjTJbtCVNGpoq8Tr3WfuDPFq89LZib+fOnRe819G
         xd5GpKWKDoc5ADwdz4/F5cUry6pvM04sqBCacB2gH0VcvwsULnruM+XLEJdVFFIVTEwN
         PGPEveinozZ3xqg63HHTCdwBytX0S912RwphNBHt5Q3tugWbTKyEapBDaeASxwEuWpvK
         e/Kg1m05+t5SsNHw5X2EtpeUnmlWxBIyKWJsXdS7PZX6ricKCzB4KK7fHKNQl6rtvD3u
         wIJktqs+PATq5dNU3Qop5KNZzt4E5x3d6YyMBFR0KRV66/P3XRusV8vebMeCTqnDRhm/
         SnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711987314; x=1712592114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFnuB6vS67T3Bx2L10cFFT7Mq1afjPSG44HJZCE7BdQ=;
        b=EygtMIP9YqQB3UAcuikEGp0N9MHYyUFJ0L2hrdcASUjGfxYLPAnujPG0eKiSD9ge/k
         Ob5EfebZxrqC+6djNjQjuHIwax1XOJuW7lP0HVXDbDNkB6Qvho0igv7pa9hklt+IAHeS
         PymJKe6qeyvlYs8j/6CKTIWbhcdnNd9uBNUGRHZbokeLHAGIxXbLbhqGLqfdCLp+u4Qc
         QS/3j98UU2tgdqI9OC5aoGBrB3SrOvdBksPdRNLIw+WTXi9kVDAHL1bj4FFnQLqf9lRW
         2arvfqWRCKEImppuOjACL8wVWok7yLrxQFEtZO18hDXchnOH9T8zV3DpyFbEjaQS8LD0
         TcRA==
X-Forwarded-Encrypted: i=1; AJvYcCVJLHzMtqQLO1q6BMcCOtPW/wFuYBhjDl8ofxQp93GVRPuEw0m83VJqrjQKwIxPdtcptv7RdicwUS0RZaxl1eQLsMMCE0f77nmNlE20
X-Gm-Message-State: AOJu0YzBiRkL2BtJwR/jf2nUAdR3Mb7n84D3QfcaV0IeGvPydQAbzZep
	jxKI61UmZXQUOiErWmNE617HAxIKQ5oI+kzabmyD+4c7wVSKy3I60w9/czNrGMM=
X-Google-Smtp-Source: AGHT+IE2dwtITxXsxaB0G/uLpOwwGbnutfeGyBbuSp4/5enbVEAxS7FoDRT1e/cft7qh39/yhDc8SQ==
X-Received: by 2002:a17:903:543:b0:1dd:e114:121c with SMTP id jo3-20020a170903054300b001dde114121cmr10066859plb.56.1711987314265;
        Mon, 01 Apr 2024 09:01:54 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:8aef:41d9:be1:3de4])
        by smtp.gmail.com with ESMTPSA id lc13-20020a170902fa8d00b001e0c949124fsm9133368plb.309.2024.04.01.09.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 09:01:53 -0700 (PDT)
Date: Mon, 1 Apr 2024 10:01:51 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] remoteproc: k3-dsp: Fix usage of omap_mbox_message
 and mbox_msg_t
Message-ID: <Zgrab/l1Fp5HPKDb@p14s>
References: <20240325165808.31885-1-afd@ti.com>
 <ZgWMi088/zORh0m3@p14s>
 <0697211f-4a28-4a74-8540-840c075d513c@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0697211f-4a28-4a74-8540-840c075d513c@ti.com>

On Thu, Mar 28, 2024 at 11:26:24AM -0500, Andrew Davis wrote:
> On 3/28/24 10:28 AM, Mathieu Poirier wrote:
> > Hi Andrew,
> > 
> > On Mon, Mar 25, 2024 at 11:58:06AM -0500, Andrew Davis wrote:
> > > The type of message sent using omap-mailbox is always u32. The definition
> > > of mbox_msg_t is uintptr_t which is wrong as that type changes based on
> > > the architecture (32bit vs 64bit). Use u32 unconditionally and remove
> > > the now unneeded omap-mailbox.h include.
> > > 
> > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > ---
> > >   drivers/remoteproc/ti_k3_dsp_remoteproc.c | 7 +++----
> > >   1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> > > index 3555b535b1683..33b30cfb86c9d 100644
> > > --- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> > > +++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> > > @@ -11,7 +11,6 @@
> > >   #include <linux/module.h>
> > >   #include <linux/of.h>
> > >   #include <linux/of_reserved_mem.h>
> > > -#include <linux/omap-mailbox.h>
> > >   #include <linux/platform_device.h>
> > >   #include <linux/remoteproc.h>
> > >   #include <linux/reset.h>
> > > @@ -113,7 +112,7 @@ static void k3_dsp_rproc_mbox_callback(struct mbox_client *client, void *data)
> > >   						  client);
> > >   	struct device *dev = kproc->rproc->dev.parent;
> > >   	const char *name = kproc->rproc->name;
> > > -	u32 msg = omap_mbox_message(data);
> > > +	u32 msg = (u32)(uintptr_t)(data);
> > 
> > Looking at omap-mailbox.h and unless I'm missing something, the end result is
> > the same.
> > 
> > 
> > >   	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
> > > @@ -152,11 +151,11 @@ static void k3_dsp_rproc_kick(struct rproc *rproc, int vqid)
> > >   {
> > >   	struct k3_dsp_rproc *kproc = rproc->priv;
> > >   	struct device *dev = rproc->dev.parent;
> > > -	mbox_msg_t msg = (mbox_msg_t)vqid;
> > > +	u32 msg = vqid;
> > >   	int ret;
> > > 
> > 
> > Here @vqid becomes a 'u32' rather than a 'uintptr'...
> > 
> 
> u32 is the correct type for messages sent with OMAP mailbox. It
> only sends 32bit messages, uintptr is 64bit when compiled on
> 64bit hardware (like our ARM64 cores on K3). mbox_msg_t should
> have been defined as u32, this was a mistake we missed as we only
> ever used to compile it for 32bit cores (where uintptr is 32bit).
> 
> > >   	/* send the index of the triggered virtqueue in the mailbox payload */
> > > -	ret = mbox_send_message(kproc->mbox, (void *)msg);
> > > +	ret = mbox_send_message(kproc->mbox, (void *)(uintptr_t)msg);
> > 
> > ... but here it is casted as a 'uintptr_t', which yields the same result.
> > 
> 
> The function mbox_send_message() takes a void*, so we need to cast our 32bit
> message to that first, it is cast back to u32 inside the OMAP mailbox driver.
> Doing that in one step (u32 -> void*) causes a warning when void* is 64bit
> (cast from int to pointer of different size).
> 
> > 
> > I am puzzled - other than getting rid of a header file I don't see what else
> > this patch does.
> > 
> 
> Getting rid of the header is the main point of this patch (I have a later
> series that needs that header gone). But the difference this patch makes is that
> before we passed a pointer to a 64bit int to OMAP mailbox which takes a pointer
> to a 32bit int. Sure, the result is the same in little-endian systems, but that
> isn't a strictly correct in general.

From your explanation above this patchset is about two things:

1) Getting rid of a compilation warning when void* is 64bit wide
2) Getting rid of omap-mailbox.h

This is what the changelog should describe.  And next time, please add a cover
letter to your work.

Thanks,
Mathieu

> > >   	if (ret < 0)
> > >   		dev_err(dev, "failed to send mailbox message (%pe)\n",
> > >   			ERR_PTR(ret));
> > > -- 
> > > 2.39.2
> > > 

