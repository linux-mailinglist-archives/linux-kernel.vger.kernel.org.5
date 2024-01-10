Return-Path: <linux-kernel+bounces-22531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63462829F14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23ACB2696B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A704D581;
	Wed, 10 Jan 2024 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RJfDNQBA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B7B4F1ED;
	Wed, 10 Jan 2024 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AGPCg0015335;
	Wed, 10 Jan 2024 17:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zM7XUSd8Y2tio1BavZrFWOH4tGIFE7jU5+Azvnh3t/g=; b=RJ
	fDNQBAZ+EH6KMFGV/NwEgVTtL5yTtHgCB6X9ui1E+EsrPdLzOSeOpah55SHbs6YU
	rXFmf3Qh6vZp5EeQ/pgS2mnc5CQp1MgRHfQ1oGUX5lum6UtOBSiLFzBjV8kJGXpE
	ZNWpETJLE0UAglWRldBHMIEx7v3HzGZ1a05sphGLtx0vO68zgwVKXhj+a1DKknNB
	zTrHMABIe4RnD7N0QNA15/WZM5mDY29YOLL+dQrV6ZebznwqLUFd0ePjrlZbw+B/
	pARVYCN6MaJG8L3qzlWKn0pXiElXkRDKWQZIZLSLH1zJ252apMcgMlLBC5DrhhMq
	OPAFNmZltOrBOjmX2+gA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhvqw0g7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 17:24:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40AHOC31018464
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 17:24:12 GMT
Received: from [10.110.49.201] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 09:24:07 -0800
Message-ID: <fdf40fac-2884-426e-87f7-5cb1788616fb@quicinc.com>
Date: Wed, 10 Jan 2024 09:24:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] check-uapi: Introduce check-uapi.sh
To: Masahiro Yamada <masahiroy@kernel.org>
CC: Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers
	<ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Jonathan
 Corbet" <corbet@lwn.net>, <linux-kbuild@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, Carlos O'Donell
	<carlos@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann
	<arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>, Todd Kjos
	<tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida
	<gprocida@google.com>, <kernel-team@android.com>,
        <libabigail@sourceware.org>, Dodji Seketeli <dodji@redhat.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        Jordan Crouse <jorcrous@amazon.com>
References: <20231212020259.2451253-1-quic_johmoo@quicinc.com>
 <20231212020259.2451253-2-quic_johmoo@quicinc.com>
 <CAK7LNASZzeJzZV0hiMrcKd6FUtQXqfuvUqux8Bf+WvBmjCwNCA@mail.gmail.com>
Content-Language: en-US
From: John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <CAK7LNASZzeJzZV0hiMrcKd6FUtQXqfuvUqux8Bf+WvBmjCwNCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l5JGLIoJ9IVeazey9Op9u_gDU-7_WqWn
X-Proofpoint-ORIG-GUID: l5JGLIoJ9IVeazey9Op9u_gDU-7_WqWn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401100140

On 12/22/2023 9:50 AM, Masahiro Yamada wrote:
> On Tue, Dec 12, 2023 at 11:04 AM John Moon <quic_johmoo@quicinc.com> wrote:
> 
> The code looks OK. I think it should work as designed.
> 
> Line 197 is inconsistently indented by spaces instead of a space,
> but I can fix it up locally.
> 
> 
> I just thought requiring target commits as positional parameters
> ("check-uapi.sh treeA treeB" just like "git diff treeA treeB")
> might be intuitive, but I guess everything is specified
> by a short option is a design. I can live with that.
> 
> 
> 
> I will wait a few days, and if there is nothing more,
> I will pick up 1/3 and 2/3.
> 
> 

Thank you Masahiro! If anyone else has comments please let me know.

Cheers,
John

