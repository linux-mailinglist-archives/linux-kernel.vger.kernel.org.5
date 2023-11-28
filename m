Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F907FBB12
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345005AbjK1NPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344860AbjK1NPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:15:43 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1C7D60
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:15:47 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id ffacd0b85a97d-332d5c852a0so3429084f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701177346; x=1701782146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=doVpP2O/1xocMcJTzHru/uuvZ/2y27/PHQwnXguSD2k=;
        b=pPZXvz6c1TQOxS/DvjME3P8IULSsJpMV/p2Li73ld8rw+8ZjHGi6ZvZ1nFg4BefJES
         Bdwg9ze+8tcvGnkPQfZnw04HQKUeI23c2DpLHOv2xKWozPXCld0zsyWYmxvjuNCy7eZu
         pt7h1aiUwB8+o72dE2E4/RIIcAZ92cof17POXZv6gjb/4Akkh69EVSsrN+3l0cFuGjFk
         E7aAC0n6JMB4ptNzClCtLV5Oz8ExlwJh6vw5GTQ0rpG4sMVyncA33AC62RUf3jNOXE+x
         +sdSF1EiWHc04WpJuofE+lj3Zh64tFUrZxCc2DAZiHDvbFAp1xqa82V5au1nkvRvbvv2
         WeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177346; x=1701782146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doVpP2O/1xocMcJTzHru/uuvZ/2y27/PHQwnXguSD2k=;
        b=u9RLTuPysmk/51soEhsPLUQH0YfisWDKIiKeUZJKanSqDggupD/aQ1miq/+OjHsUF/
         lKKIxUFoX8mhaM03/aKzfwp+JgKYIMnF0QgOn6zQthkfRijKOGEW1XUiUCBANZH04dhu
         bGrccmimWNe2/Mld/1haRh0wsbPR9yJ9JNBBDMEV0H7odKIyyVYFu9bNefPvX+yA9TO6
         Xn8mDwdPfG7ZUP2HxlxbX3R4WyAT+eLrwP+ZGCoZZW9+450Rq9T1r10gSjA1v5xO/SbB
         DhCbYY/67SGsQDu06pXXbXpuRAdd+fmOUHPR1ZBYZZSU7Gox7kpx6XXnwlRaTej2UyYB
         BwCg==
X-Gm-Message-State: AOJu0YxfYl1bPqWlittdOj3asNXnL3bGh8xbA3wJ1ET7dom0jTaGoxKq
        jZaowtC8971+u00qx7wpVUwozQ==
X-Google-Smtp-Source: AGHT+IF5Cafplop9m5creSapYYaNFhZ+IQY3Uo1h1xUyT62KVMgXgiy6c2emry2WYHv4fix4hOk5Xg==
X-Received: by 2002:a5d:448f:0:b0:332:c593:16c with SMTP id j15-20020a5d448f000000b00332c593016cmr10407808wrq.45.1701177345716;
        Tue, 28 Nov 2023 05:15:45 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id j12-20020adff00c000000b00332eadd7ea4sm11957790wro.78.2023.11.28.05.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 05:15:44 -0800 (PST)
Message-ID: <b50fd14e-7798-4b1e-aff3-9409e67300b3@linaro.org>
Date:   Tue, 28 Nov 2023 13:15:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 03/12] docs: qcom: Add qualcomm minidump guide
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, corbet@lwn.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, mathieu.poirier@linaro.org, vigneshr@ti.com,
        nm@ti.com, matthias.bgg@gmail.com, kgene@kernel.org,
        alim.akhtar@samsung.com, bmasney@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@quicinc.com
References: <1700864395-1479-1-git-send-email-quic_mojha@quicinc.com>
 <1700864395-1479-4-git-send-email-quic_mojha@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1700864395-1479-4-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2023 22:19, Mukesh Ojha wrote:
> Add the qualcomm minidump guide for the users which tries to cover
> the dependency, API use and the way to test and collect minidump
> on Qualcomm supported SoCs.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   Documentation/admin-guide/index.rst         |   1 +
>   Documentation/admin-guide/qcom_minidump.rst | 272 ++++++++++++++++++++++++++++
>   2 files changed, 273 insertions(+)
>   create mode 100644 Documentation/admin-guide/qcom_minidump.rst

General nit-pick on sequencing of your patches. Its good practice (tm) 
to put your documentation first in your series.

> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 43ea35613dfc..251d070486c2 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -120,6 +120,7 @@ configure specific aspects of kernel behavior to your liking.
>      perf-security
>      pm/index
>      pnp
> +   qcom_minidump
>      rapidio
>      ras
>      rtc
> diff --git a/Documentation/admin-guide/qcom_minidump.rst b/Documentation/admin-guide/qcom_minidump.rst
> new file mode 100644
> index 000000000000..b492f2b79639
> --- /dev/null
> +++ b/Documentation/admin-guide/qcom_minidump.rst
> @@ -0,0 +1,272 @@
> +Qualcomm minidump feature
> +=========================
> +
> +Introduction
> +------------
> +
> +Minidump is a best effort mechanism to collect useful and predefined
> +data for first level of debugging on end user devices running on
> +Qualcomm SoCs. 

What does "first-level debugging" mean here ? You use the term 
"post-mortem" later, stick with one term for consistency throughout your 
document.

Suggest:

"Minidump is a best-effort mechanism to collect useful predefined data 
for post-mortem debugging on a Qualcomm System on Chips (SoCs)."

Generally better to stick with "Qualcomm SoC" and "Minidump" once you 
establish the terms upfront and early in your text - instead of 
reverting to "device" and "it".

It is built on the premise that System on Chip (SoC)
> +or subsystem part of SoC crashes, due to a range of hardware and
> +software bugs.
Instead of saying "It" say "Minidump"

Hence, the ability to collect accurate data is only
> +a best-effort. The data collected could be invalid or corrupted, data
> +collection itself could fail, and so on.

"and so on" is a redundancy, drop.


Suggest:
Minidump is built on the premise that a hardware or software component 
on the SoC has encountered an unexpected fault. This means that the data 
collected by minidump cannot be assumed to be correct or even present.

> +
> +Qualcomm devices in engineering mode provides a mechanism for generating
> +full system RAM dumps for post-mortem debugging. 

Stick with the established naming convention

"Qualcomm SoCs in engineering mode provide a mechanism for generating 
full system RAM dumps for this post-mortem debugging"

But in some cases it's
> +however not feasible to capture the entire content of RAM. The minidump
> +mechanism provides the means for selected region should be included in
> +the ramdump.

Dont' start a sentence with "But"

You're also not being clear what you mean by "the entire content of RAM" 
since you obviously can't capture a full snap-shot of DRAM and store in 
DRAM.

Better to say IMO

"Minidump captures specific pre-defined regions of RAM and stores those 
regions in a reserved Minidump specific buffer."

"The region of RAM used to store Minidump data shall be referred to as 
SMEM throughout this document." [1]

> +::
> +
> +   +-----------------------------------------------+
> +   |   DDR                       +-------------+   |

Instead of saying "DDR" just mark this as RAM or Memory.
Its a terrible nit-pick from me but DDR = "Double Data Rate Synchronous 
Dynamic Random-Access Memory" but that's irrelevant to this 
specification. We could be living in a gigantic SRAM for argument sake.

> +   |                             |      SS0-ToC|   |
> +   | +----------------+     +----------------+ |   |
> +   | |Shared memory   |     |         SS1-ToC| |   |
> +   | |(SMEM)          |     |                | |   |
> +   | |                | +-->|--------+       | |   |
> +   | |G-ToC           | |   | SS-ToC  \      | |   |
> +   | |+-------------+ | |   | +-----------+  | |   |
> +   | ||-------------| | |   | |-----------|  | |   |
> +   | || SS0-ToC     | | | +-|<|SS1 region1|  | |   |
> +   | ||-------------| | | | | |-----------|  | |   |
> +   | || SS1-ToC     |-|>+ | | |SS1 region2|  | |   |
> +   | ||-------------| |   | | |-----------|  | |   |
> +   | || SS2-ToC     | |   | | |  ...      |  | |   |
> +   | ||-------------| |   | | |-----------|  | |   |
> +   | ||  ...        | |   |-|<|SS1 regionN|  | |   |
> +   | ||-------------| |   | | |-----------|  | |   |
> +   | || SSn-ToC     | |   | | +-----------+  | |   |
> +   | |+-------------+ |   | |                | |   |
> +   | |                |   | |----------------| |   |
> +   | |                |   +>|  regionN       | |   |
> +   | |                |   | |----------------| |   |
> +   | +----------------+   | |                | |   |
> +   |                      | |----------------| |   |
> +   |                      +>|  region1       | |   |
> +   |                        |----------------| |   |
> +   |                        |                | |   |
> +   |                        |----------------|-+   |
> +   |                        |  region5       |     |
> +   |                        |----------------|     |
> +   |                        |                |     |
> +   |  Region information    +----------------+     |
> +   | +---------------+                             |
> +   | |region name    |                             |
> +   | |---------------|                             |
> +   | |region address |                             |
> +   | |---------------|                             |
> +   | |region size    |                             |
> +   | +---------------+                             |
> +   +-----------------------------------------------+
> +       G-ToC: Global table of contents
> +       SS-ToC: Subsystem table of contents
> +       SS0-SSn: Subsystem numbered from 0 to n

