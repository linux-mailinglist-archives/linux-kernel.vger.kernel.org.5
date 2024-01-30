Return-Path: <linux-kernel+bounces-45294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CAA842E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2969281C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710B1762DD;
	Tue, 30 Jan 2024 20:49:26 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CC971B32
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647766; cv=none; b=iN06EaJpFAAOty8TiC2npfaZ9Cx6sro8K1bDfD9ya0XoVxrHshi7zSD885XdJ/Gkm9IZh0lpFE3Ea4AGP8TvZwQpSgOWyAvO0ueB+DOLYiDXPVZuYZPykfhbb2JmoOHwa1ffqMIabvFIboJo+bj3/oP1gkPhW06O3cI4ShZFf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647766; c=relaxed/simple;
	bh=bS3zY4RD+CMpw9nf3G/9PKea3i0PDScm6HPQf3AhHgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaLRoSW+v/CV+hyOpPvGvgSGJti39iol518xze75YoxhKoOQPUh0Nwv815ZgBmE2J4jkKYUb8Yl81JpN87d1/Cxz8io33DdWswnuw8v4vF678kvs/nbuNWCBntzcba7YwPf/v+pw8FMLjQVZOub2+ziX6GdCgy12b/SQP2RCV8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68009cb4669so32878096d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706647763; x=1707252563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtZBEe426KIf/mBUMlvvoaF7jyFEZ9/COBSE2/txMLU=;
        b=Ww6SwMGexzZ73kGSQbe/YIkuYi4F/Zh0o9+v0kour6sVnvDun2B+y4xIeEIImnbrkp
         OeK+VsUdhmBHt9VEPx010U3puqXHelKKIuZisdLkT28venjIjDZiLCREpfRaYGlrCFB0
         55Ma7Exm4dyTSg0l/JhhJleOH8uUGMfWEClbjZSKCBo38jtg4dNXlUZyqMJjX1USbjg+
         vgmnXUTN5lkR1JWMqhYOf1L8ixYLwcYwpLmu2ucDePxlGi5vvVuMxmg6CsfZ+vvuVvvQ
         vnTEu/ROsczpaeKbz2nvsu70InJx2kylM+DZpjbhVK0kjBynllhKHSpkLknJv67PhOQ8
         P2aQ==
X-Gm-Message-State: AOJu0Yxz7/8krBiWOaJRmrbVLhS1TXsOZZE1DoQF8QDlUpo2njBTGBpq
	oaady+7bArT62ECBfW2g34DXXPcBYtmIWIjkn0BT+6B/qT1HnqSbVC5ZFVxOiw==
X-Google-Smtp-Source: AGHT+IExCJjqhy5J/HQbLwc6HEIv1PKoKFV6opMfTc/hdwP/PWAAPv9RfvTcXLRcTuNHUUdlDE2mNw==
X-Received: by 2002:a05:6214:f2c:b0:681:7d81:705b with SMTP id iw12-20020a0562140f2c00b006817d81705bmr615439qvb.4.1706647763522;
        Tue, 30 Jan 2024 12:49:23 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id of10-20020a056214434a00b0068c560eaf8fsm1688182qvb.134.2024.01.30.12.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:49:23 -0800 (PST)
Date: Tue, 30 Jan 2024 15:49:22 -0500
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
Subject: Re: [PATCH v3 5/5] block: remove gfp_flags from blkdev_zone_mgmt
Message-ID: <Zblg0qE25wPt-SRv@redhat.com>
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-5-ae3b7c8def61@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128-zonefs_nofs-v3-5-ae3b7c8def61@wdc.com>

On Mon, Jan 29 2024 at  2:52P -0500,
Johannes Thumshirn <johannes.thumshirn@wdc.com> wrote:

> Now that all callers pass in GFP_KERNEL to blkdev_zone_mgmt() and use
> memalloc_no{io,fs}_{save,restore}() to define the allocation scope, we can
> drop the gfp_mask parameter from blkdev_zone_mgmt() as well as
> blkdev_zone_reset_all() and blkdev_zone_reset_all_emulated().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

