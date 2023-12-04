Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2E4802EEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbjLDJlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjLDJlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:41:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE01D4E;
        Mon,  4 Dec 2023 01:40:59 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B48h1r0000668;
        Mon, 4 Dec 2023 09:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3VDOrhhpZyHwMsETPwhmSxEMw1K/gH1++xxfU+EXW1A=;
 b=lnGn8ljX7gazFX7P7FvYTxxOH0QhcWnSdeJqWR5e0w6abBTSPr9OxhfFwvMhEYl2Xc4z
 6aOtoLDzGohrrZPLzsP2TP8t7IlXy+f8Zg9d6YTlMgUoSxus8KxgBWSkgRrYkzH9mpNx
 8nGm07vSgEWJEQddYPQpRcMQoHzYuktpWaGpOFsvSQ7735VLj7n+iqN8DhOUDbZ5ykio
 hVmtvz1RSYrM6NSVAY6B1P8FZhJobp+GYAih/EPRAjPsjJF+Ntk8/LGtGIsnREzb9uyy
 6oZWeSj/1TT4N2AFjcJ47YAlnPJ0sn4q+KXjuU3wBuE4TimhXeCgNWQDJclrNfeUTAcQ 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usbgf1t94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 09:40:27 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B49dt2u009497;
        Mon, 4 Dec 2023 09:40:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usbgf1t81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 09:40:26 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B474PvC007667;
        Mon, 4 Dec 2023 09:40:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3urgdkq7j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 09:40:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B49eM2V13697734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Dec 2023 09:40:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 216222004E;
        Mon,  4 Dec 2023 09:40:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3ACA20040;
        Mon,  4 Dec 2023 09:40:20 +0000 (GMT)
Received: from [9.179.21.199] (unknown [9.179.21.199])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  4 Dec 2023 09:40:20 +0000 (GMT)
Message-ID: <b344c321-b481-48b0-8165-c3ab604fc397@linux.ibm.com>
Date:   Mon, 4 Dec 2023 10:40:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 31/35] net: smc: use find_and_set_bit() in
 smc_wr_tx_get_free_slot_index()
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
 <20231203193307.542794-30-yury.norov@gmail.com>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20231203193307.542794-30-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uDGvSNUw8E8DooRP5CCwhJb8Fm9JXTzZ
X-Proofpoint-GUID: CljkFlSZokllTUzPLp-H0mqHW8RlSY7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 mlxlogscore=812
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.12.23 20:33, Yury Norov wrote:
> The function opencodes find_and_set_bit() with a for_each() loop. Use
> it, and make the whole function a simple almost one-liner.
> 
> While here, drop explicit initialization of *idx, because it's already
> initialized by the caller in case of ENOLINK, or set properly with
> ->wr_tx_mask, if nothing is found, in case of EBUSY.
> 
> CC: Tony Lu <tonylu@linux.alibaba.com>
> CC: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>


Thanks a lot for the great helper function!
I guess the top-level maintainers will figure out, how this series best finds its way upstream.
