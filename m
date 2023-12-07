Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F439808B00
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443409AbjLGOsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443322AbjLGOsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:48:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C906CA3;
        Thu,  7 Dec 2023 06:48:47 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7E1cZa015644;
        Thu, 7 Dec 2023 14:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=veDpjFzfwlc4+rGL/4gsXIABL0y0doZWiMeawVjMh38=;
 b=WNNxJTyBFoj4yYHZj7CJBbliwCwMzsfRxIxtI8VvHrKhOjBHtq27TVZXGZHxiFkua9Gt
 q3HXWMcAjt9jd+MJ4lZshFSKIfpw/ExtEBHNyC3qQdiUGr0Gpf+AI5c+Fd3786go0TWR
 2BlDz15/3yNY/UTyhl3wenriRsalm0d9FxCeHX1spVqKsv2j7cFNciKrncftTVH+dFA7
 gHJQ22huLUjfEmkuXWr1BKzgsbPDO4wG5HNpckgz9K8BnCqjp0Zz8ucNF7R4IaO/Syk9
 eB2CS8UQwntEjtM4G2//sgYrUfmgGRokCISwoEDkSx6V3bSU5vavae9rAx1oaW4pCa/5 mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uuexn29f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 14:48:44 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Ecwv0026334;
        Thu, 7 Dec 2023 14:48:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uuexn29ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 14:48:44 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7ENXSK015459;
        Thu, 7 Dec 2023 14:48:43 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utavkkqu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 14:48:43 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B7EmghW45417074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Dec 2023 14:48:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08A3458053;
        Thu,  7 Dec 2023 14:48:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72D2B58043;
        Thu,  7 Dec 2023 14:48:39 +0000 (GMT)
Received: from [9.171.68.143] (unknown [9.171.68.143])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  7 Dec 2023 14:48:39 +0000 (GMT)
Message-ID: <44b1ebbb-1c12-4b38-b73b-9dd95cea34ea@linux.ibm.com>
Date:   Thu, 7 Dec 2023 15:48:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix missing byte order conversion in CLC
 handshake
Content-Language: en-GB
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, Alexandra Winter <wintera@linux.ibm.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        ubraun@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1701882157-87956-1-git-send-email-guwen@linux.alibaba.com>
 <0e2cbf20-bd58-49bf-8000-6d3f80f50380@linux.ibm.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <0e2cbf20-bd58-49bf-8000-6d3f80f50380@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vnZ1c-g0D1HtZASVlf3lG7qwVjB784Qz
X-Proofpoint-ORIG-GUID: B_P1cUaA0A2pryFlr9etb6c1A4hYy_Z-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_12,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=910
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07.12.23 14:12, Wen Gu wrote:

> The byte order conversions of ISM GID and DMB token are missing in
> process of CLC accept and confirm. So fix it.
>
> Fixes: 3d9725a6a133 ("net/smc: common routine for CLC accept and confirm")
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---

[...]

LGTM, thank you!

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
