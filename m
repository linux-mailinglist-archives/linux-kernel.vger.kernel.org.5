Return-Path: <linux-kernel+bounces-44193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D18841E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC2B1C253CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4075D58AB6;
	Tue, 30 Jan 2024 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mP48PiG+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C27B59141;
	Tue, 30 Jan 2024 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605407; cv=none; b=HTfaXMDS3AhYLDk6xt1uPCkUYFK/CTz9Rcj7puuGrKzSd0n3QFsJ942ql6hIxWoPr0vl6TeyDxXDLyQj6UImsObdp+FNoMUnNiaaTh8B3Y+V04RSoXFMEYJoNn9tOzB4jvuPLuoH4t/PI8SEhtcbpxvpb5teM4vnbLDycp50ACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605407; c=relaxed/simple;
	bh=yfWWvKqBvgEfUBvViOCfzVHxsS4Lo4sb5YDwvfs5KyE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nnZWIPq8G7N2ad14b6Pg6vtQRNNPeJS8gGqdFEbFf1V2JQz1d9Q23LxDqjrCBz94AnUOnVpDbtUTekBNLNURv/PS3xo+p8OJPXhg6hopepxsbRbzS1caPyew9nQDKiq3/vjG8YJ4z9iPcB1g+6aWzPWcJc/U37lAfaqU4JQIms0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mP48PiG+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U8mTUr003786;
	Tue, 30 Jan 2024 09:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=30/+P/2wsWs2yARxwGXO
	yN2uVq5B8hlYLvH13NzA4Xo=; b=mP48PiG++QYJOsibVKU+0qREScibtsL0mSpi
	jd1sLuHnOFSOnyE468SDGCF/89emItrAb2zAiewyaD+8n3HQC/m623EyUplOJYRG
	tNpGPrYdOtzBHe827tFOChtMSB5NBF1qN7KTdwjS/ypFZqopBMAKrEJEzP3xBvnp
	wq47r+oh6Sys1kmBKKs/0zXDrcwdbk4Aegy8VqwcBf9EySd3b2Qqok0wMOl/VfU7
	CYhQqaDXcl2T0rtyUIClEkqJtyFIt3lcm+uG/aYVlq0SLgfA3sJi6XMI7HUW9OW7
	Q9mBKNWYD5JVotvRbmUdDqcbLu9QJOCkBBYv8RxqVv6+uStbBw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxwwv80ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 09:03:11 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U93AHE001714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 09:03:10 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 01:03:05 -0800
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
Subject: [PATCH v5 00/10] Add support to configure TPDM CMB subunit
Date: Tue, 30 Jan 2024 17:02:36 +0800
Message-ID: <1706605366-31705-1-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NDtuD7vXNg7PRXBRUYKeYhPJcm5IIj_c
X-Proofpoint-ORIG-GUID: NDtuD7vXNg7PRXBRUYKeYhPJcm5IIj_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_03,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300065

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
https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/tpdm-cmb-v5

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
 drivers/hwtracing/coresight/coresight-tpda.c  | 123 +++--
 drivers/hwtracing/coresight/coresight-tpda.h  |   6 +
 drivers/hwtracing/coresight/coresight-tpdm.c  | 455 ++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tpdm.h  | 113 +++++
 6 files changed, 727 insertions(+), 92 deletions(-)

-- 
2.17.1


