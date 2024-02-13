Return-Path: <linux-kernel+bounces-63180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30108852BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6258F1C22F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A765921100;
	Tue, 13 Feb 2024 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k3WNDCip"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E91B273;
	Tue, 13 Feb 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815429; cv=none; b=WxxLRrIWWJJcbr8AK4z8O1lkAdpiZLp51FDCN7SV/ltoR6bHxkog1r4l1VhlGXqimps33XMEUCMANcEzks04kwVLBF3TgkBfSvP5MgQO+hQ7PA0/2yxl9onICYlF2FtAp+yNMryt2UpBTRpPj1wHXFluDcHnBt85oPCICBk18L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815429; c=relaxed/simple;
	bh=R8R7lZbqyir1X5V99j2RDN+30uNU2eW0kHTHyCiLY44=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k/ARKlWbDacaI27n8JayyUCNOBBW5aFbaibd2tbn9VY18gw+Uf6NPkDyv1zcAfVlLOforXNWVRFq+tS0IwIZt2LiFXVvoN0hh6IIyLUbC/0up8hldSv9bMOKrzyZIR/803xEq1bBJrRhsENJNN+wC7B4Yx7ZU8jbFehFTa2Ekz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k3WNDCip; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D90DcC024107;
	Tue, 13 Feb 2024 09:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=50qwoBL1qZUcAT1DGTn4Ldk2t5cnvbQ47VWB0Xov2Ag=; b=k3
	WNDCipSlVk/SSLwh7LmBCCTV2oUzK9QxNxIWKdrUiFlvvmIsVDIKBfunERblcIFH
	faaQi4JQvEIrFOTL3ukgpwrG8CDGM5BQfWc7IxFvn5X+0GwiSfb0f/+vZRJ1vLNy
	4shQMdWQfohXjM+rPJ93KFATaAHZtLnR0R2ZutF2Uk3vbSzu7qVRMHCwLBqz6oxj
	DvBuyVRihkheHh09mg19JzUvKfvlPw4+M2qARymF8Wen7LQ9V4KyvcoZxZTWVyut
	mkL1RyZA0SzpaCo+bn1hKAi/9xZZgrAFEzqSbZaRZdJLVKj+v32KHGbgb0f7lXp9
	xlbInF9TecfIv2CRq1IA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gse2hgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 09:10:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D9A8Ea032524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 09:10:08 GMT
Received: from [10.214.66.164] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 01:10:05 -0800
Message-ID: <50d61d66-e17c-55b9-23f4-ceea93e81e68@quicinc.com>
Date: Tue, 13 Feb 2024 14:40:02 +0530
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
To: Matthew Wilcox <willy@infradead.org>
CC: <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <vbabka@suse.cz>, <dhowells@redhat.com>, <david@redhat.com>,
        <surenb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        #
 see patch description <stable@vger.kernel.org>
References: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>
 <ZcsuLLhNPPylU-hi@casper.infradead.org>
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <ZcsuLLhNPPylU-hi@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bYcMl3QYj68A3s_ZMeMrEvrIklLd6DO1
X-Proofpoint-ORIG-GUID: bYcMl3QYj68A3s_ZMeMrEvrIklLd6DO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130071

Thanks Matthew!!

On 2/13/2024 2:24 PM, Matthew Wilcox wrote:
> I am deeply confused by this commit message.
> 
> Are you saying there is a problem in current HEAD which this fixes, or
> are you saying that this problem has already been fixed, and this patch
> is for older kernels?

Sorry, I meant this patch is __only for older kernels__. We are seeing
this issue on 6.1 LTS kernel.

At least I am not expecting this issue on the HEAD of the linux-next branch.

Seems the below message is not clear from my side to say that:
a) why this issue won't be seen on the latest kernel and
b) the problems associated with the respective patches in back porting
to LTS branch?

"On the recent kernels, this issues is indirectly getting fixed with the
series[1], to be specific[2].

When tried to back port this series, it is observed many merge
conflicts and also seems dependent on many other changes. As backporting
to LTS branches is not a trivial one, the similar change from [2] is
picked as a fix.

[1] https://lore.kernel.org/all/20230821160849.531668-1-david@redhat.com/
[2] https://lore.kernel.org/all/20230821160849.531668-5-david@redhat.com/"

IOW, the below couple of line is ensuring the proper swap entry is
stored in the tail pages which is somehow missed on the older kernels.

static void __split_huge_page_tail(struct folio *folio, int tail,
 		struct lruvec *lruvec, struct list_head *list)
{
     .............
+	if (folio_test_swapcache(folio))
+		new_folio->swap.val = folio->swap.val + tail;
     .............
}

Thanks.

