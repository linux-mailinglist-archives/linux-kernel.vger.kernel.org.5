Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1B87E68CC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjKIKwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjKIKwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:52:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97DB26B1;
        Thu,  9 Nov 2023 02:52:05 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A99VRiJ023860;
        Thu, 9 Nov 2023 10:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=asrSdqR8etWm4UY4zGpWvqxO6HonHQwNqgQz2v72Wxs=;
 b=aKw6aqzE2PGn+w71hms9xeBWz7UDGw8CZ4P2CpJmPnc8DkUKKZlIrwed5dMV26fb5BwW
 exlclVe+I5J9mDC/yMZcfqEEMJfD0a4ArM5becTbqYASBUX7H3mEPMUo3v5C5ToV255L
 IG50uWbbGSHAgq5uXGxfGQODKIlCjUMniJgQAsFpjGvmkb4tIpY+Bm6+zLXbUN3wbQQQ
 Xmwi/SomsTLMRYWb0TP0FT0XYpuC/HFXBP1F2LSik7U37x/HbGG4JjDZCXJw6QxDyvYa
 KCXEgf4H3bJ0UHz8PBJAHJ7drb5CPVYjjmHbS2/kHGKK0I2TPtg6Dvy2WLfCjuojE3Mh 2g== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u8t0nrum2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 10:51:32 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A9ApV9Y001631
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Nov 2023 10:51:31 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 9 Nov
 2023 02:51:26 -0800
Message-ID: <887a37d7-a719-ab02-0a60-d9f17c2f37e2@quicinc.com>
Date:   Thu, 9 Nov 2023 18:51:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: ufs: Add msi-parent for UFS MCQ
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh@kernel.org>
CC:     <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <mani@kernel.org>, <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <quic_nguyenb@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1698835699-28550-1-git-send-email-quic_ziqichen@quicinc.com>
 <20231106144831.GA317907-robh@kernel.org>
 <5850d5ac-e735-4358-866d-f410b00ba39d@acm.org>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <5850d5ac-e735-4358-866d-f410b00ba39d@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2XRJs_KHp5Fr3Vr0h-B-FIuWq-52-cHN
X-Proofpoint-GUID: 2XRJs_KHp5Fr3Vr0h-B-FIuWq-52-cHN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_08,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2023 1:56 AM, Bart Van Assche wrote:
> On 11/6/23 06:48, Rob Herring wrote:
>> On Wed, Nov 01, 2023 at 06:48:13PM +0800, Ziqi Chen wrote:
>>> The Message Signaled Interrupts (MSI) has been introduced
>>> to UFS driver since the MCQ be enabled.
>>
>> Not really relevant when a driver supported MSI, but the when the h/w
>> did. Has UFS always supported MSI? It was added in some version of the
>> spec?
> 
> MSI support has been introduced in UFSHCI version 4.0 and I think that
> the controller vendor can decide whether or not to implement MSI. Does
> this mean that the patch needs to be improved?
> 
> Thanks,
> 
> Bart.
> 

Hi Rob, in my previous patch " dt-bindings: ufs: qcom: Add msi-parent 
for UFS MCQ",  Manivannan Sadhasivam also think instead of 
qcom,ufs.yaml, this should be part of ufs-common.yaml.

please let me know if there is any others I need to improve for this 
patch. Thanks a lot.


Best Regards,
Ziqi
