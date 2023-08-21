Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4C6782348
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 07:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjHUFpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 01:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjHUFpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 01:45:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0981A3;
        Sun, 20 Aug 2023 22:45:17 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37L4jt30025941;
        Mon, 21 Aug 2023 05:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=r9+BJyQY7hx0+1mY9f8giJm35JddZIApbisPSpWK8qg=;
 b=bC8kTa+XGsubBRbjMogigiwVpYAxOEyd5bQ8byOayf2IrwOYCu3EE54jnmEpW1k1ZZRS
 RPgsw/Re/iNYm9BqEySomiEtzxv44B9eqbZjlQV65lUsnywhZiLdel5laf9/TugUUY8j
 CoFLP305b2qG4f0xIvJ/x9jG381vaLTH0oJLyrJgx6pALR66a82Ne5LBNddA57pv9ki9
 tnB5/Z5R9ZxDeqSNcOgSn1UGi91UXzPyrNAG+r6B7LDC9iWxhup8a+4dM9b+67xtQ37m
 L3z0gQ4TaL/QwQzBM04WjT+yJlZGuBgCo2WCLn5PbKoA/cM9i9LdVYDPku34VGo8zdwA 3A== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjmrejr79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 05:45:02 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37L5j1Ov020392
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 05:45:01 GMT
Received: from [10.216.3.117] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 20 Aug
 2023 22:44:58 -0700
Message-ID: <78220b51-da70-c2d6-3aaa-20c17251b021@quicinc.com>
Date:   Mon, 21 Aug 2023 11:14:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: linux-next: build failure after merge of the nand tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
CC:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230821120213.403fcefe@canb.auug.org.au>
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20230821120213.403fcefe@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zjm2fozz_I4re97MZl5TVVcoGQhrHi2Z
X-Proofpoint-ORIG-GUID: zjm2fozz_I4re97MZl5TVVcoGQhrHi2Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=977
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210053
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/2023 7:32 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the nand tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/mtd/nand/raw/qcom_nandc.c: In function 'qcom_parse_instructions':
> drivers/mtd/nand/raw/qcom_nandc.c:2596:38: error: unused variable 'nandc' [-Werror=unused-variable]
>   2596 |         struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>        |                                      ^~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>    5a7688a3e2e6 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
> 
> I have used the nand tree from next-20230818 for today.

   I have posted a patch to fix this build issue.

   Link: https://patchwork.kernel.org/project/linux-arm-msm/patch/20230821053513.13728-1-quic_mdalam@quicinc.com/

> 
