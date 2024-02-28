Return-Path: <linux-kernel+bounces-85269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052DB86B33D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABC81F241F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983A415CD4D;
	Wed, 28 Feb 2024 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SYKdGNXZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696CF73515;
	Wed, 28 Feb 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134615; cv=none; b=gezZtcPHObskQFCyTByU62cybkwltmFp83cNXQEHNyazQdpAw3un6Ayx+QA7X/y3VOv106qkX284KVL4BrK/qd2trjoEFkBcWIaPUmWklDJrypiAnSiCZmhvZ/wrB8f03Lw/H9WkT21PTyGepl3doYGyBc7+fAr+D+LEbjnK25Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134615; c=relaxed/simple;
	bh=oppvgGkmN+5BSfIdEQzSl7am8hiJSjwTgH3zq3ioVBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CtyHZAmYRd9LaVYvWbFxXzlqy3sBe56AliZP1qG60LpXdcSTW2AAqjlrZ5Nt6xRxhTV+G+ds3ytqlQbJ2y41zBE0S7+Edu37oiJySQuj2RhnbMKWRZ8sO6A0IWNGZBqA7MUIERBuqj36ncNc3fvVp9mMTK1p5s1Hetpuvxp3Uac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SYKdGNXZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SDd9vi008537;
	Wed, 28 Feb 2024 15:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rzh7fFKDHPXXBiFPuiszpKYf6i6kw5PNZfcDhIT104g=; b=SY
	KdGNXZgrPZXVr+9BRHFyUy78XbJmIkyTvZ7gXMjPeu/SFyoVJjxC1ESOY6FobeiT
	I4Tfkug2ynU9bUZkt07rm8K75dYfX38boPkRbHJZEj9rFsNprDSd10ngubbeKCDM
	jt7MShm1QfQk83GucwGKdxoJFWT1Kt6rB2KxO3OfUByaswDLgYFDxlC4ZmBadJND
	jkeTOc2Cub8svfkhQqIW8hgpYZD0N7FJxBgA3e3Pe/VxXUKuF9jvY/2G8oaKtDnz
	wccOeIdftI01zvXsImb2t/sJmJQWtR6lMnVze7g52WrWQcrwi10TpwSFTcScUX4k
	XqX/v42Xcw08GhQQKO0w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj5wc8a9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 15:36:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SFaRXo005518
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 15:36:27 GMT
Received: from [10.216.4.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 07:36:23 -0800
Message-ID: <acdf3d44-b20e-8491-6302-bfb1b354bc62@quicinc.com>
Date: Wed, 28 Feb 2024 21:06:19 +0530
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
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>
CC: Matthew Wilcox <willy@infradead.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <surenb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        #
 see patch description <stable@vger.kernel.org>,
        Huang Ying
	<ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>
References: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>
 <a683e199-ce8a-4534-a21e-65f2528415a6@redhat.com>
 <8620c1a0-e091-46e9-418a-db66e621b9c4@quicinc.com>
 <845ca78f-913b-4a92-8b40-ff772a7ad333@redhat.com>
 <bc1a5e36-1983-1a39-4d06-8062993a4ca4@quicinc.com>
 <ZczLoOqdpMJpkO5N@casper.infradead.org>
 <f2ad5918-7e36-4a7c-a619-c6807cfca5ec@redhat.com>
 <30ea073d-0ccf-46e1-954d-e22f5cbf69f7@redhat.com>
 <1ABD022A-35FC-4A6E-ADAD-36F3D745FB91@nvidia.com>
 <42be658c-cb13-4001-aae4-8d8275a84038@redhat.com>
 <ECEF5EF8-3328-43AD-9E0B-7AE325368CB7@nvidia.com>
 <07A26237-B17E-4418-9A19-E86F450B9695@nvidia.com>
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <07A26237-B17E-4418-9A19-E86F450B9695@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3DgsQ5K6CdeE7HoNgVxwNN7q32GPa0T7
X-Proofpoint-ORIG-GUID: 3DgsQ5K6CdeE7HoNgVxwNN7q32GPa0T7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_07,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280121

Thanks David/Zi Yan,

On 2/27/2024 9:45 PM, Zi Yan wrote:
> So likely we'd have to fix the stable kernels:
> 
> 4.19
> 5.4
> 5.10
> 5.15
> 6.1
> 
> That's a lot of pre-folio code. A backport of my series likely won't really make any sense.

So, I assume this is a consensus to have stable-only fix for this issue.

> 
> For v6.1, the fix would like below?
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c93dd6a31c31..c5968021fde0 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -423,8 +423,12 @@ int folio_migrate_mapping(struct address_space *mapping,
>         if (folio_test_swapbacked(folio)) {
>                 __folio_set_swapbacked(newfolio);
>                 if (folio_test_swapcache(folio)) {
> +                       int i;
> +
>                         folio_set_swapcache(newfolio);
> -                       newfolio->private = folio_get_private(folio);
> +                       for (i = 0; i < nr; i++)
> +                               set_page_private(folio_page(newfolio, i),
> +                                       page_private(folio_page(folio, i)));
>                 }
>                 entries = nr;
>         } else {

Similar to this is what we had tested[1] internally and observed no issues.

Can this be taken to 6.1, please?

[1]https://lore.kernel.org/linux-mm/8620c1a0-e091-46e9-418a-db66e621b9c4@quicinc.com/

Thanks,
Charan

