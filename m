Return-Path: <linux-kernel+bounces-10294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2294381D24D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47381F2151F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30BB46AF;
	Sat, 23 Dec 2023 05:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LEA2HSkF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506938BE0;
	Sat, 23 Dec 2023 05:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KaEmTpHfBTShYhOTv7C/rpD+KFzSuDv6UtwePGIwHNU=; b=LEA2HSkFnfK9YLqle7dnJ4j8Wj
	XaH2cav+DKN4mfRBc9HlU8SdN5i3Mr+5/7O7727wxef/IiK7uj2qLCxZk+FCWLs+grqrW67S0i4TS
	OENMMCjQREew568lElOhnaWt3zgD93Uu8GyzRTxfFNV8Sj+wg2noR1edRP5ELTJ9WW1Xu65wemgof
	1XB6nnSD8tMFZhWAJJ88AG6i+mqgxNlJRafmqaw6VTyGqTTIL4VbVDfoJrLHqga8NNsHtRQYFnkJS
	4gqbJb6/R/DzTT6KVlvx4OImlP1RgCCsTo/qm2oCU4pP1HO7L/irCYRfEvR1twdfNH1XTZaIWYDR1
	sP3VNqwg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGuCF-007OWO-2B;
	Sat, 23 Dec 2023 05:05:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	William Breathitt Gray <william.gray@linaro.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH] counter: linux/counter.h: fix Excess kernel-doc description warning
Date: Fri, 22 Dec 2023 21:05:11 -0800
Message-ID: <20231223050511.13849-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the @priv: line to prevent the kernel-doc warning:

include/linux/counter.h:400: warning: Excess struct member 'priv' description in 'counter_device'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: William Breathitt Gray <william.gray@linaro.org>
Cc: linux-iio@vger.kernel.org
---
 include/linux/counter.h |    1 -
 1 file changed, 1 deletion(-)

diff -- a/include/linux/counter.h b/include/linux/counter.h
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -359,7 +359,6 @@ struct counter_ops {
  * @num_counts:		number of Counts specified in @counts
  * @ext:		optional array of Counter device extensions
  * @num_ext:		number of Counter device extensions specified in @ext
- * @priv:		optional private data supplied by driver
  * @dev:		internal device structure
  * @chrdev:		internal character device structure
  * @events_list:	list of current watching Counter events

