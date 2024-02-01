Return-Path: <linux-kernel+bounces-48516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ABF845D2C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAEA293ABC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4B77E0FB;
	Thu,  1 Feb 2024 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fm/0m8EL"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03267E0F2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804601; cv=none; b=H98mx7+ALt1VN50D6jdgkug8zp9Mfe3rIbepbk8SS6c6MiZNBSo+N2d/mCv6lTZJEEjBWXUOkEtNEs1o0HVOl0yfculXygbrx8vpCNdCvMVTu/qw3VRt9rV8w8l3qmjGI6VSqGO/hoj28fADA9yvnQeURP498OvuIGRDf8leimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804601; c=relaxed/simple;
	bh=CcTsJRuBV7FsnKfKzyIU75uXHMZOKiQnJvCybgMg5QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hne1awESp49tmaZJtTH9fqa+0zIzMwyaJbDFeL48Lj0j3F5yj+oOvMfSLySyUXE2GMIrkWjNj8/8XDmTGZPdEmYmgVOCCgRj2L4zkoeP0BnppGg+XN2ZYyrg6p8j3JbXMfM9/VYVUq+FhXvVbm+sdRkmhyCuZBjjD1Goyr+9MPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fm/0m8EL; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783d916d039so79856985a.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 08:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706804599; x=1707409399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CcTsJRuBV7FsnKfKzyIU75uXHMZOKiQnJvCybgMg5QM=;
        b=fm/0m8EL1YPF9qE9pK9yhdCvVihSdc1Sc7bIS3lSuV13elfTFd/H5FfGPjzMK6Pvoa
         xBw1HZ8VgyZSbNPVZcx2Wybz+bTHxVDqfvu3jMdn1GYbKUchUJVwsm5njTA3IHICJmwk
         DBCnOvCI/R25/J6DHsIG5v/O0wyBhh2Z6BKu9sq52jXGgsonwF7AC9rE1qxEfDc0lFvn
         J65eD7fX4NPEM05jQj9omcDLqVDO7y+WFer7xvf1ZkEvgSIg2ZsG7GjGDJiK8bieZRvL
         5LlXCQavwVUL4PIdQdH33j5H69vbulYdBsOi94TM5E9YlQxnf4n1VbuTRpgMAq6+7CkW
         LOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706804599; x=1707409399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcTsJRuBV7FsnKfKzyIU75uXHMZOKiQnJvCybgMg5QM=;
        b=YfBkdHgs7An2twc5C5Fwry85GtrhTz6IKVztloX2B8L7rC7AoSHFmaln3TJnWusosl
         a4J6GOf59DsZdLl3jATEnTW7FsnVpJzp3fJNq/+mTVyU1QWWSoj+YQUCAm13qzsmTkqf
         qkqlyrh2QM/F4TXpC80r2s6nq7Jw33FMyY9ObnZ5gtDUe2mYBL69woOHJ9p0fjjCSDFF
         Bakjihzod6k2qKhv3ren0UidNQbARQ9v98PpEjfnG4xd0CRi3Mda35uN1MummB73OXRx
         NGWmQuk12qY1bdTGZnezSlBzzjKzePOPMKz/jLSb+ifNVt7ShfQXnJE2F2yNUCY+tAPH
         lW1g==
X-Gm-Message-State: AOJu0YyhIX1pw+GFIgj/bNjtyWbmvzglP04VLwxCMldBLUrRHD1/nVrq
	frNjPBoxzvFfvj7osNzXZinTO9PdjkSdJNeW0Ncxrlp87/9cQxVEghi7URZAkWc=
X-Google-Smtp-Source: AGHT+IFi4KZwaIGRm3q47w7BjMsKmiX4fpOGOKit+SVa9n3QbWQY3Wl0wBNYNELUTfzSXr2sJraYZg==
X-Received: by 2002:a05:620a:2491:b0:785:501c:2bd2 with SMTP id i17-20020a05620a249100b00785501c2bd2mr1035299qkn.38.1706804598763;
        Thu, 01 Feb 2024 08:23:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU87vsPNAg+pZEP5zUOh6/YC+YRKj4IweuYEznAwhlkaHTekFELvGEStc9E8xPfg6fdFoHbklzzDDEyWsQEF68iOX77q3SltmJfpPNZaLSf4Q5bmL9RMxTq1lt8kN+kEiP8o3PZzz3GzB0VtEY1vjmTkktIMB3EgdsUDAXX+roW0AYz77LG0s654wnd8RyTj2TsWgPGQBHsbf2kpVNp2bBCVaa6tg8=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d23-20020a05620a205700b00783f77b968fsm4034200qka.109.2024.02.01.08.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:23:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVZqP-00Ammc-N5;
	Thu, 01 Feb 2024 12:23:17 -0400
Date: Thu, 1 Feb 2024 12:23:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nikhil V <quic_nprakash@quicinc.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Avoid races around default domain allocations
Message-ID: <20240201162317.GI50608@ziepe.ca>
References: <e605b38a2d40b1e7589e10110c6d3ece35f6af4e.1705571894.git.quic_nprakash@quicinc.com>
 <139a9abe-75d8-3bda-3ec9-a14a493eb2a9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <139a9abe-75d8-3bda-3ec9-a14a493eb2a9@quicinc.com>

On Mon, Jan 29, 2024 at 01:29:12PM +0530, Nikhil V wrote:

> Gentle ping to have your valuable feedback. This fix is helping us
> downstream without which we see a bunch of kernel crashes.

What are you expecting here? This was fixed in Linus's tree some time
ago now

Are you asking for the stable team to put something weird in 6.1? I
don't think they generally do that?

Jason

