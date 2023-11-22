Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081CB7F4D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjKVQtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVQtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:49:11 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F054C1B2;
        Wed, 22 Nov 2023 08:49:04 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMDcVQh009288;
        Wed, 22 Nov 2023 16:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : cc : references : subject : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SKT9R9iYjff926YXo3eXJuJgeIo1hmrH5Haye2g1Cp4=;
 b=Vji5iL0JnOfkk+4+bLuGS4IcvwVvp4gDguydjk1Dd6Oek1lSCucr9cwdDntEAspiXPb8
 OMmTcv1T/9JoCI4ZVMqyl/baceEq8amZCaQXqmjInAj+ufI1ur0NX7k59mCW7AeNN7gk
 ZmWK42HCGzkJQ9Bp9fxYth64Aqbe7v9Vf2FYd9ePdvio5ADObrB43ZVAfq8QNEZgh2Qi
 w2s597yyA2CA/RJZwm0eWMIzoRqRVQAoA3HbvuwZsMX0hxfs2eLvTjI9GrbtzmJi9O36
 DYoNKSpLaRriENGiMWIEQIqx0aXLDnDdZpWHQfkQtCsFvV2DLXTI9CdGEMEPA8fk+KEP 8w== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhf6ks201-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 16:48:32 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AMGmV7b002454
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 16:48:31 GMT
Received: from [10.50.4.8] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 Nov
 2023 08:48:23 -0800
Message-ID: <e172657b-6d96-47ab-bb7e-56a1fdae6f04@quicinc.com>
Date:   Wed, 22 Nov 2023 22:18:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     <yong.wu@mediatek.com>
CC:     <Brian.Starkey@arm.com>, <angelogioacchino.delregno@collabora.com>,
        <benjamin.gaignard@collabora.com>, <christian.koenig@amd.com>,
        <ckoenig.leichtzumerken@gmail.com>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <jianjiao.zeng@mediatek.com>, <jkardatzke@google.com>,
        <joakim.bech@linaro.org>, <jstultz@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <kuohong.wang@mediatek.com>,
        <linaro-mm-sig@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <nicolas@ndufresne.ca>, <quic_vjitta@quicinc.com>,
        <robh+dt@kernel.org>, <sumit.semwal@linaro.org>,
        <tjmercier@google.com>
References: <20231111111559.8218-1-yong.wu@mediatek.com>
Subject: Re: [PATCH v2 0/8] dma-buf: heaps: Add secure heap
Content-Language: en-US
From:   Pratyush Brahma <quic_pbrahma@quicinc.com>
In-Reply-To: <20231111111559.8218-1-yong.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LBMlHL-ANHDe-VZJD3DCpoZKmUAAXEK8
X-Proofpoint-ORIG-GUID: LBMlHL-ANHDe-VZJD3DCpoZKmUAAXEK8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 mlxlogscore=500 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311220121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

We have sent a patch series at [1] using this series to add support for 
Qualcomm secure heaps.
Instead of TEE calls, it uses qcom_scm_assign_mem() to secure the memory.

Thanks,
Pratyush

[1] 
https://lore.kernel.org/lkml/cover.1700544802.git.quic_vjitta@quicinc.com/

