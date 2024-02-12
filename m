Return-Path: <linux-kernel+bounces-61429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B8F85123F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898482829C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D883B38FBC;
	Mon, 12 Feb 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="KKOY9uud"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A3738DE2;
	Mon, 12 Feb 2024 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737403; cv=none; b=AEUphoaQoKAUoxPAfN3/itRPrQ3kMXo+kcPyNqMoKOqafucaqBRE65TujBCXDL/hGDN6FuwNe200vkdDlKYmckIFga48p/M+acQDuCBxuETnSFe0OayRRmX0+9Yqha0403fmWWoGeQ6Z8ET6u5Al/mwllQh83e0HzT87aiX8WWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737403; c=relaxed/simple;
	bh=wHNMVNWK/w9GJUGqEQBEQnxp1z9OF3ab6ZUMoNLudvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/4lNm4eG+GfGrW/b7xNfWc2/mvEwaa9WU4vzTC5CHmqCY/7gTrzCX6ax+ap4oYS/HizFjFtkXSgzBJfjLLD8vU6CiGdUOkmCbknjp3/RKkOaCs/xKHS8ht6G8dhBqggaXoBf/7jEosI2KCFa3Yc1q9VlXCOswwAXi1FJnIKPSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=KKOY9uud; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e2e507b942so484330a34.1;
        Mon, 12 Feb 2024 03:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707737400; x=1708342200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z4h2DO1YDh7Cbrp5C2cI3eDKxNVoHo7pCybkKBnqfOE=;
        b=n+rBeoUEhzP1IWWVJFyb10qUa9ZY2emxz02EeZGtnJEuSTHbJlYK2e03CBEPoyjOlE
         EsgCASeftlTDL3YOpyLisvYRf3I27KVXcy++2NZa77izh+4OoN/S/eVi4DJB0rsWQ9yE
         zO1hnOwHfzmwF3rqBtobPnLn33XshH2J9AwIsnqT4CG6qixjnQWz/gOqQdDoG3CgoT7g
         F7UCE/VWpSZ/ehty5mjbdxSh5w90j6cHwK6sqNzbFgLvSflQxA0y1OhNm10aMj9icPdN
         Zq1htFFBwhZhSev5ssklE1g5ASCE0sLkWDn083bzEe2RO8vocv8NLmv0Cksh4SrlNGzE
         HEAw==
X-Forwarded-Encrypted: i=1; AJvYcCVcJ+Z7xQ1xFQqr7DiCvyV9YbJDNC0T+EBqOcMkvV/QdOvuK2oXQYFVCwrDHzYkYD8OW3rT9alSqLL97iw+uIHlBAvsBGalZjN1FJKdR6xlAtbZRdU8+D/7ljZ9LDPEtc1HIwdNzOjRJA==
X-Gm-Message-State: AOJu0YyzLAFxQQg3kyCZ0pEUkraPxFSDWj8bDUrNhPnnQU4kJFMDHzlp
	GlkoLWvXLc8oaR3Xv2zXf37HqLnJRvw0uTuGbnLq1dcy+gsZ+DCj
X-Google-Smtp-Source: AGHT+IGEL/O4Tj2MNd6er8WCrenKgU9sj4RH/c1ZcLON895KqnhVVbuz1FDTq1CXmCPR3YwAeL7JmQ==
X-Received: by 2002:a05:6358:618c:b0:176:470f:9275 with SMTP id w12-20020a056358618c00b00176470f9275mr7382118rww.21.1707737399967;
        Mon, 12 Feb 2024 03:29:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDSgDpFpTsFY9w9wMzTQQZk2XXhuEqol7vq1FWj+gmYE6KX00Ck6BRIbFWfMzpvli2PqbrT8fuEZ3LObFOc6dS24Y9Qw/zeXC4J2xKF4rdhpSiZl1v+BYqC9shuKBJusBJBk6X/LqxfYNNVRlKQDN/r9zyjhYFhnD6Oxu1wkYeyjVL5yA=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id k29-20020a63ba1d000000b0059b2316be86sm174708pgf.46.2024.02.12.03.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:29:59 -0800 (PST)
