Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EC77B7F5D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242422AbjJDMiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242400AbjJDMiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:38:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B871707;
        Wed,  4 Oct 2023 05:37:53 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394Cb2TO011517;
        Wed, 4 Oct 2023 12:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=x/NBZ+opexFAIqioQc4W3QuYamoOs5pkZ6pzwfkMpB4=;
 b=ml30rtU7vxbV40gbe2kvFhrV1Pl+CNjBc6c5GJCUbPEibZRvFpG++g9SjSb48Tv9DnoW
 GDrs072Yvr5FHkXHY9Hl8bpK2hdXL7w/rCttACnrxLJ+Y2YZViNkQ2L0dIzCVuCnEXyf
 aHMePY5nsCiP3KvOa9g1Iznb/ulRcH1BCbY653YDSyMpnb285IxmL/x80XKl5NvzM6wO
 CdWrBL2LFQV5JHquogCzIomKrpAZuzGEPQV/ll7e8u5NS235HO4uX+ApyWpoIMoY4V+M
 dCzTvfiY1UspRVU5LviQpzX/lSxpJTza+o0Cz8bh6tJ15ur10wqsdWINEfvtDhcR6FVF FQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th813g8d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 12:37:17 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 394BV22x006684;
        Wed, 4 Oct 2023 12:37:05 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf07k3v9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 12:37:05 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 394Cb4f34588168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 12:37:05 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAA445805E;
        Wed,  4 Oct 2023 12:37:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A03B658056;
        Wed,  4 Oct 2023 12:37:03 +0000 (GMT)
Received: from [9.171.41.118] (unknown [9.171.41.118])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Oct 2023 12:37:03 +0000 (GMT)
Message-ID: <d9a2d47d-c8bd-cf17-83e0-d9b82561a594@linux.ibm.com>
Date:   Wed, 4 Oct 2023 14:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: linux-next: Tree for Oct 3 (net/smc/smc_ism.o)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Network Development <netdev@vger.kernel.org>
References: <20231003143340.61697d4c@canb.auug.org.au>
 <d53b5b50-d894-4df8-8969-fd39e63440ae@infradead.org>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <d53b5b50-d894-4df8-8969-fd39e63440ae@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OjBFZtBJv7yJ2a807HxwSdW7mAwdsS0S
X-Proofpoint-ORIG-GUID: OjBFZtBJv7yJ2a807HxwSdW7mAwdsS0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040091
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.10.23 03:08, Randy Dunlap wrote:
> 
> 
> On 10/2/23 20:33, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20230929:
>>
> 
> on s390: when
> 
> CONFIG_ISM=m
> CONFIG_SMC=y
> 
> s390-linux-ld: net/smc/smc_ism.o: in function `smcd_register_dev':
> smc_ism.c:(.text+0x55c): undefined reference to `ism_get_smcd_ops'
> s390-linux-ld: net/smc/smc_ism.o: in function `smc_ism_init':
> smc_ism.c:(.text+0x1dc2): undefined reference to `ism_register_client'
> s390-linux-ld: net/smc/smc_ism.o: in function `smc_ism_exit':
> smc_ism.c:(.text+0x1e08): undefined reference to `ism_unregister_client'
> 
> 
> Full randconfig file is attached.
> 
Hi Randy,

Thank you for the finding! I'll send the fix soon.

Best
Wenjia
