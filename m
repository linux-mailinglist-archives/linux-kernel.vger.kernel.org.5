Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143217512B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjGLVeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGLVeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:34:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFA4CF;
        Wed, 12 Jul 2023 14:34:16 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CLT9xh024767;
        Wed, 12 Jul 2023 21:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=I61+B3ltgikm/N5Uk7LdOLIV9Fjh4/slIA5ZKF4hq0w=;
 b=EPWHwxW7WI4uagpJg7Xu4Hernze4j+iGXiEOYfXzJdmqfAoMplAodO7+DAxAJYe+GTRa
 iUl+JmFTWxnJ+AnuyuJa6FITMhocQzqfymP9uev49rQA/7rLwHeWzxooPkpzLFowVXzg
 Lnd6MkPGOwUKBOG8GiNhjvbkwP/JIF8vJ5tQXA+5F+KzcR5bb+5gjv6MOq6nfAm7G3kS
 b+DLQlRdVZfur3kjGX/Ttm+QzXDZEynWNls8CNjsskpwVPd8UwTrQIoW6pN39BoRyqMv
 1OVO23aDnxOEd/9lVWzQYZNw/nKJFnVQRRhNoJIdKJXgxYDjj6g67nGJzJjaTtgJ8Oq5 aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rt44gr3qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 21:34:00 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36CLUV73028208;
        Wed, 12 Jul 2023 21:33:59 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rt44gr3pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 21:33:59 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36CJb8VK005847;
        Wed, 12 Jul 2023 21:33:57 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3rpye65jj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 21:33:57 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36CLXuYf36962674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 21:33:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9558E58058;
        Wed, 12 Jul 2023 21:33:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96F455805C;
        Wed, 12 Jul 2023 21:33:55 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.100.51])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jul 2023 21:33:55 +0000 (GMT)
Message-ID: <6ce8d8b5b6d4b59b113ee3d5224e9d3b4e1231d2.camel@linux.ibm.com>
Subject: Re: [PATCH v2] integrity: Always reference the blacklist keyring
 with apprasial
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Wed, 12 Jul 2023 17:33:55 -0400
In-Reply-To: <A9725ECB-0811-42BD-8586-7DF7A8BD7393@oracle.com>
References: <20230705225229.1435691-1-eric.snowberg@oracle.com>
         <6173db54e3d75481a6b1f1079c5b06e1c1caf564.camel@linux.ibm.com>
         <A9725ECB-0811-42BD-8586-7DF7A8BD7393@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1Bel5VZx89r6qEL14xxWAkhs0b1nVfu4
X-Proofpoint-GUID: BM5rE2yr4RTxKIb9fIUzhF7phjIli2YD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_15,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120190
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-12 at 21:12 +0000, Eric Snowberg wrote:
> 
> > On Jul 12, 2023, at 11:40 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Wed, 2023-07-05 at 18:52 -0400, Eric Snowberg wrote:
> >> Commit 273df864cf746 ("ima: Check against blacklisted hashes for files with
> >> modsig") introduced an appraise_flag option for referencing the blacklist
> >> keyring.  Any matching binary found on this keyring fails signature
> >> validation. This flag only works with module appended signatures.
> >> 
> >> An important part of a PKI infrastructure is to have the ability to do
> >> revocation at a later time should a vulnerability be found.  Expand the
> >> revocation flag usage to all appraisal functions. The flag is now
> >> enabled by default. Setting the flag with an IMA policy has been
> >> deprecated. Without a revocation capability like this in place, only
> >> authenticity can be maintained. With this change, integrity can now be
> >> achieved with digital signature based IMA appraisal.
> >> 
> >> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > 
> > Thanks, Eric.  Other than including "appraise_flag=check_blacklist"
> > when displaying the measurement list, it looks good.
> 
> Thanks for your review.  
> 
> I want to make sure I understand the request here.  Do you mean you 
> don’t want to see  “appraise_flag=check_blacklist”  when you cat 
> /sys/kernel/security/ima/policy?  Or are you referencing a change in the 
> /sys/kernel/security/ima/ascii_runtime_measurements list? Thanks.

The IMA policy rules as displayed via <securityfs>/ima/policy should
not contain  “appraise_flag=check_blacklist".

-- 
thanks,

Mimi



