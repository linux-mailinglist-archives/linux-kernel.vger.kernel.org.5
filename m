Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A3D780E18
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377762AbjHROgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377722AbjHROgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:36:37 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844703AAC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:36:36 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IEY1HQ024444;
        Fri, 18 Aug 2023 14:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=VHZQst/51t4Hw0asCQKzw174oRUnh9VJzoV4g9EwwHg=;
 b=GjxGqxNc62pvx3lDeGo2GR//RDm+LmK38/e1/RKc27zwuYb68UWiztAwvC6pzpQxq5D4
 e3dfYhnFqzxT+ksiB0A3bmoHt5/RVK3zqLTzEC0240+rDv674l3XO0kjDU0revMAyfPx
 MI20ZTnU4NGYsq0n0sCtp4HrE++4pnUWye6y7sx8bN4xauGpj3+9qJW6//uMI/SxGnDm
 NqTyn7X71J+afCMu2QXIbTaYRm86wpbI0a3Fm+Ars7hi34mCmwjb2Q6nc9djmvn+PazZ
 p3BNHeVCknhZ6LhFcxlV48CX8WnbaTcsGFWavhQKT7cdVX3mVIA1tNGTv+kivrS06wov mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjagqg4x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 14:36:28 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IEZ77o030736;
        Fri, 18 Aug 2023 14:36:28 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjagqg4vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 14:36:28 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37ICigYk018856;
        Fri, 18 Aug 2023 14:36:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3seq4273hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 14:36:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IEaPRs16581232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 14:36:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5EE92004B;
        Fri, 18 Aug 2023 14:36:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A6122004D;
        Fri, 18 Aug 2023 14:36:25 +0000 (GMT)
Received: from osiris (unknown [9.171.32.106])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 18 Aug 2023 14:36:25 +0000 (GMT)
Date:   Fri, 18 Aug 2023 16:36:23 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/1] checkpatch: recognise NOKPROBE_SYMBOL for blank line
 detection after function/struct/union/enum
Message-ID: <20230818143623.24849-A-hca@linux.ibm.com>
References: <20230120114649.117018-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120114649.117018-1-borntraeger@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x7kmo9uTFWfVpHdgsjdbuxqUmVYpZ8KI
X-Proofpoint-ORIG-GUID: 3hOQ8EswXQJ3ZI5iwrBzmszzXtxD9Ni1
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_18,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 mlxlogscore=754 spamscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180132
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 12:46:49PM +0100, Christian Borntraeger wrote:
> NOKPROBE_SYMBOL should be treated like EXPORT_SYMBOL to avoid
> false positives.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 78cc595b98ce..037acbcee0e1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3995,6 +3995,7 @@ sub process {
>  		    $line =~ /^\+/ &&
>  		    !($line =~ /^\+\s*$/ ||
>  		      $line =~ /^\+\s*(?:EXPORT_SYMBOL|early_param)/ ||
> +		      $line =~ /^\+\s*NOKPROBE_SYMBOL/ ||
>  		      $line =~ /^\+\s*MODULE_/i ||
>  		      $line =~ /^\+\s*\#\s*(?:end|elif|else)/ ||
>  		      $line =~ /^\+[a-z_]*init/ ||

Seven months later... Joe, is there actually anything that prevents this
from being merged?
You were the only one who replied back then:
https://lore.kernel.org/lkml/20230120114649.117018-1-borntraeger@linux.ibm.com/

And it is kind of not obvious what the result was.
