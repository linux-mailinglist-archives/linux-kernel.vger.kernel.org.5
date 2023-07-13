Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503B07527EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjGMQCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjGMQBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:01:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB9B270D;
        Thu, 13 Jul 2023 09:01:47 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DF0Icj001283;
        Thu, 13 Jul 2023 16:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CsT9iAfXVZR9OmieCUMutP9im1dY1nRQpXp0+pqVraU=;
 b=omTjDHwojwQZNIE+LPUxUgFssq2p8tnAxnGeJLe9sn2yRwiW8qJ+eg5v+ja3lVk6Arpr
 EuPP7d+p/Fi7r+l0agwK5Tc6ERmb1dlX3FDMsKaGPkmsYUzXRvD7xzJXLrnyNdHA/YQT
 motXpcgHkgrNE7vO+WdclCnm/ZDCB5IDma0q3VaFFHK0eE19JIc5msOQ36eiFjqNDH1a
 pRnTQBjsbzvTCrIH0zX/UfZI+D6CuLUiQKATa1hWRdxEuvOoUF5HEaCHbyHUe8ERk/IC
 AhnFb9xIMUSf7li5knDBIf1jj3y7CIwAKrrFhOzrIMu4qNq7zDyeakdgIO26pzHcXwup hA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt3qfhxwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 16:01:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36DG1eqC028111
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 16:01:40 GMT
Received: from [10.111.182.44] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 13 Jul
 2023 09:01:39 -0700
Message-ID: <0c205c06-bdbd-a6f6-f351-52c918b1cff0@quicinc.com>
Date:   Thu, 13 Jul 2023 09:01:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net v2] ath6kl: Remove error checking for
 debugfs_create_dir()
Content-Language: en-US
To:     Wang Ming <machel@vivo.com>, Kalle Valo <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <opensource.kernel@vivo.com>, <pabeni@redhat.com>
References: <20230713100404.5096-1-machel@vivo.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230713100404.5096-1-machel@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WZfuo20TynACNMheW7FBEj_qV9-CIp-k
X-Proofpoint-GUID: WZfuo20TynACNMheW7FBEj_qV9-CIp-k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501 mlxlogscore=544
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130141
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

subject prefix should be "wifi: ath6kl: "


