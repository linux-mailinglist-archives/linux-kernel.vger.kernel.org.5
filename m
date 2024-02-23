Return-Path: <linux-kernel+bounces-77823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F08E860AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC1D6B22050
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC19412B60;
	Fri, 23 Feb 2024 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uL3o/K5J"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4845A13AF3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708668552; cv=none; b=ChB1POokoBKZUfsApiNqWbofPp08wd/l8VN984mQrKfctBjDrVCdf/Ap5kF3GuTPgL3GkGMWIxZO1AVeERsampt4pIVk/tJ7F+CL4jzjfSCNZ8hAFM28NDR9vkaR0C7QHm+6zB3Wc49UaYTtGzfl32LNLgnWimgZJSqAZmnTY44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708668552; c=relaxed/simple;
	bh=w73Y1KiCtwSSNnb8s6C3iNRtkRCRJkrRrjR54fcNazI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOqKzsKc0F9pFOatI9QixDvWlT2ZiUzcDE59hS73R+bCicRDTdsvt9IF7gwQ1+F3vcYyN5Cx8M3V7e8rm4MLlDucK4QqoGt8s+v7oCl8CsZe7Rw/RSNYGaSZ5Hp88mR4WU+Z39KPY9YDpqe13l1voyXdX/IppRA63eZEYdCXGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uL3o/K5J; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4127700a384so3540975e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708668536; x=1709273336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvvawxzkQ/f1bt19Uoqp8vmIWZqjXje7U8hF46YHGuw=;
        b=uL3o/K5JLpNZw8GMlEOKpA0JWyODh38Xcn0AoGB6782/io6PqplEwqfFHHcKdFBpc8
         aZ7Pn4KoPv3g4ZVX5JvSHAH61grVA5uvjCzCSfBJGA84Qw29oEpAT1HdT2iObynp+s3D
         //Rwz/Yh2EQA5/qJdNCxom8Zwq6FPHBaO3V0hDC38q2YM52lTN+GzM9mSP/rRgZNX0yW
         CWXSoupVuZhjKbHmnJMdwCGJugOco2KwLFnD+pVTZUewEiPHtPT7zWySqWcxzqT4WC7p
         M39Y8vhUfXutv9xvGd4DnisZzAScO65ebuERnzCjiVSKDfFYuurbi+a2NbD9YJmbyPHU
         cGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708668536; x=1709273336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvvawxzkQ/f1bt19Uoqp8vmIWZqjXje7U8hF46YHGuw=;
        b=Wu0SOycyoRsgy9nugT9wNJzAHaQ5yJFaiGQpwkFHGTzWStRk426H1f426O5MbwGaUS
         Oc0UfFfHTTKhi8aOBX8fSINpQb9O4kSDMdxxpDtDofkErOruImJN87DPf/KUTQQWh5aB
         dBfWdFzVoJ2/rEtb14jbF+z4iZUuITUTrcQ7V1NSdXwafSgykBoCyYlVTqZjx/kkRGGA
         N4h4BUN11exlLAgfdZXC7W03IXqGeNcw/Gg9sUWUQnqiQ1UFMoWS29QxY4/VqI2Wj/G/
         NlXWC3w4wpkhwjJsHcKMeEWImBb3hZ/7U17J8GEACPwOw5IWFmuOLIaDdtwpgvzMPX6o
         7NSw==
X-Forwarded-Encrypted: i=1; AJvYcCWjzSBXHNZpFpnFOByOWU4C2lLs6yngJDGgAGxcJ4+0hT6fa+yqs5C9dSUZB1CXtOddV0Buhe9J+0TkSIi4sBGFWaq/t/JCctWBSScT
X-Gm-Message-State: AOJu0Yyj9Z4k+VVi6BHWAN05ZBGVLXTDtxnZngmUR392I+4/a8YzQ8fF
	TDIw0MDqZUZL80hQJm0V0PWJNdxg624LMuw71Vwu5GQKztZnjOOYwPB+qLWhWV4=
X-Google-Smtp-Source: AGHT+IFIeHpvgdehCMrYu8OHPGNSDClunXiXc00W2jMt4Z0Ch5RLvUjC/9bVOT0FwD4vAERkHWlhQg==
X-Received: by 2002:a05:600c:a4f:b0:411:c789:5730 with SMTP id c15-20020a05600c0a4f00b00411c7895730mr471326wmq.35.1708668536282;
        Thu, 22 Feb 2024 22:08:56 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bs22-20020a056000071600b0033b75b39aebsm1482967wrb.11.2024.02.22.22.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 22:08:55 -0800 (PST)
