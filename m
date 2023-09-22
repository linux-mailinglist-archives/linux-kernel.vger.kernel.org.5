Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02047AB347
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjIVOKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjIVOKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:10:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D623100;
        Fri, 22 Sep 2023 07:10:12 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MAlPgr013694;
        Fri, 22 Sep 2023 14:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oGkedumiF7qYscPq09Wq92YClO+TfRoVXGPIg+PD0HQ=;
 b=Iar2PsA+0E28/CsFqHGYd7r3UjZPVQpoujsfZeeSjbJ6/Qp2k+RrRyyTSk2CbcMe5kVi
 iGZkGYFWIfUJjQAU67QlAjfKXiGDpQztz/6nBuGrunS70v9JEp63IX3RAT8TqoPxjtnp
 fvxFXe9kr4U74CoyINvW/2jZEIzunz8pOp+63HSNgCYbR99Ix6/6AQgnpQxq0WaYTG9E
 utWo/L/2i/aQsHqTegA3hVbzngUQm1HBL3G2tPZ9KqjjP6uaVJT4Xqihmf6COf1BENfA
 en6G6bFxFgZWP4YG6i22r8+nwv0tNkDcj0lF3TazJuEeqcORzkPYQN3eKeGo+K+kY9U8 6A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8txga2d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 14:10:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38MEA38a027467
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 14:10:03 GMT
Received: from [10.48.243.100] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 22 Sep
 2023 07:10:03 -0700
Message-ID: <b5fa2ea0-d025-47e3-a1c3-eb7c2f6bc5b7@quicinc.com>
Date:   Fri, 22 Sep 2023 07:10:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug] mhi: ath11k: resume after hibernation is not working
Content-Language: en-US
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        <kvalo@kernel.org>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230922120040.15460-1-jtornosm@redhat.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230922120040.15460-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5eaN3bOQAHFkZHFd0mV6_XoLmwyPlDDd
X-Proofpoint-GUID: 5eaN3bOQAHFkZHFd0mV6_XoLmwyPlDDd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_12,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=804 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220121
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/2023 5:00 AM, Jose Ignacio Tornos Martinez wrote:
> Hello,
> 
> We have several machines with QCNFA765 wireless card (WCN6856) and with
> the same behavior: although hibernation seems to work, post resume is not
> working due to the wireless card (if the wireless card is disabled or ath11k
> driver is blacklisted, everything is working).

This is a known issue being tracked by:
https://bugzilla.kernel.org/show_bug.cgi?id=214649

A fix for this issue is under development.

/jeff

