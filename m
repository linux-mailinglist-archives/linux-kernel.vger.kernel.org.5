Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E807BA1F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjJEPGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjJEPFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:05:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E276D085;
        Thu,  5 Oct 2023 07:41:04 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3958tp9X011945;
        Thu, 5 Oct 2023 09:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=khXMauHaN37WlQI4QDMEvQGmqZEu2LmWzhZ2mcPvDZE=;
 b=iJK+h5UuvXGORfn3Su1l5sNOStXWzdWo2SX732Gm5YR0hV00KAsUHE5TrqBapDYIrba4
 vvKQWwhVgWSq3RqZHHkpA8egeIqltIXNsVQjREFtaaW9/EHhSU/n5gPODR5wv4NZ70kR
 GK17VR6RR9YB62Tlk1e+5PfvImxIqSCQfnYTBsi0EmMZL3z/XFPQN3Kbo1+JtxWDovHB
 vRvFhkWevWwzKqTPwM3CkaoEcOk3larNK1rWmCyTmN6pvIvp77gzi2oaxPenuQNjCSiT
 /a1booBASbHnQoWd0xgEOCYgvU8fhcDAiVXtgxoujUQAwPx/DR3gfvo/bbZCa0/bAtrs rA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thfkh155e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 09:03:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 395931mm029885
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 09:03:01 GMT
Received: from [10.216.33.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 5 Oct
 2023 02:02:58 -0700
Message-ID: <d6974352-e157-421b-aa2d-e4a6c791ca2b@quicinc.com>
Date:   Thu, 5 Oct 2023 14:32:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/3] Add multiport support for DWC3 controllers
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20231004165922.25642-1-quic_kriskura@quicinc.com>
 <ZR5ZUaWcyRj5sZKx@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZR5ZUaWcyRj5sZKx@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PYKGrIw-0QHMrmDtdXhsl-lWKvnsWBm5
X-Proofpoint-ORIG-GUID: PYKGrIw-0QHMrmDtdXhsl-lWKvnsWBm5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_06,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=889
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050069
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2023 12:06 PM, Johan Hovold wrote:
> On Wed, Oct 04, 2023 at 10:29:19PM +0530, Krishna Kurapati wrote:
>> This series is a set of picked up acks and split from larger series [1]
>> The series is rebased on top of:
>> Repo: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
>> Branch: usb-testing
>> commit 03cf2af41b37 ("Revert "phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support"")
>>
>> The patches present in series have been reviewed and acked by respective
>> maintainers. They dont break any existing implementation and is just a
>> subset of merge ready multiport code. The rest of the patches will be
>> rebased on top of the usb branch once this series is merged.
>>
>> [1]: https://patchwork.kernel.org/project/linux-usb/cover/20230828133033.11988-1-quic_kriskura@quicinc.com/
>>
>> Krishna Kurapati (3):
>>    usb: dwc3: core: Access XHCI address space temporarily to read port
>>      info
>>    usb: dwc3: core: Skip setting event buffers for host only controllers
>>    usb: dwc3: qcom: Add helper function to request threaded IRQ
> 
> NAK.
> 
> These patches make very little sense on their own and can't really be
> evaluated without the context of the larger series.
> 
> Just work on getting the multiport series in shape and include any acks
> you've received so far when submitting new revisions.
> 

Hi Johan,

  This may be partially true for first patch of this series, (where we 
read num_ports), but the other two patches are self explanatory and are 
applicable for non-mp controllers as well. Intention was to ensure we 
make the next rebase easy.

  Will try to address all comments and send v12 again as a whole series 
this week. I am actually blocked on [1]. Not able to repro the compile 
error on my end. That's what stopped me from sending all at once.

[1]: https://lore.kernel.org/all/202309200156.CxQ3yaLY-lkp@intel.com/

Thanks,
Krishna,
