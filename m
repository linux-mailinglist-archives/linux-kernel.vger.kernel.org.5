Return-Path: <linux-kernel+bounces-107954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B00E38803FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A910B23BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204B42D03D;
	Tue, 19 Mar 2024 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zeyph68h"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46FC2745E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870871; cv=none; b=Ef6tkVUtZLJbC39mR2rZpXT74F5X4DLskIJQZwZjrvIApiCGn/EH/SuKdLZQDUfHT+jCPkkB+ZF3jkHHT78lPPkQw/BfZonEb7R8lrA4LVWXEHGkyZZhvrdywHalYkLvk0xjgOw0ZvpEcRZDbteo1ixd552u9CjgnsDgvIQ/9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870871; c=relaxed/simple;
	bh=HF6Vl5KL4xpUREI17F/A98SYy0fCl/Pf+Aw5AKvgvKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4M3m4mO1GX8N/PZ7abaWaGHlsbuQI5O14kMWfLbYNh1XY9OvoMHh//at6uGxQGc0IPOd7ogoL2HOjbJV1Sb+aQt88CLdq56sTYH+B7S+rUDd+l5EWISQ1p1rDnfbqFYtQJ3y7dP4S19D5M3/Df0Lw39jS9TLXdtFqoLet7dNlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Zeyph68h; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22200c78d4fso2467888fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1710870869; x=1711475669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HF6Vl5KL4xpUREI17F/A98SYy0fCl/Pf+Aw5AKvgvKY=;
        b=Zeyph68hDhYvRsvh3QePT9Ovap2WmcKCsLwaPl+ziByVLNxle6pkN7O8XgaezmKqXM
         hbH25obwUJYKwihm8E7APaYbYYYayAPdfhhmawgOjGAJRF43HW/Kdkj2NzIRkuwRe6cr
         0Cv5g7sWLFOJP8daUmYjLr4Ut380WkcDmt2s3Djx0BlxC6jINMrdzY1aBR2jcesvRzG6
         nDN6rvBgQCayLLNChFpCWokjHuRxnL8zgFguqSt0JVT19MPv1hhxN8rTZbXb5eL7wWXS
         WI11fWG0u5gSjoqxTZPl7u21oQU5pOnHYqpKf+xVhyxdaRkzTCm1R/ga37zaa2sNhnJy
         +NdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870869; x=1711475669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HF6Vl5KL4xpUREI17F/A98SYy0fCl/Pf+Aw5AKvgvKY=;
        b=Tc6+iyJB4x06rXox0KVia7EgBZ0ew/S6bUdvCwBTZB9arY+mvM0fklrQkOfyoQIJP3
         VPFEJJEkKFZGonXKrKxG3zGZX9omg3BoUFmk3LQbroQJ8CckHOE39MPaGrhXKTh3LOxj
         qeMbGkKU2OSBNTXdV/JAYqZ4Iqgo6qFwRPibliuKyNYyHhqgMG/iSZajM6miIuFq6zHn
         FcRS2/RPLMtDCv0oLQuSvI4tqdtxxxwgsczV6r/UBN1Kwcp2IPdss+8kUyx7Fhfy9yOC
         WT1ycq+SBeXLW87SjAJpJ1NwB9tk8ausBBGvgCXi/t+/2uszQCQP0wtoCt3eQUO49d7w
         6f1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHxRYQeZ23qL86BC5/aeQUo8b64Znlspx92ArnjWxgGCGiEaqWq/WR1KZnixWyHSN+cVANGsmyxPT7JXZYyfIlucurKVpt1X7W/LX2
X-Gm-Message-State: AOJu0YzF7SHIpnPjrqZb05ptE1QO4dESeha7TNaU4/3Km1av61PfbYSi
	UlAjJy0bIIQhKtlfcQ5Pdg/EnIYhFvSEg3wkXQJuPIafPHquJN7sTSoxRJ+UIY0=
X-Google-Smtp-Source: AGHT+IHVIAnHnQZiZoDX/pbyOjP2H640ehA0I39KqURFs2tz8LL5UStmL8zs/cTqG9a5m1PaAXGInQ==
X-Received: by 2002:a05:6871:110:b0:221:a517:17ec with SMTP id y16-20020a056871011000b00221a51717ecmr16967034oab.57.1710870868900;
        Tue, 19 Mar 2024 10:54:28 -0700 (PDT)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id gh11-20020a056638698b00b00477716fcbb8sm2429986jab.40.2024.03.19.10.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:54:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rmaVW-001eUR-KB;
	Tue, 19 Mar 2024 11:32:02 -0300
Date: Tue, 19 Mar 2024 11:32:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: tpearson@raptorengineering.com, alex.williamson@redhat.com,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com,
	gbatra@linux.vnet.ibm.com, brking@linux.vnet.ibm.com, aik@ozlabs.ru,
	robh@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	aik@amd.com, msuchanek@suse.de, jroedel@suse.de,
	vaibhav@linux.ibm.com, svaidy@linux.ibm.com
Subject: Re: [RFC PATCH 1/3] powerpc/pseries/iommu: Bring back userspace view
 for single level TCE tables
Message-ID: <20240319143202.GA66976@ziepe.ca>
References: <171026724548.8367.8321359354119254395.stgit@linux.ibm.com>
 <171026725393.8367.17497620074051138306.stgit@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171026725393.8367.17497620074051138306.stgit@linux.ibm.com>

On Tue, Mar 12, 2024 at 01:14:20PM -0500, Shivaprasad G Bhat wrote:
> The commit 090bad39b237a ("powerpc/powernv: Add indirect levels to
> it_userspace") which implemented the tce indirect levels
> support for PowerNV ended up removing the single level support
> which existed by default(generic tce_iommu_userspace_view_alloc/free()
> calls). On pSeries the TCEs are single level, and the allocation
> of userspace view is lost with the removal of generic code.

:( :(

If this has been broken since 2018 and nobody cared till now can we
please go in a direction of moving this code to the new iommu APIs
instead of doubling down on more of this old stuff that apparently
almost nobody cares about ??

Jason

