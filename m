Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38757CDD1F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjJRNYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjJRNYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:24:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB40B83;
        Wed, 18 Oct 2023 06:24:16 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IDMRVm009680;
        Wed, 18 Oct 2023 13:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TiOX6dll2bvGdWalE9/Utntb+gAx0yYM4DDzC7MoWvI=;
 b=qqmQ6GQ8skPeKGNU7xDyOwp5sPN2w/xmnR/1t9AKSRONMnrj/iNWWvLPg9KJsLX8Fi1V
 3dKaz1WYlPSQtfMQXyvBqgDRz2OLGDuw9xpvt7Ql5jFA5DRG4D0mYOMG3Y9n/SGxjIk3
 KR20neAE6ZGjKxYC6iyLUpmc9ql8+FP+h98AYBGXalanNlUnQ5N5IAWcFv+Bks7o6Qg5
 CN4zuIG+Jf3Xfb4+SY02mwF6FnrB9cLDpcj/Gh3L0btZ+YPWqvN2Qtsp84YIr4cHs/e8
 7cWgmKT9OQrR/W9+WzKEDczz5eXcQU0zX/vMG5xbh36NFePqBeCxc4trZcc9/FbYH71w NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttg6g8396-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 13:24:13 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39IDMWfV010043;
        Wed, 18 Oct 2023 13:24:12 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttg6g8382-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 13:24:12 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39IBBhAx030719;
        Wed, 18 Oct 2023 13:24:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr7hjrafv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 13:24:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39IDO83n18088602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 13:24:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F11B20043;
        Wed, 18 Oct 2023 13:24:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B039A20040;
        Wed, 18 Oct 2023 13:24:07 +0000 (GMT)
Received: from [9.152.224.54] (unknown [9.152.224.54])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Oct 2023 13:24:07 +0000 (GMT)
Message-ID: <0d6c3a16-bba1-4f7d-bfbc-44efb7e73706@linux.ibm.com>
Date:   Wed, 18 Oct 2023 15:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 10/18] net/smc: implement ID-related
 operations of loopback
Content-Language: en-US
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <1695568613-125057-11-git-send-email-guwen@linux.alibaba.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1695568613-125057-11-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ugbjpdp0hi_8TGux2-ODi44VSmBAfyAA
X-Proofpoint-GUID: i8QepzJQ-DOyQjH0mORVfHrOJtpPRnsK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_12,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=650 bulkscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.09.23 17:16, Wen Gu wrote:
> This patch implements GID/CHID/SEID related operations of SMC-D loopback device. In loopback device, GID is generated by UUIDv4 algorithm, CHID is reserved 0xFFFF, SEID is generated using the same algorithm as ISM device under s390 architecture, and is 0 and disabled under non-s390 architecture. Signed-off-by: Wen Gu <guwen@linux.alibaba.com> ---

IMO, get_system_eid should not be part of smcd_ops. And should not be provided by an smcd device.
It is a system_eid is a global value that is valid for all smcd interfaces of this system (os instance).
So I think it should be provided by the smc module. 

I agree it needs to be architecture dependent and same as today for s390.
