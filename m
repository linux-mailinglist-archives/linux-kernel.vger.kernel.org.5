Return-Path: <linux-kernel+bounces-97163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBC587664E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180051F21DF6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D4D4597E;
	Fri,  8 Mar 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MIdDJCe8"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CD54085D;
	Fri,  8 Mar 2024 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907868; cv=none; b=VAteCtlNTmv7C/+hQ69ipcGlozHMLTfSZCUo9mMsaogff8SZkTf0EgjvrmGaXTwNP+nlmqDqUe02iinoDT17Hk8BHoIzqLHfqLp8lSEn/slHJuNtc9X7bC0h/o/Iwxnyn9PZF4GQB9bCmJ5JBaZRYAXuxLg/onarC1PMZGstyFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907868; c=relaxed/simple;
	bh=vUVkDUD3axpCPicGPFgPYjPzEqrDMjih2pP6FKkcRr4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=YM6wrrU0BbPaeWQulO6kGsieFH6y3Jew0yyKzGBR1o1A3814Hl7F8SviJpN+WfmCmepj2NhGVp5xSiTah5+/dQcxK4k0koJJ4JzbUP318UDwSC0bv+pjadTBqQwHR+ma/wmPh7TeVy2tQpOQV2mQp5DRee1x4DtJnimoUYbyj7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MIdDJCe8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428E3142022572;
	Fri, 8 Mar 2024 14:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Vu/l+DQKZOYkXzuole393h6jwOeq6WLNrYugvlWstEs=;
 b=MIdDJCe8TloBPSI7ATMg0DqljqO6o+Cj9xE58nwdBQGBUk9O7dmHPcIQRkAQaHBhFf1d
 irzLoAUAV6rt1IlZ+Kn/IwLQl+LzjE8JdC3226RVZSf3eiyF2Y/zx9pxvmHWV4s06sxd
 wBmNXN53/5LSDhVgLNJbLZXsWISrff0CMbl0ciQdatgBa53WlHygGCr7whKtGb//op+u
 uQ5waxxGB7HH/m2LrsYZxS9EanyLwy7RQFKVj+gAI59NASIrW7TPP8W5zsczg0Utu/4m
 ILE2C+8oM8yEmVFZANuVH4ue+p7V3aRMfFPNfObB/FrMBZbxC3rGYok6F4xs/84tH/KZ XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr43k8dbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 14:23:21 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428E5Tiq032050;
	Fri, 8 Mar 2024 14:23:21 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr43k8db5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 14:23:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428D1e1u024185;
	Fri, 8 Mar 2024 14:23:20 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwsr50t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 14:23:20 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428ENHv130147044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 14:23:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9539A58077;
	Fri,  8 Mar 2024 14:23:15 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CEC958061;
	Fri,  8 Mar 2024 14:23:14 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.150.204])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 14:23:14 +0000 (GMT)
Message-ID: <f1228f212520c66a5f3610627a7e26f736b384c5.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 4/8] ima: Add digest_cache_measure and
 digest_cache_appraise boot-time policies
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        wufan@linux.microsoft.com, pbrobinson@gmail.com, zbyszek@in.waw.pl,
        hch@lst.de, mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
        dhowells@redhat.com, jikos@kernel.org, mkoutny@suse.com,
        ppavlu@suse.com, petr.vorel@gmail.com, petrtesarik@huaweicloud.com,
        mzerqung@0pointer.de, kgold@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 08 Mar 2024 09:23:13 -0500
In-Reply-To: <e10207bd82ee13fb088f9efc12e10a5478b6926d.camel@huaweicloud.com>
References: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
	 <20240214143525.2205481-5-roberto.sassu@huaweicloud.com>
	 <ed5df367582f0c5e212638a12204fd20fd8e46e5.camel@linux.ibm.com>
	 <e10207bd82ee13fb088f9efc12e10a5478b6926d.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sbd1D3lTwHVEAuySFdWdLc-bwqtzp6xI
X-Proofpoint-ORIG-GUID: HdjBFLw7vZvRLwMeX_MOwurbZ_0YdaAo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080115


> > > @@ -971,6 +1006,16 @@ void __init ima_init_policy(void)
> > >  {
> > >  	int build_appraise_entries, arch_entries;
> > >  
> > > +	/*
> > > +	 * We need to load digest cache rules at the beginning, to avoid dont_
> > > +	 * rules causing ours to not be reached.
> > > +	 */
> > 
> > "lockdown" trusts IMA to measure and appraise kernel modules, if the rule
> > exists.  Placing the digest_cache first breaks this trust.
> 
> The new rules don't prevent other rules to be reached, since they are
> 'do' and not 'don_t' rules.

My mistake.  These are just the rules for measuring or appraising the digest
cache lists themselves, not the actual policy rules for using the digest_cache. 
This should be fine.

Perhaps update the comment to reflect initramfs usage.


thanks,

Mimi


