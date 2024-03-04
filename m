Return-Path: <linux-kernel+bounces-90870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB31870616
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FAB28C1AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCF94CB47;
	Mon,  4 Mar 2024 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="GQBri/AH"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A474C3C3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567046; cv=fail; b=Oz+xIciwgZ69tSB+aF5wVGauF65vjBTR+mwH4sR0Zq4hCvesrVt8U5/5QM2I3JhGgDg7qJq/CLw7+OVQWwN0JVSBFc3r6Xd4lDtK3FB66UdS+dKbmTIRwi/VBR0g7LtfdH+mOK8ANtwyN/yHISLqz/9UwuUKZG9kAH7ME4+YBtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567046; c=relaxed/simple;
	bh=nSqEmGSaKT1lr7Q/XpmUfpi6lwVLIwXt2MztnVGaHoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cEgHpdB3O8i6k4kcJ4ytK8+aGy6220/frmyWw7E2/9fhph7vZGuH3OxO09sXiUxZiyMW7rR5FflCJI1VW29nyqwbfQSfx+MXxNZ759Cf5mB2GBnR7Hr1xkhaKWgalGTbGHFHCks0gCUhe04DE1fPjTez8PJyqKLJVALR3MIfS2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=GQBri/AH; arc=fail smtp.client-ip=18.185.115.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.162.72])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 949F210000D0A;
	Mon,  4 Mar 2024 15:43:57 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1709567035.225000
X-TM-MAIL-UUID: fde3fafc-98b6-4055-99ab-9574f179bcdd
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 370AA10000E52;
	Mon,  4 Mar 2024 15:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNnEoa45kEdHaHiivoEzmSPAEXfEZPl5AKZnhSCjJPoV5F0OFaPMECEXvAbJrMseYkHORGAu5p3tl5JslIShRUbL1RQHjSMaqrOz4ZLKcETUWGlmhTpDUWbwWHn+F9+cherakAkNnzPljVCcK953beJ48lvhuKRo7U/FngOo069rOxAm9SjAamyM87w/fu1pj3X5GopJwdSIn7Xesr2ZIKYlCkIKIYbPsNX3LdcYUVyYThDTRrRfA4+3xc9zkMICOkF3rI7MRqiSwiyUM/nq4XXypmc6wAbtCFcTv9B2JBBr/kUnx0xfbOFhzE9hz15/3PyhcZHnfRa8Hg3k6F7Y8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VT2WeqmP/aDu/fhcGbBd5kYHkq8z2lpWJjuD43SUBio=;
 b=m8BCOSBXZZWUtlQihdK0EzycZ0iLJ4M2SPnSKuU2hgtARg6i2LUIZAF4PReSBG6ZNxnrbokGD/sQextzpKLR+IqrsvmxyZn6iKNalcDrqVjTs9XutMSmbcrY3Eks0mjb1jsCDxUV8qldRUtuDDJmbbLGQac5a6Ty4oKT31d0FALhcNpAIz+RAsnWX83714swJ54ZV6JOitaemX3Mhg+48h2s/HY600d74IwWAFfmTxzQUONknzhlw5I5m2j++s4IHMRPEBKapinTxtZ2JIOOpQgpsLfGMJnDZLMS902JLEVYILguwAkcOQ9NDhNPj/nU8COz7i8jKXz9Rtwvxk+iKQ==
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
Subject: [PATCH v2 0/3] Virtio SPI Linux driver
Date: Mon,  4 Mar 2024 16:43:39 +0100
Message-Id: <20240304154342.44021-1-Harald.Mommer@opensynergy.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A2:EE_|FR6P281MB3629:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7f6c3d2f-ad44-4b1d-c688-08dc3c61e548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	34KlbyN8euMh2xst41KcjpjhqrRp9V8VdHFRosANKApOIWoLZu+BoTfxUpgwXV5L5l2bn3zJOzT9qAXgoiKRNjpriQraEDVMyW1IfJvOOrMsaxkSPTU3RfV8e0OGs0CJqhufRxpf2dpT+B09HLM1i/bJsvwABomLQvSRiowPeL4/i8GQUznqy3cruSY3Gz7UQ+4xJwN4OVh8vTJIiRPIOMmAKW28J0FZFiqB1OVRm1rxrE36D+PZ2KYFmytN81q0eGe6MwJbbl6I5FliUud8ivk4BXlCcg9MFLWrBSDLPc6iz/PEVIW6EgIpD9SBr+klpLcyGclhpTHc/10yBfGKveSauaUEJfFqSPN9ue3He/hNsXgcc4LAdhmhGBuDGlMZ3ejJiNgLdCQJ5BEtPtr+GkovJPz9Exce5KCMrpgUUBugSvjXEoUEFHcXbert2qqPi8V2MpD/VbOsDLGws0REhJaRuWB1+9/VKM4Z8Q5ii2ZrEApH4LjeECnVqlPugxO3UTXnVzKUNpaAveFT25aa8dKdzKcHGM5i2zaT6mlM0VlzKCLzvvqrNbjTmTyHu052U48TbU7Wgkt/OuloqN8j1UMnrQVM+i/RBYhRwRGsOeNy54jEFbPciwkBkeRAUw6rvuxVyoySo1nVqL3Ezi8WbVtPslhNQkth90seTbtUntDicJpOxsMy0vIhkUiw8ckBx9TEF2tsD2EPZk+R6GCDAA==
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 15:43:53.5232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6c3d2f-ad44-4b1d-c688-08dc3c61e548
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3629
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28232.000
X-TMASE-Result: 10--12.476900-4.000000
X-TMASE-MatchedRID: GBRRVxh6iep+P9X2YpqgJg0vIxjiU4qa+bMNqByZrThgGncd4UL3wtvg
	EYRNbHS38+Sy0Kb1RsB+bMqzm+sLBtGWdb4fn9mBAszeqtinEnsWRcTK0fEGOb2L79/20sYbS/c
	jG/gfmu8VUYZTT6p1OshYa+kuusm6cE3FwWrm18QLOnhkOkWpfSd8voqopKNvuzAg7efo/wXYHk
	MT0O/LF1UzWEVEXZ/MsXn4SpgL43YBXLfU7YcIf0sfZgIcSmI9YfwVmaD2H4ZwLNL3IuElDR5Wy
	kMoTtfXIdEt8j0U+5Q3JoGmac9XrcgQrXecJrZF0A1Umn1aDodISqO7uCT8S0uJfM58tqmeaftC
	e5kj6T6BK7jsLKFqkSEEB+1mvDOoi0Lxf1aMtgRyCBet3G8bCqgclxRwe1qqKIN+Wah9iR51WON
	HT78wn+0Dx9so3Ua56xA0Ava73nBcOnqpgy+bqxEuOqgkm3/1h7z+gmKKj0oDf6I8jFx+tlmLzQ
	cf60TusLrqnOPE+us0zI7+eiZZ8FIwpoXl+YmJG/hIVZB14aWDJncORRtCoDxhmyH8K1MxfZ0lX
	QE3j4E=
