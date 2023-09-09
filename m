Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A01D799ADA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245756AbjIIUSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 16:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245346AbjIIUS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:18:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EA119BC;
        Sat,  9 Sep 2023 13:17:50 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 389KCCLX026247;
        Sat, 9 Sep 2023 20:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=47U0wjkLNNzJMzGRtWIy9DXhXMW8cvfyRnreZaE9VOA=;
 b=OSxz3SgiDYiRO5+A9pm+qZODXupIoIe+3fWLFOX2DW8i+aD5iMGFpptFSTYbUAgLJqE6
 CZxc2IIzPV2NuiWFXAGg1RwUmYFPI5dtohvFtgANFwBZ8hO5GdgCrIQPvHFXzd6+8AMj
 ywxwoElwFUA8pBM909aEZOXYctf2wH5Zooc6ZptP1+u2xBm5cUO+i+7X36ONv+mIh1pM
 rVylea5AMCwWHvTo7KoWC+i6j+VI+ctXt26dz7Zj59sHM+m+FVXard3cdAVlPVLDTl6O
 gHizeko0LURvArxd11Y7sfzJ4Mkl+Oa+dfhtJ0fditzwFAcjiDj+zvdrlewEBrk0ag9G kg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0fnyh3fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Sep 2023 20:16:55 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 389KGsWQ004747
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 9 Sep 2023 20:16:54 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sat, 9 Sep 2023 13:16:43 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_mojha@quicinc.com>
Subject: [PATCH v5 01/17] docs: qcom: Add qualcomm minidump guide
Date:   Sun, 10 Sep 2023 01:46:02 +0530
Message-ID: <1694290578-17733-2-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
References: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Yq2HaNWC5M45Sa6BuJq7Y4OQNpw2_9ip
X-Proofpoint-ORIG-GUID: Yq2HaNWC5M45Sa6BuJq7Y4OQNpw2_9ip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309090187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the qualcomm minidump guide for the users which tries to cover
the dependency, API use and the way to test and collect minidump
on Qualcomm supported SoCs.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 Documentation/admin-guide/index.rst         |   1 +
 Documentation/admin-guide/qcom_minidump.rst | 272 ++++++++++++++++++++++++++++
 2 files changed, 273 insertions(+)
 create mode 100644 Documentation/admin-guide/qcom_minidump.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 43ea35613dfc..251d070486c2 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -120,6 +120,7 @@ configure specific aspects of kernel behavior to your liking.
    perf-security
    pm/index
    pnp
+   qcom_minidump
    rapidio
    ras
    rtc
