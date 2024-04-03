Return-Path: <linux-kernel+bounces-130190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C7789752D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B29FB27592
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC15C150982;
	Wed,  3 Apr 2024 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sAjrqesj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD32814F122;
	Wed,  3 Apr 2024 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161523; cv=none; b=cKN9TTT8jhL+740h6rFhAvItUP+ioKeWA4gm2MQfTGq+ZUCwPZDovF99Rr6+Ki7se9ma9BIgC8r96/Tkj707v+PPUAcgGyG0v2xfm990y3DaftR0MD9QJxYVMIxo41qYmTKFNopPKV0U98YXA+W6Din73GWZOdS93K04IDgHTaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161523; c=relaxed/simple;
	bh=M2KSxX/qzBohwPJ02hVjKtTS/u8IGLEnJlpOLc775+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A4uFRn7AaCaSPnXdZuoAlQt2XCyqIexTOLALzFuOX8qsxVeg0HABotusZAqEfXgfyDMEgMSdi81hvMZzPXyQKXsvOSswQx7weSnB7u9qJXj4aZSx3zVrsX4gC/9pEwEp+vbQ5sEIRT/fsFMmCBfquI1S4+O2L5X7IisxvHD9MvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sAjrqesj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433G2mnG017749;
	Wed, 3 Apr 2024 16:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UqaB+wRnNOYEb2m53SzDiYd2Jvl8mk/TbCmsEno9obA=;
 b=sAjrqesjJ6yYZeiFMFjQW7W9xciDm/RAp2G44FYgyrNmsN74i9KhwHiFKZGvi+XZq39V
 eUn4H96aidg69kGQWvz9UdlDYiNz5tVLnueLVGzyASv+scU0wWR7qW9r/CghFpxrD5ai
 AOL01EG/FVBYwfoNH2y7XmRNqADoqlIxu6wUgy+a6f40p1318e15Mus+LGOVbGqcG9xa
 gGxFeTNqvRt8/v14QV2flcmpHQrKfixx3Sn4wdTMrOJawZlXFyhsL41dutaEVBY/U6Ay
 E27WUkn4sPhYtWug43OYjTR5p34ojzrUiWUeBwW0x1x1RKKE4KuhX6yklpUSL4md1Wt5 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9a9b02jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 16:25:16 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 433GPGRJ023481;
	Wed, 3 Apr 2024 16:25:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9a9b02jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 16:25:16 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 433EwYjc025753;
	Wed, 3 Apr 2024 16:25:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6x2peegv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 16:25:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433GP9PY25231958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 16:25:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C71F20065;
	Wed,  3 Apr 2024 16:25:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02BE52004B;
	Wed,  3 Apr 2024 16:25:08 +0000 (GMT)
Received: from [9.171.60.51] (unknown [9.171.60.51])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 16:25:07 +0000 (GMT)
Message-ID: <3122eece5b484abcf8d23f85d6c18c36f0b939ff.camel@linux.ibm.com>
Subject: Re: [RFC PATCH net-next v5 04/11] net/smc: implement some
 unsupported operations of loopback-ism
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com,
        jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 03 Apr 2024 18:25:07 +0200
In-Reply-To: <20240324135522.108564-5-guwen@linux.alibaba.com>
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
	 <20240324135522.108564-5-guwen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-2.fc39app4) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e-maJrEYK3CrbN1gUYBUw5wqMTnGJHjI
X-Proofpoint-ORIG-GUID: y1xl521ypI8S9m31iHqSuVR8sDJBb3t1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_16,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030112

On Sun, 2024-03-24 at 21:55 +0800, Wen Gu wrote:
> This implements some operations that loopback-ism does not support
> currently:
>  - vlan operations, since there is no strong use-case for it.
>  - signal_event operations, since there is no event to be processed=20
> by the loopback-ism device.

Hi Wen,

I wonder if the these operations that are not supported by loopback-ism
should rather be marked "optional" in the struct smcd_ops, and the
calling code should call these only when they are implemented.

Of course this would mean more changes to net/smc/smc_core.c - but
loopback-ism could omit these "boiler-plate" functions.

> =C2=A0
> +static int smc_lo_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int smc_lo_del_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int smc_lo_set_vlan_required(struct smcd_dev *smcd)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int smc_lo_reset_vlan_required(struct smcd_dev *smcd)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int smc_lo_signal_event(struct smcd_dev *dev, struct smcd_gid
> *rgid,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 trigger_irq, u32 event_code,=
 u64
> info)
> +{
> +	return 0;
> +}
> +

Just a pattern that I saw elsewhere in the kernel...

Thanks,
Gerd

