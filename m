Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AA67B33A1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjI2Nbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjI2Nbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:31:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D9F1A8;
        Fri, 29 Sep 2023 06:31:31 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TDCvBN026797;
        Fri, 29 Sep 2023 13:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=KOguaF6iALYcwr27LNhLYvutGdA4b4GGDP7gWC/lIdw=;
 b=E1dhxl1GaoBJiZnhbyJsXCL3SMKcJe3hVn02fVmAVWTW9BQahWNYP9mmjHSpOqLeB2P7
 /u34byGz5GO0iumI/Urh7akqLiH6LvJHPeu0/bhWZkLGLjpoQ4AcEN+VTqTuioNcJ8Bu
 7dPznadXRwHC3zRHYH9Sk5etiOCKmabjeP6s7HtutqBtm87QbC7Vd4FwNETViutULB5r
 9rSX2GN4KSrKlrDUx2i18reNkmHI2DLRdon6x5qH37xbDqi4E8qy1IZh7NtJtqZUc85+
 FnRj+eFXZgdvjJrGQQ/spwYLitV/ox+S9weGDCiTH+Vv3PHJ+/k/kx2AgLE4zVNaVASr PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdx32tpvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 13:31:26 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38TDTeE7014388;
        Fri, 29 Sep 2023 13:31:25 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdx32tpvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 13:31:25 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38TBK6KS030735;
        Fri, 29 Sep 2023 13:31:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjkmfh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 13:31:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38TDVLIn23265794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 13:31:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC02520040;
        Fri, 29 Sep 2023 13:31:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC6522004B;
        Fri, 29 Sep 2023 13:31:20 +0000 (GMT)
Received: from [9.179.2.72] (unknown [9.179.2.72])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 29 Sep 2023 13:31:20 +0000 (GMT)
Message-ID: <da1d0698-ea4c-12b3-3e20-fc9b65e56a3a@linux.ibm.com>
Date:   Fri, 29 Sep 2023 15:31:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 00/18] net/smc: implement virtual ISM
 extension and loopback-ism
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <2e4bb42a-1a6c-476e-c982-c4d6cfdac63b@linux.ibm.com>
 <1fc9a6aa-019d-f3f5-7cac-3b78388c2730@linux.ibm.com>
 <4bac8bcf-5507-0982-fed2-c507fc3264c2@linux.alibaba.com>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <4bac8bcf-5507-0982-fed2-c507fc3264c2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: roAzsINWAF_IAxI5Chgnx5YVqvI05Fmd
X-Proofpoint-ORIG-GUID: 9pqjkfaYLUZvpVjerG8VUa573a816dfQ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=991 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290112
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.09.23 19:29, Wen Gu wrote:
> 
> 
> On 2023/9/28 16:56, Alexandra Winter wrote:
>>
>>
>> On 27.09.23 17:16, Alexandra Winter wrote:
>>> Hello Wen Gu,
>>>
>>> I applied and built your patches and noticed some things that you may want to consider in the next version:
>>
>>
>> FYI, patchwork basically complains about many the same issues:
>> https://patchwork.kernel.org/project/netdevbpf/list/?series=787037&state=*
>>
>> In general you should run those check BEFORE you send the patches and not rely on patchwork.
> Thank you Sandy. I seem to have not seen the specific content of these checks. May I ask how to
> run those patchwork check locally? So that I can make sure everything is ok before send them.
> 

Citing from Documentation/process/maintainer-netdev.rst :

"patchwork checks
~~~~~~~~~~~~~~~~

Checks in patchwork are mostly simple wrappers around existing kernel
scripts, the sources are available at:

https://github.com/kuba-moo/nipa/tree/master/tests

**Do not** post your patches just to run them through the checks.
You must ensure that your patches are ready by testing them locally
before posting to the mailing list. The patchwork build bot instance
gets overloaded very easily and netdev@vger really doesn't need more
traffic if we can help it."

HTH

