Return-Path: <linux-kernel+bounces-128192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4D189575B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5E11C20A6F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F17312C533;
	Tue,  2 Apr 2024 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkJkgsz+"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E63912B171
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069066; cv=none; b=r2g60snHvu/mHc8juQTJ3dOBU6D303HK1XrXKSaLR9S6NMEA4QuSSWQn2JWoo3zer00x2INm/pPSDcH/NqQyv2R8ELE7URwbsRsDlRQNaKgKl8FgAQAq/rhKQIiyo/fxAzCdWb+qxIIneZ9ZxRZY+S/hBh4D/ARE/1QuGxwHrAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069066; c=relaxed/simple;
	bh=fGuaPdX4+28sYtC5DboaV6Cdo5XbtDu/aiutArVxNMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nceXHTbeHgaCICAF6QQ/CUIFcu8w42Wq0keCsHGGyarP1xuQ424yU71q/LKialyhEjGHO1Q37Vjm54O7Rlkmglrs67OtFmuX+7/+CNFLKuuBfWREdhbTXpkN66VoYJv8YzPFmHSuFV/3aW4svQ2Gu3+8XN0qp8RFGCzb2g1BpUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bkJkgsz+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56be32b9775so6947913a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712069063; x=1712673863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=llvWiU6WYMOEo8iT+6jDXsiJqq1fV6TG+kjDiXbKQ00=;
        b=bkJkgsz+Pi3KdolvflzrXw9MQ1j4UeCJMUi+vhwcf9RkV8z77dVrpyFyROoF9xRjYA
         pMPWPCanluKA3VywzG56JKLSiGZyFBgBom//vH9UP9VmHyYG6p/2W+OYT21FWRnxMA6K
         Xbb9MIzXk0eshITs1+KldRkWNBEK98TAZh6n26LnVXYOrvH58Ja8Qc/pl2kRpeJNTncE
         VcW2lPWz5FIsi95r8CIXyyt0yYkAGHAYSVijooeZqqtONRuuJVhgDBY04ntEb8zjR8Ht
         kSOkxbO8hUa0HUcPu2/6ba1luGEQla/7vkFpFEiJAHPjW4KTCXDH409NfJdUb7fsYqXd
         M6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712069063; x=1712673863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llvWiU6WYMOEo8iT+6jDXsiJqq1fV6TG+kjDiXbKQ00=;
        b=FMZRCg90JEVsp6RHZYrrBw5o+jk/pR8OiouMAd/L2cHw5Q7/HexiDdcTxgfidrE6xs
         Zzb9Yx3vX2pTNK5Ptmqm51WiFTelvM85KcWd6YzN6EjpUgvI0iOMXEP479NLpQ+6/tTW
         S1pM+/ZJCDrqOXuGibHDy2Ny+nb2KvywnM5YnlQY/nskn3NWVq2hfVUDYaUQWBKGhzp6
         mhKwf/mAiSVzjORWXiMDBF2U0MupJ1z3tycqR+TH0fRQ5z28/odJa1+/piZ4oYx015c2
         zJ3NgonhfmHs7AHab06VH8YV1wKgjA746HETzFbJMkndFdGoTUH21egI7c7kz7qsbfMn
         SXng==
X-Forwarded-Encrypted: i=1; AJvYcCVxZ+tMK7nmIMcvLT/gUOo9gQQwfrSvbFhrwTNBsX2m0eTdux33E065D7Fna4tLk7tlxMCD0i9vLEP+1qa9n+y/6pCzhp3+TnT/TlOp
X-Gm-Message-State: AOJu0YxYv0ZPlF5N0Kqxz+INp+q/Ihu2BlyWyjibve81u6IE23KKv4gq
	PAPg0mNJu6KFQVvvJrdVA5DixsYhxI+S9UjW9zRtS4nba6h8rFpuAGDyhlLUImc=
X-Google-Smtp-Source: AGHT+IGHCy6AW5RJuX88eDfDpaARDXtUhVjEm97XYVInHvyg/NeNlnam7roamuVmcsfAR6UYhzSKPg==
X-Received: by 2002:a50:c318:0:b0:56c:16c9:bd2e with SMTP id a24-20020a50c318000000b0056c16c9bd2emr31946edb.9.1712069063270;
        Tue, 02 Apr 2024 07:44:23 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bf18-20020a0564021a5200b0056bd13ce50esm6951480edb.44.2024.04.02.07.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 07:44:22 -0700 (PDT)
Date: Tue, 2 Apr 2024 17:44:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>,
	Grant Likely <grant.likely@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH v3] drm/panthor: Fix couple of NULL vs IS_ERR() bugs
Message-ID: <91e25b42-c3fa-4b69-ab8c-5d79610e757b@moroto.mountain>
References: <20240402141412.1707949-1-harshit.m.mogalapalli@oracle.com>
 <20240402163838.34003a10@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402163838.34003a10@collabora.com>

On Tue, Apr 02, 2024 at 04:38:38PM +0200, Boris Brezillon wrote:
> On Tue,  2 Apr 2024 07:14:11 -0700
> Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:
> 
> > Currently panthor_vm_get_heap_pool() returns both ERR_PTR() and
> > NULL(when create is false and if there is no poool attached to the
> 
>                                                ^ pool
> 
> > VM)
> > 	- Change the function to return error pointers, when pool is
> > 	  NULL return -ENOENT
> > 	- Also handle the callers to check for IS_ERR() on failure.
> > 
> > Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")
> 
> I would explain that the code was correct, but the documentation didn't
> match the function behavior, otherwise it feels a bit weird to have a
> Fixes tag here.

The code wasn't correct, it returned a mix of error pointers and NULL.
So it needs a Fixes tag.

regards,
dan carpenter


