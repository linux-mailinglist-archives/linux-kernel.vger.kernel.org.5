Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA37C66D6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377919AbjJLHiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377465AbjJLHiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:38:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078DCC9;
        Thu, 12 Oct 2023 00:38:01 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C7a5nT027495;
        Thu, 12 Oct 2023 07:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : content-type :
 content-transfer-encoding; s=pp1;
 bh=tPSkQTo/UIqXR9TJ1CiWAXvie/7O/aQcvxPdNMCnRaQ=;
 b=jo7nfrBWGer9nMakApRz3RcoZA2ZN1f4jEeprif2AuN389dxBrqzxtL2efYXamLaR0du
 fw6bN6bGl41UIqdYm2zlahXnnM0Rzb5exHValpP6Dp/Guoo9C4bv7lpYuTVb46n8eLSV
 TYtZUNE8QHTCRPVOm+T+kOe/U2tYbzfVTF2GGZ5Fag3C1DI/iRNvWxGsWY5a0amLxEyj
 jziFDXubpXE83YkuUsaRnwdStQMmdB9304Vm9l1FUJeOZmdJrytf/Y9IBJkVq7nkDT9Q
 EMIWT6bOttjzlsaEml/ovKYPXMm/YPkxmAcOjP1UYdaQBo8I1h/AQuXK3wmR+giEHfvS 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpca98hq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 07:37:47 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39C7at3T001180;
        Thu, 12 Oct 2023 07:37:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpca98hpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 07:37:47 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39C6hZva026364;
        Thu, 12 Oct 2023 07:37:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkjnnp138-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 07:37:46 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39C7bj7E20906588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 07:37:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E52E85805C;
        Thu, 12 Oct 2023 07:37:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80E3558058;
        Thu, 12 Oct 2023 07:37:41 +0000 (GMT)
Received: from [9.171.14.51] (unknown [9.171.14.51])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Oct 2023 07:37:41 +0000 (GMT)
Message-ID: <79fbe35c-4dd1-4f27-acb2-7a60794bc348@linux.vnet.ibm.com>
Date:   Thu, 12 Oct 2023 13:07:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: [Bisected] [1b4fa28a8b07] Build failure "net/core/gso_test.c"
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     willemb@google.com, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, abdhalee@linux.vnet.ibm.com,
        sachinp@linux.vnet.com, mputtash@linux.vnet.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yLsQ2Nng7jDxAk8U1K_hek_n1amIIVYW
X-Proofpoint-GUID: eG8iLiYuF54pSKJIIhddBbltn08Nb454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_03,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=953
 impostorscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

[net-next] [6.6-rc4] Build failure "net/core/gso_test.c"

--- Traces ---

make -j 33 -s && make modules_install && make install
net/core/gso_test.c:58:48: error: initializer element is not constant
    58 |                 .segs = (const unsigned int[]) { gso_size },
       |                                                ^
net/core/gso_test.c:58:48: note: (near initialization for ‘cases[0]’)
net/core/gso_test.c:65:48: error: initializer element is not constant
    65 |                 .segs = (const unsigned int[]) { gso_size, 
gso_size, 1 },
       |                                                ^
net/core/gso_test.c:65:48: note: (near initialization for ‘cases[1]’)
net/core/gso_test.c:72:49: error: initializer element is not constant
    72 |                 .frags = (const unsigned int[]) { gso_size, 1 },
       |                                                 ^
net/core/gso_test.c:72:49: note: (near initialization for ‘cases[2]’)
net/core/gso_test.c:74:48: error: initializer element is not constant
    74 |                 .segs = (const unsigned int[]) { gso_size, 
gso_size, 1 },
       |                                                ^
net/core/gso_test.c:74:48: note: (near initialization for ‘cases[2]’)
net/core/gso_test.c:80:49: error: initializer element is not constant
    80 |                 .frags = (const unsigned int[]) { gso_size, 
gso_size, 2 },
       |                                                 ^
net/core/gso_test.c:80:49: note: (near initialization for ‘cases[3]’)
net/core/gso_test.c:82:48: error: initializer element is not constant
    82 |                 .segs = (const unsigned int[]) { gso_size, 
gso_size, 2 },
       |                                                ^
net/core/gso_test.c:82:48: note: (near initialization for ‘cases[3]’)
net/core/gso_test.c:89:49: error: initializer element is not constant
    89 |                 .frags = (const unsigned int[]) { gso_size, 3 },
       |                                                 ^
net/core/gso_test.c:89:49: note: (near initialization for ‘cases[4]’)
net/core/gso_test.c:91:48: error: initializer element is not constant
    91 |                 .segs = (const unsigned int[]) { 2 * gso_size, 3 },
       |                                                ^
net/core/gso_test.c:91:48: note: (near initialization for ‘cases[4]’)
net/core/gso_test.c:99:53: error: initializer element is not constant
    99 |                 .frag_skbs = (const unsigned int[]) { gso_size, 
gso_size },
       |                                                     ^
net/core/gso_test.c:99:53: note: (near initialization for ‘cases[5]’)
net/core/gso_test.c:101:48: error: initializer element is not constant
   101 |                 .segs = (const unsigned int[]) { gso_size, 
gso_size, gso_size },
       |                                                ^
net/core/gso_test.c:101:48: note: (near initialization for ‘cases[5]’)
net/core/gso_test.c:107:53: error: initializer element is not constant
   107 |                 .frag_skbs = (const unsigned int[]) { gso_size, 
gso_size },
       |                                                     ^
net/core/gso_test.c:107:53: note: (near initialization for ‘cases[6]’)
net/core/gso_test.c:109:48: error: initializer element is not constant
   109 |                 .segs = (const unsigned int[]) { gso_size, 
gso_size },
       |                                                ^
net/core/gso_test.c:109:48: note: (near initialization for ‘cases[6]’)
net/core/gso_test.c:117:53: error: initializer element is not constant
   117 |                 .frag_skbs = (const unsigned int[]) { gso_size, 
1, gso_size, 2 },
       |                                                     ^
net/core/gso_test.c:117:53: note: (near initialization for ‘cases[7]’)
net/core/gso_test.c:119:48: error: initializer element is not constant
   119 |                 .segs = (const unsigned int[]) { gso_size, 
gso_size, gso_size, 3 },
       |                                                ^
net/core/gso_test.c:119:48: note: (near initialization for ‘cases[7]’)
make[4]: *** [scripts/Makefile.build:243: net/core/gso_test.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:480: net/core] Error 2
make[3]: *** Waiting for unfinished jobs....

make[2]: *** [scripts/Makefile.build:480: net] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/root/net-next/Makefile:1913: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2

gitbisect points to below commit, reverting the below commit resolves 
the issue

commit 1b4fa28a8b07eb331aeb7fbfc806c0d2e3dc3627
     net: parametrize skb_segment unit test to expand coverage

-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center

