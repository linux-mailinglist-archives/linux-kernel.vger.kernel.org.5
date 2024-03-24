Return-Path: <linux-kernel+bounces-112874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27803887F51
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60AF2816D2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F16C3E468;
	Sun, 24 Mar 2024 21:57:35 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A713D963
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711317454; cv=none; b=pI0Djj1Hw+XeEk1yivps/JY1wlfT2C4xregNcxkssah7VYf4FxyReFL/1ci2D6qBtIPurreTddMxOjyzL5cZCW1uwXYA68qSoxT9PTk5fHddnPbh2TOVu+L3wh3W5c2Fta8/LExUIAPkICKdpYky96a9YuaK0LD3jTm1+Dwi+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711317454; c=relaxed/simple;
	bh=BOkYCK2qQtPHq4L14VfaTwZ/r9VLhpWaboZSzmJjo0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnUK64fW/z8eDp+eAduc/4B/fU/rRuC83RF+HKDOUF/u7ka13ZUpfw7XJklZE+BgmFYNMAbt2aMInQTQDLXP989wxD79bv35nIEjXq1K2eSm8s5b0fQlAShVPqpvogbZVtUnpLmf2ITQWePyC1/dMrpafGxewrjl9RozWk/KHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78a4708a557so98746385a.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711317452; x=1711922252;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aW1uYlxzmK0CTtcm9QtkmtxOoxLLB7jXV7c/ndwCr2g=;
        b=Tp/+SmF/tM3xUHzKpRBhr9SYV5TFmXwwktYqSHb2pvFf6AGtsKvXtFndFl7eZ6E1Xl
         XkpXF7Uhiya4jTyPBAJtDZ6vmJ+B4Lcy6X92vRRE0uxerwggMeHG0H0X/lbome33TrYM
         2DF+DCpevHmAy+qLUifv7OWWbVJpcLRiNfsXOzn/dmk0ZzYfGgzD2h45efhFQrgc0X83
         GS6uNyZEmwDEk/ObamTvz2j3rYOIFk4yh2iFMWvKA5L+GZ+XJYk+1Na+UvEXjeNZzwpR
         13u0gxA/Kvz6lBuWpVOVups/ufhxmCxy+8LgE8H34HF5Lf22zkoDN+iMUAkIsTOrbkZF
         TBcg==
X-Forwarded-Encrypted: i=1; AJvYcCVL24GE2NKQvCb6lhYCTwBgvF7F8R3ZIlZYHEvwBdl3UNRGctG4GjrkZlpPh9tph2HCTq0Ntv0dNkaqBaatfDUTjU8eACepL+BubBjN
X-Gm-Message-State: AOJu0YwTxE6OI6KzwnU24rnqtqFAK9aIR3nTh+zWFY0/XbxFvfUAJ3yl
	1v+3OskL/19NlkYYqAxCh+MBJX3zcaunJJC5uIGiGR0i/M2G1iYuNom8l+C2kE4qlCVZ/L0DhZs
	=
X-Google-Smtp-Source: AGHT+IGGMBnbwmlHZ1ViBESOWV4M56q0VRQdJ2XXd4ey16lzyfQzewIYJf/bLSJRR3q4cCsSThMoSQ==
X-Received: by 2002:ad4:5aaf:0:b0:696:3e05:9c21 with SMTP id u15-20020ad45aaf000000b006963e059c21mr7295157qvg.18.1711317451878;
        Sun, 24 Mar 2024 14:57:31 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id h14-20020a0562140dae00b00691732938a8sm3410147qvh.73.2024.03.24.14.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 14:57:31 -0700 (PDT)
Date: Sun, 24 Mar 2024 17:57:30 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org, axboe@kernel.dk,
	mpatocka@redhat.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/2] block: remove blk_mq_in_flight() and
 blk_mq_in_flight_rw()
Message-ID: <ZgChym1BEpxUm_bL@redhat.com>
References: <20240323035959.1397382-1-yukuai1@huaweicloud.com>
 <20240323035959.1397382-3-yukuai1@huaweicloud.com>
 <Zf79w4Ip3fzSMCWh@redhat.com>
 <abb0af09-e9bb-4781-176b-b4b98726c211@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abb0af09-e9bb-4781-176b-b4b98726c211@huaweicloud.com>

On Sat, Mar 23 2024 at 10:11P -0400,
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> Hi,
> 
> 在 2024/03/24 0:05, Mike Snitzer 写道:
> > On Fri, Mar 22 2024 at 11:59P -0400,
> > Yu Kuai <yukuai1@huaweicloud.com> wrote:
> > 
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > Now that blk-mq also use per_cpu counter to trace inflight as bio-based
> > > device, they can be replaced by part_in_flight() and part_in_flight_rw()
> > > directly.
> > 
> > Please reference the commit that enabled this, e.g.:
> > 
> > With commit XXXXX ("commit subject") blk-mq was updated to use per_cpu
> > counters to track inflight IO same as bio-based devices, so replace
> > blk_mq_in_flight* with part_in_flight() and part_in_flight_rw()
> > accordingly.
> 
> Patch 1 in this set do this, so there is no commit xxx yet.
> 
> Thanks,
> Kuai

Would've helped if I looked at 1/2, but please say:

With the previous commit blk-mq was updated to use per_cpu ...

