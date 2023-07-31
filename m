Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16987768EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjGaHaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjGaH3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:29:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B692C1703;
        Mon, 31 Jul 2023 00:27:03 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V7BwOK002128;
        Mon, 31 Jul 2023 07:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OGKgTUQdiOBkn8EITMnpjyPTwSnRGvYmwWmatLPbyzs=;
 b=tC1IHoJor0t8foyGv9epTpmmX2M3zNlKapYStTMP5RVxBQde1QwPMQSgTOCZS+Iku8pI
 2Ekzaik9vA7QEqRWoT5RwSAmehyjU6ISm67ee5iIXmaNzEU9AuwfiiAQHl72wJBN2bcE
 4lflMmNowtz03UxxF8/tBw8ibjLwEBDh5yj/EOs1A26juTnXmm2sriDjJTbofABTGPNZ
 O9+KwWDiyC80IvVZbDx8hIDAxxHeM5DS5omGHhdNptKEozzj0k16zlIUzPBN7g44jaMt
 AytQqDaD/ASzaIyO0S1E+HvxdVI0H61kgxiXVk85KX7PRLZFRi3d/PHvQS1RpYgoJPPg OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s68bv0enp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 07:26:47 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36V7C1Sl002470;
        Mon, 31 Jul 2023 07:26:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s68bv0en0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 07:26:46 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36V6dYB9015486;
        Mon, 31 Jul 2023 07:26:45 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5e3mh6y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 07:26:45 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36V7QibZ34079068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 07:26:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A85765805E;
        Mon, 31 Jul 2023 07:26:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D457D58045;
        Mon, 31 Jul 2023 07:26:41 +0000 (GMT)
Received: from [9.171.26.13] (unknown [9.171.26.13])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jul 2023 07:26:41 +0000 (GMT)
Message-ID: <67def28b-27cf-560d-8b33-d94a8b8a4d9d@linux.ibm.com>
Date:   Mon, 31 Jul 2023 09:26:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] net/smc: Remove unused function declarations
To:     Yue Haibing <yuehaibing@huawei.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230729121929.17180-1-yuehaibing@huawei.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20230729121929.17180-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uODoM8UPlxLbEVWzylmkl_fwteAOR5j1
X-Proofpoint-ORIG-GUID: EZqHPi-9IKEEMVyy4IrcDAarHBtdvSRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310062
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.07.23 14:19, Yue Haibing wrote:
> commit f9aab6f2ce57 ("net/smc: immediate freeing in smc_lgr_cleanup_early()")
> left behind smc_lgr_schedule_free_work_fast() declaration.
> And since commit 349d43127dac ("net/smc: fix kernel panic caused by race of smc_sock")
> smc_ib_modify_qp_reset() is not used anymore.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Thank you for the findings!

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
