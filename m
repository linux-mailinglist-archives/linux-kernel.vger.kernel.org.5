Return-Path: <linux-kernel+bounces-26034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC07E82DA31
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105951C2191D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A6017543;
	Mon, 15 Jan 2024 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="IM7PXIYa"
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F68171B4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.9.72])
	by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 742CA10A72DF4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:37:26 +0000 (UTC)
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.165.80])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 6AF4810000D02;
	Mon, 15 Jan 2024 13:37:19 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1705325838.822000
X-TM-MAIL-UUID: 8615e246-9924-4019-a52a-0167866a1afb
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id C8D08100003DA;
	Mon, 15 Jan 2024 13:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vc4ZFncztq8K65DV2nLCYjBA1DWvoy23lPcwPl2z9f/HpPcjG3iCvVaEALqxRStSGA7ErWGOZ/2rQkNks4vyCZGltFVm0rIr0MZFgSE2zsLDdA1sqGca5cLQ8Zno0kyCPdnhPSkPDWRpsdx7rXZSQ5M02Y3n3skXABadSxBX9M9ILWpNsIQWosI0qW8gVVbTuJjtE/WYcIzJW7ovVksiGBh4uM9WCgmHPx5HqKNtwOFApLMrKbJS/t0jkiFx7R9gCZUomxTSPWLFJYwhgo+tbURfXwBm9BThYTOvc94ZVO5I1SyTIkODDscDA6gYmGqEqIpdnZbzin+BjN5bn2lTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSZVHG/I0pFRAfTVrjwk/pb/uazazlGXO5sB4Sfd6jA=;
 b=RRp2qaCrooIKauMzfwvG9lK9I8Qsh+4nydonvz6wj516oHTv3y9bLqtbqsO5rZHGlE9BEryvVnnXb5TT0wtby3/kAgq+BSXMV3uXsWxRNID5UEb8LletonJm1WZD3CFdBXH7V2a4YsNbSp2REPBjIpgmmdWNg91MtUsPMe2y+ZxMH+JmHixa3PI3usYeiNX5FtJYnNhH7KFT/v6fQXABltR6wuDMeqQkGN+wHhKuGxqYuUil00xWDm3WBd44oIF6QbOkCehe7Sw365LLPU97USnbCwoZBQtcxQdLjTvbyiO+b5pyAH3kqG1h1SqfISG0jE/X8cE+AY+HDXYtnvOtmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensynergy.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=opensynergy.com; dkim=none (message not signed);
 arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Subject: [v2 PATCH 0/1] ALSA: virtio: add support for audio controls
Date: Mon, 15 Jan 2024 14:36:53 +0100
Message-Id: <20240115133654.576068-1-aiswarya.cyriac@opensynergy.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT021:EE_|FR3P281MB1802:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3cca41-1307-4c99-e825-08dc15cf171c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GrFSFLXTD/NtuWHKfhPZUls0Lxv80M81MgyRFD6NsbeWoL4e9eU3NWWIDv6tykvDOchKw35NJ+VU9uLDyLDG8SGU2srMUZqesLQWWIQ3kZ1qwJOwtzWsx05rX3HuDKZjP/UKQ6SqH2HLkP/GGftB+If72Aip2Xy0+jaDtpOMUa3aSwTAu6qXs4ga9pIpFfMiIAeA+qC3AEXlONCFifQXfLeg5kizkFja4ZpGP4SEqqueq1mr/2K3er4yKq0mt9CG/wmlqRY4qmIpAUvtuVWGC7hlW6q/GRpbZVVPq1FX7LhJwC9gCyUQHQHzULhoP8ZFLXpcjAZ6VJQFdPh7n+4x73zHEG2iQFCe7pvXbklhrTOZEd0WZyIf3cE1evAzC991O3CU+37x1KPzQU71ju6/J6x3Z5CgApCDY8ZDJDzIos/3LaVWQ8AlA/nWk2UAsUMw8eZs11Zt+4hET3ihUf2lUN/n0tAfwCdrro/xlVWmcvnfWKYdFsmUt6YKAPa+IIs+OnETic56komJWlDeMNV3iW/I7D12wVCyo7qtvwqYRj7NbXKPCGWP9hK8Z2DI60QFVlHsgPLBO0hvyHhpypqLOGaoRo6VJTPskREQa4WgDbgJ34xL2MawcdjCW9zreXl5zXMZ4Rf5orflyGAo4c2xtceAPB5zd0n7GDVH3HkjROlXHmjJl3H5eHixgXr9n7A2CJYTYV16KLY9yWTHsnsWbPEX+MZFfkEqdzsFeG88mhJSvNu2PXUgawiEknt0fYRv
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(396003)(39840400004)(376002)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(336012)(2616005)(478600001)(26005)(1076003)(44832011)(316002)(8936002)(8676002)(36756003)(42186006)(70586007)(70206006)(966005)(81166007)(4326008)(107886003)(86362001)(47076005)(36860700001)(2013699003)(5660300002)(2906002)(41300700001)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 13:37:16.8858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3cca41-1307-4c99-e825-08dc15cf171c
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB8EUR05FT021.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1802
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28120.006
X-TMASE-Result: 10--2.321700-4.000000
X-TMASE-MatchedRID: GQw6Xh/XS6Um0dhXKknEYlIqxe4Du375QY6l9K/GjIa3UJJ8+n/4RTGk
	4C4tTtZDZTt1c61q8EC5ZLMflDc75zpDTzfGTRASI2nKN0pwPwHGOkxYqopOQz4mDuxB3Odo/Km
	F6PXUvSGUfGQGyvqnFGqjjgt3rom+k/dA6P3T5FuSHQtEOSQwHMogIowo7lY9MHiMmW0ZUNuJRl
	VRJlV6D8A2iDfbpfy+AVpeDm8nJoK4YW3IPBlDmmoEkqixPwVYTTiPv6gRtv1aOxpgjiWHdcjHc
	hynrO5b7AEHE68Gb318fzBUh/2Yd7SDyM/+PEMUDWGgbPrHoak=
