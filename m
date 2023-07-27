Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E73764EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjG0JMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjG0JLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:11:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C181F271D;
        Thu, 27 Jul 2023 01:57:31 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RBPg53r6Zz6GDBq;
        Thu, 27 Jul 2023 16:53:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 09:57:28 +0100
Date:   Thu, 27 Jul 2023 09:57:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     <chengyou@linux.alibaba.com>, <kaishen@linux.alibaba.com>,
        <helgaas@kernel.org>, <yangyicong@huawei.com>, <will@kernel.org>,
        <baolin.wang@linux.alibaba.com>, <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <rdunlap@infradead.org>,
        <mark.rutland@arm.com>, <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v6 1/4] docs: perf: Add description for Synopsys
 DesignWare PCIe PMU driver
Message-ID: <20230727095727.0000190b@Huawei.com>
In-Reply-To: <20230606074938.97724-2-xueshuai@linux.alibaba.com>
References: <20230606074938.97724-1-xueshuai@linux.alibaba.com>
        <20230606074938.97724-2-xueshuai@linux.alibaba.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023 15:49:35 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> Alibaba's T-Head Yitan 710 SoC includes Synopsys' DesignWare Core PCIe
> controller which implements which implements PMU for performance and
> functional debugging to facilitate system maintenance.
> 
> Document it to provide guidance on how to use it.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Given this looks like it might move forwards (after Bjorn's reply)
I'll give it a closer review :)

Some editorial things in here only. What you have is easy
to understand but nice to tidy up the odd corner or two.
We can bikeshed this for ever so I've skipped really minor things
where phrasing is debatable (particularly British vs US English :)

Jonathan


> ---
>  .../admin-guide/perf/dwc_pcie_pmu.rst         | 97 +++++++++++++++++++
>  Documentation/admin-guide/perf/index.rst      |  1 +
>  2 files changed, 98 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> 
> diff --git a/Documentation/admin-guide/perf/dwc_pcie_pmu.rst b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> new file mode 100644
> index 000000000000..c1f671cb64ec
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> @@ -0,0 +1,97 @@
> +======================================================================
> +Synopsys DesignWare Cores (DWC) PCIe Performance Monitoring Unit (PMU)
> +======================================================================
> +
> +DesignWare Cores (DWC) PCIe PMU
> +===============================
> +
> +The PMU is not a PCIe Root Complex integrated End Point (RCiEP) device but
> +only PCIe configuration space register block provided by each PCIe Root

I don't think you need the negative bit of description - it's not a lot of
different things and this statement only really makes sense when compared to
some other PCIe PMUs which the reader may never have come across.

"The PMU is a PCIe configuration space register block provided by each PCIE Root
Port in a Vendor-Specific Extended Capability ..."

> +Port in a Vendor-Specific Extended Capability named RAS DES (Debug, Error
> +injection, and Statistics).
> +
> +As the name indicated, the RAS DES capability supports system level

"As the name indicates," (present tense more appropriate here)

> +debugging, AER error injection, and collection of statistics. To facilitate
> +collection of statistics, Synopsys DesignWare Cores PCIe controller

"Core's"

(as it belongs to the core rather than intent being that it applies to plural
cores?)

> +provides the following two features:
> +
> +- Time Based Analysis (RX/TX data throughput and time spent in each
> +  low-power LTSSM state)
> +- Lane Event counters (Error and Non-Error for lanes)
> +
> +Time Based Analysis
> +-------------------
> +
> +Using this feature you can obtain information regarding RX/TX data
> +throughput and time spent in each low-power LTSSM state by the controller.
> +
> +The counters are 64-bit width and measure data in two categories,
> +
> +- percentage of time does the controller stay in LTSSM state in a

"percentage of time the controller stays in LTSSM " 

> +  configurable duration. The measurement range of each Event in Group#0.

I'm not sure of meaning of the last sentence.  Is it simply that this bullet
refers to group#0?  Perhaps make that the lead off. e.g.

- Group#0: Percentage of time the controller stays in LTSSM states.
- Group#1: Amount of data processed (Units of 16 bytes).

> +- amount of data processed (Units of 16 bytes). The measurement range of
> +  each Event in Group#1.
> +
> +Lane Event counters
> +-------------------
> +
> +Using this feature you can obtain Error and Non-Error information in
> +specific lane by the controller.
> +
> +The counters are 32-bit width and the measured event is select by:
> +
> +- Group i
> +- Event j within the Group i
> +- and Lane k
> +
> +Some of the event counters only exist for specific configurations.
> +
> +DesignWare Cores (DWC) PCIe PMU Driver
> +=======================================
> +
> +This driver add PMU devices for each PCIe Root Port. And the PMU device is

"This driver adds PMU devices for each PCIe Root Port.  The PMU device is named"

(Not good to start a sentence with And - an alternative form would be)

"This driver adds PMU devices for each PCIe Root Port named based on the BDF of
the Root Port." 

> +named based the BDF of Root Port. For example,
> +
> +    30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
> +
> +the PMU device name for this Root Port is dwc_rootport_3018.
> +
> +The DWC PCIe PMU driver registers a perf PMU driver, which provides
> +description of available events and configuration options in sysfs, see
> +/sys/bus/event_source/devices/dwc_rootport_{bdf}.
> +
> +The "format" directory describes format of the config, fields of the

"config fields" (stray comma makes this confusing to read)

> +perf_event_attr structure. The "events" directory provides configuration
> +templates for all documented events.  For example,
> +"Rx_PCIe_TLP_Data_Payload" is an equivalent of "eventid=0x22,type=0x1".
> +
> +The "perf list" command shall list the available events from sysfs, e.g.::
> +
> +    $# perf list | grep dwc_rootport
> +    <...>
> +    dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/        [Kernel PMU event]
> +    <...>
> +    dwc_rootport_3018/rx_memory_read,lane=?/               [Kernel PMU event]
> +
> +Time Based Analysis Event Usage
> +-------------------------------
> +
> +Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
> +
> +    $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
> +
> +The average RX/TX bandwidth can be calculated using the following formula:
> +
> +    PCIe RX Bandwidth = PCIE_RX_DATA * 16B / Measure_Time_Window
> +    PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window
> +
> +Lane Event Usage
> +-------------------------------
> +
> +Each lane has the same event set and to avoid generating a list of hundreds
> +of events, the user need to specify the lane ID explicitly, e.g.::
> +
> +    $# perf stat -a -e dwc_rootport_3018/rx_memory_read,lane=4/
> +
> +The driver does not support sampling, therefore "perf record" will not
> +work. Per-task (without "-a") perf sessions are not supported.
> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> index 9de64a40adab..11a80cd28a2e 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -19,5 +19,6 @@ Performance monitor support
>     arm_dsu_pmu
>     thunderx2-pmu
>     alibaba_pmu
> +   dwc_pcie_pmu
>     nvidia-pmu
>     meson-ddr-pmu

