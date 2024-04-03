Return-Path: <linux-kernel+bounces-129602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D309C896D11
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F911F30CD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB291419B0;
	Wed,  3 Apr 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E9sQRovm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD441411D7;
	Wed,  3 Apr 2024 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141131; cv=none; b=ldQZ+ZvyLr9vPzPg+OK3LzCUVw41ZTa6fZd7OF3wFqF/I/z4fPtIufXVwJsEEY2pxR1zkY1iuxraVgVzl/+iOHJ8RgMwg9ECqa8ArZlx3XES0Utjc3NtzH7IYkF1J2PNymGEMDYlxwRTUASi0G8oRRqXfHT9jxj9rhqG06k4jIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141131; c=relaxed/simple;
	bh=NRiJZSAEaHpmWILpkwDOH+Nn0vCmuqhx+Aw5DPhRLnE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPMiTw8uhjKLU8ilGrWyIyKceDOJeq1h6tj008vXCgKbOKmPRMrfjCCg/NVUx9tDFhujl0fV5lypuKnAY0uSdsnYULL3B9LptEwEx+32BW6UftCAl90B/FgbvQOnA2ZQMQlIY54pUiCY17WG/vRNBRteiYxYt8WOuXgXkkFo0YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E9sQRovm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4339sZsG015552;
	Wed, 3 Apr 2024 10:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=YPFUUtNa1Y1789Hp4DW3f
	Kfu5cDS7M38VbG/wxejbIs=; b=E9sQRovmrhe+3lR5bvlIjLwu/ACZtLv6MarKi
	xB8JlXA5oDQj5CL2ZN5Qn15c9VWLJMzoadbwyN2xeE9eihPvh6aR50IzD1Ncsfmy
	Lq3ilDrW/Qj1qILODC8XvNzmepVaktqvCwTg2XvHVdyHcokBd23W7t5Wpds/VPnn
	y+xzBK3P0qekgzuLbtXHF1uciA90/EZBATwGtbC0VZzGABR11L0kyDh3FFfLDfsZ
	8qfFHr5Ll2MEVMNQFngri+l4qC6jCJLxaIiYuQrYGTO/DgvpVmQqzKgZYhdl0a+x
	Tnvv1iJrOKy+pNBT+PVNdCbiBwKiXf/IazNJn6AaoI+FvtiVw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x93pw89bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 10:45:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433AjP7e019641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 10:45:25 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Apr 2024 03:45:21 -0700
Date: Wed, 3 Apr 2024 16:15:17 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v6 3/6] interconnect: icc-clk: Add devm_icc_clk_register
Message-ID: <Zg0zPZ1oRMD+CN6X@hu-varada-blr.qualcomm.com>
References: <20240402103406.3638821-1-quic_varada@quicinc.com>
 <20240402103406.3638821-4-quic_varada@quicinc.com>
 <CAA8EJpphk_kqzBE7cKb73ipdpTi29t9ZSOOdSfq7pAGSs5NKeg@mail.gmail.com>
 <CAA8EJpo=TMhu+Te+JE0cQzmjLOTDPi-Vv-h5Bch0Wfr_7iVi2w@mail.gmail.com>
 <ZgvlrbvvPNA6HRiL@hu-varada-blr.qualcomm.com>
 <CAA8EJpp2dgy0DcLoUuo6gz-8ee0RRwJ_mvCLGDbdvF-gVhREFg@mail.gmail.com>
 <ZgvqkhF2mTG82Rx2@hu-varada-blr.qualcomm.com>
 <CAA8EJprN3TuMF-v5PeFW_JUKk+a+MxB7poccZbi9biZNniRnTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJprN3TuMF-v5PeFW_JUKk+a+MxB7poccZbi9biZNniRnTQ@mail.gmail.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1KN1hY6_zceb0XJF0OjAwe7Fuac5WBp0
X-Proofpoint-ORIG-GUID: 1KN1hY6_zceb0XJF0OjAwe7Fuac5WBp0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=946
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404030074

On Tue, Apr 02, 2024 at 03:12:04PM +0300, Dmitry Baryshkov wrote:
> On Tue, 2 Apr 2024 at 14:23, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > On Tue, Apr 02, 2024 at 02:16:56PM +0300, Dmitry Baryshkov wrote:
> > > On Tue, 2 Apr 2024 at 14:02, Varadarajan Narayanan
> > > <quic_varada@quicinc.com> wrote:
> > > >
> > > > On Tue, Apr 02, 2024 at 01:48:08PM +0300, Dmitry Baryshkov wrote:
> > > > > On Tue, 2 Apr 2024 at 13:40, Dmitry Baryshkov
> > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > >
> > > > > > On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
> > > > > > <quic_varada@quicinc.com> wrote:
> > > > > > >
> > > > > > > Wrap icc_clk_register to create devm_icc_clk_register to be
> > > > > > > able to release the resources properly.
> > > > > > >
> > > > > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > > > > ---
> > > > > > > v5: Introduced devm_icc_clk_register
> > > > > > > ---
> > > > > > >  drivers/interconnect/icc-clk.c   | 29 +++++++++++++++++++++++++++++
> > > > > > >  include/linux/interconnect-clk.h |  4 ++++
> > > > > > >  2 files changed, 33 insertions(+)
> > > > > >
> > > > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > >
> > > > > Wait. Actually,
> > > > >
> > > > > Unreviewed-by: me
> > > > >
> > > > > Please return int from devm_icc_clk_register instead of returning the pointer.
> > > >
> > > > Wouldn't returning int break the general assumption that
> > > > devm_foo(), returns the same type as foo(). For example
> > > > devm_clk_hw_get_clk and clk_hw_get_clk return struct clk *?
> > >
> > > Not always. The only reason to return icc_provider was to make it
> > > possible to destroy it. With devres-managed function you don't have to
> > > do anything.
> >
> > Ok. Will change as follows
> >
> >         return prov; -> return PTR_ERR_OR_ZERO(prov);
> >
>
> I think the code might become simpler if you first allocate the ICC
> provider and then just 'return devm_add_action_or_reset(dev,
> your_icc_clk_release, provider)'

Have posted v7 incorporating these and other feedback.
Please review.

Thanks
Varada

