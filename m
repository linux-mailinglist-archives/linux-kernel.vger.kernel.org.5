Return-Path: <linux-kernel+bounces-112400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BDC88794F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D8CDB215DD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42814087A;
	Sat, 23 Mar 2024 16:05:27 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F06405FB
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711209927; cv=none; b=iWjmKRmOA26iTGstJoUt/1MCzSAASRwEvzwncuIeXuzEj90oIGuh5Sz4xc5GolCDm6nTzPhyh1/C0DNIaW5maQH7rfrgQMWdACqK6soDr6BXDtXxk8pfql5kdZSG3X9Ot3fP9vGKSNEJByM2xm8gINgAdEVOk/irpbIxokQGPLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711209927; c=relaxed/simple;
	bh=UTIcrrwXNx/qWXkxlQfJF7yP5zzW0DBI70wtwcfgnt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERIm8UxIdgxBti0+NQgwsL8Lu+AVHzev3H5MbmhaCNypvWb+NaPO5/XLme+2MAqWJ1Cdt5KurZcSN6BN6zFZS1b6NdLlJWpOXBSuFMB+hu/MNjieTJMLacQY3qfyrmIgjFH13lC2rt38hRTFl7D38vMwQMUf5CCYD23ujylM5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69674639df2so7889626d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 09:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711209924; x=1711814724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwgP8PLLhEZ4I/JPIIVutoqihwAKeS31/sLLIs4EdsA=;
        b=iWLqAEF3of/me7RAQeMBazPW64BgnMEFZG9/mmb3k6OKQiu1k4zPL6jeb79t+HGEg0
         iH6oIPG9H/goh/NYzC/n8Q95JKSaAX2Fw3QwHtFW3cwTl/JDaCDPOE/tsfmvG7Ny0VpI
         YknUvtFmqHce4+fjhR/YCs5NK929I1xi0+sXq5mFU1ebg0fbWmyDRdZNKqXdDgV1Zv0h
         WaTMiYjFMF2z88rObm+VdIcy2Q4V0SgelWDEas5F5C858vpgkpcX6VBG/bZezGjlmxUs
         H9HQXitdcZ+GSspgpLlRh36ooDE/geOs2GmTLEmv/Tqxuz7wFaskJ47RILQw14twdWGy
         vw/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlYwSrYFQ2s5x8VV8WNXAh5KNdwyCVHwwW9ZTx3ZsEhiZDm1AnS+H9dOSoVMEzKm4cPsOy3QofNaud/wlBuWl7STRLho76XeRUnXrp
X-Gm-Message-State: AOJu0YxTKUyeBGK+VwN8i7K6BimA7kdWS49F9GuHOgWUTcpZZ+LVbTp3
	tdNH/CpKrw/JYt70MvYKjE7go7/4rpWBvGxApMqkCmY8w0KYjzAFngCgmDJCGQ==
X-Google-Smtp-Source: AGHT+IEshk/dc6HBbutRsVAeN/yLgWxtrdsdReob4esfZAV/w/UrsUWSizBnvhEbX0jZww+wWyWm2A==
X-Received: by 2002:ad4:4ea8:0:b0:691:1fcc:e26d with SMTP id ed8-20020ad44ea8000000b006911fcce26dmr2460772qvb.31.1711209924582;
        Sat, 23 Mar 2024 09:05:24 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id jr9-20020a0562142a8900b0069186a078b3sm2170108qvb.143.2024.03.23.09.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 09:05:24 -0700 (PDT)
Date: Sat, 23 Mar 2024 12:05:23 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org, axboe@kernel.dk,
	mpatocka@redhat.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 2/2] block: remove blk_mq_in_flight() and
 blk_mq_in_flight_rw()
Message-ID: <Zf79w4Ip3fzSMCWh@redhat.com>
References: <20240323035959.1397382-1-yukuai1@huaweicloud.com>
 <20240323035959.1397382-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323035959.1397382-3-yukuai1@huaweicloud.com>

On Fri, Mar 22 2024 at 11:59P -0400,
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that blk-mq also use per_cpu counter to trace inflight as bio-based
> device, they can be replaced by part_in_flight() and part_in_flight_rw()
> directly.

Please reference the commit that enabled this, e.g.:

With commit XXXXX ("commit subject") blk-mq was updated to use per_cpu
counters to track inflight IO same as bio-based devices, so replace
blk_mq_in_flight* with part_in_flight() and part_in_flight_rw()
accordingly.

(I'm not seeing the commit in question, but I only took a quick look).

Mike

