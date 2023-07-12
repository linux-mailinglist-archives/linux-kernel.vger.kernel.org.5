Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6091B750FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGLRlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjGLRlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:41:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21E21980;
        Wed, 12 Jul 2023 10:40:58 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CHcYiP014845;
        Wed, 12 Jul 2023 17:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=4GxWEjvEv5Twr+uqJ2gvsf8uuNbg1yd7ft+BOI9rfXc=;
 b=i63FOm5sV41HH/jiZSCYycXnNW5JTP01UGN1HMOzheCPsA1FqntCqzO7YqU7d4qEfacW
 61x2FcatxKFEJ8FhMm+BJz3VQZsJ3FNN6a53nPoCeBHTcoFrWNoi6sOwQafKG8A0YZYk
 QP0JCSUxM+hZSI5PEvI+UpSfxa4Aq1xaroCp4VPiaV4v/1HrFHU5UeZP4JLlaTJuUm2b
 Ku7diif+2epZcRrvhxJpvNRFPuj786j8Vrf9ZfBcXA4Fi5u+60ntskwCG3pWNbYt+ZaH
 P1agTToYUbaXKvFv6hf2BxEbhPsKOBVlKY2KqwbBYWt/a+Fz8pTGS60UvXTfNVmZdHea 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rt0ejggsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 17:40:37 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36CHcnNa016467;
        Wed, 12 Jul 2023 17:40:37 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rt0ejggrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 17:40:36 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36CFG6Ql027318;
        Wed, 12 Jul 2023 17:40:35 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3rpye6cr15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 17:40:35 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36CHeYDR62980456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 17:40:34 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9006858055;
        Wed, 12 Jul 2023 17:40:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2F2B58043;
        Wed, 12 Jul 2023 17:40:33 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.213])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jul 2023 17:40:33 +0000 (GMT)
Message-ID: <6173db54e3d75481a6b1f1079c5b06e1c1caf564.camel@linux.ibm.com>
Subject: Re: [PATCH v2] integrity: Always reference the blacklist keyring
 with apprasial
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 12 Jul 2023 13:40:33 -0400
In-Reply-To: <20230705225229.1435691-1-eric.snowberg@oracle.com>
References: <20230705225229.1435691-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X4cOEriUldXrdCZUhBjrp-IAEXRya-0f
X-Proofpoint-ORIG-GUID: 5vpcSxvj7l7Qp4NdG5MdwqYtSH5NEvjf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120158
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-05 at 18:52 -0400, Eric Snowberg wrote:
> Commit 273df864cf746 ("ima: Check against blacklisted hashes for files with
> modsig") introduced an appraise_flag option for referencing the blacklist
> keyring.  Any matching binary found on this keyring fails signature
> validation. This flag only works with module appended signatures.
> 
> An important part of a PKI infrastructure is to have the ability to do
> revocation at a later time should a vulnerability be found.  Expand the
> revocation flag usage to all appraisal functions. The flag is now
> enabled by default. Setting the flag with an IMA policy has been
> deprecated. Without a revocation capability like this in place, only
> authenticity can be maintained. With this change, integrity can now be
> achieved with digital signature based IMA appraisal.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Thanks, Eric.  Other than including "appraise_flag=check_blacklist"
when displaying the measurement list, it looks good.
-- 
thanks,

Mimi

