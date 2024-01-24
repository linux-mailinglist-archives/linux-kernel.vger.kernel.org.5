Return-Path: <linux-kernel+bounces-36676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EEF83A4E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0943288433
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE0617BC5;
	Wed, 24 Jan 2024 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUJx2hii"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EA317BB2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087259; cv=none; b=atNrPOysGCxeAGs6ivfkdHXLtP28q1Cr1JSguhbCd/P1q4kvE7u90FoiUXdnEISDIpO1IFm0FgxFARFWDaBFUsk7xAYEAFYNCKa3PLDHJhXv3piUfZ4a1MAKiqRJqXINbBvIkjV9EmegZL9ly04fUpE84bqxZYjx+611BXFFpKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087259; c=relaxed/simple;
	bh=IXM6p4NQ5xNMIp+I08MpFl/C4xzL887zpVFg7lffNJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWAEIycbG7m4aRFI2O4OI+ZZe7kfiXR2cITQHWnoB8013vs6zZGd9rQHU9MbT5Z2AEYU7aHO0p8ZY/jCEARWqN9Cst+ySJcDoOJSg0mIDhGDvSqbUvUAUFWozo1t9U0MfQ1cZDbBsMtBR8HWrY65jjfqV1UBUMa7KXtEFlHonJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TUJx2hii; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e865bccb4so37345e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706087256; x=1706692056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SI39RK/rWNckwv2r4B917cux2i/pKiQn7x4kFloCx1A=;
        b=TUJx2hiiFXxEQO9IQO4ITipdfTgUi18peJAvMnVsL8dIUc62kd3gjl7G2/axNg8bNj
         hbvQknLjtRLLBcscEGmAeRMBuNttn7tAK1jlZrYtTPtOdZP1Mxa6lputKsJ8A756gvmz
         GQtW+efuCYYLZbKLnU8pSQtDahsa4HOsY8nl3Lv4uJH88Aahjb69eyMF+ZfXpVlOsPUH
         yEP4EHMTbfVgISteoPGj8rhkK7TlZCy9pAYaYbRP6hTrxXiOhbyNpUppDNJHxo7gdK85
         do662d5S31U+q/9doKBYhIgicgVzb5cA7QMZ9s9ihmLeG1V1sdtUqLKM5Aas1cxzrFZG
         2VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706087256; x=1706692056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI39RK/rWNckwv2r4B917cux2i/pKiQn7x4kFloCx1A=;
        b=hktC/D4rTeDFBJmWSA3UwApby5gRpB9xDr2qkJaauaxibjX5aq8r+EEYyS0T0qLjvp
         8WQBNZsjWrtq0LeKf6DfkNLHGnQ5/uZU2bz3lsxIESVs2SCz6YUlJoRLvi8N6iBC3pA2
         jL1uj0wd8cfZcZub/hF3YAakgmDChhcBQPECAf40mQ5PRnU8jwYbZd+qfkdLaJTI7BDg
         a15uLWx6zS0HNPgjTBdfkmOLn2p+3m/2Z2R5CXMiy16mTC94GchUYB5InxY1ok1yGKkR
         RJviK3S2IHKLcALN+JpaKk2jEIllLuh+dgKBIFLezgxxkWbWmTg2bPKWylHjo0TzSZHq
         sF+A==
X-Gm-Message-State: AOJu0YzHptkyMnN05M64uSHYd89AxqKsf5j8Z2GJmh8Jq/vy3UO584Qj
	gihU+7pNSuP45otepGKw03s+s8oJkTqJPXsb4L+WzrjpdE4VZrZERj1CZgGnUQ==
X-Google-Smtp-Source: AGHT+IG0lrnvSdMVJPjDEKWKykbbZOKABVazci9lTsykpHwLQImNw7JnWtDPfFCpWv5+CfrTrixLkQ==
X-Received: by 2002:a05:600c:5107:b0:40e:b963:6076 with SMTP id o7-20020a05600c510700b0040eb9636076mr41367wms.5.1706087255568;
        Wed, 24 Jan 2024 01:07:35 -0800 (PST)
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d5110000000b0033763a9ea2dsm9142555wrt.63.2024.01.24.01.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:07:35 -0800 (PST)
Date: Wed, 24 Jan 2024 09:07:33 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix circular locking dependency
Message-ID: <ZbDTVX1y2bRtJf-G@google.com>
References: <20240123164818.1306122-2-sebastianene@google.com>
 <Za_43qOnVsCPauEr@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za_43qOnVsCPauEr@linux.dev>

On Tue, Jan 23, 2024 at 05:35:26PM +0000, Oliver Upton wrote:
> On Tue, Jan 23, 2024 at 04:48:19PM +0000, Sebastian Ene wrote:
> > The rule inside kvm enforces that the vcpu->mutex is taken *inside*
> > kvm->lock. The rule is violated by the pkvm_create_hyp_vm which acquires

Hi Oliver,

>                                          ^~~~~~~~~~~~~~~~~~
> 
> nit: always suffix function names with '()'
> 
> > the kvm->lock while already holding the vcpu->mutex lock from
> > kvm_vcpu_ioctl. Follow the rule by taking the config lock while getting the
> > VM handle and make sure that this is cleaned on VM destroy under the
> > same lock.
> 
> It is always better to describe a lock in terms of what data it
> protects, the critical section(s) are rather obvious here.
> 
>   Avoid the circular locking dependency altogether by protecting the hyp
>   vm handle with the config_lock, much like we already do for other
>   forms of VM-scoped data.
> 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > Cc: stable@vger.kernel.org
> 
> nitpicks aside, this looks fine.
> 
> Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
> 

Thanks for the suggestions, I updated the comit message and I will push
a V2 of the patch with the above and the Reviewed-by tag.

Thanks,
Seb

> -- 
> Thanks,
> Oliver

