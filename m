Return-Path: <linux-kernel+bounces-87687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2A986D7B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9772849C1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD9E3FBA6;
	Thu, 29 Feb 2024 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xM8dEdSI"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B5F74BF9
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249210; cv=none; b=rV+YQGhTF25Zma4QJPmPU+zakWR36RDC09WZW8F0HjRQnWnbCJjl+5+gl7qzzxEqX5o3qShL/G12e2UCobOA/gjc2tb+nZ9jY8A22OT9TLy0DlGWmf1OAPzjzcTXCq+6i/DC4nmH3QUWLy+wSLsXcKatsDD+orzK4pPUZ0q4piY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249210; c=relaxed/simple;
	bh=vFGe/JPM+D98FYRCFhoM8TP+K+kv3fj2cPK6Z4iL8bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrWE0PQVhbz1AvfK1ac8yYmMlVz/HzOGaC4ucWKy90mx+OckefE8ptBRhOPUcbnRZ/VVLwWlCAlNo2pP52QoP7M7Gs6I61o3gMOahwkVbxZJUuYQKOI5duenGga4aROHqWIYC2lrsNmudqK05QSEDQq9XcByMbbNdEBFsjwsD6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=xM8dEdSI; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29abd02d0d9so1106931a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709249208; x=1709854008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=grHdyJH43EDqTr7lOlPpsv2LnOtPCDv7mkz6AEIU0ok=;
        b=xM8dEdSI0/FTFjeiVslj0L5JrHinrkZRbK0wIXgaF8BK0/xXK48R39MUEVILrw2tlZ
         0y/HJuwAJxr1wFMOoWiyYc3EtldxtiVFQgPvAeoOiXMAUMHcGUScmnsLYYWUbhyLyU6q
         pcaS1Expi4zbTjBNaun9f5cSG0m2dzOOiYpMW5OOG547M9uUewSBC6N3I4yUX3OoKPra
         5yAWS88QIpu0mxdp25Zi96Pl94/StNz/wZOGOQBGxoqeUxMxftRsNi7NgDEwTahvjtrY
         4DUiPcf8eGyEX1ShqWsUB0ZO7Fcd5+wrB6NhB2Z+EOKWDoS+fSOeQAT948ZgqnUtpbqz
         KWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709249208; x=1709854008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grHdyJH43EDqTr7lOlPpsv2LnOtPCDv7mkz6AEIU0ok=;
        b=AxDEbw+mUMTvu9SZfdoEb80HYDuj12qFQ38ZHqwnimiMDQf55OoFRwC5MwfhafYysE
         pnuzd5LgwjP3KlNZaivasU/aLQpH2RUdm+6JfYq7O45xwtdPr19+2j+DF13Tl/j+I1DG
         0BstM8GemW8JDv9WNe9X00xv1qsLpmdHgaX4MaU86WT9xgGQ4ihGc8QIOfGJfWmx5U9m
         tIKShO1TEj/iSrV+UHgx28L9pR+r7oRVPx8p8+QV/FCZiAiLQWPCy/CYGbxV0f/uMdcB
         vNgQPDg7DXsSXbjaURKWZQKv/JUmpxr9607rUKT++8+T47BX8DY+62EShBdIrojKcm+I
         vb0g==
X-Forwarded-Encrypted: i=1; AJvYcCWxKZWEWw36qgWiAsRBR/41b3lRY1V0OOQvsICOelMB3jpf1bFRykRjH5yfUuajpSK2HEhcAXVuz2UGQ16usGjcCEdJxPIkvylwRd1+
X-Gm-Message-State: AOJu0YywcyrOM4emfSbPYlT7tOYGEIxciOwqJXxmCjYCAq3Mvch2TuAu
	t1bErZx6A6sd2+ygjPx4hfBjzvftbAEN2P4EiaNZfGuDB3w0czbjUGxiwejqTy9mJgGbu3VpY0U
	+
X-Google-Smtp-Source: AGHT+IGiSfuRv3Y76uLW0YYRJRv2KJMhOadB6A35s9PgdU0SN6q4L74ZxSAPem4Amsho3fTWY8H25g==
X-Received: by 2002:a17:90a:a618:b0:29a:795:a132 with SMTP id c24-20020a17090aa61800b0029a0795a132mr99168pjq.18.1709249208246;
        Thu, 29 Feb 2024 15:26:48 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id sj5-20020a17090b2d8500b0029ad78306d8sm4245337pjb.3.2024.02.29.15.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:26:47 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rfpnY-00DJUd-1S;
	Fri, 01 Mar 2024 10:26:44 +1100
Date: Fri, 1 Mar 2024 10:26:44 +1100
From: Dave Chinner <david@fromorbit.com>
To: kunwu.chan@linux.dev
Cc: chandan.babu@oracle.com, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] xfs: use KMEM_CACHE() to create xfs_defer_pending cache
Message-ID: <ZeEStFZwMu068YTc@dread.disaster.area>
References: <20240229083342.1128686-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229083342.1128686-1-kunwu.chan@linux.dev>

On Thu, Feb 29, 2024 at 04:33:42PM +0800, kunwu.chan@linux.dev wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> 
> Use the KMEM_CACHE() macro instead of kmem_cache_create() to simplify
> the creation of SLAB caches when the default values are used.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  fs/xfs/libxfs/xfs_defer.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
> index 66a17910d021..6d957fcc17f2 100644
> --- a/fs/xfs/libxfs/xfs_defer.c
> +++ b/fs/xfs/libxfs/xfs_defer.c
> @@ -1143,9 +1143,7 @@ xfs_defer_resources_rele(
>  static inline int __init
>  xfs_defer_init_cache(void)
>  {
> -	xfs_defer_pending_cache = kmem_cache_create("xfs_defer_pending",
> -			sizeof(struct xfs_defer_pending),
> -			0, 0, NULL);
> +	xfs_defer_pending_cache = KMEM_CACHE(xfs_defer_pending, 0);
>  
>  	return xfs_defer_pending_cache != NULL ? 0 : -ENOMEM;
>  }

Please stop wasting our time by trying to make changes that have
already been rejected. I gave you good reasons last time for why we
aren't going to make this change in XFS, and now you've forced
Darrick to waste time repeating all those same reasons. You did not
respond to my review comments last time, and now you are posting
more patches that make the same rejected change.

PLease listen to the feedback you are given. Indeed, please respond
and acknowledge that you have read and understood the feedback you
have been given, otherwise I'll consider anything from this email
address as "just another annoying bot" and killfile it.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

