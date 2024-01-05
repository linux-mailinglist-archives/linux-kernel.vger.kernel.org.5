Return-Path: <linux-kernel+bounces-17673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76626825107
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288CC1F22D4B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45D92420E;
	Fri,  5 Jan 2024 09:43:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2928E15;
	Fri,  5 Jan 2024 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4T5z4Y44frzvTnS;
	Fri,  5 Jan 2024 17:41:49 +0800 (CST)
Received: from dggpemd500003.china.huawei.com (unknown [7.185.36.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F512140134;
	Fri,  5 Jan 2024 17:43:01 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpemd500003.china.huawei.com (7.185.36.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 5 Jan 2024 17:43:00 +0800
From: gaoxingwang <gaoxingwang1@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>
CC: <liaichun@huawei.com>, <yanan@huawei.com>
Subject: [Discuss]iproute2: ipv6 route add fail
Date: Fri, 5 Jan 2024 17:42:55 +0800
Message-ID: <20240105094255.1498461-1-gaoxingwang1@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd500003.china.huawei.com (7.185.36.29)

Hello everyone,

Here is a particular problem with routing.
Sometimes users can run the ip -6 route command to add a route whose destination address is the same as the gateway address, and it can be successfully added. However, adding another route with the same gateway address will fail later.

Example:
# ip -6 route add 2409:8080:5a0a:60c7::7/128 via 2409:8080:5a0a:60c7::7 dev eth2
# ip -6 route add 2409:8080:5a0a:60c7::8/128 via 2409:8080:5a0a:60c7::7 dev eth2
RTNETLINK answers: No route to host

Does the kernel not support this application scenario?
Or should the kernel not allow routes with the same destination address as the gateway address to be added so that other more meaningful routes can be added successfully?

This question puzzles me, thank you very much if your can reply.

Best regards,
Xingwang

