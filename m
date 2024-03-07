Return-Path: <linux-kernel+bounces-95669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA607875107
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856DA28CA8E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DEA12D740;
	Thu,  7 Mar 2024 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EeBnYTNQ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F912BF2B;
	Thu,  7 Mar 2024 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819695; cv=none; b=kKaudBCebhEDXNuA8RSrLCwujNN1j+Cqb1Sn6sOJBdIZXMbQdwKiLgGQwlfTjOQQMiXURFs9LjXPYegBriWCMO77y5jsYR/tZhEH9ElFdsqOIR0u6Z9mSEKXlNV6KxY5+8GFIHPL9aH/+lK+HsFE/MkPU/fCT30qnnQQOw+b4VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819695; c=relaxed/simple;
	bh=oEzl7dl6NWaRWrEUFGNrR8+6+KKJNgRHfwCX1+msrsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFg2PW5iyQQA1XY8UlqDbrPkpgVuGDbcnjiJnfmRG9A+0QHv9BF7KM+dc1iiz9q+mQLoNSMMLnTTiHIoOwA/MqSLVor0Yy4fyv/3mY96wm/HYw7/ESDkCkX+pg7UDL47DQxZcP0m6oSamLkbCaRttxedG1eX70dAZ+Izodf1VnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EeBnYTNQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427DsKZ9012325;
	Thu, 7 Mar 2024 13:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Fa/aGcMEgm8gDXNGJzDbzRC3uIbhDV9b2L9bU9ZV21E=;
 b=EeBnYTNQf7RO1doeHrsUODZ8MJOXa0jkGSaaFrTsWEJucmyYTgiTInZF5UYPkyTSNDc3
 d5cMsplAMxl7JsBUzknBKrtXtORj5MPBtKnR6Jatz3qC0ps7z/GGtx2FUzDk4ZzTfFMd
 ZX/MX3zM0xS5ckyzvkjEDJqeqSHdKsm4g+NKM0VOL8OVRuUrMXBBRyUDVCOUEveTJr2p
 CAjXvEYDQaW6mYM282ZRA8juqPloQZOQ42V48dm0rV+EfgVbShCeT+8It22qrK1D3Evi
 lKb3/IxB5Bb8vgTt5DZE+3jmru9AMDwHoqwdUnkOhztPewn9dU3+HCfIkh30yZWa2HGJ BQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqe3ja9g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 13:54:50 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 427DTO1M025396;
	Thu, 7 Mar 2024 13:54:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmetyx3ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 13:54:50 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 427DsiYQ11469084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 13:54:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9996B2004B;
	Thu,  7 Mar 2024 13:54:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D27A20063;
	Thu,  7 Mar 2024 13:54:44 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 Mar 2024 13:54:44 +0000 (GMT)
Date: Thu, 7 Mar 2024 14:54:42 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] s390/cio: Use while (i--) pattern to clean up
Message-ID: <20240307135442.33873-B-hca@linux.ibm.com>
References: <20240222134501.236871-1-andriy.shevchenko@linux.intel.com>
 <ZeXeBr5z8TrLbuCI@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeXeBr5z8TrLbuCI@smile.fi.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F1BYNmKUIttaDLjTHT1GOrFixZpv3BoS
X-Proofpoint-ORIG-GUID: F1BYNmKUIttaDLjTHT1GOrFixZpv3BoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=596
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403070087

On Mon, Mar 04, 2024 at 04:43:18PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 22, 2024 at 03:45:01PM +0200, Andy Shevchenko wrote:
> > Use more natural while (i--) patter to clean up allocated resources.
> 
> Any comments?

It is up to Vineeth and Peter to decide what to do with this.

But in general I'm not a fan of such patches. It depends on what people
prefer, and you can send literally thousands of similar patches where the
code looks "more natural" afterwards.

