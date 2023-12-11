Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174DD80CAC8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343642AbjLKNV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343502AbjLKNV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:21:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C64B3;
        Mon, 11 Dec 2023 05:21:32 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBCB6Zf024524;
        Mon, 11 Dec 2023 13:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=lJ4ovIVB4iJjD7WogmWjEHHjz4jfdMjCoBUQhm5qGsM=; b=d7
        Rpmziw6a56MHjFl3yOL1zxBlvlVgGaGFaoGRkTiou6E8sky8FIX2+UIeV6ooVCaD
        bqhY8KTZtqmp45AsWokW5csg+vOPMWnUMiX1pN0KccuzC8CzDZaoKoraLzS5ddPd
        omJ/unkbE80VzKbPXoKGosc3MjxRpa0HGhFaSUij6E8TWMZfUDyavxbID7EWFW8b
        c9TEUPzjT62jz9xlDawgRP4S5xbXwwdfOU8He6O0LpFj01s4Ak6Zlh2rk3szFFAz
        /1dF2/Voos21lOBfvndlf025xjg3LsUpvdFSell9lSitVguyVpv14/Tw5bQupAzf
        0o6CNQpccXFkZ1Gsb5FA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvney3c1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 13:21:02 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BBDL1lC028891
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 13:21:01 GMT
Received: from [10.216.63.6] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Dec
 2023 05:20:46 -0800
Message-ID: <c91bec51-5ca5-26c5-c41d-55461477b623@quicinc.com>
Date:   Mon, 11 Dec 2023 18:50:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Patch v6 03/12] docs: qcom: Add qualcomm minidump guide
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>, <bmasney@redhat.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>
References: <1700864395-1479-1-git-send-email-quic_mojha@quicinc.com>
 <1700864395-1479-4-git-send-email-quic_mojha@quicinc.com>
 <b50fd14e-7798-4b1e-aff3-9409e67300b3@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <b50fd14e-7798-4b1e-aff3-9409e67300b3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OlUDVDtynC2MULdK7WvfjhsoHerd6vKU
X-Proofpoint-ORIG-GUID: OlUDVDtynC2MULdK7WvfjhsoHerd6vKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110109
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks you very much Bryan for giving so much time of yours in reviewing 
minidump DOC and I apologize for coming so late for your reply.

I will definetely apply your suggestion in next series.

Please find my reply inline for your queries.

On 11/28/2023 6:45 PM, Bryan O'Donoghue wrote:
> On 24/11/2023 22:19, Mukesh Ojha wrote:
>> Add the qualcomm minidump guide for the users which tries to cover
>> the dependency, API use and the way to test and collect minidump
>> on Qualcomm supported SoCs.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   Documentation/admin-guide/index.rst         |   1 +
>>   Documentation/admin-guide/qcom_minidump.rst | 272 
>> ++++++++++++++++++++++++++++
>>   2 files changed, 273 insertions(+)
>>   create mode 100644 Documentation/admin-guide/qcom_minidump.rst
> 
> General nit-pick on sequencing of your patches. Its good practice (tm) 
> to put your documentation first in your series.
> 
>> diff --git a/Documentation/admin-guide/index.rst 
>> b/Documentation/admin-guide/index.rst
>> index 43ea35613dfc..251d070486c2 100644
>> --- a/Documentation/admin-guide/index.rst
>> +++ b/Documentation/admin-guide/index.rst
>> @@ -120,6 +120,7 @@ configure specific aspects of kernel behavior to 
>> your liking.
>>      perf-security
>>      pm/index
>>      pnp
>> +   qcom_minidump
>>      rapidio
>>      ras
>>      rtc
>> diff --git a/Documentation/admin-guide/qcom_minidump.rst 
>> b/Documentation/admin-guide/qcom_minidump.rst
>> new file mode 100644
>> index 000000000000..b492f2b79639
>> --- /dev/null
>> +++ b/Documentation/admin-guide/qcom_minidump.rst
>> @@ -0,0 +1,272 @@
>> +Qualcomm minidump feature
>> +=========================
>> +
>> +Introduction
>> +------------
>> +
>> +Minidump is a best effort mechanism to collect useful and predefined
>> +data for first level of debugging on end user devices running on
>> +Qualcomm SoCs. 
> 
> What does "first-level debugging" mean here ? You use the term 
> "post-mortem" later, stick with one term for consistency throughout your 
> document.

