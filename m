Return-Path: <linux-kernel+bounces-122039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A66B88F113
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F48B230AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBCF153588;
	Wed, 27 Mar 2024 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PYN9fpsO"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E0B14D45E;
	Wed, 27 Mar 2024 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575508; cv=none; b=eq+DUfACvS/jditN4RvF4uGI7T1/iZC1iggGbUz63tnsOsfb1S92JSo2o4pyZByKrZnv8Vn02n4AsIHPXwoGO5MtnyckD+DNlOvHsbdeeTBlPGlqXzTbr2dBQhjdvSEjIP7OfzR+WvFD5Z12khbnOUrlgPHepGEDmh0xSl/+VUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575508; c=relaxed/simple;
	bh=E46rS6DyZmgWjFTs2IiXMR5Dedgyiw2lergIZcqtSws=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=hGAz6T7UPfwaK58CmSMrgs0/2GvVr3KBz+516elGbOU8WPhO8ay6QYMIAwKngHYGS0+D055Snmrm3iT252Tw6EDHDF8GJLG+jxKQLEV6V6d7YSDuuKM8Grr/oDPCMXBLAUE1Cd265oHBVkCPLzYwMJPOQwa+oAJbKfvv0li/Nho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PYN9fpsO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42RLcDj0020492;
	Wed, 27 Mar 2024 21:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : in-reply-to : references : content-type : date :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ReoEszQrwUGqXYrgmhSzYi1cHR7YwjwuX0hpchvcg3g=;
 b=PYN9fpsOnNBMVgss0OKLnZJR3K2T5JBpKmBHhC1h7GL7v0SJ6bOXx/1mqjZdjac69ABx
 Lwv7JX/Ijm5KjoWkTrWwCx7VE372CreKn4cad9p5a6zZENrK4nULYm81bNCTEQJEMUQI
 gOQdoNSGIchfPEI/dWAt0wyEv/KQalu6M00Inw47yd2UOXL+/oa6sbhQFBRQeMYjZFU2
 lqCmL0usbh098xu5vaUhxdONaI7xNaXFSbO46hrIsz5HpoONDLB3MbqRzHl4SvqNoJmf
 sy+Rqwt5QG2OMIx2RBGvnd19rBp5KA+alHYSHsSAclgQ4KE118PAGeQCagsjK2UfVXnJ XA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x4ufc0090-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 21:38:13 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42RJNfEX028620;
	Wed, 27 Mar 2024 21:38:12 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adphecq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 21:38:12 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42RLc9aG39256584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 21:38:12 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B59F858060;
	Wed, 27 Mar 2024 21:38:09 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED5E05803F;
	Wed, 27 Mar 2024 21:38:08 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.watson.ibm.com (unknown [9.31.110.109])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Mar 2024 21:38:08 +0000 (GMT)
Message-ID: <80b2e479bc0c520423885a16dd46e0201a1c9418.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: define an init_module critical data record
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-integrity@vger.kernel.org,
        Roberto
	Sassu <roberto.sassu@huawei.com>,
        linux-kernel@vger.kernel.org, Ken Goldman
	 <kgold@linux.ibm.com>
In-Reply-To: <D04OU424128P.22TP02GW2CJCT@kernel.org>
References: <20240327150019.81477-1-zohar@linux.ibm.com>
	 <D04OU424128P.22TP02GW2CJCT@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 27 Mar 2024 17:37:57 -0400
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9Iy7kmUzA82cNmVKfLSL1jGoLpxmXH_g
X-Proofpoint-GUID: 9Iy7kmUzA82cNmVKfLSL1jGoLpxmXH_g
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_18,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270154

On Wed, 2024-03-27 at 18:54 +0200, Jarkko Sakkinen wrote:
> On Wed Mar 27, 2024 at 5:00 PM EET, Mimi Zohar wrote:
> > The init_module syscall loads an ELF image into kernel space without
> > measuring the buffer containing the ELF image.  To close this kernel
> > module integrity gap, define a new critical-data record which includes
> > the hash of the ELF image.
> > 
> > Instead of including the buffer data in the IMA measurement list,
> > include the hash of the buffer data to avoid large IMA measurement
> > list records.  The buffer data hash would be the same value as the
> > finit_module syscall file hash.
> > 
> > To enable measuring the init_module buffer and other critical data from
> > boot, define "ima_policy=critical_data" on the boot command line.  Since
> > builtin policies are not persistent, a custom IMA policy must include
> > the rule as well: measure func=CRITICAL_DATA label=modules
> > 
> > To verify the template data hash value, first convert the buffer data
> > hash to binary:
> > grep "init_module" \
> > 	/sys/kernel/security/integrity/ima/ascii_runtime_measurements | \
> > 	tail -1 | cut -d' ' -f 6 | xxd -r -p | sha256sum
> > 
> > Reported-by: Ken Goldman <kgold@linux.ibm.com>
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  security/integrity/ima/ima_main.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/security/integrity/ima/ima_main.c
> > b/security/integrity/ima/ima_main.c
> > index c84e8c55333d..4b4348d681a6 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -902,6 +902,13 @@ static int ima_post_load_data(char *buf, loff_t size,
> >  		return 0;
> >  	}
> >  
> > +	/*
> > +	 * Measure the init_module syscall buffer containing the ELF image.
> > +	 */
> > +	if (load_id == LOADING_MODULE)
> > +		ima_measure_critical_data("modules", "init_module",
> > +					  buf, size, true, NULL, 0);
> 
> No reason not to ack but could be just as well (passing checkpatch):

Please review the tag usage as defined in 
https://docs.kernel.org/process/submitting-patches.html.

> 
> 	if (load_id == LOADING_MODULE)
> 		ima_measure_critical_data("modules", "init_module", buf, size,
> true, NULL, 0);
> 
> < 100 characters

From what I understand, it's still preferable to stay under the 80 character
limit, but checkpatch.pl will not complain.  From 
https://www.kernel.org/doc/Documentation/process/maintainer-tip.rst:

"The 80 character rule is not a strict rule, so please use common sense when
breaking lines. Especially format strings should never be broken up."

> 
> > +
> >  	return 0;
> >  }
> >  
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks!

Mimi


