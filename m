Return-Path: <linux-kernel+bounces-79426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9E4862211
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86132858A1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ECA611B;
	Sat, 24 Feb 2024 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J7FoVtkv"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8CE539E
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708739205; cv=none; b=tmjC33B9XcJIZ/Lsm58FzwN0iYW8r/c/pqFUMV8DTTIpdKmYSuwfSGBvNPIAEYzGL1fbGR4gIEZEZTZW0Pou5jz1voTdRvdWtlqhrVK0/HAn1Gu1BKePWZ9PcZhSRDIRHL+O5Uk7YXq5hE8ssI1OXAostr69dqv2TLggOXXxJaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708739205; c=relaxed/simple;
	bh=0iUTPt4lafDkSom9yeB5DcsA56CMo3W9uqcE27H56+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hFVk/lIdDiVt/yKkfzh41JfjC4LG4/UI8u2shxWPQmjR9oODFiqXle1Q3mx7u+I2wA8zNCEsLT2OPj+J2TWijiKx1AyJ1U953XLnwLsNlD6vmhTfscOpc0REXf9sUcSczSMfmv/sPVHl87nOCUOMVGMVKsrZ1wDH5E6xY34vw9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J7FoVtkv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xbeJv3Tf/iMamzgLN+SF08O4Ib87/TQEtiDCMarQbX8=; b=J7FoVtkv4O0m7QZdhP1qk35VUl
	B67v/8S1ouWa8GNECA7D2gZsXVXqO4Ro01awwbVpI3A8ikoNR4ejt6dMWhL4ZbplZNUZD32ZXAfIU
	n+Bts6sfhbJIdleGg+iW7G2w/rMsHYpD6M8oxtTWjA22Jf5XLq0oYaUrdAAbT+DHz/v68RiLg8Ar2
	SKWcVpBwVd3tCcizRb6l33DiJhBGJTCUwoQIkIbIKGDD2sphKKHxBbJTMBZjyLv/wsAijlxB9VCjK
	ZU1ZvMv9/+nrHsful4fwfokvu8m7Yz/1QhnMv9Ci09JXOpxbno00lMjH4vsr6rhJGVXkKQWk8mtJg
	kD/QsnEw==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdh7g-0000000Bp1H-2IfP;
	Sat, 24 Feb 2024 01:46:42 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: rawnand: hynix: remove @nand_technology kernel-doc description
Date: Fri, 23 Feb 2024 17:46:39 -0800
Message-ID: <20240224014639.16145-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the extraneous kernel-doc description for @nand_technology to
eliminate a kernel-doc warning:

nand_hynix.c:39: warning: Excess struct member 'nand_technology' description in 'hynix_nand'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
---
 drivers/mtd/nand/raw/nand_hynix.c |    1 -
 1 file changed, 1 deletion(-)

diff -- a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -31,7 +31,6 @@ struct hynix_read_retry {
 
 /**
  * struct hynix_nand - private Hynix NAND struct
- * @nand_technology: manufacturing process expressed in picometer
  * @read_retry: read-retry information
  */
 struct hynix_nand {

