Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135F3805E11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjLEStU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbjLEStQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:49:16 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6408CD41;
        Tue,  5 Dec 2023 10:49:22 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5IjYYL016762;
        Tue, 5 Dec 2023 18:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=iDfqMsGgHo6OPb8fjdSSMrZs5hCYCoC6wwlPMgirfs8=;
 b=ZP++RQKOvnjYIOzDi4YafAJmH1o2eW+iIVpHjznMrHA3svvUZQ3eW4ghwRZxW50q83EM
 i7rsixrh0fAYsJsa8nxh9TjmEkN8FL8ssY+oKAruB8yyl2AeH+HQ0jsitlqU4Z2evHgM
 5egpbpR55ZFMYgaI4mdq4PPfgAC572WKnHLZ4t48uDALcLUa9H6bqB5EuplNXpQtvcEX
 uOA2r6/xE2tzepPaWRJ+HJ7IndtkHfy7JDKEEMEtYzCtDWR786hN7LEHAGspr/EClHiK
 xz1yG/WqkqfKN7Ofb24yMPlBeYCWJevcwqveO0sggPJcRLsSLQW2/7FdKDlnm1SSC9XU /Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ut9dwr3p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 18:49:21 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5GjLip022637;
        Tue, 5 Dec 2023 18:49:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urhm283h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 18:49:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B5InD4E23855626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Dec 2023 18:49:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E300E2004B;
        Tue,  5 Dec 2023 18:49:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B6ED20040;
        Tue,  5 Dec 2023 18:49:13 +0000 (GMT)
Received: from osiris (unknown [9.179.8.210])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Dec 2023 18:49:13 +0000 (GMT)
Date:   Tue, 5 Dec 2023 19:49:11 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        kvm390-list@tuxmaker.boeblingen.de.ibm.com, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, nsg@linux.ibm.com,
        svens@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com
Subject: Re: [PATCH v1 1/1] s390: mm: convert pgste locking functions to C
Message-ID: <20231205184911.5381-A-hca@linux.ibm.com>
References: <20231205173252.62305-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205173252.62305-1-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iPEPHnYiVzznPu8EI935PF8pJYs_6i2R
X-Proofpoint-GUID: iPEPHnYiVzznPu8EI935PF8pJYs_6i2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_14,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=550
 spamscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312050148
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 06:32:52PM +0100, Claudio Imbrenda wrote:
> Convert pgste_get_lock() and pgste_set_unlock() to C.
> 
> There is no real reasons to keep them in assembler. Having them in C
> makes them more readable and maintainable, and better instructions are
> used automatically when available.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/mm/pgtable.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
