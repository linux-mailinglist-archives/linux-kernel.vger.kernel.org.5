Return-Path: <linux-kernel+bounces-51438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E0C848B39
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A60B2492F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517208827;
	Sun,  4 Feb 2024 05:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WgBf0S77"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849696FBD;
	Sun,  4 Feb 2024 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707024691; cv=none; b=GSUriE8zRpzu9mx6Uh2gH9Midd6H3Vsfg2TUDrHXJ9FRUcqKub2biaRf/Arv+DjiFbdSBBrL5JlbFrRPvDnj7yGcV4IugPRNO9yg9J5wgzfVB/sedu56bmrpfeV4ur3DSfMZhbXzg5sQSsnpfQkfCk8+7GJgCq+3jhnKwtfPXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707024691; c=relaxed/simple;
	bh=6U+8IRbqFICNTC/jcWD9NvlE987Nzn0qYDmUSUgoVmk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ecmuGWnq7aj7TvRR6VWAZiuILe5tPNChNFLS3GeiQ12p+PdnGRCKSgmL0++PKjNXsm3u4cHDhfXDERBc2REv8lK0DJgGJ9zN9f3xzXrO6SaOVv15cIBKQLLteh1GBCCTnkalizRo/lBN0CbHh55yu5SLa6ZmndCpcxWy0bFUQ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WgBf0S77; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4145SVLb028063;
	Sun, 4 Feb 2024 05:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=bjWwX5s1RouBD1JRpaOQ
	JIEjqXnWIn4ZvWQptlM+GOo=; b=WgBf0S77HWIk5H8HGGLkFiXR1miOaAshJxRT
	z/CSuTkDyQ3eGy0HoTY/Z2FLgNb7PW+g48bkEQEvPFMwGGxaaGeSuoA7pSEn9cnp
	CrBNJ3b7YV+Gs1bJEPG78axs8OqpgFZ5qJ2fZVp+dyFbpwVbCibI/Cvu+hZWJG4U
	SeHGdS1hTr/a6IQbOkn3me8/MGmDcaOJFG5waCMU6IqLh8j9gyGivXlrSk5+dcoM
	NDEKVWCFsEfbXsmF4viqpfAFoPxUKLzE6BuHhDUZNHGQe63509F2g22zfpOuV7GH
	+XCWHOQLgzczmIJv0ThW4grmLeF92ZlE3VGO5XRjJAYnlg1cYA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w1ey51aps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Feb 2024 05:31:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4145VCgN003757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 4 Feb 2024 05:31:12 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 21:31:07 -0800
From: Tao Zhang <quic_taozha@quicinc.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao
	<quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>
Subject: [PATCH v7 00/10] Add support to configure TPDM CMB subunit
Date: Sun, 4 Feb 2024 13:30:31 +0800
Message-ID: <1707024641-22460-1-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mJLeGGJyoUPdn-CFLBcsOdsHVXI_q7rg
X-Proofpoint-ORIG-GUID: mJLeGGJyoUPdn-CFLBcsOdsHVXI_q7rg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-04_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402040039

Introduction of TPDM CMB(Continuous Multi Bit) subunit
CMB subunit is responsible for creating a dataset element, and is also
optionally responsible for packing it to fit multiple elements on a
single ATB transfer if possible in the configuration. The TPDM Core
Datapath requests timestamps be stored by the TPDA and then delivering
ATB sized data (depending on ATB width and element size, this could
be smaller or larger than a dataset element) to the ATB Mast FSM.
The CMB makes trace elements in two modes. In ‘continuous’ mode, every
valid data cycle creates an element. In ‘trace on change’ mode, when
valid data changes on the bus, a trace element is created. In
continuous mode, all cycles where this condition is true create trace
elements. In trace on change mode, a data element is only when the
previously sampled input is different from the current sampled input.

The CMB subunit must be configured prior to enablement. This series
adds support for TPDM to configure the configure CMB subunit.

