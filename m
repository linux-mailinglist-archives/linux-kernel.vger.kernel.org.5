Return-Path: <linux-kernel+bounces-145508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D148A5722
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A96B225BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902D48005C;
	Mon, 15 Apr 2024 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="i/xSNXwK"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6D47F7F2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197346; cv=none; b=mV7ENgcbSt0rio8VvK8WrH5412MQK5Gn1J5sgTDE3fs+1xrpn62OfcLqjngFw515pH7A7M5mHCu4YrTe91MwZCzpQ4mJasRL2xXSG04r/dgZgLAdJFo6UV0ZMwVX8+2S3TP6xX3J+4ZZLuRt4OnH8jpMoXt9uTco3+hOu41XKcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197346; c=relaxed/simple;
	bh=E/HJYNCwsVkHpTWHtftb4kU3kk8lhl3wMS3rheRjiQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfj5/K/7UXmQcYqZNXvAKEZrWJ+mQd8EqCWURaB458A2yY2u96IvqSDMei9rQ9MPNESSZ3gIsl5nO0V1+g8jIDuoNs8KOv4S3M+7NnYhw636fR07isS11PQkNLc1bktNQDitROWJx/hY1BjBAGYMzs0dyTnMG7TuB9g1/Q5JVeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=i/xSNXwK; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2330f85c2ebso2304132fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713197343; x=1713802143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTXFGU40TZUxrNmMPsS0SfAuCZx2k12qnJO4YGZoAlM=;
        b=i/xSNXwKmgz8eeJqAA0Vy5lgSEoL5Yz3ZkqPn6KmTdTRPZRGrpI4aKHMgYRCDQUwpx
         jKE20ag6ZO6dihmR+IlVZWwJnA/ccf6gEn3g7XlawGcfGtALPBjqeK1pw7xh+i7J9YTE
         /09SdVf5B6pal4QYLEonXrzNe3I8zGsn9aon5IsozwE0/adjfPjAzLu+3s5W4csA7lts
         KUvKNYUhKL5T3lfiQjYWaBoGtLnhkYGgzkxdRjuLH0nLJC0UKF/AlidtnyvIdumqhPqW
         75OAKdDTBXG8J+Fl+CZl4rp3oWgNBc6k97O4Cvzwpdayhk1UxJyNtOYvRZBDMgmZ+FcR
         H7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197343; x=1713802143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTXFGU40TZUxrNmMPsS0SfAuCZx2k12qnJO4YGZoAlM=;
        b=Csn83jYCHN2RnVZBcwAv/Wqx3cHLHfmd3vM4N+a98xQE317YayvJifHawi3dbDHYpM
         65rp0gpLqwbZrncGrV6BDCuevDgE2DTwXkggg6F2pGEnUnCLZRhSAaLnjutmCab3E3AM
         sLmHEaLO0B4wB0LehUKL9sh86Xf5LP6jCvJB0AkqgWxjqC13JWvl9N6vjbjnPGPXSwuT
         UfHeAGJ1Y4kWmK/ONbwl0vg/IY7RfLelfGe1ctPiMnbp0DVyBAFwIaMXqMQWDyoAwOfB
         F8vCEKIKndnpahpG4gmzM49QawHlZyddsyzAFLMx6y+F9XgFI7zWvkkCLJ4eEcrU6rAL
         FNxA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ6CKKCgMUc8KVh/9vX/4Ta0LNTGWhD5N/tQIlgeSGgN4BdCA5IVgFKQMY2SCcfqul292LaMEyD0DP5C/EWhikp+Tv3nnRU04kQiuY
X-Gm-Message-State: AOJu0Yxb2X+HZqXwRbwEwGlhFiYkNUW/nZye4azPMRH1cLryQHQIBBcg
	mZMN4Ie1B5kE4yaxwywJoqDLSpiAtX/MbsuRXpBkCvN4WimsoeQIkDQ4KEtPBNc=
X-Google-Smtp-Source: AGHT+IGsiA6KZ3pe9BtRhO+pbVOY45AuLQMOs+w2wDePMtUYoW4o4u2JX5C7mqkiROcVBcvSR1rGJA==
X-Received: by 2002:a05:6871:7505:b0:22e:15fd:e247 with SMTP id ny5-20020a056871750500b0022e15fde247mr12653184oac.5.1713197343311;
        Mon, 15 Apr 2024 09:09:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ej2-20020ad45a42000000b0069b7bc51271sm1526012qvb.123.2024.04.15.09.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:09:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rwOtB-006BJP-JQ;
	Mon, 15 Apr 2024 13:09:01 -0300
Date: Mon, 15 Apr 2024 13:09:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
	kernel@collabora.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
Message-ID: <20240415160901.GN223006@ziepe.ca>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <45b4d209-675a-4b42-b62c-6644bafa36c0@collabora.com>
 <20240405001020.GB5792@ziepe.ca>
 <b7c437f5-ac70-4611-908d-b665d8e02679@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7c437f5-ac70-4611-908d-b665d8e02679@collabora.com>

On Sun, Apr 14, 2024 at 07:39:58PM +0500, Muhammad Usama Anjum wrote:
> On 4/5/24 5:10 AM, Jason Gunthorpe wrote:
> > On Mon, Mar 25, 2024 at 02:11:41PM +0500, Muhammad Usama Anjum wrote:
> >> On 3/25/24 2:00 PM, Muhammad Usama Anjum wrote:
> >>> Add FAULT_INJECTION_DEBUG_FS and FAILSLAB configurations which are
> >>> needed by iommufd_fail_nth test.
> >>>
> >>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >>> ---
> >>> While building and running these tests on x86, defconfig had these
> >>> configs enabled. But ARM64's defconfig doesn't enable these configs.
> >>> Hence the config options are being added explicitly in this patch.
> >> Please disregard this extra comment. Overall this patch is needed to enable
> >> these config options of x86 and ARM both.
> > 
> > I picked this and the other patch up, thanks
> Not sure why but I'm unable to find this patch in next and in your tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/log/?h=for-next
> 
> Maybe this patch was missed?

ah I made some mistakes, all sorted thanks

Jason