You need to be more consistent here

SSX-ToC -> SSX-SSn

Where X is an integer from 0 upwards and similarly n is a integer from 0 
upwards.

This name SSX-SSn is not especially descriptive, I'm not sure if this is 
a name you are choosing here ? If so then let me suggest a new name like 
"Subsystem Memory Segment" SSX-MSn

->

        G-ToC: Global table of contents
        SSX-ToC: Subsystem X table of contents.
                 X is an integer in the range of 0 to ?
                 Is there an upper limit ?
                 Presumably this is an 8, 16, 32 or 64 bit integer
                 Please define either the size of the integer or the
                 valid range of values 0..128, 0..256
        SSX-MSn: Subsystem numbered from 0 to n
                 Same comment for the 'n' here.

> +
> +It depends on SoC where the underlying firmware is keeping the
> +minidump global table taking care of subsystem ToC part for
> +minidump like for above diagram, it is for shared memory sitting
> +in DDR and it is shared among various master however it is possible

> +that this could be implemented via memory mapped regions but the
> +general idea should remain same. Here, various subsystem could be
> +DSP's like ADSP/CDSP/MODEM etc, along with Application processor
> +(APSS) where Linux runs. 


DSP minidump gets collected when DSP's goes
> +for recovery followed by a crash. The minidump part of code for
> +that resides in ``qcom_rproc_minidump.c``.

This paragraph is difficult to parse.

What you are describing here is a linked list, I think you should have a 
paragraph describing how the memory structure works

->

"Minidump determines which areas of DRAM to capture via a Minidump 
defined linked-list structure.

At the top level a Global Table of Contents (GTOC) enumerates a variable 
number of SubSystem Table Of Contents (SSTOC) structures.

Each SSTOC contains a list of SubSystem Memory Segements which are named 
according to the containing SSTOC hence (SSX-MSn) where "X" denotes the 
SystemSystem index of the containing SSX-ToC and "n" denotes an 
individual Memory Segment within the SystemSystem. Hence SS0-MS0 belongs 
to SS0-ToC whereas SS1-MS0 belongs to SS1-ToC."

Then I think you can describe how the crash dump colleciton works and 
which agents of the system - DSP ? is responsible for collecting the 
crashdump

->

"The Application Processor SubSystem (APSS) runs the Linux kernel and is 
therefore not responsible for assembling Minidump data. One of the other 
system agents in the SoC will be responsible for capturing the Minidump 
data during system reset.

Typically one of the SoC Digital Signal Processors (DSP) will be used 
for this purpose.

During reset the DSP will walk the GTOC, SSX-ToCs and SSX-MSns 
populating the Minidump RAM area with the indicated memory"

> +
> +
> +SMEM as backend


> +----------------
> +
> +In this document, SMEM will be used as the backend implementation
> +of minidump.

[1] As per the above link, you need to introduce the term SMEM earlier.

It's fine to expand on its meaning later but, do please define it once 
upfront before you use it in your awesome ASCII art.

> +The core of minidump feature is part of Qualcomm's boot firmware code.
> +It initializes shared memory (SMEM), which is a part of DDR and
> +allocates a small section of it to minidump table, i.e. also called
> +global table of contents (G-ToC). Each subsystem (APSS, ADSP, ...) has
> +its own table of segments to be included in the minidump, all
> +references from a descriptor in SMEM (G-ToC). Each segment/region has
> +some details like name, physical address and its size etc. and it
> +could be anywhere scattered in the DDR.

->

"The SoC's bootloader must reserve an area of RAM as SMEM prior to 
handing over control to the run-time operating system. The bootloader is 
responsible to place the GTOC at the starting address of SMEM."

If you want to give more technical details of size, physical address - 
then explicitly define those in the section above which talks about the 
linked-list structure.

Please try to avoid use of "etc" or "and so on" since it assumes the 
reader already knows how the system works and can fill in the blanks 
but, what you are doing here is educating a Minidump novice in how 
things work.

> +
> +Qualcomm APSS Minidump kernel driver concept
> +--------------------------------------------
> +
> +Qualcomm APSS minidump kernel driver adds the capability to add Linux

So why "Minidump" and then "minidump" choose one.

> +region to be dumped as part of RAM dump collection.


OK so this really is the "meat" of the system. The bootloader/firmware 
populates the GTOC.

