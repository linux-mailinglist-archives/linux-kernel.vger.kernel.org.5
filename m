Return-Path: <linux-kernel+bounces-167668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8C08BAD19
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A490BB232EE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C711215380B;
	Fri,  3 May 2024 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GG9rlfyG"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CCC152E17
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741463; cv=none; b=bTYS8bLqS24Sk+fKC6s1ONLMtxYB7FFU4cyjuU+jqAofM+TicgQFel1hafePZJSgti7iiztAXJU1DFycq51sqRsXS4NV1dbbienXTxx0icAxYB2o7an40mPXMIphw4e3+3DmImB84VTOSODZA9JosOcwapTlU7xgzO5ZdsDTLoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741463; c=relaxed/simple;
	bh=pffomHGtC34y1FLgL5SDQy8VpYgWMygSGhAt21/DLgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0c1Wc0qKqS/F7l9b4+KJJLuCHeLphzC1f/mlU2RpbB94bda1AVptne/LfihZF8pUnju/7SUQdzZx9K6Zk2+Tzl0qoMAlxaFBJOhIgrjewWw4M+G9sO8tdb3aEBLIxtRXpQH4Iso0nOdoaDdSNRBtZTyqC3L1OdAkf3pPi+q4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GG9rlfyG; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5aa1bf6cb40so5959032eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714741459; x=1715346259; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T24fsb6UmCj1BuBe7A8xi01GqDYWjj7XjEjPE3iHXwo=;
        b=GG9rlfyGnKj8ylVzSj2OObBUNA6DDnSqdsQ6krq0LoEsHwjdQIln+4AOW9e61WCWDX
         Z23LJZfyYvr58JW0pSGW4J45ukdf4AiB+jATlqVny2+fkObZJKrgifCx9AJTfgsLRklD
         vMgGj7bvbynRCcLJI4MUHWUgiF7hqeNMxFPJ2QhrM3XMfTuJMlgwPudp0Un1xhJf4nM5
         ItQyoTcfN6pZd2m3sWpi4BL6gzwzGJHmeU+bb1mkDXECI+oN/6+szO9FiO20tbGZP4nc
         4ilIGx7orEj+RP1sA4j1Eg9+0ZUA9K8Bg3RiwbT6X6csmAAbqxpsyGGOfaQczsc1tJIu
         e12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714741459; x=1715346259;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T24fsb6UmCj1BuBe7A8xi01GqDYWjj7XjEjPE3iHXwo=;
        b=TTsLFjk7wW9/Uv5noAD1BxkKdxsmVHK4TsL036QF3Um5sKjEFuFWoqAPx8cnrMyY6m
         pZb92pbNjeHDH3uwvKN3Nty0e9Tn1MT4zJovuAHmJF87HwpOmFfvqN92vfidyzAiyAoR
         5QtwKJEdkq0bUSlH32knnm/yOFOGeptvRPhJY5khNZJxgi+Dsk3mwBATTdMziEMu6PQT
         cjwlCfvktIHNotRSDuTFDIdRFSsdTZaogS/sQo22aYDVLDKDlJBNl4w+42WhM1NePE5R
         Cfh9VcFC+eU/NpmiEbBfQubV5iU54AWcwL0RWqtsvSDISFz/maADNgmNqrNGdeOVySZL
         bEwg==
X-Forwarded-Encrypted: i=1; AJvYcCVJe5UVUyvF+LLVCxuE0sJ9Nm2JSh1BtRmdqA0GJZPb4kQHbDYDCSreR2VN7x8s3IoZYTcoh1EZ27bbueOJ5MYY8znwQdU/7bZKxA1w
X-Gm-Message-State: AOJu0YwgESFpYEAT3eMuphPsjKbWM0m5h98WWTAwom/gdw9DqOjGALQc
	fJTaXajQjri5fp5cazkW49liHj7l+Y2wxmX9JsC9zWQ/CFiwSwMYIYXrpS4zPus=
X-Google-Smtp-Source: AGHT+IFkDVZmGphlJUVtShrOiyFDXAxL2dqwcQGk35D/hs5G0hXFSbZERBs+fJjVjtBARWifNREq9A==
X-Received: by 2002:a4a:4bc6:0:b0:5a9:cef4:fcea with SMTP id q189-20020a4a4bc6000000b005a9cef4fceamr2843172ooa.1.1714741459559;
        Fri, 03 May 2024 06:04:19 -0700 (PDT)
Received: from ziepe.ca ([216.228.117.190])
        by smtp.gmail.com with ESMTPSA id gr5-20020a0568204cc500b005a4bb400a0fsm620032oob.4.2024.05.03.06.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:04:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s2saG-006Wjv-Qi;
	Fri, 03 May 2024 10:04:16 -0300
Date: Fri, 3 May 2024 10:04:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	dri-devel@lists.freedesktop.org, Leon Romanovsky <leon@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Lukas Wunner <lukas@wunner.de>,
	Dean Luick <dean.luick@cornelisnetworks.com>
Subject: Re: [PATCH 3/3] RDMA/hfi1: Use RMW accessors for changing LNKCTL2
Message-ID: <20240503130416.GA901876@ziepe.ca>
References: <20240215133155.9198-1-ilpo.jarvinen@linux.intel.com>
 <20240215133155.9198-4-ilpo.jarvinen@linux.intel.com>
 <26be3948-e687-f510-0612-abcac5d919af@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26be3948-e687-f510-0612-abcac5d919af@linux.intel.com>

On Fri, May 03, 2024 at 01:18:35PM +0300, Ilpo Järvinen wrote:
> On Thu, 15 Feb 2024, Ilpo Järvinen wrote:
> 
> > Convert open coded RMW accesses for LNKCTL2 to use
> > pcie_capability_clear_and_set_word() which makes its easier to
> > understand what the code tries to do.
> > 
> > LNKCTL2 is not really owned by any driver because it is a collection of
> > control bits that PCI core might need to touch. RMW accessors already
> > have support for proper locking for a selected set of registers
> > (LNKCTL2 is not yet among them but likely will be in the future) to
> > avoid losing concurrent updates.
> > 
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Reviewed-by: Dean Luick <dean.luick@cornelisnetworks.com>
> 
> I found out from Linux RDMA and InfiniBand patchwork that this patch had 
> been silently closed as "Not Applicable". Is there some reason for
> that?

It is part of a series that crosses subsystems, series like that
usually go through some other trees.

If you want single patches applied then please send single
patches.. It is hard to understand intent from mixed series.

Jason

