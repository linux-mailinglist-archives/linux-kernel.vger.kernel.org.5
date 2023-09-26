Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6867AE6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjIZHa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjIZHax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:30:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2D1DC;
        Tue, 26 Sep 2023 00:30:47 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q7P735016783;
        Tue, 26 Sep 2023 07:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XKB0S+xLh1RPdUjVKo5o+nYaUW7n/k+7Q2ToNYxcMuw=;
 b=N0gl+gIVaoc//JYhyIxuHBa71Hqt8QNWBpIjW/DUwiNH6sEzSoMPjvr/3fv3iT+iQEJM
 FjnEtrFBZgOE6f3ITmu9CxpfKv6UMWqnD7IL4YK+ZtT6/7PfWkEYC8wGwIhlN5F1jOE4
 If1BMpeW9EUywN83ErrATsM9WVZbI7OyiR/nIXLy7525DTcnXeqiiHf67ZQHqfYwdQwy
 74/j6gOi5SP79BP77FE1mLjEjhYKOhNJXjs/hHGIfv9/vvIIYZB+R45KCI3LT5DkzVmO
 SwDwhoQcBInNfk5epVgFyLaoiljpoAgKcjB/+OHE221i97pNNQ9WwEoDDbspAocDWHRm rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbt0b9h3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 07:30:44 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38Q7QSjm022421;
        Tue, 26 Sep 2023 07:30:43 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbt0b9h29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 07:30:43 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q7IPCs030706;
        Tue, 26 Sep 2023 07:30:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjjsb7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 07:30:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38Q7Ucr913238892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 07:30:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE89D200C2;
        Tue, 26 Sep 2023 07:30:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A9D8200C4;
        Tue, 26 Sep 2023 07:30:38 +0000 (GMT)
Received: from [9.152.224.54] (unknown [9.152.224.54])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 26 Sep 2023 07:30:38 +0000 (GMT)
Message-ID: <3a9fde58-2de5-8ade-b1a2-caeb0ca59086@linux.ibm.com>
Date:   Tue, 26 Sep 2023 09:30:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 00/18] net/smc: implement virtual ISM
 extension and loopback-ism
Content-Language: en-US
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ra5twl3tzEINSAYwQZYwjTK7zsMAQmkW
X-Proofpoint-ORIG-GUID: sJ07Y0qUDCUJY85-9gi-U7MPG_t_Tb3N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_05,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 phishscore=0 mlxlogscore=863 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260062
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.09.23 17:16, Wen Gu wrote:
> This patch set includes 4 parts:
> 
>  - Patch #1-#3: decouple ISM device hard code from SMC-D stack.
>  - Patch #4-#8: implement virtual ISM extension defined in SMCv2.1.
>  - Patch #9-#13: implement loopback-ism device.
>  - Patch #14-#18: memory copy optimization for the case using loopback.


Your cover letter is very well helpful, thanks a lot for that.
I really like the way you grouped the patches.
Just a thought:
If it takes too long to get this large patchset reviewed, you could
split it up into smaller sets and get them upstream one after the other. 

I think it is especially valuable to more crisply define the interface between
SMC-D and the smc-d devices, given that virtio-ism may soon be a third kind of
smcd device.
