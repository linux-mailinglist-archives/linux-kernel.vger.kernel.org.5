Return-Path: <linux-kernel+bounces-149264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0468A8E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFDD1C21029
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF68881734;
	Wed, 17 Apr 2024 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XRTpbr+e"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887F537E5;
	Wed, 17 Apr 2024 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713389974; cv=none; b=pPnzV4DumjAM3ezjtTKR4EnZ2j5lIzol4kLewhlHRPCblWoa4tR+YiGmWfTx20YO2kRcA2SNQwaZB9r/sTm/lxud3JlzFIBSF8epGd21BapGwrSFQNd3iWpcGUIV58gBh9qpCM7dxt0X8OoyPLFK5bgh69C3WAgN6fEaWhPJ2Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713389974; c=relaxed/simple;
	bh=q0QCaPKXFQaJRN1yKHQCY4iTcPAK8SFeGcseBNHXKuI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYDTODPnhZsxgp3zQZ0fqdrBk1oPtQvuC6wa/dmCwDBvfmkNFJwYVcFboC2Mkz9HcX61kD4KIqXlHSl6LN0dA1qAn4zk11gOOizMV8kHLadcsx0ZrhVhPi55qxLBkCTt5cCaFQRa21d7ic7AngEmnwlSva533wVfeb3d2U8CEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XRTpbr+e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H8LoRD018023;
	Wed, 17 Apr 2024 21:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	qcppdkim1; bh=nz82gthU4H0gzVnKqCRneaII5j/RA0J3JmroyTGbXns=; b=XR
	Tpbr+eghOqh92U4wjOh6wVPT5NRTbypCgO3o5fhk6dVO7O8oCYqzaKh1kQeblTZm
	B2rmXxZy8EwdRDx/C+lJ0uAXGOCIjXW+sl/4F+09k/zdGx6QwBNWC+5lJHLNlhgW
	Tfha3ujMEVPcixuxSXyNQO5xp65qAUfTv2Bq2ANrf564MXxwjDgQ72KK5B5ucOkG
	9zSBAO/uSr6+wL0l5VwIz6V8qBifAdj7BRkDbdcGBFtjU3Pv2FVeXV0Ii48Cny4z
	MoJ6JT+v97t2ddSvtYY4PGkUyD0kAiQQX9cI/0mFvf5tDm+WdwgWf6NU2Yhv1wbd
	9wC/V6y5wLAQd2Iu7LZQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjaupt2ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 21:39:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HLdFfK029845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 21:39:16 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 14:39:15 -0700
Date: Wed, 17 Apr 2024 14:39:14 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_anupkulk@quicinc.com>, <quic_cchiluve@quicinc.com>
Subject: Re: [PATCH v1 RESEND] slimbus: stream: Add null pointer check for
 client functions
Message-ID: <ZiBBgiQYVAEEaeZi@hu-bjorande-lv.qualcomm.com>
References: <20240327083214.29443-1-quic_vdadhani@quicinc.com>
 <ZhgIHHP1FUeCr+vx@hu-bjorande-lv.qualcomm.com>
 <720e1ee0-79b0-4d30-b1b8-a90676057161@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <720e1ee0-79b0-4d30-b1b8-a90676057161@quicinc.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hzUEsAMLuivqaa-ID21jar4hQvkob5w3
X-Proofpoint-ORIG-GUID: hzUEsAMLuivqaa-ID21jar4hQvkob5w3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170154

On Wed, Apr 17, 2024 at 03:12:38PM +0530, Viken Dadhaniya wrote:
> 
> 
> On 4/11/2024 9:26 PM, Bjorn Andersson wrote:
> > On Wed, Mar 27, 2024 at 02:02:14PM +0530, Viken Dadhaniya wrote:
> > > There is a possible scenario where client driver is calling
> > 
> > How can we asses the validity or the risk of this problem?
> > How would I know if this matches e.g. a bug report reported by a user?
> > 
> > Describe the problem such that the reviewer can asses the validity and
> > severity of your bug fixes.
> 
> Ok. Updated commit log in v2
> 
> > 
> > > slimbus stream APIs in incorrect sequence and it might lead to
> > > invalid null access of the stream pointer in slimbus
> > > enable/disable/prepare/unprepare/free function.
> > > 
> > > Fix this by checking validity of the stream before accessing in
> > > all function API’s exposed to client.
> > > 
> > 
> > You use the work "fix" a few time, are you fixing an actual bug? Are you
> > just guarding the driver from incorrect usage?
> > 
> > If it's a fix, then add Fixes and Cc: stable here.
> 
> Let me correct myself there. Not a fix but consider an improvement where
> preventing a crash due to client following the incorrect sequence.
> 

This is C, this is the Linux kernel. We do not account for clients
calling random functions in random order.

If it happens because there are race conditions, then fix the client
driver (there's probably other bugs hidden there). If it's a problem
that can happen during bringup due to some misconfiguration, let it go
to kernel panic so we can catch it quickly.

If there is a valid scenario where this can happen, then clearly
describe this in the commit message.

> > 
> > > Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> > > ---
> > >   drivers/slimbus/stream.c | 37 +++++++++++++++++++++++++++++++++----
> > >   1 file changed, 33 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
> > > index 1d6b38657917..c5a436fd0952 100644
> > > --- a/drivers/slimbus/stream.c
> > > +++ b/drivers/slimbus/stream.c
> > > @@ -202,10 +202,16 @@ static int slim_get_prate_code(int rate)
> > >   int slim_stream_prepare(struct slim_stream_runtime *rt,
> > >   			struct slim_stream_config *cfg)
> > >   {
> > > -	struct slim_controller *ctrl = rt->dev->ctrl;
> > > +	struct slim_controller *ctrl;
> > >   	struct slim_port *port;
> > >   	int num_ports, i, port_id, prrate;
> > > +	if (!rt || !cfg) {
> > > +		pr_err("%s: Stream or cfg is NULL, Check from client side\n", __func__);
> > 
> > Use dev_err() and write your error messages such that they make sense
> > without the use of __func__.
> 
> For error scenario, we don't have valid dev to be used in dev_err argument.
> this log will help for debug. Please let us know any concern with pr_err
> 

Yes, I have a concern with this.

You will print a line in the log and carry on as if nothing happened.
Most likely this will go unnoticed during testing, or you will have bug
reports that are extremely hard to take action on.

> > 
> > > +		return -EINVAL;
> > 
> > Is this expected to happen during normal operation, or is this a sign of
> > a bug?
> > 
> 
> It's a scenario where client doesn't follow the proper sequence and slimbus
> driver can crash if not checked against NULL.
> 
> > 
> > Neither of the two callers of this function checks the return value, so
> > is this really going to result in a good system state?
> > 
> 
> we expect client to check return value of framework APIs.
> 

Please send bug fixes for these.

> > 
> > It would make sense to require the client to pass valid rt and cfg
> > pointers, and if you have an issue in the client driver in which we
> > might end up with invalid points, then those drivers should be fixed -
> > rather than relying on chance and swipe it under the rug here.
> > 
> > Regards,
> > Bjorn
> > 
> 
> Agree. it is sequence mismatch from client driver, and they should take
> care. it is leading to NULL pointer access in slimbus APIs, so prevent crash
> by adding check.
> 

You're not just preventing a crash, you're introducing a unexpected
(currently undefined, due to lack of error propagation) behavior by just
returning an error here.

Regards,
Bjorn

