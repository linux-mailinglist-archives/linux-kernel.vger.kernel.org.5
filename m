Return-Path: <linux-kernel+bounces-61167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18766850E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C867628115C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06EE17998;
	Mon, 12 Feb 2024 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="anYLrnEt"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58CF749F;
	Mon, 12 Feb 2024 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724634; cv=none; b=hnQIeY8ROJtOsM1vTQ2/9pnbV4ieuSwuK+DvX8grOR9QH5MsbmCPDOnN05dXvv/lLuOi5CC1zJXqz071bxXCp1iDIj/m5cSvPissyi4s+bLpr87KgJgNBK5Vsn6/T8yOPAQuKOuAo4yJSpeISB3OIebXjie9KzkmscXh6f3FdIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724634; c=relaxed/simple;
	bh=akj2o61fKpwaYPHm8Yxzo/FzHPHlKlIu1XNMHBAC0LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLDoMn7jjMQq3tkPIORveRcN8+m5PfUzNSreNJZZJ+9J5qSCskRgcYCl2QNNPCOjUV9gS1Wa26KwJzfE/O5ZaH5GLZK/Ndbu3FbsB0IIcZ9BZhw7apLvdPc2Q6zqNe3h7Aw7VWYqK3NQVz3TA/V4H745+7qdWS/zt5BiE4O8W3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=anYLrnEt; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 39DEE4000A;
	Mon, 12 Feb 2024 07:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707724627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSfZQ+fRkCMgKK8xfkXLcaIY0CpWpwvD1FeC5lzh3h8=;
	b=anYLrnEtEVvT0YdPtp2AydSd2VPAKV3yjnsyBRg416L1sl8TIQrPVLrNGjHsj96pO7EJPc
	LWKUWZb1ZEgj9p8wZaq3pSuZouPxJJg0u9Ib+P22NwOgmFZId4hOh6KobbsLQB/eTOP0xR
	bvvpNql+3RYXDXLYuGwm83wfcKoSu2R9SuLvPblTvlN72GmPWjfQDLogSnXjyxzoohLi4j
	YXck9wAjrczG319bB+hs80+P7BftTaLBku1XQVMoMiuK4DZi0/wc6RjYUsLuDlATkTPaAw
	1oF/sgRRIEalTvPK9s6uIgmiFZhmDz2UwQ759vDX1kbj8pkE2LZu9BerE2fT4g==
From: Herve Codina <herve.codina@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [RESEND PATCH v3 0/6] Add support for QMC HDLC
Date: Mon, 12 Feb 2024 08:56:35 +0100
Message-ID: <20240212075646.19114-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212075646.19114-1-herve.codina@bootlin.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

Note: Resent this v3 series with missing maintainers added in CC.

This series introduces the QMC HDLC support.

Patches were previously sent as part of a full feature series and were
previously reviewed in that context:
"Add support for QMC HDLC, framer infrastructure and PEF2256 framer" [1]

In order to ease the merge, the full feature series has been split and
needed parts were merged in v6.8-rc1:
 - "Prepare the PowerQUICC QMC and TSA for the HDLC QMC driver" [2]
 - "Add support for framer infrastructure and PEF2256 framer" [3]

This series contains patches related to the QMC HDLC part (QMC HDLC
driver):
 - Introduce the QMC HDLC driver (patches 1 and 2)
 - Add timeslots change support in QMC HDLC (patch 3)
 - Add framer support as a framer consumer in QMC HDLC (patch 4)

Compare to the original full feature series, a modification was done on
patch 3 in order to use a coherent prefix in the commit title.

I kept the patches unsquashed as they were previously sent and reviewed.
Of course, I can squash them if needed.

Compared to the previous iteration:
  https://lore.kernel.org/linux-kernel/20240130084035.115086-1-herve.codina@bootlin.com/
this v3 series:
- Remove 'inline' function specifier from .c file.
- Fixed a bug introduced in the previous iteration.
- Remove one lock/unlock sequence in the QMC HDCL xmit path.
- Use bitmap_from_u64().

Best regards,
Hervé

[1]: https://lore.kernel.org/linux-kernel/20231115144007.478111-1-herve.codina@bootlin.com/
[2]: https://lore.kernel.org/linux-kernel/20231205152116.122512-1-herve.codina@bootlin.com/
[3]: https://lore.kernel.org/linux-kernel/20231128132534.258459-1-herve.codina@bootlin.com/

Changes v2 -> v3
  - Patch 1
    Remove 'inline' function specifier from .c file.
    Fix a bug introduced when added WARN_ONCE(). The warn condition must
    be desc->skb (descriptor used) instead of !desc->skb.
    Remove a lock/unlock section locking the entire qmc_hdlc_xmit()
    function.

  - Patch 5
    Use bitmap_from_u64() everywhere instead of bitmap_from_arr32() and
    bitmap_from_arr64().

Changes v1 -> v2
  - Patch 1
    Use the same qmc_hdlc initialisation in qmc_hcld_recv_complete()
    than the one present in qmc_hcld_xmit_complete().
    Use WARN_ONCE()

  - Patch 3 (new patch in v2)
    Make bitmap_onto() available to users

  - Patch 4 (new patch in v2)
    Introduce bitmap_off()

  - Patch 5 (patch 3 in v1)
    Use bitmap_*() functions

  - Patch 6 (patch 4 in v1)
    No changes

Changes compare to the full feature series:
  - Patch 3
    Use 'net: wan: fsl_qmc_hdlc:' as commit title prefix

Patches extracted:
  - Patch 1 : full feature series patch 7
  - Patch 2 : full feature series patch 8
  - Patch 3 : full feature series patch 20
  - Patch 4 : full feature series patch 27

Herve Codina (6):
  net: wan: Add support for QMC HDLC
  MAINTAINERS: Add the Freescale QMC HDLC driver entry
  bitmap: Make bitmap_onto() available to users
  bitmap: Introduce bitmap_off()
  net: wan: fsl_qmc_hdlc: Add runtime timeslots changes support
  net: wan: fsl_qmc_hdlc: Add framer support

 MAINTAINERS                    |   7 +
 drivers/net/wan/Kconfig        |  12 +
 drivers/net/wan/Makefile       |   1 +
 drivers/net/wan/fsl_qmc_hdlc.c | 807 +++++++++++++++++++++++++++++++++
 include/linux/bitmap.h         |   3 +
 lib/bitmap.c                   |  45 +-
 6 files changed, 874 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wan/fsl_qmc_hdlc.c

-- 
2.43.0


