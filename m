Return-Path: <linux-kernel+bounces-64326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD405853D18
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A2728DEBD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CE46350E;
	Tue, 13 Feb 2024 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="muUHpyeB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D4A634FB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707859169; cv=none; b=gEt1I0l290S85FIvCODf4Ufqo4SdQKdGnHk3kEr33IAWrWPHZlHeQrxbNArT7Fx6F2MC1qYP2Ciq4rNijf29lIAJG7KCvbkqFjOfkEf9AVvZfULzHnPSSPxwd+HvlRvi8fLHp1WTaYP2GnVBa4JrnUtekEbsTlDukthbjfPYKC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707859169; c=relaxed/simple;
	bh=u+37GdGC/RFOsezdEzqNgPOn7MJSkWmd3LKNGiI80J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhaN88LwyLb1y5WEyHP3z3s4QY5wz29Ll5ZaDL++hqKwR2lcQ1Y17E11BIfvAMZPQ1qQuXnvchbJTNuO6RltK1EL+vobzfXN/6Jq5fyTerDcLsO8nIywTgQbAIVxFyHwEkReM1A8oPVPKhWM3EWuO0aGIaaqwddDrqNQJ5IrATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=muUHpyeB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d95d67ff45so35794805ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707859166; x=1708463966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gewUBLZJkZ832bNkMemwPNuP6AjEYnwmsKdeIxmXvlI=;
        b=muUHpyeBf1KIuKy4jG193Pg6QL2rXVjfMpLAi11TuNtxp/i+odCs4Bk+pTRQ4rTg8g
         ZpklTrmKbPMZglwk9ylLhWFypJSWszxfohmsFJBqFtWo5ybO+tjVQ3d5hSyJgl14C55O
         wvvTf3EZJG2OS/gQjFfGZZU7fZoHkLHwvFdsQKS4cok0IBeWFYWU7X4Or2i8uS3NTd+r
         Y8Q1RCy3aP4IjYhWyI/JeBxF16hBbJpVqCbevQrOHnGJBnZXMKOSS5HITHSI+6KinZ/M
         pvfNhHTnkTZ50s2WaQs/os0ab3TpObwgSZ8mkbkLg4XXagTE1W4NnfwPkVVcEYNIii6Q
         gsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707859166; x=1708463966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gewUBLZJkZ832bNkMemwPNuP6AjEYnwmsKdeIxmXvlI=;
        b=ZVLobe+IdN07VxO8WLAWuyLaWoVBT3zcRK7Gxhz43XlzRytEjZoLvr0nBHE2XSdqr2
         enQWmS4vXJUs48RRIid07UXtpAjLs0ucW0+puYBaRsMLPV3vKt1CEj0ZUXA9B3CPnHEi
         gkDAKX5EH15qKfl4bfRKWRauYxDjnkP6YlTLVVGIvha9sTkPg15XmVrWUnGMFNdSHqt9
         Zofz+Ra/o8F/qsY2OF2nQzQ2WY5nOUpocLp/rR3/lit9yTWBXfMx/k7IBzN0UMT0MdUM
         3SMNuJ5kppFYu0GDQg4JaTFIL3jrn/aE2wZtNTDD+nB7OReGd/YQEQteVPaeb5ilkdui
         mq7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXXhZMlG8VofVi06btP2/l8g5t5WPB59x+QF3aK6j9UTTGCGeOqZlkE9mAOTTiTL2q8ciZLd7yj66IsmkWzNN9SxQir0zbZaFHkr0Z
X-Gm-Message-State: AOJu0Yw/Ysxu98JuC2QkgNXO6mgvI/iX7ARs/D5m5GRjlfNNKO2JRYV3
	o2vP/PPDAmIPO8WY4KUg6SDUYNuDzvt/8O13jNydSM0S4ymEGCgsYK1bw2p5SC4=
X-Google-Smtp-Source: AGHT+IGLUSZXB3ylBDOhdlT0T3KZyXplzyMRS717PUcEqeBADrUjMdBE30QvnJ3A0SsgCKfJuXzdRA==
X-Received: by 2002:a17:902:7c90:b0:1d8:e4b8:95e5 with SMTP id y16-20020a1709027c9000b001d8e4b895e5mr735185pll.32.1707859166637;
        Tue, 13 Feb 2024 13:19:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWO0TbDjhh/ndSsZJYVcwjhjhY0VK36KvnOtetues9rvO72mKN9S6yrohbe5HpmsHReSYH//kgA3cLVZxJSMxKOBS/2qAwhj/Ve3rjcJb72MNFOXoUbYL/1CHTiHPkUj3x8m/33hM3Sh4vq1BII/6HK8bXM3Mc+Yi72mVEPrASerHOqghSCpuXChXE6/J76YAtOSgKQzIE87VSXT8enpMMaMSj+ozTtytuBa4adQH6IY58agY4JRs+hnLXJzLmsg0ygeU0Hb0UpvuBuGvaPYhTsC2dXedD1qO8CynIO3MzKF6GndNboo1QM78YmrQ8do/9qEnP5vdEp/v481jEju4juRSj8dnYazah1MlNqE9Axz1VtwYEiLPIwFr1EaSFkyDujAUTN2jw/42pr6bDcyywOqMSEwl6dTczNiRo=
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001d8e5a3be8asm2466833pld.259.2024.02.13.13.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:19:26 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1ra0BX-0066dX-0Y;
	Wed, 14 Feb 2024 08:19:23 +1100
Date: Wed, 14 Feb 2024 08:19:23 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com,
	p.raghav@samsung.com, linux-kernel@vger.kernel.org, hare@suse.de,
	willy@infradead.org, linux-mm@kvack.org
Subject: Re: [RFC v2 13/14] xfs: add an experimental CONFIG_XFS_LBS option
Message-ID: <Zcvc20gqm6U6xaD0@dread.disaster.area>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-14-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093713.1753368-14-kernel@pankajraghav.com>

On Tue, Feb 13, 2024 at 10:37:12AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Add an experimental CONFIG_XFS_LBS option to enable LBS support in XFS.
> Retain the ASSERT for PAGE_SHIFT if CONFIG_XFS_LBS is not enabled.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

NAK.

There it no reason for this existing - the same code is run
regardless of the state of this config variable just with a
difference in min folio order. All it does is increase the test
matrix arbitrarily - now we have two kernel configs we have to test
and there's no good reason for doing that.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

