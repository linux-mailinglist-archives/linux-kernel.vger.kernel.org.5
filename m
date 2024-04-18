Return-Path: <linux-kernel+bounces-149418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C768A90E2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955AF1F215DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C2638F94;
	Thu, 18 Apr 2024 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdEJRmBr"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7815374D1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713405361; cv=none; b=rihXe25iaIF9FQIyy+6BjxYedZEMKqZmfVGWZ8zjUnHL7Lh4t44o2kUGfzrJB3IVLdZHM7lcaXq0ENRP6fNoYX/MO2RRxM4kiNRTJCbYj32CHyCTUuJkb8zDihmjZNfu8UtOgy3JGtVVSqJc2R+Ngya3TpsKmoYZsLetPXum538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713405361; c=relaxed/simple;
	bh=ICzcusRjinh/BvFsgCxzdDsojAF1g9oCIpNlSl6yBRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beKTEwkl+eSXcB9775VOYB+6G3C3N2nkN+0/6b7+sf6c2aUKnnJxJyIIU0xRT4XMfJBInGeecTLhpefOZHrnta+y3KPGbfnMrOsP0O5CLihtN5LN5AeIIH6Nmv4fEW/WQv07Xe/XK1mCz5419fovDkCDoIqdgB18kveFj7DIzUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdEJRmBr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f074520c8cso403952b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713405359; x=1714010159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsW8EACTysaUs0PEk43AddyGrOZ25hiNKaJ5MO8hta4=;
        b=jdEJRmBr/Hl7zz05yfP6R5DZBlnpor9Txwk5i5Ov8PdL1wfzkVJAK6dkjmH8R9sOVr
         nu9cjFoCLYzQzXvqdDCWVmblUvpd9pHfZRNY0Xgxadh/dNw9nFELApbfi+YFryTjIBEG
         z9Z6Ke5/a7tUqabv64mF8WpKziRYJZn1ED/eltWxoDPzh2Dv1o46UGwyVdn20kcHb7CW
         M7SBdfDDSdy/KwEsYHxKkAoJnmbJ5gwXOu6oqVp715+cQ8I25SNgpETBM3l1FRfPa6JL
         uoNBjfZcwreJxnOfFy0X6Vd4lrfFs2k3LEloMCpluGQzL6/gOX8zSUsE1gQeOXtjEuT1
         lgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713405359; x=1714010159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsW8EACTysaUs0PEk43AddyGrOZ25hiNKaJ5MO8hta4=;
        b=eOJG8rZ6w9c4h+qBWcAhbKhoUtrDl89g3LX7J41mTq2pgYK44FBPcjPWztfwljx0oX
         bP4g+PX8FLRVG48InMT2FqdcgETkQ0p21Z9FFPlrrjY1R+mLYJ7oAwYvBD9EjXshLFwR
         0WUZBz9kMZlO5vOrFiNci46KtsUuKkpTP81faF3N5mI9lJCnBBZDqeb5G8qTw6zxgSNA
         DJAOj00O0m7NQ25sRFvo843r+egaRx4Vbdj8HdOHoTgSRBXx9wPpZFmMcYLFeikkK8/p
         BrHmODBcPWzNB9uj0BmSimdznymW+1+firHRenuqNrbR92PC8jIf8jSH3AWLO/MsR4hS
         iIZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4nVEkvzW4pBI5tga609OcXJ3Umpd2LYNtwFXcuWdTW8bSefuw+STpenL5HKyI1tSGnZpzrg43aOlXBnKdvZFmi5SgGARHijlt7+ZO
X-Gm-Message-State: AOJu0Yy4p3XDmmZWbw0ZTJhVElmrYuaF1y8KW3kbhDRE6wPArtCGo/VU
	ZAKzuJuNkjp3ayZRPZ/2ucOL5VKoteIgFZaiqL7bwGY8No6GGT3cSSiBK1eq
X-Google-Smtp-Source: AGHT+IGhwSkWS5QZPlqHqybjTToiQbSchTvJA0dgGjCBhjCI+nxz3OYMGKZEit92pga6qIqfluzF6w==
X-Received: by 2002:a05:6a20:2446:b0:1aa:33a5:c5e9 with SMTP id t6-20020a056a20244600b001aa33a5c5e9mr2079208pzc.34.1713405359032;
        Wed, 17 Apr 2024 18:55:59 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id fe8-20020a056a002f0800b006ed00ea504asm339035pfb.159.2024.04.17.18.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 18:55:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Apr 2024 15:55:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix selection of wake_cpu in kick_pool()
Message-ID: <ZiB9rYBu-0qjsCbF@slm.duckdns.org>
References: <20240415053550.538722-1-svens@linux.ibm.com>
 <Zh8EfxdVdiIj_27H@slm.duckdns.org>
 <yt9dpluogfw9.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dpluogfw9.fsf@linux.ibm.com>

Hello,

On Wed, Apr 17, 2024 at 05:36:38PM +0200, Sven Schnelle wrote:
> > This generally seems like a good idea but isn't this still racy? The CPU may
> > go down between setting p->wake_cpu and wake_up_process().
> 
> Don't know without reading the source, but how does this code normally
> protect against that?

Probably by wrapping determining the wake_cpu and the wake_up inside
cpu_read_lock() section.

Thanks.

-- 
tejun

