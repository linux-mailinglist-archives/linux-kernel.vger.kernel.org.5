Return-Path: <linux-kernel+bounces-40296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3131F83DDE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD9F1F24C52
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2891D557;
	Fri, 26 Jan 2024 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XPmKa4ht"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21DD1DA38
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283871; cv=none; b=MRDJkTolCxblYIqcdVUckfrAaIgivioy2ubFSL0BOVg80mKzsGfsz5ccc5qupczofbuGJ1t+YC5J+WDTDGn1mlTIHLHlKz+/DcHm3snQN3mXAS8doU7qF0Laxqa3jKiQ9MOEhB0LxRR3oP6lIBJ1hUiydZ6Ts/AVLU+G67CR0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283871; c=relaxed/simple;
	bh=UiLdiIVvMb83SWw7AGXvISH8OI0rahijuASgroB/Hlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFCRr3jWYBrrZUFc2pqRnXIjotSqRdomAdwtfRUSwCqScOLIhOXBXyf0G30QSS4bFNgvtMgf+Xy492mIldp+yBO7UTMxGeuQy1ruep9abT55EkGpE8Y3/IfrtOvojjYY2YOQwIL5C6xKzykD2fVP8pnNUg1o/FfVcCVVRrbJsk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XPmKa4ht; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-206689895bfso328275fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706283869; x=1706888669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ifj3vKt8QC0k+Lvrl/eE4vaSsPq+S4SksoQKXsBRSXc=;
        b=XPmKa4htdyIFQN5nkahRKFHwjBIj2w5nnjnY1CyS6eVuLv3IrPCwmLUgoyVIAkXD4U
         P1jun110v+iDL6vurH48iPpOv8S1BmzzTMcimFbXtQCsXtQlviUT2tQMSKmyK+4XCXFe
         n39GTlT4ZJyrynW6hqgC/kXgsU2hJlTH0dKRJsHzuRomi6ncG1mOu61Fd9roa6dwduUq
         m8qJkDNwKT8M8M2KvISQ+ovcf4bY7EgZqz//rM9qPeJzVOx+t4W6XM16TiiOZiRRITMz
         O5s22W3MQ/r6vJdV6wFmhQbFKMlzpxLGW/lfwvUrkFpPolQPZt4mVU3XDM44WmTHZEEM
         lI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283869; x=1706888669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifj3vKt8QC0k+Lvrl/eE4vaSsPq+S4SksoQKXsBRSXc=;
        b=O3URtzSupLvobWWCLTHJyFS41thRp2es9UFUNj/a59Aa6RkjG8+RWw1VhDzgOvVq5U
         yRerslJCrVEaLip8xeXU61C8PmEEaaZf+tbhkEwegTmKpt/N+MzZt63lILcXW+BkWcxl
         qNlNWkewLlXrrEJ7nOWlR1plKy9i/UaWjIFG0+GUL/h8D9XQF95JJ71ZeitCB/0YmPc7
         lMu66OaxM+5SBqctHQ3rxEVqC5CG7ci2h9BOG/4uDtbztd18myun9b5ZM78Ub7M5XxCZ
         De3G362jREoYDLwwPwg1iuQSM2cMXXeccRdTkiMSNhf23nLDnquNGIr6+6UUTFPhYxEe
         HM/A==
X-Gm-Message-State: AOJu0Yz6V3i8r3mv4sFghjaV8UO1VYVF970eO0/Ur1xwvF4A8rO/78f2
	nbYCrxZpX8B1kcJdXBt/1MziZ1kmT5SZrBrYtpLDftCfS3AWr87WLNsM7XjbF00=
X-Google-Smtp-Source: AGHT+IHvXs9zt8rzQimULCxVKWRw2gBSkFT+WcT7r0xChxJT011B7UN6s63xs55ItZMqKHL08VvUaA==
X-Received: by 2002:a05:6871:2787:b0:214:2544:bfd9 with SMTP id zd7-20020a056871278700b002142544bfd9mr955769oab.43.1706283869008;
        Fri, 26 Jan 2024 07:44:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id pl10-20020a0568704e0a00b0021837cadf53sm200549oab.39.2024.01.26.07.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:44:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rTONX-009SCu-NX;
	Fri, 26 Jan 2024 11:44:27 -0400
Date: Fri, 26 Jan 2024 11:44:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>, iommu <iommu@lists.linux.dev>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>, npiggin <npiggin@gmail.com>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	aneesh kumar <aneesh.kumar@kernel.org>,
	naveen n rao <naveen.n.rao@linux.ibm.com>,
	jroedel <jroedel@suse.de>, aik <aik@amd.com>,
	bgray <bgray@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	gbatra <gbatra@linux.vnet.ibm.com>, vaibhav <vaibhav@linux.ibm.com>
Subject: Re: [PATCH 1/2] powerpc: iommu: Bring back table group
 release_ownership() call
Message-ID: <20240126154427.GB50608@ziepe.ca>
References: <170618450592.3805.8216395093813382208.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <170618451433.3805.9015493852395837391.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <20240125155017.GW50608@ziepe.ca>
 <b825dd04-3d32-4fbd-91e3-523ddf96fc7a@linux.ibm.com>
 <20240126151701.GZ50608@ziepe.ca>
 <392247278.10124607.1706282995795.JavaMail.zimbra@raptorengineeringinc.com>
 <20240126153806.GA50608@ziepe.ca>
 <1453449220.10126352.1706283596477.JavaMail.zimbra@raptorengineeringinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453449220.10126352.1706283596477.JavaMail.zimbra@raptorengineeringinc.com>

On Fri, Jan 26, 2024 at 09:39:56AM -0600, Timothy Pearson wrote:
> > Just forget about the weird KVM and SPAPR stuff, leave it under the
> > kconfig of the old code and nobody will run it. Almost nobody already
> > runs it, apparently.
> 
> We actually use QEMU/KVM/VFIO extensively at Raptor, so need the
> support and need it to be performant...

I wonder if you alone are the "almost" :)

The KVM entanglement was hairy and scary. I never did figure out what
was really going on there. Maybe you don't need all of it and can be
successful with a more typical iommu working model?

Suggest to tackle it after getting the first parts done.

Jason

