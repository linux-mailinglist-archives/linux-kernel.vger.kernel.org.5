Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D38877F0AD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348291AbjHQGo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348318AbjHQGoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:44:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB6A2D50;
        Wed, 16 Aug 2023 23:43:55 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H6hrqT002707;
        Thu, 17 Aug 2023 06:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Qu++uhRIHn0LC/uEYxS8hGf0rrE606DyRQ4FkwSEb58=;
 b=sIyAPASFiMum8mHBictToZh4dmbRkfcD4a0azL3jlQXQw0x4AQJLMxFxHFXvXQgBygnt
 RRTwlh8gyTWevS/vRlS6fwSltLokOahJ4qtoceBLXDnvnbKmHX6ZwgJwXdvDVprCByKO
 MrJEQID8YUHN8Sn8luQ5XaoUcQnhu6dLyghU200P7gAcufWhe3VnBOwMZD4dW58iAEP8
 H0pbXkRbGOtPfTvkCkytuv6Ob3gqfHDVuUqISXAOiNipgDa1R5P2OIW1nYl4VcO2axqn
 uLfHZlCvGyHVMXA2Icz0Ah/GOLmg+lWLCL6VjeAGFgCziEjwl5Wx7oZO5DcTE99fzCVn Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shehh801p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 06:43:52 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37H6hqEn002645;
        Thu, 17 Aug 2023 06:43:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shehh801b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 06:43:52 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37H5LgQ7007861;
        Thu, 17 Aug 2023 06:43:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3senwkkpee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 06:43:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37H6hlhs16777922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 06:43:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B08220065;
        Thu, 17 Aug 2023 06:43:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9771F2004D;
        Thu, 17 Aug 2023 06:43:46 +0000 (GMT)
Received: from [9.171.82.18] (unknown [9.171.82.18])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 17 Aug 2023 06:43:46 +0000 (GMT)
Message-ID: <3fa272d7-d3a5-374a-1161-4e9008240ba6@linux.ibm.com>
Date:   Thu, 17 Aug 2023 08:43:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 0/6] net/smc: several features's implementation
 for smc v2.1
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        wenjia@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230816083328.95746-1-guangguan.wang@linux.alibaba.com>
From:   Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20230816083328.95746-1-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uvk1DlWO40w_y7agiAihYvNK4FEekDLn
X-Proofpoint-ORIG-GUID: GitfDR2vniIwOTxOz38cmfTvfCEH77AO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=983 priorityscore=1501 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170057
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/08/2023 10:33, Guangguan Wang wrote:
> This patch set implement several new features in SMC v2.1(https://
> www.ibm.com/support/pages/node/7009315), including vendor unique
> experimental options, max connections per lgr negotiation, max links
> per lgr negotiation.
> 
> I have removed the RFC tag and changed the patch series to formal
> patch series from this version.

Thank you Guangguan for your effort!

I'm done with the first iteration of review.
Please see the comments.

- Jan


> 
> RFC v2 - v1:
>   - more description in commit message
>   - modify SMC_CONN_PER_LGR_xxx and SMC_LINKS_ADD_LNK_xxx
>     macro defination and usage
>   - rename variable release_ver to release_nr
>   - remove redundant release version check in client
>   - explicitly set the rc value in smc_llc_cli/srv_add_link
> 
> RFC v1 - RFC v2:
>   - Remove ini pointer NULL check and fix code style in
>     smc_clc_send_confirm_accept.
>   - Optimize the max_conns check in smc_clc_xxx_v2x_features_validate.
> 
> Guangguan Wang (6):
>    net/smc: support smc release version negotiation in clc handshake
>    net/smc: add vendor unique experimental options area in clc handshake
>    net/smc: support smc v2.x features validate
>    net/smc: support max connections per lgr negotiation
>    net/smc: support max links per lgr negotiation in clc handshake
>    net/smc: Extend SMCR v2 linkgroup netlink attribute
> 
>   include/uapi/linux/smc.h |   2 +
>   net/smc/af_smc.c         |  83 ++++++++++++++++------
>   net/smc/smc.h            |   5 +-
>   net/smc/smc_clc.c        | 150 ++++++++++++++++++++++++++++++++-------
>   net/smc/smc_clc.h        |  53 ++++++++++++--
>   net/smc/smc_core.c       |  13 +++-
>   net/smc/smc_core.h       |  25 +++++++
>   net/smc/smc_llc.c        |  25 +++++--
>   8 files changed, 301 insertions(+), 55 deletions(-)
> 
