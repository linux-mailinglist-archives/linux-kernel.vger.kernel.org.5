Return-Path: <linux-kernel+bounces-50045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F6F8473A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D201D28A250
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFAC1474CC;
	Fri,  2 Feb 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R3jBlFsX"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E451474C8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888919; cv=none; b=RwY2jezEy0HUL77w1pU9b+DJvWhfoB/0GpkYCUW0n2sEhb24J2KipE8LGIbYQizPDoQFENSTEzQN51arRBHjWSEgRjioe+0qwM2LwYa+X1gMO1nCFesuhnQY7x+bBRolPOLT8ZtlgpWb1txdRi9oynytq7j6OYOhDMD8XhvjrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888919; c=relaxed/simple;
	bh=5UJrbH6ZRN4kNuthN5UYTDRlbVX89oUehKj0D9FGXoI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AF4ih7knAObsf6H74A+Tia5TVnFcwNpnYbjc3Xaa/3usSGn2ckjQfApfSTrO/mYJ3FGS42DPLqox3tp5ZbuW/QtKsp/2OZApjEEnQIT/os3LWEFg0gSFx67mCmcCRbTggRA7wAIsceRXUpNjowt5801WlF8b8jxNeVgNHSOz4mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R3jBlFsX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412EDQAq014369;
	Fri, 2 Feb 2024 15:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=1ef4mOELuh88KqIagstx3A2AF2Vq8w0YGFedSZMdHPU=;
 b=R3jBlFsXoHhyX6T3rKUKn88b6Cl1VojB1OoqbpxRbp3lfWbhnKFKYVnXjzR8TdPSdOss
 g+6U4gWx1tc+f2PiqWguoxEn7kcUVdNpfCaQYVfld2VIcTd+uIWaxG+oIjWkl7cPCul5
 2wUfFoyCGawXRTDheJtLBf2yPtD3nDDQeGPapbU4lTBy6KMAlTU59mcYDStQIuVBDF7j
 Va8pG4AWeHIP/Lqi6oZbb5Ac4clHPhTaWvk8WpnSquytsG9CgjhjAEC/fth26SEVEJE5
 fpc7k/ScTmdHq0rQ2/rEjnzsyE8jvcsEb9JUfB1+ndE+ErEPCrJQV3P/FfG2HyZnHjxT GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w11yca83v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 15:47:57 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412FRZnX018586;
	Fri, 2 Feb 2024 15:47:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w11yca7ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 15:47:53 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 412D3CNa010496;
	Fri, 2 Feb 2024 15:47:20 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5pc5nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 15:47:20 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 412FlJdU22544918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 15:47:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7846158058;
	Fri,  2 Feb 2024 15:47:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E1D858057;
	Fri,  2 Feb 2024 15:47:14 +0000 (GMT)
Received: from [192.168.1.228] (unknown [9.67.185.238])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Feb 2024 15:47:13 +0000 (GMT)
Message-ID: <ad1a131a006bf98a506e767a01f5022358b3e291.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
From: James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, "Theodore Ts'o" <tytso@mit.edu>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Dave Hansen
 <dave.hansen@linux.intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner
	 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov
	 <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org"
	 <x86@kernel.org>,
        Kuppuswamy Sathyanarayanan
	 <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Nakajima, Jun"
	 <jun.nakajima@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, 
	Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "linux-coco@lists.linux.dev"
	 <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Fri, 02 Feb 2024 16:47:11 +0100
In-Reply-To: <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
References: 
	<CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com>
	 <DM8PR11MB5750797D0B9B8EB32740F55DE77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
	 <CAHmME9oC=GE-7QS2m9FA5cs_ss+tQgB9Pj3tKnTtMMFpQmUshg@mail.gmail.com>
	 <DM8PR11MB5750B861F7A105886AA5FCE4E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
	 <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
	 <20240131140756.GB2356784@mit.edu> <Zbpc8tppxuKr-hnN@zx2c4.com>
	 <20240131171042.GA2371371@mit.edu>
	 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
	 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
	 <20240201045710.GD2356784@mit.edu>
	 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ShPhA6Ky6HaXA1fIPMY4Y1vwgghlcoo9
X-Proofpoint-ORIG-GUID: iWF4rlzPIgjsVCLw-_PZOFXnNoSH4MJm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_09,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 mlxlogscore=867 clxscore=1011
 suspectscore=0 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402020115

On Thu, 2024-02-01 at 19:09 +0100, Jason A. Donenfeld wrote:
[...]
> Anyway, that's about where I'm at. I figure I'll wait to see if the
> internal inquiry within Intel yields anything interesting, and then
> maybe we can move forward with solutions (B) or (F) or (G) or a
> different Roald Dahl novel instead.

It's a lot to quote, so I cut it, but all of your solutions assume a
rdseed/rdrand failure equates to a system one but it really doesn't: in
most systems there are other entropy sources.  In confidential
computing it is an issue because we have no other trusted sources.  The
problem with picking on rdseed/rdrand is that there are bound to be
older CPUs somewhere that have rng generation bugs that this will
expose.    How about making the failure contingent on the entropy pool
not having any entropy when the first random number is requested?  That
way systems with more than one usable entropy source won't flag a bug,
but it will still flag up confidential computing systems where there's
a malicious entropy depleter.

James