The Q this document should probably answer is how the kernel driver 
knows how/where to place its data.

Assumed to be parsing the DTB.

  At the moment,
> +shared memory driver creates platform device for minidump driver and
> +give a means to APSS minidump to initialize itself on probe.

"At the moment" is another drop.

Just make a clear statement

"The minidump platform driver populates the APSS porition of the GTOC"

more interesting to me is - are there defined numbers, identifiers for 
the APSS ? or do we just add new entries to the GTOC ?

ie. is there a reserved index or "type" in the GTOC that identifies 
where the APSS needs to insert itself ?

> +This driver provides ``qcom_minidump_region_register`` and
> +``qcom_minidump_region_unregister`` API's to register and unregister
> +APSS minidump region. 

Why does it do that ? Is it not the case that the driver knows where the 
APSS data goes ?

It also supports registration for the clients
> +who came before minidump driver was initialized. It maintains pending
> +list of clients who came before minidump and once minidump is initialized
> +it registers them in one go.

Don't start sentences with "It" -> "The driver" or "Minidump"

As I read this though, the Minidump driver in Linux isn't just 
registering / managing the APSS side of things but also "doing stuff" 
for other clients ?

How does the Linux driver know what to register ?

> +
> +To simplify post-mortem debugging, driver creates and maintain an ELF

the driver creates and maintains

> +header as first region that gets updated each time a new region gets
> +registered.

as the first region

So - who is registering these regions ? Linux kernel drivers ? aDSP / cDSP ?

If I write a new driver for Venus or GPU can I define my own region(s) 
to be captured ?

Presumably. Please give more detail on this.

> +
> +The solution supports extracting the RAM dump/minidump produced either
> +over USB or stored to an attached storage device.

What provides that functionality ? The bootloader ?

How do you trigger / capture that dump from the bootloader ?

No need to go into super-detail but give some idea.

> +
> +Dependency of minidump kernel driver
> +------------------------------------
> +
> +It is to note that whole of minidump depends on Qualcomm boot firmware
> +whether it supports minidump or not. 

You can drop this - you've already stated the bootloader/firmware must 
setup the initial table so, you're not providing additional information 
with this statement.

> So, if the minidump SMEM ID is

Try not to start sentences with "So"

SMEM ID ? This is your first time using this term - please relate it 
back to your ASCII diagram and the description you give with that text.

> +present in shared memory, it indicates that minidump is supported from
> +boot firmware and it is possible to dump Linux (APSS) region as part
> +of minidump collection.

If _which_ SMEM ID ?

It seems to me as if we are missing some important information here - 
what are the list of SMEM IDs ?

Are these IDs serial and incrementing across SoC versions or SoC specific ?

You need to define that data.

> +How a kernel client driver can register region with minidump
> +------------------------------------------------------------

Answering yes to my earlier question. A driver I write can make use of 
the API you are providing here.

Great. Please give some indication of that earlier, even if its a 
reference to this description you give here "See X.Y later in this document"

> +
> +Client driver can use ``qcom_minidump_region_register`` API's to register
> +and ``qcom_minidump_region_unregister`` to unregister their region from
> +minidump driver.
> +
> +Client needs to fill their region by filling ``qcom_minidump_region``
> +structure object which consists of the region name, region's virtual
> +and physical address and its size.

Nit pick. You need a definite article here "A client driver" etc.

> +
> +Below, is one sample client driver snippet which tries to allocate a
> +region from kernel heap of certain size and it writes a certain known
> +pattern.

Good

  (that can help in verification after collection that we got
> +the exact pattern, what we wrote) and registers it with minidump.

Not necessary to define this. We are all smart here and by now the 
intent of the mechanism is defined..

> +
> + .. code-block:: c
> +
> +  #include <soc/qcom/qcom_minidump.h>
> +  [...]
> +
> +
> +  [... inside a function ...]
> +  struct qcom_minidump_region region;
> +
> +  [...]
> +
> +  client_mem_region = kzalloc(region_size, GFP_KERNEL);
> +  if (!client_mem_region)
> +	return -ENOMEM;
> +
> +  [... Just write a pattern ...]
> +  memset(client_mem_region, 0xAB, region_size);
> +
> +  [... Fill up the region object ...]
> +  strlcpy(region.name, "REGION_A", sizeof(region.name));
> +  region.virt_addr = client_mem_region;
> +  region.phys_addr = virt_to_phys(client_mem_region);
> +  region.size = region_size;
> +
> +  ret = qcom_minidump_region_register(&region);
> +  if (ret < 0) {
> +	pr_err("failed to add region in minidump: err: %d\n", ret);
> +	return ret;
> +  }
> +
> +  [...]
> +
> +
> +Test
> +----

Testing

> +
> +Existing Qualcomm devices already supports entire RAM dump (also called
> +full dump) by writing appropriate value to Qualcomm's top control and
> +status register (tcsr) in ``driver/firmware/qcom_scm.c`` .

"Existing Qualcomm SoCs already support dumping the entire RAM to the 
SMEM area/segment/whatever"

This is 100% counter-intuitive since SMEM lives in RAM, correct ?

Full dump means what, a full dump of the APSS RAM ? What happens if SMEM 
cannot accommodate the full APSS RAM dump ?

> +
> +SCM device Tree bindings required to support download mode
> +For example (sm8450) ::
> +
> +	/ {
> +
> +	[...]
> +
> +		firmware {
> +			scm: scm {
> +				compatible = "qcom,scm-sm8450", "qcom,scm";
> +				[... tcsr register ... ]
> +				qcom,dload-mode = <&tcsr 0x13000>;
> +
> +				[...]
> +			};
> +		};
> +
> +	[...]
> +
> +		soc: soc@0 {
> +
> +			[...]
> +
> +			tcsr: syscon@1fc0000 {
> +				compatible = "qcom,sm8450-tcsr", "syscon";
> +				reg = <0x0 0x1fc0000 0x0 0x30000>;
> +			};
> +
> +			[...]
> +		};
> +	[...]
> +
> +	};
> +
> +User of minidump can pass ``qcom_scm.download_mode="mini"`` to kernel
> +commandline to set the current download mode to minidump.

"A kernel command line parameter is provided 
``qcom_scm.download_mode="mini"`` to facilitate ... but you aren't 
telling us what "minidump" captures "the current download" ? do you mean 
the current state ?

Does the system continue to boot up if you pass 
qcom_scm.download_mode="mini ? will additional registrations to 
SMEM/Minidump work ?

What happens to the minidump data if there is a _subsequent_ real 
crashdump ?

Overwritten ?

Also what happens if SMEM runs out of space ? Say I boot with 
``qcom_scm.download_mode="mini"`` and then the system crashes - SMEM has 
a limit right ?

So the minidump gets overwritten ?

> +Similarly, ``"full"`` is passed to set the download mode to full dump
> +where entire RAM dump will be collected while setting it ``"full,mini"``
> +will collect minidump along with fulldump.

Still not super-clear what the difference between mini and full is here.

> +
> +Writing to sysfs node can also be used to set the mode to minidump::
> +
> +	echo "mini" > /sys/module/qcom_scm/parameter/download_mode
> +
> +Once the download mode is set, any kind of crash will make the device collect
> +respective dump as per set download mode.

Nice.

> +
> +Dump collection
> +---------------
> +::
> +
> +	+-----------+
> +	|           |
> +	|           |         +------+
> +	|           |         |      |
> +	|           |         +--+---+ Product(Qualcomm SoC)
> +	+-----------+             |
> +	|+++++++++++|<------------+
> +	|+++++++++++|    usb cable
> +	+-----------+
> +            x86_64 PC
> +
> +The solution supports a product running with Qualcomm SoC (where minidump)
> +is supported from the firmware) connected to x86_64 host PC running PCAT
> +tool.

It supports downloading the minidump produced from product to the
> +host PC over USB or to save the minidump to the product attached storage
> +device(UFS/eMMC/SD Card) into minidump dedicated partition.

It would be a good idea to reference this section earlier.

> +
> +By default, dumps are downloaded via USB to the attached x86_64 PC running
> +PCAT (Qualcomm tool) software. Upon download, we will see a set of binary
> +blobs starting with name ``md_*`` in PCAT configured directory in x86_64
> +machine, so for above example from the client it will be ``md_REGION_A.BIN``.
> +This binary blob depends on region content to determine whether it needs
> +external parser support to get the content of the region, so for simple
> +plain ASCII text we don't need any parsing and the content can be seen
> +just opening the binary file.
> +
> +To collect the dump to attached storage type, one needs to write appropriate
> +value to IMEM register, in that case dumps are collected in rawdump
> +partition on the product device itself.
> +
> +One needs to read the entire rawdump partition and pull out content to
> +save it onto the attached x86_64 machine over USB. Later, this rawdump
> +can be passed to another tool (``dexter.exe`` [Qualcomm tool]) which
> +converts this into the similar binary blobs which we have got it when
> +download type was set to USB, i.e. a set of registered regions as blobs
> +and their name starts with ``md_*``.
> +
> +Replacing the ``dexter.exe`` with some open source tool can be added as future
> +scope of this document.

---
bod
