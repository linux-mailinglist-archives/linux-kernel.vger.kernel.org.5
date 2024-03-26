Return-Path: <linux-kernel+bounces-119161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6B588C4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15FD1F3CFC6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFEC129E7D;
	Tue, 26 Mar 2024 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YQKeQQGD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E1F80634
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462637; cv=none; b=oeMhZt/p8sOL3m5MrCeHdYlYZHcwRWZZSJV24ruBP77yvVF+GPETXn6nVtBMz7iwmMWCjRauqXyTWoL/8b9pbcpaeZ+hotWTFjB1GVqDwcUK/hh+4OjY4OguZw7zxMV+v/VCqQMBQ4l+zMKe45tZM7XL42riDVyItrkSMTmD2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462637; c=relaxed/simple;
	bh=TrVeDU0uR65eRy+Mpo4DguINOUOGg6f7SUedywVxRac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vA8A62t58JMEi7rQs2bevYXhychvF8oCxXWqjPQd9XPbN5OyO/ghCw8kxbVMLwSFpGCHtwCdJN6mk/VPlxt8A5UML9eDGGTo8LR5XsyWoE4FcNxFLgnCWQ1drNhsC3a0ChqxbdGUPE9A7vPMCnHp9y206ANjSXZ+WnlRAVEi1no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=YQKeQQGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A212C43609;
	Tue, 26 Mar 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YQKeQQGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1711462634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mHXe/7UhlsoSGGI2nlSEGBHAtnt1Nhox4n9CWQjsB2U=;
	b=YQKeQQGD538lRepe0IYjhUye29culSEgRbPAYJc9f+r0NqC0STcRW5OD+nLtwkotBrDZha
	0V6fD9R7XTjsg4YvELxvYT9uUhlW+N+sAEURezY5/CX2sc6Zk66bNnpQi5mEAR2avg4SZC
	2MvarbqCGoNcO30hh4SfOrkZGB/nwf0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2bb37daf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Mar 2024 14:17:14 +0000 (UTC)
Date: Tue, 26 Mar 2024 15:17:14 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: vmgenid: drop redundant .owner
Message-ID: <ZgLY6i7zZDh5uDb0@zx2c4.com>
References: <20240326075337.55377-1-krzysztof.kozlowski@linaro.org>
 <461a8c3d-460b-4ca4-aa90-b70685958f6f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <461a8c3d-460b-4ca4-aa90-b70685958f6f@linaro.org>

On Tue, Mar 26, 2024 at 09:07:52AM +0100, Krzysztof Kozlowski wrote:
> On 26/03/2024 08:53, Krzysztof Kozlowski wrote:
> > Core already sets .owner in acpi_bus_register_driver().
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  drivers/virt/vmgenid.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
> > index b67a28da4702..8f6880c3a87f 100644
> > --- a/drivers/virt/vmgenid.c
> > +++ b/drivers/virt/vmgenid.c
> > @@ -88,7 +88,6 @@ static const struct acpi_device_id vmgenid_ids[] = {
> >  static struct acpi_driver vmgenid_driver = {
> >  	.name = "vmgenid",
> >  	.ids = vmgenid_ids,
> > -	.owner = THIS_MODULE,
> 
> This does not make sense and is not correct.  I need to fix
> acpi_bus_register_driver first(). Please ignore.

Oh, okay. Does that mean this will resurface as part of a series that is
core fix + individual driver cleanups subsequently?

You made some comment on the other thread indicating that this
meant the driver is "clearly abandoned" because of "all this owner
crap". Wondering if this driver here hits some weird edge case that
isn't covered by changes made "many years ago" or if something else is
up.

Jason

