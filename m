Return-Path: <linux-kernel+bounces-25564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC6682D2BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905D62816DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C76015A8;
	Mon, 15 Jan 2024 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G51/0kwf"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025B636;
	Mon, 15 Jan 2024 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=YXexne54uBipRudKQOZXAif3F+kYQzTRMHfDKADzw4M=; b=G51/0kwfJAZdFW24YgZShuaQnv
	pbbxM5hYoIF1O5lCvb7EFtZEU/0ro6f4CV3JFcnqavJN6aYsmYM/H8bB2BA4CugAD4rUrapkxpEXV
	B3PweRvfkeDkLcetqaB3pTgVXtaPRaOnDeWlRVJbU81o2FTfMCn1gb+Y3fLxu/ebNMf4RWgf9RTpT
	NW60xrLbFoq12K65U4rsRC31/RVv7ApTaKVbaYifAKM8JapAS0ICqUIihmGUUSSWwoNjyv20aekrd
	iAi2scor+6h3W4M7ZD6OJhSI46JsOWNHT7oCEo/bw/SHLO0bCEeHpL4zlDlQ/3AyVL7d7N/aE3TIV
	bGHhvKFQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPArh-007YA5-1a;
	Mon, 15 Jan 2024 00:30:09 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	tomoya-linux@dsn.lapis-semi.com
Subject: [PATCH] usb: gadget: pch_udc: fix an Excess kernel-doc warning
Date: Sun, 14 Jan 2024 16:30:08 -0800
Message-ID: <20240115003008.5763-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete one extraneous line of kernel-doc to prevent a kernel-doc
warning:

pch_udc.c:297: warning: Excess struct member 'desc' description in 'pch_udc_ep'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: <tomoya-linux@dsn.lapis-semi.com>
---
 drivers/usb/gadget/udc/pch_udc.c |    1 -
 1 file changed, 1 deletion(-)

diff -- a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -274,7 +274,6 @@ struct pch_udc_cfg_data {
  * @td_data:		for data request
  * @dev:		reference to device struct
  * @offset_addr:	offset address of ep register
- * @desc:		for this ep
  * @queue:		queue for requests
  * @num:		endpoint number
  * @in:			endpoint is IN

