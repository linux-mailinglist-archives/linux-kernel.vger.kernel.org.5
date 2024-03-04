Return-Path: <linux-kernel+bounces-91356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A765870FED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C66C4B243EE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408B87B3D8;
	Mon,  4 Mar 2024 22:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="nKE7NNwt"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260007BB15
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590541; cv=none; b=Bo7rT1+AGna0HS5UsIkDvIQHS7CJmsxt77qdZP/mYgqx17zf0LIV3uRKwoJB3Xu0kfUyEipqMt/aP6nzIi+1MMoAOQGK4iWY9yTNOpMqQSVDc0YJbiJdJCLZ+bzJKHYbEGLqhZx3iNXBYyw5xyx1D6Ljyd2zHvFTtS++dGtRU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590541; c=relaxed/simple;
	bh=rSGFobPyTkrtYOKrWnakciYsu5Thh2UHXGCu4vHBxx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSQLuyacsAXzjl0BB27HX75jHpbGZ3wbNXUrZTYu0qJA48RcwEbeqEwvxw2pg4M7GuG1sE5cLfHr9Pa1ymRVBj2CfgKY/Cpe2HM9WhzCXoexmusZcpLsZZLYPVyvs9KHZhuo9OqhCmj7uQj+PQ4rvq5icjaIksenLEqbN38cWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=nKE7NNwt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc5d0162bcso43097815ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 14:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709590539; x=1710195339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CARpH995S3Hk2OhajVVG/E9yFa4bHHeBmVGYbe1yvEM=;
        b=nKE7NNwtDebQIvzwuNHl5MXrTWR1UYwV5rImMRz1fx4XP2MDAGkd2QtFgsPkmI1Du+
         wXCtUsUKqskJFBoNfABQdyfii/cyc0e2lhvzqDeACTDNcUxB4rFIPDxRkHxlw4q/LBzE
         KEHIEjVZskCndd0JygzSttr8UDvQWtOlI662N2fVlVAxc1y7ZQf6H9WH4JHpXNQIVscU
         gBnbaIDCnr9enEdVG2l2qmplVGSy8wYbLigXTRwDwpA66xljxLSNE4ilcNSzcLbqqWzY
         6nB1h4GnI52/dzRdr88JxXAZtmYHZshYZuxeEhN6ppCduLyn0g1ncwOd/iZ6gF1IJYnh
         CPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709590539; x=1710195339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CARpH995S3Hk2OhajVVG/E9yFa4bHHeBmVGYbe1yvEM=;
        b=ntbSVMm98n1YmOX1YZpj26tMjRWrUcuEWxC8XXiyfaFE78MfFY4mmE9/B/0i6+eJgi
         8+1ImW/llAuJGtbs8jw9fwWlrblaDn0uLdGxRAR/2YJElE6x8QK514yHu/dhGjzJvHPs
         zl/WfFQxQ2fpIwauSYlsoapAOCHHpw1pKSDKzxdGHmcdMRdTkENRjagC2Te0iZIdY2hW
         L2AcaKmCc2lPC+RlP6iwVIIt43D3bvcESulqIiVwnwwxfF89fbrGSgZU4vgPO1VSdxtm
         WDx3V/m94QpvUka0UGo31iWxBNrDePip9jbT5xN8HA6SKiDLO/qtrQ+LM3hJhGW/B01U
         RcPg==
X-Forwarded-Encrypted: i=1; AJvYcCUEF8pXxxEyrPFct67ZWPF023YrZx/o6BmEE7wS0s2ct/GwVAnneNHIuOLwuLgDacA7oac3m1lbkAtAwtH7+zLryCuCtwzmLbzq6Ja4
X-Gm-Message-State: AOJu0YzMy44Yvn2tyYN6QA6OCmyREjX6ptHmAwss0DiMUUZGlkkDXKj9
	YpaMCkeRw6Jd3A+WoElSWyy4oHHtng3TCuN1xzwdh50PaSuGnkxi62SaShBRSAk=
X-Google-Smtp-Source: AGHT+IHjDF0RDc8u5rnaR/asbdM4SN8DQz/RLkAlmnt/uLBjLn0m2kj8Q8ebupgqkBNzu1lOIT8Y/Q==
X-Received: by 2002:a17:902:64c9:b0:1d9:f5dd:2480 with SMTP id y9-20020a17090264c900b001d9f5dd2480mr80144pli.54.1709590539370;
        Mon, 04 Mar 2024 14:15:39 -0800 (PST)
Received: from dread.disaster.area (pa49-181-192-230.pa.nsw.optusnet.com.au. [49.181.192.230])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902b28c00b001dc94fde843sm9007439plr.177.2024.03.04.14.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:15:38 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rhGat-00F5P7-2j;
	Tue, 05 Mar 2024 09:15:35 +1100
Date: Tue, 5 Mar 2024 09:15:35 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 02/14] fs: xfs: Don't use low-space allocator for
 alignment > 1
Message-ID: <ZeZIB0G3zjaq7dWK@dread.disaster.area>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304130428.13026-3-john.g.garry@oracle.com>

On Mon, Mar 04, 2024 at 01:04:16PM +0000, John Garry wrote:
> The low-space allocator doesn't honour the alignment requirement, so don't
> attempt to even use it (when we have an alignment requirement).
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index f362345467fa..60d100134280 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3584,6 +3584,10 @@ xfs_bmap_btalloc_low_space(
>  {
>  	int			error;
>  
> +	/* The allocator doesn't honour args->alignment */
> +	if (args->alignment > 1)
> +		return 0;

I think that's wrong.

The alignment argument here is purely a best effort consideration -
we ignore it several different allocation situations, not just low
space.

e.g. xfs_bmap_btalloc_at_eof() will try exact block
allocation regardless of whether an alignment parameter is set. It
will then fall back to stripe alignment if exact block fails.

If stripe aligned allocation fails, it will then set args->alignment
= 1 and try a full filesystem allocation scan without alignment.

And if that fails, then we finally get to the low space allocator
with args->alignment = 1 even though we might be trying to allocate
an aligned extent for an atomic IO....

IOWs, I think this indicates deeper surgery is needed to ensure
aligned allocations fail immediately and don't fall back to
unaligned allocations and set XFS_TRANS_LOW_MODE...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

