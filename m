Return-Path: <linux-kernel+bounces-133760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7673589A83D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E7B1F21F19
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AD610A1A;
	Sat,  6 Apr 2024 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="axxW+Jqh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84072119;
	Sat,  6 Apr 2024 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366970; cv=none; b=dllfGreAn5Wx+znu7mGEBEBTv4WAIJl4V49KNAD7T/xXyZB7XL8RFC54Ny3zpgD5ozP9x6S/YEFmtcuBqm02CccnRL0RvvVsCcL37ePmUHtSlFwFjVNn3/s4sV9CwxfwOwn7J31dvE0UVa+aH0NxH1+EfI0T3Eu+W3eXXYgspZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366970; c=relaxed/simple;
	bh=dv6A4hoBJMNm5OFald/HPKZC9gQreHTjR6Gbz6PETEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fNR0D/E1Mao81V1hoSnZ43MTnizgmZW91UT1y1ziCQYTd/VVS2FfLmR1WJ1N1QAJhUWZPEpWWOBnubbpjxHt4gSwHAIcJwCE5+khqtUHYJx/FHQ62ZLlm+g0Gmkhqj2ljOS2dXTjgOmoBpkj2jY8RAoGUK7XgdpurfFWGu0C5xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=axxW+Jqh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43617a3r001838;
	Sat, 6 Apr 2024 01:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pJIDmkv+nhCUT5XuKD+cJ5b+mKtAThVKkZ2VMYhos5E=; b=ax
	xW+JqhDFXcCxciKu1S22bmTez61Rvasi9HNzsMr1iic9i8P9j5ohL+PC0GD2t132
	lnN+H93KF83FuO/iWBDQ/j/4zZSSnhLm0kUiIebfwgQPu9v03AdLx+9gXEs5VYwe
	U00R3t18o1/X7v94s6zhneqZzVgBClHwL42qVr9UQodJLgd36OtDosEHXV/hiN5Y
	THt456pFneZ6UPCMp4Z110L4YXXDhuWiQ/S+qo2RupiJUipK5uCjHHfIjMS88k28
	LKsd+1oCsUEBmrjkp5e+A/BbjEmAsBhY+JynzlKRXGbKJ+Hy9x1noL5JX+LqiCFz
	rKTz6SbbAr7ycAwqU5Xg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xaver813p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Apr 2024 01:29:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4361T4Q4029823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 6 Apr 2024 01:29:04 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 18:29:03 -0700
Message-ID: <e1a9f751-8431-4cc0-a65d-f00b184da09e@quicinc.com>
Date: Fri, 5 Apr 2024 18:29:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/7] spmi: pmic-arb: Register controller for bus
 instead of arbiter
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold
	<johan@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20240402-spmi-multi-master-support-v8-0-ce6f2d14a058@linaro.org>
 <20240402-spmi-multi-master-support-v8-6-ce6f2d14a058@linaro.org>
From: David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <20240402-spmi-multi-master-support-v8-6-ce6f2d14a058@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VTMQSKwVhBh_InbA8xBhyFtuvnMohNnY
X-Proofpoint-GUID: VTMQSKwVhBh_InbA8xBhyFtuvnMohNnY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_31,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=967 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404060010

On 4/2/24 05:07, Abel Vesa wrote:
> +struct spmi_pmic_arb_bus {
> +	struct spmi_pmic_arb	*pmic_arb;
> +	struct irq_domain	*domain;
> +	void __iomem		*intr;
> +	void __iomem		*cnfg;
> +	struct spmi_controller	*spmic;
> +	u16			base_apid;
> +	int			apid_count;
> +	u32			*mapping_table;
> +	DECLARE_BITMAP(mapping_table_valid, PMIC_ARB_MAX_PERIPHS);
> +	u16			*ppid_to_apid;
> +	u16			last_apid;
> +	struct apid_data	*apid_data;
> +	u16			min_apid;
> +	u16			max_apid;
> +	int			irq;
> +};
..
>  struct spmi_pmic_arb {
>  	void __iomem		*rd_base;
>  	void __iomem		*wr_base;
> -	void __iomem		*intr;
> -	void __iomem		*cnfg;
>  	void __iomem		*core;
>  	resource_size_t		core_size;
>  	raw_spinlock_t		lock;

Can you please move "lock" from "struct spmi_pmic_arb" into "struct
spmi_pmic_arb_bus" and update its usage in the functions below?  The two
SPMI buses within PMIC Arbiter v7 operate entirely independently and
write to separate sets of registers.  As-is, transactions on one bus
would unnecessarily block transactions on the other, leading to a
performance penalty.

>  	u8			channel;
> -	int			irq;
>  	u8			ee;
> -	u32			bus_instance;
> -	u16			min_apid;
> -	u16			max_apid;
> -	u16			base_apid;
> -	int			apid_count;
> -	u32			*mapping_table;
> -	DECLARE_BITMAP(mapping_table_valid, PMIC_ARB_MAX_PERIPHS);
> -	struct irq_domain	*domain;
> -	struct spmi_controller	*spmic;
>  	const struct pmic_arb_ver_ops *ver_ops;
> -	u16			*ppid_to_apid;
> -	u16			last_apid;
> -	struct apid_data	*apid_data;
>  	int			max_periphs;
> +	struct spmi_pmic_arb_bus *bus;
>  };

Thanks,
David Collins


