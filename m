Return-Path: <linux-kernel+bounces-118888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D83588C0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908BE1C3B386
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75765C99;
	Tue, 26 Mar 2024 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="W4J+An0N"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC954905
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452649; cv=fail; b=hf0PYH/5vS/dCHk1U8+GLDf9A1DXdov0uOtWxWD9WUXGHqVqNkBJQoYoya8QN1lpaNEScaONY/syu+2PAnE+GnA32aQN5t4dKlGhMmmY5FzQbBFrYO4FtEPF0qDWeOBTeqwGI/ZFFJl0g77dLRDClWhYE3f1qikReOjfkHb699w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452649; c=relaxed/simple;
	bh=wKyMQAA+Uxoy+QGvQRqJWzaaAFFlsL78bfMPLvmTuHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mydn99sdcgy9fyhxOEbBGv/TVb3JVgc1Yg6Ci6dL5o0iRQqgx4nYlA0AaqXNIg1T2SYxOKdEbotfgs37oBP3EslxmHeOqe3+yM6HZvaw4RVwOUaZidM8xrSH7ia85k6Pc7Xsc5e6lkgOLb7zCmSAwlunK9cmKGVO3nrGoKEcQ40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=W4J+An0N; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.10.52])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 5447010055520
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:28:32 +0000 (UTC)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.171.124])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 6C41C10001FBE;
	Tue, 26 Mar 2024 11:28:25 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1711452502.150000
