Return-Path: <linux-kernel+bounces-9758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2456A81CACC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEEF4282ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFBC19BD3;
	Fri, 22 Dec 2023 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NeqxTdbq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A071CAA9;
	Fri, 22 Dec 2023 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BMDaILU032374;
	Fri, 22 Dec 2023 13:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=bky3hG1Jynbv2MF60GqEpZXdaKhDc+ZIc+AoWweCBRc=;
 b=NeqxTdbqAhiAELgaPdsvIDEqPWr+x/n5MrzKZyUGGFh9/O1LO0g4Bwk1msMPUon2d/YU
 9BmKyi97JPOKz0qr1mNie/aAIckXxOPbD2zG4/d/EHfV/c6sW/bcj5njQBFQM3A/ONnf
 6nxT0rFln4z6ecxLCiPMShs2xoq9czyaUyn1NjcDLSo7qefeU4zLr6AkMnG1NkUjxxbP
 kwjNi39gJKaP7t3k4+1u16ECYZ9wG7HfayD3RFWSBKIX1HlV6HMftqdMTZ4+t3g/j8E9
 wvUsbrPPeAjOVskZ+LaxeOAYkHhQgNm+MWe/m0kjVBMDWrruXVBLvYRsVqzmxj1vR2+f Wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p4dqtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 13:36:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BMDQXLh024975;
	Fri, 22 Dec 2023 13:36:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bksdjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 13:36:56 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BMDauGU000703;
	Fri, 22 Dec 2023 13:36:56 GMT
Received: from localhost.localdomain (dhcp-10-175-57-47.vpn.oracle.com [10.175.57.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3v12bksdgb-1;
	Fri, 22 Dec 2023 13:36:55 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Breno Leitao <leitao@debian.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next] Documentation: add pyyaml to requirements.txt
Date: Fri, 22 Dec 2023 14:36:28 +0100
Message-Id: <20231222133628.3010641-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-22_08,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312220099
X-Proofpoint-GUID: ffs6MtFJ0j2KMLTJF7Z6CpvALAI9ZP9r
X-Proofpoint-ORIG-GUID: ffs6MtFJ0j2KMLTJF7Z6CpvALAI9ZP9r

Commit f061c9f7d058 ("Documentation: Document each netlink family") added
a new Python script that is invoked during 'make htmldocs' and which reads
the netlink YAML spec files.

Using the virtualenv from scripts/sphinx-pre-install, we get this new
error wen running 'make htmldocs':

  Traceback (most recent call last):
    File "./tools/net/ynl/ynl-gen-rst.py", line 26, in <module>
      import yaml
  ModuleNotFoundError: No module named 'yaml'
  make[2]: *** [Documentation/Makefile:112: Documentation/networking/netlink_spec/rt_link.rst] Error 1
  make[1]: *** [Makefile:1708: htmldocs] Error 2

Fix this by adding 'pyyaml' to requirements.txt.

Note: This was somehow present in the original patch submission:
<https://lore.kernel.org/all/20231103135622.250314-1-leitao@debian.org/>
I'm not sure why the pyyaml requirement disappeared in the meantime.

Fixes: f061c9f7d058 ("Documentation: Document each netlink family")
Cc: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/sphinx/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 335b53df35e2..a8a1aff6445e 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,3 +1,4 @@
 # jinja2>=3.1 is not compatible with Sphinx<4.0
 jinja2<3.1
 Sphinx==2.4.4
+pyyaml
-- 
2.34.1


