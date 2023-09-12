Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F57E79D5E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbjILQM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbjILQMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:12:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4BC10F9;
        Tue, 12 Sep 2023 09:12:08 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CBxXip029920;
        Tue, 12 Sep 2023 16:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HGPwTekFVgsaiRSddNdn3KG0LdKXpPRp2h7EJXZIuyA=;
 b=nhEhRwYSoFkRrQekx8y9ZrsRZRAXkSFL8Q6/G7/OrjgyCUGNBOnOgd3C5ck/3codj6Zr
 JVR/c1U0qatbon07fyibL22aSAFknRGkTkXwdljMMH1BXFhMNZuvTSH433AaD01FGtrj
 woJMWO18LYZn/e7WP0ultrKSeGHszl9mCZBxggbk/v1vM+CH2etUkTE5Rbh2uFXw39Ir
 hvcDNmXHfNsPcdypEFgwBB045iPFQIMn4NdhIJGUFkNO2KHGoIp3myD3CcctTA7MeUCD
 BEt8Hgy865qSHMBZjBo36XAY0PzoVQ5xgrTieyOOuLy9UV8W2I4c6HTQ/sN5jX7/GopN 9w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2qkj8w0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 16:12:02 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38CGC2pK025177
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 16:12:02 GMT
Received: from [10.110.7.215] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 12 Sep
 2023 09:11:58 -0700
Message-ID: <bd3ccb8f-0341-879b-113b-50b341e00d4d@quicinc.com>
Date:   Tue, 12 Sep 2023 09:11:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 0/1] Add driver to read secondary bootloader (XBL) log
Content-Language: en-US
To:     Nikunj Kela <quic_nkela@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <kernel@quicinc.com>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <psodagud@quicinc.com>,
        <quic_aneelaka@quicinc.com>, <quic_kprasan@quicinc.com>,
        <quic_ninanaik@quicinc.com>, <quic_ppareek@quicinc.com>
References: <0abc0e3b-077c-d7b9-e561-2c2e01d46540@quicinc.com>
 <20230912160800.39412-1-quic_nkela@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20230912160800.39412-1-quic_nkela@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DfOBYB9lD8-bZZvOwpHsWVIVNJHKNxNi
X-Proofpoint-GUID: DfOBYB9lD8-bZZvOwpHsWVIVNJHKNxNi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_15,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=577
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2023 9:08 AM, Nikunj Kela wrote:
> From: Nikunj Kela <quic_nkela@quicinc.com
> 
> I was planning something similar for dumping firmware VM's logs. These are in
> ascii format too hence doesn't require any parsing/post processing. Can this
> be little generic so I can use this driver?

This is exactly I want to avoid too. The discussion internally lead us to look at the UEFI/EDK2 work done by Alexander Graf [1] and TPM EFI log driver. For EDK2 we should have generic approach coming from the EDK2 and not just SOC vendor specific approaches. 


[1]
https://edk2.groups.io/g/devel/message/90067
https://github.com/agraf/linux/commit/b1fe0c296ec923e9b1f544862b0eb9365a8da7cb

--
---Trilok Soni