X-TM-MAIL-UUID: c02b2e57-3589-4ba7-839a-151a26aa8fdc
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 24C1B10001283;
	Tue, 26 Mar 2024 11:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4+2ARngFvZVnx80VmT2c6tRxl28zGUapvV0EloQ6WQeg8dih6uy3mgfNbUguLtEOVT4sfoqhLitNBXxFedZA8Zs4hc+2/FE4ajprnD/lMsMW7mwWRlLm7rv7xLgoCrBXJshf2tK4Q9Q9O50cCqiRN3VMgvG/At3tjZAID8SagJ+X75IDfG0pmDR4MdJtGxAvviCLWDBkPULD+B87980xOUg1Wxpa2042Kupyi677jJNlpTgKUbd9z/hCB2XVqGRDvKPAUlB6Z7WF0wUtrL3EUgqJRgix9my8cnY55lMm7X1cwyUv6jurKqgaljMb+Ing0khL1YBNJKXu2xfP8ImVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COEapnuWnypt+yFh6MuBhwus5pCMpDL6gLIXqXFAxkw=;
 b=I1qM5NuNIGEDJ3ou8gAvEGMI72HECkonh4zjZh+WauD6tVsfBEL6l/o3oyn/bEHBW7iORwqTFU5UGl71robBdblWtIU0MP6O+l+d8TCfunVE2Ar/XzMPRsQC3v3V7vG93T9kgkwVGayBnu72dicrOmhwzYr2KC8NzVpnyhXQOI+Q+/nXlqvqi22o2c3EzsMLIZNizxlWVfYzt3EGKNMN/xZcZvWtwBLMQi/Pk5YOaIi2y8rj205XmaM7UU+SFY7QY1YMp0Z87nrI5+ktt+ITJaa5KIXVYce9sSEwfiT+Hi/kAyYHt20yoAk+aMYbeyHO3vAsDC6Xox5vmHNvc3I7lw==
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
Subject: [PATCH v3 0/3] Virtio SPI Linux driver
Date: Tue, 26 Mar 2024 12:28:09 +0100
Message-Id: <20240326112812.31739-1-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C708:EE_|BE1P281MB2963:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4698240b-e073-4dd3-e94c-08dc4d87d722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GupSAbxjm0h+/KusWHNjHEq8uHrAMkaoZWjShdxAzyFQnW7ACIkjJ/YGraEotXKz6xT4V3UFPQypSBVcuZMF/aPdiz2gjusgx19l/SN5k/cntoRZY0dejJMdQCJ9A5Q77xroTO9tXr3eMF2rVH0t+SUL8ed68P27MA6ya3YdMCLxrALgdf74ZZC1QEoDtYPqvAUlORsTR1e7Ur4zKOjoL/LSwK42aEDU9jCBTi+zl4VMuxBag9GBo8vk2XXGH4mMDyTP+I880DIOQYaC2FXWsx5EZz1AjFU8V6NYh6Ptiz/Iwegoq0AQGxNP3ko+YZy+ZI01tG56pIy5OaHoM9CRDfw0dUPpxHGhd17cyQzOzpOjTAdkWcz1Wt3hJU6GCeIDBS5tqRyn1lmBAutMmYiJlOLcVzV3w7nQSkfE17+X5CEg0vwHMBqVGI3leR3Jcuqy54J5Y81Ej0H1+DZpOpe6Aa1S/kAFnCUFGW1d+BdiNcPv8a3YyUsQYr/Z3l6/fbTFKdyzS0SxpUqLQoSxCZwyhVpdBjU1YGyBbg1ghHXweNLSLt+5D5paiCklvV+5azUcmvK9EsR0qd/CTROHKy+uFOpEgfsl1WO6yNkl6NTlOM2eKYxKflOyZeRBi3v6yS+KtMc7GyZ24z/K1EHAoB19/RIBxM22TSRdG2BexZuwR7a5RM92UegceTif+jy+Tna/bceZLqvJayNIazQYzhsLBw==
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 11:28:20.4300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4698240b-e073-4dd3-e94c-08dc4d87d722
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C708.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2963
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28274.007
X-TMASE-Result: 10--19.343400-4.000000
X-TMASE-MatchedRID: zPTG0b+aJkB+P9X2YpqgJg0vIxjiU4qa+bMNqByZrThgGncd4UL3wjFs
	YwY0RDZrL6i+4hIrtWis0HnzywbzyUKoEC/clj5U1tM63VFvEPmVmuhG06IIbShHN604Ejh+byZ
	DI9hJ3AVcAf2s/XIiJ6nKVwCUkQCkbf/bpbzNEDFzoxCmHXb7+uyK4FdEsFZChlhgYTkUArK06I
	QNqLPXs7Jo2G7RknMtGVpXbIDItBGHXEtxeZW06OsfkPrj7CaqUuqb3o0OIosFX1JqaNriOBRL5
	4g5lkI+kAafHqa/bYwlToeHyJK8Sx9SZHV0Ej3HkeeqD5STBM9NMNY2L2K/D/2OliWH2p1srf8w
	z4ESzw83et//UjNpWfnvV4wGvJWytF4vznTVu9/4MTnOvlqF3BAHEUDztk84oQxni7GotoBswfm
	utPEm1/V5R3sVrNxuoDY0aYvvcctl4A8862sgDcFwCSR9lLGI2j7jyCKpnCf6eDrkstFBca+eCS
	MeOiOkfZ9uentPYeaJcb4M4L3rfqQ02atb0iKZO/mB2+12nNVaOxpgjiWHdQKmARN5PTKc
