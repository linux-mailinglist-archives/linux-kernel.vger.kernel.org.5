Return-Path: <linux-kernel+bounces-16694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C2482428D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A32287860
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51F722328;
	Thu,  4 Jan 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="tapHwWJ3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174F821343
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.19.113])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 4DB6C10C38463
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:01:53 +0000 (UTC)
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.190.17])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 28A7F100017B4;
	Thu,  4 Jan 2024 13:01:46 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1704373305.800000
X-TM-MAIL-UUID: 325a088b-9946-47ab-98f4-9e6177fccd91
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id C368010005E05;
	Thu,  4 Jan 2024 13:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1w3KTcjIGUE+nHq+idj8P7QjKERDjeFbWl4Iyj+30fqynVXktWtzdLj2KL++kO/EGAsaQ9/OcSoGuALHhSGv2XlH74Qa1rsvNVVudCD5W5Uf3VAjoLgKlZ2ARZ/4UTRhV/s7ttoMP8EhXju5Nuv6mceyWrT4q+UCK3WX4XKtNzfU9Ama+9WXOqyqj9QGTr17sKxdtQEJyC8P146hgYQoF7UUhNgEyJlV3w9c6+xYaimfrjk57P4VFDiVBv5QIhify3GbnNfCoPAMU8gBizKWsamIz+m/HG84hYx5xjt3vBQiP8ur11ANLW4i2vNGnXjHw1zEF6RuLRcqvb8OYTI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD4bLclCZpuMviRRRXjZPmSxZGAril918v4sguIz8IE=;
 b=K3gYWs2DTpPW/lnzNdhXz8onyHckKwox0xSg77XTXX+jMgEPXiLUo7AP7HuRA/WrH8dDZ5xu785PVR4ZhZ+nNL0Zl1PLofOF68eiCbzA9owhOaTjksbTLjwiyFJMtGg7l6imfgo878cAnvVCd9lmsdPWoS8SOW34SIAsnG52imnBl/vEHLiL0x4cvk/6FIfcyOELLnefQCNH7bYTM7sKOh0B0E330521i6TGWtpq/NGrYWb95NloF4ZoExdj3cH5skzdyathM5xuPA5GMnEOx9KJl9sqq+LzVCMB0n1vu143ymctbQXRJkikwR1X1U2SHsw/RgI3bSkpYIYsRG9mIQ==
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
Subject: [RFC PATCH v2 0/3] Virtio SPI Linux driver compliant to draft spec V10
Date: Thu,  4 Jan 2024 14:01:26 +0100
Message-Id: <20240104130129.17823-1-Harald.Mommer@opensynergy.com>
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
X-MS-TrafficTypeDiagnostic: AM6EUR05FT058:EE_|FR0P281MB1657:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 968e96ec-a6f2-418e-1829-08dc0d254d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2LsLELJlGMKhu/beQmokZ32xT1SzHQChohsd7rOfKdoGbIzqrsE5bLDqncpk7xCHOOjHq/3zAQR5FySmqcvINaPSElGTzk6L4adzAA3LcIwlh/y4DQWmgLhg9c7jbINKrv/sjIS5VSQo0GfWdCRqfOfKk5FVN2DFI09g+Hwbi+zLY40lh4pNczlRGPgjnJxVTZjOW5MdryReKZ0mD/QZ9vqPQU3crTJmgQtxweoRe+yh9zLmydgL9oEFs0jKyAMb3KO49dCrgka6r/I1leWlufHB5ogzSN/nsoK4oCxOtwn45aaa44mCLGVJjPr6yTbQQP2+WQFY5t7NsVyNsgcjfsVBUD+CFlfWitA3f4b7QmuonvGHU9G57wMOhS0ktE07tBF+3GvkMLyXrT6sgw22j+Ee7cgSI/a24Bl6vcf0JYiolXjqKT60GE/q9v3Ng8UA1RG1pTuwLYpZdP1iSGPdt7tuJlMVG8fjznmXCYimxL85+ZhrvC9SzUPno8kW/igUl0gOhGm8OXSBmB89J7YH4YUAZ7BOWu9Rcim2ml5NQpZNkmnIWtFAzEMn7S0KgqS0CieGVxWhXu1ZyuqH3PJ9YBTcDb0AqxitZ63nPqeChh+L90Kge6D+2ih7Uhqa+Z0xMWZFTka1ssr0FWjdC5kIacI+3jkUM1jrguENtu0z3xQIf8UPNt179f46WXeJY/y6pXExEM5NcA8cjmAV8zmseRfi5luqhdO+oQPH7LT8wjlQiC5me0KtwLQ1XpVxLEuwMsaR2leGnzzyJNWqTy29fS/glOEhv9/kvGvKbsbTvn4=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39840400004)(346002)(230922051799003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(46966006)(36840700001)(40480700001)(36756003)(70206006)(70586007)(336012)(86362001)(81166007)(2616005)(83380400001)(26005)(2906002)(107886003)(1076003)(41300700001)(47076005)(4744005)(478600001)(316002)(8676002)(36860700001)(110136005)(54906003)(42186006)(8936002)(4326008)(5660300002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:01:44.3915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 968e96ec-a6f2-418e-1829-08dc0d254d7c
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM6EUR05FT058.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1657
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28098.007
X-TMASE-Result: 10--11.032200-4.000000
X-TMASE-MatchedRID: M5ojAfE2AMVFXrD9KUuNErIyl8KAIcW/3B1hSgpgA3P7Bamin45J3C1A
	/qnDlqGPPXE7GzZeNWqfc2mI/RAws4zsraOzq+6IwXAJJH2UsYhyfGzN/EfYKSbHySXVad36r54
	JIx46I6R9n256e09h5olxvgzgvet+uULRkEvU8xpIkEj2f2VroVo7GmCOJYd19Ss5ONHRGPWuNO
	ssio6KLbpz7vHwsYikqkjov5EB47zRySc0IgjcZw==
X-TMASE-XGENCLOUD: 33d3a4f6-edfd-4113-8135-551c91594638-0-0-200-0
X-TM-Deliver-Signature: 3BB8C31667B9E50F7F4C847EFC64DE87
X-TM-Addin-Auth: U6Do99F+N1LiRu/MXehP8zf90HWMvMe9nz9GNU3dGDsnAXv6DXCmXPtiEBy
	aT9SSugZV0kn5yHwy3++Rl+NHYaElHal2n5do+WT+PlG0U1Py95Q5EH5ewSoUj8dXAadUqbSUkY
	KbRlmtuk+54LMyCQm+tpHdSut4shosfJZBu7tqWTvXmn/Zk5jvZbcHqPNI3aXsmrGTnO8jm5hQY
	EHAiEHKwA64BwHSvDcr9NOFhDVfh2NImDwUS49jcFbQSXt8XhKN3TsEguAqWY/CfViY2+zfViwr
	f/FNOc/vEKeFSlQ=.g7sbIF7xRL0MK+YbZ8NYcF4OJ+Fo564jZ7wdcZIBxj7qFs6j5S80tdssxV
	NjqmzaK3LU2MkOtpfNX8KFvjdghIIJztr2AOvSQFNUW83bkiqyWXsM3pDTHvvFC7DC3FGkrA84f
	8Nl+KASADrzpPq0QpJ4m+qC/mXNRPVfvMzSW42+xvs1Laidp2IUc50f926oCdCIlod4IQrpugkJ
	0BY/1z7Ce7fvIjRGOfRcUWlN/4XGPCOMJM95fDl3PtCfnJjqCBqJyQyg+rbwg8NvDThxv8ZPuqE
	lKFF1pUV5QNh0dPm+myzfILM59lPyFH8dYiwu2XYIskSTlPpkGaEU9owL1Q==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1704373306;
	bh=hD4bLclCZpuMviRRRXjZPmSxZGAril918v4sguIz8IE=; l=872;
	h=From:To:Date;
	b=tapHwWJ34dCtYn/EpNLmNb54Nsn9R+ydf09GmfjlTw5Dv6YofnfloM/X3VP7x1SyF
	 6Li0ECtculN40euQNN/Uo3Nl3sFG7lPmaUTe6ztRDmO9FAv4SvTrmErulxO6a1Csid
	 hX2swdg8ML/vmof4jROxkWE2RvQ4BUB3pNT/TbITDDCbCyNTmP6y/UsMC3hRtEWRvH
	 Cf+W2xgyQugh8d4MJ95y6/02YcblXIV4dUBovrjwCoa6+2XtTb+IO0yxvyzhG+bD0T
	 +rpFZwY7H3CYMWnhT+XQC1GkS8+YjAtfAwibw80noXqCm+MbuwpuAh2fOxRgbhMHIc
	 gg4Su7uOwzyZQ==

This is the 2nd RFC version of a virtio SPI Linux driver which is
intended to be compliant with the proposed virtio SPI draft
specification V10.

The 1st RFC version sent out publicly was compliant to the virtio draft
specification V4.

Changes between 1st and 2nd virtio SPI driver RFC:

- Update to be compliant to virtio SPI draft specification V10.

- Incorporated review comments gotten from the community.

A proposal for a performance enhancement having more than only one SPI
message in flight had to be kept out. The more complicated code would
have caused an unacceptable project risk now.

The virtio SPI driver was smoke tested on qemu using OpenSynergy's
proprietary virtio SPI device doing a SPI backend simulation on top of
next-20240103 and an adapted version on Linux 6.1 with target hardware
providing a physical SPI backend device.


