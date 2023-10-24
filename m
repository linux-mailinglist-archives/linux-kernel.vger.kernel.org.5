Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B309C7D438C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjJXACr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJXACq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:02:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50173DC;
        Mon, 23 Oct 2023 17:02:44 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NMK7d4025163;
        Tue, 24 Oct 2023 00:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uxvmUj4EhnsM0m5Wwednxb/2VPkkpIrKARmEWAk3OPk=;
 b=DjiPHL9SYvZF5+AUPO8SH6g0BiaoaTGy4n5xyTlA0Qs7w6FEukpYqeWa6KNrHx8nHCq0
 D3MPOW7YPAg5Tr366Y6/yOJNC9YuxLXKy20WTljzamsowfLswniaZeaVg0c3NS7onWdR
 AdaGZQqPB5hZe6hwSfoNSSH7M7x6szLGLu3SAtZnAPWi2iOqgpGFv8Z6h+7qGvhfGQsu
 zxLiiRtlOGl46M6zmnxP6sXeA97a3mGpUltICGsBcOZ4+4a/HV96e6nnrp0At98VkxVl
 ZJFkuA4mK0Fv6s8B6/hofgr8Cxytqv9TRINB7nB5Z4zjS0CZgu1iBpyWKWuCgnhtFPui FA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3twtxws6af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 00:02:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39O02VUt010002
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 00:02:31 GMT
Received: from [10.48.243.236] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 17:02:30 -0700
Message-ID: <d0865f9b-081b-4358-a039-2fc04f0575dc@quicinc.com>
Date:   Mon, 23 Oct 2023 17:02:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] wifi: mwifiex: added code to support host mlme.
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        David Lin <yu-hao.lin@nxp.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
References: <PA4PR04MB96388A628D6AB8359D3DAAD0D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZTKbxe1bAkfRI29V@francesco-nb.int.toradex.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZTKbxe1bAkfRI29V@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YLr-aRyuR0rTGg23WE61FS5H94caHnEg
X-Proofpoint-GUID: YLr-aRyuR0rTGg23WE61FS5H94caHnEg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_22,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=857 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230211
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/2023 8:24 AM, Francesco Dolcini wrote:
> On Fri, Oct 20, 2023 at 03:48:06AM +0000, David Lin wrote:
>> Patch v6:
>> Correct mailing sequence.
> 
> You are still doing something wrong sending the patches over email, the
> various emails are not threaded as expected, git-send-email should do
> everything for you.
> 
> No need to re-send now IMO, but please figure out what's wrong for the
> next time.
> 
> To give you an idea here [1] you see this email alone.
> 
> This [2] and this [3] are examples of a properly sent patch series (just random
> series from your NXP colleagues).
> 
> You have also a winmail.dat file attached to every email in this series,
> not sure what it is, but I would try to not send it.
> 
> Francesco
> 
> [1] https://lore.kernel.org/all/PA4PR04MB96388A628D6AB8359D3DAAD0D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com/
> [2] https://lore.kernel.org/all/1697794232-2607-1-git-send-email-shengjiu.wang@nxp.com/
> [3] https://lore.kernel.org/all/20230811101232.844769-1-neeraj.sanjaykale@nxp.com/
> 

If you are new to contributing to the kernel and don't have an 
established workflow I strongly recommend using b4. It removes a lot of 
steps from the standard workflow.
<https://b4.docs.kernel.org/en/latest/contributor/overview.html>
