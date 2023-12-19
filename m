Return-Path: <linux-kernel+bounces-5227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69560818836
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A231C242CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94F918C03;
	Tue, 19 Dec 2023 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kco6YoTU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B481B267;
	Tue, 19 Dec 2023 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hu16B
	/w9CwNQoqVaJ4g0i49fjsPPZNTMZNSo5via85Y=; b=kco6YoTUE8aJI6U/9IX5V
	ylAtXRoF0XLIGTN2G8W5cvdPX2k+8oY2JkCctAfiT9PAluu3sMX+9jbBRq2e9kg/
	TtILX9ceKw89zsRd5hsP27lwxLdNTEm+AlRDZMcwg+VQdL/71ww5zGITvvGxg4qn
	IjNp6nvzuwvOaAz7l8yqzE=
Received: from ubuntu22.localdomain (unknown [117.176.219.50])
	by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wD3_3Dbk4FlqxFqBw--.22995S2;
	Tue, 19 Dec 2023 21:00:12 +0800 (CST)
From: chenguanxi11234@163.com
To: rafael@kernel.org
Cc: len.brown@intel.com,
	pavel@ucw.cz,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Haonan <chen.haonan2@zte.com.cn>
Subject: [PATCH linux-next v2] kernel/power: Use kmap_local_page() in snapshot.c
Date: Tue, 19 Dec 2023 21:00:58 +0800
Message-Id: <19e305896a2357d305f955fa14cc379e40e512bd.1702977429.git.chen.haonan2@zte.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_3Dbk4FlqxFqBw--.22995S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUfcdbUUUUU
X-CM-SenderInfo: xfkh0wxxdq5xirrsjki6rwjhhfrp/1tbiQABL+mVOAjMcXAAAsr

From: Chen Haonan <chen.haonan2@zte.com.cn>


