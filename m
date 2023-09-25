Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EDA7AD56F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjIYKJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjIYKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:09:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED8A1BF;
        Mon, 25 Sep 2023 03:08:52 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P8eHcw018266;
        Mon, 25 Sep 2023 10:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MxwvRJpSsUBD8MG0AuzX88+LtO7ZRpsyjs+Df1TzoQs=;
 b=RcXn2luVDcqkEcCTl62rQiV087GUIkdl+OyL946GwGnwnxLm73RYjE4daJ0jectfNruz
 fynbPjJ5nagHF6UiFdyct8rOgYlf914Q5AFwRemTIdIbpRxXMfou9krUyk0MXNDbyKOj
 4smmD4xjLK5P0U8atAKRYsxOR/5D0e76FksPHtYdUY8MF9+OJpA+b3DQ4x9nkFCwAj9a
 1xmZEY6uXDlqlN+2Lz8G38177Cx2AumR66DeLNsDt72ffxwLOq6N+kpP/3tmtH1On8iu
 dCGGoZ7XaQK0Qnzjbdh6YZ4khdv2emU2OR9JSDQ9JS9DeTFnRr9H8KWs5CBFt7+J2+5V UQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9rsq3rp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:08:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38PA8iAZ003739
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:08:44 GMT
Received: from [10.216.42.228] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 03:08:39 -0700
Message-ID: <7c11ad1f-ed78-4ca9-84a2-f0b847a244d1@quicinc.com>
Date:   Mon, 25 Sep 2023 15:38:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: Add interconnect nodes for SDX75
To:     kernel test robot <lkp@intel.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1695383434-24705-2-git-send-email-quic_rohiagar@quicinc.com>
 <202309240033.AmuJpOkT-lkp@intel.com>
Content-Language: en-US
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <202309240033.AmuJpOkT-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PgWYXqWgEjAS4Mk9xNak1QmuBdCHTSDI
X-Proofpoint-ORIG-GUID: PgWYXqWgEjAS4Mk9xNak1QmuBdCHTSDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_07,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 mlxlogscore=933 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/23/2023 9:57 PM, kernel test robot wrote:
> Hi Rohit,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on linus/master v6.6-rc2 next-20230921]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Rohit-Agarwal/arm64-dts-qcom-Add-interconnect-nodes-for-SDX75/20230922-195140
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> patch link:    https://lore.kernel.org/r/1695383434-24705-2-git-send-email-quic_rohiagar%40quicinc.com
> patch subject: [PATCH 1/3] arm64: dts: qcom: Add interconnect nodes for SDX75
> config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230924/202309240033.AmuJpOkT-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230924/202309240033.AmuJpOkT-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309240033.AmuJpOkT-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>     In file included from arch/arm64/boot/dts/qcom/sdx75-idp.dts:9:
>>> arch/arm64/boot/dts/qcom/sdx75.dtsi:11:10: fatal error: dt-bindings/interconnect/qcom,sdx75.h: No such file or directory
>        11 | #include <dt-bindings/interconnect/qcom,sdx75.h>
>           |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
>
>
> vim +11 arch/arm64/boot/dts/qcom/sdx75.dtsi
>
>    > 11	#include <dt-bindings/interconnect/qcom,sdx75.h>
>      12	#include <dt-bindings/interrupt-controller/arm-gic.h>
>      13	#include <dt-bindings/power/qcom,rpmhpd.h>
>      14	#include <dt-bindings/power/qcom-rpmpd.h>
>      15	#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>      16	
This can be ignored. I have mentioned the dependency in the cover letter.

Thanks,
Rohit.
