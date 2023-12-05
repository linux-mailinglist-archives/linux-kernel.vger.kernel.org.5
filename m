Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44A6805324
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346892AbjLELie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345061AbjLELid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:38:33 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09868A0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:38:38 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B57HVBJ005326;
        Tue, 5 Dec 2023 11:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RSD8BLtviwN+VNeR9YJ6eGCrfy3ZKVqHoATWsBAfNUM=;
 b=XdIbNwiTNsu1/rmuEaVCEXjCM7kwr3idnlK+gUtk/fx+ljOGVxMROSBYaQtYlpvwhti7
 NAOUBF7vDL5c1yGi2MHX8otmbJ9kKblWW16h51tJDzPusvqATVaAk+ZI+OmolXv94Ym+
 PQmbKfwMLlLU7noeQnN0e21+V99iPynW/ZHAmC0k+DYQfK2hvIaj3RfLvDLa8WRyikxM
 6txSWDln+P3vMTsRptCgk01cqc+RsD24ULakg/+XBYxsPajb3RaSASJkZVkhgMSBVDDR
 yZLTekXeBfq3giUim+H71F+vwQCw1LRI5fsV5Ml7kAAGLCCfXUSFMsKxCKgCqN/+PllY IQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3us8wpkpkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 11:38:35 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B5BcYji023388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Dec 2023 11:38:34 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Dec
 2023 03:38:32 -0800
Message-ID: <810e5883-609e-1d5f-fb3a-655ba21d9ee0@quicinc.com>
Date:   Tue, 5 Dec 2023 17:07:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fs/sysfs/dir.c : Fix typo in comment
Content-Language: en-US
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <1698661274-32540-1-git-send-email-quic_mojha@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1698661274-32540-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lPXumITfXjEmuZiF3R3sNwc2HqqBvECT
X-Proofpoint-ORIG-GUID: lPXumITfXjEmuZiF3R3sNwc2HqqBvECT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_05,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=674 impostorscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312050090
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I know, this is very minor patch., floating this up again to see
incase we want to consider..

-Mukesh

On 10/30/2023 3:51 PM, Mukesh Ojha wrote:
> Typo correction
> kboject => kobject
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   fs/sysfs/dir.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
> index b6b6796e1616..4df2afa551dc 100644
> --- a/fs/sysfs/dir.c
> +++ b/fs/sysfs/dir.c
> @@ -81,7 +81,7 @@ void sysfs_remove_dir(struct kobject *kobj)
>   	struct kernfs_node *kn = kobj->sd;
>   
>   	/*
> -	 * In general, kboject owner is responsible for ensuring removal
> +	 * In general, kobject owner is responsible for ensuring removal
>   	 * doesn't race with other operations and sysfs doesn't provide any
>   	 * protection; however, when @kobj is used as a symlink target, the
>   	 * symlinking entity usually doesn't own @kobj and thus has no

