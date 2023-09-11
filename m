Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B90D79BEAD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbjIKUvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237854AbjIKNPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:15:21 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C268AE9;
        Mon, 11 Sep 2023 06:15:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c35ee3b0d2so28295345ad.2;
        Mon, 11 Sep 2023 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694438116; x=1695042916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2yRSNijSEry1q3t5KG0YspbSUTWaMB7q8b9zVPDgfQ=;
        b=HVCnvGufcw2atJ/kBHS5BNiOeCCZoMiP+ih2eU8wEazPc6nGyd/581cSd/nNyKHoNw
         EMBoLq7rH5QC0598H9O49HoJcvvZzpfeFPRciXRQRWfgrYRfbtMOgpbxPjXFRkUQKlgG
         Fizzgd7U0sM9dO0Qlzf6sHI2ETnXPiwuRkOV+vvaXyI2eccZvD/1lZCxWILPk+9zrOan
         JD6A5VsQOo95whgRNcO9fqyz+p9Kx3Lfn2KMH35dXu0C47m+oG2OZzrKa12kKkBsOr+r
         F84zn/dI8gTpvjWy5BeKohSfcQGRbh+thchaq7QZ8qOXZm72r6TquGl1pgA45ykyE5av
         CCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438116; x=1695042916;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2yRSNijSEry1q3t5KG0YspbSUTWaMB7q8b9zVPDgfQ=;
        b=iD/YlYViUZJE9bfZVjtltOqU9WRLdNcSygQRS7/QroMy8Yo8nrhnEf4hb/SxI8d/Tv
         He0OT7xp9HouyD3PUla0MX0Mej8xuiA5y64vyqdcgozinoze9YfGA3FfgJtbqrMRM5Qu
         vLAyvgC9g2rzxiDTyhTrDgJh/tfii9p6jcOHPIGywaF/ASlL4sWOmrl5d+VhaMKfAE5a
         kxaau1YGkIoVKt1GkemWyJER5rXO7Ed38NUTlAWzOHmbRPCV7Qx50Qxrp3FE95aFdDKx
         g30QIuW7kVFgTw51vK7hlbP1yCCNWm167QIn9M95/0Vo3xswqobdUdZzsPkNc57xF3xv
         oq/Q==
X-Gm-Message-State: AOJu0YxNzRTCxxsPN3EsHOvlAMrj0kQ1jPl1OlIgAXGMGwD1vsC2ltcY
        CyoPhY7FJf3dAQ8d8LS3zFM=
X-Google-Smtp-Source: AGHT+IELjlMzUCNKicXbgrdGNOE2IUiNXf+0+gLijFTkFHG5fABBFoZEs1wFcY4YX7BmQrH9l7MLTA==
X-Received: by 2002:a17:903:41c8:b0:1c0:c86a:5425 with SMTP id u8-20020a17090341c800b001c0c86a5425mr10229624ple.19.1694438116095;
        Mon, 11 Sep 2023 06:15:16 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d90500b001b9ecee459csm6372378plz.34.2023.09.11.06.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:15:15 -0700 (PDT)
Message-ID: <d3c32833-72c3-f10c-bdb1-52de90eb90c7@gmail.com>
Date:   Mon, 11 Sep 2023 20:14:55 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 00/17] Add Qualcomm Minidump kernel driver related
 support
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, corbet@lwn.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, mathieu.poirier@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, vigneshr@ti.com, nm@ti.com,
        matthias.bgg@gmail.com, kgene@kernel.org, alim.akhtar@samsung.com,
        bmasney@redhat.com, quic_tsoni@quicinc.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@quicinc.com
References: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
 <ZP7VPfVtvbmB5aQf@debian.me>
 <c52e90e4-cab0-13b7-9658-1f730de6cf64@quicinc.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <c52e90e4-cab0-13b7-9658-1f730de6cf64@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 17:39, Mukesh Ojha wrote:
> 
> 
> On 9/11/2023 2:22 PM, Bagas Sanjaya wrote:
>> On Sun, Sep 10, 2023 at 01:46:01AM +0530, Mukesh Ojha wrote:
>>> Hi All,
>>>
>>> This is to continuation from the conversation happened at v4
>>>
>>> https://lore.kernel.org/lkml/632c5b97-4a91-c3e8-1e6c-33d6c4f6454f@quicinc.com/
>>>
>>> https://lore.kernel.org/lkml/695133e6-105f-de2a-5559-555cea0a0462@quicinc.com/
>>>
>>> We have put abstract on LPC on this topic as well as initiated a mail thread
>>> with other SoC vendors but did not get much traction on it.
>>>
>>> https://lore.kernel.org/lkml/0199db00-1b1d-0c63-58ff-03efae02cb21@quicinc.com/
>>>
>>> We explored most of possiblity present in kernel to address this issue[1] but
>>> solution like kdump/fadump does not seems safe/secure/performant from our
>>> perspective.
>>>
>>> Hence, with this series we tried to make the minidump kernel driver, simple
>>> and tied with pstore frontends, so that it collects the present available
>>> frontends data like dmesg, ftrace, pmsg, ftrace., Also, we will be working
>>> towards enhancing generic pstore to capture more debug data which will be
>>> helpful for first hand of debugging that can benefit both other pstore users
>>> as well as us as minidump users.
>>>
>>> One of the proposal made here,
>>> https://lore.kernel.org/lkml/1683561060-2197-1-git-send-email-quic_mojha@quicinc.com/
>>>
>>> Looking forward for your comments.
>>>
>>> Thanks,
>>> Mukesh
>>>
>>> [1]
>>> Minidump is a best effort mechanism to collect useful and predefined data
>>> for first level of debugging on end user devices running on Qualcomm SoCs.
>>> It is built on the premise that System on Chip (SoC) or subsystem part of
>>> SoC crashes, due to a range of hardware and software bugs. Hence, the
>>> ability to collect accurate data is only a best-effort. The data collected
>>> could be invalid or corrupted, data collection itself could fail, and so on.
>>>
>>> Qualcomm devices in engineering mode provides a mechanism for generating
>>> full system ramdumps for post mortem debugging. But in some cases it's
>>> however not feasible to capture the entire content of RAM. The minidump
>>> mechanism provides the means for selecting which snippets should be
>>> included in the ramdump.
>>>
>>> The core of SMEM based minidump feature is part of Qualcomm's boot
>>> firmware code. It initializes shared memory (SMEM), which is a part of
>>> DDR and allocates a small section of SMEM to minidump table i.e also
>>> called global table of content (G-ToC). Each subsystem (APSS, ADSP, ...)
>>> has their own table of segments to be included in the minidump and all
>>> get their reference from G-ToC. Each segment/region has some details
>>> like name, physical address and it's size etc. and it could be anywhere
>>> scattered in the DDR.
>>>
>>> Existing upstream Qualcomm remoteproc driver[1] already supports SMEM
>>> based minidump feature for remoteproc instances like ADSP, MODEM, ...
>>> where predefined selective segments of subsystem region can be dumped
>>> as part of coredump collection which generates smaller size artifacts
>>> compared to complete coredump of subsystem on crash.
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/remoteproc/qcom_common.c#n142
>>>
>>> In addition to managing and querying the APSS minidump description,
>>> the Linux driver maintains a ELF header in a segment. This segment
>>> gets updated with section/program header whenever a new entry gets
>>> registered.
>>>
>>> Changes in v5:
>>>   - On suggestion from Pavan.k, to have single function call for minidump collection
>>>     from remoteproc driver, separated the logic to have separate minidump file called
>>>     qcom_rproc_minidump.c and also renamed the function from qcom_minidump() to
>>>     qcom_rproc_minidump(); however, dropped his suggestion about rework on lazy deletion
>>>     during region unregister in this series, will pursue it in next series.
>>>
>>>   - To simplify the minidump driver, removed the complication for frontend and different
>>>     backend from Greg suggestion, will pursue this once main driver gets mainlined.
>>>
>>>   - Move the dynamic ramoops region allocation from Device tree approach to command line
>>>     approch with the introduction command line parsing and memblock reservation during
>>>     early boot up; Not added documentation about it yet, will add if it gets positive
>>>     response.
>>>
>>>   - Exporting linux banner from kernel to make minidump build also as module, however,
>>>     minidump is a debug module and should be kernel built to get most debug information
>>>     from kernel.
>>>
>>>   - Tried to address comments given on dload patch series.
>>>
>>> Changes in v4: https://lore.kernel.org/lkml/1687955688-20809-1-git-send-email-quic_mojha@quicinc.com/
>>>   - Redesigned the driver and divided the driver into front end and backend (smem) so
>>>     that any new backend can be attached easily to avoid code duplication.
>>>   - Patch reordering as per the driver and subsystem to easier review of the code.
>>>   - Removed minidump specific code from remoteproc to minidump smem based driver.
>>>   - Enabled the all the driver as modules.
>>>   - Address comments made on documentation and yaml and Device tree file [Krzysztof/Konrad]
>>>   - Address comments made qcom_pstore_minidump driver and given its Device tree
>>>     same set of properties as ramoops. [Luca/Kees]
>>>   - Added patch for MAINTAINER file.
>>>   - Include defconfig change as one patch as per [Krzysztof] suggestion.
>>>   - Tried to remove the redundant file scope variables from the module as per [Krzysztof] suggestion.
>>>   - Addressed comments made on dload mode patch v6 version
>>>     https://lore.kernel.org/lkml/1680076012-10785-1-git-send-email-quic_mojha@quicinc.com/
>>>
>>> Changes in v3: https://lore.kernel.org/lkml/1683133352-10046-1-git-send-email-quic_mojha@quicinc.com/
>>>   - Addressed most of the comments by Srini on v2 and refactored the minidump driver.
>>>      - Added platform device support
>>>      - Unregister region support.
>>>   - Added update region for clients.
>>>   - Added pending region support.
>>>   - Modified the documentation guide accordingly.
>>>   - Added qcom_pstore_ramdump client driver which happen to add ramoops platform
>>>     device and also registers ramoops region with minidump.
>>>   - Added download mode patch series with this minidump series.
>>>      https://lore.kernel.org/lkml/1680076012-10785-1-git-send-email-quic_mojha@quicinc.com/
>>>
>>> Changes in v2: https://lore.kernel.org/lkml/1679491817-2498-1-git-send-email-quic_mojha@quicinc.com/
>>>   - Addressed review comment made by [quic_tsoni/bmasney] to add documentation.
>>>   - Addressed comments made by [srinivas.kandagatla]
>>>   - Dropped pstore 6/6 from the last series, till i get conclusion to get pstore
>>>     region in minidump.
>>>   - Fixed issue reported by kernel test robot.
>>>
>>> Changes in v1: https://lore.kernel.org/lkml/1676978713-7394-1-git-send-email-quic_mojha@quicinc.com/
>>>
>>> Testing of the patches has been done on sm8450 target after enabling config like
>>> CONFIG_PSTORE_RAM and CONFIG_PSTORE_CONSOLE and once the device boots up.
>>>
>>>   echo mini > /sys/module/qcom_scm/parameters/download_mode
>>>
>>> Try crashing it via devmem2 0xf11c000(this is known to create xpu violation and
>>> and put the device in download mode) on command prompt.
>>>
>>> Default storage type is set to via USB, so minidump would be downloaded with the
>>> help of x86_64 machine (running PCAT tool) attached to Qualcomm device which has
>>> backed minidump boot firmware support.
>>>
>>> This will make the device go to download mode and collect the minidump on to the
>>> attached x86 machine running the Qualcomm PCAT tool(This comes as part Qualcomm
>>> package manager kit).
>>>
>>> After that we will see a bunch of predefined registered region as binary blobs files
>>> starts with md_* downloaded on the x86 machine on given location in PCAT tool from
>>> the target device, more about this can be found in qualcomm minidump guide patch.
>>>
>>
>> I tried to apply this series on top of 535a265d7f0dd50 (as suggested by
>> `b4 am -l -g`), but it conflicts on patch [04/17]. Please specify the
>> exact base commit or another series for which this series is based on.
> 
> Apologies !
> I just realized, it was 6.5-rc7, but let me rebase version of the series;
> 
> Sorry, for all the reviewed done so far, i will definitely take care of them or reply.
> 

OK, see you in v6!

-- 
An old man doll... just what I always wanted! - Clara

