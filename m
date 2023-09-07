Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1997E797E8C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbjIGWFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjIGWFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:05:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BD01BC5;
        Thu,  7 Sep 2023 15:05:13 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387M0jGb007978;
        Thu, 7 Sep 2023 22:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SPm4ciCY+fahhXaZZSv4H/lYOjwZuaemc2COLO4evos=;
 b=YWdc45I90+6x8QsdHaDq/Q+CY0DSFqfSeRd1cRr7HyP0IqlseLXVImRf+OaHXd6VaTp2
 U0Y3aZQTaC52fSVWoTSF4JpFf4O+xvxQBbCzKwXc59oJhLLikFrnPBLTHyadFS+rthok
 fg7595smYkSybriNjOUPF1vNyLa7NYPmFROVu7v1osESJQlbAzJE1zaf79tph2pVjTjs
 SisSEuj8oegeyz4TPhQZRmkucHrduWw5wcvCFMwXTvdGo7Dcaq6X7mUV/N2sK+Sh5i1L
 fOCVF47kgRF1knGMCtY0ROfbdd1nm1zM4ECoYt+hKtHMSixDjqy3AWy8AxHPwHtuklss pA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3syaad1r2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 22:05:07 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 387M56TS014405
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 22:05:06 GMT
Received: from [10.110.110.18] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 7 Sep
 2023 15:05:05 -0700
Message-ID: <a1d0599c-b1b3-e57e-a857-112030a83872@quicinc.com>
Date:   Thu, 7 Sep 2023 15:05:01 -0700
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
 <89294acf-501f-5c2c-1619-cfc2b3dc893a@quicinc.com>
 <5487e816-f30c-468f-b860-a4cac30fba36@gmail.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <5487e816-f30c-468f-b860-a4cac30fba36@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Hmxp9jScaQKRxoiqecrBYDFRCw1_Vkmg
X-Proofpoint-GUID: Hmxp9jScaQKRxoiqecrBYDFRCw1_Vkmg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070195
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/2023 1:52 PM, Maximilian Luz wrote:
> On 8/27/23 23:59, Trilok Soni wrote:
>> On 8/27/2023 2:53 PM, Maximilian Luz wrote:
>>> On 8/27/23 23:26, Trilok Soni wrote:
>>>> On 8/27/2023 2:14 PM, Maximilian Luz wrote:
>>>>>    +config QCOM_QSEECOM_UEFISECAPP
>>>>> +    bool "Qualcomm SEE UEFI Secure App client driver"
>>>>
>>>> Why not "tristate"? This driver can be a loadable module, right?
>>>
>>> As I understand, modular efivars have still not been fully sorted out in
>>> the kernel. For example, userspace could try and mount efivarfs before
>>> the module has been loaded and by that erroneously determine that the
>>> system doesn't support efivars. So requiring it to be built in for now
>>> is more of a workaround (which has been suggested by Johan Hovold).
>>>
>>> There is no technical limitation in this part of the code itself, so
>>> enabling it (and QCOM_QSEECOM for that matter) to be built as module
>>> should be fairly straightforward once that's been sorted out.
>>
>> If not this application I would atleast like the QSEECOM driver to be a loadable module due to GKI (Generic Kernel Image) needs. Can we mark QSEECOM as "tristate" please? If not then there is a problem which we are not solving right now as you are documenting above and just moving it it for future and downstream vendors will keep having their additional changes to make it fit for loadable module needs.
> 
> Could you elaborate a bit on why/how switching to a tristate would help
> here? I'm afraid I don't quite follow. Do you mean that this would make
> it easier for downstream vendors to patch the module as opposed to
> create their own new thing? IMHO if they already need to patch it they
> can just as well modify it to be buildable as a module.
> 
> Generally I'm not opposed to have both loadable as modules, but I don't
> quite see the point as it would not be usable as such in upstream at
> the moment (at least not reliably, so to avoid those headaches I think
> it's better to just stick to bool for now).

I just want to be clear that it is not about downstream patches. That is not the intention. Not having the tristate the shows the real problem somewhere in the framework. It means such drivers won't be much usable without hacks on the configuration like GKI - so problem needs to be solved at upstream someday. 

> 
> Regards,
> Max
-- 
---Trilok Soni

