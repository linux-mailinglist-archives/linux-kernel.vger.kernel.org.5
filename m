Return-Path: <linux-kernel+bounces-85182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 729F886B1B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293DE28362D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30C715A498;
	Wed, 28 Feb 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="wNiB2+9j"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1594159574
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130502; cv=fail; b=UvHMGnbi7te6u4wIj8cwup4hZZY/aHOsMYkWyGpWGr3V+shudDuMyJe83RIDYDoqGhEBvYoAGJlwHUIfmNogQNbYSJHuOQ6z22wDwuXEc50MrYVz5STA6zL6O+W2K1mRD01yAU+YbMjcmJ/wcy3JgOfRD+XrckAVm8F99J1U4wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130502; c=relaxed/simple;
	bh=goeutjHxH0q+cPnXlZrj/rik07j/QaS0PBouD8E2eSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NURftvJF74IhPLMfChNH4+iM5TTJU//cX8HXGPj2yBTArIE06K577pMmYAk3vstTxhmOzKET2yhTMCW0+yjPrHMetgvICNY990wsL2s0aRVJ1KPb36GUvl56AaUss9Nhzz2qWyUY0YC+abIPL7F9h58pq7Zo+/tTLooOifBMv5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=wNiB2+9j; arc=fail smtp.client-ip=18.185.115.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.10.226])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 4863A1000585E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:28:12 +0000 (UTC)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.191.80])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id A789810000D1B;
	Wed, 28 Feb 2024 14:28:05 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1709130482.992000
X-TM-MAIL-UUID: e2c33151-a67b-4e35-b819-16a5a9e1ee1b
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id F259C10047C3E;
	Wed, 28 Feb 2024 14:28:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6YXoId4V5E1UgFiFO9L1PXKmVMsoZ7jGDJjf4mbis4oLjP7wJcmjdmplhvmgX/jOoqlfEoCU5pi8emi9OvYZSpemRbl6grIbOwr+7evEHbZY8HS/VxkO+vCHxwPfGK4T5c8hUXx1OQoU7LoLpurEWnNLQiuTWiHP9WR+GU017QOv2KGIeVaKrK25qxJzt3R1Y35GtFEEfvF726l+LFjuQL6mEHquatoZHF3NuUcKjvyW3W9psO9LVl5IeEoFUVOK3/uIVWH+e9TJU6t9VjsaYKUxxOnXymS+JDzlRq4oBYS0V04tmd0fR+Hu1iNdOIIqpVcV4NX9ahxBLUGUR66lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYYBcrsQ/lR9d2yFACPZ+OErrlmfXF0dB65cxbTJBZo=;
 b=gqD0rvCFb7pbWeTYtUfXs5aKo6p6du6YJD+aFEi5xm56J05FnSA6o+YQbiHjyq96JdLSAroNTSebry34ABO2anL6kMaxIbeYVv9qb+GeM1NUnZzQ5UG4KiTQxo/K6+78iX7ddL2EpbO9KrXv827KZuhPXgds0HWgHsIBBKi3l9NhQHVjC9rcvHYknIF5aM2agiPyVUlMxcKihNPqOFQG84cgBc8NaxZdj6jpzSz8H29h7bgPPUC2onttcFeDfN8I5L28t4sIaNi2XUUFvBqhwWeOgmYuqgpFM/CD6VhjaLK3uI7Vc5N9o5VLH3k5hYkqHmhusxDyHhAstC8HgoMvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=kernel.org smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Harald Mommer <Harald.Mommer@opensynergy.com>
To: virtio-dev@lists.oasis-open.org,
	Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: [PATCH v1 0/3] Virtio SPI Linux driver
