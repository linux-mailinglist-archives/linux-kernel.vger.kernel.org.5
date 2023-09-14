Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695FA7A01B1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbjINK3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjINK31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:29:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140791BE9;
        Thu, 14 Sep 2023 03:29:22 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EADAR6009551;
        Thu, 14 Sep 2023 10:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tDkkOsocqls0t+Q5ELLs9Xlf48gqtWqdENRZHsKALys=;
 b=s3PBRqjZdZxyUyh3YAa4pFcEEr+axzEf8LcU15PQ/9WLuwDtZRqUK9QX3HftB3ayoPiD
 n8DbCGUn0JD9uNvz7DVapZJ94elga0WRjRzPLG4cFsmiN/U89AHyEZq+zDuVna2JwIfk
 DV0s9G/YEzEfNyL+ce1WdW0iJCHG7bm4q15iZKV8PZF3Ci15nPknr0/LqriAqdvYvbuI
 5B+rmXGxzw7ThJ/raCK75XPSglDSdrh1Ow5AaYMS79z+RXEdyPaub7iqZKa0tDAsWTY8
 eSG3wSBEoPvVAot6qVVG334YsLEQE/ukAuScaF3YjRkz1eAPeM7XvlYb16ZMaMMiO07m 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t3yvms0g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:29:19 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38E9nn4L007950;
        Thu, 14 Sep 2023 10:29:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t3yvms0fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:29:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38E8bvLi002755;
        Thu, 14 Sep 2023 10:29:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hma24p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:29:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38EATEgf63504642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 10:29:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A78F2004B;
        Thu, 14 Sep 2023 10:29:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3746420043;
        Thu, 14 Sep 2023 10:29:14 +0000 (GMT)
Received: from [9.152.224.42] (unknown [9.152.224.42])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Sep 2023 10:29:14 +0000 (GMT)
Message-ID: <30bbcc92-f5ff-cbda-7a3b-cc801aa560ed@linux.ibm.com>
Date:   Thu, 14 Sep 2023 12:29:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH net-next] net/smc: Introduce SMC-related proc files
To:     Wen Gu <guwen@linux.alibaba.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1694416820-60340-1-git-send-email-guwen@linux.alibaba.com>
 <2b1d129c-06e2-0161-7c8a-1e930150d797@linux.ibm.com>
 <a0a4567e-07f1-91db-50cb-bbfc803f5969@linux.alibaba.com>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <a0a4567e-07f1-91db-50cb-bbfc803f5969@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4fx-3ooD91c3ydo1CMa1Lpm2-ZiD0jFe
X-Proofpoint-ORIG-GUID: Q_MUuDzbxZRPe2jKpigVVMnUXad3vX-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_08,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxlogscore=727 clxscore=1011
 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309140085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.09.23 11:53, Wen Gu wrote:
> 
> 
> On 2023/9/11 19:54, Wenjia Zhang wrote:
>>
>>
>>
>> Hi Wen,
>>
>> I can understand your problem and frustration. However, there are two reasons I'm not really convinced by the proc file method:
>> 1) AFAI, the proc method could consume many CPU time especially in case with a log of sockets to read the pseudo files.
>> 2) We have already implemented the complex netlink method on the same purpose. I see the double expense to main the code.
>>
>> Then the question is if the lack of dependency issue can be handle somehow, or the proc method is the only way to achieve this purpose?
>>
>> Any opinion is welcome!
>>
>> Thanks,
>> Wenjia
> 
> Hi, Wenjia. I agree with your concerns.
> 
> My initial intention is to make these proc files serve as a supplement to netlink to conveniently
> check smc connections in an environment where smc-tools cannot be easily obtained.
> 
> Yes, proc files won't be the first choice for diagnosis, but can be a convenient backup.
> 
> Thanks,
> Wen Gu
> 
> 
As /proc is an interface to userface,  we would have to maintain the 2 redundant methods basically forever.
I personally don't think we should implement another interface without a very strong reason.
