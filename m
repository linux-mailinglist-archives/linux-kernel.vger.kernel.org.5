Return-Path: <linux-kernel+bounces-31425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BE3832E28
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95961C23DA3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4D755E6A;
	Fri, 19 Jan 2024 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="jMRR+7u3"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821EC54789
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685373; cv=none; b=Iog9WK5F22NwP9nVViEuPvJymROulLg1Jarw0vbLBuINF5CpJ5MC96T4CTcfkKoS8JTYudcQba3xSxeJa0B+WTu+uGYxnEvcudKbet6DZ4A/gumRSRK+E6E/0tBqY1eFCZF0RAjSKurW3nYPrIerKMaoxbmbqRSR1r2DZYVFeZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685373; c=relaxed/simple;
	bh=qzdeZGxUGBe60J7tTRbF1FCXYOXStUYMyGSBHlyeVlk=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=oxFSs0oWIr95nukZc45cWFbjGdyPpwqfEAgxXUJcTtnRDiySlaWhg5n9gpInegCKySKKRDAohnU7kg1deB0Z8ZIEyRnYMD63V0MQ7CaIRub7fr4NYbz1YvhyaTvAIrHXKkm9y2e2ADC7aGM/R+2nueE+6DNTmSrYMd4P1rDBCv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=jMRR+7u3; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Gd5rRvCvk7A7t8hfY2Ir18pxSCWpF0XNjMnF+Cgs/V4=;
  b=jMRR+7u3rrx/jO1/tk/gc3ZwUu7OOA0dcdghvSrJZQZ7OinPBf/ASdw8
   Z+ZvovxBSLJ/mxh79XsY8NRS1sAy6molzXIwUV0l/YXIMLAYJtda4JMSW
   gTyv8/O+lszdw/yz9VscbsiL39QA8/OiSddhplnRFAOmJUkZcljkcv29a
   Q=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,204,1701126000"; 
   d="scan'208";a="77312799"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 18:29:22 +0100
Date: Fri, 19 Jan 2024 18:29:21 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/usb/typec/tipd/core.c:1159:17-18: WARNING opportunity for
 min() (fwd)
Message-ID: <36170c8-2d89-6c70-7e1d-1b52e950c7a1@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Just a suggestion.  You could also consider that he code is readable
enough as is.

---------- Forwarded message ----------
Date: Sat, 20 Jan 2024 01:27:01 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/usb/typec/tipd/core.c:1159:17-18: WARNING opportunity for min()

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Javier Carrasco <javier.carrasco@wolfvision.net>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d1694dc91ce7b80bc96d6d8eaf1a1eca668d847
commit: 4c3ea81aa8e11400f24e5541bf46c2cadb4202e9 usb: typec: tipd: add patch update support for tps6598x
date:   2 weeks ago
:::::: branch date: 15 hours ago
:::::: commit date: 2 weeks ago
config: i386-randconfig-053-20240118 (https://download.01.org/0day-ci/archive/20240120/202401200150.XOjrMEhu-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202401200150.XOjrMEhu-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/usb/typec/tipd/core.c:1159:17-18: WARNING opportunity for min()

vim +1159 drivers/usb/typec/tipd/core.c

7e7a3c815d22170 Abdel Alkuor    2023-10-03  1127
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1128  static int tps6598x_apply_patch(struct tps6598x *tps)
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1129  {
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1130  	u8 in = TPS_PTCS_CONTENT_DEV | TPS_PTCS_CONTENT_APP;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1131  	u8 out[TPS_MAX_LEN] = {0};
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1132  	size_t in_len = sizeof(in);
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1133  	size_t copied_bytes = 0;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1134  	size_t bytes_left;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1135  	const struct firmware *fw;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1136  	const char *firmware_name;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1137  	int ret;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1138
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1139  	ret = device_property_read_string(tps->dev, "firmware-name",
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1140  					  &firmware_name);
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1141  	if (ret)
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1142  		return ret;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1143
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1144  	ret = tps_request_firmware(tps, &fw);
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1145  	if (ret)
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1146  		return ret;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1147
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1148  	ret = tps6598x_exec_cmd(tps, "PTCs", in_len, &in,
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1149  				TPS_PTCS_OUT_BYTES, out);
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1150  	if (ret || out[TPS_PTCS_STATUS] == TPS_PTCS_STATUS_FAIL) {
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1151  		if (!ret)
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1152  			ret = -EBUSY;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1153  		dev_err(tps->dev, "Update start failed (%d)\n", ret);
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1154  		goto release_fw;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1155  	}
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1156
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1157  	bytes_left = fw->size;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1158  	while (bytes_left) {
4c3ea81aa8e1140 Javier Carrasco 2023-12-14 @1159  		if (bytes_left < TPS_MAX_LEN)
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1160  			in_len = bytes_left;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1161  		else
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1162  			in_len = TPS_MAX_LEN;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1163  		ret = tps6598x_exec_cmd(tps, "PTCd", in_len,
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1164  					fw->data + copied_bytes,
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1165  					TPS_PTCD_OUT_BYTES, out);
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1166  		if (ret || out[TPS_PTCD_TRANSFER_STATUS] ||
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1167  		    out[TPS_PTCD_LOADING_STATE] == TPS_PTCD_LOAD_ERR) {
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1168  			if (!ret)
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1169  				ret = -EBUSY;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1170  			dev_err(tps->dev, "Patch download failed (%d)\n", ret);
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1171  			goto release_fw;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1172  		}
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1173  		copied_bytes += in_len;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1174  		bytes_left -= in_len;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1175  	}
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1176
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1177  	ret = tps6598x_exec_cmd(tps, "PTCc", 0, NULL, TPS_PTCC_OUT_BYTES, out);
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1178  	if (ret || out[TPS_PTCC_DEV] || out[TPS_PTCC_APP]) {
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1179  		if (!ret)
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1180  			ret = -EBUSY;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1181  		dev_err(tps->dev, "Update completion failed (%d)\n", ret);
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1182  		goto release_fw;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1183  	}
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1184  	msleep(TPS_SETUP_MS);
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1185  	dev_info(tps->dev, "Firmware update succeeded\n");
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1186
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1187  release_fw:
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1188  	release_firmware(fw);
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1189
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1190  	return ret;
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1191  };
4c3ea81aa8e1140 Javier Carrasco 2023-12-14  1192

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