X-TMASE-XGENCLOUD: 914cd6c8-c0af-4979-b93d-6c4a0d9e9547-0-0-200-0
X-TM-Deliver-Signature: 47F24A8628BD228EA66B4C1759F723EC
X-TM-Addin-Auth: 5oZO3qT9/dOUIailRiIfh9Ok/CqAIM18qiBbNU3JWjubatd87ey90S4LUyc
	MXMsJRgLt8Hy4zqghgoTAoHME83xxSxp9ck8ECW/4bYAAvrDFPwg4DtXIiulgljXMlR4hPKQuS6
	jVVXsJuVQGQYD6wKJYaa3AbA56VziSBJQTA+Xp7Lwdlsmz4tGsqXuvUUYkXVivLuiE5ttiC8QHI
	UK/miyXkZJZbqlFLN+rNmAzvxfPkGIyppHoDHObg2i2FnkK5h6M+E7qLHEa6xrIEO7wobs3xgKm
	Z6p4Iy1QXvWerHU=.hoJ3QOGJ08O3lv5Y2R+BtzGFYaSWtjeLhJg1/WRRLFVXU/Mq8yIxOJrS3u
	UHgtainZYFpH8TyVPGfAq0ceCm/qL/8wBd6QXSN9LJx/745v3lBOkHP+A7I/EwB2fG8anoeIqXD
	lpLLwf7IIE2BhaCK6KDOFAE5Jtq97sFsXynbsC79tzA3rZQhgycEdp6Mobf5eU0/CT5fFOv7khR
	l/3/zaXAJ1cPdTYF2sJ3sXFHJblH6R1E+Uwx3H69C2GyXFfT0CklIpyk98j/jCCRis1A/sN4e9E
	pyrzZk3URmZ+mNkth3/KkVU96myiW3YoBcJZQTELwctTYZO2zb1eD8VWgnw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1709567037;
	bh=nSqEmGSaKT1lr7Q/XpmUfpi6lwVLIwXt2MztnVGaHoQ=; l=3357;
	h=From:To:Date;
	b=GQBri/AHzxrSE0TIiSDFvMO4unThtoC4mlg/kgMvmlQTck7zuKilOCLpVxo8SMenE
	 OSisyTCBK0zIiJ3FJT51FpEJs/K9LO0gIyhAl7ZshWczJn4Eh2wRjJsrmTgDmdsxG3
	 LUqlCfcISnWiI4Bq3po6xLcPzOzscX+/kUhdxn80FPN0HephbTPgClU/dHsUWUYmzE
	 h2/FQOqZdmFV9V3xSu1n3wWjPcymbMCjD2XIR64ehdYVsE2atdCzvPhRbL2M5Zd5j5
	 YEo8IxhRlCigjRVwcQIh1sok6IeAbC+bzBkk8c6eCNEptZhpLQxh0lNX6CGWOFzKSL
	 quXRgpvW0Lo9Q==

This is the 2nd non-RFC version of a virtio SPI Linux driver which is
intended to be compliant with the the upcoming virtio specification
version 1.4. The specification can be found in repository
https://github.com/oasis-tcs/virtio-spec.git branch virtio-1.4.

This driver is the direct successor of the 1st non-RFC virtio driver.

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
  
The virtio SPI driver was smoke tested on qemu using OpenSynergy's
proprietary virtio SPI device doing a SPI backend simulation on top of
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
branch next/stable (tagged v6.8-rc7). Changes between v1 and v2 are so
small that target test of the adapted version of the driver on Linux 6.5
with target hardware providing a physical SPI backend device was
omitted, there were no code change code paths normally taken.


