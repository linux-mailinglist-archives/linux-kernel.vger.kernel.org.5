Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B34B7CE7FD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjJRToU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjJRToS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:44:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE31114;
        Wed, 18 Oct 2023 12:44:17 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IJc8HK014172;
        Wed, 18 Oct 2023 19:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=AjO0+DMZK14GwTlpeBi1dhU00X8CMlyCeEpqSlp6+ks=;
 b=Iaarea27KH35WAJCF6v7BuQkObgbCzHIS2ey8QWyJuxCP4noy3JCBTHUBSP5NUBwt5+p
 kUXvziR5vcaNwLhnk/eOL8w/cijKoGkXE5YaU0Jm/uuAo1aUgzw7QoBS/eWPb7OZoZTe
 riN1H5EQ2hvNCUWCPko+KcqOranHWNQyNcK2WeVLWG/hohvfATqC7nsYrvuUJzE0lV5+
 nMqS4pnvUfTdmaoiGflmTUTw8pnNpZ4S5/FTqW2PhfOrRIaMbGhZbW3FCwFbbxSIWgZX
 XIdcxTZ3ip7D33IXOKh9tPVqiyranCdWdCTQcQG8zJqRWHYaXATSsu6VxqwVSCX0glXh Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttnpdr9xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 19:44:14 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39IJcJlg014497;
        Wed, 18 Oct 2023 19:44:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttnpdr9qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 19:44:13 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39IJ75aj020486;
        Wed, 18 Oct 2023 19:44:08 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6anbf6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 19:44:08 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39IJi79517302174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 19:44:07 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9257458056;
        Wed, 18 Oct 2023 19:44:07 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 022675804E;
        Wed, 18 Oct 2023 19:44:05 +0000 (GMT)
Received: from [9.171.53.134] (unknown [9.171.53.134])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Oct 2023 19:44:04 +0000 (GMT)
Message-ID: <f67f97e0-b298-4fcb-ad23-4af389f255b5@linux.ibm.com>
Date:   Wed, 18 Oct 2023 21:44:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net/smc: change function name from
 smc_find_ism_store_rc to smc_find_device_store_rc
Content-Language: en-GB
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        kgraul@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231017124234.99574-1-guangguan.wang@linux.alibaba.com>
 <20231017124234.99574-2-guangguan.wang@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20231017124234.99574-2-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o8yaggoV8SLYYU4-l2Q07Dqg8UOWNx3j
X-Proofpoint-GUID: DS2PTqMOHC6oXwDZNB4LKgcS6mDXPAvS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=911 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180162
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.10.23 14:42, Guangguan Wang wrote:
> The function smc_find_ism_store_rc is not only used for ism, so it is
> reasonable to change the function name to smc_find_device_store_rc.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
