Return-Path: <linux-kernel+bounces-94216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72975873B89
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CE11F2766B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1906713E7D7;
	Wed,  6 Mar 2024 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SlbmvEt9"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C007013791C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740884; cv=none; b=TorO4No1isRiHpFYemdUgOBDs38tLMQXGa6jk6CjZbjifrr2l09DguVjp/UqLn5bQMGYXrmw4uyjEL5K7yxRx/IZTi+CetTbL7AB6PJaeq+df8eLztXL+TJ5JtRdzYOekJxAHKw/Apf2vitRvYSZynlaTjrCaztwDqzxNXCFGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740884; c=relaxed/simple;
	bh=v/bXOSBKu2eGpHEzaYDbJicIc8rMxQdp3cklgPly4s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+ABwseh28iOKHTbRr/C4z/WrY2eGlqSQEHaM1EC/CJ0JxONbKB9kQAcXHVuno0YHwznWfSiVRBUO6EGczyojKFuZyUoXfcmfMB2rBy2idr5C8TGKBNjhc/E4Tj3vpVyR2Ep77MtZZg9Fuu9N+AVEW4qL76ndxUGsewUYr226t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SlbmvEt9; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78830bba6a4so57602885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 08:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709740882; x=1710345682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iSA2YBah1Lj30DTvNjciwv55fQTPNlhcFkEFTOf2JJk=;
        b=SlbmvEt97tWasfFCKAxhSzZmhmYTHQKqI0reH/+fHo+Ga/qUx/HdGtgXt7iBvFuMey
         w8iK/s25p0v/y5cUM6OmjCa1B2vdOGjG4FsL3arhcWltUxs3OJG+BDZDTKOFN4rYPuXX
         122dMxOOVPsmYV9jMqRoWHJbh60kqbQUl3SYtOAdfWXtg8gkc7D0K96GoNaSmcNKXz2A
         NkpeRCS/zkEgcow5XtiIqCwpXknGI/yvo9WLOn3lrtq4zm1ZR0/v4GRqOGWUvBit6s0V
         gv48TGy5+ZVsHMmi5jmeJVUMkqJ1E2GGPll8ucTU/A5YGHjEQI255Ed0tqOoh1+6FQg5
         YXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740882; x=1710345682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSA2YBah1Lj30DTvNjciwv55fQTPNlhcFkEFTOf2JJk=;
        b=bwaUHSzNxBfnn97I2FDokyOsIoQWV23lHPxZsB1Bz2CeN70Zf4fw2GlBi9YUUe84JJ
         kbuS4eLj07HR4zgQxltgZjAeRedxFclSLTIGPLoae4zHurSDwqBVUH+JW53Iquy6q8nB
         f6fs4qiMCtG4a71i71wJQIsZPsVbQ/bI2vVyvJwqhAgMIV4SIf7Bq/UTlE21gBMPqRxy
         nTePD6PtKYrmRYH/2xTLIMLu9A1JQzFdu9GsRsA/NI3qNcuCY+U3vBJSGoa/w+OnSf+x
         BIGeI/tplDBAsuL3qVndbwBBRV0hOG6ubBreUJ6+mmudv3Vw7tJApiBQ3ukhnfK01neT
         TCQw==
X-Forwarded-Encrypted: i=1; AJvYcCUYZZx5WwTSBgJCumbjK4XU09VyHz481YeWgxm2Lf4BTVbhbfi4HFPfvevFsV+Hv8Ktvtv9bdsU1XuUdXDLu+SJcSsqsk6I963+6Tfy
X-Gm-Message-State: AOJu0Ywo570zZgch7/jGMn+Zmei7bTtE5yATmNYmFCIM31j6YVql5qKL
	Lud9WV5GEXLQ5KOQB/0Et4R2fRgs7ZbZ9VjDGdz2ipDlOxAVAfd8On8oKFn2/88=
X-Google-Smtp-Source: AGHT+IHonZr06DjH8Yk84J1MO3pfMp1YqC5mCzQ7TjuwpRdCgfCoxMkD1Wnxg7YpHS7pifKwQl02jQ==
X-Received: by 2002:a05:620a:1a9f:b0:788:3766:b145 with SMTP id bl31-20020a05620a1a9f00b007883766b145mr6022406qkb.38.1709740881754;
        Wed, 06 Mar 2024 08:01:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a29c800b007881ff8cebasm4246571qkp.92.2024.03.06.08.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 08:01:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhtho-001egy-PW;
	Wed, 06 Mar 2024 12:01:20 -0400
Date: Wed, 6 Mar 2024 12:01:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240306160120.GN9225@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
 <CABQgh9FwOVsFe3+5VG0_rDruJVW0ueHTcsnxUcVAvFqrF4Vz6Q@mail.gmail.com>
 <CABQgh9G5yFZ_p+tfvnJqOQo+Be62rMDatsEX1rhD_oTiXDaw5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9G5yFZ_p+tfvnJqOQo+Be62rMDatsEX1rhD_oTiXDaw5w@mail.gmail.com>

On Wed, Mar 06, 2024 at 11:15:50PM +0800, Zhangfei Gao wrote:
> 
> Double checked, this does not send flags, 0 is OK,
> Only domain_alloc_user in iommufd_hwpt_paging_alloc requires flags.
> 
> In my debug, I need this patch, otherwise NULL pointer errors happen
> since SVA is not set.

This is some driver bug, we need to get rid of these
iommu_dev_enable_feature() requirements.

Attaching domains with properties should be entirely sufficient.

Jason

