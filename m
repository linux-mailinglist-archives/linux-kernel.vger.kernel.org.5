Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CBD78DA05
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjH3SfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244987AbjH3ORR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:17:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93F3122;
        Wed, 30 Aug 2023 07:17:13 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UDR0bn014094;
        Wed, 30 Aug 2023 14:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=t+pa7pawiXHGZsyFpEhyJeURi1Iqk12oeRHuQvv8HfI=;
 b=JJuR33EIgP9wPpvFBDwqZfRoVVFoweXSPTpDpfOxkJiaqmgIfDs+b1jm9/xv/4H2BisG
 O4whebwnwqbjFnV+PvO2z2HHOKp2vo0aFn9y4JRxXq5pNt18BoCtREU3QYHeUS1bjy7P
 XH1gGt3H4fTaiBezGwGzzcf6Gdr1X0fFv+m4eCkatQLgyqNcTNGw2X/mWBDrSVPHXdHt
 WuUhdOdwpMX+jw5CwfiS1jT/+VBNG7GHV8mzd7m5aDG3EfRZ7HX177EOTnLq8691HJHU
 AHO+waUx2eVQBKOPeCoc/w/XrPrmtCAIeJv9NKoNUHIY+EKr5thKEtlJNn20Baa3ePmf Ig== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st28a8kvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 14:16:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UEGVeB023380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 14:16:31 GMT
Received: from [10.111.178.80] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 30 Aug
 2023 07:16:28 -0700
Message-ID: <42177428-c85f-4fa8-af0a-0252dd4aef43@quicinc.com>
Date:   Wed, 30 Aug 2023 07:16:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <quic_pkondeti@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <workflows@vger.kernel.org>,
        <tools@linux.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
 <2efba6b3-2399-9deb-d0ce-78f7b5e12f30@linaro.org>
 <20230828175629.GC23466@quicinc.com>
 <78aa33f9-ead8-b128-2a7a-40530a1a3ed0@linaro.org>
 <ZOz4XtX3DFRQpvQY@finisterre.sirena.org.uk>
 <670a87e9-2f0c-ec9e-ebb4-9041c8972ace@linaro.org>
 <20230829231638.GA27843@quicinc.com>
 <0f7b32e1-1b26-4543-bfec-471641a67416@sirena.org.uk>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <0f7b32e1-1b26-4543-bfec-471641a67416@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Y99vl80-AQIBPhE1u991VngBk1l7j4Xp
X-Proofpoint-GUID: Y99vl80-AQIBPhE1u991VngBk1l7j4Xp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=965
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/2023 4:22 AM, Mark Brown wrote:
> On Tue, Aug 29, 2023 at 04:16:39PM -0700, Guru Das Srinagesh wrote:
> 
>> If this script is accepted and gains adoption, maintainers like yourself will
>> only be To-ed in patches that touch files that you're a direct "Maintainer" or
>> "Reviewer" of. For all other patches in the series you'll be in "Cc:". I
>> imagine that this can be very useful regardless of the specifics of your
>> workflow.
> 
> Given that b4 solves a lot more problems and is getting quite widely
> adopted it's probably going to be more effective to look at trying to
> get this implemented there.  That might still mean a separate script
> that b4 can hook into, but it's probably important that whatever you do
> can be used easily with b4.

As someone who has recently moved to using b4 I second this comment.
b4 makes it so much easier to maintain patch versioning and to add the 
right folks to the review. And most folks aren't performing tree-wide 
changes so the per-patch customization doesn't seem to be a big win.

/jeff
