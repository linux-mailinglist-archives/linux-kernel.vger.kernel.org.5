Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393347EC555
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344111AbjKOOaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjKOOaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:30:05 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D5E127;
        Wed, 15 Nov 2023 06:29:58 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFEQi3O029077;
        Wed, 15 Nov 2023 14:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=US9zv12lGioUA6y3gUFsuEhdS9xvFgifGW5KNI8SMos=;
 b=G8eCvNFFmNRZufcYveqq8hXnYavhKfnyoXY55j8SOwtcQHTnj4JyaY6q1YESgIcvM1u1
 q4X+/9IQQPH5td/BPafiwt8r/0Cfk5XvHVLhvadwbSQQTkd5fwQqmlRJgl6ndmKVwGbB
 LRz/TvO9iOWCGH5qgxi+sN3xdb1YeuDLWTYxUf2f2aqCZtUWtwp1G6WgJc+YOT5mnrwW
 sjsdoNpSL+9v7jsa20RsW2XxzZkVRzfuRY5S+l2Vk4sj3lkElwNtqAK1jtyfdSHTDruA
 iWrRFLMWaVy14+g5l/2hHKey+B29KiREM47BL/H1/KAg88QciUFhXM5src78Ln8+PWL8 +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucyrk02hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:29:57 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFERdF0031403;
        Wed, 15 Nov 2023 14:29:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucyrk02gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:29:56 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDn6rP031622;
        Wed, 15 Nov 2023 14:29:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uapn1q800-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:29:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFETr0f3670638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 14:29:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5910B20040;
        Wed, 15 Nov 2023 14:29:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27A0B2004B;
        Wed, 15 Nov 2023 14:29:53 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Nov 2023 14:29:53 +0000 (GMT)
Date:   Wed, 15 Nov 2023 15:29:51 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com
Subject: Re: [PATCH v3 0/3] s390/vfio-ap: a couple of corrections to the IRQ
 enablement function
Message-ID: <ZVTV37wqwu8cDmK7@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231109164427.460493-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109164427.460493-1-akrowiak@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kC2EzW4Z3rmaEjNTgnHdfJe61LQiG1Bv
X-Proofpoint-ORIG-GUID: jNrMZyKUpeGzijisLF2RKK8DdBJofZSk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=648 malwarescore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 11:44:19AM -0500, Tony Krowiak wrote:
> This series corrects two issues related to enablement of interrupts in 
> response to interception of the PQAP(AQIC) command:
...

Hi Tony!

Via which tree this series is to be pulled?

Thanks!
