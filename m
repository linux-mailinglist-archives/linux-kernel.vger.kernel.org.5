Return-Path: <linux-kernel+bounces-102475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766E487B29A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB451F234D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAB44CB47;
	Wed, 13 Mar 2024 20:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WotBfk+9"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC9E4D5A1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360663; cv=none; b=gaPGGSO94H8M+8TzIwqt2IMPaiB5Ubi2Kp2KaQP+b/ilpGiTpEenJm7m4njI6StofsMt3z6oqr7X1bKjzUeUjISjnpm10QPn50GvJlmXk45/0R6e005Rnu1E1iY//EH5slGjJAT3POwX4Smp0hWY3/4AhNbFmsjxkPxISXujlBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360663; c=relaxed/simple;
	bh=8yAqCzvWQdL0ew6cof8Jtas0cv8ha0osm8+vyvr5p8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIZo1Kpz3EV6X2Ygf0kov5JcUS/GHpY9/bkQU8OTDCHBujKA1mOY6YP+CSeZ08DZteLr/GoZivrSK4/mpJ5tMv13c/26wROQOVlBf/XZugN6eM4GaCIEiqUf82U7e1XLcYDVWEe5DwOrpn87q8C/hp4disM2KNmjCZ5eqUAOTKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WotBfk+9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dd7df835a8so1997915ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710360661; x=1710965461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbZJl0CElzoIEk8IP9Ngn8Nv9P9nIaaRfiaB0kVntjw=;
        b=WotBfk+9ZrJuW3ozdfFhn7lo6j25QhWRuFkEbGTIZNYlh/ockMYk7hbKVHUXBSVdOj
         SsLVZ/Jo2M+MeTy1BUPOjQeKs+bhCNnK/C864aNunGWQo7htUsGLUAfGe8xC60Bs321c
         kyAry0i0x47TiXqyQZCT0Te2AdoTKQhi6tyeE7qrJJxyKg13aK57puj/4bs60cOm5h2V
         w3ciP4xK8pXnv+E6nItvQ4v/C1Vp0jadvF9YZK7X9kPKbpYVROiOyv/YjdojYBs0OI9w
         0SkM1UPlQbOtq7UYIpMOcT0kKv80rsLR/bl63V59yLelhCm6BOBp5YSKJwKwkQTxU57E
         NX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710360661; x=1710965461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbZJl0CElzoIEk8IP9Ngn8Nv9P9nIaaRfiaB0kVntjw=;
        b=By4eHoxsMOhgIEAZcYhq1JP1brDriwKVmqg3MZPTIcQm3pEhKI3Jm8n4lBb3L97xLA
         vBOwEB1kaUkYcUABvnfRZts6qWpUKx+215V8teKQDq7w4QiZVhRigHt6jfad7wUT8iv1
         4hcHHP9OspznR3RWdHN7fxna/u/KL+ee/53KmFisjQTGP0ms1wu0nGkHX4Xt7IO8dCRG
         RjCtBXp4ra85i8QeFnLoFqV1eM5sQJzC1azF8t80UxUbqk2+vDbS/TszmM7VJxKXNmdU
         S0lOEEZK1LrfjlKY4gqT7OJJA2JnbZixFsD8tIeGMJSAJ9RIINaWk0UAygDE5nm87wAX
         65jw==
X-Forwarded-Encrypted: i=1; AJvYcCXv2YZcgjU2w/vPsBqhrtvBgXA2u9zAiSzMjQqOj8RIh8wKRVnkET7UjSzBLDw/pl/bNnzCCJ31EX0QIB6o9XOUjl/3iP9d7U9iGhPl
X-Gm-Message-State: AOJu0YzJgkbuKEVD5IJ56pRyZyi+nVCQwTZFtHNYhIOyTCfaXuq3inMv
	e0IlWm53nMvT82lsLAim3A5YGrd/cB7aBXDsqvAw6D+HksrAdOAO
X-Google-Smtp-Source: AGHT+IFUQ2CTUYalVg3crtcu+LVSn00GcuVJ23CVxT6o3SwVRCyk3hG+ffiwj5ZGcX5nvnMVelunbA==
X-Received: by 2002:a17:903:2983:b0:1da:1e60:f9fe with SMTP id lm3-20020a170903298300b001da1e60f9femr4900969plb.54.1710360661414;
        Wed, 13 Mar 2024 13:11:01 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:2875])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902e88c00b001db5bdd5e3asm5749plg.84.2024.03.13.13.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 13:11:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 13 Mar 2024 10:10:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Allen <allen.lkml@gmail.com>
Cc: Allen Pais <apais@linux.microsoft.com>, jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: Introduce enable_and_queue_work() convenience
 function
Message-ID: <ZfIIUyip4U-hGZ4l@slm.duckdns.org>
References: <20240228181850.5895-1-apais@linux.microsoft.com>
 <Zd96XzRHI_jMOCip@slm.duckdns.org>
 <CAOMdWSK9_1LMA-ULLa-iZ26P75UCOrO4gScAqmYvqbrvJi7wSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSK9_1LMA-ULLa-iZ26P75UCOrO4gScAqmYvqbrvJi7wSQ@mail.gmail.com>

On Mon, Mar 11, 2024 at 03:50:54PM -0700, Allen wrote:
> Tejun
> > > The function accepts a target workqueue and a work item as parameters.
> > > It first attempts to enable the work item using enable_work(). If the
> > > enable operation is successful, the work item is then queued on the
> > > specified workqueue using queue_work(). The function returns true if
> > > the work item was successfully enabled and queued, and false otherwise.
> > >
> > > This addition aims to enhance code readability and maintainability by
> > > providing a unified interface for the common use case of enabling and
> > > queuing work items on a workqueue.
> > >
> > > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> >
> > I'll apply this together with the rest of the series once v6.10-rc1 opens.
> >
> 
>  Could you please let me know once this is applied or point me to the branch.
> I have all the conversion based on this.
> 
>  I have a series ready for review(a set of 10 patches):
> https://github.com/allenpais/for-6.9-bh-conversions/tree/for-6.9
> 
>  A series that still needs some work(testing and cleanup):
> https:/github.com/allenpais/for-6.9-bh-conversions/tree/for-6.9-wip (This
> series contains changes to all the files that use tasklets in drivers/*)
> I am working on cleaning it up and also testing. They should be ready
> for review soon.

Great, I'll open wq/for-6.10 branch once 6.9-rc1 is cut and apply the
patches there.

Thanks.

-- 
tejun

