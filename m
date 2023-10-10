Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42D7BF8B8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjJJKch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjJJKce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:32:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B16C4;
        Tue, 10 Oct 2023 03:32:32 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AAMUIK022219;
        Tue, 10 Oct 2023 10:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=G4ZN2prybdRxjNMpLfgdIP1IbuHzdG4M/LEnYvyrvaY=;
 b=RkPHVsJvnXXq9AlQIeRc8ezYAw+NDvivDQn3zjpKZN8Q38KlxaixLM/HSvveNvlFstqX
 tQZaUaW//CmxpMhv3aWvHNRle3RhkPfzv4o0ZRfmWF0ZQgy6fpAn3PJH5kyLy3vIG3F3
 5KMnq/fPx3AY0XK90qL30fl4QJCQM5DIl0nwkCRdq4vIJZa8f6ePmAA4ciZjZibQrtTA
 FnhQPrRa7r5j6PF9uFZHbTqDbC787/iS0YEAd3Li/yO2ZGevfsFpt5f8ul12VbuLYySN
 kGmDBTg2aaCUiBgQMRLzOw0M8fDoloaop2ZT5ggDPr2JYaKkk7ztmpWf2Vllh+iyOKDr FQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tn4t4gaf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 10:32:31 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39A88wJ3025927;
        Tue, 10 Oct 2023 10:32:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkjnn7p11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 10:32:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39AAWQ2Y46137614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 10:32:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB4952004D;
        Tue, 10 Oct 2023 10:32:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D8BC20040;
        Tue, 10 Oct 2023 10:32:26 +0000 (GMT)
Received: from localhost (unknown [9.171.24.117])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 10 Oct 2023 10:32:25 +0000 (GMT)
Date:   Tue, 10 Oct 2023 12:32:24 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/cio: Fix a memleak in css_alloc_subchannel
Message-ID: <your-ad-here.call-01696933944-ext-3327@work.hours>
References: <20230921071412.13806-1-dinghao.liu@zju.edu.cn>
 <bd38baa8-7b9d-4d89-9422-7e943d626d6e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd38baa8-7b9d-4d89-9422-7e943d626d6e@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9T8T13insnaSR3sdLLL219eJzjiz1LHd
X-Proofpoint-GUID: 9T8T13insnaSR3sdLLL219eJzjiz1LHd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_05,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 mlxlogscore=706 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 05:12:54PM +0200, Peter Oberparleiter wrote:
> On 21.09.2023 09:14, Dinghao Liu wrote:
> > When dma_set_coherent_mask() fails, sch->lock has not been
> > freed, which is allocated in css_sch_create_locks(), leading
> > to a memleak.
> > 
> > Fixes: 4520a91a976e ("s390/cio: use dma helpers for setting masks")
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> 
> Looks good to me.
> 
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Applied, thank you.
