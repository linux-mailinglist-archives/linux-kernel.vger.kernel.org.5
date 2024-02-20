Return-Path: <linux-kernel+bounces-73651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08F585C57B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7676C284776
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9E114AD12;
	Tue, 20 Feb 2024 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdT+XJIf"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82A77656;
	Tue, 20 Feb 2024 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459546; cv=none; b=AUMg7vq4jOqLCB1SGc/dcAWNa6mtoYN+i3eQxIBXd9lXzkgYascT+Z6PBcNSmn1HO5JA0OclzB6vILHvnaU2IjTR0ojMgsj25NeCPZPOVfReTuCeGPmzIn38adMyfF1eQBUQt+VYY7UJSwkNKsK4XXeQJrR3OgzwuVOjceckSVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459546; c=relaxed/simple;
	bh=0TezNLJVdcLshluzbqu/T/BkOu7/M8fDbBUUIqa/jb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTUoW3JwQguugWvcwbVNlKZzkjOv6+6yddfqaFatW9fzVDDsLw4feOHGJW1rKEJFpqNlZhmKm2dxGTzWiOP3b4OjY6Rd6fF2Xy0qqpEl/acPRvDbIOnhEZsoyWP5N6mhWPYsyIywZDhCubftJrrdwtdPaP5evXRMX1xYzbTgD2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdT+XJIf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e457fab0e2so1446807b3a.0;
        Tue, 20 Feb 2024 12:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708459544; x=1709064344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gW7vTF8rfNG49dpSnGO33E9gPKbjVpE73uaPhoG4koU=;
        b=YdT+XJIf28doaeYvH/+zLfrVjH2v3Hk3UbNeYiHnTvod8/Mhofon9+YpK84o8aPW0M
         4nhnHCfW68qsfFa/SpF5nBFNrkymFFHRqqhd0zLzJod0ndtryRuNTFBSbA5TxXWn7Ql1
         jT2jxA1fs1EnkjsRk8Lu8i2oU448jsQ02QZL2jBy6fophdzQRh/UMOlRaJhsFaVxyRnY
         j+sSYBnaKrlJLeh3DAiHSz2o+9aQwWjJ4JOrjWKvbNVJUdWrs0+yL1nwK9SppmqXBYZ6
         cEcOkjmizAgSCrqI8FuCy8CyZlb6LWHRtLQ0VbpBBt/L3GK3DWCNC/PDv69XK74OPfh8
         dPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708459544; x=1709064344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gW7vTF8rfNG49dpSnGO33E9gPKbjVpE73uaPhoG4koU=;
        b=pKhsj5LU7xXHn0P+S5SyhAzVew+2JDd4ZJQzvh485axSzTSR8i7JHo6SwFnwef2s+T
         XzHlGhM00l0VeGZee8eA000lUs5i4r+leWIBRyheTn6ZBhbm99WENKHrqBsspy+XiIx2
         9quKGNHrZNQKJiZgJSKL3MQAmEBuqKQGL/DzgKaZgjrn/L8WTxSRJz+IjCwjVjd1XA1Y
         KQoD4aqmxGbA3/nwC0j0VNAoXuJ2FlgM3IOrnfjztjRO42Obuzg9DLR5+ZKPd0vIUa1J
         HxxlyEyi47qmWBo1cysw/KrWvisIly9FG0w2GDOpgWLxLtVyFhgWHVwn0j/6ZiKAfWo7
         Wvdw==
X-Forwarded-Encrypted: i=1; AJvYcCWJKapHy9z8N9XwoTBzhxJeS2btCphWdwsheBWunTe+5mTkKQuATAs560Xkb9cWZ69If9xSrRJIrKa89FJjg8smynw6qNWfNiBFM90fqyV20wTkAyPFTW4snSK4JDAzGr9JWx2C
X-Gm-Message-State: AOJu0Yyr6emtFTeMcVUkitgFgaMvbFERoTtkMjUlWpAEuQIFQy7Mpy0y
	DotbSymIocX9eJgiPeVLEcD8KxSTeDS65oqDOJz1A+hPQPiGxhXR
X-Google-Smtp-Source: AGHT+IEFpe+TQnBO6E2Zo9LcH0NoW7qj2OoD0B8VMDIQsbL3NhuZGX/D86CD8PdMSwC3kb5ysijS/A==
X-Received: by 2002:a05:6a00:93a5:b0:6e4:69ea:1f6d with SMTP id ka37-20020a056a0093a500b006e469ea1f6dmr6952335pfb.5.1708459543718;
        Tue, 20 Feb 2024 12:05:43 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id s12-20020aa7828c000000b006e0651ec05csm7283639pfm.43.2024.02.20.12.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 12:05:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 20 Feb 2024 10:05:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mikulas Patocka <mpatocka@redhat.com>, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, msnitzer@redhat.com, ignat@cloudflare.com,
	damien.lemoal@wdc.com, bob.liu@oracle.com, houtao1@huawei.com,
	peterz@infradead.org, mingo@kernel.org, netdev@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com,
	Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 8/8] dm-verity: Convert from tasklet to BH workqueue
Message-ID: <ZdUGFqLCpWez42Js@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-9-tj@kernel.org>
 <c2539f87-b4fe-ac7d-64d9-cbf8db929c7@redhat.com>
 <Zbq8cE3Y2ZL6dl8r@slm.duckdns.org>
 <CAHk-=wjMz_1mb+WJsPhfp5VBNrM=o8f-x2=6UW2eK5n4DHff9g@mail.gmail.com>
 <ZbrgCPEolPJNfg1x@slm.duckdns.org>
 <ZbrjhJFMttj8lh3X@redhat.com>
 <ZdUBHQQEN5-9AHBe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdUBHQQEN5-9AHBe@redhat.com>

Hello, Mike.

On Tue, Feb 20, 2024 at 02:44:29PM -0500, Mike Snitzer wrote:
> I'm not sure where things stand with the 6.9 workqueue changes to add
> BH workqueue.  I had a look at your various branches and I'm not
> seeing where you might have staged any conversion patches (like this
> dm-verity one).

Yeah, the branch is for-6.9-bh-conversions in the wq tree but I haven't
queued the DM patches yet. Wanted to make sure the perf signal from TCP
conversion is okay first. FWIW, while Eric still has concerns, the initial
test didn't show any appreciable regression with production memcache
workload on our side.

> I just staged various unrelated dm-verity and dm-crypt 6.8 fixes from
> Mikulas that I'll be sending to Linus later this week (for v6.8-rc6).
> Those changes required rebasing 'dm-6.9' because of conflicts, here is
> the dm-6.9 branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-6.9
> 
> So we'll definitely need to rebase your changes on dm-6.9 to convert
> dm-crypt and dm-verity over to your BH workqueue.  Are you OK with
> doing that or would you prefer I merge some 6.9 workqueue branch that
> you have into dm-6.9? And then Mikulas and I work to make the required
> DM target conversion changes?

Oh, if you don't mind, it'd be best if you could pull wq/for-6.9 into dm-6.9
and do the conversions there.

Thank you.

-- 
tejun