Once this series patches are applied properly, the new tpdm nodes for
should be observed at the tpdm path /sys/bus/coresight/devices/tpdm*
which supports CMB subunit.
e.g.
root@qemuarm64:/sys/devices/platform/soc@0/684c000.tpdm/tpdm0# ls -l
-rw-r--r--    1 root     root          4096 Jan  1 00:00 cmb_mode
drwxr-xr-x    2 root     root             0 Jan  1 00:00 cmb_msr
drwxr-xr-x    2 root     root             0 Jan  1 00:00 cmb_patt
drwxr-xr-x    2 root     root             0 Jan  1 00:00 cmb_trig_patt
-rw-r--r--    1 root     root          4096 Jan  1 00:00 cmb_trig_ts
-rw-r--r--    1 root     root          4096 Jan  1 00:00 cmb_ts_all
drwxr-xr-x    2 root     root             0 Jan  1 00:00 connections
drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_edge
drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_msr
drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_patt
drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_trig_patt
-rw-r--r--    1 root     root          4096 Jan  1 00:00 enable_source
--w-------    1 root     root          4096 Jan  1 00:00 integration_test
drwxr-xr-x    2 root     root             0 Ja?  1 00:00 power
--w-------    1 root     root          4096 Jan  1 00:00 reset_dataset
lrwxrwxrwx    1 root     root             0 Apr  5  2021 subsystem -> ../../../../../bus/coresight
-rw-r--r--    1 root     root          4096 Apr  5  2021 uevent
-r--r--r--    1 root     root          4096 Jan  1 00:00 waiting_for_supplier

We can use the commands are similar to the below to configure the
TPDMs which support CMB subunit. Enable coresight sink first.
echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
echo 1 > /sys/bus/coresight/devices/tpdm0/reset_dataset
echo 1 > /sys/bus/coresight/devices/tpdm0/cmb_mode
echo 1 > /sys/bus/coresight/devices/tpdm0/cmb_patt/enable_ts
echo 0xFFFFFFFF > /sys/bus/coresight/devices/tpdm0/cmb_patt/tpmr0
echo 0 > /sys/bus/coresight/devices/tpdm0/cmb_trig_ts
echo 0xFFFFFFFF > /sys/bus/coresight/devices/tpdm0/cmb_trig_patt/xpr1
echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source

codelinaro link:
https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/tpdm-cmb-v7

Changes in V7:
1. Rename "tpdm_clear_element_size" to "tpda_clear_element_size" in
the patch#5.
-- Suzuki K Poulose
2. Remove the stale comments in "tpda_enable_port".
-- Suzuki K Poulose

Changes in V6:
1. Clear all the relevant fields before setting them in the function
"tpda_set_element_size". In patch#5.
-- Suzuki K Poulose

2. Leave a space after/before '/*' & '*/'. In patch#7 #8.
-- Suzuki K Poulose

Changes in V5:
1. Return directly to refine the process of "tpdm_enable_dsb" and
"tpdm_disable_dsb" if the TPDM does not support DSB dataset.
-- Suzuki K Poulose
2. Change the new property name from "qcom,cmb-element-size" to
"qcom,cmb-element-bits". And update the property name to the new
tpdm example which supports the CMB dataset.
-- Krzysztof
3. Drop unnecessary () around the drvdata member access in patch#5.
-- Suzuki K Poulose
4. Replace the error code "-EEXIST" with the port number in detecting
multiple TPDMs on one input port. In patch#5.
-- Suzuki K Poulose
5. Due to the modification of the new property name, the searched
property name was changed from "qcom,cmb-element-size" to
"qcom,cmb-element-bits". In patch#5.
6. Replace the judgement "tpdm_has_cmb_dataset(drvdata)" with
"drvdata->cmb" in the function "tpdm_reset_datasets". In patch#6.
-- Suzuki K Poulose
7. Drop unnecessary () around kstrtoul() in the function
"cmb_mode_store". In patch#6.
-- Suzuki K Poulose
8. Update the date and the kernel version in the Document.
-- Suzuki K Poulose
9. Initialize the return value to "-EINVAL" and remove the unnecessary
code in the function "enable_ts_show". In patch#8.
-- Suzuki K Poulose
10. Replace spin lock/unlock with guard(spinlock). In patch#8.
-- Suzuki K Poulose
11. Drop _rw from the macro "tpdm_patt_enable_ts_rw". In patch#8.
-- Suzuki K Poulose

