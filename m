Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD47813AC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346764AbjHRTm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379780AbjHRTm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:42:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA144681;
        Fri, 18 Aug 2023 12:41:26 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IJZRBW022726;
        Fri, 18 Aug 2023 19:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=s7BVM/qKC0aGRo+zRLkHSbcMK2LK36taw0SKWzINMoM=;
 b=lsxV7pr7knfb0PvbnO4UDZk82/M+8JpMDK1ECDOkKuA/UTBHOoNmv7N1JSgpBpUOcPHT
 Izge3/1bGQF0J4KuSB/aqmO3AtBQECQnQTTBhb9F2Fm3Qim7lfZtoYewqJDBZe4V/qA/
 0pLenw3xpImCgwAfVC43O+X7263oarMyqcGERTtg2pNKs4+mfvW4Ve7J5XRpVTLv2e6H
 vL4d97KU+vGMmKmh7dWSX7RjPlZHc+dC51svJ+I7MPao6NlXWdwEbt9c+8CKMC2UcR07
 GYjvXu7YxftQYXT/0X2VWe0m/OrpEWYr6NV95coDX0k9E+jRHyCnMthZtHyvkPrvnsUN Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjerv079h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 19:41:22 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IJZSFL022913;
        Fri, 18 Aug 2023 19:41:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjerv0791-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 19:41:21 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37IHqs9t002403;
        Fri, 18 Aug 2023 19:41:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendp1jf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 19:41:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IJfGQY19333874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 19:41:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFD0320049;
        Fri, 18 Aug 2023 19:41:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8AEA20040;
        Fri, 18 Aug 2023 19:41:15 +0000 (GMT)
Received: from [9.179.22.225] (unknown [9.179.22.225])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 18 Aug 2023 19:41:15 +0000 (GMT)
Message-ID: <714beaf2-929f-f0ad-f16b-00ca4b2bb2b6@linux.ibm.com>
Date:   Fri, 18 Aug 2023 21:41:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v2 6/6] net/smc: Extend SMCR v2 linkgroup netlink
 attribute
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        wenjia@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230817132032.23397-1-guangguan.wang@linux.alibaba.com>
 <20230817132032.23397-7-guangguan.wang@linux.alibaba.com>
From:   Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20230817132032.23397-7-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vo7LE_OicD7EUL3yfcFeextLU3bjztWE
X-Proofpoint-GUID: jbZhzyAXrcCYDSjg5zEb54--vzVEOp-i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_24,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180178
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/08/2023 15:20, Guangguan Wang wrote:
> Add SMC_NLA_LGR_R_V2_MAX_CONNS and SMC_NLA_LGR_R_V2_MAX_LINKS
> to SMCR v2 linkgroup netlink attribute SMC_NLA_LGR_R_V2 for
> linkgroup's detail info showing.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

Thank you for your contribution, Guangguan.

Reviewed-by: Jan Karcher <jaka@linux.ibm.com>

> ---
>   include/uapi/linux/smc.h | 2 ++
>   net/smc/smc_core.c       | 4 ++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
> index bb4dacca31e7..837fcd4b0abc 100644
> --- a/include/uapi/linux/smc.h
> +++ b/include/uapi/linux/smc.h
> @@ -107,6 +107,8 @@ enum {
>   enum {
>   	SMC_NLA_LGR_R_V2_UNSPEC,
>   	SMC_NLA_LGR_R_V2_DIRECT,	/* u8 */
> +	SMC_NLA_LGR_R_V2_MAX_CONNS,	/* u8 */
> +	SMC_NLA_LGR_R_V2_MAX_LINKS,	/* u8 */
>   	__SMC_NLA_LGR_R_V2_MAX,
>   	SMC_NLA_LGR_R_V2_MAX = __SMC_NLA_LGR_R_V2_MAX - 1
>   };
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 1e1475084bb4..ef5336df3b09 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -319,6 +319,10 @@ static int smc_nl_fill_smcr_lgr_v2(struct smc_link_group *lgr,
>   		goto errattr;
>   	if (nla_put_u8(skb, SMC_NLA_LGR_R_V2_DIRECT, !lgr->uses_gateway))
>   		goto errv2attr;
> +	if (nla_put_u8(skb, SMC_NLA_LGR_R_V2_MAX_CONNS, lgr->max_conns))
> +		goto errv2attr;
> +	if (nla_put_u8(skb, SMC_NLA_LGR_R_V2_MAX_LINKS, lgr->max_links))
> +		goto errv2attr;
>   
>   	nla_nest_end(skb, v2_attrs);
>   	return 0;