X-TMASE-XGENCLOUD: ed0abfd9-966a-4a32-b53d-6c541c7034d1-0-0-200-0
X-TM-Deliver-Signature: 5E8E6E2A6622A031937B205A563B1D11
X-TM-Addin-Auth: /xs3mT/P6rJZk2jae1Z62L97wYVf4DZ4rOkPC8zXVRRRHoFGD8PGOTRbprg
	uf4hpFgwDJx1Xfodnqlo0GSDDZNBp8I9rHZWm9JqPv1eQO0c7RZ8nkMa/tKaVLI5rigKE5uFMCH
	jeo8UIyPahA5IGmW7tjFgKRPvW23x8MSe9c7cSemqsE6QbMfdnsJ79emm1DQ27zLDFutNy0fZf0
	n30jkp+L58BcCqUe2v643sjLoo/h0xCiJ0Ao8DG/sfMIXI02tcq9Yauo0b6HkdOeRCjxuedf4pI
	DwkF93Hu1ykjq5Ra7+KKQdkaaNvgTspJh7p/.BDtZw6fT+wdRWSX2WcdyKKJYvcGGimuXsg7YbK
	12c4ULpseOIN64kw3gKT9BNWenPKlaU2oP1f/uG+4BfYkHvaXqjsnqkSSP3Z7VZcjuAVUH5d9G2
	pVw1FF+9rbZFYda3HaXu8g3x3kfqwNuz5bKNIh9x+0ild0UozA0pJv4hdgKj/7G4K2GBItO+L80
	+SgZWvaSRaVGqYwSo9ThJDNyaZr1I1ay68E78o1ZI7UiTeFNbe0fWm7jv4sitJ7eADT4I7bomQL
	Rk4OQgzVmhOMkSgGdrVuI/FaucEtegYRoFvC47TWWSvoSFZYF0qpKA4sg8NvalQ7t7TbHz4t78B
	86xg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1705325839;
	bh=/RHN5jq42jdyKdGjr7hlYXSY9JHtEC5aQZizLOsFL4g=; l=1199;
	h=From:To:Date;
	b=IM7PXIYaFFD7uo/wxcGIyt2p7dzIewC9CyXq19NYHZeFG9iBS9Hyk+ms1SidMdaV7
	 XE1Iin3OQNKDBJFPV3k85zqCEb6oJatBmnHmpkaIZN6jw/VsosRXOWY3TjajnZGHFU
	 l7SksojCeX30fhQen6oynWrihy4q6uD0vz6YRZaFZGT6Bt5N1Z48ShZwqZaKk6CrsT
	 hrUGE2OCiUH2Cxem+vY8obJf3meeX7aISkJpO/U/Llq+j+o+zLw9TrVMvRCydqoiP9
	 JPTsn9ZzW5+qUTX19yVhH7IKXoDT5eMHsfQBw1hwblomjN9Wx1IQLBj7mkKMQ5f5vo
	 +qkpZ4ru0iYdw==

From: Anton Yakovlev <anton.yakovlev@opensynergy.com>

Changes in v2
- Fix reporting of incorrect number of items for ENUMERATED controls

Implementation of support for audio controls in accordance with the
extension of the virtio sound device specification[1] planned for
virtio-v1.3-cs01.

Design　of virtual audio controls is based on and derived from ALSA
audio controls. It allows the driver to perform all standard operations,
such as reading and writing audio control value, as well as working with
metadata (represented in the TLV form).

The driver part was tested on top of the Linux 5.10 kernel.

As a device part was used OpenSynergy proprietary implementation.

[1] https://lists.oasis-open.org/archives/virtio-comment/202104/msg00013.html

Anton Yakovlev (1):
  ALSA: virtio: add support for audio controls

 include/uapi/linux/virtio_snd.h | 154 +++++++++++
 sound/virtio/Makefile           |   1 +
 sound/virtio/virtio_card.c      |  21 ++
 sound/virtio/virtio_card.h      |  22 ++
 sound/virtio/virtio_kctl.c      | 464 ++++++++++++++++++++++++++++++++
 5 files changed, 662 insertions(+)
 create mode 100644 sound/virtio/virtio_kctl.c

-- 
2.25.1


