Return-Path: <linux-kernel+bounces-45293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB61E842E27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77530283F76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F8762D3;
	Tue, 30 Jan 2024 20:48:42 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A079DD0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647721; cv=none; b=kKmzkjVzI/bSoiDfK+j15PCs76T5VLkyDT5xOdWsAaoU+PKCNijHQJA3ULxnkt2bIYJq8jszFlHK/ekKEBEOa1ZSCH5cup3Gi1/X6mIaSb3/0Qs0R/sHcQDxaLKbzpO5x6XtZ3RieEZcMF/ZxxpVw7ZpFrzRmE7BmkwM4hF/Kjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647721; c=relaxed/simple;
	bh=lML9QmyIv+LUMOg/iT47sri/G1/loRasVQk342qZgN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJUnXpcW1P6ItUoRCC1PU0tUMbZ6b5JRaQPKXt47b+h5Y3+wBEPvGIzFkfALkz99jF6YvvLpT1sbqmja+14p3MqaQALHDtQxiQn8pIvkjBaihLktA8NrTE8AweE4WUiXnTs/g3YM52LE0qL1H0iEghIjNlosAV0ndG6FBjDp7VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42aa4a9d984so28857171cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706647719; x=1707252519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wxvZziXbUhtUP1Y9zXw54fZ6cDdnya/SKk+UDHGEFo=;
        b=Ief6lS+27ZskYkJL3wxt72IV3MHf8vGSbno7SeFtsuficRcG/Ep1w6b1Kib2a1PfcZ
         2IgyVFgU4GQyQPIttB3n2nOb/aafVGNQxsECosUaBUg2DHBKjGdDYiNoCF6jPDh1/2r4
         3jB3f7ZcwG75alTNzquCzG6PsAJzLsV2upbIZ4Jht1Gkq9eJGZE9z2rKSMAuUxqSbV76
         Eahh/SnKLVJCFjIcW89eLqHVEywdvJgvGiAwI3+2Ss5B5ndTpeOAHqeDmG08sx1fHjaX
         pUC2J313t+c59jzEh/zJKuZWuSwH67Q0t85iev7pkGhsuw+bi4ltXfO8HqqZixRiEjWJ
         JgTw==
X-Gm-Message-State: AOJu0YzYOLbJoAMlbdSvu43NW6cjZO2YCb6q/NEWCd/sdHCVSRs+dN85
	GW1Ofzxb0eFvphdEjCk1GT+joeOHBNJ4Q9mc/hx0WVvEZBAv4wkTCshUSQAxGQ==
X-Google-Smtp-Source: AGHT+IH5S9pyQeSM2K6WGjuq7LBNmUE3HoawjAO33JauM5M9qFYAUZROQj6Nk22MOXOq+8oUsCH3ng==
X-Received: by 2002:ac8:7f8a:0:b0:42a:b37f:4a75 with SMTP id z10-20020ac87f8a000000b0042ab37f4a75mr3021041qtj.16.1706647719211;
        Tue, 30 Jan 2024 12:48:39 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id x4-20020ac81204000000b00429bd898838sm4160126qti.47.2024.01.30.12.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:48:38 -0800 (PST)
Date: Tue, 30 Jan 2024 15:48:37 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/5] dm: dm-zoned: guard blkdev_zone_mgmt with noio
 scope
Message-ID: <ZblgpVdHZqPaq7xD@redhat.com>
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-2-ae3b7c8def61@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128-zonefs_nofs-v3-2-ae3b7c8def61@wdc.com>

On Mon, Jan 29 2024 at  2:52P -0500,
Johannes Thumshirn <johannes.thumshirn@wdc.com> wrote:

> Guard the calls to blkdev_zone_mgmt() with a memalloc_noio scope.
> This helps us getting rid of the GFP_NOIO argument to blkdev_zone_mgmt();
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

