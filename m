Return-Path: <linux-kernel+bounces-10296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE2481D24F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03F11F21922
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B75C9441;
	Sat, 23 Dec 2023 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y0t3Za79"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4662F8F68
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 05:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=79m4T/NYfm775xrhU0IxEZw2Inulh1Se54ealG/90iI=; b=y0t3Za79/yjXGDGXOvz+nKtAQo
	VKPjiZe1Wveuv+IdfLg0++3xNpmlUugxJuG/YQrVBh2F93wN7T4nftco/FWo+JDb2KfEF+BBMoCSs
	oelMVxLDoECQI7wf+KrtTBJJvRzBQ6y3egRK6ApvxibkhhVpyrHRFLHaHwTNoJloNy1cnrkyXn7wD
	4wa83UWQsKD4nxwvK8huEVJhE+OihzITT+vM3en6Db23+2xt0/RLX5I9NIyP9NntK78HIkhH1i2yJ
	a8G02O+qMoQqd5P04Us+T3A0fYt78m+gDKu8q5Fne4dXWFlxiYfE4OWWo8To/DpzOrByjUXtnG0ji
	l5fLXG0A==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGuCa-007OZO-2v;
	Sat, 23 Dec 2023 05:05:32 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: device.h: fix Excess kernel-doc description warning
Date: Fri, 22 Dec 2023 21:05:32 -0800
Message-ID: <20231223050532.13881-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the @knode_class: line to prevent the kernel-doc warning:

include/linux/device.h:807: warning: Excess struct member 'knode_class' description in 'device'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 include/linux/device.h |    1 -
 1 file changed, 1 deletion(-)

diff -- a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -661,7 +661,6 @@ struct device_physical_location {
  * @id:		device instance
  * @devres_lock: Spinlock to protect the resource of the device.
  * @devres_head: The resources list of the device.
- * @knode_class: The node used to add the device to the class list.
  * @class:	The class of the device.
  * @groups:	Optional attribute groups.
  * @release:	Callback to free the device after all references have