X-TMASE-XGENCLOUD: 63416605-403f-408d-a4dc-aa42dffd4f3c-0-0-200-0
X-TM-Deliver-Signature: 306D567026554B15A869E35E9A8E86A1
X-TM-Addin-Auth: ah4P3v0G8L4Jn4ztEz5lj3qxNgPH67/yiEU1jt7T3rzAjR0RWoPbHJmOe86
	0jhFBrx5VtkT0QYjKnAZRVwb+x95QmtjKxDH2sL72JxXMTz/8nhDiuM1tQTQuA3RI+EltxN4VIs
	vEee1dLi0KVybXSz97JgimSjviEyHRjvyaDdw9GDewIoDlLcwbv6wbqg5IVL7erizDG4odF9Dyu
	VjEdOj9VnbEFdU26hNolbOpppMmn97n7XHJyIvTwok6//BwpsEom+7IT2/FNuJ0Sapiu/zC2SaD
	cY6a5lf7+ocebgU=.K0kOAYZtGIuusIhNH0moucN8wR1l4W78nlPYC4ow39o9yar/U0T8uAHdGa
	Kvnw8uD9HMdcjA7wDc9kJYOcVQ58rC1yydWu4rI4u1iXDHAKiYp93D68ccyM1+C6qzemDBId+bL
	GagxgEYNtRX/Pk7sEPFx7l0b6qrOKlS3Q2vrfLqJrWN09YP4lnqrmX3MnWcfrYUdFj6tiud4ft5
	+i5P/T0Wmh34uQnvMH86zWNiAhhdg0yQW7kxF3wcuq8pGPtkSMKhFwVWKZDv89+W6IFkGjkP2sP
	qo0FZA2EPn76ppzTWmCnfSW/WUDbLLYwnSUdgBEOCbZVkNWK47D+VD+Y6qg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1711452505;
	bh=wKyMQAA+Uxoy+QGvQRqJWzaaAFFlsL78bfMPLvmTuHY=; l=3795;
	h=From:To:Date;
	b=W4J+An0N19xD59q1tu3AIy25U4dH5wk8Ws5BaYK+RHIT/mnSDGo3UcO6hVlN95+tP
	 ftrhyACDTwLjHOBBQywgTt9JBSxLb2ZI0kSe0bw4s+5FcKZKEuqVQICQGf8vmUuz1x
	 j5M9qs94ewNFvGg5x98XQ/tVYUbtYNGgpI+SKP/o1YtNGBI/OmuUNEo8yHWaImAYpg
	 oXD5f+gDVe27svbu5bhZt5v+ynPbWQJPsfwmdRDDa6QB89/Wul997J88lo79bc3XFZ
	 sRV0OidpjzS3DQ6xIyX1axmZXlGCUnD8IRDSaKn1w7jWMDanLOqWtHKlMTw4p7XWIB
	 J3wiioom5VxnA==

This is the 3rd non-RFC version of a virtio SPI Linux driver which is
intended to be compliant with the the upcoming virtio specification
version 1.4. The specification can be found in repository
https://github.com/oasis-tcs/virtio-spec.git branch virtio-1.4.

This driver is the successor of the 2nd non-RFC virtio driver.

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

Changes between 3rd virtio SPI driver RFC and non-RFC driver V1

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
  
Changes between 1st non-RFC virtio SPI driver and non-RFC driver V2

- Remove some comments stating the obvious
- Remove error trace when devm_spi_alloc_host() failed as this is habit
- Add some blank lines to improve readabilty
- Last TODO comment removed which was used to trigger some discussion.
  Discussion did not take place, most probably the code below is correct
  as it is

- Abstained from replacing "Cannot " by "Failed to " in error messages
  as the wording "Cannot " is frequently used even when "Failed to " has
  the majority. Announced this, heard nothing about this, so added the
  "Reviewed-by" from Viresh Kumar <viresh.kumar@linaro.org> as
  everything else was done.

Changes between non-RFC virtio SPI driver V2 and V3

- Child spi device tree nodes are supported now.

  If a child spi device tree node exists the setup of the user mode SPI
  device is done by spi_register_controller() and the driver itself does
  not call spi_new_device() any more to setup the chip selects.

  If there is no device tree child node the SPI device sets up the user
  mode SPI devices autonomously as it was before.

The virtio SPI driver was smoke tested on qemu using OpenSynergy's
proprietary virtio SPI device doing a SPI backend simulation on top of
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
branch next/stable at the time of testing (tagged v6.8). An almost
identical driver version was tested on hardware using kernel v6.5.7.

Removed "Reviewed-by" from Viresh Kumar <viresh.kumar@linaro.org> again
as the changes while small may be considered as substantial.


