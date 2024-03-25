Return-Path: <linux-kernel+bounces-116554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DA588A0B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873D61C37B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEE01487E2;
	Mon, 25 Mar 2024 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="ImHP03Du";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oC4RHPrN"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE691487F7;
	Mon, 25 Mar 2024 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345810; cv=none; b=BmN0V7Ds3ZpcuCj+ofMNw2709GR6+3ww5XoXOddt11gMZoQ6/HAu3O+atgOZR1eXMQkXRb3+Vj6MH6b2vV9zX+xget066yI4hhWsXY1TkPDIgHYl6VEI2+4DDe+yXyzl772fMkBqKH0Dw8w1esRKOS6M6gCUV2zauREYSE1O+ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345810; c=relaxed/simple;
	bh=R5F1sCuv07c2gXHxPP4bDuP4gk0uzrinmcQ9DxKvGNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfaLZtvwO1tzgNj/hIv/gFymJ8XMYGTr0L3X7rn0NIovfYtrl0cxMbtO8iF1hnch2zrA6ogfgkao2qgXHNExlNsYnLaSqFvnwvbMC+YdWrk/B48Fhe9EOAWedgEb//94x2ToIPcAWJmfgrZXTB/L4YBOvlGeyuq7J8FToGsBjNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=ImHP03Du; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oC4RHPrN; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id C80EC13800F9;
	Mon, 25 Mar 2024 01:50:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 25 Mar 2024 01:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1711345806; x=1711432206; bh=iqvDbzDeTvgQwXec4P1M7
	lVLZPAxb2s+KgS8gBIeABc=; b=ImHP03DubdtYIeGCrCPZkAVY4Mr+XkuPs8Lnh
	mTU1kYuPpb6aGGVp+E39cnhO5Yf2QznU0I4FEhHdzkvO6hoUhvcBmagAICsYqhYx
	lvr4VR6fE0IxUqb0C8utpeVcBw5ki5VNKaiRhHG32GwtUOBawSbBNReu13BJU2g1
	QZGDM1wtSgQYf+kDYPx0DFLaNEnCZLEw0JCpg2yxxs01TvPcsQLDCciGfqygG//o
	+gxoXVRu6DH6sFOrCshnS2gqzNa2n8qCmVTh/xOdTir718pzCiPYfcnSk/dV5d4d
	g9li3WskGMTSfIn2qcHTxfOGazsx431GLXzOdhq/pzImTZRmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711345806; x=1711432206; bh=iqvDbzDeTvgQwXec4P1M7lVLZPAx
	b2s+KgS8gBIeABc=; b=oC4RHPrN4UqJWmTW/tKTba05axeDJAw+ClP4xMukE+Bl
	0No2d4qtZy0OfmQul7maTQUunJtQqhvGZ/EuoFhh48blcSkBcDI1VnpFnxeiYOsb
	UiMXZMsx12LOwYV1ge1577nRJP8UUT6Ia7QImb9GTkpKgEBphXs1RhiCoktOJNy4
	czLKXJYwUtnipE7fdic5+WkGZaWv03HSD9Ow5WkuT+znsavrP4HHfMEZjeTOq5tG
	C2IwLOT8xaXB5C0NXmFn3WDdXfdfxmjLnC7fuhLvvcyHX6bDD8/N5mI393guGZ/Y
	DTLsFPtcjOCzw1M/2c6xw3ifhCWgjW9YoMgkAKMkYg==
X-ME-Sender: <xms:jhABZt_pcXa9c5dECfKx8hTDwaWGs_4CRyEn1SrNcCCDYx_0_VnENA>
    <xme:jhABZhsKKQoDKMiUBAT7OSMcDdepTaLfN_nWROCv_mXInpH3JGXBxhOY2796o1Vjn
    jjp0kMWSv31yxbE-8c>
X-ME-Received: <xmr:jhABZrDn0eStiDCoqKfYbQMfL1Q-XOKy6VqL9gFbi4H5Db6Od7OnwNQYpxze>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnheptdehkeeigeeggfelkeeufeefjeduvd
    ejveduvdehtdegveeftdeugeetvdeltdejnecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:jhABZhcyq35CdZyPnj3t_XI8TowIcntipUEjEw6NpgqgL_Vl3y36Cw>
    <xmx:jhABZiPCXBkzKBZTKMEeDD0l-qH9Eg9Y414_zWmHQlIPw-tYAHVgzw>
    <xmx:jhABZjm3FPZGzppNB7V5H4o_fV0iytDATzJCNkXO_mcdVEl3z0lUyg>
    <xmx:jhABZsvKmCzEdT5updNru2mYPu3qQQ2wTg6GtlV-0DoPTqwDGu9IXw>
    <xmx:jhABZuCEOTupMXq62_Tj2htzFFPKjyHKtVHiRT8eGO7Yux-LJIFsrg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 01:50:03 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 0/9] asus-wmi: add new features, clean up, fixes
Date: Mon, 25 Mar 2024 18:49:29 +1300
Message-ID: <20240325054938.489732-1-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series touches quite a few things along with adding support for some
new features.

- Add support for mini-LED on 2024 ROG lpatops
- Add support for the gpu MUX WMI call on Vivobook laptops
- Add support for the POST boot sound on ROG laptops
- Add support for MCU power-save (ROG Ally only, saves more power on suspend)
- Store written values for ppt_* features
- Small formatting cleanup
- Small fixes to cleanup struct holes found with pahole

Obsoletes:
- https://lore.kernel.org/all/20240320011442.11608-1-luke@ljones.dev/
- https://lore.kernel.org/all/20240310065408.63703-1-luke@ljones.dev/
- https://lore.kernel.org/all/20240310061715.16531-1-luke@ljones.dev/
- https://lore.kernel.org/all/20240310055312.11293-1-luke@ljones.dev/
- https://lore.kernel.org/all/20240310233722.30884-1-luke@ljones.dev/

Luke D. Jones (9):
  platform/x86: asus-wmi: add support for 2024 ROG Mini-LED
  platform/x86: asus-wmi: add support for Vivobook GPU MUX
  platform/x86: asus-wmi: add support variant of TUF RGB
  platform/x86: asus-wmi: support toggling POST sound
  platform/x86: asus-wmi: store a min default for ppt options
  platform/x86: asus-wmi: adjust formatting of ppt-<name>() functions
  platform/x86: asus-wmi: ROG Ally increase wait time, allow MCU
    powersave
  platform/x86: asus-wmi: Add support for MCU powersave
  platform/x86: asus-wmi: cleanup main struct to avoid some holes

 .../ABI/testing/sysfs-platform-asus-wmi       |  26 ++
 drivers/platform/x86/asus-wmi.c               | 386 ++++++++++++++----
 include/linux/platform_data/x86/asus-wmi.h    |   6 +
 3 files changed, 339 insertions(+), 79 deletions(-)

-- 
2.44.0


