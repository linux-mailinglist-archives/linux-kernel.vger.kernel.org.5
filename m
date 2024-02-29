Return-Path: <linux-kernel+bounces-87708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F6886D804
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD284B22257
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C21113E7D6;
	Thu, 29 Feb 2024 23:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kX4brMjo"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D2A16FF51
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709250342; cv=none; b=GAZ3NxLMDsqi0RwBUYd1atLzQjxd59J+U6j9/Xzm0jCFCk8pV5yR9M5+bOyE2VZ/WoQYw6jzJqBm8962N0ErwbdFxnXX0R10w6YXd0XWO2viRXsx96NF92fbzzCpdgeO6k1ewIzo7Jg/6xgjHj0jUnbaGeyIfj1IxG/8wTpt4GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709250342; c=relaxed/simple;
	bh=lQZDwo7pNYetMYwpB3CLHJ/+PW0KEucA/7RaMYYnuTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kd0LNvVhRHYZ6R25IhLj0LaL6q20w3GdhmCDvcVaN6Jy4OwQ1PP7df7yB0s1AqDjN4fKIKdUfGwZpTgAQwuTTPjdvv6wbRV4OsaHX6MqoDmyyQpw2qGlfpNvk02MskL+h+gHcUtvzthQLTuOZb/5KpdNTiNaUT8JKyh/SBi74nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kX4brMjo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41TNWlOH010226;
	Thu, 29 Feb 2024 23:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=lQZDwo7pNYetMYwpB3CLHJ/+PW0KEucA/7RaMYYnuTc=;
 b=kX4brMjoz9GU4Ua7wF7C3LO3d0+LpWRXWcHL979m82x2aYuGyQsMayFihDQbBqihP0Qh
 dM9OkKHAi+YwngaZBX5C5jGLRk2/dBWq/jUV/4lacEntPIPtgl7/IUVWCMAFCD2nNTjf
 4lQiNffnATGq/ASD6r81bXFpaZzy3RTzmzblqEyUcoZOc9oS6iu8Yr52NtqwxcKNxQmE
 28rhRpTGvht0OUKtp/EHDX8cPMVysF7Zm2Oz0aGEtQuqhn+dgwOmd/Z/Fvc2w/11wVio
 KCdPCgyAS77P6EQOmN/YnwihW3DCM5mCGWRZ4pMZ3Hz/nWn+Bwt7tiuBlaLS/OxExmYm WA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk3pkr7vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 23:45:36 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41TMA2D6021267;
	Thu, 29 Feb 2024 23:45:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfuspgxdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 23:45:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41TNjVfK000648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 23:45:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CDBC20043;
	Thu, 29 Feb 2024 23:45:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8B6E2004B;
	Thu, 29 Feb 2024 23:45:30 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 23:45:30 +0000 (GMT)
Received: from localhost (unknown [9.66.77.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id DCE2A60064;
	Fri,  1 Mar 2024 10:45:26 +1100 (AEDT)
From: Michael Ellerman <mpe@linux.ibm.com>
To: Sachin Sant <sachinp@linux.ibm.com>
Cc: Tasmiya Nalatwad <tasmiya@linux.ibm.com>,
        "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [netdev] Build failure on powerpc
In-Reply-To: <916F09F9-FC10-4248-BE64-9E01AA264CBA@linux.ibm.com>
References: <8294bf9a-d175-4d86-b6df-9c409108cbf1@linux.vnet.ibm.com>
 <875xy8103a.fsf@mail.lhotse>
 <916F09F9-FC10-4248-BE64-9E01AA264CBA@linux.ibm.com>
Date: Fri, 01 Mar 2024 10:45:23 +1100
Message-ID: <87il26g7ho.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vHsBYj5vATN-KdEmopV5fJmGr-eMjc2A
X-Proofpoint-GUID: vHsBYj5vATN-KdEmopV5fJmGr-eMjc2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_06,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=669 impostorscore=0 adultscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290185

Sachin Sant <sachinp@linux.ibm.com> writes:
>> On 29-Feb-2024, at 7:52=E2=80=AFAM, Michael Ellerman <mpe@linux.ibm.com>=
 wrote:
>> Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com> writes:
>>> Greetings,
>>>=20
>>> [netdev] Build failure on powerpc
>>> latest netdev 6.8.0-rc5-auto-g1ce7d306ea63 fails to build on powerpc=20
>>> below traces
>>=20
>> Please include the defconfig you're building, and the toolchain
>> versions, in reports like this.
>>=20
>> I wasn't able to reproduce this failure here.
>
> I believe this is tied to gcc version.=20
>
> Build failure is seen while using gcc-8.5.x but not with gcc-11.4.x

Thanks. Yes, I see it here with 8.4, and 9.5, but not 10.5.

cheers

