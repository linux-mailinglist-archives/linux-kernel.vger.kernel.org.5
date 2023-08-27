Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1878978A26F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjH0WAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjH0WAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:00:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8659811B;
        Sun, 27 Aug 2023 15:00:10 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37RLxwdo029031;
        Sun, 27 Aug 2023 21:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=w2vFr4rO5I1Ua8kQ34OWFnCU/OtD7f9ZKbhNxtWIsBI=;
 b=f7TYpN2XUx7JZUjrwVZ448YHeYcuy4/HyGqbkfZzF2DC6WIYmyl0lwyOnham7i5g3MAT
 LmlOKXja13/7ih/YqPtR+N6PDcLK8mXHA0J+NTOp9k+TgVFvHrfSKjmw15NOkyY+Tctw
 nX4Hd5HODxcVHlz1hyKev5US8pUjmfI+8GcDPaT2HuFba1ZkhQbjKq/MCsCZ+P5dgRcr
 qHs/B5g5pPdbm4sHV8vv1iLiDFqe2RzsSkavzTYNrIwttQu58vIe2ow2fqWd8jWOsszs
 X7nVHmdILZU4/zr6pIWLuE8gSl5eM3XNFHgHQGr44WdhdTglJdS5PbEZ2a2Rjr3uZlm1 2w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq907j4ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Aug 2023 21:59:57 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37RLxubL029093
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Aug 2023 21:59:56 GMT
Received: from [10.110.11.89] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 27 Aug
 2023 14:59:55 -0700
Message-ID: <89294acf-501f-5c2c-1619-cfc2b3dc893a@quicinc.com>
Date:   Sun, 27 Aug 2023 14:59:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 3/3] firmware: Add support for Qualcomm UEFI Secure
 Application
Content-Language: en-US
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
References: <20230827211408.689076-1-luzmaximilian@gmail.com>
 <20230827211408.689076-4-luzmaximilian@gmail.com>
 <0d7697fd-11b3-1d4a-78da-7e5eb293d186@quicinc.com>
 <072b3df6-09fb-98a8-2b58-41dfcabd98c0@gmail.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <072b3df6-09fb-98a8-2b58-41dfcabd98c0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jc1u73hZUQZW3u4ttQLPdUCPTrlXGLHh
X-Proofpoint-ORIG-GUID: Jc1u73hZUQZW3u4ttQLPdUCPTrlXGLHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-27_19,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308270208
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/2023 2:53 PM, Maximilian Luz wrote:
> On 8/27/23 23:26, Trilok Soni wrote:
>> On 8/27/2023 2:14 PM, Maximilian Luz wrote:
>>>   +config QCOM_QSEECOM_UEFISECAPP
>>> +    bool "Qualcomm SEE UEFI Secure App client driver"
>>
>> Why not "tristate"? This driver can be a loadable module, right?
> 
> As I understand, modular efivars have still not been fully sorted out in
> the kernel. For example, userspace could try and mount efivarfs before
> the module has been loaded and by that erroneously determine that the
> system doesn't support efivars. So requiring it to be built in for now
> is more of a workaround (which has been suggested by Johan Hovold).
> 
> There is no technical limitation in this part of the code itself, so
> enabling it (and QCOM_QSEECOM for that matter) to be built as module
> should be fairly straightforward once that's been sorted out.

If not this application I would atleast like the QSEECOM driver to be a loadable module due to GKI (Generic Kernel Image) needs. Can we mark QSEECOM as "tristate" please? If not then there is a problem which we are not solving right now as you are documenting above and just moving it it for future and downstream vendors will keep having their additional changes to make it fit for loadable module needs. 

-- 
---Trilok Soni

