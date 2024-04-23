Return-Path: <linux-kernel+bounces-154598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 447D28ADE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD611F23778
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E5E47F5D;
	Tue, 23 Apr 2024 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJv4Ppcc"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984AF45C06
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856945; cv=none; b=Nj7Kvo5tD/ovGRFFqwWNZmb1K6QPwSr/APWWXs1oa8oTjaPpWZQw9IQSfhaWFlVzAmxf7As95Gum/gCj9FsSGJfmeaw/hXCEOGscTLngFQpKoHTXJe04tmdWyBIixW15n5YSiICLvcbkN7VN6yT5+WxTevNFfIl1V54SSFxbV6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856945; c=relaxed/simple;
	bh=xG4JAgggbzIwtbQrgp5cQbAA+BYHCthqelpG3g6YI4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvB3VCryTmuFMvx+6pyzjWL6UpQQQJFwdqCUE1vW8i6HnqtizeJDkTJPybdOefVZEqaKL7ViKg7376s/Qdj3Iz+XgfNQXEtaCXwX17PtM2A9PF/8A5HuQki9LDsB8Olo8TCQpe2mvMtJ4BZhUrfhZHQN8f3EJFiZX0i8e1xw/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pJv4Ppcc; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-22ed075a629so2086879fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 00:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713856943; x=1714461743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r4/YoB5QNhMgFUUqg2UAE1DzTDTXxcFbcb2bKzJdYQE=;
        b=pJv4PpccAbSaS76FHjEsvNWljXuintm6DSkb74PwXX62Jg4vsdBVflZ7vPsLxISNUd
         arZlIzX3D9EYg50Nm79Q+3AXoFB8lq3ZX/XS2XVwssOsaURuTvj8z9hLDoG6r+lMcJo0
         Xob6TyW1N5hIagWgTMn2ZyTvnYXhyh4lVoPK9sEV74ZC8K9ej0jR7cB7boKkG64aAJ1l
         nb/11NHvjSitEq4xh85FweEcDn2t8vA7sRIL+ElBscHFiM3UVIVG8oGO3mVLcsQkIGtC
         YJkP3cfg9lfepZeEbEHdg+j8IGWd3BzPjqEveBMWWqlsRmnq7rWGrmjA1xLywnv2yuH2
         8EYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856943; x=1714461743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4/YoB5QNhMgFUUqg2UAE1DzTDTXxcFbcb2bKzJdYQE=;
        b=stW7bTW19aZQr6KFqyRk6uHdFf6gpxKxeiChzfxwR2QqPuMPro5MayoEDm/jkXI56S
         NcBNoXRKB0dFyn2Ss2fDsHui8SoNc8kmT+zGmJriPac+f+z7IU4tT/YtSGFSSxunJNl/
         NKbmDN/v7Totm75CHvtrlWW2R0z2CI/yyySdnALgGZCNFfKzUWNX3IPZYnl2alNUK5E5
         /v8Vnf7M9Cwluis1von6ZkatkK0UXDRe0IfAWDSLfvuhEe+1wp0nuxrkeLE1/jtXKsN5
         OQXHIBsMhQzXt8ELdLJBtVNToTCN05TiX5DqEfEVsddgZFUZthGnrYyFMr0v3tAGEJes
         b3RA==
X-Forwarded-Encrypted: i=1; AJvYcCW9ORaU4EnPk6CMUMFNWzoU92dO092Xh73DNsAxDKU7D13bGTqDxim7TTzMukB+4TW6pdaSp1L6Dw3OkF7JPTpaA1K4a2By4lUTOBg/
X-Gm-Message-State: AOJu0YwBwLOx9pVzdExNayuSQo3D3VuQvm9su7vlBf8GPveq1dsa6bvH
	D5y4OcZTU1cCzXlwtOnSFvksJwv5cFvSxlQeZVsZQAOsqdRoL3sguIaxmAeBeF4=
X-Google-Smtp-Source: AGHT+IENc2wersPjV+jG0SCLKtH5Uji/VePfmZnmxfyXZ/X66GgFYNF4DqlSWWPDB3bqhRWLvKbNXQ==
X-Received: by 2002:a05:6871:548:b0:233:378c:a06a with SMTP id t8-20020a056871054800b00233378ca06amr16184873oal.22.1713856943435;
        Tue, 23 Apr 2024 00:22:23 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id r84-20020a632b57000000b00601df0a973dsm1997272pgr.48.2024.04.23.00.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:22:22 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:52:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Shivani Gupta <shivani07g@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] cpufreq: ti: Implement scope-based cleanup in
 ti_cpufreq_match_node()
Message-ID: <20240423072220.sx3lrvjtlirmz675@vireshk-i7>
References: <20240423020727.776360-1-shivani07g@gmail.com>
 <aa2bd3b6-7bb9-98ae-b762-6060f828170@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa2bd3b6-7bb9-98ae-b762-6060f828170@inria.fr>

On 23-04-24, 09:11, Julia Lawall wrote:
> 
> 
> On Tue, 23 Apr 2024, Shivani Gupta wrote:
> 
> > This patch modifies the ti_cpufreq_match_node() function to utilize the
> > __free() cleanup handler for automatically releasing the device
> > node when it goes out of scope.
> >
> > By moving the declaration to the initialization, the patch ensures that
> > the device node is properly managed throughout the function's scope,
> > thus eliminating the need for manual invocation of of_node_put().
> > This approach reduces the potential for memory leaks.
> 
> The code is fine.  The log message is a bit verbose.  Try to avoid
> referring to the patch.  It's obvious that you are talking about the
> patch.  Try to favor the imperative, so "Modify..." instead of "This patch
> modifies".

Fixed while applying.

-- 
viresh

