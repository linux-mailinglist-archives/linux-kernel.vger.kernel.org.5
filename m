Return-Path: <linux-kernel+bounces-109608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CBE881B59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC58E1F21485
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A48B5CB5;
	Thu, 21 Mar 2024 02:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kmz8468X"
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0118F4C8C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710989686; cv=none; b=j23NwPPijKoVH3jY7M+OpDft08fvenAxyT5w/TcvBno7OLXL4GLI17HMIIcy2DHb9/5khTD9QYrneM9oFE8keuUPDfPbNzJftt4irDGtMU5K/7+qAdekWGdAx0LZeIF4gudYJY/HUgWqEg4mR8MoIQ6cnYx58ej2K++8J2Qcvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710989686; c=relaxed/simple;
	bh=SsPl6lnAdqS/S+GeY3UVEaFsBoIWgWENPgpAMnzgZNY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=REc59V8u1J6ZCuv66Zvy1SueM/Eme8/GKdHS4sYG8/pTL7XA+jt3OQV5fhy+0FYaB9h8Xz8Ccc11tzLYLd7rM570vurau/YkIoON2k6GU/CU22D8VuAs7nBKLo4ejsV7xFWtZhm06eMbDDTV0TxCqUHpz2rR1UCZri8z6kPQfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kmz8468X; arc=none smtp.client-ip=203.205.251.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710989676; bh=f5jT1hNfbmJ01fmppMvabKrX5qm3Y5Yh4bcX0uJxKHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kmz8468X1m6ybJanGYWkGiTx4DdvN3BFJu6MVpNvWBPrdaP+deyIKEm0HHqiT+mqk
	 B+0ayxYxlp/JX8e7hLYbc6YISURg99ZBVMd4H6gERDlvG3dPD1Mvtr1dSTbb1BYA9m
	 czfeI6bq9Uz+mh52Kzv3p+2XCBaunXt3TvY+Npww=
Received: from localhost.localdomain ([153.3.156.52])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id C0E1E684; Thu, 21 Mar 2024 10:48:14 +0800
X-QQ-mid: xmsmtpt1710989294t10a5k7uh
Message-ID: <tencent_BF745A1543ABB0579DFC20480AA1A4456307@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jMknYzBTUX1TyLQJJwnGJa2kGkEXkzy0QynM54t99hdlGOmruc7
	 toQQcHl+vKWX9+9pLw9QmAfPfFz+Fcina/RUynC85MoalhWZJrTyu6CyQqCS0xH5CKDvha3pOLwj
	 8dDw9JGPUmWO2qXBykbYrODaauNVGyEaclEu/d9oiQqBLlEphq2aUQ9NVG80sufxqxP0G4D1v40C
	 tQrqGcv4HO84B8O1I9YRrb1N3nj8uhY/YUFSsDGuNjo+m+Iq6xElACW21mDdJfUEroXSciS2ixUN
	 H+rKWbQVORslYyIKY1A6Q6Fxfu89FN5Ryp2yashaiCveCtW5/vHG4ws+bUdE2VbiuX7bsrl/wO+C
	 MpP3YdXcBydST3g32C7EOvTw1Kd1nOBvWvtVxYe0PZ9uEnloRdGNed/Mct8rEEQO500MQGqrP5rX
	 VIMPgJZkFwZLA4O3cL24DYJFCLY4GPj1f3Ixj6mLoAdjQ8XwGyjCexj1uBEpztO8HBHORuKyp2BI
	 aVwZt2J71jdknC5+W9ADQnPVjSFR3m41sCVIAorqC7MTXdbStHbQTFg2UtFIU6fmRSaQOqKZWcTF
	 VfEgnKXWsvjhm7uZww+85MWGqikf4OL34cqXdxy1T/FtwBxJOlwQi80Hq+LNuCkvmsDHmaUNNjWh
	 we4l0y3SE2ZGahL/SFY+rG/UBILx17k8CLnSWqZBcXpy3PnmLHar5/5IK5El4+xLj46Bp8f0GpQO
	 eOD3J3SAweSh+8+DyG1ztLSPP6Q8bOuFspz1jA4z+YVsYw7WVk062wkCSYmu/RTpff455UuvskHK
	 MaEJm6sLtRYa0M3Y9VT4utfv54gnO8frSX5gCLEcO273dAgfO/cN7cFQlByVr8hhkNX+N5R0sHTU
	 dpICBgdQ6Yx7U/yMBshA8ulpDLrGTFAv0dgpHdAAJBemTATMJrF7mZipsHDLAemsXeM0Y9TFBGFv
	 /f5FTsnAEHHEYplPbe+ABftfReiA1wd2uhHnjKcshWTx6du94nyusaSVT9N7IvTj/rxsj61DELwe
	 wz83YKpm0UjRl3oTXu
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: linke li <lilinke99@qq.com>
To: chengming.zhou@linux.dev
Cc: 42.hyeyoo@gmail.com,
	akpm@linux-foundation.org,
	cl@linux.com,
	iamjoonsoo.kim@lge.com,
	lilinke99@qq.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	vbabka@suse.cz
Subject: Re: [PATCH] mm/slub: mark racy accesses on slab->slabs
Date: Thu, 21 Mar 2024 10:48:11 +0800
X-OQ-MSGID: <20240321024811.57550-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <8bc1aebf-8395-416f-8c23-53cbd25d0eef@linux.dev>
References: <8bc1aebf-8395-416f-8c23-53cbd25d0eef@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry for a late reply, I just found this because of my bad email client.

> There is another unmarked access of "slab->slabs" in the show_slab_objects(),
> which you can change too.

Yes, I think show_slab_objects() has a similar situation. Should I
consider to submit a V2 patch for this?

> I'm not sure that it's really safe to access "slab->slabs" here without any protection?
> Although it should be no problem in practice, alternative choice maybe putting partial
> slabs count in the kmem_cache_cpu struct.

I think it is ok, because it seems that slab->slabs in slub_percpu_partial
and show_slab_objects() are just used for showing some infomation.

I noticed Paul summarized some of these strategies in access-marking.txt[1]

Quote from it:

"Use of the data_race() Macro
----------------------------

Here are some situations where data_race() should be used instead of
READ_ONCE() and WRITE_ONCE():

1.	Data-racy loads from shared variables whose values are used only
	for diagnostic purposes.

2.	Data-racy reads whose values are checked against marked reload.

3.	Reads whose values feed into error-tolerant heuristics.

4.	Writes setting values that feed into error-tolerant heuristics.
"

Thanks,
Linke

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt


