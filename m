Return-Path: <linux-kernel+bounces-63622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB170853262
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01E81C22839
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D065786A;
	Tue, 13 Feb 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="b4nLP7o2"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92154FBB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832453; cv=fail; b=IOZ6DoiQAMz5uXnn3mI2ee2jlTIG0Ymmq27xDBw4fPYkXJsqcXlhylD5AYORPbQA9ytIz/17f1FXKaQVv9fvBiITjwNDzc/Uov4NEGJH99ButYO7rP9wrY+tzm2RrvI37KPcq1ae0+E0RMWylqPPhUuNKKkcO7P4hLkWlw7BvRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832453; c=relaxed/simple;
	bh=Y34A0SU8Ez+v7OqZc/3s2NaEXRAOz6Qdm8Yk5vyeiUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SCGpX29JvjWhX9ESLjErcQakNE/TIY5R6vzAtYfxXbbe9UsBz9IORVbLveEItsmG+ph9mhHyJu2Bh1+5GTwuAdAQ4z7K+LTbHdFYRpvQOcVsbOVHQ5GL6sQpyLuVI5n9xudFpiatxjj9nv0XdeKasvepNai/LEKjFZpsKi3GdT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=b4nLP7o2; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.9.90])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 576AA10036A19
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:54:09 +0000 (UTC)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.193.99])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id C935F100004FE;
	Tue, 13 Feb 2024 13:54:01 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1707832441.348000
X-TM-MAIL-UUID: cf0b964b-b42e-4d70-9522-b667015f844d
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 5529F1000150E;
	Tue, 13 Feb 2024 13:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmzwLLJvfmRrenrtIuMs/oCdFHftLbXalsH0Lpcg6dH50wDZH4JLlPoD8LpPBTUM5xXCtyISCiQOjgxwsUuv6wnd4kkqVueTVcqiSK4CsXqyfgCn7dWvMZ3wZA2HWXLFd+zuYPw1rMWfN1N/esNZR7bjat8Wfv7ksdOrPtA9wJwYcYDEIdym7gfcLGaVMtGCubk4Ag37djtkYzW7XcWJ8o8zD7reKpt+Bh/G/tACmQc0crGPv5Gl6/R5hZGLJKAmpEXGresGCn/M3bHgs2YWQVk5/cSK+t+qgfKGhSYCtY61YoekS1k+EsoTXzHBkgqDaSWqb7lP8uDAK3x+4TgW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=proSnUgtUD10020MrtctP+WI80/HVxHOU75cYNcKQiI=;
 b=nZSXTvZ3TCCpuqPiKkaJyysxY4mfR+DtBJhsWWEDsjWCqw/8xIxPYpsasd0kAxqOvRR1Z7LJojC1A2yhbxBGJYgHBGOcnf/b9S2c41twEHSl2126LyrWiYsQMAfWy/HUkgi3AZmi7MeY1+LJ4wzLB4nm/t1feUdJGnLLW9hDd3DSis5VBABnDgORQUUEl37UhllCuQRxwQNVDfrFT6vesJUXgGODaqZLbi7EUfpMI4zMwIehRUtNdypTHrg/LBlZ8z2llFE1BfTjgUSJp6Fvcg2/lfreZyjKJQFzaQNCwGhWEmoKxyPdPwBvn1xrkpBq/PLHsVFEG2KwUhMsUQKiKw==
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
Subject: [RFC PATCH v3 0/3] Virtio SPI Linux driver compliant to draft spec V10
Date: Tue, 13 Feb 2024 14:53:47 +0100
Message-Id: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9B:EE_|BEZP281MB3063:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9861efdb-492e-44a4-b8c8-08dc2c9b3a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d2Lxy4lbP3FD8X0sq8NZeOZTeuzqEskkgf2zbPlgghtvOls084L4Evu6q3ezRjmlW0KW2Z4tpKYGsDe4Iq2qXMSrkyv19cT5eqRNN5hk2Seznc++HgltVuv/jJSwoSSCS/FBliLz20NfeONUfxNriAMibzGC+4dc9LDDcr5c05aiaE9+QpDqKsKlc3hM4EQnKSo3Y++vLU3eVP6yWoC8kifovXhOI8c3YErJYNrLKFTTM/8mImDka9GVVQ/9dECKoPP7Lu8CBkTgbk1xuTDkAFIETwc3ukphbmeyjbYv7rOZMfK1Lqibu6e8P+ASwOcNPuL5sbNMfgV/UB8d3PNgeLVBBL6nxLIkrqgAyWhnRKsfBZ4ZB9BQ7r4ClPHSm2vDuvoWkSi54m97Xl4hi/bItwBugaKXcD64tnsZU0pl4ZQieSpofqV1S4RYKIgWS5AHqzqipSB9JkwdEhGTUMtmqsFFyOYLW4Ej2Tg/WNLxsfYvkfN1Q1T9KPgSmzzLbYS2hblIXivUUC4mQb9PQh2moNxFu6ugMVkOJ8WorhcMOPBMNiKpPwGlSrPsT2ll0gPVbns4sGZmoYPvEeoM6VjELPKIJAV12FmRBcfSfSue3tc=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39840400004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(46966006)(36840700001)(41300700001)(478600001)(2906002)(42186006)(5660300002)(54906003)(70206006)(110136005)(2616005)(107886003)(83380400001)(336012)(70586007)(26005)(1076003)(36756003)(4326008)(8676002)(316002)(8936002)(86362001)(81166007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 13:53:59.2145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9861efdb-492e-44a4-b8c8-08dc2c9b3a9e
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3063
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28190.000
X-TMASE-Result: 10--5.807400-4.000000
X-TMASE-MatchedRID: UdxqiKKFAzhFXrD9KUuNErIyl8KAIcW/3B1hSgpgA3P7Bamin45J3DM+
	jPWs1TwyCRyXfdSvdmw8BVvUwtAJs+Lm8FY5k1yNOPwPJT+A+aJCKdqcEPNeC5GeN+9dVIq31/6
	WTCeqY2shPCzXmn9t9DHH90MCQqpzbsT0kBZNrmUhPK2mn+OsTMOr2HNR+yxjt1CSfPp/+EWDCS
	dOycy8kxcgNH4AIUmJYReXSC3dfpnsocQd7WY5yEI9AEPfED/dqvJX/aNGr9cSCDdzAMeX/RLdY
	zv1bejiZrfFxrTdHozfY76xzK50wKg7Zo5UOBRpoli4ZoiOHT9+ICquNi0WJN1LCC9OQK7stqzv
	3rgvk8i2lmxaf3h8xnut0zlWRjtHftwZ3X11IV0=
X-TMASE-XGENCLOUD: bdd947d4-acd2-4538-b8de-d770f9c568cb-0-0-200-0
X-TM-Deliver-Signature: F30FAC9FBD3025F9E66A07FBABF5CACE
X-TM-Addin-Auth: ioXJIzpebPhoei7p2a6mK7aAvKIf+Diyc4q/syAJMB0QOJCnmzn+ct7ZhvV
	DegpBrODSu4XuKGhJYWZPsYZ7oNfyvBKiSz8LPUY576W4Eo+uUp0ilAqyikLlP/9RjIPAt5ZO5g
	g/t6IwjEzyGeCHIqW0WHQPHlIEV3mCGXwhTTY+xItCOWLYVJJ33NSNV7I/HTEMKkNqlxPYILN4o
	C2ZnhHVnqupzAbfd+NJqdGuuenpsoyYyUWJ3zoigpO33D+V+1jGvvaw0fPXxrYiW4nhrTA0Op0C
	G6JUBU8chUGKxrc=.htgGgIQhvmhLb3UL5g6Pc+D+rxgN4y7M+x4HYQpngQSzJfPEO6h5aMuedo
	qf8JNrjo3D0x9UmtuJW/JxgBsgEQgaExqnFKoPDsWNLeyyNwVpljPR2dSFQZPJO6ezJZ6W33rDe
	ytqYeOYA62meizKRPZmBGybbIx4TPQ8vfuVAJsFW5x3cUF32IADoRlDwT2UFxJuou5pDqbpxaoC
	4k9yCGUWspd/Z/F8SzMOWNAXhQDoJ3xMS0wl2wdPi6fGmWRdEF3AzCV+2dIBHmGRyD/nORaIApP
	4VmAJxZUMANGvaDsUwfovjmVbvmDJJcAl70MMxAAqx4BGa3KxhqaYEfLWEA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1707832441;
	bh=Y34A0SU8Ez+v7OqZc/3s2NaEXRAOz6Qdm8Yk5vyeiUY=; l=1506;
	h=From:To:Date;
	b=b4nLP7o2BuRnJI6VcWP5lDwjj+y84NnSSSjWxqtbChrpUZoSjD0yiMWEd81EA2E03
	 UiO4zAMpMETOe3RkmeBGRJQGCjieeY9wbvARGcCu4TR41N9bc1gybZQkpvHCEZtxf1
	 +MW34T5lJjXc/IvzcGLCLrUVHS1HwV/A49Q3BQ+sXKV1rK8JY3Q/Vh8LwhjHxZ5NxZ
	 P3rdgFU3/1YS+EDOhdWeHKwurCFop/D7oHgCoMANl77IVt0y2VNQ1bksSX2bbjHOyg
	 mHG2EM4tIKR+tsiwC1jWXOlR0dQ1z3gb/JwujrF+GElYv2QHG3+7qRd6zqGrm8jH8g
	 TfNNgLn7s3+mA==

This is the 3rd RFC version of a virtio SPI Linux driver which is
intended to be compliant with the proposed virtio SPI draft
specification V10.

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

The virtio SPI driver was smoke tested on qemu using OpenSynergy's
proprietary virtio SPI device doing a SPI backend simulation on top of
next-20240213 and an adapted version on Linux 6.5 with target hardware
providing a physical SPI backend device.


