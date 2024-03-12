Return-Path: <linux-kernel+bounces-99842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A522B878E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D430E1C21C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FB117590;
	Tue, 12 Mar 2024 05:25:54 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C09D2FF;
	Tue, 12 Mar 2024 05:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710221154; cv=none; b=gBqdjhmorl4M4yDqmtyPhSpfSvrGf96CjzULBY/Z77oAx8LHwfDDKHS7KACHcJjSZEibY7byldppZDZ7jTv4o1jswNVHNqki9DgfldKmiY+l5xBVAZphcZhlZhWeox06HRaCPxKgaTJhRRWvM5LMuPakVtaUvSX/FnsSGmrptII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710221154; c=relaxed/simple;
	bh=Hazu1tEC4Y2MS8UuFwLiTUKOQXGrWe8Yzjy8Qnrk6MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBLDlRkAb7HJOZ86Ok0XmBuoQ/eeYKewg/C0JuymvKxUJOUq1WwcavJYA055rH+l8n2PWzHoM5ex85bLH/OS16dKHf53vXfWnVlTzi7fosRMSB+OQlqStA2Z7qnWB1dtlYFv+3fvESkGSVo+MTa6oUtGxU7mMDdN85bj8oQxUT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dca3951ad9so41848335ad.3;
        Mon, 11 Mar 2024 22:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710221152; x=1710825952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1fE9AhFdNbC/vl7YPR7mQwT/um2fblt6Kg4fbbzsik=;
        b=CTseT7uOu6Mtuqv8j06NjZS9QSFp0tvJjMQJ4SAmGFyIcIYjxTUskOeVMnpQSNGAKp
         B39jDONm4d9S3UDPTWVOYsuuDVHk98/B5yjBi5cYEwLt5uuMe8KJLn5Vi8xEDE4MFS6u
         ZKmWCMfRJ7vcDtjKd2RC2T/UaqpOaKjrK7O7r5pPW6waDegBJkt6nHURBDKh0AtM0L8x
         vrboU3Y+39kKuNF3K38fNDSllidwN58bd7qKJv7RWyTyRx4zpntX+sXS59aXW27mtHS7
         b0rL1acMKuNEYZ/LEyWQNfL9+X3lRGtWqObHQlFVUrAFE66MFGBog2vFHhZEZDO6TWxG
         5r6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6Yi+LkgAgBYDSN8I/YISh6MbQEpRbk7Jrtsnr5wKYvC0t69g8MgDOOe8hSvu1o7TDMpTzBWy50MOOSzu2qsXQnBqKFL5j4An7PgwdfbMfyfzS+NxpeolanSqDyIVqLKT5T+FglSODsw==
X-Gm-Message-State: AOJu0YxND4gQwjhOU4CBT25s7ZItAS4iAr9kYNEJ94LML0lw+yope2bw
	KTpBJDY4sK/gTBkN/7E07JIZn1bHcVWC88wH2BLA7V64rP2msdYQw9HScZsL
X-Google-Smtp-Source: AGHT+IH3UAG1jO0o7VckutcAI64rmksF670270RMsb3Fw1nWltq/q4+fsnkvTRo1I7gGRpaDFeAy9g==
X-Received: by 2002:a17:902:ec8f:b0:1dd:a314:7351 with SMTP id x15-20020a170902ec8f00b001dda3147351mr5714762plg.57.1710221152360;
        Mon, 11 Mar 2024 22:25:52 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709027ec100b001ddbdd14872sm162608plb.112.2024.03.11.22.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 22:25:51 -0700 (PDT)
Date: Tue, 12 Mar 2024 05:25:46 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Wei Liu <wei.liu@kernel.org>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the hyperv tree
Message-ID: <Ze_nWnzKvw4kI_l5@liuwe-devbox-debian-v2>
References: <20240312151807.52478738@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312151807.52478738@canb.auug.org.au>

On Tue, Mar 12, 2024 at 03:18:07PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the hyperv tree, today's linux-next build (i386 defconfig)
> failed like this:
> 
> arch/x86/kernel/cpu/mshyperv.c:355:5: error: no previous prototype for 'hv_get_hypervisor_version' [-Werror=missing-prototypes]
>   355 | int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

We noticed this as well.  A fix has been sent out. I will update the tree
shortly.

Thanks,
Wei.

> 
> Caused by commit
> 
>   1634df06ea12 ("mshyperv: Introduce hv_get_hypervisor_version function")
> 
> I have reverted that commit for today.
> 
> -- 
> Cheers,
> Stephen Rothwell



