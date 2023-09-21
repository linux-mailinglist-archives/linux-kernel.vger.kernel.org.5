Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB237AA5B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjIUXhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjIUXhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:37:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4650E129;
        Thu, 21 Sep 2023 16:37:29 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LNbLQq001748;
        Thu, 21 Sep 2023 23:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=J4tPXsGAIwPWKiDS0fRDZ3GSuFmDHRRzMOCHHXbXTNI=;
 b=jUMDd6s+YrFom/9i5YFDnXx/DOisLyRKxnVuRvbUrrAznZ2vi5DkTKVN3iXF43zjGpik
 zzP/sSunnfQKgDvbaeteKAfeW2HAgU3vOv3eMsIqNQxHKsFj5+xWWKm7Fruy/ccsO3lu
 38brUJUSh81BItccWQsX3NM7kIwc0mv2/mY+knmZ37cmiZ3y2iHLFvpHNnROBM0HZfQu
 mZ1rhVLJSU1cpkIsRHNZgPEZ5IbA0DCTo18ifC7y+gP54JMXMQyZIhQmgTv7cEuq53KT
 2hdXuloFhRxvaPSsuwiGTjJRS7gRXt2rZ7hEts+eYhBn6CuAwLIPpIWydJiyjWO95vh2 Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8w11uwjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 23:37:24 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38LNbMEg001904;
        Thu, 21 Sep 2023 23:37:23 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8w11uw9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 23:37:22 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38LNAYmd025939;
        Thu, 21 Sep 2023 23:32:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t8tspmrb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 23:32:37 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38LNWbVU21758336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 23:32:37 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE45858053;
        Thu, 21 Sep 2023 23:32:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 927AA58043;
        Thu, 21 Sep 2023 23:32:34 +0000 (GMT)
Received: from [9.171.4.137] (unknown [9.171.4.137])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 21 Sep 2023 23:32:34 +0000 (GMT)
Message-ID: <0a150c58-5fdc-5e8d-1ea6-861406f2c70a@linux.ibm.com>
Date:   Fri, 22 Sep 2023 01:32:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
From:   Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [PATCH net-next v3 05/18] net/smc: reserve CHID range for SMC-D
 virtual device
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1695302360-46691-1-git-send-email-guwen@linux.alibaba.com>
 <1695302360-46691-6-git-send-email-guwen@linux.alibaba.com>
In-Reply-To: <1695302360-46691-6-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q_NCqUikah0oJnJqcpPiaUiAp1LeTz-o
X-Proofpoint-GUID: R0t4DEMOwiRSCu9U8-jWZl9kEOzVC1wW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309210205
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.09.23 15:19, Wen Gu wrote:
> This patch reserve CHID range from 0xFF00 to 0xFFFF for SMC-D virtual
> device and introduces helpers to identify them.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_ism.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
> index 14d2e77..2ecc8de 100644
> --- a/net/smc/smc_ism.h
> +++ b/net/smc/smc_ism.h
> @@ -15,6 +15,9 @@
>   
>   #include "smc.h"
>   
> +#define SMC_VIRT_ISM_CHID_MAX		0xFFFF
> +#define SMC_VIRT_ISM_CHID_MIN		0xFF00
> +
>   struct smcd_dev_list {	/* List of SMCD devices */
>   	struct list_head list;
>   	struct mutex mutex;	/* Protects list of devices */
> @@ -57,4 +60,16 @@ static inline int smc_ism_write(struct smcd_dev *smcd, u64 dmb_tok,
>   	return rc < 0 ? rc : 0;
>   }
>   
> +static inline bool __smc_ism_is_virtdev(u16 chid)
> +{
> +	return (chid >= SMC_VIRT_ISM_CHID_MIN && chid <= SMC_VIRT_ISM_CHID_MAX);
> +}
> +
> +static inline bool smc_ism_is_virtdev(struct smcd_dev *smcd)
> +{
> +	u16 chid = smcd->ops->get_chid(smcd);
> +
> +	return __smc_ism_is_virtdev(chid);
> +}
> +
I'm wondering if barrier is needed here.
>   #endif