First level debugging meant was to mean the amount of data captured is
limited and may be sufficient to root cause an issue and you may need
entire ramdump to debug the issue.

> 
> Suggest:
> 
> "Minidump is a best-effort mechanism to collect useful predefined data 
> for post-mortem debugging on a Qualcomm System on Chips (SoCs)."
> 
> Generally better to stick with "Qualcomm SoC" and "Minidump" once you 
> establish the terms upfront and early in your text - instead of 
> reverting to "device" and "it".
> 
> It is built on the premise that System on Chip (SoC)
>> +or subsystem part of SoC crashes, due to a range of hardware and
>> +software bugs.
> Instead of saying "It" say "Minidump"

Sure, will try to be consistent in term usage.

> 
> Hence, the ability to collect accurate data is only
>> +a best-effort. The data collected could be invalid or corrupted, data
>> +collection itself could fail, and so on.
> 
> "and so on" is a redundancy, drop.
> 
> 
> Suggest:
> Minidump is built on the premise that a hardware or software component 
> on the SoC has encountered an unexpected fault. This means that the data 
> collected by minidump cannot be assumed to be correct or even present.
> 
>> +
>> +Qualcomm devices in engineering mode provides a mechanism for generating
>> +full system RAM dumps for post-mortem debugging. 
> 
> Stick with the established naming convention
> 
> "Qualcomm SoCs in engineering mode provide a mechanism for generating 
> full system RAM dumps for this post-mortem debugging"
> 
> But in some cases it's
>> +however not feasible to capture the entire content of RAM. The minidump
>> +mechanism provides the means for selected region should be included in
>> +the ramdump.
> 
> Dont' start a sentence with "But"

Sure.

> 
> You're also not being clear what you mean by "the entire content of RAM" 
> since you obviously can't capture a full snap-shot of DRAM and store in 
> DRAM.
> 
> Better to say IMO
> 
> "Minidump captures specific pre-defined regions of RAM and stores those 
> regions in a reserved Minidump specific buffer."
> 
> "The region of RAM used to store Minidump data shall be referred to as 
> SMEM throughout this document." [1]

ok

> 
>> +::
>> +
>> +   +-----------------------------------------------+
>> +   |   DDR                       +-------------+   |
> 
> Instead of saying "DDR" just mark this as RAM or Memory.
> Its a terrible nit-pick from me but DDR = "Double Data Rate Synchronous 
> Dynamic Random-Access Memory" but that's irrelevant to this 
> specification. We could be living in a gigantic SRAM for argument sake.

Sure.

