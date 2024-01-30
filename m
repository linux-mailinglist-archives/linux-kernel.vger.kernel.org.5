Return-Path: <linux-kernel+bounces-44432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1A0842205
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC590B2C000
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEF265BD6;
	Tue, 30 Jan 2024 10:53:48 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301B67738;
	Tue, 30 Jan 2024 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612027; cv=none; b=KhjMRZ6mq50cyU7bunF09cca6FSiN5PwLFuRaobaEa5sxAiEFMsobfbAVCD7jVN0MHmwDABueASP4Lg8Fr6w/I7x6BS6Oh8f9VfG7ZL49y5Q3VvyQfeCBNMkVyyBdyUqUyhHTca42t3XN198QBbUpxYuaoVFoYnFhGrHgU8p920=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612027; c=relaxed/simple;
	bh=2TcQC8/sN+CLKa4KAz9WJchbaQNDMQnwf41Xbq7rBgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C3aAXNt/N6pnQ5pnfASyMwC71ExvSIWAUpN5B5JosqJPEmSG3wOlCHDrl5IEI59KGZCewMfKxn5dEZy86IwGVxclFyCvyI+2MOInZwkjz8nTYlcTEEczX9TDNJhWzbc6TEN5l/peSZV8Dx96T/QW6DGvEea15ou+yi/hMBpbedk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp84t1706611993tay72xlo
X-QQ-Originating-IP: DyyG5fTYbDh9gbtijojX+M9mzLNkGPtb7cZXAbr6tow=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 30 Jan 2024 18:53:12 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: qOAV9bwDT/lFp2KM4BZcFePts6WfQEUT1pumFcfYdGZdgiiigHcAXnIMZuxyc
	Gb4h61KQIZmE9frO2Hb3Gs1vjFHOkgNxs3FTJZiCLFf8PrBYEFPns7IshnNWc0N7kS3U+Zc
	o7LqtiF4w9dpfBq/L/fwkSv+OacQUynKPAaeH5vowKoIjYMFi+SGDIL5YTYv4evwLHaxMv2
	Z5y2QcBMh1vCK78rA2wooMQ7FbcZJJJmbB3WBZWBq9UVWBwry2TWVQ3ofJswZRZwvrBjlqI
	xeD5lNN4CsUZAdW61NCAxVwtywxggvn6tKTcaR+nX+uNDoWe8vM+E5ntQ+SpmhzCt7FQV0V
	Xd0sFqlo6eiT+/ApK9HHe6wHgbaEE/xqFSM0iEbG4i6XHiMbgQA/WUYeIh81tmMNtJgBzJz
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15235478550126742813
From: Dawei Li <dawei.li@shingroup.cn>
To: robh+dt@kernel.org,
	frowand.list@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 0/2] Update phandle cache on device node attach 
Date: Tue, 30 Jan 2024 18:52:34 +0800
Message-Id: <20240130105236.3097126-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Rob,

This tiny series implement cache updating logic for device node
attaching for CONFIG_OF_DYNAMIC.


Dawei Li (2):
  of: Introduce __of_phandle_update_cache
  of: Implment cache update operation on device node attach

 drivers/of/base.c       | 22 ++++++++++++++++++++--
 drivers/of/dynamic.c    |  2 ++
 drivers/of/of_private.h |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

base-commit: 861c0981648f5b64c86fd028ee622096eb7af05a

Sorry for wrong tree on which these patches are standing(which is
Linus's tree), I am have hard time fetching OF tree.

Thanks,

    Dawei

-- 
2.27.0


