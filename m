Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9877C101
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjHNToR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjHNTnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:43:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0CCAF;
        Mon, 14 Aug 2023 12:43:48 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EIxfBK005221;
        Mon, 14 Aug 2023 19:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=gGU4i3Wetb6vziDtdg288vqP3V8FSa2AfKVET40eFEw=;
 b=AF+u8VmKqhTMkiT7a3hPOnk6qOJJyjC3DVWtOMr2hcHwF6s7gol7UC6qIaZNdWPYSL++
 0zKqTNR+HmTqAwezenJ+JrcmJVRfSuUrorPsGmKp+vlCUcrz/CBFLom9SxA1B0XlZtGI
 YHwrCPxtyR5sf3vSKpuLY/bUl1PtYxcrDhK7HyoGXS3v+0+daQJMziDpqVD6LQhf4gZw
 VZPB4PfHC7s56XlcdHCEayG7llbPlSEI5zAKE4SHD8q12XQ4jj7rIyd+wUkGbCDe2Nfo
 39hzZ5pWCJeuPlDkI3LzxTTfesiasK9lhgzO17bkROaIfePGio9o5CjxSyJTfY1mZZyK fw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sffxt9kcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:43:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EJhaQQ022267
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:43:36 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 14 Aug 2023 12:43:36 -0700
Date:   Mon, 14 Aug 2023 12:43:35 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andrei Coardos <aboutphysycs@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <alex@shruggie.ro>,
        <sre@kernel.org>, <konrad.dybcio@linaro.org>,
        <andersson@kernel.org>, <agross@kernel.org>
Subject: Re: [PATCH] power: reset: qcom-pon: removed unneeded call to
 platform_set_drvdata()
Message-ID: <20230814194335.GV1428172@hu-bjorande-lv.qualcomm.com>
References: <20230814181823.3662-1-aboutphysycs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230814181823.3662-1-aboutphysycs@gmail.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OO5ixX7UXJgjFtaOm1oNnqoH7ygK8_-p
X-Proofpoint-GUID: OO5ixX7UXJgjFtaOm1oNnqoH7ygK8_-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_17,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=937 spamscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 09:18:23PM +0300, Andrei Coardos wrote:
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.
> 
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn
