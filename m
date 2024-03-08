Return-Path: <linux-kernel+bounces-97179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A824876689
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7EC6B21643
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E93210D;
	Fri,  8 Mar 2024 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OYCh9/aT"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0775B4400;
	Fri,  8 Mar 2024 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909096; cv=none; b=Zmd1pzBjLm3KUndpURigNlAIKiepqamyyLz3Y27uBzG8ABuaGVAvh9S3njgktICYSXEcKuMmGwnQ3rHy5nZ4/lurS+k4VofxEz5QgtEX8G/B3YpenFFFYTBujFE3dyXK1EUVG0Xir+coBWkioUjwk6AcvyUFQAVfGli+R1Nepw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909096; c=relaxed/simple;
	bh=D5DUjp1tW/+gvyaRcPRqbMQ4vhu6x7pNv2ECqevSKT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASHvsiKatZ/8+36N3V5UkxF2w0kPlIkw7AoXftfbxVMSUtcCMSi8kV8HJOXAFanhsU69QP8/XYEa5COgeQAtHvjO2vYRWad4uULcBjyLxVzl7KEy8stGDip26L69OZlIzuMOXGS5pMFcnkshwCt6hv/aFL1p0bPvkHDYLr93Ivc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OYCh9/aT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428EYSUc007236;
	Fri, 8 Mar 2024 14:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=0XsPBrQ6qk46Lg2rFw8u91fbHtUJiwLkjPnktZHJZPs=;
 b=OYCh9/aTS9eShuDINZNFGyXvgM3PSwHuDMILI+PFAtbqpXZoxEkP0JvB26OQS/6pLiCJ
 ZRfOkyrYdHp7iqsp1TfTQADwbm/UGgWydM3cB+55FmjSeB75EKRNnrvZVwL4ZlAdy6P1
 CiX4vJpyqoyJXYH0MnnEqN31uvxOPodDHU3hQRGTIHaGphH/51OEwcRGGp1HUOOszt9c
 40qfNS+HPqSxK++gfY5PsGsU6PkVVtFc0n6EVU4pM92wQVgbFPX0Fg6lH2KJoChWiyhD
 tIAalv9DUIE3h0uimktiGnIURDTF6UMSVXpwhCM4G4O/xdutSYc7bo4Lbz3QpJ5nJ1wT mA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr4j0r614-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 14:44:45 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428DkgFJ010913;
	Fri, 8 Mar 2024 14:44:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52vgug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 14:44:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428EidUD21168792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 14:44:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C3C72004B;
	Fri,  8 Mar 2024 14:44:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC9DB2006C;
	Fri,  8 Mar 2024 14:44:38 +0000 (GMT)
Received: from osiris (unknown [9.171.32.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 Mar 2024 14:44:38 +0000 (GMT)
Date: Fri, 8 Mar 2024 15:44:37 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/6] s390: zcrypt: make zcrypt_class constant
Message-ID: <20240308144437.26074-G-hca@linux.ibm.com>
References: <20240305-class_cleanup-s390-v1-0-c4ff1ec49ffd@marliere.net>
 <20240305-class_cleanup-s390-v1-1-c4ff1ec49ffd@marliere.net>
 <84263def1d38584cd83558a33bb52f22@linux.ibm.com>
 <nh5d7ock5gb4zttfmq354si3iewm4u2zxqquzg3erl55jxjhuo@5yveroq4li4s>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nh5d7ock5gb4zttfmq354si3iewm4u2zxqquzg3erl55jxjhuo@5yveroq4li4s>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bS1TgzZ0LcUhZLvkew1eOnILrEd10Y0N
X-Proofpoint-GUID: bS1TgzZ0LcUhZLvkew1eOnILrEd10Y0N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=626
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080118

On Fri, Mar 08, 2024 at 11:38:14AM -0300, Ricardo B. Marliere wrote:
> > Thanks Ricardo, nice work.
> > The only thing I would do is to rename the label "out_class_create_failed"
> > with "out_class_register_failed".
> 
> Ah, indeed. Thanks for catching that. I will wait for more feedback on
> the other patches and send a v2 if required.
> 
> > 
> > Who will pick this patch? As this is part of a bundle of fixes, Richardo
> > do you have a way to push this into the kernel? Otherwise as the AP/zcrypt
> > maintainer I would pick only this patch and forward it to the s390
> > subsystem.
> 
> I have no ways of pushing this, sorry. The series is based on
> s390/linux.git/for-next, so perhaps the s390 maintainers can pick this
> one along with the others with your Acked-by: provided? :) 

I will pick up the whole series, but need some more time.

There is no need to send a v2 for this patch - I'll change the label as
requested by Harald.