diff --git a/Documentation/admin-guide/qcom_minidump.rst b/Documentation/admin-guide/qcom_minidump.rst
new file mode 100644
index 000000000000..20202da8ca40
--- /dev/null
+++ b/Documentation/admin-guide/qcom_minidump.rst
@@ -0,0 +1,272 @@
+Qualcomm minidump feature
+=========================
+
+Introduction
+------------
+
+Minidump is a best effort mechanism to collect useful and predefined
+data for first level of debugging on end user devices running on
+Qualcomm SoCs. It is built on the premise that System on Chip (SoC)
+or subsystem part of SoC crashes, due to a range of hardware and
+software bugs. Hence, the ability to collect accurate data is only
+a best-effort. The data collected could be invalid or corrupted, data
+collection itself could fail, and so on.
+
+Qualcomm devices in engineering mode provides a mechanism for generating
+full system RAM dumps for post-mortem debugging. But in some cases it's
+however not feasible to capture the entire content of RAM. The minidump
+mechanism provides the means for selected region should be included in
+the ramdump.
+
+
+::
+
+   +-----------------------------------------------+
+   |   DDR                       +-------------+   |
+   |                             |      SS0-ToC|   |
+   | +----------------+     +----------------+ |   |
+   | |Shared memory   |     |         SS1-ToC| |   |
+   | |(SMEM)          |     |                | |   |
+   | |                | +-->|--------+       | |   |
+   | |G-ToC           | |   | SS-ToC  \      | |   |
+   | |+-------------+ | |   | +-----------+  | |   |
+   | ||-------------| | |   | |-----------|  | |   |
+   | || SS0-ToC     | | | +-|<|SS1 region1|  | |   |
+   | ||-------------| | | | | |-----------|  | |   |
+   | || SS1-ToC     |-|>+ | | |SS1 region2|  | |   |
+   | ||-------------| |   | | |-----------|  | |   |
+   | || SS2-ToC     | |   | | |  ...      |  | |   |
+   | ||-------------| |   | | |-----------|  | |   |
+   | ||  ...        | |   |-|<|SS1 regionN|  | |   |
+   | ||-------------| |   | | |-----------|  | |   |
+   | || SSn-ToC     | |   | | +-----------+  | |   |
+   | |+-------------+ |   | |                | |   |
+   | |                |   | |----------------| |   |
+   | |                |   +>|  regionN       | |   |
+   | |                |   | |----------------| |   |
+   | +----------------+   | |                | |   |
+   |                      | |----------------| |   |
+   |                      +>|  region1       | |   |
+   |                        |----------------| |   |
+   |                        |                | |   |
+   |                        |----------------|-+   |
+   |                        |  region5       |     |
+   |                        |----------------|     |
+   |                        |                |     |
+   |  Region information    +----------------+     |
+   | +---------------+                             |
+   | |region name    |                             |
+   | |---------------|                             |
+   | |region address |                             |
+   | |---------------|                             |
+   | |region size    |                             |
+   | +---------------+                             |
+   +-----------------------------------------------+
+       G-ToC: Global table of contents
+       SS-ToC: Subsystem table of contents
+       SS0-SSn: Subsystem numbered from 0 to n
+
+It depends on SoC where the underlying firmware is keeping the
+minidump global table taking care of subsystem ToC part for
+minidump like for above diagram, it is for shared memory sitting
+in DDR and it is shared among various master however it is possible
+that this could be implemented via memory mapped regions but the
+general idea should remain same. Here, various subsystem could be
+DSP's like ADSP/CDSP/MODEM etc, along with Application processor
+(APSS) where Linux runs. DSP minidump gets collected when DSP's goes
+for recovery followed by a crash. The minidump part of code for
+that resides in ``qcom_rproc_minidump.c``.
+
+
+SMEM as backend
+----------------
+
+In this document, SMEM will be used as the backend implementation
+of minidump.
+
+The core of minidump feature is part of Qualcomm's boot firmware code.
+It initializes shared memory (SMEM), which is a part of DDR and
+allocates a small section of it to minidump table, i.e. also called
+global table of contents (G-ToC). Each subsystem (APSS, ADSP, ...) has
+its own table of segments to be included in the minidump, all
+references from a descriptor in SMEM (G-ToC). Each segment/region has
+some details like name, physical address and its size etc. and it
+could be anywhere scattered in the DDR.
+
+Qualcomm APSS Minidump kernel driver concept
+--------------------------------------------
+::
+
+Qualcomm APSS minidump kernel driver adds the capability to add Linux
+region to be dumped as part of RAM dump collection. At the moment,
+shared memory driver creates platform device for minidump driver and
+give a means to APSS minidump to initialize itself on probe.
+
+This driver provides ``qcom_minidump_region_register`` and
+``qcom_minidump_region_unregister`` API's to register and unregister
+APSS minidump region. It also supports registration for the clients
+who came before minidump driver was initialized. It maintains pending
+list of clients who came before minidump and once minidump is initialized
+it registers them in one go.
+
+To simplify post-mortem debugging, driver creates and maintain an ELF
+header as first region that gets updated each time a new region gets
+registered.
+
+The solution supports extracting the RAM dump/minidump produced either
+over USB or stored to an attached storage device.
+
+Dependency of minidump kernel driver
+------------------------------------
+
+It is to note that whole of minidump depends on Qualcomm boot firmware
+whether it supports minidump or not. So, if the minidump SMEM ID is
+present in shared memory, it indicates that minidump is supported from
+boot firmware and it is possible to dump Linux (APSS) region as part
+of minidump collection.
+
+How a kernel client driver can register region with minidump
+------------------------------------------------------------
+
+Client driver can use ``qcom_minidump_region_register`` API's to register
+and ``qcom_minidump_region_unregister`` to unregister their region from
+minidump driver.
+
+Client needs to fill their region by filling ``qcom_minidump_region``
+structure object which consists of the region name, region's virtual
+and physical address and its size.
+
+Below, is one sample client driver snippet which tries to allocate a
+region from kernel heap of certain size and it writes a certain known
+pattern (that can help in verification after collection that we got
+the exact pattern, what we wrote) and registers it with minidump.
+
+ .. code-block:: c
+
+  #include <soc/qcom/qcom_minidump.h>
+  [...]
+
+
+  [... inside a function ...]
+  struct qcom_minidump_region region;
+
+  [...]
+
+  client_mem_region = kzalloc(region_size, GFP_KERNEL);
+  if (!client_mem_region)
+	return -ENOMEM;
+
+  [... Just write a pattern ...]
+  memset(client_mem_region, 0xAB, region_size);
+
+  [... Fill up the region object ...]
+  strlcpy(region.name, "REGION_A", sizeof(region.name));
+  region.virt_addr = client_mem_region;
+  region.phys_addr = virt_to_phys(client_mem_region);
+  region.size = region_size;
+
+  ret = qcom_minidump_region_register(&region);
+  if (ret < 0) {
+	pr_err("failed to add region in minidump: err: %d\n", ret);
+	return ret;
+  }
+
+  [...]
+
+
+Test
+----
+
+Existing Qualcomm devices already supports entire RAM dump (also called
+full dump) by writing appropriate value to Qualcomm's top control and
+status register (tcsr) in ``driver/firmware/qcom_scm.c`` .
+
+SCM device Tree bindings required to support download mode
+For example (sm8450) ::
+
+	/ {
+
+	[...]
+
+		firmware {
+			scm: scm {
+				compatible = "qcom,scm-sm8450", "qcom,scm";
+				[... tcsr register ... ]
+				qcom,dload-mode = <&tcsr 0x13000>;
+
+				[...]
+			};
+		};
+
+	[...]
+
+		soc: soc@0 {
+
+			[...]
+
+			tcsr: syscon@1fc0000 {
+				compatible = "qcom,sm8450-tcsr", "syscon";
+				reg = <0x0 0x1fc0000 0x0 0x30000>;
+			};
+
+			[...]
+		};
+	[...]
+
+	};
+
+User of minidump can pass ``qcom_scm.download_mode="mini"`` to kernel
+commandline to set the current download mode to minidump.
+Similarly, ``"full"`` is passed to set the download mode to full dump
+where entire RAM dump will be collected while setting it ``"full,mini"``
+will collect minidump along with fulldump.
+
+Writing to sysfs node can also be used to set the mode to minidump::
+
+	echo "mini" > /sys/module/qcom_scm/parameter/download_mode
+
+Once the download mode is set, any kind of crash will make the device collect
+respective dump as per set download mode.
+
+Dump collection
+---------------
+
+	+-----------+
+	|           |
+	|           |         +------+
+	|           |         |      |
+	|           |         +--+---+ Product(Qualcomm SoC)
+	+-----------+             |
+	|+++++++++++|<------------+
+	|+++++++++++|    usb cable
+	+-----------+
+            x86_64 PC
+
+The solution supports a product running with Qualcomm SoC (where minidump)
+is supported from the firmware) connected to x86_64 host PC running PCAT
+tool. It supports downloading the minidump produced from product to the
+host PC over USB or to save the minidump to the product attached storage
+device(UFS/eMMC/SD Card) into minidump dedicated partition.
+
+By default, dumps are downloaded via USB to the attached x86_64 PC running
+PCAT (Qualcomm tool) software. Upon download, we will see a set of binary
+blobs starting with name ``md_*`` in PCAT configured directory in x86_64
+machine, so for above example from the client it will be ``md_REGION_A.BIN``.
+This binary blob depends on region content to determine whether it needs
+external parser support to get the content of the region, so for simple
+plain ASCII text we don't need any parsing and the content can be seen
+just opening the binary file.
+
+To collect the dump to attached storage type, one needs to write appropriate
+value to IMEM register, in that case dumps are collected in rawdump
+partition on the product device itself.
+
+One needs to read the entire rawdump partition and pull out content to
+save it onto the attached x86_64 machine over USB. Later, this rawdump
+can be passed to another tool (``dexter.exe`` [Qualcomm tool]) which
+converts this into the similar binary blobs which we have got it when
+download type was set to USB, i.e. a set of registered regions as blobs
+and their name starts with ``md_*``.
+
+Replacing the ``dexter.exe`` with some open source tool can be added as future
+scope of this document.
-- 
2.7.4

