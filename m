Return-Path: <linux-kernel+bounces-13372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250AA82041D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 10:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DE41C20C0B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008B22561;
	Sat, 30 Dec 2023 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="neS6J+tG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378523A0
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:subject:message-id:mime-version;
  bh=TOUPRdNxaxvAai5DzjAa4JS1sGru7neFvgD9gRt7eo8=;
  b=neS6J+tGrtcOdwvFmvNTuuc/YUlneuGz/ig7cyOFLscm+O3Mf7vLSyDp
   xrv8oKWNWuRdUeFfVerdq/yHSEB2VbxlXJO69+xTi49zAOxmeREOul0T5
   Ey/Cssx+LdUQaDlHA9jyzuBgxCy5ETnfzdrEAxqFAPG+hpAW0JxhmbHSu
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,317,1695679200"; 
   d="scan'208";a="144358278"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2023 10:19:18 +0100
Date: Sat, 30 Dec 2023 10:19:17 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>, 
    Miquel Raynal <miquel.raynal@bootlin.com>, linux-kernel@vger.kernel.org, 
    oe-kbuild-all@lists.linux.dev
Subject: drivers/mtd/mtdcore.c:577:1-23: WARNING: Function "for_each_child_of_node"
 should have of_node_put() before break around line 594. (fwd)
Message-ID: <alpine.DEB.2.22.394.2312301017590.3057@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-884759604-1703927958=:3057"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-884759604-1703927958=:3057
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

The of_node_put on line 598 should be moved just before the break on line
594.

julia