Changes in V4:
1. Replace spin lock/unlock to avoid forgetting to unlock when the
function exits.
-- Suzuki K Poulose
2. Move the helper "tpdm_has_dsb_dataset" to the header file.
-- Suzuki K Poulose
3. Fix the incorrect property of the sample in the documents.
-- James Clark
4. Clear the dsb/cmb element size directly in the clear helper.
-- Suzuki K Poulose
5. Correct the comment of "tpdm_read_element_size".
-- Suzuki K Poulose
6. Call the helper "tpdm_has_dsb/cmb_dataset" in TPDA driver to
check what dataset the TPDM supports.
-- Suzuki K Poulose
7. Refine the dsb/cmb dataset support check in enable/disable functions.
-- Suzuki K Poulose
8. Get rid of redundant code in function "set_cmb_tier".
-- Suzuki K Poulose
9. Since one SysFs file should follow "one value", use "dev_ext_attribute"
to instead of the previous "enable_ts" Sysfs file approach.
-- Suzuki K Poulose
10. Change the kernel version to 6.9 for the MSR related SysFs file.
-- James Clark
11. Refine the function "tpdm_simple_dataset_store".
-- Suzuki K Poulose

Changes in V3:
1. Add 8-bit support to the description in the TPDM devicetree document.
-- Rob Herring
2. Change how the result is produced in "tpdm_read_element_size".
-- James Clark
3. Calling "tpdm_clear_element_size" at the beginning of
"tpda_enable_port".
-- James Clark
4. Use "dsb_esize" and "cmb_esize" to determine whether multiple TPDMs
are detected on a TPDA input port in "tpda_get_element_size".
-- James Clark
5. Modify the judgment logic in "tpda_enable_port".
-- James Clark
6. Add more description of "cmb_mode" to TPDM SysFS document.
-- James Clark

Changes in V2:
1. Optimizate and modify this patch series based on the patch series
"Add support to configure TPDM CMB subunit".
2. Modify the functions that read the element size of DSB/CMB in TPDA driver.

Tao Zhang (10):
  coresight-tpdm: Optimize the store function of tpdm simple dataset
  coresight-tpdm: Optimize the useage of tpdm_has_dsb_dataset
  dt-bindings: arm: qcom,coresight-tpdm: Add support for CMB element
    size
  coresight-tpdm: Add CMB dataset support
  coresight-tpda: Add support to configure CMB element
  coresight-tpdm: Add support to configure CMB
  coresight-tpdm: Add pattern registers support for CMB
  coresight-tpdm: Add timestamp control register support for the CMB
  dt-bindings: arm: qcom,coresight-tpdm: Add support for TPDM CMB MSR
    register
  coresight-tpdm: Add msr register support for CMB

 .../testing/sysfs-bus-coresight-devices-tpdm  |  87 ++++
 .../bindings/arm/qcom,coresight-tpdm.yaml     |  35 ++
 drivers/hwtracing/coresight/coresight-tpda.c  | 130 ++---
 drivers/hwtracing/coresight/coresight-tpda.h  |   6 +
 drivers/hwtracing/coresight/coresight-tpdm.c  | 455 ++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tpdm.h  | 113 +++++
 6 files changed, 729 insertions(+), 97 deletions(-)

-- 
2.17.1


