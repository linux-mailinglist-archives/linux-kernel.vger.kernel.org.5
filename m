Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED487984F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbjIHJmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 05:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjIHJmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:42:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1702D19A8;
        Fri,  8 Sep 2023 02:42:47 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3889cXQD031752;
        Fri, 8 Sep 2023 09:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6MGczS6Yh85U4Nu66lvBdcsqE1SDsXC6dQIdLvw11KE=;
 b=B0pBctTDp+LeUJoqSJL9+YKsn3AdbRk23IjeqfcMWrTI7GIijq4h1nz5mjLhDl+4iR71
 7rh4CMhlGOciss9AxJ3G5E7Ks5j05ikbhvIC7QMppzvxtkfng5U2C1JRelvqcnQBCcBC
 XoHSYxc4pcCf/nyC5D4dJq7JBz8rz6GI6sm38kDve4qhZ8dNFBuarUupn6sb15/+fH2D
 sg+4W3/qGTObU3WhTv/n4hQrnQap31yvPxFlp2DtnPntW7NcktHl+eLRJiwQrZQTCrx+
 aArEhG6EdNYoLucTQI0OPQFuAQKcswPD1qodtU8UOd92LeYHnaB3owRllJZBpqkU3XUl Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t00xfgaey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 09:42:42 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3889e2wc007022;
        Fri, 8 Sep 2023 09:42:41 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t00xfgaef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 09:42:41 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3889Ssfk001598;
        Fri, 8 Sep 2023 09:42:40 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfctb1q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 09:42:40 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3889gdgj65667386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 09:42:39 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65F895804E;
        Fri,  8 Sep 2023 09:42:39 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08BF95803F;
        Fri,  8 Sep 2023 09:42:37 +0000 (GMT)
Received: from [9.179.12.78] (unknown [9.179.12.78])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  8 Sep 2023 09:42:36 +0000 (GMT)
Message-ID: <be086da3-061d-8f39-6e79-0e5d21771453@linux.ibm.com>
Date:   Fri, 8 Sep 2023 11:42:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net 1/2] net/smc: bugfix for smcr v2 server connect
 success statistic
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        jaka@linux.ibm.com, kgraul@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230908033143.89489-1-guangguan.wang@linux.alibaba.com>
 <20230908033143.89489-2-guangguan.wang@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20230908033143.89489-2-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2qYvur1I44TmMN5WPEEjbUnTQayqm5n2
X-Proofpoint-GUID: t6H5re0ezIwEuW5nJIQkuuFW31qx8AN8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080088
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08.09.23 05:31, Guangguan Wang wrote:
> In the macro SMC_STAT_SERV_SUCC_INC, the smcd_version is used
> to determin whether to increase the v1 statistic or the v2
> statistic. It is correct for SMCD. But for SMCR, smcr_version
> should be used.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> ---
>   net/smc/smc_stats.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
> index b60fe1eb37ab..aa8928975cc6 100644
> --- a/net/smc/smc_stats.h
> +++ b/net/smc/smc_stats.h
> @@ -243,8 +243,9 @@ while (0)
>   #define SMC_STAT_SERV_SUCC_INC(net, _ini) \
>   do { \
>   	typeof(_ini) i = (_ini); \
> -	bool is_v2 = (i->smcd_version & SMC_V2); \
>   	bool is_smcd = (i->is_smcd); \
> +	u8 version = is_smcd ? i->smcd_version : i->smcr_version; \
> +	bool is_v2 = (version & SMC_V2); \
>   	typeof(net->smc.smc_stats) smc_stats = (net)->smc.smc_stats; \
>   	if (is_v2 && is_smcd) \
>   		this_cpu_inc(smc_stats->smc[SMC_TYPE_D].srv_v2_succ_cnt); \

ohje, that is because the statistic was implemented first, then SMCR_v2. 
Good catch! Thank you!
