Return-Path: <linux-kernel+bounces-83546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE081869B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AC2284DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE311468FE;
	Tue, 27 Feb 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aXJBuXUI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D61D1468E7;
	Tue, 27 Feb 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049213; cv=none; b=otun2WrDbQrzttqdGYo0s2nhlmecVocqsWOJDHlueDAJqYcCkJBT6o5Wpa1Cb30fAl0EuYPglLhnQWZTBJzARVUb4vRlt7bhwSuiotwudo/WTvlNrOA+2cnw5FbM2lDbYQC6GJHmOprKD9XvlN/IHLLoI9285kU/xXyNtEGMDn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049213; c=relaxed/simple;
	bh=jsF2wHju+sh1rsni+UJBVrbmg2QxJUfOLijH/amOaZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NysDlwxeZqzpfRV5huQfRIgfPOkmOoTkYWKcCGEAejZnzbzuNR80R9L2fgDq5NNLVBOZwi5uON4/9JEVCddzNuk7OFI6ikQfGySw50J/wxreh9c7LKunWlKdxqw5jgdnN0o9rEfIMmyy0kfm+MK1/PhOrXsrlc/CoVQc5jMlrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aXJBuXUI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9XvY0030791;
	Tue, 27 Feb 2024 15:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=IV1qgDC
	t3fwVQa4CIWhsIsshEEAUM3GFeB2yrlEz+qM=; b=aXJBuXUIIXKYGv9NbrsFS9Z
	fEFCXWxH9RQ41iQ3l1mGU9Y5yULWStP9C+FxZjpBGNSwf6fNsOiSrstlLkQ7+ApK
	R9j2qghX0GA1LvTu9RnH4TK78oOM0UPLhioMGvQQYTg6zXpRZGM3PvnXU0wMfFSv
	BS5pJDKVpALHXuAh508ymjtcNqaf35i539cVdkG3GAdOQ8+RVOHd1dQyXon9Ec/4
	XQ83UV3ZDpkomO1OjeAZCxI208VXcUK8fSvQcila6l2fERo8oO+NI1dDDpbz+xfa
	A8Sun0s/7esXthLWwJeaNc7eEjg2nuzZayE7Sv1CwteHcvjRMt9+0+cc6lmgzmA=
	=
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh6nrhqvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:53:27 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RFrQUm028375
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:53:26 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 07:53:23 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        Mukesh Ojha
	<quic_mojha@quicinc.com>
Subject: [PATCH v12 0/9] Misc SCM driver changes
Date: Tue, 27 Feb 2024 21:22:59 +0530
Message-ID: <20240227155308.18395-1-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GvGkMsG5xC1j3Bfi34jQzPhZjdnA1sm8
X-Proofpoint-ORIG-GUID: GvGkMsG5xC1j3Bfi34jQzPhZjdnA1sm8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270123

Earlier version was just introducing secure rmw API introduction
and its use in pinctrl/scm dload register.

Current version also seems to fix some of the identified issue
in scm driver code.

Patch #1-3 patches are for secure rmw api.
Patch #4 is slight optimization for the newer SoCs.
Patch #5 is using the introduce api.
Patch #6-9 try to avoid NUll pointer or to remove redundant code.

Change from v11: https://lore.kernel.org/lkml/1704727654-13999-1-git-send-email-quic_mojha@quicinc.com/
 - New patches #1 and #6-9
 - Renamed scm_query_lock to scm_lock and reuse it in qcom_scm_io_rmw()
 - Added comment for scm_lock

Changes from v10:
 - Rebased on linux-next tag 20240108

Changes from v9: https://lore.kernel.org/lkml/1698648967-974-1-git-send-email-quic_mojha@quicinc.com/
 - Added 3/4 new patch.
 - commit subject modification.

Change from v8: https://lore.kernel.org/lkml/1698235506-16993-1-git-send-email-quic_mojha@quicinc.com/
 - Introduce enum for dload mode constants as per suggestion from [Elliot].
 - Rebased on linux-next.

Changes from v7: https://lore.kernel.org/lkml/1696440338-12561-1-git-send-email-quic_mojha@quicinc.com/
 - Rebased it on next-20231025.
 - Added reviewed-by tag and take care of comment made about
   commit text should be in imperative mode.
 - Modified the name of the API to qcom_scm_io_rmw() as per suggestion
   made by [Dmitry]
 - Moved spinlock inside qcom_scm structure.
 - Corrected the patch order as per subsystem SCM first then pinctrl.

