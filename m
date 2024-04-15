Return-Path: <linux-kernel+bounces-145554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D379D8A57C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101711C21CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4AB7F7D3;
	Mon, 15 Apr 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="m1LdM9tz"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34A436B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198720; cv=none; b=B9bfR7n6LjBsVxa3PXoNbuVQW+QZnvZ9h78KU00b1VTSm4PVGTWSZo+ZuaIen1z43LiDB9i+M55Kb/D4hQcM52qkqSbkzxyAys5Zo8FFnMLattZDV15/H8ncFOGrOAzuenPtuKFQXivKlR1i2y7/9xTNxQrSdLJ+aitzw4MJKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198720; c=relaxed/simple;
	bh=zDDgIpy5N7xLBr7DtqrgxVpWSUxp5zbXxCvvF/CXoxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQVsVdnymTFp6MR1BnoUm0QIz8udwBD/OVKpw77bBHx2PAlgfJGhtlwq0quTVYgsiJhxGw94OgeOUKrIcLa/DyB7mZOcwGMZ7NDaaAVStevMQlaPorT16oMK09trKW43HZ4Jf/0CYb6WuvwkZiTBlY5Zbqm30Zus4bo9j619z4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=m1LdM9tz; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-69b514d3cf4so29638446d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713198718; x=1713803518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T6uDrxd1LuGun2rXxCqlhNV+bZCg6ihMUktEllK1boI=;
        b=m1LdM9tzy49aMbC3eeurnk4ARKGinTBtttTHCly/I8E/7eBkIlH4iERJC1vmLdJBnS
         ktMPusuyEi6LNROFIZptVf1eSJ6GWtuyxStC7ITi4L+MYMe9r5o38Vg37hx2QE+i+ARc
         +lLmTCF13ZZzFwO2TRveTAqokl8s+bt4rCghdtgU8degDFPJ6OHp7vKpJWxk8fVuYq0T
         1Y1PAItVznFg+sJ+09Ztf36ZJhRn+pFffnnGu27yPdrREuOxM+Z2jamZBEhI3TtVjc+L
         95S4svJYWWt71mEf4xQlJmHH+NzIRMhBJj5tEp1EqTEyNDjdxH4jvKtUhkCOlu7tW9Jg
         IBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198718; x=1713803518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6uDrxd1LuGun2rXxCqlhNV+bZCg6ihMUktEllK1boI=;
        b=KudN2b6soF1OmKL4m7uR7dhJhl1TLbdwHpGWDz6qx28GfSxl+0eLYjCrnNV1qQqNoh
         uo157hoe22C3HWvynlzDBacQvOYZRNuJg4/8tFJckyMqu4cHhv7eY+xDHOWnYD0RuGnI
         p5Mle9aj+1mijSO/TvECHJivRlgBAh+wFZbDXbXHawGutJiUKl2rTII/s5R5cggizrGW
         XyWgJRn9xyCbxkTYJ7TGpehklDTZkynlENDvIYuOzRI8m0IoC78iPBiGy4oAGnY72ovZ
         UIpsbKG2ewuET+/DcYmmStfv8gqFy5BufRBcj38wE0e2HKaQKtB9Z0px5Ab7c9JNts5/
         wVkw==
X-Forwarded-Encrypted: i=1; AJvYcCXUSpx+WRzvbOFpt1L0KyrHPOtL7uekLEdh2E6UyUUFrn7KKoJtBCHuyCCoh5NlIB4w63D2UyyS932u1WL/NzKBumdbk1TuPg5truzP
X-Gm-Message-State: AOJu0YyEaX0PSORmZ3Wafh6oS8ydJR18m9NLDr2IJg8EpBVIXiChSy0j
	BmGrZdKDqmRpvysA0xllWLJOiSGiKY3dHturCOXRlxYDvF33+haPcbLBwjQwTcI=
X-Google-Smtp-Source: AGHT+IHVq5hY+GNFQ2IMoJ/qm3S7ScfSdhVXy5WVNEqLMFjzgGG9jH1WHbxQxmN2mvwrSp80JLklmg==
X-Received: by 2002:a05:6214:d09:b0:69b:5475:b9df with SMTP id 9-20020a0562140d0900b0069b5475b9dfmr13767033qvh.47.1713198717859;
        Mon, 15 Apr 2024 09:31:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id v10-20020a0ce1ca000000b00699427d1611sm6392605qvl.40.2024.04.15.09.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:31:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rwPFM-006ENU-Tv;
	Mon, 15 Apr 2024 13:31:56 -0300
Date: Mon, 15 Apr 2024 13:31:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/intel: Use try_cmpxchg64{,_local}() in iommu.c
Message-ID: <20240415163156.GQ223006@ziepe.ca>
References: <20240414162454.49584-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414162454.49584-1-ubizjak@gmail.com>

On Sun, Apr 14, 2024 at 06:23:11PM +0200, Uros Bizjak wrote:
> Replace this pattern in iommu.c:
> 
>     cmpxchg64{,_local}(*ptr, 0, new) != 0
> 
> ... with the simpler and faster:
> 
>     !try_cmpxchg64{,_local}(*ptr, &tmp, new)
> 
> The x86 CMPXCHG instruction returns success in the ZF flag, so this change
> saves a compare after the CMPXCHG.
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/intel/iommu.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

