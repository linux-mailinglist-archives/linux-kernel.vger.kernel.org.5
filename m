Return-Path: <linux-kernel+bounces-123204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10208890472
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F891C285CB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984BE130E50;
	Thu, 28 Mar 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kolvcEWX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473054BCB;
	Thu, 28 Mar 2024 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641754; cv=none; b=eXALzYfKFCxDqvXJSSQraWvzRWOyFjnlUB7Gn5BW8Fx3Jltyq6jfruaEvjXrojJr7/XHq0HRlkWtUVv4LeKTMhgcaNp6dusRT1KRJFa9eWtzemPN8gSyOqFllKYzmZ1v2nqn/AcLr51vOj47RoDeMxDsQhYaPCTM/XX7KGyHtAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641754; c=relaxed/simple;
	bh=Yd+L1QfQn5v6eTEbWUAT4ptod70oCMTDA08xBm0v75s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kl3PRF8QCGlqI6cB2JA+Ov1ylCrwVvgBD88513BUcMEooKUz4Yf+eKHPavg3VsvoSYSQXG2PFVbl0J1gg8kw/3SkzRMhm6mvvQsXb8wYoKBSL7SCJEgjhzMpF0ISxzdEVJzczJf+P7AvNuxTB002Eg7FND4zFSdIyOly7cqzByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kolvcEWX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SCMHpM029979;
	Thu, 28 Mar 2024 16:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wA0aGtF7pfUFgVF+PxkYWrv7TedUijbGDdENsyX5AgQ=; b=ko
	lvcEWXQ+cSONt0QrNcfGX2I+aipfJmjAd57F/9FXL58aSPra8zcFgdKuJ8Z21nTf
	ketEXxlSqpWo/WTx8e6RQBE/QMU5yOl669saggIdbDUEgDNm6L9uOihE5R82qHol
	4WBMkxyD/udJAO90PQFnWvtkkOy5uge61LkeZ2rS8h3pF5+tvy5LBYWhZtN1QbQx
	48HxQbhUanOh9lgq07HjOlbT4z01aSyxxY4PnXgTbbWSW4x/sQmWJMdfw4XSrMfA
	Bt49OwX7tVVhm5icQppKo8Sipn3byK8GsRH+Sj7Fj+ajxM9ka3huOx9w/PWw6juH
	OEiCUmsnV7KLexfHeBMg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x54r61f2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 16:01:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SG1Z4S019666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 16:01:35 GMT
Received: from [10.110.124.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 09:01:34 -0700
Message-ID: <09fe8f18-7f68-4d5d-89e4-68c1e5487b05@quicinc.com>
Date: Thu, 28 Mar 2024 09:01:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] scripts: checkpatch: check unused parameters for
 function-like macro
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, <akpm@linux-foundation.org>,
        <linux-doc@vger.kernel.org>
CC: <apw@canonical.com>, <broonie@kernel.org>, <chenhuacai@loongson.cn>,
        <chris@zankel.net>, <corbet@lwn.net>, <dwaipayanray1@gmail.com>,
        <herbert@gondor.apana.org.au>, <joe@perches.com>,
        <linux-kernel@vger.kernel.org>, <linux@roeck-us.net>,
        <lukas.bulwahn@gmail.com>, <mac.xxn@outlook.com>,
        <sfr@canb.auug.org.au>, <v-songbaohua@oppo.com>,
        <workflows@vger.kernel.org>, Max Filippov
	<jcmvbkbc@gmail.com>
References: <20240328022136.5789-1-21cnbao@gmail.com>
 <20240328022136.5789-3-21cnbao@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240328022136.5789-3-21cnbao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Uyx3T4g92k3IzsT8Y3tgT1r8_KiCbe2B
X-Proofpoint-ORIG-GUID: Uyx3T4g92k3IzsT8Y3tgT1r8_KiCbe2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_15,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280108

On 3/27/2024 7:21 PM, Barry Song wrote:
> From: Xining Xu <mac.xxn@outlook.com>
> 
> If function-like macros do not utilize a parameter, it might result in a
> build warning.  In our coding style guidelines, we advocate for utilizing
> static inline functions to replace such macros.  This patch verifies
> compliance with the new rule.
> 
> For a macro such as the one below,
> 
>  #define test(a) do { } while (0)
> 
> The test result is as follows.
> 
>  ERROR: Parameter 'a' is not used in function-like macro, please use static
>  inline instead
>  #21: FILE: mm/init-mm.c:20:
>  +#define test(a) do { } while (0)
> 
>  total: 1 errors, 0 warnings, 8 lines checked
> 
> Signed-off-by: Xining Xu <mac.xxn@outlook.com>

if you are re-posting somebody else's work you need to add your own Signed-off-by

> Tested-by: Barry Song <v-songbaohua@oppo.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Huacai Chen <chenhuacai@loongson.cn>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>


