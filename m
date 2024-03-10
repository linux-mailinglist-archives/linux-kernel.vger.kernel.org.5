Return-Path: <linux-kernel+bounces-98324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B80EB87786B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47FF9B20CE1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FF73A268;
	Sun, 10 Mar 2024 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+C7r9KK"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABFE3A1A1
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710102150; cv=none; b=bvtDiWreXXiM1D/iqQ176bPn98zc0ia5566G3Mj9Z+gpC/2DX1uCkhQZRq8JjGYBjg7zKL9Jwju+0CcI8GEsSWtuNxVd7mU/Cmxzxf7nxBuQtSvCBKB0An/+yJBD8/f/Dlk2d35S9qJrcd2gXmEomnQJGzFBrA9UBFGIQ8FxoFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710102150; c=relaxed/simple;
	bh=5GLYdRBXYaPayInyNzyZCfA3bU2rYudYy1uIlup/UBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhVOqzJFJN5w0bknMsoY/GCgcHBTWfoJLTRHJvvAQMNeFin/+wU6jU4g/cxlT80owzSwpLzOsLR6cglj8L3VrnVegBDGZaOfgqo1qs+YpKs4Qv2E6skjybOROa0jS+C1dgcrESQdfEgsf07r+o3mud7H1bB95b4oOxaxS1EQS0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+C7r9KK; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1ea5b42e7so1459424b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 13:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710102148; x=1710706948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W5AZLhIKNippDeEefLWNHHg2oZa7XZ4n3TMBlTllJs0=;
        b=N+C7r9KK0ZRYCQqCUpCyxfHBfKWnmZVpK/h7Vo2BGgWlHqNhLInpsTxrJDkkpcyIs3
         qhoeiOH47zknskUiMOCigLNZhnsK3iOFUMOz6XAbm1h+BAzGEf3hK52AlDZYHQvbrzD+
         0zk/ENqL5F8ZuDRVM6ktv9WShMxXyK2USYLLnzvLLffCCVdlE0hW1rgrS6sQaXxVC4h4
         1kakuzae96T5DbDDDg7dBUc/QtJ4IQXmHtaTRX4X5XIJgkHWWBxj/tQwQNcit52bYEk2
         yfuB38G2++g5QNFsKaXeN0IrnF5uWUHgWIMQkkz9Oyxqa9ROV1vRKCrhVOWFlPt2/CL2
         Kt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710102148; x=1710706948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5AZLhIKNippDeEefLWNHHg2oZa7XZ4n3TMBlTllJs0=;
        b=v7jBNXtMCAhtRdotPT6e8wCSDiUNC1pLsqlBgj5iT7y6yr6TdbdESfhdYKS1BtksON
         tGw+10K0kRCZci4C5Bm+Jk03te0vr7NhMeAebvKSclV5m62u9C9JM9ZWlgMPK3Ibi7sG
         BX1dAcDtrBviZmeqpzuHmj6jLVWzqJ4hQAXlJnb1drjTjxdOK2CsI5weewK/CVusfRnT
         UUkFSTKmipAV368xIJboeRwHLDUTmPvwBqLvJsoGt/u7/553a6bQrEAQ2Xv31Iq6luuq
         nNB63fP5XpEmdvLDl0/xpBZxZJikdKMBGMQ3Ld9pKwrU2W+0AVIILVm44zzAH8JTq0to
         EBpA==
X-Forwarded-Encrypted: i=1; AJvYcCXrZ9WGL9oAQxNYg6EnyGyNhfBsUDa/Tnc+Xzpi+N+0xtesgTWoR7XvsSR25G+RV9poC4Zri4QKFjogLI1o22Rdcv8/7hexX85yGnFp
X-Gm-Message-State: AOJu0Yx8m3J397+9w3e8IxgJl7EDUoelWwPg30SKUQEW05PrOc2AA3Ja
	1P/F5dKOUQpxTBwfLItKl2b1IsAGa1MYpWOo7dUBnrVQmgMenECQeaYt7YTqzg==
X-Google-Smtp-Source: AGHT+IFg1GfHhAkHASKD+D3gSfJN7aBpfcaxljlZLX0vDpnI/Sqgb3HZDTICFWAA61tEVe6yGCDrCQ==
X-Received: by 2002:a05:6808:21a9:b0:3c1:effd:726f with SMTP id be41-20020a05680821a900b003c1effd726fmr6643959oib.43.1710102148130;
        Sun, 10 Mar 2024 13:22:28 -0700 (PDT)
Received: from google.com ([2620:15c:2c5:13:d1de:e5bb:fcf:1314])
        by smtp.gmail.com with ESMTPSA id j25-20020aa78019000000b006e2301e702fsm2848532pfi.125.2024.03.10.13.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 13:22:27 -0700 (PDT)
Date: Sun, 10 Mar 2024 13:22:23 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: John Garry <john.g.garry@oracle.com>
Cc: jejb@linux.ibm.com, martin.petersen@oracle.com,
	chenxiang66@hisilicon.com, jinpu.wang@cloud.ionos.com,
	artur.paszkiewicz@intel.com, yanaijie@huawei.com,
	dlemoal@kernel.org, cassel@kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] scsi: aic94xx: Use LIBSAS_SHT_BASE
Message-ID: <Ze4Wf2Cw52ZXQxJV@google.com>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
 <20240308114339.1340549-5-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308114339.1340549-5-john.g.garry@oracle.com>

On Fri, Mar 08, 2024 at 11:43:37AM +0000, John Garry wrote:
> Use standard template for scsi_host_template structure to reduce
> duplication.
> 
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  drivers/scsi/aic94xx/aic94xx_init.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor

