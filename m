Return-Path: <linux-kernel+bounces-112247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27A5887765
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588D01F222DC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41312C13B;
	Sat, 23 Mar 2024 07:17:14 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845ED23BF;
	Sat, 23 Mar 2024 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711178233; cv=none; b=hBho216LFdT3CsiyuQChTqlvISN4pghjfW8DePF1WSKeBNd0smt/IQzr/keczxjf6hCb8eg6z6f2nncNxmlcmIf7dCp15esUGB3vRTxPxtv3Blq+yjO5apP5P5VZPwIMoUTLY3j/97CmTw1PbXJ3mzhuftFa2zTTgWPTln5KcEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711178233; c=relaxed/simple;
	bh=eMZ6gi8HGgwMWkQtrCvapcqfvLPGcwP9grwV9JS3tOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKrOJr9bECrEf4FqK6Ay7qyTgNR2jDWCiGqV8m13yn62BmXPaFECavMhfd7d9o+Kih1d2w5X2lLBDor3WqAFNlaS6CsbTmDijXcP598xFyFGcTWc2u8IgRIGMnYsRBREhOL36x3FUF7f2At8KyYde5Er2R9sFssKqKxv17nSKpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4V1r7C6BPmzNmJv;
	Sat, 23 Mar 2024 15:15:03 +0800 (CST)
Received: from dggpemd500003.china.huawei.com (unknown [7.185.36.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 399FE1400D7;
	Sat, 23 Mar 2024 15:17:00 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpemd500003.china.huawei.com (7.185.36.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 23 Mar 2024 15:16:59 +0800
From: gaoxingwang <gaoxingwang1@huawei.com>
To: <mkubecek@suse.cz>
CC: <idosch@nvidia.com>, <jiri@resnulli.us>, <liaichun@huawei.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <yanan@huawei.com>
Subject: Re: [PATCH] netlink: fix typo
Date: Sat, 23 Mar 2024 15:16:27 +0800
Message-ID: <20240323071627.2095986-1-gaoxingwang1@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240322084943.5xodsuxt45jr5l3l@lion.mk-sys.cz>
References: <20240322084943.5xodsuxt45jr5l3l@lion.mk-sys.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd500003.china.huawei.com (7.185.36.29)

>> Please make clear indication which project/tree you target with your
>> patch by putting appropriate name in the [patch NAME] brackets
>
>In this case, it should be "[PATCH ethtool]".
>
>Michal
Yes, this is a commit for the ethtool project. First time contributing a patch to this project, not familiar with it yet.
Thank you all or your guidance. I'll resubmit the patch later.