Date: Wed, 28 Feb 2024 15:27:52 +0100
Message-Id: <20240228142755.4061-1-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8B:EE_|FR0P281MB1984:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ccdf5b86-b832-4cb0-c49b-08dc386977f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CAL8aC49VC8hhRbZeYLFSEpNmtyDqyPE8YqIuzjYMf2+YTy/EBnQCaGC5kmsCCUQy1XlOB+lhGww+bXbeQoJP3dK5UaKwysUtPlYKXJNgSSgtqVqr3HsaUAGsOX5ZTLTa90HxOxnC5gOg6cPkceruVeGVx3v5nWrgJhNee2f74ieQmImaFDPHd+6UBrxonmEHCSLQROs3Swx5p861AR1RWEfnlqB650U+i/er7H/S0z2GQahX+iyDZNorjSH0vkRbEAndwgbFGHmChA20zB0BDC6vwA0T3A1myRSguuDKFKsWJTqynAmT1oDQK5f4u6ZauB1V3RztVBDBx4pKANLodiX+1h2lCmJQcA7JcFIuCEv7gX+qB5hHdQ3NjqWNzAA7CYvJeAuV7boygZ+jN6yODbK4MV4Ke21SMea+mlq+WYCPbFXjSaWNIrLhNlkobMtr7wWgSUdMFKYxAAz07qEDziA4Kx9kyMAVPVJsZVsKh73vDngdqDQaDTLGMG3R6F0G595R8wT3aU0+IG/57i7BKvqrp0ESbqrTN7wu/8b6bjKi6MJ9HNnRJwwAYAhgJpOJ4xvSj6NtgbdqMzZrntHYvn2IBJ8aYbPSdR6HXmymF7l5/VtDGiCc0YjnSntGbwh6S0b02jaZ4XyNcfq0YV+HmwvpLlK4uisl3fbo4JS8cH80O2v4/7iw2+SYGiB4t94PpovTU+xb3muHa6eg4f0Sg==
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 14:28:01.3728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdf5b86-b832-4cb0-c49b-08dc386977f1
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1984
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28218.007
X-TMASE-Result: 10--11.256900-4.000000
X-TMASE-MatchedRID: cnGyUyYq85B+P9X2YpqgJg0vIxjiU4qa+bMNqByZrThgGncd4UL3wtvg
	EYRNbHS3pf6OknqQ5Jw7Lmie7Pl+FHvNqzBtuvl1sjKXwoAhxb/cHWFKCmADc/sFqaKfjkncMz6
	M9azVPDIJHJd91K92bDwFW9TC0Amz4ubwVjmTXI04/A8lP4D5okIp2pwQ814LkZ43711UirfX/p
	ZMJ6pjayE8LNeaf230Mcf3QwJCqnOdNK8nItAi6oruruLIWfnxuxdWEFKDsyyV+3kv74ek/d5eh
	toCBUdfKQcd4Z9L9DYtKXIpbCzGiZ1QNdoCSn9geJchdZcr1K0a3oXvkaIARt8e0hdN6SBs1dNF
	BSGC857ETle6GD4DshKgf+tdRiU+ifyRQLERY0pCPQBD3xA/3aryV/2jRq/XEgg3cwDHl/0S3WM
	79W3o4ma3xca03R6Mjwv8P4S/RAO/2tJ3foSBQiPzRlrdFGDw06lvPWlWGC17ThLv4K/UeV8g8V
	B5suCtGO0DQENLlp2hgLRzA45JPQ==
