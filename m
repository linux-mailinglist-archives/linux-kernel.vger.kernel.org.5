Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6318580C878
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjLKLus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343501AbjLKLuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:50:46 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432D69B;
        Mon, 11 Dec 2023 03:50:52 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBBnDu1019329;
        Mon, 11 Dec 2023 11:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=g/OpsuF0w/ezjdOt1y1XRBvIP8co9yItLc4jPWanbV0=;
 b=ZOOokYmGmmVp51O0dGWUb90Pc3CKvxJp1s3jtuYeivB9BWiENkynUsjTPG0WSHA9JQmU
 qqUNQq5Uy7CR4Cv7VWNJQ+fZ5szid2D+hBrhCbS6X26TSCnFGh9SeDmdnuXrc+sRujmM
 P2xPOY+oyUsXM5NfIm5mHOKTxjC5DvGAyYfvoX6JLFVbtuf7V1sBta54AFe5HlIVmLb/
 aq08YZsoWJETms1X5pvZg+n/kWcStobnnVlNJDge3FLOyL8f4uqCDffg3f7SfWfZfA6T
 SBNo6EPT2vOevZzR7USd22VDfyAoNchNQJUiW9ws3RO0gN9+sBnnqZWrcbO99TmDI/hl Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ux1vq81ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 11:50:44 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BBBnwHp021051;
        Mon, 11 Dec 2023 11:50:43 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ux1vq81ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 11:50:43 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB9sDxZ013874;
        Mon, 11 Dec 2023 11:50:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw591rgdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 11:50:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BBBod4v27853536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Dec 2023 11:50:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB4D320040;
        Mon, 11 Dec 2023 11:50:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D9EC20043;
        Mon, 11 Dec 2023 11:50:38 +0000 (GMT)
Received: from [9.171.1.164] (unknown [9.171.1.164])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Dec 2023 11:50:38 +0000 (GMT)
Message-ID: <a7abaf57-a49a-4a31-a7e6-0d5312367480@linux.ibm.com>
Date:   Mon, 11 Dec 2023 12:50:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 7/9] net/smc: support extended GID in SMC-D
 lgr netlink attribute
Content-Language: en-US
To:     Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1702021259-41504-1-git-send-email-guwen@linux.alibaba.com>
 <1702021259-41504-8-git-send-email-guwen@linux.alibaba.com>
 <8b651c68-c51d-49a9-9df0-58e9110fa47d@linux.ibm.com>
 <1c14f769-8da2-fdac-cec2-a59ab69284ad@linux.alibaba.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1c14f769-8da2-fdac-cec2-a59ab69284ad@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Pa-SLE7kdb9xgaosGmzVJpt4wpjlfvWN
X-Proofpoint-ORIG-GUID: jdoe_snMf-7DmBs02uL24sx8-JQ6gp8N
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_04,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=749 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312110095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.12.23 11:09, Wen Gu wrote:
> 
> 
> On 2023/12/11 17:39, Alexandra Winter wrote:
>>
>>
>> On 08.12.23 08:40, Wen Gu wrote:
>>> Virtual ISM devices introduced in SMCv2.1 requires a 128 bit extended
>>> GID vs. the existing ISM 64bit GID. So the 2nd 64 bit of extended GID
>>> should be included in SMC-D linkgroup netlink attribute as well.
>>>
>>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>>> ---
>>
>> This patch did not apply cleanly.
>> Please always base patches on the current net-next
> 
> Strange.. I can apply them cleanly with the latest net-next
> (6e944cc68633 ("Merge branch 'rswitch-jumbo-frames'")).
> 
> Could you please try again? Thanks.
> 

Sorry, the patches were somehow re-ordered when I downloaded them from
https://lore.kernel.org/netdev/4ad3a168-f506-fc21-582d-fe8764f404c0@linux.alibaba.com/t.mbox.gz

Everything is ok with this patch.
