Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CF875179C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjGMElJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjGMElF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:41:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F221BC6;
        Wed, 12 Jul 2023 21:41:02 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D4TYwv006392;
        Thu, 13 Jul 2023 04:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=d2WU4CPcd2QTXx9JvqD5og2WatJsIhcpZA9yoDEyVlI=;
 b=H4QguBPrqqClPPOCAVyjMfBM8uFUsHlw7Y+FaYLWmuPXRdVGb2W5UV6KQffxgjTwuGqe
 z+Xja1p2JMAqehfSE2MkmFT3/EtcoMqvHsiKdGA8yZokThjjxY6H3qiOMj1aSVUbS0Sm
 /AOBu836wxoXOnA01YsZw5sf0Q/rWsZFGRl9ZeWGlmG5huNHoIvP/2eOhfzw4OGpUJfr
 XBlrX+1KvG1VKAu2MZCHe6sZWIqVGXBC9g6o7e2pkHB6iNYZporx9obi6V9m1JkzEoTm
 iTxnWogn4DxEaFQP7oRHvezI9kVE1zQcz3C8NiJqesktMsPQ5ly42i6Fhjgr7a8rPzES CQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsgarb220-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 04:39:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36D4de92011853
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 04:39:40 GMT
Received: from [10.216.13.133] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 21:39:33 -0700
Message-ID: <c712597e-f870-f224-fc1b-90c6f8f19710@quicinc.com>
Date:   Thu, 13 Jul 2023 10:09:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related
 support
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MaqzpqKB0eK88cKu5ZKlsCARV6v5r7dT
X-Proofpoint-ORIG-GUID: MaqzpqKB0eK88cKu5ZKlsCARV6v5r7dT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_01,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1011 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130040
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/28/2023 6:04 PM, Mukesh Ojha wrote:
> Minidump is a best effort mechanism to collect useful and predefined data
> for first level of debugging on end user devices running on Qualcomm SoCs.
> It is built on the premise that System on Chip (SoC) or subsystem part of
> SoC crashes, due to a range of hardware and software bugs. Hence, the
> ability to collect accurate data is only a best-effort. The data collected
> could be invalid or corrupted, data collection itself could fail, and so on.
>
> Qualcomm devices in engineering mode provides a mechanism for generating
> full system ramdumps for post mortem debugging. But in some cases it's
> however not feasible to capture the entire content of RAM. The minidump
> mechanism provides the means for selecting which snippets should be
> included in the ramdump.
>
> Minidump kernel driver implementation is divided into two parts for
> simplicity, one is minidump core which can also be called minidump
> frontend(As API gets exported from this driver for registration with
> backend) and the other part is minidump backend i.e, where the underlying
> implementation of minidump will be there. There could be different way
> how the backend is implemented like Shared memory, Memory mapped IO
> or Resource manager(gunyah) based where the guest region information is
> passed to hypervisor via hypercalls.
>
>      Minidump Client-1     Client-2      Client-5    Client-n
>               |               |              |             |
>               |               |    ...       |   ...       |
>               |               |              |             |
>               |               |              |             |
>               |               |              |             |
>               |               |              |             |
>               |               |              |             |
>               |               |              |             |
>               |           +---+--------------+----+        |
>               +-----------+  qcom_minidump(core)  +--------+
>                           |                       |
>                           +------+-----+------+---+
>                                  |     |      |
>                                  |     |      |
>                  +---------------+     |      +--------------------+
>                  |                     |                           |
>                  |                     |                           |
>                  |                     |                           |
>                  v                     v                           v
>       +-------------------+      +-------------------+     +------------------+
>       |qcom_minidump_smem |      |qcom_minidump_mmio |     | qcom_minidump_rm |
>       |                   |      |                   |     |                  |
>       +-------------------+      +-------------------+     +------------------+
>         Shared memory              Memory mapped IO           Resource manager
>          (backend)                   (backend)                   (backend)
>
>
> Here, we will be giving all analogy of backend with SMEM as it is the
> only implemented backend at present but general idea remains the same.
>
> The core of SMEM based minidump feature is part of Qualcomm's boot
> firmware code. It initializes shared memory (SMEM), which is a part of
> DDR and allocates a small section of SMEM to minidump table i.e also
> called global table of content (G-ToC). Each subsystem (APSS, ADSP, ...)
> has their own table of segments to be included in the minidump and all
> get their reference from G-ToC. Each segment/region has some details
> like name, physical address and it's size etc. and it could be anywhere
> scattered in the DDR.
>
> Existing upstream Qualcomm remoteproc driver[1] already supports SMEM
> based minidump feature for remoteproc instances like ADSP, MODEM, ...
> where predefined selective segments of subsystem region can be dumped
> as part of coredump collection which generates smaller size artifacts
> compared to complete coredump of subsystem on crash.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/remoteproc/qcom_common.c#n142
>
> In addition to managing and querying the APSS minidump description,
> the Linux driver maintains a ELF header in a segment. This segment
> gets updated with section/program header whenever a new entry gets
> registered.
>
>
>   docs: qcom: Add qualcomm minidump guide
>    kallsyms: Export kallsyms_lookup_name
>    soc: qcom: Add qcom_minidump_smem module
>    soc: qcom: Add Qualcomm APSS minidump (frontend) feature support
>    soc: qcom: Add linux minidump smem backend driver support
>    soc: qcom: minidump: Add pending region registration support
>    soc: qcom: minidump: Add update region support
>    dt-bindings: reserved-memory: Add qcom,ramoops binding
>    pstore/ram : Export ramoops_parse_dt() symbol
>    soc: qcom: Add qcom's pstore minidump driver support
>    soc: qcom: Register pstore frontend region with minidump
>    remoteproc: qcom: Expand MD_* as MINIDUMP_*
>    remoterproc: qcom: refactor to leverage exported minidump symbol
>    MAINTAINERS: Add entry for minidump driver related support
>    arm64: defconfig: Enable Qualcomm Minidump related drivers
>    arm64: dts: qcom: sm8450: Add Qualcomm ramoops minidump node
>    firmware: qcom_scm: provide a read-modify-write function
>    pinctrl: qcom: Use qcom_scm_io_update_field()
>    firmware: scm: Modify only the download bits in TCSR register
>    firmware: qcom_scm: Refactor code to support multiple download mode
>    firmware: qcom_scm: Add multiple download mode support
>
> Patch 1/21 is qualcomm minidump document
> Patch 2/21 will export kallsyms_lookup_name will be needed for minidump module
> Patch 3/21 moves the minidump specific data structure and macro to
>   qcom_minidump_smem.c and later 13/21 will use the API and remove
>   minidump specific code to qcom_minidump_smem file.
> Patch 4/21 is qualcomm minidump core(frontend) driver
> Patch 5/21 implements qualcomm smem backend kernel driver
> Patch 6/21 add pending region support for the clients who came for
>   registration before minidump.
> Patch 7/21 add update region support for registered clients.
> Patch 8/21 Add dt-binding for qualcomm ramoops driver which is also a minidump client driver
> Patch 9/21 exported symbol from ramoops driver to avoid copy of the code.
> Patch 10/21 Add qcom's pstore minidump driver support which adds ramoops platform device
>              and 11/21 register existing pstore frontend regions.
> Patch 12/21 and 13/21 does some clean up and code reuse.
> Patch 16/21 enable qcom_ramoops driver for sm8450
> Patch 17-21 are not new and has already been through 6 versions and
> reason of adding here is for minidump testing purpose and it will be rebased
> automatically along with new version of minidump series.
>
> Testing of the patches has been done on sm8450 target after enabling config like
> CONFIG_PSTORE_RAM and CONFIG_PSTORE_CONSOLE and once the device boots up.
> Try crashing it via devmem2 0xf11c000(this is known to create xpu violation and
> and put the device in download mode) on command prompt.
>
> I have added download patch here numbered from 14/18 to 18/18
> Earlier download mode setting patches were sent separately
> https://lore.kernel.org/lkml/1680076012-10785-1-git-send-email-quic_mojha@quicinc.com/
>
> Default storage type is set to via USB, so minidump would be downloaded with the
> help of x86_64 machine (running PCAT tool) attached to Qualcomm device which has
> backed minidump boot firmware support (more can be found patch 3/18)
>
> Below patch [1] is to warm reset Qualcomm device which has upstream qcom
> watchdog driver support.
>
> After applying all patches, we can boot the device and can execute
> following command.
>
> echo mini > /sys/module/qcom_scm/parameters/download_mode
> echo c > /proc/sysrq-trigger
>
> This will make the device go to download mode and collect the minidump on to the
> attached x86 machine running the Qualcomm PCAT tool(This comes as part Qualcomm
> package manager kit).
> After that we will see a bunch of predefined registered region as binary blobs files
> starts with md_* downloaded on the x86 machine on given location in PCAT tool from
> the target device.
>
> A sample client example to dump a linux region has been given in patch 3/18 and as
> well as can be seen in patch 12/18.
>
> [1]
> --------------------------->8-------------------------------------
>
> commit f1124ccebd47550b4c9627aa162d9cdceba2b76f
> Author: Mukesh Ojha <quic_mojha@quicinc.com>
> Date:   Thu Mar 16 14:08:35 2023 +0530
>
>      do not merge: watchdog bite on panic
>
>      Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 0d2209c..767e84a 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -12,6 +12,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/watchdog.h>
>   #include <linux/of_device.h>
> +#include <linux/panic.h>
>
>   enum wdt_reg {
>          WDT_RST,
> @@ -114,12 +115,28 @@ static int qcom_wdt_set_pretimeout(struct watchdog_device *wdd,
>          return qcom_wdt_start(wdd);
>   }
>
> +static void qcom_wdt_bite_on_panic(struct qcom_wdt *wdt)
> +{
> +       writel(0, wdt_addr(wdt, WDT_EN));
> +       writel(1, wdt_addr(wdt, WDT_BITE_TIME));
> +       writel(1, wdt_addr(wdt, WDT_RST));
> +       writel(QCOM_WDT_ENABLE, wdt_addr(wdt, WDT_EN));
> +
> +       wmb();
> +
> +       while(1)
> +               udelay(1);
> +}
> +
>   static int qcom_wdt_restart(struct watchdog_device *wdd, unsigned long action,
>                              void *data)
>   {
>          struct qcom_wdt *wdt = to_qcom_wdt(wdd);
>          u32 timeout;
>
> +       if (in_panic)
> +               qcom_wdt_bite_on_panic(wdt);
> +
>          /*
>           * Trigger watchdog bite:
>           *    Setup BITE_TIME to be 128ms, and enable WDT.
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index 979b776..f913629 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -22,6 +22,7 @@ extern int panic_on_oops;
>   extern int panic_on_unrecovered_nmi;
>   extern int panic_on_io_nmi;
>   extern int panic_on_warn;
> +extern bool in_panic;
>
>   extern unsigned long panic_on_taint;
>   extern bool panic_on_taint_nousertaint;
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 487f5b0..714f7f4 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -65,6 +65,8 @@ static unsigned int warn_limit __read_mostly;
>
>   int panic_timeout = CONFIG_PANIC_TIMEOUT;
>   EXPORT_SYMBOL_GPL(panic_timeout);
> +bool in_panic = false;
> +EXPORT_SYMBOL_GPL(in_panic);
>
>   #define PANIC_PRINT_TASK_INFO          0x00000001
>   #define PANIC_PRINT_MEM_INFO           0x00000002
> @@ -261,6 +263,7 @@ void panic(const char *fmt, ...)
>          int old_cpu, this_cpu;
>          bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
>
> +       in_panic = true;
>          if (panic_on_warn) {
>                  /*
>                   * This thread may hit another WARN() in the panic path.
> --------------------------------------------------------------------------
>
> Changes in v4:
>   - Redesigned the driver and divided the driver into front end and backend (smem) so
>     that any new backend can be attached easily to avoid code duplication.
>   - Patch reordering as per the driver and subsystem to easier review of the code.
>   - Removed minidump specific code from remoteproc to minidump smem based driver.
>   - Enabled the all the driver as modules.
>   - Address comments made on documentation and yaml and Device tree file [Krzysztof/Konrad]
>   - Address comments made qcom_pstore_minidump driver and given its Device tree
>     same set of properties as ramoops. [Luca/Kees]
>   - Added patch for MAINTAINER file.
>   - Include defconfig change as one patch as per [Krzysztof] suggestion.
>   - Tried to remove the redundant file scope variables from the module as per [Krzysztof] suggestion.
>   - Addressed comments made on dload mode patch v6 version
>     https://lore.kernel.org/lkml/1680076012-10785-1-git-send-email-quic_mojha@quicinc.com/
>
> Changes in v3: https://lore.kernel.org/lkml/1683133352-10046-1-git-send-email-quic_mojha@quicinc.com/
>   - Addressed most of the comments by Srini on v2 and refactored the minidump driver.
>      - Added platform device support
>      - Unregister region support.
>   - Added update region for clients.
>   - Added pending region support.
>   - Modified the documentation guide accordingly.
>   - Added qcom_pstore_ramdump client driver which happen to add ramoops platform
>     device and also registers ramoops region with minidump.
>   - Added download mode patch series with this minidump series.
>      https://lore.kernel.org/lkml/1680076012-10785-1-git-send-email-quic_mojha@quicinc.com/
>
> Changes in v2: https://lore.kernel.org/lkml/1679491817-2498-1-git-send-email-quic_mojha@quicinc.com/
>   - Addressed review comment made by [quic_tsoni/bmasney] to add documentation.
>   - Addressed comments made by [srinivas.kandagatla]
>   - Dropped pstore 6/6 from the last series, till i get conclusion to get pstore
>     region in minidump.
>   - Fixed issue reported by kernel test robot.
>
> Changes in v1: https://lore.kernel.org/lkml/1676978713-7394-1-git-send-email-quic_mojha@quicinc.com/
>
> Mukesh Ojha (21):
>    docs: qcom: Add qualcomm minidump guide
>    kallsyms: Export kallsyms_lookup_name
>    soc: qcom: Add qcom_minidump_smem module
>    soc: qcom: Add Qualcomm APSS minidump (frontend) feature support
>    soc: qcom: Add linux minidump smem backend driver support
>    soc: qcom: minidump: Add pending region registration support
>    soc: qcom: minidump: Add update region support
>    dt-bindings: reserved-memory: Add qcom,ramoops binding
>    pstore/ram : Export ramoops_parse_dt() symbol
>    soc: qcom: Add qcom's pstore minidump driver support
>    soc: qcom: Register pstore frontend region with minidump
>    remoteproc: qcom: Expand MD_* as MINIDUMP_*
>    remoterproc: qcom: refactor to leverage exported minidump symbol
>    MAINTAINERS: Add entry for minidump driver related support
>    arm64: defconfig: Enable Qualcomm Minidump related drivers
>    arm64: dts: qcom: sm8450: Add Qualcomm ramoops minidump node
>    firmware: qcom_scm: provide a read-modify-write function
>    pinctrl: qcom: Use qcom_scm_io_update_field()
>    firmware: scm: Modify only the download bits in TCSR register
>    firmware: qcom_scm: Refactor code to support multiple download mode
>    firmware: qcom_scm: Add multiple download mode support


Hi Mukesh,

For IPQ chipsets, for the crashdump to work, we need the below patch

firmware: scm: Modify only the download bits in TCSR register

can you post the below patches separately? Looks like minidump will take 
some time and also I don't see any dependencies for these to go along 
with the minidump. Given that, will it be possible to post the below 
patches separately?

   firmware: qcom_scm: provide a read-modify-write function
   pinctrl: qcom: Use qcom_scm_io_update_field()
   firmware: scm: Modify only the download bits in TCSR register

Do let us know if we can take these patches and post it separately.

Thanks,

Kathiravan T.


>
>   Documentation/admin-guide/index.rst                |   1 +
>   Documentation/admin-guide/qcom_minidump.rst        | 293 +++++++++++
>   .../devicetree/bindings/soc/qcom/qcom,ramoops.yaml | 126 +++++
>   MAINTAINERS                                        |  15 +
>   arch/arm64/boot/dts/qcom/sm8450.dtsi               |  12 +
>   arch/arm64/configs/defconfig                       |   4 +
>   drivers/firmware/Kconfig                           |  11 -
>   drivers/firmware/qcom_scm.c                        |  85 ++-
>   drivers/pinctrl/qcom/pinctrl-msm.c                 |  12 +-
>   drivers/remoteproc/qcom_common.c                   | 142 +----
>   drivers/soc/qcom/Kconfig                           |  39 ++
>   drivers/soc/qcom/Makefile                          |   3 +
>   drivers/soc/qcom/qcom_minidump.c                   | 582 +++++++++++++++++++++
>   drivers/soc/qcom/qcom_minidump_internal.h          |  98 ++++
>   drivers/soc/qcom/qcom_minidump_smem.c              | 387 ++++++++++++++
>   drivers/soc/qcom/qcom_pstore_minidump.c            | 210 ++++++++
>   drivers/soc/qcom/smem.c                            |   9 +
>   fs/pstore/ram.c                                    |  26 +-
>   include/linux/firmware/qcom/qcom_scm.h             |   2 +
>   include/linux/pstore_ram.h                         |   2 +
>   include/soc/qcom/qcom_minidump.h                   |  64 +++
>   kernel/kallsyms.c                                  |   2 +-
>   22 files changed, 1973 insertions(+), 152 deletions(-)
>   create mode 100644 Documentation/admin-guide/qcom_minidump.rst
>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml
>   create mode 100644 drivers/soc/qcom/qcom_minidump.c
>   create mode 100644 drivers/soc/qcom/qcom_minidump_internal.h
>   create mode 100644 drivers/soc/qcom/qcom_minidump_smem.c
>   create mode 100644 drivers/soc/qcom/qcom_pstore_minidump.c
>   create mode 100644 include/soc/qcom/qcom_minidump.h
>
