Return-Path: <linux-kernel+bounces-105010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AED387D794
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6472D282827
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3F517FF;
	Sat, 16 Mar 2024 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A76P9CZH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843117F6;
	Sat, 16 Mar 2024 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710548789; cv=none; b=a3MvwrX2l4YmSg8kIPxTscrhW8fSPX3yoaLKamfr0hTVn7R9ECl/D6PAufEyc+0CcPPQ5SK+5dWRney+hNyyAZJzADXTCPXCHo3j3VMRCoUkXNz7YGIRuYAU6HLaTuN3t/3msOTkZSUyogc9ocJehPY3WoGmpYRV/KJvJ35EGcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710548789; c=relaxed/simple;
	bh=FTVzweEJdBb3KGekCmN9WfLK44PXS9oJJetwk3q2GY4=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RXZfMiyXwmfaKKYpSeqhSAefHWk432Jp3n9ahXyu35tk0R3Bu+Ml8DT9MUNg/oA0as51OxpSSDzcOFAL4Jgn2hwWdXDRJK1SxUxnnfaSE9KimcTAjBNKj46T/hnOKcHIzNTQV7ikF8Wl0jZfqB9mBJI/v8cmhZZ4ZbyEGLeQgj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A76P9CZH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42G0PG6s011596;
	Sat, 16 Mar 2024 00:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:mime-version:content-type; s=
	qcppdkim1; bh=FTVzweEJdBb3KGekCmN9WfLK44PXS9oJJetwk3q2GY4=; b=A7
	6P9CZHIHAgYdS8VqUrdoIHFL0PV300C9pz2swflBtdwkbrgqYTNC05DUs5nDFuHD
	3U8nw5MAjp357WpmO0mtK/cZE+nrnedZC+bafs51fruQbPVxwLJSRH8rxBINpnR2
	fP5GRn9Sgk+RrHvQXZy81ZPONr32ah/yTMPV/m8IhUtnsKJ6smH6oqRFZfq/jwbx
	285Y2ygfk4HCsk5Bx+My+nSUgDA/EZhy5owPKcWIEldqv/elPXOBa/qlKmEY6KMN
	8QRaa+Yyx4fYiuncfDzMzDoYSLLeHPW2QcdoEc/v8A5nNUL1N2yTYj8XNR08hSCF
	K9Ay7RD4VY/7aGVs53Og==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wvj82sd49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Mar 2024 00:26:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42G0QMco025523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Mar 2024 00:26:22 GMT
Received: from hu-cgoldswo-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Mar 2024 17:26:22 -0700
Date: Fri, 15 Mar 2024 17:26:21 -0700
From: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Driver supporting HW decompression and SW decompression
Message-ID: <20240316002443.GA31904@hu-cgoldswo-sd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vioKnUnLSsDY9tMB6QFwLy0zuyxPwO4G
X-Proofpoint-GUID: vioKnUnLSsDY9tMB6QFwLy0zuyxPwO4G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_08,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=629 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403160000

Hi There,

If a compression driver were submitted upstream that used HW LZO decompression
and SW LZO compression, could it be accepted? It would be geared towards
decompressing boot images on IOT-type targets with exteremely limited secondary
storage.

Thanks,

Chris.