> 
>> +   |                             |      SS0-ToC|   |
>> +   | +----------------+     +----------------+ |   |
>> +   | |Shared memory   |     |         SS1-ToC| |   |
>> +   | |(SMEM)          |     |                | |   |
>> +   | |                | +-->|--------+       | |   |
>> +   | |G-ToC           | |   | SS-ToC  \      | |   |
>> +   | |+-------------+ | |   | +-----------+  | |   |
>> +   | ||-------------| | |   | |-----------|  | |   |
>> +   | || SS0-ToC     | | | +-|<|SS1 region1|  | |   |
>> +   | ||-------------| | | | | |-----------|  | |   |
>> +   | || SS1-ToC     |-|>+ | | |SS1 region2|  | |   |
>> +   | ||-------------| |   | | |-----------|  | |   |
>> +   | || SS2-ToC     | |   | | |  ...      |  | |   |
>> +   | ||-------------| |   | | |-----------|  | |   |
>> +   | ||  ...        | |   |-|<|SS1 regionN|  | |   |
>> +   | ||-------------| |   | | |-----------|  | |   |
>> +   | || SSn-ToC     | |   | | +-----------+  | |   |
>> +   | |+-------------+ |   | |                | |   |
>> +   | |                |   | |----------------| |   |
>> +   | |                |   +>|  regionN       | |   |
>> +   | |                |   | |----------------| |   |
>> +   | +----------------+   | |                | |   |
>> +   |                      | |----------------| |   |
>> +   |                      +>|  region1       | |   |
>> +   |                        |----------------| |   |
>> +   |                        |                | |   |
>> +   |                        |----------------|-+   |
>> +   |                        |  region5       |     |
>> +   |                        |----------------|     |
>> +   |                        |                |     |
>> +   |  Region information    +----------------+     |
>> +   | +---------------+                             |
>> +   | |region name    |                             |
>> +   | |---------------|                             |
>> +   | |region address |                             |
>> +   | |---------------|                             |
>> +   | |region size    |                             |
>> +   | +---------------+                             |
>> +   +-----------------------------------------------+
>> +       G-ToC: Global table of contents
>> +       SS-ToC: Subsystem table of contents
>> +       SS0-SSn: Subsystem numbered from 0 to n
> 
> You need to be more consistent here
> 
> SSX-ToC -> SSX-SSn
> 
> Where X is an integer from 0 upwards and similarly n is a integer from 0 
> upwards.
> 
> This name SSX-SSn is not especially descriptive, I'm not sure if this is 
> a name you are choosing here ? If so then let me suggest a new name like 
> "Subsystem Memory Segment" SSX-MSn

looks good.

> 
> ->
> 
>         G-ToC: Global table of contents
>         SSX-ToC: Subsystem X table of contents.
>                  X is an integer in the range of 0 to ?
>                  Is there an upper limit ?

Older Soc had the limit of 10 but the newer SoC firmware this limit has 
increased.

This reminds me of creating a patch to make the no of subsystem 
configurable through CONFIG_*.

   #define MAX_NUM_OF_SS           10

"drivers/remoteproc/qcom_common.c"


>                  Presumably this is an 8, 16, 32 or 64 bit integer
>                  Please define either the size of the integer or the
>                  valid range of values 0..128, 0..256
>         SSX-MSn: Subsystem numbered from 0 to n
>                  Same comment for the 'n' here.

Thanks again..

> 
>> +
>> +It depends on SoC where the underlying firmware is keeping the
>> +minidump global table taking care of subsystem ToC part for
>> +minidump like for above diagram, it is for shared memory sitting
>> +in DDR and it is shared among various master however it is possible
> 
>> +that this could be implemented via memory mapped regions but the
>> +general idea should remain same. Here, various subsystem could be
>> +DSP's like ADSP/CDSP/MODEM etc, along with Application processor
>> +(APSS) where Linux runs. 
> 
> 
> DSP minidump gets collected when DSP's goes
>> +for recovery followed by a crash. The minidump part of code for
>> +that resides in ``qcom_rproc_minidump.c``.
> 
> This paragraph is difficult to parse.
> 
> What you are describing here is a linked list, I think you should have a 
> paragraph describing how the memory structure works
> 
> ->
> 
> "Minidump determines which areas of DRAM to capture via a Minidump 
> defined linked-list structure.
> 
> At the top level a Global Table of Contents (GTOC) enumerates a variable 
> number of SubSystem Table Of Contents (SSTOC) structures.
> 
> Each SSTOC contains a list of SubSystem Memory Segements which are named 
> according to the containing SSTOC hence (SSX-MSn) where "X" denotes the 
> SystemSystem index of the containing SSX-ToC and "n" denotes an 
> individual Memory Segment within the SystemSystem. Hence SS0-MS0 belongs 
> to SS0-ToC whereas SS1-MS0 belongs to SS1-ToC."

Thanks for this.