Date: Mon, 12 Feb 2024 08:30:35 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707737397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4h2DO1YDh7Cbrp5C2cI3eDKxNVoHo7pCybkKBnqfOE=;
	b=KKOY9uudcbHzK2Ha73rWAiI9iPhfdDnG6fAf1Rkyasw87QRT/q6C84/6BLdtbJc8UTrM6G
	D4MSiqrABqVP94gZOzKH/zfxploASKdrOX588URL8/T/WvjJEr4UbFRzMHgrzxXyRYB4/b
	/pudh2ubR/0PFdf2/NiVDjVofRI9s/7sioOa/uTL/uyD6Ye0EzQjm4me5kTXrEZGSl6JaO
	ggehdbDIFcW2q9d/G7t2/9ZDeEUvJZydcNRPVh22H4isi9Y4BqG2eaOnExLGF0xKAOLPvg
	YDHOGQieOzHqwZPAF19k83gje98gBEi76nHfUvSTdnYSNmdK3hEoeR5cfHPzsQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: Make scsi_bus_type const
Message-ID: <zcv7kteidcnqj3kpiwwmpdytuirhxbdnzri2rfmumujftthyft@xvcqzmyr2clb>
References: <20240211-bus_cleanup-scsi2-v1-1-dd04ee82e6b0@marliere.net>
 <2024021246-canon-planner-2bf6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021246-canon-planner-2bf6@gregkh>

Hi Greg,

On 12 Feb 11:45, Greg Kroah-Hartman wrote:
> On Sun, Feb 11, 2024 at 12:33:50PM -0300, Ricardo B. Marliere wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the scsi_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> > 
> > Remove some extraneous whitespace.

I saw some patches did this, thought it would ok to add.

> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  drivers/scsi/scsi_priv.h  | 6 +++---
> >  drivers/scsi/scsi_sysfs.c | 6 +++---
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
> > index 1fbfe1b52c9f..6a02114776b3 100644
> > --- a/drivers/scsi/scsi_priv.h
> > +++ b/drivers/scsi/scsi_priv.h
> > @@ -54,7 +54,7 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd);
> >  void scsi_log_send(struct scsi_cmnd *cmd);
> >  void scsi_log_completion(struct scsi_cmnd *cmd, int disposition);
> >  #else
> > -static inline void scsi_log_send(struct scsi_cmnd *cmd) 
> > +static inline void scsi_log_send(struct scsi_cmnd *cmd)
> 
> Why is this line changed?
> 
> >  	{ };
> >  static inline void scsi_log_completion(struct scsi_cmnd *cmd, int disposition)
> >  	{ };
> > @@ -156,7 +156,7 @@ extern void scsi_sysfs_device_initialize(struct scsi_device *);
> >  extern struct scsi_transport_template blank_transport_template;
> >  extern void __scsi_remove_device(struct scsi_device *);
> >  
> > -extern struct bus_type scsi_bus_type;
> > +extern const struct bus_type scsi_bus_type;
> >  extern const struct attribute_group *scsi_shost_groups[];
> >  
> >  /* scsi_netlink.c */
> > @@ -197,7 +197,7 @@ struct bsg_device *scsi_bsg_register_queue(struct scsi_device *sdev);
> >  
> >  extern int scsi_device_max_queue_depth(struct scsi_device *sdev);
> >  
> > -/* 
> > +/*
> 
> And this?
> 
> 
> >   * internal scsi timeout functions: for use by mid-layer and transport
> >   * classes.
> >   */
> > diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> > index 24f6eefb6803..7f1fede8ef5d 100644
> > --- a/drivers/scsi/scsi_sysfs.c
> > +++ b/drivers/scsi/scsi_sysfs.c
> > @@ -549,7 +549,7 @@ static int scsi_bus_uevent(const struct device *dev, struct kobj_uevent_env *env
> >  	return 0;
> >  }
> >  
> > -struct bus_type scsi_bus_type = {
> > +const struct bus_type scsi_bus_type = {
> >          .name		= "scsi",
> >          .match		= scsi_bus_match,
> >  	.uevent		= scsi_bus_uevent,
> > @@ -656,7 +656,7 @@ static int scsi_sdev_check_buf_bit(const char *buf)
> >  			return 1;
> >  		else if (buf[0] == '0')
> >  			return 0;
> > -		else 
> > +		else
> 
> And this, please be more careful, it looks like your editor stripped out
> all trailing whitespace, which is fine for new files, but not for
> existing ones.

In fact it took me a while to figure this out, as I don't have
format-on-save enabled. It's actually due to the recently added
editorconfig file to the tree. I can send it without the whitespace
changes if that's better, but it's there in the changelog. Please let me
know.

Thanks for reviewing,
-	Ricardo.



> 
> thanks,
> 
> greg k-h

