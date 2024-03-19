Return-Path: <linux-kernel+bounces-108235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4EE88082D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94037284626
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BBF5FB97;
	Tue, 19 Mar 2024 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MILY0DzQ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DD5FB87;
	Tue, 19 Mar 2024 23:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710890839; cv=none; b=cjHke/n+MKFDnFFkz/Cb4WW+oZTJYXBeF6X7IO7wtLLfZLU1/AHG4R7Shw8wzqvo+TA7uDggVJLwGIRuNGq00dY3fm7ePDYwJIewNoQAqMhHQvlwguq5Mw49r+TcqU5NK2ZH0OQSSgdX8+tECJhB1cYijocX5iFqWllk7f3aCME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710890839; c=relaxed/simple;
	bh=n9hJKPDTxTJEfGF00HWBydZQG0tQd8kHTr6mql/7gpY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=cMH0CZ9/Z6fof50dgcETM501kLBxLhvKcCRB3cMj4zFGyJiTvyfAwmiSpR5FLAleK68tbEXCuPAyZKFsqNUaHesd/vpAKPKg5wbXD2uDhddU3wYlcYKbQhVFmuh6VF4fiZt+LstpVVzdFOzX5TKYzflxPtqTod7o9nDP+sf2x0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MILY0DzQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JNBJDE005139;
	Tue, 19 Mar 2024 23:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KT4mNfO5o+rkVdaLLiWXiMPJK6QQlVazM68bG532oFk=;
 b=MILY0DzQUbBH/Zzhy4xhDfxLRNsWgXsRgdzYoSo7RaXJMMSk4QJ78CtyIzWJdxPZX11E
 7Mg8YDJf0gI04d9A3g6iZRo88sryRfn+SjBCax2r5aK5IXKb1iIlUjcZIZrIRSBqEtPo
 EKeTknIISJalWuve5+ZxUY+GpLDxuKoAdVTU8942YZCXGO6vol5QnrT8c3R4RlOYI3/x
 O0jVWP9e/YFvPNuDNdSL3lJ+ZJ/u7GsvfIir3A3zqoAwiTXg/3drPaAbXdPXfdizqc/s
 WKlCANpbo763pV4s/aCAhIQ1noOGYdNhBNICBoQ5uFh46Oa7IYMpQhEXfMhASPHgUxhK EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyhffga22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 23:27:03 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42JNR3te027009;
	Tue, 19 Mar 2024 23:27:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyhffga21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 23:27:03 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42JKRFYe002815;
	Tue, 19 Mar 2024 23:27:02 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2jajb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 23:27:02 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42JNQxjR21496396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 23:27:02 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0A675805C;
	Tue, 19 Mar 2024 23:26:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66EDC58058;
	Tue, 19 Mar 2024 23:26:58 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.80.83])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Mar 2024 23:26:58 +0000 (GMT)
Message-ID: <7f4a9464a5582e7f1b0feb180bb198b44bb278c0.camel@linux.ibm.com>
Subject: Re: [PATCH v3 08/10] evm: Enforce signatures on unsupported
 filesystem for EVM_INIT_X509
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, amir73il@gmail.com,
        brauner@kernel.org, miklos@szeredi.hu
Date: Tue, 19 Mar 2024 19:26:57 -0400
In-Reply-To: <20240223172513.4049959-9-stefanb@linux.ibm.com>
References: <20240223172513.4049959-1-stefanb@linux.ibm.com>
	 <20240223172513.4049959-9-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: MV5-4AaJmUZr_ILvF1ZFbSmYl5l6Ejj4
X-Proofpoint-GUID: cDOQUTGmD65oKLSwel36uzjFzk1A7WtH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403140000 definitions=main-2403190180

On Fri, 2024-02-23 at 12:25 -0500, Stefan Berger wrote:
> Unsupported filesystems currently do not enforce any signatures. Add
> support for signature enforcement of the "original" and "portable &
> immutable" signatures when EVM_INIT_X509 is enabled.
> 
> The "original" signature type contains filesystem specific metadata.
> Thus it cannot be copied up and verified. However with EVM_INIT_X509
> and EVM_ALLOW_METADATA_WRITES enabled, the "original" file signature
> may be written.
> 
> When EVM_ALLOW_METADATA_WRITES is not set or once it is removed from
> /sys/kernel/security/evm by setting EVM_INIT_HMAC for example, it is not
> possible to write or remove xattrs on the overlay filesystem.

This paragraph is currently correct, but at some point EVM_ALLOW_METADATA_WRITES
will be deprecated.  Refer to commit 1434c6a1d32a ("evm: Deprecate
EVM_ALLOW_METADATA_WRITES").

Mimi

> 
> This change still prevents EVM from writing HMAC signatures on
> unsupported filesystem when EVM_INIT_HMAC is enabled.
> 
> Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>



