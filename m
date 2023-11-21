Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8267F3110
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjKUOgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjKUOgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:36:20 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E096C100;
        Tue, 21 Nov 2023 06:36:16 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALDM7M3027906;
        Tue, 21 Nov 2023 14:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=kA0m7wG+q6zq5Ot/06C/knbcRiXmToTBkQjHd2VSm9A=;
 b=WPXjxBmBjou4hv5nVV8VijrF45QzRA6yNwVHujX4ontVUzbOm6E6uFaqvbneKWGByLbH
 MNgj3i/INyfOXaCgqUVFWXUru2WVzuIwttBYQLMUTNpwZdb7U65+4DLs0/XCxIA5jPQ/
 SWn1ZGME1AUu2EE0amkkbJUpzUmG/llgTncuKzoR4fhRILbERl0Z3x4rBq1L9plq2PeU
 CLd7Ouz6Q5FGtLGNE9XIOTYyKF3+6DqBI0E6uq4erEZANhDIo2dgUH8GBu5OETbQii+C
 tuFxHE1UyzSXtCs5TM2udigAlz/CpC60C4zev8GIPK5O4ZBqeNA9I04PkOWF7zA/zJHC Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugw0t37kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:36:15 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALEBt8c020169;
        Tue, 21 Nov 2023 14:36:15 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugw0t37k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:36:15 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALDnSN3005276;
        Tue, 21 Nov 2023 14:36:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7kt1fh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:36:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALEaBlV23331532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 14:36:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 771712004E;
        Tue, 21 Nov 2023 14:36:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47DAC2004D;
        Tue, 21 Nov 2023 14:36:10 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.5.131])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Nov 2023 14:36:10 +0000 (GMT)
Date:   Tue, 21 Nov 2023 15:36:08 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, jjherne@linux.ibm.com,
        pasic@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        david@redhat.com, Harald Freudenberger <freude@linux.ibm.com>
Subject: Re: [PATCH v2] s390/vfio-ap: fix sysfs status attribute for AP queue
 devices
Message-ID: <ZVzAWPzAFR5JV2jZ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231108201135.351419-1-akrowiak@linux.ibm.com>
 <17ef8d76-5dec-46a3-84e1-1b92fadd27b0@linux.ibm.com>
 <f18f6993-17e8-cab4-6a7f-059f669fc890@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f18f6993-17e8-cab4-6a7f-059f669fc890@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: y9aVtmIUTagj-7RJiy6ntd7-SdFUurzL
X-Proofpoint-GUID: 7J1_RtTdNV_bHcBsdJuS9BB7F6MsOe37
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_07,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=508
 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 10:16:10AM +0100, Christian Borntraeger wrote:
> I think this can go via the s390 tree as well. Alexander do you want to take it?

Applied, thanks!

I assume, it does not need to wait until the merge window?
