Return-Path: <linux-kernel+bounces-60911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EA5850AE6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99981F22570
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB56D5C5EB;
	Sun, 11 Feb 2024 18:55:11 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9126F5C5E8
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707677711; cv=none; b=NetJszaLXuVhiatWxprDDS8t4ndW2srUOEskB8coqiFRlLewVbu+6MOboCYrNkL6J+BDQFKqHXpmLxdOtPeoWl0h3wV+JVvCwAeSVYD0muPNltN0c9TRUftH1kLtLTu8Ka1z/XbATbnftXFBjaoVtkhsZmwuC8oneehc0q9Fx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707677711; c=relaxed/simple;
	bh=zOMiltPoLSaPVXQpX+AyhP1tWAB8q+YFG5onf3ColLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/hgoxH0ZSzahOYmWTc4yvjSle9bvjywMLrQxccNQyQ7iZvqZYf3YjU+KMm53Y5nQTNiM0ESnz1R90o+y2rZx+L1kz/ewxMDRuB406zpWGzJYgajrug1KLSTKTQiNf0CayNAOV4rqh9WLa+ZzeMNt/FkDKvlP5qOQpOYELJLLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78552105081so178067185a.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 10:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707677708; x=1708282508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYaFnPH4T57xbODxsrD1uA/JRSAy3nBPFfHDTo1ipmE=;
        b=dRJWiOSLXrK5+kGrFFgTid8u383bBfuwNfZMmc5+2ej45yVv1rkJFK+6zkElEDZVZx
         bCNha4u9q49ODxbdieWevOGY6w6myDB2AMY0g7t8gXf9PgoBVvpuPRKrIZFNOWcT+lbh
         SN8cHmVwS11XmrTG6byisMu3MTNt2hGYqFbOGDFdtOS2I64kgOP0RLCRweCTSoJFs7xG
         8yf6QLP/m7u4VeIuaIFAbVTIbJLCExTeb5x0o0xxoZ9e+hW6rV7LI6s/KA2rf/g5wRKl
         pliGhKgL0V9LewbLoRmtoubxrkHEWgVmmdPIMzX/8FURXpAIkvCJ3/fiLaAyfScFu0sa
         oZGA==
X-Gm-Message-State: AOJu0Yyo9OAPuQ6UNRALdofuVcV2PPuPE7bZeRH6eUDZ/90vHCVxCQrV
	Ctx76+C35ZloX8/q2tUeD1+otZgUUn64sb5Tv0y9GP5Ee0I3HQqaW3OuHsxbRQ==
X-Google-Smtp-Source: AGHT+IEpVYQgDizFElfNgxxrxcQYJwrK2TguA2ymoGhXLUMM6BM6g4VnY8a5QEGnidAYziFgxvHqig==
X-Received: by 2002:a0c:dd08:0:b0:68c:48fd:4441 with SMTP id u8-20020a0cdd08000000b0068c48fd4441mr5088279qvk.64.1707677708614;
        Sun, 11 Feb 2024 10:55:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUN17KHbxG10s+yxCtcs3OdW+Xkyi+j12gZmyMIv8GAHSnYGoSY4HE9hwNcdGiorsU8NTu+jVS/XyFjRSfwsSAoH1fHgR3wyBbxKRyqKN35MPBaBUG6gQVbISVPBRikukhUy1XefK4QGMevRepkn0rmKH+phaIL7Sg9NxV67STQkMKJyC0Cckw=
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id nh6-20020a056214390600b0068c6dd9af10sm2685704qvb.64.2024.02.11.10.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 10:55:08 -0800 (PST)
Date: Sun, 11 Feb 2024 13:55:07 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Matthew Sakai <msakai@redhat.com>, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: dm vdo slab-depot: delete unnecessary check
Message-ID: <ZckYC4wyzbX2870P@redhat.com>
References: <16ffd614-48a9-42b8-961d-2dc8a69c48d6@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16ffd614-48a9-42b8-961d-2dc8a69c48d6@moroto.mountain>

On Fri, Feb 09 2024 at  8:06P -0500,
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> This is a duplicate check so it can't be true.  Delete it.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/md/dm-vdo/slab-depot.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/md/dm-vdo/slab-depot.c b/drivers/md/dm-vdo/slab-depot.c
> index 42126bd60242..2f4a2ae5e082 100644
> --- a/drivers/md/dm-vdo/slab-depot.c
> +++ b/drivers/md/dm-vdo/slab-depot.c
> @@ -4100,9 +4100,6 @@ static int allocate_components(struct slab_depot *depot,
>  		};
>  	}
>  
> -	if (result != VDO_SUCCESS)
> -		return result;
> -
>  	slab_count = vdo_compute_slab_count(depot->first_block, depot->last_block,
>  					    depot->slab_size_shift);
>  	if (thread_config->physical_zone_count > slab_count) {
> -- 
> 2.43.0
> 
> 

Looks good, I've picked this up.

Thanks,
Mike

