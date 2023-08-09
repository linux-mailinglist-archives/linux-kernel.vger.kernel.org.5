Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790D57756C2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjHIJ5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjHIJ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:57:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741801FDE;
        Wed,  9 Aug 2023 02:57:39 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3799WPpA019243;
        Wed, 9 Aug 2023 09:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fVpgZKslMcyy352rXxoKVRWUIDnDc472zh70Y9sLZgk=;
 b=d4Maz9dq4SjgkOTMh2RTqY13cOKTAQs8oueOBSPBMnLZ5spYWEKo/FlK1apofX7D4STP
 KjymAC3tcisMx2NVwreuPp0jnu/b8yRLxRK//LJ5gdcKCx0bk5e/8xQu16XS8+r674CL
 i5znt2G23mHVjUpH7CKwWACD9c0TXkkNZ7j8Lq4ZZvkW8WiAJzt5PTbngkodRGuoAg13
 05aZD0ilcOoqTz2mT2E/t4hXbg9CMvZsALLUlPISD6CQxS8bY3ayCjx0UO3IWxxb0YjM
 0fUJcIGsczxcu5n52FM+pyulKdFQrq/Jy6zIvgOLeaTuaw8A8O/E3z6CxOyiOpjddPX9 lw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc6k588t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 09:57:33 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3799vWRb025929
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 09:57:32 GMT
Received: from [10.79.198.201] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 02:57:28 -0700
Message-ID: <2e9c9e03-bc25-9c37-2a91-0fbf75d500a4@quicinc.com>
Date:   Wed, 9 Aug 2023 15:27:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: qcom: Add intr_target_width field to support
 increased number of interrupt targets
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppareek@quicinc.com>,
        <psodagud@quicinc.com>, <quic_kprasan@quicinc.com>,
        <quic_ymg@quicinc.com>, Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20230718064246.12429-1-quic_ninanaik@quicinc.com>
 <fskuol2q4wbfilrz3x3dcmikhjgfsajgnuqjnp4petxr2ne6at@zfnonisxnjh3>
 <pdag3mk5fru4x7zc3lljrt3mlg2g2pa6l6h7l6fyd6n2kjydli@yvxpnjelwfns>
From:   Ninad Naik <quic_ninanaik@quicinc.com>
In-Reply-To: <pdag3mk5fru4x7zc3lljrt3mlg2g2pa6l6h7l6fyd6n2kjydli@yvxpnjelwfns>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wOVM9lJuCgmwe85pme1p7db5VnxWtSxy
X-Proofpoint-ORIG-GUID: wOVM9lJuCgmwe85pme1p7db5VnxWtSxy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_08,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/2023 2:36 AM, Andrew Halaney wrote:
> On Tue, Jul 18, 2023 at 08:32:59AM -0700, Bjorn Andersson wrote:
>> On Tue, Jul 18, 2023 at 12:12:46PM +0530, Ninad Naik wrote:
>>> SA8775 and newer target have added support for an increased number of
>>> interrupt targets. To implement this change, the intr_target field, which
>>> is used to configure the interrupt target in the interrupt configuration
>>> register is increased from 3 bits to 4 bits.
>>>
>>> In accordance to these updates, a new intr_target_width member is
>>> introduced in msm_pingroup structure. This member stores the value of
>>> width of intr_target field in the interrupt configuration register. This
>>> value is used to dynamically calculate and generate mask for setting the
>>> intr_target field. By default, this mask is set to 3 bit wide, to ensure
>>> backward compatibility with the older targets.
>>>
>>> Changes in v2 :
>>> -----------------
>>> - Changed initial definition of intr_target_mask variable to use GENMASK().
>>> - Update commit subject appropiately.
>>> - Add Fixes tag.
>>> - v1 : https://lore.kernel.org/all/20230714061010.15817-1-quic_ninanaik@quicinc.com/
>>
>> Thanks for adding a good changelog, very much appreciated. The changelog
>> should be added below the '---' line though, as it typically don't add
>> value to the git history (except drivers/gpu/* which wants it here...).
>>
>> Perhaps Linus can drop it as he applies the patch, no need to resubmit
>> unless he ask you to.
>>
>> Thanks,
>> Bjorn
>>
> 
> Gentle ping on this one... but then I realized that linusw isn't CC'ed
> on this patch directly, and I'm unsure of what the workflow is for
> pinctrl. ./scripts/get_maintainer.pl shows he should have been in the CC
> list ideally :)
> 
> Maybe send a v3 with the changelog dropped from the actual message (i.e.
> follow Bjorn's advice), and make sure to include the folks
> get_maintainer tells you to so this gets picked up (or maybe just saying
> Linus' name will make him appear out of the woodworks if we're lucky):
My bad on this one, I'll immediately send a v3 along with addressing the 
changelog suggestion mentioned by Bjorn.
> 
>      ahalaney@fedora ~/git/linux-next (git)-[7de73ad15b73] % b4 am 20230718064246.12429-1-quic_ninanaik@quicinc.com
>      Grabbing thread from lore.kernel.org/all/20230718064246.12429-1-quic_ninanaik@quicinc.com/t.mbox.gz
>      Analyzing 3 messages in the thread
>      Checking attestation on all messages, may take a moment...
>      ---
>        ✓ [PATCH v2] pinctrl: qcom: Add intr_target_width field to support increased number of interrupt targets
>        ---
>        ✓ Signed: DKIM/quicinc.com
>      ---
>      Total patches: 1
>      ---
>       Link: https://lore.kernel.org/r/20230718064246.12429-1-quic_ninanaik@quicinc.com
>       Base: applies clean to current tree
>             git checkout -b v2_20230718_quic_ninanaik_quicinc_com HEAD
>             git am ./v2_20230718_quic_ninanaik_pinctrl_qcom_add_intr_target_width_field_to_support_increased_number_of_in.mbx
>      ahalaney@fedora ~/git/linux-next (git)-[7de73ad15b73] % ./scripts/get_maintainer.pl ./v2_20230718_quic_ninanaik_pinctrl_qcom_add_intr_target_width_field_to_support_increased_number_of_in.mbx
>      Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
>      Bjorn Andersson <andersson@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
>      Konrad Dybcio <konrad.dybcio@linaro.org> (maintainer:ARM/QUALCOMM SUPPORT,blamed_fixes:1/1=100%)
>      Linus Walleij <linus.walleij@linaro.org> (maintainer:PIN CONTROL SUBSYSTEM,blamed_fixes:1/1=100%)
>      Bartosz Golaszewski <bartosz.golaszewski@linaro.org> (blamed_fixes:1/1=100%)
>      Yadu MG <quic_ymg@quicinc.com> (blamed_fixes:1/1=100%)
>      Prasad Sodagudi <quic_psodagud@quicinc.com> (blamed_fixes:1/1=100%)
>      linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
>      linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM)
>      linux-kernel@vger.kernel.org (open list)
>      ahalaney@fedora ~/git/linux-next (git)-[7de73ad15b73] %
> 
> I'm eager to get this fix in so I can describe a missing IRQ or two
> wrt ethernet GPIOs and submit that without stating the dependency
> on this fix! :)
> 
> Thanks,
> Andrew
> 
Thanks,
Ninad