> 
> Then I think you can describe how the crash dump colleciton works and 
> which agents of the system - DSP ? is responsible for collecting the 
> crashdump
> 
> ->
> 
> "The Application Processor SubSystem (APSS) runs the Linux kernel and is 
> therefore not responsible for assembling Minidump data. One of the other 
> system agents in the SoC will be responsible for capturing the Minidump 
> data during system reset.
> 
> Typically one of the SoC Digital Signal Processors (DSP) will be used 
> for this purpose.
> 
> During reset the DSP will walk the GTOC, SSX-ToCs and SSX-MSns 
> populating the Minidump RAM area with the indicated memory"
> 
>> +
>> +
>> +SMEM as backend
> 
> 
>> +----------------
>> +
>> +In this document, SMEM will be used as the backend implementation
>> +of minidump.
> 
> [1] As per the above link, you need to introduce the term SMEM earlier.
> 
> It's fine to expand on its meaning later but, do please define it once 
> upfront before you use it in your awesome ASCII art.

Sure.

> 
>> +The core of minidump feature is part of Qualcomm's boot firmware code.
>> +It initializes shared memory (SMEM), which is a part of DDR and
>> +allocates a small section of it to minidump table, i.e. also called
>> +global table of contents (G-ToC). Each subsystem (APSS, ADSP, ...) has
>> +its own table of segments to be included in the minidump, all
>> +references from a descriptor in SMEM (G-ToC). Each segment/region has
>> +some details like name, physical address and its size etc. and it
>> +could be anywhere scattered in the DDR.
> 
> ->
> 
> "The SoC's bootloader must reserve an area of RAM as SMEM prior to 
> handing over control to the run-time operating system. The bootloader is 
> responsible to place the GTOC at the starting address of SMEM."
> 
> If you want to give more technical details of size, physical address - 
> then explicitly define those in the section above which talks about the 
> linked-list structure.
> 
> Please try to avoid use of "etc" or "and so on" since it assumes the 
> reader already knows how the system works and can fill in the blanks 
> but, what you are doing here is educating a Minidump novice in how 
> things work.

ok.

> 
>> +
>> +Qualcomm APSS Minidump kernel driver concept
>> +--------------------------------------------
>> +
>> +Qualcomm APSS minidump kernel driver adds the capability to add Linux
> 
> So why "Minidump" and then "minidump" choose one.
> 
>> +region to be dumped as part of RAM dump collection.
> 
> 
> OK so this really is the "meat" of the system. The bootloader/firmware 
> populates the GTOC.
> 
> The Q this document should probably answer is how the kernel driver 
> knows how/where to place its data.
> 
> Assumed to be parsing the DTB.
> 
>   At the moment,
>> +shared memory driver creates platform device for minidump driver and
>> +give a means to APSS minidump to initialize itself on probe.
> 
> "At the moment" is another drop.
> 
> Just make a clear statement
> 
> "The minidump platform driver populates the APSS porition of the GTOC"
> 
> more interesting to me is - are there defined numbers, identifiers for 
> the APSS ? or do we just add new entries to the GTOC ?
> 
> ie. is there a reserved index or "type" in the GTOC that identifies 
> where the APSS needs to insert itself ?

Correct.

APSS has similar index i.e, 0 similar to minidump index for other 
remoteprocs mentioned belowin GTOC.

https://elixir.bootlin.com/linux/v6.7-rc5/source/drivers/remoteproc/qcom_q6v5_pas.c#L1113

https://elixir.bootlin.com/linux/v6.7-rc5/source/drivers/remoteproc/qcom_q6v5_pas.c#L1133

https://elixir.bootlin.com/linux/v6.7-rc5/source/drivers/remoteproc/qcom_q6v5_pas.c#L1153

qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, &size);

Above API is the key, And given SMEM ID it gives the object detail 
present in shared memory and whether it is Minidump global table 
structure object address in case of minidump or SoC info object
in case of socinfo related information (drivers/soc/qcom/socinfo.c).

> 
>> +This driver provides ``qcom_minidump_region_register`` and
>> +``qcom_minidump_region_unregister`` API's to register and unregister
>> +APSS minidump region. 
> 
> Why does it do that ? Is it not the case that the driver knows where the 
> APSS data goes ?

If you mean why does it provide
qcom_minidump_region_register/qcom_minidump_region_unregister

