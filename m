Return-Path: <linux-kernel+bounces-40254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C41783DD40
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF4B1F25F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA871CF83;
	Fri, 26 Jan 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YilXqasW"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66D1CF99
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282225; cv=none; b=QGlcz8Z9rPz86Gmp1cE/EjSMhYCyFunVHUaT9ePNbMBC9QDP7f7cIX3hAh2JPdaj6YHKwchkoB51007D2oMgT9QAOf1NzSnOs/3A9zvFgCDgK4q+HvJHlvdk2D2pBrCxDCO/p3MYseHlWAZyDckMKBaDDckDi2yp2eNNeVipjXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282225; c=relaxed/simple;
	bh=ycK1Stg6RqUITxTiNF6zYf2SsEC1R2ya33fUNr0wo3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfU+FT8VJbV5Gsoj2aTqWeXDIo528J0f4UyscW8Yjrr0JxTE3KrRdsbLYj0lMYMo4hwqiN38fiFuMTmVSAboWc9bBPl9bt0pQfxE/4YXk2Bfjw/B3q7dWjyxQoHTxDLBkAfurWrNJVoYJmpOy7DlXD+fvU4Go8NY7qrtpitG1Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YilXqasW; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-204f50f305cso294033fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706282223; x=1706887023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ycK1Stg6RqUITxTiNF6zYf2SsEC1R2ya33fUNr0wo3M=;
        b=YilXqasWXMmHhexd6fGEugQL/KAs2mX+uoNiinwGoqcXCAsaBO+YZACinWCwUTtAPv
         gLHGtzgqVRJxljirBQ4YuQXuZxvLgkV9qlpki6OLQ666tgWRo2JWx8TSUL+XmSJVTW0n
         2O+Qd8iyHU8cRtVtkLD9QGT97Lb+iYeTbVysZge7IGu4sjEPX81gapWGIXgn5EM+ae9Q
         r7QU2UhvKM+n+rwQED2t9ACtt6Nu84Xi20MutRca7EZehrNEwQxUjIsEIHKV92FSNfen
         S/J3/5GGZv+8zgU/rDsfW90dUHliBlVOU04c/wenyqZGfSGotFDNSUan0kQKWhlMGNqp
         fGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706282223; x=1706887023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycK1Stg6RqUITxTiNF6zYf2SsEC1R2ya33fUNr0wo3M=;
        b=QhJP64bCGLYcIqQzA24GLEaQQ4Nh32w850//CluQcbw3brrzncusPxzOX08TfX6zZ7
         tYnIV+gLT/II1akLKqL/S5XZmqYak7553Iu1yrHLDTslCp/X4m8xzWfc9BltuDO6Fq34
         D+P/Fi3PCBHTdX60GmCN+SnmOUcQwCy+n4u9x/Yvx/+UYCCsGZ2j6HNYcLZd6zGcP/jq
         whR/yt9byoZOMvzrEYBObYPwDdqLhZ5JPoyJkQiyyc4NezjVid2Dofua+ay0H9PsOhAm
         k90NiDlApflBbl9jTkYtnEINZq5HkgYD5XmZsVeierVDa7c5wrH9rhM0qW9sUbzmNHi8
         zD/w==
X-Gm-Message-State: AOJu0YzIL5jQ+dDxM6qdPmlNCSP7lh9ADZ7QRV1wTA3Oj4lApzUvAq2y
	YS2/hA3Nzbl2qUyHpis1jdyAf+51G5iojiFzC7Fw65ijWEGiT3/iVKZgEPab9YQ=
X-Google-Smtp-Source: AGHT+IFrt9nryZjWKK5XB8rdZZQ0ZLiVll/0WhFtuhH2eLFjwwzfbOmZXs5b/TpVTrjEAEXhJyZ8jA==
X-Received: by 2002:a05:6870:b1c4:b0:210:e14a:7a9c with SMTP id x4-20020a056870b1c400b00210e14a7a9cmr1359195oak.58.1706282222837;
        Fri, 26 Jan 2024 07:17:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ns26-20020a056870ac9a00b00210cc6cc9eesm385454oab.33.2024.01.26.07.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:17:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rTNwz-009S0o-4e;
	Fri, 26 Jan 2024 11:17:01 -0400
Date: Fri, 26 Jan 2024 11:17:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com, jroedel@suse.de,
	tpearson@raptorengineering.com, aik@amd.com, bgray@linux.ibm.com,
	gregkh@linuxfoundation.org, gbatra@linux.vnet.ibm.com,
	vaibhav@linux.ibm.com
Subject: Re: [PATCH 1/2] powerpc: iommu: Bring back table group
 release_ownership() call
Message-ID: <20240126151701.GZ50608@ziepe.ca>
References: <170618450592.3805.8216395093813382208.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <170618451433.3805.9015493852395837391.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <20240125155017.GW50608@ziepe.ca>
 <b825dd04-3d32-4fbd-91e3-523ddf96fc7a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b825dd04-3d32-4fbd-91e3-523ddf96fc7a@linux.ibm.com>

On Fri, Jan 26, 2024 at 08:43:12PM +0530, Shivaprasad G Bhat wrote:
> > Also, is there any chance someone can work on actually fixing this to
> > be a proper iommu driver? I think that will become important for power
> > to use the common dma_iommu code in the next year...
> We are looking into it.

Okay, let me know, I can possibly help make parts of this happen

power is the last still-current architecture to be outside the modern
IOMMU and DMA API design and I'm going to start proposing things that
will not be efficient on power because of this.

I think a basic iommu driver using the dma API would not be so hard.

I don't know what to do about the SPAPR VFIO mess though. :(

Jason

