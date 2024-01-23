Return-Path: <linux-kernel+bounces-34499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C76837D11
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2567F1C28101
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EA615E28C;
	Tue, 23 Jan 2024 00:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="opJxkq48"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CE44EB4A;
	Tue, 23 Jan 2024 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969782; cv=none; b=r1XQrhWuHi3+sS2+dHQONmFEeqkz6D2TrDD8IsqHZN4dZ+s9PZyPT7Lj+pDIDHZ8A76nsHRnNvk5MlnINmnKjnx1FBgUthBha0FH4OzqRjWZ7qTcAdtTKHmhmsqTqNSXeLmYIZ1yqMIh3rcEeOw77EWs0I6AcVIAHn+mV1Q7upg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969782; c=relaxed/simple;
	bh=y/0JTxWJL4qXHs9f+iHagTYbOJ0iNKWs2IBmc5nPNoE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgAqX2KTsz6WWMfawuSKHTDyMYHIErdLtMfXtOLnQyBcKRx50Kn4y6z1h7pcnCWRKEdbXPQlAgBfToeI4wmqEyvnv/TGZduIGe776Xp2gqm4t7T88vPtCL87g0Zbp/UyF25cugBMgVgtUfTkLMkjL4PDbjgxc6bCOdXKBINm+oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=opJxkq48; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MMrfmi020913;
	Tue, 23 Jan 2024 00:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=NyMAEdlEAWa7yJwAP7Klz
	mcCKaFtnf5sr6TORSj8Tkg=; b=opJxkq48x2uNUWDHy7giEfGHBZtYJpmPq1ECF
	Zn/TuRSaxa3sVMc8j/CXFCBgIuWuE9FqM3wIQXpWAh4SLYymfpik7n7C7i9c9H64
	Sea/dc9qXi0T/tmfRma7jodXrMWr+eyrKc8/2w4Lcl/RCVBU5slFZbQcwiqq1th/
	DRwx2jApgEM/dvOOmr4q+vFmqCmkGMj99tuJ3lbTKKi1bTvOmRbhtACEFxLBeKM0
	xwLR+jGojqbcAG3ovf5ff2t6yFx5eeKaNZFZeb2eRCp5ppQzKWrvWPBZ/IT8Gn8i
	qnpnflCLKWz7YxxRqJTJF/l1DFhWWjhJoq4W+9FqWrEvHZLBg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vspw8sxeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 00:29:34 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40N0TXxm022679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 00:29:33 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 16:29:33 -0800
Date: Mon, 22 Jan 2024 16:29:32 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Stephen
 Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v3] soc: qcom: aoss: Add debugfs interface for sending
 messages
Message-ID: <20240123002932.GC2936378@hu-bjorande-lv.qualcomm.com>
References: <20240117-qcom-aoss-debugfs-v2-v3-1-1aa779124822@quicinc.com>
 <2b43e7f9-9394-4ed2-b6d7-46fdc1e515c5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2b43e7f9-9394-4ed2-b6d7-46fdc1e515c5@linaro.org>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QcIdnaTHvQKjPjCAXGw5IOhgyImcDwuw
X-Proofpoint-ORIG-GUID: QcIdnaTHvQKjPjCAXGw5IOhgyImcDwuw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230002

On Mon, Jan 22, 2024 at 11:44:30AM +0100, Konrad Dybcio wrote:
> On 18.01.2024 03:31, Bjorn Andersson wrote:
> > In addition to the normal runtime commands, the Always On Processor
> > (AOP) provides a number of debug commands which can be used during
> > system debugging for things such as preventing power collapse or placing
> > floor votes for certain resources. Some of these are documented in the
> > Robotics RB5 "Debug AOP ADB" linked below.
> > 
> > Provide a debugfs interface for the developer/tester to send some of
> > these commands to the AOP, which allow the user to override the DDR
> > frequency, preventing power collapse of cx and ddr, and prevent AOSS
> > from going to sleep.
> > 
> > Link: https://docs.qualcomm.com/bundle/publicresource/topics/80-88500-3/85_Debugging_AOP_ADB.html
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> 
> [...]
> 
> >  
> > +struct qmp_debugfs_entry {
> > +	const char *name;
> > +	const char *fmt;
> > +	bool is_bool;
> 
> This can also be const
> 
> > +	const char *true_val;
> > +	const char *false_val;
> 
> All of these strings can be const ptrs to const data
> 

These are all const data now, but what would the reason for enforcing it
in the struct definition be?

Regards,
Bjorn