E.g., it is for the linux clients to upfront register their buffer or 
object which they want to see to check once there is crash from their 
driver and same is true other linux clients.

In the current state of the driver it does not export these symbols
and only captures ramoops frontends data like console, dmesg, ftrace, 
pmesg but there is plan to do that when one of the upstream client
driver interested in capturing something from their driver they have
to use this API to register it with APSS minidump table.

> 
> It also supports registration for the clients
>> +who came before minidump driver was initialized. It maintains pending
>> +list of clients who came before minidump and once minidump is 
>> initialized
>> +it registers them in one go.
> 
> Don't start sentences with "It" -> "The driver" or "Minidump"
> 
> As I read this though, the Minidump driver in Linux isn't just 
> registering / managing the APSS side of things but also "doing stuff" 
> for other clients ?
> 
> How does the Linux driver know what to register ?

Again, I am reiterating what i said above, it is upto the client driver 
interests what they want to check from their driver once they see a 
crash from there driver, it could be some buffer content or structure
object or anything.

Minidump is kind of blind what are you capturing is not known to itself.

> 
>> +
>> +To simplify post-mortem debugging, driver creates and maintain an ELF
> 
> the driver creates and maintains
> 
>> +header as first region that gets updated each time a new region gets
>> +registered.
> 
> as the first region
> 
> So - who is registering these regions ? Linux kernel drivers ? aDSP / 
> cDSP ?

For APSS(linux), driver register it through the call made to
qcom_minidump_region_{register|unregister} by the linux clients.
Here, it provide flexiblity to dynamically register the regions.

For ADSP/CDSP/MODEM, they will have their own way which is mostly
statically decided what addresses range they want to capture on
their crash.

> 
> If I write a new driver for Venus or GPU can I define my own region(s) 
> to be captured ?

I am not an expert of Venus/GPU but AFAIK, currently their firmware side 
don't use minidump but you can still use APSS minidump to register
required their host regions from GPU/VENUS linux drivers once APSS 
minidump driver exports register/unregister API.

> 
> Presumably. Please give more detail on this.
> 
>> +
>> +The solution supports extracting the RAM dump/minidump produced either
>> +over USB or stored to an attached storage device.
> 
> What provides that functionality ? The bootloader ?

Yes, the bootloader.

> 
> How do you trigger / capture that dump from the bootloader ?

This is explained how to set minidump and once set any region of SOC
crash will collect minidump and if not set by default entire ddr
dump is collected.

> 
> No need to go into super-detail but give some idea.
> 
>> +
>> +Dependency of minidump kernel driver
>> +------------------------------------
>> +
>> +It is to note that whole of minidump depends on Qualcomm boot firmware
>> +whether it supports minidump or not. 
> 
> You can drop this - you've already stated the bootloader/firmware must 
> setup the initial table so, you're not providing additional information 
> with this statement.
> 
>> So, if the minidump SMEM ID is
> 
> Try not to start sentences with "So"
> 
> SMEM ID ? This is your first time using this term - please relate it 
> back to your ASCII diagram and the description you give with that text.
> 
>> +present in shared memory, it indicates that minidump is supported from
>> +boot firmware and it is possible to dump Linux (APSS) region as part
>> +of minidump collection.
> 
> If _which_ SMEM ID ?
> 
> It seems to me as if we are missing some important information here - 
> what are the list of SMEM IDs ?
> 
> Are these IDs serial and incrementing across SoC versions or SoC specific ?


I have described above in my explanation probably it should make sense 
now, will also try to add it in the doc.

