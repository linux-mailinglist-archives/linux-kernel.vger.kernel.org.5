Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE430762A98
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjGZFG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjGZFGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:06:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DDD1FC0;
        Tue, 25 Jul 2023 22:06:48 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q55XYb005491;
        Wed, 26 Jul 2023 05:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=V4hwNQkrMC/P0DifFVg0cViD8aQb31tFWHbSM/lw0sk=;
 b=UdmjB4IeiBD7Gy3yb/sxDIwOktcukhZIf5vCsjITkSOxQq6NO3YZd5xTQ+ivcwLO7mS0
 LCDqjUMH74CBafHbJDU/jdCKCHto9kHTK49C8NrFD2TNoHnp4qmkfKK5kBIDyt5pU99W
 D9PT4kVeAlPVttXLNELnnXO1n6lvl72UCUBiIR2wepH7URTFh0Ta3Ji2HPuSYDoKcdQG
 Q1HhH/fzGHaQVEOxFZ5Cff1zcqqY65wb8KsM4D/IKFtm7KSe1yvlCH5YiHoM8yIXyz0P
 yst7zfHQu2/rE25uXeBj/KhcqqEYQILkqv413wcVQaJmG6BT1x8NOIL6EQAYrLqN5QG/ Jg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2draa2p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 05:06:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q56brC006747
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 05:06:37 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 22:06:32 -0700
Date:   Wed, 26 Jul 2023 10:36:28 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Prasad Sodagudi <quic_psodagud@quicinc.com>
Subject: Re: [RFC PATCH 1/4] power: reset: reboot-mode: Allow magic to be 0
Message-ID: <1241d1bd-aa0f-4e27-9e40-1624bbc4c2e6@quicinc.com>
References: <20230724223057.1208122-1-quic_eberman@quicinc.com>
 <20230724223057.1208122-2-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230724223057.1208122-2-quic_eberman@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jeEnzyVS92sPyGCTceLyNHAzN5vLlEM7
X-Proofpoint-ORIG-GUID: jeEnzyVS92sPyGCTceLyNHAzN5vLlEM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307260044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 03:30:51PM -0700, Elliot Berman wrote:
> Allow magic from the reboot-mode driver to be defined, but 0. This is
> useful when the register/command to trigger reboot needs 0 to be
> written. This is the case when the "default" reboot mode is to enter a
> crash dump collection mode (e.g. when triggered by a watchdog) and Linux
> doing a normal reboot requires the setting to be explicitly reset to
> zero.

Sorry, it is not clear to me. The current code does not treat 0 as a
valid value for magic. Since our platform has a meaning for 0 as a magic
value, we are doing this correct?

Basically we are allowing

reboot-mode {
	mode-normal = <0x0>;
	...
}

What is "default" reboot mode you are referring here? are you referring
to

enum reboot_mode reboot_mode DEFAULT_REBOOT_MODE

defined in kernel/reboot.c?

> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/power/reset/reboot-mode.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index b4076b10b893..a646aefa041b 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -19,11 +19,10 @@ struct mode_info {
>  	struct list_head list;
>  };
>  
> -static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
> -					  const char *cmd)
> +static bool get_reboot_mode_magic(struct reboot_mode_driver *reboot,
> +					  const char *cmd, unsigned int *magic)
>  {
>  	const char *normal = "normal";
> -	int magic = 0;
>  	struct mode_info *info;
>  
>  	if (!cmd)
> @@ -31,12 +30,12 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>  
>  	list_for_each_entry(info, &reboot->head, list) {
>  		if (!strcmp(info->mode, cmd)) {
> -			magic = info->magic;
> -			break;
> +			*magic = info->magic;
> +			return true;
>  		}
>  	}
>  
> -	return magic;
> +	return false;
>  }
>  
>  static int reboot_mode_notify(struct notifier_block *this,
> @@ -46,8 +45,7 @@ static int reboot_mode_notify(struct notifier_block *this,
>  	unsigned int magic;
>  
>  	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
> -	magic = get_reboot_mode_magic(reboot, cmd);
> -	if (magic)
> +	if (get_reboot_mode_magic(reboot, cmd, &magic))
>  		reboot->write(reboot, magic);
>  
>  	return NOTIFY_DONE;
> -- 
> 2.41.0
> 

Thanks,
Pavan
