Return-Path: <linux-kernel+bounces-94577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F368741AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595AD1F22446
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0521A5AC;
	Wed,  6 Mar 2024 21:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3MlpxjPt"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3651B806
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759611; cv=none; b=iggAtqF0y1iveXyb3Ftmu0ScWM9NMODfSLkO/URA5dVsd+8vqPEq8KeWt4DK53pZFWepm0VEAH3RABXuikCxXExoW3wb7eIQ1ErElH/iXvQEDtcFizUsTSiWDGWj3OYausTT3QdGYnTrFDzReSLWUuQhlCEoFzfS/EVmiMA5FQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759611; c=relaxed/simple;
	bh=d883N2vJtpZj5bifCRAlDtYmvlYuDPPoWBWkmtRiq6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgCZcF8tT2/U0uCRO3OMY4hdwqC9r9YFRJjYh4L49Nyzuvevhq9xL4ynnlE5f2rlQxngQdx23usBKsqLVdCqYKDYAYYJr3n8gwsnaqoe2CB3a3JPtBVDz8frJVpFggs7x9YwR5nmY+0MrAkg2cAlOlANDbuO0xIPZI1Mu6Mg26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3MlpxjPt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dcd6a3da83so1101725ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 13:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709759608; x=1710364408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l2JVk38XPxvsT3/YhoDsMGF+vCTpgTNDdkuD7ePo4Wc=;
        b=3MlpxjPtVLPVJ5BScvq0HiKkCmWisnlK5Ozt8VO/pN7XFO7YPc6ynB16pLx8vDmE2b
         fI/3LDxOpB4Iu8+HSM8F4MIfRAMJIyH6k1sFv7oldzb8U6hKtJYfGi1hfATts+f3ATzu
         J6U2LDjS6pCafGa+LYU1ts57MXbwEk2NMDiM2JRTBeJcbOaguhXUCFaknOO0QHPAyeG5
         +OeyzrxncKsk974cNimDVbUbxXTWO1BqpNWUnoQodthV83TFKUIzAQRGyLga6kgRK+jg
         XLTbXmZNIMHg7Cvbsp303SASiHAcvg5BquewW2wrr9kmbVLu8xyp3BWRDMAqcWzLjxxt
         LLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709759608; x=1710364408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2JVk38XPxvsT3/YhoDsMGF+vCTpgTNDdkuD7ePo4Wc=;
        b=bWmx2OzRcNMSAS/ttX58EwO8rzTOl9MrSHOj0qUw+me9wTPi37txT9wq4nqvJW6Zpz
         NZGgtYBt5eKyMtXQKPGXceOQ4Xdc1TnutGXzzusQ4U5vEHgdfFai3TxMICXGnaJSAjon
         tFCAuwi77jHTHcyLskTSc4+M+7pn6IBtq2pqoViTQKOVsaoqR9LKcTwYEutai+wI2+mb
         CS4erqiLIU6Ue+QIs4nLqA0uOvC34z9E10oUQqOwDql2Rb4WyoouxLGgMuKa9oc+L55t
         +pZRkzubPGDS+PGy/GuRjwp2Wl7FxoeNPYwpNN/hoIp33Ug9chZ3x9KzzAtnRAIAlBuH
         E7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVaxIUIFTzAGUaGAgFedRJrNr5+PpRf09tl7ip+WyXweeQih4ZJ0Ll2W8C6kjLsPb42htdPLyTZsQnb68f4hzRq1ZCvye+mzvHI0ynM
X-Gm-Message-State: AOJu0YxhZ+NgHC855+P/xf5crpBsWP1mzQc1piREBmhqJrwN7fLuVFrv
	Hj7O4Z1Un2RYsH0dGZeaX6q48NuhSO/kElAa/Z389urIUAihvBLRJnM1cLppxg==
X-Google-Smtp-Source: AGHT+IEjY5wfLmhvO6o+PFnHEKHo1lDD+P9YoVu1QuPXyRH71YIGQ7FOVYJlLAbtUP4oshOZLuF4Yg==
X-Received: by 2002:a17:903:18f:b0:1dd:152:225d with SMTP id z15-20020a170903018f00b001dd0152225dmr8094717plg.8.1709759607700;
        Wed, 06 Mar 2024 13:13:27 -0800 (PST)
Received: from google.com ([2620:15c:2c5:13:9a91:c17:53d9:d156])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b001dbad2172cbsm13343407plb.8.2024.03.06.13.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 13:13:27 -0800 (PST)
Date: Wed, 6 Mar 2024 13:13:22 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Hannes Reinecke <hare@suse.de>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/7] scsi: mvsas: Add libsas SATA sysfs attributes
 group
Message-ID: <ZejccpVEsQTHjltB@google.com>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-5-ipylypiv@google.com>
 <ZehLl4AymauIvYl8@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZehLl4AymauIvYl8@ryzen>

On Wed, Mar 06, 2024 at 11:55:19AM +0100, Niklas Cassel wrote:
> On Tue, Mar 05, 2024 at 05:22:23PM -0800, Igor Pylypiv wrote:
> > The added sysfs attributes group enables the configuration of NCQ Priority
> > feature for HBAs that rely on libsas to manage SATA devices.
> > 
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Reviewed-by: Jason Yan <yanaijie@huawei.com>
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/scsi/mvsas/mv_init.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> > index 43ebb331e216..f1090bb5f2c9 100644
> > --- a/drivers/scsi/mvsas/mv_init.c
> > +++ b/drivers/scsi/mvsas/mv_init.c
> > @@ -26,6 +26,7 @@ static const struct mvs_chip_info mvs_chips[] = {
> >  };
> >  
> >  static const struct attribute_group *mvst_host_groups[];
> > +static const struct attribute_group *mvst_sdev_groups[];
> 
> I think you can remove this line.
>
I kept the forward declaration to match the mvst_host_groups style.

Perhaps mvs_sht can be moved to the bottom of the file so that all forward
declarations can be removed? This can be done in a separate cleanup patch
series.

I'll keep this and aic94xx patches as-is, unless there are objections.

> 
> >  
> >  #define SOC_SAS_NUM 2
> >  
> > @@ -53,6 +54,7 @@ static const struct scsi_host_template mvs_sht = {
> >  	.compat_ioctl		= sas_ioctl,
> >  #endif
> >  	.shost_groups		= mvst_host_groups,
> > +	.sdev_groups		= mvst_sdev_groups,
> >  	.track_queue_depth	= 1,
> >  };
> >  
> > @@ -779,6 +781,11 @@ static struct attribute *mvst_host_attrs[] = {
> >  
> >  ATTRIBUTE_GROUPS(mvst_host);
> >  
> > +static const struct attribute_group *mvst_sdev_groups[] = {
> > +	&sas_ata_sdev_attr_group,
> > +	NULL
> > +};
> 
> ..and move these lines up to be after:
> static const struct attribute_group *mvst_host_groups[];
> 
> 
> > +
> >  module_init(mvs_init);
> >  module_exit(mvs_exit);
> >  
> > -- 
> > 2.44.0.278.ge034bb2e1d-goog
> > 