X-TMASE-XGENCLOUD: d6f58ebc-a933-4ccc-8627-6d6bc663c0b7-0-0-200-0
X-TM-Deliver-Signature: 2C0E004A244692AF1F523A61466D64FC
X-TM-Addin-Auth: eQDtECMENuKvBsbAszeOxOnRfMOmX/7Xv5moOg9um190S6y69ar18p4DHA5
	2FSk6lZMKOwQl592ztXG6ZE85guhk4DHdkU38sLVLcSQPGN+SjXotc6Zh4D9/P/Xp3pDAQEgtV9
	FBVjG7i9bf+Xw4MiQ+vQSF5+XpUMtiweNkKTBK+KGmujqANAuFOgDO0KwClTikeDbk9Xsvx/oqO
	ChcO8Otl2jnFBd93fkxuXTKoZIigfK914aZuNheLUN2fkxJmjI5e3uzRo75Logz7wGf3bK137BS
	RuNU85Cu6mrOX/k=.xwROPDUMCqHKkTbHmujMCFApNk+oHowRCjZzcYMOE6cM9fc81Xa76+Hfzf
	4Ngs6VvKS73gcBy9cLzOashPy0x0m2HKalna6v2vnV9rsRUc20YO5CmnrosSJ8HWlSF9OZ0euWh
	c0r/p35ANXEHnFKYUgPZx3Bpbl1VvP3N7vcw+MdqOoHDX3hCUWW0sTHMG8scALfGa1IYFmPPgd5
	LYRBmXn56ByN0Y/H0P++hDQ/jsTSwkjZWLCwNBIGoo6E3I2VW2h1wV4R8a41jKc5gs6W3fVR0Ue
	DW/54rYPX5pJrnwCXFfq2jcsrBg9YB3g4RRHUYfKzqqI3Ns2NJzk/+zBqhA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1709130485;
	bh=goeutjHxH0q+cPnXlZrj/rik07j/QaS0PBouD8E2eSM=; l=2788;
	h=From:To:Date;
	b=wNiB2+9jZJxuxU+ZXADptazVbY7NxRbR81jgpZzxFm0jv6V4+IrZ9oC5Ktag+iBky
	 m0MPmZzO4TdvmgkLGDuR7ih0qkmgTQj5yJUtlpg9DHV4xPvfFlGWCEYpLYXgTAN16Q
	 rGZsMO451/CnWKVTKOb0pN3UaDMqsxL5rO3/wgSmSbv4cuXkRWUwb7sPmWuC2CT4xv
	 PZF2Jsf6ySGHNpIXyaHMka7Ku4tDojY9PmMH3vNSDEttwk4gdvEOTbJvJvUFQYl13F
	 lP+CJ0NJL6F5tGLPOVLsfrr0RWRykCtSr85C8Klpf4i+b5JyEKIp56zAoy/F3EInsf
	 mgAZkNzajjfGA==

This is the 1st non-RFC version of a virtio SPI Linux driver which is
intended to be compliant with the the upcoming virtio specification
version 1.4. The specification can be found in repository
https://github.com/oasis-tcs/virtio-spec.git branch virtio-1.4.

This driver is the direct successor of the 3rd virtio driver RFC which
was based on the same specification text.

As in the meantime the virtio SPI specification has been accepted by
OASIS the driver is now based on an official specification (vs. a draft)
the time has come to remove the --rfc.

Changes between 1st and 2nd virtio SPI driver RFC:

- Update from virtio SPI draft specification V4 to V10.

- Incorporate review comments gotten from the community.

A proposal for a performance enhancement having more than only one SPI
message in flight had to be kept out. The more complicated code would
have caused an unacceptable project risk now.

Changes between 2nd and 3rd virtio SPI driver RFC:

- Order header inclusion alphabetically

- Add Viresh Kumar's "signed-off" to the header files

- Rework virtio_spi_one_transfer()
  - Rework the delays according to Haixu Cui's advise. Delays are now
    handled in a new sub-function virtio_spi_set_delays()
  - Minor change: Re-formulate arguments of sg_init_one()

- Rework virtio_spi_probe()
  - Replace some goto in error paths by return
  - Add spi_unregister_controller() to an error path. Abstained from
    using devm_spi_register_controller() to keep order of
    de-initialization in virtio_spi_remove().
  - Add deletion of vqueue to all error paths taken after the virtqueues
    have been initialized

Changes between 3rd virtio SPI driver RFC and non-RFC driver V1 (newest)

- Address kernel test robot comment which revealed an actual bug
- Rework some comments in the code addressing review comments
- Remove a TODO comment which has served it's purpose
- Allocate struct virtio_spi_req spi_req only once at startup
- Use callback transfer_one instead of transfer_one_message to simplify
  and shorten code. Due to this rework in the affected function(s) some
  additional changes:
  - Do init_completion() only once at startup, for re-initialization
    now reinit_completion() is used
  - Translate result codes VIRTIO_SPI_PARAM_ERR and VIRTIO_SPI_TRANS_ERR
    to appropriate Linux error codes -EINVAL and -EIO
  
The virtio SPI driver was smoke tested on qemu using OpenSynergy's
proprietary virtio SPI device doing a SPI backend simulation on top of
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git tag
stable (commit 45ec2f5f6ed3ec3a79ba1329ad585497cdcbe663) and an adapted
version of the driver on Linux 6.5 with target hardware providing a
physical SPI backend device.


