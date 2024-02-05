Return-Path: <linux-kernel+bounces-54109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF04784AAEA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6387B289C06
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE8C4C3D6;
	Mon,  5 Feb 2024 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deCfnlkG"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5925948CF2;
	Mon,  5 Feb 2024 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707177514; cv=none; b=meDH2kb/3E3OGYy9HvFFJhWrmjG+MXgE0cY9d2+fTp3Ps8/3nivrX0uEkJvRDm2z4rGTR3ra/GBlft50vopFQ97Jl6BvLFMjBnYF433xsOHHV6Z7wQvDXWXaD+mlaXQzcIP/4e9JqRUqjXwgYRy3Zw4SP+fruxkO2k61DNJ3z9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707177514; c=relaxed/simple;
	bh=93QXxafaVw5XvGO/nunfJv/0a5KfZBxmrHdx1Ptzq+M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jWA44upCpvLWN8B0VGGdLZRla6Y0cZfljYu1LIZ/nKOT6ZShNHVssDQCJymCFnagBzAcsu9A6aW0xe7etAmxlOHU1UBAP5KwV5nWwynGA/WR2nbwPlNP7jc+XAce9JJIoNm+bjQVrwmGEhSBsFY+/YGCxEwbYJlt4G6KXYBiAT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deCfnlkG; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-20503dc09adso3388107fac.2;
        Mon, 05 Feb 2024 15:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707177511; x=1707782311; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LtaKsqfpcyHuWJPjZvPw/ChfmsDTwQtI/UDfAaWKaM8=;
        b=deCfnlkGvThZXSSrL/+2e4zxvV0ZNfCMEGIRpUSktFvbHNrzUdEkq35lORhND5LRQr
         LS2fP63cddgZoUxIaUSvh2fQ5YiSV2skMoyEaesDCnmaSomClXH21yFuMAoZvNSI5iCt
         6bRz5nO8KtL1duQniFQfhbEEY6oPz6mSrceV4uBR+5HqUgppMYvxv3mWs6PT/tWaEbXf
         Khe6kyaMnwf3yloCnsfsuGEBVVLeZv/uLyeV1c0h7CEDk2HEtvly6CmnnhmxKW+AwDFb
         /zaXGVyce4tJs2r2aDzsNlcGxqTcmWtD85C4MXBA5txczBmkricOj/xMR7YBx+xCZUVT
         qpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707177511; x=1707782311;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtaKsqfpcyHuWJPjZvPw/ChfmsDTwQtI/UDfAaWKaM8=;
        b=gbWG1OMS9AJVP0e0RKFBMBR6FXB7/SjugZaOvqAvMid3iC0NArraruZoiICIi2MfR7
         miQmt7b8lAVQ7x82tx/sixNGZE66YjmFHtC7KasJ77uJbiF7V8N9IuQIIZLkOGEILzXX
         5C8Sl1uZku1QEOlJLGJ0/LH1blJdkG5VUDzVBvt/Vyx7dwKdzmiwZp2eBr8vt3JJfKnt
         9m01SD9tVc99LFknYvjGFdOPFsdEoO+i9sLPpyV7rGb5YTh2Ws8NavMZx1VSgq8Z4rCo
         9MyBBsfDi3uUJWK1gQshsNQmH3NKWrABHhruvsXkxmkV97WL9o23y4c4PgMGcfTgPGG7
         M+lw==
X-Gm-Message-State: AOJu0Yzzb7TzAZrNIFtkk3U3x1SMkSy+Q3qGQjZdb6aJwsqKza3snjkZ
	oNTcHz9+Flcw0zHiyw7ZADFVXkPqidYjyccP8/vEn9AmYKM10/QZ
X-Google-Smtp-Source: AGHT+IFLSb/qzbcHV4+eK/vehAJPhhAMyWJ0waravQi5GuADBjdj5rmxTzMEH07ljUnTlNe1yaylxQ==
X-Received: by 2002:a05:6870:bac7:b0:218:3c0a:7d75 with SMTP id js7-20020a056870bac700b002183c0a7d75mr823025oab.9.1707177511257;
        Mon, 05 Feb 2024 15:58:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUPExShyc/bRXaRWNwyV382EpjROWLSZRHV+E1tHFlJX4UAhwzw/ml5wc9Zo77/jpdsVTeXv20H4AxQjFvom/yinEOhZBvnsB6r/v0bV9zuri73ASy5SavqSn5P4U1scnqV+K7ETfrwcqeIipUaWvDKZss=
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id g20-20020a635214000000b005d8b89bbf20sm637409pgb.63.2024.02.05.15.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 15:58:30 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 13:58:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bcachefs: Use alloc_ordered_workqueue() to create ordered
 workqueues
Message-ID: <ZcF2JaEuwMdg9kYi@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

BACKGROUND
==========

When multiple work items are queued to a workqueue, their execution order
doesn't match the queueing order. They may get executed in any order and
simultaneously. When fully serialized execution - one by one in the queueing
order - is needed, an ordered workqueue should be used which can be created
with alloc_ordered_workqueue().

However, alloc_ordered_workqueue() was a later addition. Before it, an
ordered workqueue could be obtained by creating an UNBOUND workqueue with
@max_active==1. This originally was an implementation side-effect which was
broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
ordered"). Because there were users that depended on the ordered execution,
5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
made workqueue allocation path to implicitly promote UNBOUND workqueues w/
@max_active==1 to ordered workqueues.

While this has worked okay, overloading the UNBOUND allocation interface
this way creates other issues. It's difficult to tell whether a given
workqueue actually needs to be ordered and users that legitimately want a
min concurrency level wq unexpectedly gets an ordered one instead. With
planned UNBOUND workqueue updates to improve execution locality and more
prevalence of chiplet designs which can benefit from such improvements, this
isn't a state we wanna be in forever.

This patch series audits all callsites that create an UNBOUND workqueue w/
@max_active==1 and converts them to alloc_ordered_workqueue() as necessary.

WHAT TO LOOK FOR
================

The conversions are from

  alloc_workqueue(WQ_UNBOUND | flags, 1, args..)

to 

  alloc_ordered_workqueue(flags, args...)

which don't cause any functional changes. If you know that fully ordered
execution is not ncessary, please let me know. I'll drop the conversion and
instead add a comment noting the fact to reduce confusion while conversion
is in progress.

If you aren't fully sure, it's completely fine to let the conversion
through. The behavior will stay exactly the same and we can always
reconsider later.

As there are follow-up workqueue core changes, I'd really appreciate if the
patch can be routed through the workqueue tree w/ your acks. Thanks.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Brian Foster <bfoster@redhat.com>
---
 fs/bcachefs/btree_update_interior.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/bcachefs/btree_update_interior.c
+++ b/fs/bcachefs/btree_update_interior.c
@@ -2484,7 +2484,7 @@ void bch2_fs_btree_interior_update_init_
 int bch2_fs_btree_interior_update_init(struct bch_fs *c)
 {
 	c->btree_interior_update_worker =
-		alloc_workqueue("btree_update", WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
+		alloc_ordered_workqueue("btree_update", WQ_MEM_RECLAIM);
 	if (!c->btree_interior_update_worker)
 		return -BCH_ERR_ENOMEM_btree_interior_update_worker_init;
 

