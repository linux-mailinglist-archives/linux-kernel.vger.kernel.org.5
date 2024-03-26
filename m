Return-Path: <linux-kernel+bounces-119256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A72188C638
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB30B219F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C950513C696;
	Tue, 26 Mar 2024 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iV4vuXV8"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1D12D76F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465425; cv=none; b=lzCw2pJ4MnSOUMFVEjtyKkhxJhIryCRFptXx6GcLBodnQChLWegncwmEsAyt9avlhekZWlXL4ydcWs5O4RKoyOJMNN0FDeGf8Hcqa19H+0BR2O9SEzUVM0FN+x9t0Gug3/qqe4/bOl1Z8pLlbS0sZi0gegqLsRZ4YoQ42LkElLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465425; c=relaxed/simple;
	bh=ExcLTQp7iKT4c7ldvFWHhVLbBQ0J2Wt1RPxz2DBljGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sh4msfYqlmJ8d7Tn22ilu9eS9VvoG+iPlE0E43LkDYzKJBsyCWnVm0A3RX2iZPlOfmYSXTgfFnrwIjWFS6TDvATDGWZzjSOn7/WUReRIy+4D/cw8If1moY1rDhZTNX3ozV6OM0vCz7iMfOXH88yA9AiQZDZObrLqLNnuxMenSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iV4vuXV8; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-430b74c17aaso41386991cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711465422; x=1712070222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZmVXdcDWPhXaTMyPMBaD6/fwX/FAGo/S1sSULtN0q0=;
        b=iV4vuXV8tZPh4tpXd52HieOFgI6QWG5eKzf33pYbok1kKD7Nba9VDVDmNrDnrjah6b
         oJNnSPKav/lX8AxfGnA3/DY+R1S6yqVoiLMrzyxq9ALDZl5/lNcrYXiI1i0+v2Z/rRLx
         3F4U7kAx8iEDUDq2ljIiFCD0lEv1SKwCvBppH1KFoj9cFhadpFRCFlMqilidg07xiaJJ
         aQC/hQAMAjRsKU2+yw0DDDVK6Qz9dTrpZ1KS6wZ+9kNgqg5hz988yQf7JQ+94BXZGk6U
         2befCvM95NKqw8sdfHWCEa/nv3Ht1+xOeN41C5jqGgrAIYj6bhO09PxbJab6Nud6219A
         HKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711465422; x=1712070222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZmVXdcDWPhXaTMyPMBaD6/fwX/FAGo/S1sSULtN0q0=;
        b=vgxPaRKDxVusnglIlM+eLcANfcxD6whZf+LSGBKNXrqcjC6dlMdKUe+/LNTRBuCpsS
         b6aKTuTV45r3oA/YYM2Vc21XihgHXiL3FbkRbAxfevz6KoZlTDg8CZcC0XQk2ojKZZq5
         xRtFfnzbHRC8db48LE9bQAfjTqp4I2JGXrOFjd4Np3cUr0LyscpqxSbpsXDnUgyTBhV3
         iDKB7hrs5rdAndeFA8tUfacxWlK851ty2IY3MHSWPvsL0jHKoDhky3jClxGmQCFzMcDt
         pjYCooId8go8ne64kJFRTIcD7ciaUstXGauYNAXV1r4v2wkxfhAtVopK1SZPyQdxXKLV
         Ye2A==
X-Forwarded-Encrypted: i=1; AJvYcCWXpFo0MM+5hXXDHfRkQqXSj3DKPmx3cc0KgoxD+EnysbWDGRC9UBx6vNql+8HUdRRPVkxRLhOUDOHjcJuQUi0FIlV+tOe0w97PfgDS
X-Gm-Message-State: AOJu0Yyapb9i2KUUNffBsRBhhhIw1JAlDTN4JrE63E1lNu8fAmFEIZ34
	3xvxgM5TWK0Yx5eWyRjrMdjqjJ8DNQVGYUJEyO7rzm1AiQ/xGI1bg4YoDVk9UBEGKyUGn/GyxED
	b
X-Google-Smtp-Source: AGHT+IFbkghKVs0qjyIKFqbeUkN1cAZXdAcHb14STOhbg3JBqfd/rhDdojP76IXrbvnTZ+ibjllo/w==
X-Received: by 2002:a05:622a:1ba1:b0:431:32c1:e8b5 with SMTP id bp33-20020a05622a1ba100b0043132c1e8b5mr11952271qtb.50.1711465421858;
        Tue, 26 Mar 2024 08:03:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id gd14-20020a05622a5c0e00b0042f21fe66f7sm3749489qtb.73.2024.03.26.08.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:03:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rp8Ky-003QqR-SO;
	Tue, 26 Mar 2024 12:03:40 -0300
Date: Tue, 26 Mar 2024 12:03:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
Message-ID: <20240326150340.GE8419@ziepe.ca>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <31fcc276-acd6-4277-bd6c-4a871c7fb28a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31fcc276-acd6-4277-bd6c-4a871c7fb28a@collabora.com>

On Tue, Mar 26, 2024 at 06:09:34PM +0500, Muhammad Usama Anjum wrote:
> Even after applying this config patch and following snippet (which doesn't
> terminate the program if mmap doesn't allocate exactly as the hint), I'm
> finding failed tests.
> 
> @@ -1746,7 +1748,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
>         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
>         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
>                    mmap_flags, -1, 0);
> -       assert(vrc == self->buffer);
> +       assert(vrc == self->buffer);// ???
> 
> On x86:
> # Totals: pass:176 fail:4 xfail:0 xpass:0 skip:0 error:0
> On ARM64:
> # Totals: pass:166 fail:14 xfail:0 xpass:0 skip:0 error:0
> 
> The log files are attached.

You probably don't have enough transparent huge pages available to the process

      echo 1024 > /proc/sys/vm/nr_hugepages

Jason

