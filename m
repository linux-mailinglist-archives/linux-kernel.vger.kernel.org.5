Return-Path: <linux-kernel+bounces-165553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365118B8DE7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D7E1C211F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18B512FF80;
	Wed,  1 May 2024 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="evndqV20"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B3F14012
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580265; cv=none; b=kX7bGmTiZNLMWbqqyewI3moTDazKy42puGcUU77wV/25EnpAoEkWvGbav4hCEmnaYPmd3rwRwVYgdq1ltB0a9jv8mVfaEKqpXI38Ab9RMAUV1KLFG+qeQ/lpUwqvWaCytwBDdwU1ro9+jP3YplHjpYGP+dt00qvOlR4mAfhwNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580265; c=relaxed/simple;
	bh=WMbb2YIutbT9nENgsU83J3jQa7ch6qSbwQgGs2qjpog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FakYGKtZBQTaQnEdXH0bkCW6u9LH5GW9/gyEsCFeS5yr/W0dMJ4iHFeVEcNsMq6sEqAFSJrSWaDcLCJqySfe8ebmihuJIonMR9kkKoxDxtLg8J10iekLEzl8DPv2Et1khI1fWqSWAyDDjg0MLZ1/Z2encbPXkR3Zq/OfkC/OlH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=evndqV20; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c61486d3fcso4155052b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714580263; x=1715185063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BPYbga/8HekZBhU29ejBHMNmmO8g5JnLQNHtUS17ag=;
        b=evndqV20YCSm14z2yykD8jpADj7wqGS0itHkTlcDnjNd69RK3pdYmeGTcI0IhWfy7T
         6NZsVSojRvKRfinzuqVc61S1AmnLnbSGpAHnhixQRKwugXyJTEtVM7S7162sFLbG254k
         CGC2oULdYFvW4E4Xkgr+KkKDW6a1v4vcIQzIysH7TOURvhTHFPH7Vd4qvZ69QFUxnuj9
         +FF1sjPxQRuIdJ6+C4+cl9dZIxuw11/drVbugjl8mYfjrzS3BKtA2TS4bSlFkKfMPRtI
         WV/o1ohCjOiPUyBFb+HYLJJzyK8FIvv8byo3CJAETKJIs5NdYcafupcIzAhaXJKoW5Qn
         /oVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580263; x=1715185063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BPYbga/8HekZBhU29ejBHMNmmO8g5JnLQNHtUS17ag=;
        b=oSpHGTjpntuMqGvjK284zMz8Ycx4GA04tb6RE4P8mvGj8py76jUcm1rEbsOYsCPpye
         QKICSGVPjMP0C/tl3Nba8da0482V9FSVbM1TCZydR6dGph6K3iRo9pWI4W3LgckqZM9s
         um8k92Kh9o5tWbNsATixIJyw3ze10xP8vsoD3vZP7djr8+69461Yz/FX56cWJNhwD970
         HPD/q3AwRXNrIBAdSMHf6hwl3VjQDnI0ta6MFf1kPMT914SNvxA4pX4b4pb9XnsmT0Sv
         xySWbiQdLAR2oAdKSkB6onz93ehe3lgByn/vFTaqZEt+vF03732sgTMTM8/bPCdb80+C
         TSkA==
X-Gm-Message-State: AOJu0YyTAc1ZJBB0FgwNdgGN8Sh5HmXx1ttRZ6A5poBrmgN1w5KA2OuS
	z6zlLCA3JCsLNA5HjDh1+POfyEJ2LlBvfIMGrGNjTzFskBb3wOLpGtLYrkTnFz8=
X-Google-Smtp-Source: AGHT+IGy0Y1JrKO8EVr1ZE17EubAJ7KMInc1BkkfIk+jJ2jmtCVQLOnE/yA6PvkgfDmkhDU/+DY2vA==
X-Received: by 2002:a05:6808:21a0:b0:3c9:506e:3301 with SMTP id be32-20020a05680821a000b003c9506e3301mr1741651oib.57.1714580262701;
        Wed, 01 May 2024 09:17:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id s8-20020ad44388000000b006a0e9eda182sm1164809qvr.124.2024.05.01.09.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:17:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s2CeL-00Dxcn-DD;
	Wed, 01 May 2024 13:17:41 -0300
Date: Wed, 1 May 2024 13:17:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	thomas.lendacky@amd.com, vasant.hegde@amd.com, michael.roth@amd.com,
	jon.grimm@amd.com, rientjes@google.com
Subject: Re: [PATCH 1/9] iommu/amd: Introduce helper functions for managing
 IOMMU memory
Message-ID: <20240501161741.GG1723318@ziepe.ca>
References: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
 <20240430152430.4245-2-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430152430.4245-2-suravee.suthikulpanit@amd.com>

On Tue, Apr 30, 2024 at 03:24:22PM +0000, Suravee Suthikulpanit wrote:
> Depending on the modes of operation, certain AMD IOMMU data structures are
> allocated with constraints. For example:
> 
>  * Some buffers must be 4K-aligned when running in SNP-enabled host
> 
>  * To support AMD IOMMU emulation in an SEV guest, some data structures
>    cannot be encrypted so that the VMM can access the memory successfully.

Uh, this seems like a really bad idea. The VM's integrity strongly
depends on the correct function of the HW. If the IOMMU datastructures
are not protected then the whole thing is not secure.

For instance allowing hostile VMs to manipulate the DTE, or interfere
with the command queue, destroys any possibility to have secure DMA.

Is this some precursor to implementing a secure iommu where the data
structures will remain encrypted? What is even the point of putting a
non-secure viommu into a SEV guest anyhow?

Jason

