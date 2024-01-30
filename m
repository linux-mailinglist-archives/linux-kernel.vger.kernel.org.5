Return-Path: <linux-kernel+bounces-44680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 639498425E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2010E2858A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7846BB47;
	Tue, 30 Jan 2024 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CeXq6TeK"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAA06BB28
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620358; cv=none; b=o5AjDfxo7TZkq2JRcN9r1JJVHIlp16VT6LySZN725ACfsXIjkx9KmXGQT4T9b/2HrJ6LzyGSN3J0qjYSn9RtINjHaiew6OSqwzXIMnbLENOlSHCZEfxwBh78hifNe+WVs+D7mH2I2eUczdYSjPYQJGxK0mIG3lrdMRMFXNIdqMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620358; c=relaxed/simple;
	bh=A+ONNkJdbSKWp/DxO94Z/o0YVNM65s8QEU9vU5ojKCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHBC4MmhCOAWNiHI+b11YCCPcgldGp9z85Bq/Y5LTPfMM3JdYhMdSWWi5SWqvsLbkQA4ng1/nUDk1dw2aQ6a/JBkzmA0cKufV8f4bOj6ih+p7FsdYqws4nbrTgchEH1ALAA4WUOvkq7GYXcxEQTp+epvcpyfM/d84BoqKfFdOeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CeXq6TeK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso490827666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 05:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706620353; x=1707225153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHNgqo2ejpHW782QEu4xpIQb0v6vpUHndrnJztXi/5Y=;
        b=CeXq6TeKw0l5TQWmAxNDL8ZT2AYiKOAflGQJrm8jm2y79zslEbC11SgQ8JKWDFdhhK
         RDyXm8NeAn6tEHlGkLtuIRakHdfEO3ar/Nykc5p81frl24gUylP0sSVvjAHoIp3P99Q0
         Y2Jh2uxU2j3yoMAs0I735Isc/4uwgAxDpCYpLpzhJyipIELOtIXw0PF5uLlX28KvHvaX
         qYpoqi8lTW2VvW8jW66tFWc5HhKWV/gMDJzGzralpcOD+qsFXJiyu1VsgnBKBxZV1DEA
         +zApGFMFfYH0As72OAfU+sWWLLcnIbRW937jbaUidMOZHQzVJM89AcG/FM3BP2pdn9FX
         qu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706620353; x=1707225153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHNgqo2ejpHW782QEu4xpIQb0v6vpUHndrnJztXi/5Y=;
        b=stZkyhsq+o2hGH8Ou99RmljTmlxOkZEYOkY4C18yWrULjgwua0FIRzTTdYQy6aK+n+
         rJboNgS440QeXO+yN2jshdeVMoCcJRDfbXGPclq3nCldo0o9HYCdCgbUCgF1Z/j/PmSM
         /12VParlfEEqT0+ypbrALqeeosxD1UcRbdYCpgMKqxe6AtQNFA6Cj2xZTfSxUcDLQdsE
         FAMDAVC5eTP0bU3ZUniJIHoAmv1K2DFjfW9fnfkmm3Zi/S+daAmUGAF25bFUze1E7hhZ
         qP59/+S7CmZXuk/MaftJ1CwZLBs4P/srPuRh2Vpm0PZG/XLRt5t9WsbFKNwbXxBOrc9F
         d/YQ==
X-Gm-Message-State: AOJu0YzwsvfswOYSA3Pezy17OkKUQrL3IAiKUwUxhUfOuI1CGylP7Zkq
	t3Sdq1IcOhVlz3se+D/G0orD+zybpV7nb+2ufksYx2hlBITRjp14Z3TiUntAtuP30J4bl+8iyPb
	q
X-Google-Smtp-Source: AGHT+IGVsxfy6AcPEm4G3hK1VaRqmYqT5vMX9QHNlYuLQjyEKhJ783PAnYve61iT470I9ZGE9G7Z5A==
X-Received: by 2002:a17:906:e098:b0:a2f:1817:2ef with SMTP id gh24-20020a170906e09800b00a2f181702efmr6568527ejb.70.1706620353194;
        Tue, 30 Jan 2024 05:12:33 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id l14-20020a170906a40e00b00a35de0619dbsm1694437ejz.200.2024.01.30.05.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 05:12:32 -0800 (PST)
Date: Tue, 30 Jan 2024 14:12:31 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 05/14] printk: ringbuffer: Clarify special lpos
 values
Message-ID: <Zbj1vz5J1hgXaLf4@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-6-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214214201.499426-6-john.ogness@linutronix.de>

On Thu 2023-12-14 22:47:52, John Ogness wrote:
> For empty line records, no data blocks are created. Instead,
> these valid records are identified by special logical position
> values (in fields of @prb_desc.text_blk_lpos).
> 
> Currently the macro NO_LPOS is used for empty line records.
> This name is confusing because it does not imply _why_ there is
> no data block.
> 
> Rename NO_LPOS to EMPTY_LINE_LPOS so that it is clear why there
> is no data block.
> 
> Also add comments explaining the use of EMPTY_LINE_LPOS as well
> as clarification to the values used to represent data-less
> blocks.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: Just for record. I had to make a pause in the review
    because I have been on a sick leave last week and half.


