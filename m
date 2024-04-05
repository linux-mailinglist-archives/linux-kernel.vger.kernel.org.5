Return-Path: <linux-kernel+bounces-132787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4288C899A27
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CF528424C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4197161309;
	Fri,  5 Apr 2024 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="PqoCYnD/";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="B0mEMFs8"
Received: from e3i57.smtp2go.com (e3i57.smtp2go.com [158.120.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68C160872
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311373; cv=none; b=Ww2s89EkRWX1qbSjevyBR5s5dxwuoOH/x6+GKJ+fVf3YhAYD3yjw75qjkzlOwdvgmU7ZP7fyr6xQ3c4Ys+YmNu/cjZjlt6aKBPynOhFfgOHWVGukPGw2Whr/WLCHnbwDb2DWiAheQqgz3N0PsSmWQ1qNyDvH53UV9PTJWTRjwoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311373; c=relaxed/simple;
	bh=S/aNv2lF06ooFUIcmaegi/4jt++yjayJ5fVpl/t9Ymc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L7IlriHGE9xTU88kVX5irI8x06lth0mMOsu8HuYm17vMQAo9D2x9sx1BdxyHSQri01mLIdmF0+kEkStnMaL1NWPXlfGoRKN+E/QBHxFHZqiJnbdk05GErM5EO6RW1wgrxOzyKskwYUf28j6mU8W31NCBB2DF80Kr5bDzdGvFa9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=PqoCYnD/; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=B0mEMFs8; arc=none smtp.client-ip=158.120.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rsgNk-rloBri-0u
	for linux-kernel@vger.kernel.org;
	Fri, 05 Apr 2024 10:01:12 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Fri, 5 Apr 2024 12:01:10 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 0/1] mtd: spi-nor: everspin: add em004lxb entry
Date: Fri,  5 Apr 2024 12:01:03 +0200
Message-Id: <20240405100104.480779-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Apr 2024 10:01:10.0750 (UTC) FILETIME=[2F9FA7E0:01DA8740]
X-smtpcorp-track: 1rsgNkr_oUri0I.DxvpHifGoTRPv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1712311369; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=BEE1Q44IuerTAix98C68lkBVz054z7wXlAMnf+3bW8g=;
 b=PqoCYnD/+u1ymfp7xfDd9qdsHV+ZcQTJJczVP9WSKLYlpJaVG+5IRKURUQCysIU/obNTB
 Tldm9hUINCR7T6/UyPT79NfgZeNyd6coW0aIfJIMLyymllD01OrQgUTrqdhmv3MwBRFLGwf
 WfLRdCO7X3TT3JvQ16pNgKdxz6gykjINtRopCnA5CRisJrUPyK2Ii9S5NqRxyLQhxvHSWNX
 lmal8R1VxyZM8ABnGL9S9CZVliNHVoUymdW+pnS7P/St0Jengo/6J/6njy68cS2ZW/3ZVky
 1V68KWW+MjoAlEd5q/d7z4Q/mewoufrartbQDVo73E40/CJWma+lXq6mC7DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1712311369; h=from : subject : to
 : message-id : date; bh=BEE1Q44IuerTAix98C68lkBVz054z7wXlAMnf+3bW8g=;
 b=B0mEMFs8ZPxm6bHwhftw2tl518X9caBsgFkU2XACRwYUmd8lrXX5k7AYDYVgXePm921ga
 zVeBJa+bR7MklaMD7NY0zth2jQxo5DDxZv6vL7qoAx9uZEBB2wdMftou1Vh6kD1E2accoqF
 eXyF6ZeJD7qnT2cfq07yDg/qt0FOEl8jWWt+RxerU9jPeewMdzvQv/mjrxDTN6E8WHaJX0M
 J6Ft7qNlX7NYIzJBVNHGDfj8zLLNDoE0Z4PjQBSfhcUcM536NKrfdknn2yiI0pevuCY+xSv
 NmqBKbBoYJPIcGCqJk7A7nkg9jXi9uJ5VisdLPnkDj59ZAPai8YI4NvrF7zg==

Add the Everspin EM0004LXB 4Mb (512KB) Industrial STT-MRAM Persistent
Memory.
This device is JEDEC compatible (JESD251 and JESD251-1), but it is not able
to provide SFDP information.

Link: https://www.everspin.com/file/158244/download

I currently use this MRAM on one of our i.MX8MP boards.

Flavio Suligoi (1):
  mtd: spi-nor: everspin: add em004lxb entry

 drivers/mtd/spi-nor/everspin.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.34.1


