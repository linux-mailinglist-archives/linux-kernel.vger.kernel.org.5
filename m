Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378CE7BA1FE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjJEPJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjJEPI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:08:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F7A3A8B;
        Thu,  5 Oct 2023 07:34:02 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395CslCb008997;
        Thu, 5 Oct 2023 14:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YCoqfRfci803TAuA+uObCUn+qGJg5RKtRXjOeiZfK9k=;
 b=B55MkgcaOrIqHhjMdlym+xDBLWuWI70fTSRR+UPsCzdji6soDNscZB9CMpzzS5y/uv+s
 IZ7WUww80LuQbymlVFI+jtDsLdBLtGdhzsmKysDaDsLx3pSWxLlBRG7fATexCLNGnenB
 qiE3XTe49bHzeUyq7oTGK64fwUEym7KmRYH+py89QHJ9/cgk13V7N82274x4zMbTtuWQ
 2KxEIuToEtz2ehfgc7t/yYPBdzWf+eSkWrXhE5yr0YJ0v5JceKrBcLNBfIddTZZ40NWs
 jWetd6PI4optHKFdkOBgRXP6+P6bK4M+AH/IzlBLIYfzZqf7aqukugsey0kUBbCeWLZA xg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thrjdrt9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 14:33:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 395EXqb2010454
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 14:33:52 GMT
Received: from [10.216.55.130] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 5 Oct
 2023 07:33:48 -0700
Message-ID: <7a4cf85f-c221-41c5-bc3d-7b00c88aff36@quicinc.com>
Date:   Thu, 5 Oct 2023 20:03:44 +0530
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
X-Proofpoint-ORIG-GUID: wjd4U7B_MpgIcUrCV8sjvUzrM0-anjfe
X-Proofpoint-GUID: wjd4U7B_MpgIcUrCV8sjvUzrM0-anjfe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_08,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
> you've received so far when submitting new revisions
Hi Johan,

  This may be partially true for first patch of this series, (where we 
read num_ports), but the other two patches are self explanatory and are 
applicable for non-mp controllers as well. Intention was to ensure we 
make the next rebase easy.

  Will try to address all comments and send v12 again as a whole series 
this week. I am actually blocked on [1]. Not able to repro the compile 
error on my end. That's what stopped me from sending all at once.

[1]: https://lore.kernel.org/all/202309200156.CxQ3yaLY-lkp@intel.com/

PS: I sent this mail once but some issue with my mail client and the 
mail didn't reach the mailing list. If two copies of same mail comes up, 
pls ignore it.

Thanks,
Krishna,
