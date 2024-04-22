Return-Path: <linux-kernel+bounces-153989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 417438AD5B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B01B23C38
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C221553B6;
	Mon, 22 Apr 2024 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIuQVWze"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CEA153BE4;
	Mon, 22 Apr 2024 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816788; cv=none; b=UPyCGjQe4B/jJ+hW0VjVXl31pfopDWef3HjlQQE4PEAPPbhkzFBf0vIOs1vdjZBaFhapNqaiaZUNUN0OEqSNw9j28UQE95r+UdmcrD2+UnkVcjLLIrf6MATRmvioRrYicnBgIPN6nhErd5eRmWRan0LeqSGXeVX3TpfwccmnApk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816788; c=relaxed/simple;
	bh=9trJzoqp1C/EU6tuf4Zc2+jsosJ7oNQe6+hk5tkn1EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E82fncUUiwvp8Nsew3l0mLLdTFhYU2wrprjkN37z2ozBQt08zpZQS33/oTJBUBr6XOhzgZjgOJaFaCLxQY5UPB5ftNHpcgZkwGAQRIdOgbJaU6iReOe4VnwWE5RrzEA7DVQ7ZYY0TRMUjI/6BMUz0sIa37KK2FEcCFTxVvyC81k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIuQVWze; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5f034b4dcecso3096355a12.1;
        Mon, 22 Apr 2024 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713816786; x=1714421586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OH0RmiRnNNLPVffIpwhztH1e1woOXWUMr/11m8+KJYw=;
        b=nIuQVWzeWD3SzK6aHsRePPnWIgtgGiusx+gkRkWEVJm/KNXJi5yM3EyevPIFDU0O1G
         Qmcw3bvHJrcyey6gyDbWEbi3q3RpY2lReEZJcPUtTYVvH/iZ758mPMKn1y4lrFui12ya
         VIHs3SuNzrCI3seI4xm8G6FDgj7RZ5XLUQSrqKBafoRp3UacNMzM8nEtSHoKr6ZwX7Zm
         JgnHzGU7cHyzNBRGyO+8+AWmqIKfIPo4cQKmeDUDSqbEK0Ol5VBMUCgN1pwZzCP1NSYc
         zJKGYNU/gEY2CaayKTrR/atBcU1MIqwvJWE+bP+zawKvl0As8xty2h24RjXRmG5zzpK2
         780g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713816786; x=1714421586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OH0RmiRnNNLPVffIpwhztH1e1woOXWUMr/11m8+KJYw=;
        b=NK3Pevq4QMmkpcOP2q905ssn1vGr1rcx2PTQP2zbS6Nnru5WlDW6OINhdoX3sNjhbU
         0OlB7iFBxPki8AA4U6aD3UVHKCUjDpOJm086f+koQorhAPq7d5WiQgUbb5LDUcxAop/E
         XEvU1E9xWSc1lcHtXQJBJ94OlcgUHFgGIIl4yXoND6f21PnDP/O+cQe5Z/h3nWdhGffo
         gOglkrGfhZ+Exxb2YzRiZNKavoZRPNeckO+W4l9H/OalMrjXUabExDoUnnD++svGXbUw
         SlECh5NaL4ez3BrKLp4izBJfjDaIPqk3GXa5t7fAln1t0pUEr9VV7XTLUG3jGrHUZEyA
         4mAA==
X-Forwarded-Encrypted: i=1; AJvYcCWMLfH90awRSYPeVCiP+btyPu0ZkYxK1VUVXZq4XZEUEmYvBIV/CEXAv87ZHFVmHJmRFjxSfgsh1XG2ZnmESZIQ+j6kLChETgo84Q==
X-Gm-Message-State: AOJu0YxSEwesbKjnOnWd2h77moW9gNRPUkWHUKE+a4OjCF/qMOqC6K7c
	uOCiHurkVpnPNUvL5iywBQsiE2r0E/vwoel/QcnrIlcaLcx75d3I5W9QG7RX
X-Google-Smtp-Source: AGHT+IE/DQ0Znq3NPjPU6VifnotEYnZC10pQXDRij8KJ2HgbkrrBbdCK66nj003TpyJAGilgVR+YeQ==
X-Received: by 2002:a17:902:ce8d:b0:1e8:7906:5be3 with SMTP id f13-20020a170902ce8d00b001e879065be3mr905431plg.18.1713816786052;
        Mon, 22 Apr 2024 13:13:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id d10-20020a170903230a00b001e8b81de172sm6937448plh.262.2024.04.22.13.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:13:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 22 Apr 2024 10:13:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the workqueues tree
Message-ID: <ZibE0ORQaDK7RUzU@slm.duckdns.org>
References: <20240130133748.7c30d71f@canb.auug.org.au>
 <20240422094816.09cbdcc2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422094816.09cbdcc2@canb.auug.org.au>

Hello,

I applied the following patch to wq/for-6.10.

The offending line wasn't introduced recently tho. It goes way back.
5797b1c18919 just touches the surrounding lines. Maybe that triggered
something?

Thanks.
------ 8< ------
From 51da7f68edae38e81543d57fd71811f7481c0472 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 22 Apr 2024 10:03:13 -1000
Subject: [PATCH] workqueue: Use "@..." in function comment to describe
 variable length argument

Previously, it was using "remaining args" without leading "@" which isn't
valid. Let's follow snprintf()'s example and use "@...".

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/workqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 2df1188c0f96..fb3993894536 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -473,7 +473,7 @@ void workqueue_softirq_dead(unsigned int cpu);
  * @fmt: printf format for the name of the workqueue
  * @flags: WQ_* flags
  * @max_active: max in-flight work items, 0 for default
- * remaining args: args for @fmt
+ * @...: args for @fmt
  *
  * For a per-cpu workqueue, @max_active limits the number of in-flight work
  * items for each CPU. e.g. @max_active of 1 indicates that each CPU can be
-- 
2.44.0