> 
> You need to define that data.
> 
>> +How a kernel client driver can register region with minidump
>> +------------------------------------------------------------
> 
> Answering yes to my earlier question. A driver I write can make use of 
> the API you are providing here.
> 
> Great. Please give some indication of that earlier, even if its a 
> reference to this description you give here "See X.Y later in this 
> document"
> 
>> +
>> +Client driver can use ``qcom_minidump_region_register`` API's to 
>> register
>> +and ``qcom_minidump_region_unregister`` to unregister their region from
>> +minidump driver.
>> +
>> +Client needs to fill their region by filling ``qcom_minidump_region``
>> +structure object which consists of the region name, region's virtual
>> +and physical address and its size.
> 
> Nit pick. You need a definite article here "A client driver" etc.
> 
>> +
>> +Below, is one sample client driver snippet which tries to allocate a
>> +region from kernel heap of certain size and it writes a certain known
>> +pattern.
> 
> Good
> 
>   (that can help in verification after collection that we got
>> +the exact pattern, what we wrote) and registers it with minidump.
> 
> Not necessary to define this. We are all smart here and by now the 
> intent of the mechanism is defined..
> 
>> +
>> + .. code-block:: c
>> +
>> +  #include <soc/qcom/qcom_minidump.h>
>> +  [...]
>> +
>> +
>> +  [... inside a function ...]
>> +  struct qcom_minidump_region region;
>> +
>> +  [...]
>> +
>> +  client_mem_region = kzalloc(region_size, GFP_KERNEL);
>> +  if (!client_mem_region)
>> +    return -ENOMEM;
>> +
>> +  [... Just write a pattern ...]
>> +  memset(client_mem_region, 0xAB, region_size);
>> +
>> +  [... Fill up the region object ...]
>> +  strlcpy(region.name, "REGION_A", sizeof(region.name));
>> +  region.virt_addr = client_mem_region;
>> +  region.phys_addr = virt_to_phys(client_mem_region);
>> +  region.size = region_size;
>> +
>> +  ret = qcom_minidump_region_register(&region);
>> +  if (ret < 0) {
>> +    pr_err("failed to add region in minidump: err: %d\n", ret);
>> +    return ret;
>> +  }
>> +
>> +  [...]
>> +
>> +
>> +Test
>> +----
> 
> Testing
> 
>> +
>> +Existing Qualcomm devices already supports entire RAM dump (also called
>> +full dump) by writing appropriate value to Qualcomm's top control and
>> +status register (tcsr) in ``driver/firmware/qcom_scm.c`` .
> 
> "Existing Qualcomm SoCs already support dumping the entire RAM to the 
> SMEM area/segment/whatever"
> 
> This is 100% counter-intuitive since SMEM lives in RAM, correct ?
> 
> Full dump means what, a full dump of the APSS RAM ? What happens if SMEM 
> cannot accommodate the full APSS RAM dump ?

Sorry, I never said full dump is captured in SMEM, the only difference 
of minidump with full dump is, no region registration is required so no
need of SMEM(where the meta data is there right ?) and entire ddr dump 
is collected by firmware/bootloader and it sent to to host connected 
machine via USB through Sahara protocol.

> 
>> +
>> +SCM device Tree bindings required to support download mode
>> +For example (sm8450) ::
>> +
>> +    / {
>> +
>> +    [...]
>> +
>> +        firmware {
>> +            scm: scm {
>> +                compatible = "qcom,scm-sm8450", "qcom,scm";
>> +                [... tcsr register ... ]
>> +                qcom,dload-mode = <&tcsr 0x13000>;
>> +
>> +                [...]
>> +            };
>> +        };
>> +
>> +    [...]
>> +
>> +        soc: soc@0 {
>> +
>> +            [...]
>> +
>> +            tcsr: syscon@1fc0000 {
>> +                compatible = "qcom,sm8450-tcsr", "syscon";
>> +                reg = <0x0 0x1fc0000 0x0 0x30000>;
>> +            };
>> +
>> +            [...]
>> +        };
>> +    [...]
>> +
>> +    };
>> +
>> +User of minidump can pass ``qcom_scm.download_mode="mini"`` to kernel
>> +commandline to set the current download mode to minidump.
> 
> "A kernel command line parameter is provided 
> ``qcom_scm.download_mode="mini"`` to facilitate ... but you aren't 
> telling us what "minidump" captures "the current download" ? do you mean 
> the current state ?

Minidump is a SoC solution and not specific to linux(APSS) so even if
there is no APSS linux driver to capture linux specific regions,
firmware like ADSP/CDSP/MODEM or Trustzone or boot loader still 
registers their own regions that get captured and you will get them on 
crash. If there is no registration from anywhere it will not dump
anything.

