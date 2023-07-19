Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0694758B55
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjGSC3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGSC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:29:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AD71BC3;
        Tue, 18 Jul 2023 19:29:44 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J2TIxH007959;
        Wed, 19 Jul 2023 02:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+oBvnbE4xroSbYblQPs/8HL2djhB8Xgtq8WYGp/sZlM=;
 b=gqeFM/rhDgWUd2209z2WRBT19d41SxrQNrXet2O9odcevW+J9p4WwN8aUK5aaTbuqJ5A
 TKARAu5EURfu3HE0BOqD6DNmuwA8t9NOeIAl+PK9ss+729369gvylZK9apd8zzl7iZZ9
 7NoVWKd1iV7Yww5fwpdwzFLC3dKmfINMPau8cQnNhB/VFdfQTk+yUqnizhWaSSlYG+bB
 Ojq8CJnG1C7GSN+gfTsh0oK/mlWfJuLLQIcoZmJ0cc/sULmkcF2kJEqR/vNTteUIr0zg
 62NXmi46g6kEjQp05u7a8EpAqhdmm5xyDEQCqi9r5rgtV9wHrZUY656hRY8LamHSIxwj Hg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rx728r02k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 02:29:17 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36J2SpRI022113
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 02:28:51 GMT
Received: from [10.110.33.212] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 19:28:49 -0700
Message-ID: <5ef4a5f7-27a0-f46c-fcbd-c3b8c93e0366@quicinc.com>
Date:   Tue, 18 Jul 2023 19:28:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v13 10/24] gunyah: vm_mgr: Add/remove user memory regions
To:     Will Deacon <will@kernel.org>
CC:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Andy Gross <agross@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <qperret@google.com>
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-11-quic_eberman@quicinc.com>
 <20230519115948.GB2637@willie-the-truck>
 <e22c31bd-10ed-f242-3e72-debf40e01e3c@quicinc.com>
 <20230605141839.GD21212@willie-the-truck>
 <3bd86221-ee2e-d157-009b-11f6ada98537@quicinc.com>
 <eae302ab-b508-cdc6-847f-dff6a6b82798@quicinc.com>
 <04605642-cad8-1701-ff41-63f2f00ba5f6@quicinc.com>
 <20230714121321.GB5597@willie-the-truck>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230714121321.GB5597@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SNSk4sgb0_aYac39uGO505G7EPNebv42
X-Proofpoint-ORIG-GUID: SNSk4sgb0_aYac39uGO505G7EPNebv42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_19,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=965 impostorscore=0 spamscore=0 clxscore=1011 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190022
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 7/14/2023 5:13 AM, Will Deacon wrote:
> On Thu, Jul 13, 2023 at 01:28:34PM -0700, Elliot Berman wrote:
>> On 6/22/2023 4:56 PM, Elliot Berman wrote:
>>> On 6/7/2023 8:54 AM, Elliot Berman wrote:
>>>> On 6/5/2023 7:18 AM, Will Deacon wrote:
>>>>> On Fri, May 19, 2023 at 10:02:29AM -0700, Elliot Berman wrote:
>>>>>> The user interface design for *shared* memory aligns with
>>>>>> KVM_SET_USER_MEMORY_REGION.
>>>>>
>>>>> I don't think it does. For example, file mappings don't work (as above),
>>>>> you're placing additional rlimit requirements on the caller, read-only
>>>>> memslots are not functional, the memory cannot be swapped or migrated,
>>>>> dirty logging doesn't work etc. pKVM is in the same boat, but that's why
>>>>> we're not upstreaming this part in its current form.
>>>>>
>>>>
>>>> I thought pKVM was only holding off on upstreaming changes related
>>>> to guest-private memory?
>>>>
>>>>>> I understood we want to use restricted memfd for giving
>>>>>> guest-private memory
>>>>>> (Gunyah calls this "lending memory"). When I went through
>>>>>> the changes, I
>>>>>> gathered KVM is using restricted memfd only for
>>>>>> guest-private memory and not
>>>>>> for shared memory. Thus, I dropped support for lending
>>>>>> memory to the guest
>>>>>> VM and only retained the shared memory support in this
>>>>>> series. I'd like to
>>>>>> merge what we can today and introduce the guest-private
>>>>>> memory support in
>>>>>> tandem with the restricted memfd; I don't see much reason to delay the
>>>>>> series.
>>>>>
>>>>> Right, protected guests will use the new restricted memfd ("guest mem"
>>>>> now, I think?), but non-protected guests should implement the existing
>>>>> interface *without* the need for the GUP pin on guest memory pages. Yes,
>>>>> that means full support for MMU notifiers so that these pages can be
>>>>> managed properly by the host kernel. We're working on that for pKVM, but
>>>>> it requires a more flexible form of memory sharing over what we
>>>>> currently
>>>>> have so that e.g. the zero page can be shared between multiple entities.
>>>>
>>>> Gunyah doesn't support swapping pages out while the guest is running
>>>> and the design of Gunyah isn't made to give host kernel full control
>>>> over the S2 page table for its guests. As best I can tell from
>>>> reading the respective drivers, ACRN and Nitro Enclaves both GUP pin
>>>> guest memory pages prior to giving them to the guest, so I don't
>>>> think this requirement from Gunyah is particularly unusual.
>>>>
>>>
>>> I read/dug into mmu notifiers more and I don't think it matches with
>>> Gunyah's features today. We don't allow the host to freely manage VM's
>>> pages because it requires the guest VM to have a level of trust on the
>>> host. Once a page is given to the guest, it's done for the lifetime of
>>> the VM. Allowing the host to replace pages in the guest memory map isn't
>>> part of any VM's security model that we run in Gunyah. With that
>>> requirement, longterm pinning looks like the correct approach to me.
>>
>> Is my approach of longterm pinning correct given that Gunyah doesn't allow
>> host to freely swap pages?
> 
> No, I really don't think a longterm GUP pin is the right approach for this.
> GUP pins in general are horrible for the mm layer, but required for cases
> such as DMA where I/O faults are unrecoverable. Gunyah is not a good
> justification for such a hack, and I don't think you get to choose which
> parts of the Linux mm you want and which bits you don't.
> 
> In other words, either carve out your memory and pin it that way, or
> implement the proper hooks for the mm to do its job.

I talked to the team about whether we can extend the Gunyah support for 
this. We have plans to support sharing/lending individual pages when the 
guest faults on them. The support also allows (unprotected) pages to be 
removed from the VM. We'll need to temporarily pin the pages of the VM 
configuration device tree blob while the VM is being created and those 
pages can be unpinned once the VM starts. I'll work on this.

Thanks for the feedback!

- Elliot


