Return-Path: <linux-kernel+bounces-59337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACAD84F597
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BA61C21DCE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A83376FD;
	Fri,  9 Feb 2024 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KalGNxGo"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6322031E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707483972; cv=none; b=CbdDcVcC8Abd+FiGqm7frffX6D2Xj/ntAeDNT329dauh9/SYKzUafRtzzfqkKQyGwXHY4eztCfzXHNvxaSV2G7qK6a88oePduA94Cpy953FmoYjo4Z8bJg8hwO/oxWVd4qHk9O7EhH1/ZgnVGtL7WPEClsCeXfkoCmxBKRD+74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707483972; c=relaxed/simple;
	bh=D1I9C82K27EKrdSDWRrP1udXuSzgZmJRqnn1NoTF8yI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Zs/pa4xeNocUgItO5L6Iqr/o28LvCaTygXMY8iR9BN9BQVlHwf+P/bGQKQvfMHbRIuXM+kM5VThloOypuQshmLLhLmtznT6JaaY4yhAD02YjADAP4d2P6JQOZLrBNO/XQfkU4gwJiRSM30PeqkbgK2WcJMvKnFysMKFcYWErg0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KalGNxGo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a38392b9917so122854066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707483969; x=1708088769; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tLtEo1OKqwUWvTBgCakfkTG09kqUPK7D3C3/KQylNEw=;
        b=KalGNxGoV+JgDIrSFPgXwEOomKw+DsZhYjuJj5/pQbG6muODI8sohhrU1bacjmoAp6
         SWLxPu9ES0w3Kf5lFr5AVFczauaIIumxR03B40ZYpefuXC+oeVej07HVQPCe90AS1iDW
         8xdLxR+Ts4FuEywUfQVMaERmjvvswr6OPtIDNYAEOPNQNMuZ/J7z6PBy3qgFKrCc8Y8f
         CmU28SzcSW6RxZ9MSbL832Id8xjSndkEwTOMemJhMstOZv4bI8uV+n2wdWjNEsdolqdy
         UbJKJImcpiMVzw+vPXLoau9smhRixA1bUXXHOviJ9s9p/aNd0ylS3nscS20RKFXCcKGs
         w5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707483969; x=1708088769;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLtEo1OKqwUWvTBgCakfkTG09kqUPK7D3C3/KQylNEw=;
        b=aiwyreMPpnTPMS0UznUzO8Zl4AspXiV91BGr8IOMJNcXWFn8hUPwCzVlzm6GWJw0AB
         8KDBq3s5qrPTyhWpXycwk7dDNMCYQ4Pn08ktsd2Zw/yIE+z7rX8YxiWgZWEssDnE7Loh
         XjUBLKUVhYUnII77L9b6yRzrTAV4sSqbf5gyVSe6MoEZTAt4G/O17CxG2qGsU6sx38ME
         TQD+JmLYrTy/CrqFhFQm4I85EHP4CZ7OLVVIljX0tjoq2Ljo5TMMIJRQKfZUhk6VXnXX
         oGqColQVv8tNbADKAVCh3Drmt0oqiLzNkCAMRIbj4fT5KntVnkx1vv4ZQ2LN51wV6CR3
         ozFQ==
X-Gm-Message-State: AOJu0YwlmarBxFRxl0EfcQVfKepPO1zW9xtZGg+wPh5/zczKVzsA2ybv
	IpdRNGLfNomUBd3AqZ+BiEawRjmb10TK4Y9SzuWSZpORGaqaIkG7w11jEB7DqnU=
X-Google-Smtp-Source: AGHT+IEN5edzSFeEvjz3iI2J36XXz45v/QQzi6sVUlIxDFtjifYo68zTTErxjbxGObFqhdBgYmlXBQ==
X-Received: by 2002:a17:906:b354:b0:a3c:e45:4f3d with SMTP id cd20-20020a170906b35400b00a3c0e454f3dmr45052ejb.30.1707483969465;
        Fri, 09 Feb 2024 05:06:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmo+XQH+yrKac0XvIJqSlYVt9IIw1L+e7oFiTQgBGyl2mgIawunfVwRGwmw6/ipGW0YVjrQCPOK7+Tk0byAhSayncFaCNXgt5IAzyXNEcJTShLznj/7Hrl5mQWbVOXxtJXdokNuaY+5Z2k1CVZJ7B7V3WOAzm1GFKUWi82vm1arx/ksFuOz1Q=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3843b13729sm743753ejc.35.2024.02.09.05.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 05:06:09 -0800 (PST)
Date: Fri, 9 Feb 2024 16:06:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Sakai <msakai@redhat.com>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] dm vdo slab-depot: delete unnecessary check
Message-ID: <16ffd614-48a9-42b8-961d-2dc8a69c48d6@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This is a duplicate check so it can't be true.  Delete it.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/md/dm-vdo/slab-depot.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/md/dm-vdo/slab-depot.c b/drivers/md/dm-vdo/slab-depot.c
index 42126bd60242..2f4a2ae5e082 100644
--- a/drivers/md/dm-vdo/slab-depot.c
+++ b/drivers/md/dm-vdo/slab-depot.c
@@ -4100,9 +4100,6 @@ static int allocate_components(struct slab_depot *depot,
 		};
 	}
 
-	if (result != VDO_SUCCESS)
-		return result;
-
 	slab_count = vdo_compute_slab_count(depot->first_block, depot->last_block,
 					    depot->slab_size_shift);
 	if (thread_config->physical_zone_count > slab_count) {
-- 
2.43.0


