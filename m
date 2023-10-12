Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E853E7C6D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbjJLMDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjJLMDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:03:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A7BA9;
        Thu, 12 Oct 2023 05:03:10 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CBslrH023887;
        Thu, 12 Oct 2023 12:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UwnvlILX10wd8eW3lTW+/kucpzhYMeZTj2OJc0Mjlm0=;
 b=qjO9DbRxlro0ypk4NLRIUY0akrkQDpDqUVzgsN2NjkJR31nP1EFCUlnefWgDgmkreTz4
 mTa+ZLnq1ivog3aaNOGmtef7cJQQYN+iTmppP0dyrNex0vV9k/qQuGxiIE5424mCQEZa
 aGDiflW33g6zFtBbVzRfEx5UjEsN1L+/zKvG9Hkviem+pF2lPcAs2vfv1VyK8akwnMw6
 7pnlnqTsJdEUxcm+G3XFpzCVHNqbEj8nMMGjw0QNtVo/mCO2YanAr8WpLXTtcJS3esYM
 mlxYAdWzEN7V7EEWN8W/cdG2dYyQmPSf7cY+KwKHocs3+zSy9uiM0Jn/z4Ivkcg+mIxI Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpgbb88q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 12:02:54 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CBt1i8024392;
        Thu, 12 Oct 2023 12:02:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpgbb87uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 12:02:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CC1X1A028191;
        Thu, 12 Oct 2023 12:02:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkj1yfetg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 12:02:03 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CC22654850422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 12:02:02 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1436F5805E;
        Thu, 12 Oct 2023 12:02:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF5B758059;
        Thu, 12 Oct 2023 12:01:57 +0000 (GMT)
Received: from [9.171.14.51] (unknown [9.171.14.51])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Oct 2023 12:01:57 +0000 (GMT)
Message-ID: <a5f0f18e-4fe0-45b6-b962-f28bc9232293@linux.vnet.ibm.com>
Date:   Thu, 12 Oct 2023 17:31:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bisected] [1b4fa28a8b07] Build failure "net/core/gso_test.c"
Content-Language: en-US
To:     Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, willemb@google.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        abdhalee@linux.vnet.ibm.com, sachinp@linux.vnet.com,
        mputtash@linux.vnet.com
References: <79fbe35c-4dd1-4f27-acb2-7a60794bc348@linux.vnet.ibm.com>
 <20231012095746.GA26871@breakpoint.cc>
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
In-Reply-To: <20231012095746.GA26871@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p9RRXOpJ__9haWxZNh885aVaHS8foOjh
X-Proofpoint-ORIG-GUID: _dR317mRYU1r6GCnKAZudttmZcIsBbl0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=688
 impostorscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120098
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

Thank you Florian. I have tried the changes suggested by you and it 
fixes the issue. With the suggested changes the problem is not seen.

On 10/12/23 15:27, Florian Westphal wrote:
> .linear_len = GSO_TEST_SIZE,

-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center

