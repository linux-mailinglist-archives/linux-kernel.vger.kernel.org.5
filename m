Return-Path: <linux-kernel+bounces-89540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FE186F1BD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C481CB21DFC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092E82C689;
	Sat,  2 Mar 2024 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I5LyetTB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483091B298;
	Sat,  2 Mar 2024 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709401457; cv=none; b=MxMNyzfa995xrsNTNAjoLuAroRFU2XZ2qer8c0sF+VbdQA6yzI2GxpRSMf0isvFWZqOnXMIv3Mg8TqwAxKpC4wnwOI8xcr4ArbRfHqeX/PtKPBwSA3fR/be9isk8lhB6Ns3d47J63O7BiJiapvLlIG9l3DOl6pc9ET0nU3Me1OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709401457; c=relaxed/simple;
	bh=y085YQyc64ykRh2zDf4JfAZmOpmrikTbgTDrLbZkilY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mc3NJ79+6vFw0wzMv67YrUJuifLStlxLq71LqkW5FzAc6oa4RRlc2PlAGOtv4yNexpBtKulgV/hSb6WRx4D7hiESd6cAyvu4w9cN4k1X3D3YkuxpqUI8vt9vFJzKyNoGlUe/PKcrr6EdC5t3raY7Tz5M1wTZCt2KXKuF8yrNn9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I5LyetTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D0AC433F1;
	Sat,  2 Mar 2024 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709401456;
	bh=y085YQyc64ykRh2zDf4JfAZmOpmrikTbgTDrLbZkilY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5LyetTBLVLRAoDxOTnUB1iLV7PRIzlrBEh/ue8m/26E5LI899egntKzUbRzRmb0H
	 sQgcgMm/YKId2XFprY9tGMRwhSYDdsqDoMXAJ3bTZzhPnvYJHhQ/aSqN08WxleZb7V
	 IvuYv2i8cgG93wXU/jemv1nLD842Wlfadob4iLUk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.7.8
Date: Sat,  2 Mar 2024 18:44:12 +0100
Message-ID: <2024030231-okay-dullness-c3da@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024030231-stash-embark-6ba6@gregkh>
References: <2024030231-stash-embark-6ba6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 72ee3609aae3..6569f2255d50 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 7
-SUBLEVEL = 7
+SUBLEVEL = 8
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 3b42938a9d3b..7f27382e0ce2 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2457,7 +2457,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 	struct ATTR_LIST_ENTRY *le = NULL;
 	struct runs_tree *run = &ni->file.run;
 	u64 valid_size = ni->i_valid;
-	loff_t i_size = i_size_read(&ni->vfs_inode);
 	u64 vbo_disk;
 	size_t unc_size;
 	u32 frame_size, i, npages_disk, ondisk_size;
@@ -2509,6 +2508,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		err = -EOPNOTSUPP;
 		goto out1;
 #else
+		loff_t i_size = i_size_read(&ni->vfs_inode);
 		u32 frame_bits = ni_ext_compress_bits(ni);
 		u64 frame64 = frame_vbo >> frame_bits;
 		u64 frames, vbo_data;