Change from minidump-v5(13/17-15/17):https://lore.kernel.org/lkml/1694429639-21484-1-git-send-email-quic_mojha@quicinc.com/ - Removed mistakenly added macros.
   https://lore.kernel.org/lkml/9da888dc-401a-4cbb-b616-b4654fa79e35@quicinc.com/
 - Added Acked-by tag from Linus.w to 2/3.
Change from minidump-v5(13/17-15/17):https://lore.kernel.org/lkml/1694429639-21484-1-git-send-email-quic_mojha@quicinc.com/
 - Removed mistakenly added macros.
   https://lore.kernel.org/lkml/9da888dc-401a-4cbb-b616-b4654fa79e35@quicinc.com/
 - Added Acked-by tag from Linus.w to 2/3.

Changes in v6: https://lore.kernel.org/lkml/1680076012-10785-1-git-send-email-quic_mojha@quicinc.com/
 - Rebased it on latest tag available on linux-next
 - Added missed Poovendhan sign-off on 15/17 and tested-by tag from
   Kathiravan. Thanks to him for testing and reminding me of missing sign-off.
 - Addressed comments made on dload mode patch v6 version

Changes in v5: https://lore.kernel.org/lkml/1680017869-22421-1-git-send-email-quic_mojha@quicinc.com/
  - Tried to fix the issue reported by kernel test robot
    https://lore.kernel.org/lkml/202303280535.acb66sQT-lkp@intel.com/

  - Applied some of the improvement suggested by [Bjorn.andersson]

    . Dropped 'both' instead support full,mini or mini,full for setting download
    mode to collect both minidump and full dump.

    . logging improvement.

Changes in v4: https://lore.kernel.org/lkml/1679935281-18445-1-git-send-email-quic_mojha@quicinc.com/
  - val should be shifted within the function [srinivas.kandagatla]
    i.e new = (old & ~mask) | (val << ffs(mask) - 1);
  - Added Acked-by [linus.walleij] on pinctrl change.

Changes in v3 : https://lore.kernel.org/lkml/1679070482-8391-1-git-send-email-quic_mojha@quicinc.com/
 - Removed [1] from the series and sent as a separate patch[2], although this series
   should be applied on top [2].
  [1] https://lore.kernel.org/lkml/1677664555-30191-2-git-send-email-quic_mojha@quicinc.com/
  [2] https://lore.kernel.org/lkml/1678979666-551-1-git-send-email-quic_mojha@quicinc.com/
 - Introduce new exported symbol on suggestion from [srinivas.kandagatla]
 - Use the symbol from drivers/pinctrl/qcom/pinctrl-msm.c.
 - Addressed comment given by [dmitry.baryshkov]
 - Converted non-standard Originally-by to Signed-off-by.

Changes in v2: https://lore.kernel.org/lkml/1677664555-30191-1-git-send-email-quic_mojha@quicinc.com/
 - Addressed comment made by [bjorn]
 - Added download mask.
 - Passed download mode as parameter
 - Accept human accepatable download mode string.
 - enable = !!dload_mode
 - Shifted module param callback to somewhere down in
   the file so that it no longer need to know the
   prototype of qcom_scm_set_download_mode()
 - updated commit text.

Mukesh Ojha (9):
  firmware: qcom: scm: Rename scm_query_lock to scm_lock
  firmware: qcom: scm: provide a read-modify-write function
  firmware: qcom: scm: Modify only the download bits in TCSR register
  firmware: qcom: scm: Rework dload mode availability check
  pinctrl: qcom: Use qcom_scm_io_rmw() function
  firmware: qcom: scm: Remove log reporting memory allocation failure
  firmware: qcom: scm: Fix __scm->dev assignement
  firmware: qcom: scm: Add check to prevent Null pointer dereference
  firmware: scm: Remove redundant scm argument from
    qcom_scm_waitq_wakeup()

 drivers/firmware/qcom/qcom_scm.c       | 162 +++++++++++++++++++------
 drivers/pinctrl/qcom/pinctrl-msm.c     |  10 +-
 include/linux/firmware/qcom/qcom_scm.h |   1 +
 3 files changed, 128 insertions(+), 45 deletions(-)

-- 
2.43.0.254.ga26002b62827


