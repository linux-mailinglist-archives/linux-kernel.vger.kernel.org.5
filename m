Return-Path: <linux-kernel+bounces-92736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04799872521
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032B71C2501E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522B5134CE;
	Tue,  5 Mar 2024 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNbw9MOE"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB413FF2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658364; cv=none; b=ZPheore3FdRrDBGiPnmrgPP5U+/jf98NwkiKrKv2ry4UbvhXX04NUHvUPQz+zm6jw+qP1NyDhdfeCo4P3XYJqOY96syMcFo0ZT4MpDthf3dwOZ+/CIuDkAucTuxB+glpZForYb6Uh0U0oSoZDpbe4WBI8I/D3BVOosK9kT6/i84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658364; c=relaxed/simple;
	bh=9hB7kebOY+ApV7hOhqdHnmKf9HqXW88QoEAtE22lPyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eExEV4uthUWe/MfH0pEhN0wxynlFvQntiDehO9bVXzAcV7xpcVSmYCdyOrPDX39NntUkP1b16xsjFWs47f/uYeFqWsP9fHwvTD72XA0St57SZ36bXViUdx4FCOmadyPCxCbJpBm4k8CfguzufMoYlhskdopsO6QipH+iMUAi5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNbw9MOE; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51331634948so3945305e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 09:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709658361; x=1710263161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Vv0jpxd/xF2263SdlkZJNOdtU51Ivq7MydTX7x7qB4=;
        b=cNbw9MOE13CScemcKbheqsKbYSKGpPuoldgbZWGabiKO9A99J00pg1jGjozlQJelkP
         vfkVmo8EYhTRu/7N6r3C7VAOb5DXGSswZMWgAY/wqd20d1iOGKcYemW6t3ABw0SmXMzp
         43hX8R/v44sShLhIlzeIQqtG3+Y93Fk24VlWlyuqnofm3cDDjJZQMlHfG3e1OMbbgHUF
         GgZCBijHw0t/8LKEBKBLgDLYwlluOGo8dPJfr3i0QmisjQft5Vtj1NWaN/y39Ibbl9M2
         xIrux4ERkrH9YZzyZ3rxIQzdFydDgf3gApKhO2h31nZIc1LBwLQm8KEOgF+kKkQaPWga
         3Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709658361; x=1710263161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Vv0jpxd/xF2263SdlkZJNOdtU51Ivq7MydTX7x7qB4=;
        b=T6t77cnA6TOq9adLF+fIShlvtNEnOFD9+ckXnv8F0c+1Gx5Gc1mu1o2JLHuvSqtPpU
         4gInHS9YKSWP/gjiMnESLtf25Jb/gbSwoemqmJuY46rsozl8nE1ZTY3jmbnEOk/KClDZ
         yXLUZ0NdilPGVQobufYb5TYRUsjDltMzl12ASxR06pUugL5UJr/zs4pfwYkUpQeIo0Yu
         YJzehbsFAfzmahQEyXxvh1CyLmRCET4AIK87N7dNG2EIwjsH6wQvXrY+50Zb6AW24ZMQ
         w3o0ntLQ/eEWNKtQhTHhAd+IX15+YBtN4dwH94AJAKykOBJsGQiW5lVTuLlKda6VA2Ar
         xXSg==
X-Gm-Message-State: AOJu0YxaR5tmtr20L889+W2fA/4SRZMb9WFg9E2wgkPkM0NmGxF2Jkq7
	/xwsPzWj8PPBdxf3CulaFY6IJwGRObMu7z7149plaEKZHZaF9Jtl
X-Google-Smtp-Source: AGHT+IHBMwrDwxHyDONoPE8x+wLL5t36iq8HBi84FUfUY3f0bljsiU3xqW/J7kEHl4UnH8xUkv5Y4A==
X-Received: by 2002:a19:ad08:0:b0:513:486a:579b with SMTP id t8-20020a19ad08000000b00513486a579bmr910603lfc.0.1709658360569;
        Tue, 05 Mar 2024 09:06:00 -0800 (PST)
Received: from HP-ENVY-Notebook (c83-255-0-123.bredband.tele2.se. [83.255.0.123])
        by smtp.gmail.com with ESMTPSA id y17-20020a197511000000b005131cefefd8sm2238050lfe.240.2024.03.05.09.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 09:06:00 -0800 (PST)
Date: Tue, 5 Mar 2024 18:05:58 +0100
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/2] staging: vme_user: Add a newline after variable
 declarations
Message-ID: <ZedQ9kyNwY+j7Umr@HP-ENVY-Notebook>
References: <20240303100547.153636-1-bergh.jonathan@gmail.com>
 <20240303100547.153636-2-bergh.jonathan@gmail.com>
 <2024030549-sanding-finisher-dc6a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024030549-sanding-finisher-dc6a@gregkh>

On Tue, Mar 05, 2024 at 02:13:23PM +0000, Greg KH wrote:
> On Sun, Mar 03, 2024 at 11:05:47AM +0100, Jonathan Bergh wrote:
> > This patch makes the following change:
> >  * Adds a newline after the variable declarations as per checkpatch's
> >    warning
> > 
> > Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> > ---
> >  drivers/staging/vme_user/vme_tsi148.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
> > index 2a92497c5570..a1b8288b101a 100644
> > --- a/drivers/staging/vme_user/vme_tsi148.h
> > +++ b/drivers/staging/vme_user/vme_tsi148.h
> > @@ -34,6 +34,7 @@ struct tsi148_driver {
> >  	void __iomem *base;	/* Base Address of device registers */
> >  	wait_queue_head_t dma_queue[2];
> >  	wait_queue_head_t iack_queue;
> > +
> >  	void (*lm_callback[4])(void *);	/* Called in interrupt handler */
> >  	void *lm_data[4];
> >  	void *crcsr_kernel;
> 
> Please always look at the change to see if checkpatch is correct or not
> (hint, for this one, it is not.)  Also see the archives for many people
> who have done the same thing in the past :)

Got it, thanks for that. 

> 
> thanks,
> 
> greg k-h

