Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60940786758
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbjHXGNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238651AbjHXGNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:13:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F35F10F4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:13:22 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37O5Qb1b019360;
        Thu, 24 Aug 2023 06:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=+gLjQS288Kx+/ow/HsWql6fcTeP1yiP8W+67MPlat+Y=;
 b=DE8rDxG+nOEwke8OuXPbyEoqDkHc/9KpL+DEDT13dLzKkazRxBDOfCblQkug45EzD70C
 tczC55xfHSdHLYMI15ieeGw4zvFYd0JmgSzeMD7/1OcXeQm+5hT8P+6lF6pl1Fo+f4aP
 276wldo+TYQIvGXDUTngYgTpYHHrLKtFgvE1pI+mvhoU64Wla4Afh8bCigMoIGhXbBo1
 9/ATD0I9I7LSGwCnFz2rYKJHYNB6jUXh4+SxIB3+t7L8UjZFypcD3zP5NazqvGNoe4cV
 IKSXckjejkLI0St014VmSS0jsPMG7xrvu3Tn7ywFsRukNig1QLDVFxPOt8X5KeLPPfv1 MQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snxtarann-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 06:13:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37O6D8ue018598
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 06:13:08 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 23 Aug 2023 23:13:05 -0700
Date:   Thu, 24 Aug 2023 11:43:02 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Kassey Li <quic_yingangl@quicinc.com>
CC:     Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
        <will@kernel.org>, <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: seqlock:do_raw_write_seqcount_end smp_wmb
Message-ID: <52cc5910-af30-42d3-85a3-5eab06fea658@quicinc.com>
References: <3eedf328-d588-cbd2-ee99-55dc776bdf5b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3eedf328-d588-cbd2-ee99-55dc776bdf5b@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ff-1Rm3mg5fQiCrysx8TZumQyvNyfADW
X-Proofpoint-GUID: Ff-1Rm3mg5fQiCrysx8TZumQyvNyfADW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_03,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=549 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 09:07:57AM +0800, Kassey Li wrote:
> hi, Peter:
> 	I not quit sure on this, but is that a type error in
> do_raw_write_seqcount_end here  ?
> is this change necessary to match with do_raw_write_seqcount_begin ?
> 		
> 	
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 987a59d977c5..eb8807ed3a00 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -486,8 +486,8 @@ do {                        \
> 
>  static inline void do_raw_write_seqcount_end(seqcount_t *s)
>  {
> -       smp_wmb();
>         s->sequence++;
> +       smp_wmb();
>         kcsan_nestable_atomic_end();
>  }
> 
> 
> to match with
> 
> static inline void do_raw_write_seqcount_begin(seqcount_t *s)
> {
> 	kcsan_nestable_atomic_begin();
> 	s->sequence++;
> 	smp_wmb();
> }
> 
> 
> 

I don't see anything wrong here. As per my understanding,
do_raw_write_seqcount_end() marks the end of the writer side critical
section. The data modified in the critical section should be visisble to
the *reader* before seqcount::sequence increment is visible. The 
smp_wmb() here pairs with the smp_rmb() in the read_seqcount_begin().
Pls see kernel/sched/cputime.c for an example.

Thanks,
Pavan
