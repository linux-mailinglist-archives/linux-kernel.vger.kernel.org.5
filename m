Return-Path: <linux-kernel+bounces-91681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534698714F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06AE31F2225C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007D143AB0;
	Tue,  5 Mar 2024 04:47:43 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F5B3D39A;
	Tue,  5 Mar 2024 04:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614062; cv=none; b=Zlz6GBSBtwuOlT/+hWzria3W0RuBqJ5CQRe9Hi4HrZjOIP8helfwWI33g1RkApvDBSbZV7aiyDr1jxFMbOETsE+ub5nPfGudPDwjocCkcrH4KHYbS1WZvJ4QxrNBnOej2no4kYFF1Oc+dNsvBneZh8P9jJJwbc38wRJ6k25daGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614062; c=relaxed/simple;
	bh=j14sEjIeltVMQXMNfBFbioxn+HEsRP/Z6ysg6y7sSlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xyvl+7z7gI/0+WoFSwrm1+PiEK0mvnRrbT2Ia8/amTlJxcebqM1xmhyb3gLFgitUYVLbPPQFOvYu+7A5xrCl1Iw47eGOtU2ngMjGefYpOOO2DQY6XOYelTYEkP48nZ/148EOYqQ6eATegy17kBrJJxBJkjA9vhFiVwmHqlcgOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b8b30e310b114c15a8e66cfb55f18167-20240305
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c592d5d6-7113-4a2f-b3c6-903d88475371,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.37,REQID:c592d5d6-7113-4a2f-b3c6-903d88475371,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6f543d0,CLOUDID:ada81e81-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240304224331GLBEOKA9,BulkQuantity:8,Recheck:0,SF:24|100|17|42|101|64
	|19|74|66|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: b8b30e310b114c15a8e66cfb55f18167-20240305
X-User: huxiaoying@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
	(envelope-from <huxiaoying@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 340706475; Tue, 05 Mar 2024 12:47:24 +0800
From: Tom Hu <huxiaoying@kylinos.cn>
To: stern@rowland.harvard.edu
Cc: gregkh@linuxfoundation.org,
	huxiaoying@kylinos.cn,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH v2] usb-storage: Add Brain USB3-FW to IGNORE_UAS
Date: Tue,  5 Mar 2024 12:47:19 +0800
Message-Id: <20240305044719.524767-1-huxiaoying@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <eb015716-7695-4567-a553-0b6960cb2026@rowland.harvard.edu>
References: <eb015716-7695-4567-a553-0b6960cb2026@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Mar 04, 2024 at 11:16:56AM +0800, Tom Hu wrote:
> The UAS mode of BRAIN USB_HDD is reported to fail to work on several
> platforms with the following error message, then after re-connecting the
> device will be offlined and not working at all.
> 
> [  622.518442][ 2] sd 8:0:0:0: [sda] tag#17 uas_eh_abort_handler 0 uas-tag 18
>                    inflight: CMD
> [  622.527575][ 2] sd 8:0:0:0: [sda] tag#17 CDB: Write(10) 2a 00 03 6f 88 00 00
>                    04 00 00
> [  622.536330][ 2] sd 8:0:0:0: [sda] tag#0 uas_eh_abort_handler 0 uas-tag 1
>                    inflight: CMD
> [  622.545266][ 2] sd 8:0:0:0: [sda] tag#0 CDB: Write(10) 2a 00 07 44 1a 88 00
>                    00 08 00
> 
> These disks have a broken uas implementation, the tag field of the status
> iu-s is not set properly, so we need to fall-back to usb-storage.
> 
> ---
> v2: remove junk information from patch.

No, the junk information is still present.

> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

And I have to rescind this Acked-by.

> Signed-off-by: Hu Xiaoying <huxiaoying@kylinos.cn>
> ---
>  drivers/usb/storage/unusual_uas.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
> index 1f8c9b16a0fb..98b7ff2c76ba 100644
> --- a/drivers/usb/storage/unusual_uas.h
> +++ b/drivers/usb/storage/unusual_uas.h
> @@ -83,6 +83,13 @@ UNUSUAL_DEV(0x0bc2, 0x331a, 0x0000, 0x9999,
>  		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
>  		US_FL_NO_REPORT_LUNS),
>  
> +/* Reported-by: Tom Hu <huxiaoying@kylinos.cn> */
> +UNUSUAL_DEV(0x1234, 0x1234, 0x0000, 0x9999,

The junk information is the "0x1234, 0x1234" values.  And if you try
removing it from the patch, you'll find that the patch doesn't work.

> +		"Brain",
> +		"External HDD",
> +		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> +		US_FL_IGNORE_UAS),

Fortunately you can get the same effect by setting a module parameter 
for usb-storage.  For example, in /etc/modprobe.d/brain.conf:

# Brain USB HDD doesn't work in UAS mode (tag field not set properly)
options usb_storage quirks=1234:1234:u

Alan Stern
-------------------------------

Hi Alan, 

Thanks for you advice!  i accept it.