---------- Forwarded message ----------
Date: Fri, 29 Dec 2023 14:19:34 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/mtd/mtdcore.c:577:1-23: WARNING: Function
    "for_each_child_of_node" should have of_node_put() before break around line
    594.

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: "Rafał Miłecki" <rafal@milecki.pl>
CC: Miquel Raynal <miquel.raynal@bootlin.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8735c7c84d1bc5c3e481c02b6b6163bdefe4132f
commit: 2df11f00100d7278185a9dbefa20ba3f5d32401d mtd: core: try to find OF node for every MTD partition
date:   1 year, 2 months ago
:::::: branch date: 6 hours ago
:::::: commit date: 1 year, 2 months ago
config: loongarch-randconfig-r062-20231222 (https://download.01.org/0day-ci/archive/20231229/202312291448.6KecWcxf-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202312291448.6KecWcxf-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/mtd/mtdcore.c:577:1-23: WARNING: Function "for_each_child_of_node" should have of_node_put() before break around line 594.

vim +/for_each_child_of_node +577 drivers/mtd/mtdcore.c

c4dfa25ab307a2 Alban Bedel       2018-11-13  548
ad9b10d1eaada1 Christian Marangi 2022-06-22  549  static void mtd_check_of_node(struct mtd_info *mtd)
ad9b10d1eaada1 Christian Marangi 2022-06-22  550  {
ad9b10d1eaada1 Christian Marangi 2022-06-22  551  	struct device_node *partitions, *parent_dn, *mtd_dn = NULL;
ad9b10d1eaada1 Christian Marangi 2022-06-22  552  	const char *pname, *prefix = "partition-";
ad9b10d1eaada1 Christian Marangi 2022-06-22  553  	int plen, mtd_name_len, offset, prefix_len;
ad9b10d1eaada1 Christian Marangi 2022-06-22  554
ad9b10d1eaada1 Christian Marangi 2022-06-22  555  	/* Check if MTD already has a device node */
c5f5d0cd40e3bc Rafał Miłecki     2022-10-04  556  	if (mtd_get_of_node(mtd))
ad9b10d1eaada1 Christian Marangi 2022-06-22  557  		return;
ad9b10d1eaada1 Christian Marangi 2022-06-22  558
7ec4cdb321738d Tetsuo Handa      2022-07-25  559  	if (!mtd_is_partition(mtd))
7ec4cdb321738d Tetsuo Handa      2022-07-25  560  		return;
c5f5d0cd40e3bc Rafał Miłecki     2022-10-04  561
c5f5d0cd40e3bc Rafał Miłecki     2022-10-04  562  	parent_dn = of_node_get(mtd_get_of_node(mtd->parent));
ad9b10d1eaada1 Christian Marangi 2022-06-22  563  	if (!parent_dn)
ad9b10d1eaada1 Christian Marangi 2022-06-22  564  		return;
ad9b10d1eaada1 Christian Marangi 2022-06-22  565
2df11f00100d72 Rafał Miłecki     2022-10-04  566  	if (mtd_is_partition(mtd->parent))
2df11f00100d72 Rafał Miłecki     2022-10-04  567  		partitions = of_node_get(parent_dn);
2df11f00100d72 Rafał Miłecki     2022-10-04  568  	else
ad9b10d1eaada1 Christian Marangi 2022-06-22  569  		partitions = of_get_child_by_name(parent_dn, "partitions");
ad9b10d1eaada1 Christian Marangi 2022-06-22  570  	if (!partitions)
ad9b10d1eaada1 Christian Marangi 2022-06-22  571  		goto exit_parent;
ad9b10d1eaada1 Christian Marangi 2022-06-22  572
ad9b10d1eaada1 Christian Marangi 2022-06-22  573  	prefix_len = strlen(prefix);
ad9b10d1eaada1 Christian Marangi 2022-06-22  574  	mtd_name_len = strlen(mtd->name);
ad9b10d1eaada1 Christian Marangi 2022-06-22  575
ad9b10d1eaada1 Christian Marangi 2022-06-22  576  	/* Search if a partition is defined with the same name */
ad9b10d1eaada1 Christian Marangi 2022-06-22 @577  	for_each_child_of_node(partitions, mtd_dn) {
ad9b10d1eaada1 Christian Marangi 2022-06-22  578  		/* Skip partition with no/wrong prefix */
c5f5d0cd40e3bc Rafał Miłecki     2022-10-04  579  		if (!of_node_name_prefix(mtd_dn, prefix))
ad9b10d1eaada1 Christian Marangi 2022-06-22  580  			continue;
ad9b10d1eaada1 Christian Marangi 2022-06-22  581
ad9b10d1eaada1 Christian Marangi 2022-06-22  582  		/* Label have priority. Check that first */
c5f5d0cd40e3bc Rafał Miłecki     2022-10-04  583  		if (!of_property_read_string(mtd_dn, "label", &pname)) {
c5f5d0cd40e3bc Rafał Miłecki     2022-10-04  584  			offset = 0;
c5f5d0cd40e3bc Rafał Miłecki     2022-10-04  585  		} else {
c5f5d0cd40e3bc Rafał Miłecki     2022-10-04  586  			pname = mtd_dn->name;
ad9b10d1eaada1 Christian Marangi 2022-06-22  587  			offset = prefix_len;
ad9b10d1eaada1 Christian Marangi 2022-06-22  588  		}
ad9b10d1eaada1 Christian Marangi 2022-06-22  589
ad9b10d1eaada1 Christian Marangi 2022-06-22  590  		plen = strlen(pname) - offset;
ad9b10d1eaada1 Christian Marangi 2022-06-22  591  		if (plen == mtd_name_len &&
ad9b10d1eaada1 Christian Marangi 2022-06-22  592  		    !strncmp(mtd->name, pname + offset, plen)) {
2df11f00100d72 Rafał Miłecki     2022-10-04  593  			mtd_set_of_node(mtd, mtd_dn);
ad9b10d1eaada1 Christian Marangi 2022-06-22 @594  			break;
ad9b10d1eaada1 Christian Marangi 2022-06-22  595  		}
ad9b10d1eaada1 Christian Marangi 2022-06-22  596  	}
ad9b10d1eaada1 Christian Marangi 2022-06-22  597
ad9b10d1eaada1 Christian Marangi 2022-06-22  598  	of_node_put(partitions);
ad9b10d1eaada1 Christian Marangi 2022-06-22  599  exit_parent:
ad9b10d1eaada1 Christian Marangi 2022-06-22  600  	of_node_put(parent_dn);
ad9b10d1eaada1 Christian Marangi 2022-06-22  601  }
ad9b10d1eaada1 Christian Marangi 2022-06-22  602

:::::: The code at line 577 was first introduced by commit
:::::: ad9b10d1eaada169bd764abcab58f08538877e26 mtd: core: introduce of support for dynamic partitions

:::::: TO: Christian Marangi <ansuelsmth@gmail.com>
:::::: CC: Miquel Raynal <miquel.raynal@bootlin.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
--8323329-884759604-1703927958=:3057--

