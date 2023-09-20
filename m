Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420707A8B66
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjITSPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjITSPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:15:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D52CA;
        Wed, 20 Sep 2023 11:14:55 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KIEVfL030845;
        Wed, 20 Sep 2023 18:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3sioAcKLxxe5PCijkngfhgV8WZTIUxqLlulMSRyMJuM=;
 b=TJHqd7lpxRyUa8EmA1T7Wf/MgITMg6Sg5X17XtOdvlVi3VpsJHXe7xhUnZJsskXypXzW
 Z/ksXEjscuMfHLY/CeiI77Uw8OFCnMilA+7gIK5G65J52M9DHlhKH2h6E8VanqEMRCtA
 OMRxaaUUNo/bEWmgxI6/zXsBUQsfVq6jc/qnDL1pzM3sOztsq4OuMTnr65Lk0xKDEY4W
 iElLulXmCrjRDJtNJdeZX4KxsB35EXzOL5vDt58UxHkrsx566CanOx3Tl4MGc3DDEJn2
 b7Er83/hlxgt3PfajflUOLLTCCXnIb6ugYe2oXtjbPayzMFxDEPFzp8RmONeWaB70cEW vQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t80pk8xnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 18:14:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38KIEatU008860
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 18:14:36 GMT
Received: from [10.48.245.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 20 Sep
 2023 11:14:35 -0700
Message-ID: <1b8b3a0f-a9f7-435f-aeda-47ba92c78df1@quicinc.com>
Date:   Wed, 20 Sep 2023 11:14:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 wireless-next 1/9] wifi: ar5523: Remove unnecessary
 (void*) conversions
Content-Language: en-US
To:     Wu Yunchuan <yunchuan@nfschina.com>, <kvalo@kernel.org>
CC:     <syoshida@redhat.com>, <johannes.berg@intel.com>,
        <alexander@wetzel-home.de>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20230919044906.523189-1-yunchuan@nfschina.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230919044906.523189-1-yunchuan@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0CCuXFV1rXh-9X8GNV4LKCFDVzrdNcMT
X-Proofpoint-ORIG-GUID: 0CCuXFV1rXh-9X8GNV4LKCFDVzrdNcMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_08,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=819
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309200151
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/2023 9:49 PM, Wu Yunchuan wrote:
> No need cast (void*) to (struct ar5523_cmd_hdr *).
> 
> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>