> 
> Does the system continue to boot up if you pass 
> qcom_scm.download_mode="mini ? will additional registrations to 
> SMEM/Minidump work ?

yes, it will continue to boot, this parameter just convert the
capture mode from full dump (entire ddr dump ) to minidump (smem)
registered region dump.

Yes, additional registration of linux region to SMEM will work.

> 
> What happens to the minidump data if there is a _subsequent_ real 
> crashdump ?

By passing qcom_scm.download_mode="mini" we are converting crash dump
mode from full(complete ddr) to minidump.
> 
> Overwritten ?
> 
> Also what happens if SMEM runs out of space ? Say I boot with 
> ``qcom_scm.download_mode="mini"`` and then the system crashes - SMEM has 
> a limit right ?
> 
> So the minidump gets overwritten ?

I think, is this after your confusion full dump also gets written to
SMEM ?

if this crashes before qcom_scm.download_mode="mini" mode was set then
full ramdump gets collected which is default gets set from the firmware
however, it is also possible to set minidump by default from the
firmware, but let's no go into that detail.

> 
>> +Similarly, ``"full"`` is passed to set the download mode to full dump
>> +where entire RAM dump will be collected while setting it ``"full,mini"``
>> +will collect minidump along with fulldump.
> 
> Still not super-clear what the difference between mini and full is here.

It should be clear by now.

> 
>> +
>> +Writing to sysfs node can also be used to set the mode to minidump::
>> +
>> +    echo "mini" > /sys/module/qcom_scm/parameter/download_mode
>> +
>> +Once the download mode is set, any kind of crash will make the device 
>> collect
>> +respective dump as per set download mode.
> 
> Nice.
> 
>> +
>> +Dump collection
>> +---------------
>> +::
>> +
>> +    +-----------+
>> +    |           |
>> +    |           |         +------+
>> +    |           |         |      |
>> +    |           |         +--+---+ Product(Qualcomm SoC)
>> +    +-----------+             |
>> +    |+++++++++++|<------------+
>> +    |+++++++++++|    usb cable
>> +    +-----------+
>> +            x86_64 PC
>> +
>> +The solution supports a product running with Qualcomm SoC (where 
>> minidump)
>> +is supported from the firmware) connected to x86_64 host PC running PCAT
>> +tool.
> 
> It supports downloading the minidump produced from product to the
>> +host PC over USB or to save the minidump to the product attached storage
>> +device(UFS/eMMC/SD Card) into minidump dedicated partition.
> 
> It would be a good idea to reference this section earlier.

Ok.

Thanks again, for going into such minute detail and asking these questions.

I really appriciate the interest.

-Mukesh

> 
>> +
>> +By default, dumps are downloaded via USB to the attached x86_64 PC 
>> running
>> +PCAT (Qualcomm tool) software. Upon download, we will see a set of 
>> binary
>> +blobs starting with name ``md_*`` in PCAT configured directory in x86_64
>> +machine, so for above example from the client it will be 
>> ``md_REGION_A.BIN``.
>> +This binary blob depends on region content to determine whether it needs
>> +external parser support to get the content of the region, so for simple
>> +plain ASCII text we don't need any parsing and the content can be seen
>> +just opening the binary file.
>> +
>> +To collect the dump to attached storage type, one needs to write 
>> appropriate
>> +value to IMEM register, in that case dumps are collected in rawdump
>> +partition on the product device itself.
>> +
>> +One needs to read the entire rawdump partition and pull out content to
>> +save it onto the attached x86_64 machine over USB. Later, this rawdump
>> +can be passed to another tool (``dexter.exe`` [Qualcomm tool]) which
>> +converts this into the similar binary blobs which we have got it when
>> +download type was set to USB, i.e. a set of registered regions as blobs
>> +and their name starts with ``md_*``.
>> +
>> +Replacing the ``dexter.exe`` with some open source tool can be added 
>> as future
>> +scope of this document.
> 
> ---
> bod