Date: Fri, 23 Feb 2024 09:08:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
	jgg@ziepe.ca, kevin.tian@intel.com, dwmw2@infradead.org,
	will@kernel.org, lukas@wunner.de, yi.l.liu@intel.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 3/3] iommu/vt-d: improve ITE fault handling if target
 device isn't valid
Message-ID: <039a19e5-d1ff-47ae-aa35-3347c08acc13@moroto.mountain>
References: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
 <20240222090251.2849702-4-haifeng.zhao@linux.intel.com>
 <c655cd15-c883-483b-b698-b1b7ae360388@moroto.mountain>
 <2d1788da-521c-4531-a159-81d2fb801d6c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d1788da-521c-4531-a159-81d2fb801d6c@linux.intel.com>

On Fri, Feb 23, 2024 at 10:29:28AM +0800, Ethan Zhao wrote:
> > > @@ -1326,6 +1336,21 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
> > >   			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
> > >   		} while (head != tail);
> > > +		/*
> > > +		 * If got ITE, we need to check if the sid of ITE is one of the
> > > +		 * current valid ATS invalidation target devices, if no, or the
> > > +		 * target device isn't presnet, don't try this request anymore.
> > > +		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
> > > +		 */
> > This comment is kind of confusing.
> 
> Really confusing ? this is typo there, resnet-> "present"
> 

Reading this comment again, the part about zero ite_sid values is
actually useful, but what does "old" mean in "old VT-d device".  How old
is it?  One year old?

> > 
> > /*
> >   * If we have an ITE, then we need to check whether the sid of the ITE
> >   * is in the rbtree (meaning it is probed and not released), and that
> >   * the PCI device is present.
> >   */
> > 
> > My comment is slightly shorter but I think it has the necessary
> > information.
> > 
> > > +		if (ite_sid) {
> > > +			dev = device_rbtree_find(iommu, ite_sid);
> > > +			if (!dev || !dev_is_pci(dev))
> > > +				return -ETIMEDOUT;
> > -ETIMEDOUT is weird.  The callers don't care which error code we return.
> > Change this to -ENODEV or something
> 
> -ETIMEDOUT means prior ATS invalidation request hit timeout fault, and the
> caller really cares about the returned value.
> 

I don't really care about the return value and if you say it should be
-ETIMEDOUT, then you're the expert.  However, I don't see anything in
linux-next which cares about the return values except -EAGAIN.
This function is only called from qi_submit_sync() which checks for
-EAGAIN.  Then I did a git grep.

$ git grep qi_submit_sync
drivers/iommu/intel/dmar.c:int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
drivers/iommu/intel/iommu.h:int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
drivers/iommu/intel/iommu.h: * Options used in qi_submit_sync:
drivers/iommu/intel/irq_remapping.c:    return qi_submit_sync(iommu, &desc, 1, 0);
drivers/iommu/intel/pasid.c:    qi_submit_sync(iommu, &desc, 1, 0);
drivers/iommu/intel/svm.c:      qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
drivers/iommu/intel/svm.c:      qi_submit_sync(iommu, &desc, 1, 0);
drivers/iommu/intel/svm.c:              qi_submit_sync(iommu, &desc, 1, 0);

Only qi_flush_iec() in irq_remapping.c cares about the return.  Then I
traced those callers back and nothing cares about -ETIMEOUT.

Are you refering to patches that haven't ben merged yet?

> > 
> > > +			pdev = to_pci_dev(dev);
> > > +			if (!pci_device_is_present(pdev) &&
> > > +				ite_sid == pci_dev_id(pci_physfn(pdev)))
> > The && confused me, but then I realized that probably "ite_sid ==
> > pci_dev_id(pci_physfn(pdev))" is always true.  Can we delete that part?
> 
> Here is the fault handling, just double confirm nothing else goes wrong --
> beyond the assumption.
> 

Basically for that to ever be != it would need some kind of memory
corruption?  I feel like in that situation, the more conservative thing
is to give up.  If the PCI device is not present then just give up.

regards,
dan carpenter


