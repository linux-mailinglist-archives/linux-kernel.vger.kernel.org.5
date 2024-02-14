Return-Path: <linux-kernel+bounces-64787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68AD8542D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA841F2733D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2DB11193;
	Wed, 14 Feb 2024 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K+Tkm0Xi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC8AC153;
	Wed, 14 Feb 2024 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892477; cv=none; b=Wi79bYkj8/cjQMvY+pDW1ME4RMy9SaK9TGZxorZuMtW+Wup5uad4B33O8LDqn4OxX79DztmZn0S9SZmubfx1NZRA/yPR5QtFMFEkYsi2OtZ09noHGyQANdoOen5+GpbfsvD2OgR7hI+mqzpJrpIK9XwsuDoWWvcIX/sJaibfORY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892477; c=relaxed/simple;
	bh=eUr7guqISkL9cgUCdjzBliRbwwC9rTdALYdNfuR71Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DJn1Ji68dvGEDkclcau+wbUK/G2brdOB9pRBFwpD5duz6Gq5NgdI0pcn1g2X1tkb87hU6lvHNR6S9Lx5gPOsweKQKc0+dGCPNRiFoedZRuUrYOVN3VfxLtLtVUGmjUlt5ph8rZLxq5n6U3iwLV/19eAu3AxNBPXepPKCcO0zpx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K+Tkm0Xi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41E5lhae029536;
	Wed, 14 Feb 2024 06:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QXFKcU6cwm9/llQyHRKTX/LXTUeS+mwIXL79jmBiF3M=; b=K+
	Tkm0Xil1rPiW5YgVJzmTT3HP4m4lGZT/xbBFL9dXp2Zr/TqmtVcdrEhuy1WcMAWh
	1Wbtvbs1OBJF70QXIS+3/RhDRvshQkVga2zIODyy6yQyLctFDn3dVa2ceXMOm2YV
	jgTssp5VUhYMT4qlqHyt21iVcCOV67/3ACbg2VaAxz41Nhlae0QgZUKfFnsxEPZ1
	5lG6/K8kJC7xnLa2YgMCZBFWWWjbMGvgTJTj6tlBBiRst+9Nb5hFVfMeXsk2SmRz
	EISuWq3lzv6boWi7kO/AEZDph/vtq9cdk78ct/uqEykm+Wt14Hl92yGKQOBnpkCX
	m/Klo/TLTVWk3+jUB2fQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8eks8yex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 06:34:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41E6YGAm018067
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 06:34:16 GMT
Received: from [10.214.66.164] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 22:34:13 -0800
Message-ID: <bc1a5e36-1983-1a39-4d06-8062993a4ca4@quicinc.com>
Date: Wed, 14 Feb 2024 12:04:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/huge_memory: fix swap entry values of tail pages of
 THP
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>, <vbabka@suse.cz>,
        <dhowells@redhat.com>, <surenb@google.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        # see patch
 description <stable@vger.kernel.org>
References: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>
 <a683e199-ce8a-4534-a21e-65f2528415a6@redhat.com>
 <8620c1a0-e091-46e9-418a-db66e621b9c4@quicinc.com>
 <845ca78f-913b-4a92-8b40-ff772a7ad333@redhat.com>
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <845ca78f-913b-4a92-8b40-ff772a7ad333@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lnjyjyHGECX3FqfvHeBgIDMzSEvghKpQ
X-Proofpoint-GUID: lnjyjyHGECX3FqfvHeBgIDMzSEvghKpQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=815 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402140050

Thanks David.

On 2/14/2024 12:06 AM, David Hildenbrand wrote:
>>>
>>> Isn't there a way to bite the bullet and backport that series to 6.1
>>> instead?
>>
>> My worry is that, because of merge conflicts, not sure If It can end up
>> in inducing some other issues.
> 
> I can have a look this/next week. I don't recall if there was any
> particular dependency.
> 

That would help me...

>>
>> Although we didn't test THP on older kernels, from the code walk, it
>> seems issue persists to me on older to 6.1 kernel, unless I am missing
>> something here. So back porting of this series to all those LTS kernels,
>> may not be a straight forward?
>>
>> So, I am really not sure of what is the way forward here...
> 
> Again, if we want to fix this properly, we should first identify the
> commit that actually broke it.
> 
> If it predates folios, we'd need different fixes for different stable
> kernels most likely.
> 
> The big question are:
> 
> 1) Is it broken in 5.15? Did you actually try to reproduce or is this
>    just a guess?
> 

We didn't run the tests with THP enabled on 5.15, __so we didn't
encounter this issue__ on older to 6.1 kernels.

I mentioned that issue exists is based on my understanding after code
walk through. To be specific, I just looked to the
migrate_pages()->..->migrate_page_move_mapping() &
__split_huge_page_tail() where the ->private field of thp sub-pages is
not filled with swap entry. If it could have set, I think these are the
only places where it would have done, per my understanding. CMIW.

> 2) How did you come up with 417013e0d18 ("mm/migrate: Add
>    folio_migrate_mapping()")
OOPS, I mean it is Fixes: 3417013e0d18 ("mm/migrate: Add
folio_migrate_mapping()").

My understanding is that it a miss in folio_migrate_mapping() where the
sub-pages should've the ->private set. But this is just a
reimplementation of migrate_page_move_mapping()(where also the issue
exists, tmk).

commit 3417013e0d183be9b42d794082eec0ec1c5b5f15
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Fri May 7 07:28:40 2021 -0400

    mm/migrate: Add folio_migrate_mapping()

    Reimplement migrate_page_move_mapping() as a wrapper around
    folio_migrate_mapping().  Saves 193 bytes of kernel text.

Thanks.


