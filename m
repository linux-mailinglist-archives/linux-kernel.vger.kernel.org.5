Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19551761030
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjGYKFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjGYKEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:04:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D158C3582;
        Tue, 25 Jul 2023 03:04:19 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P88XSC009383;
        Tue, 25 Jul 2023 10:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4wxBb0aHeVVz4pmYcNzT5o3PmpfCFsXkoGMU7c6SCKg=;
 b=MkoTlorwYQqYxrN+bH4gZri0I+pDbzHrvAg0jhxBeKFMVBVL/RdNdyoxWpURhBgoQdCB
 UbZW5QJZhYcUYo0IuU6LNQQiau5PMvKOJpyJ3LLTZKj9veZ46xxMtkd2s2IacWOTDYCd
 RIjcSMH1rByGqVCgefoD/3Jtcv/XmabFUps1tpJ08RmC4WdE/uKtQn8FwyB8oJJouYsR
 ivtNY6WyUy3QwAXYMJkzWONdNu1WUkbqYtNaxMonTG23D+ye4f8ptxXKOcr+HYFQfM0e
 p2BxSfX3D3Cvgq2Cxl/zRc62JexwJqjjulnh7MhV3o5rSfOAoIEnpusOPDXU4ZxRf9FB PQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s29xmgb36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 10:04:08 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PA47bD031178
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 10:04:07 GMT
Received: from [10.216.12.191] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 25 Jul
 2023 03:04:01 -0700
Message-ID: <27d9bd35-b69c-5596-8e1a-c42ec2b01f75@quicinc.com>
Date:   Tue, 25 Jul 2023 15:33:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 2/4] power: reset: reboot-mode: Wire reboot_mode enum
 to magic
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Sebastian Reichel" <sre@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Prasad Sodagudi <quic_psodagud@quicinc.com>
References: <20230724223057.1208122-1-quic_eberman@quicinc.com>
 <20230724223057.1208122-3-quic_eberman@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230724223057.1208122-3-quic_eberman@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V1EUNcEWf5x7A1jIFLgk8KKf7-TfcMfc
X-Proofpoint-GUID: V1EUNcEWf5x7A1jIFLgk8KKf7-TfcMfc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_05,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250086
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/2023 4:00 AM, Elliot Berman wrote:
> Allow the reboot mode type to be wired to magic.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   drivers/power/reset/reboot-mode.c | 30 ++++++++++++++++++++++++++----
>   1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index a646aefa041b..4ea97ccbaf51 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -22,12 +22,8 @@ struct mode_info {
>   static bool get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>   					  const char *cmd, unsigned int *magic)
>   {
> -	const char *normal = "normal";
>   	struct mode_info *info;
>   
> -	if (!cmd)
> -		cmd = normal;
> -
>   	list_for_each_entry(info, &reboot->head, list) {
>   		if (!strcmp(info->mode, cmd)) {
>   			*magic = info->magic;
> @@ -45,6 +41,32 @@ static int reboot_mode_notify(struct notifier_block *this,
>   	unsigned int magic;
>   
>   	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
> +
> +	if (!cmd) {
> +		switch (mode) {

IIUC, mode will be filled up with reboot_mode during restart
notifier and not reboot notifiers ?

> +		case REBOOT_COLD:
> +			cmd = "cold";
> +			break;
> +		case REBOOT_WARM:
> +			cmd = "warm";
> +			break;
> +		case REBOOT_HARD:
> +			cmd = "hard";
> +			break;
> +		case REBOOT_SOFT:
> +			cmd = "soft";
> +			break;
> +		case REBOOT_GPIO:
> +			cmd = "gpio";

These strings are already there kernel/reboot.c
Can it be reused ?

#define REBOOT_COLD_STR         "cold"
#define REBOOT_WARM_STR         "warm"
#define REBOOT_HARD_STR         "hard"
#define REBOOT_SOFT_STR         "soft"
#define REBOOT_GPIO_STR         "gpio"
#define REBOOT_UNDEFINED_STR    "undefined"


> +			break;
> +		}
> +		if (get_reboot_mode_magic(reboot, cmd, &magic)) {

Is info->mode is going to filled up with mode-cold, mode-warm and so
on from DT to compare against cmd?

What if , cmd is not among the one above switch, NULL pointer during
strcmp ?

-Mukesh

> +			reboot->write(reboot, magic);
> +			return NOTIFY_DONE;
> +		}
> +		cmd = "normal";
> +	}
> +
>   	if (get_reboot_mode_magic(reboot, cmd, &magic))
>   		reboot->write(reboot, magic);
>   
