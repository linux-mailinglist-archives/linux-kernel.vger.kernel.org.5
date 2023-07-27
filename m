Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECA3765A68
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjG0Rel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjG0Rej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:34:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D223730E1;
        Thu, 27 Jul 2023 10:34:35 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RH3Q53010927;
        Thu, 27 Jul 2023 17:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=b1yT2kjr3CfqZGpukbGWQyFlNKOuqm/gluqOWykxj+w=;
 b=ksllpvp++DLS65B56txnLjeBd9PdwDnrTvvChEyrILWhf2+wOXijEWO0pkxrMFyRdGLG
 5ubNfK/XrQVo0/HgkBhQo9iKq33yvzf//zvCb/HHZjJzCmZ4hC3yW9gQCSWJQGYHWusD
 RN3GwSwIBCXQ6rF0HqaJ2QCGIF6MYWicY9IRyuw3rHqrXBKl1yh+5jXToisecGQdWRMv
 JJhMaKQH+cvY69gPXGmG5VJ5M+w6QRKGPfxt+hqF/K18TRXIvPcj47bS6qlO03PoH+bv
 W5Sb+tcopDtS2vyK7H1PMtX9dfFIeYhi1hxs7r3AgQW+PRiKtEHzuyu7bpX7sPag0y9B Fw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3v12tjgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:34:34 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36RGW9es002132;
        Thu, 27 Jul 2023 17:34:33 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0unjy2a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:34:33 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36RHYXUa60555574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 17:34:33 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D26258055;
        Thu, 27 Jul 2023 17:34:33 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5B4F58043;
        Thu, 27 Jul 2023 17:34:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.140.89])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jul 2023 17:34:32 +0000 (GMT)
Message-ID: <dc76cbf58bad422bf18de0d954c52b3a022e4199.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>,
        "linux-integrity @ vger . kernel . org" 
        <linux-integrity@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Date:   Thu, 27 Jul 2023 13:34:32 -0400
In-Reply-To: <20230711164447.714035-1-nayna@linux.ibm.com>
References: <20230711164447.714035-1-nayna@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HPvSWOS_u0VhrEDVULeL2y3x0_OZxJo-
X-Proofpoint-GUID: HPvSWOS_u0VhrEDVULeL2y3x0_OZxJo-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 mlxlogscore=664 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270159
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-11 at 12:44 -0400, Nayna Jain wrote:
> Time to remove "IMA_TRUSTED_KEYRING".
> 
> Fixes: f4dc37785e9b ("integrity: define '.evm' as a builtin 'trusted' keyring") # v4.5+
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Thanks, Nayna.   The patch is now queued in next-integrity-testing.

-- 
thanks,

Mimi

