Return-Path: <linux-kernel+bounces-41671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 459C583F62E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36C0282456
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129CE25773;
	Sun, 28 Jan 2024 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="P/QQdRSd"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E452C24214
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706457145; cv=none; b=k/slR2+82u82Josv36L4xIdavbYbDl7o4aFzoccD1EOi4NKiZBGmFdnrkmQ8o1x5BykjqOrTzPJv0g9Us7ZAxFi1rgehcXNiAYssov/jpmkN+Nq1E0kAJpHxX83kL3S3Yt4pP/ldKZA+OSs5Ll59zdB5IABHuF7HhGgIE1TMh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706457145; c=relaxed/simple;
	bh=6/GwWArs03dM8kHet8ssnePwsOiKDu4GIU+4Sx5AQfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pavLwlSFZlAS3IzeH/qe+A18nJxseb4WeCJr3g4za4asg0gpBDOgSCSiuWAqMPBXRIyp7qxe91lQBBaf+y8coWHlWH5HgLKyXiCb9c9JhBlp/nbZN0ordQBjg8NOQIYpGeoM7MI5NEVHh2JMIr9SxfBT4m1cdK7MNxbXypy2dbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=P/QQdRSd; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42a35c720b8so13737631cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 07:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706457140; x=1707061940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hmwam5A1aWEjCpVOYcrw8L5g1crjLSprXNSn1UxQ0Rc=;
        b=P/QQdRSdR8+g8aBK9dQy9xqyMHgwGtT8D3jQKSzwwqSL9/gWF6Kd3DSAlyPu3TKX3q
         6IV0gwFEFo0qamxBYdKLSlfHuRmuOh+9P4ma3FvENG31v1D+bcfax29IYxs+PXiyNS02
         Rrpn2u3lwjZrjG5DBX/Ux83EH+PtbTM2EUxK86Cvor+8hvzJejbIG/O8kQVBNlwgJ13P
         wX8AJdkYG4OqeBhrCutLwRaMDbiDgijxoyXI1wK5nymIEsOE4OoNYXvXr+Fnk2QOdUY1
         BaH7FLy484hNN6qmYZDB/Ev/4elb0FQRxh8348JcF0ZqyauHEZz4tV4vZLY3+BXoVHuu
         yDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706457140; x=1707061940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hmwam5A1aWEjCpVOYcrw8L5g1crjLSprXNSn1UxQ0Rc=;
        b=qcyRCA0XSJF9f4RiG97B46iNk5dhEsk26Ck77RbHpf5yRlyl4cDT9ABhIGyyhCNn45
         PuVHvIUWivbstFk5RmtkKDZYCFu4lvCsOVe9lbpa4ONR/KubISL8u1XMMzVbCAJbGWKG
         DEN+vB+YUHwvQlw99m2N51vg+K7qtMMY/dSAKZ3rxkOuWlexXHrxln0pmrvE9IIivXQT
         63LLk9UMQ3rmCSc7WXOeCvG/EQX6faA1jvBcpYFQPZSfgMxtblejvLJsCArbxyLqUn6g
         9Hl2EVBbKzmLCrZZlH6zGquMqJtYNLRtcc0UZjVEFOH4niIrzewlnA7iN7QV3LvzV2YA
         I0IQ==
X-Gm-Message-State: AOJu0YxRYcBkymyrjJ2V1ThccgpGNuAfq55O8J64s8VHO7iLU6j/ohzD
	raquwMqDN551pjEOXARwJkDdEaFEIHuLSvzrxxQNk8nnntQn/sH294Fc6j2U3yQ=
X-Google-Smtp-Source: AGHT+IGKG6888HXOQ+dC+iDyzFMolaR7r39UNQTZfh6xyvg92x9HinieTKotXvW+l6sg4D7Ase98mQ==
X-Received: by 2002:ac8:57c9:0:b0:42a:3ca8:910f with SMTP id w9-20020ac857c9000000b0042a3ca8910fmr3384689qta.39.1706457140552;
        Sun, 28 Jan 2024 07:52:20 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id hb6-20020a05622a2b4600b0042a0fa8bbe9sm2660527qtb.22.2024.01.28.07.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 07:52:20 -0800 (PST)
Date: Sun, 28 Jan 2024 10:52:19 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chriscli@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] mm/list_lru: remove list_lru_putback()
Message-ID: <20240128155219.GA174688@cmpxchg.org>
References: <20240126-zswap-writeback-race-v2-0-b10479847099@bytedance.com>
 <20240126-zswap-writeback-race-v2-3-b10479847099@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-zswap-writeback-race-v2-3-b10479847099@bytedance.com>

On Sun, Jan 28, 2024 at 01:28:51PM +0000, Chengming Zhou wrote:
> Since the only user zswap_lru_putback() has gone, remove
> list_lru_putback() too.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

