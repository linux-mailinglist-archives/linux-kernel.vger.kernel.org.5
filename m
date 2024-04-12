Return-Path: <linux-kernel+bounces-141759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 581688A230E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A59B22569
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E454A21;
	Fri, 12 Apr 2024 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AuPB5wDD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7FC4A1E;
	Fri, 12 Apr 2024 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712882995; cv=none; b=PAg+8O3j0Fb4xDVJRS24AYF87goQlrMbFPPhPFmk8876d/fiftkvolWfJQP2ZpOj/nuWzyDS6LdFtpT3h6qwiBiPYgInymezC8PWDpyseRqWQM6Fk0h8++wJlEg22esbg6/ankyOITnCmhBnw9nWqTqI2kVoS2/852nwQLqv+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712882995; c=relaxed/simple;
	bh=qDYgGpcVoXWK1Oz7IhTj8AZ45cXWNF2cfJCay6+5xgo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXyggdndqe+SOq75RXhuXdSAJ0Nx8KZo40piHX8zXNTC1nOJI0BY4F34Hf5S/YUlboe498LdBIGe9VYx28gSb8/iG1pzruotxGCzd7vI0uwwveNEDEMCLtRPPo+ojl8XmamGE/EOmbin6HeDkKmzYCOWMHe9VEwb0LaU0gmjemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AuPB5wDD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C0M5eV005552;
	Fri, 12 Apr 2024 00:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=5oLK5tzoOUKB3yOhIAUxG
	DJCyOQUxXKysYGRltIOxZU=; b=AuPB5wDDKJ8FM6UBmHc6M36gSIa8YlAY6XIKZ
	GPFksaJi2OmbhPK4mhshmJLyX0pTUSZVe8v60UQ3cLTCXN1hIG3b7z65MMQolkg7
	nJtZeRwtKj68XVQF5+pYdIcwT2DpMaYa0oCHH344Ty2izsNwNfW2ylsnXkkkANkF
	QM0jCly6HRshUeEwtbuNxPtXj9NbQDZzOUBgtfRzSvL1eC/IRZ/RxBSg/vJCtuHq
	dVcMQ6sa3o6PwXE7G2ZrcOYytr+u2lzuGUjuf1f0b4VmEggCHLmL8KgsDmDhqD7m
	S9FM1PRGbJq4vZg0XZLbr6P+6Mprz5ln8AYrN5witG4yETw7Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xedugt0vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 00:49:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C0nfJU024679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 00:49:41 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 11 Apr 2024 17:49:41 -0700
Date: Thu, 11 Apr 2024 17:49:41 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/6] soc: qcom: Move some socinfo defines to the header,
 expand them
Message-ID: <20240411174914343-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
 <20240405-topic-smem_speedbin-v1-1-ce2b864251b1@linaro.org>
 <20240410132510649-0700.eberman@hu-eberman-lv.qualcomm.com>
 <2c2bca6c-b429-4cef-b63a-ee3bd6c9eecb@linaro.org>
 <20240411130802689-0700.eberman@hu-eberman-lv.qualcomm.com>
 <bbec514f-9672-4e5a-bd83-20ab59b3dcd9@linaro.org>
 <20240411162849104-0700.eberman@hu-eberman-lv.qualcomm.com>
 <7634a8ba-e783-46ce-be91-779cd603bd3b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7634a8ba-e783-46ce-be91-779cd603bd3b@linaro.org>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O7C_Q6EzRdAyrBB5f99ahNauyd-nqlI9
X-Proofpoint-ORIG-GUID: O7C_Q6EzRdAyrBB5f99ahNauyd-nqlI9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_13,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404120004

On Fri, Apr 12, 2024 at 02:10:30AM +0200, Konrad Dybcio wrote:
> 
> 
> On 4/12/24 01:49, Elliot Berman wrote:
> > On Thu, Apr 11, 2024 at 10:24:08PM +0200, Konrad Dybcio wrote:
> > > 
> > > 
> > > On 4/11/24 22:09, Elliot Berman wrote:
> > > > On Thu, Apr 11, 2024 at 10:05:30PM +0200, Konrad Dybcio wrote:
> > > > > 
> > > > > 
> > > > > On 4/11/24 20:55, Elliot Berman wrote:
> > > > > > On Fri, Apr 05, 2024 at 10:41:29AM +0200, Konrad Dybcio wrote:
> > > > > > > In preparation for parsing the chip "feature code" (FC) and "product
> > > > > > > code" (PC) (essentially the parameters that let us conclusively
> > > > > > > characterize the sillicon we're running on, including various speed
> > > > > > > bins), move the socinfo version defines to the public header and
> > > > > > > include some more FC/PC defines.
> > > > > > > 
> > > > > > > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > > > > > ---
> > > 
> > > [...]
> > > 
> > > > 
> > > > 0xf is the last one.
> > > 
> > > One more question, are the "internal/external feature codes" referring to
> > > internality/externality of the chips (i.e. "are they QC-lab-only engineering
> > > samples), or what else does that represent?
> > 
> > Yes, QC-lab-only engineering samples is the right interpretation of
> > these feature codes.
> 
> Do you think it would be beneficial to keep the logic for these ESes in
> the upstream GPU driver? Otherwise, I can yank out half of the added lines.
> 

Should be fine to yank, IMO.


