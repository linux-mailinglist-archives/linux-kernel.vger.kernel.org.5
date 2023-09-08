Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D2C7984F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241810AbjIHJm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 05:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjIHJm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:42:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD2D1BF1;
        Fri,  8 Sep 2023 02:42:54 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3889cZg2032229;
        Fri, 8 Sep 2023 09:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ecYvUJkgEZY8thT/8b9+RPpjBcLl/sH8Z/aqr6ySu44=;
 b=Qrb6VZ4ROnKMumSIUtHDot4vITpzyrQROvOnTyKds/Ef8iw1+07tq3AuJ/2vz0l1RYYF
 zUrIgFgTiZ2JNr+WdHV3fMdlSm9hGTtSh47oWfQQeHJaMEqFtrz7gJfM90P8oc1H1dvH
 P1S0OWjjEsRKJADq+zPvA3aDKH7pGYkT9Y9brCSwe66YpMfnBrm9Vr2MTGpqAmSmJpiT
 fBMR89ZgFq8TfiFtqLnveVM2AHT6d/WRJNUTclaqao1uTKNmk3SEDv5REoiKo9UbE6vF
 XPP4iF1JbGrTfaCEZFiLkgSdhDe7PN//CgfaRoJqmAp4PjdgpHqgorBtYpG8w/xBkiBq 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t00xfgajg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 09:42:49 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3889cs8f002938;
        Fri, 8 Sep 2023 09:42:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t00xfgaj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 09:42:49 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3887mgcN026756;
        Fri, 8 Sep 2023 09:42:48 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgcp2qd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 09:42:48 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3889glo022217130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 09:42:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 683295803F;
        Fri,  8 Sep 2023 09:42:47 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0298558054;
        Fri,  8 Sep 2023 09:42:45 +0000 (GMT)
Received: from [9.179.12.78] (unknown [9.179.12.78])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  8 Sep 2023 09:42:44 +0000 (GMT)
Message-ID: <0f9aa662-f629-e7d9-1979-50493b9f52c0@linux.ibm.com>
Date:   Fri, 8 Sep 2023 11:42:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net 0/2] Two fixes for SMC-R
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        jaka@linux.ibm.com, kgraul@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230908033143.89489-1-guangguan.wang@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20230908033143.89489-1-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6lKdxtwvttwIN4H7jkOk17j7eFDVs27L
X-Proofpoint-GUID: i0HU0V0It_HG_aqW8MMo25gZfHVs8t4b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=965 lowpriorityscore=0
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
> Two fixes for SMC-R.
> 
> Guangguan Wang (2):
>    net/smc: bugfix for smcr v2 server connect success statistic
>    net/smc: use smc_lgr_list.lock to protect smc_lgr_list.list iterate in
>      smcr_port_add
> 
>   net/smc/smc_core.c  | 2 ++
>   net/smc/smc_stats.h | 3 ++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
Thank you for fixing them!

The sign is for the two patches:
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
