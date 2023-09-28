Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEBE7B1E38
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjI1N0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjI1N0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:26:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EF619C;
        Thu, 28 Sep 2023 06:26:42 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SDNYgv003097;
        Thu, 28 Sep 2023 13:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=lmpzlY8g9RwccYcbPjBKo8rq9uQJ8dBjwPUEqyL4qCQ=;
 b=BzF3+koZptecuNaiVQkPn7zaWaKx0470/zzUa3RItEkZni6dnHtE8jLJi5O3LvqVJUuk
 OcjTAixgzCiPt5M8MoHpvcgE2fE2CdcDROO7emi7ty1v3HBCNvOGP5X0ymZ4IPcPSnMX
 1iYXuWLgjHhjoca+nKs8Uz/lowbJjTdMsl/GCPMDzUEjnNLMpG2yLgBSngoVC/8xjx4q
 cDwG1/QgjrOyucLID8paDhrqi00M4lzniME3eG6Ut3HNWjNVik/k8VfU2LUYOO+4ITRe
 WR3pDFqZLJDp2xixZGeycdSRt5CCHAIsVN2Z6d1I/1IaOLT836PuQrUK+OfG108LHeyZ Pw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdab480eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 13:24:30 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38SCRPnx030746;
        Thu, 28 Sep 2023 13:24:29 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjkc6gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 13:24:29 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38SDOT3k6685276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 13:24:29 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2EEB58059;
        Thu, 28 Sep 2023 13:24:28 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECDC65805D;
        Thu, 28 Sep 2023 13:24:27 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.144.155])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 28 Sep 2023 13:24:27 +0000 (GMT)
Message-ID: <2d5b7e1a55161588d7070657b52398cf583bfb9d.camel@linux.ibm.com>
Subject: Re: [PATCH] scsi: Clean up errors in sni_53c710.c
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     chenguohua@jari.cn, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 28 Sep 2023 09:24:26 -0400
In-Reply-To: <11d7b9cb.88b.18ad5c91580.Coremail.chenguohua@jari.cn>
References: <11d7b9cb.88b.18ad5c91580.Coremail.chenguohua@jari.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pdFhTl0EVKQhX8sG9t2NDHot6hEKzF3U
X-Proofpoint-GUID: pdFhTl0EVKQhX8sG9t2NDHot6hEKzF3U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_12,2023-09-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=590 priorityscore=1501 clxscore=1011 spamscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309280112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-27 at 16:37 +0800, chenguohua@jari.cn wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: space required before the open parenthesis '('

checkpatch is advisory, not mandatory.

While we usually fix its errors and warnings on current patches,
checkpatch changes over time and code it once accepted sometimes no
longer passes.  For that reason we don't accept patches to in-tree
files which now fail checkpatch because there are a huge number of them
and it generates an awful lot of churn which ends up either causing
bugs or interfering with current development.

Regards,

James

