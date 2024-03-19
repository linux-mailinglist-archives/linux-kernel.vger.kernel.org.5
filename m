Return-Path: <linux-kernel+bounces-107380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFC287FBB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA121C21821
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D737E111;
	Tue, 19 Mar 2024 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YruXD/2n"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F97D096;
	Tue, 19 Mar 2024 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843756; cv=none; b=AtHGI0J1p259QcSGoItel3eh8jjk1z1h9Nhbeajggldd+TVSEn4xuv7rupQSMwT9syqD+Op99o91na51FXSMQ9ccE1JNslkNAweEeT9r1mqrBVI4FChjSYCidSZuCarrNxSJCVKh0Bhe0EOSPI3yOtAubkwUm5CRI/57MvtKHbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843756; c=relaxed/simple;
	bh=W3jZVNvJ0NPlQQ3uSaUdcc+IdClJd8FvQrdxHQKRd5Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feHfo5Lzf++KS6RUOGNrF2wsCgEkyDHUbc5IGqh6hk+1puyfkm7r4ScmqJDUNirrH10IzITDK6Sf+Wgr/dMzaW3fYwe+sWSonUAuQa6tvBDkDiVcY8WmeGG0kwnmo+Eg+w5Z5YwpJ2hBsyUSi+wjPOWQToH7SaVKtUc+8ZmTi0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YruXD/2n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J8Ql9w013321;
	Tue, 19 Mar 2024 10:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=Hn0IAkDGDhCgHfQvbQRjT
	SXdhr05Qbnhtd+g28g+Bss=; b=YruXD/2nqByMOQAXjS9Wda7tEx4DiUt4HVc9u
	w4ovBDOP3V1yc8LRUYqUk36RbwD8MHGGb+0vjlSHBtILc5on7tW0rEOrLupftQX7
	j/92hPmJRN0xqlX/k2col40z0e5Iki+By5ALSGC34gpKdoM8SLy6rksTywiD30r3
	Z6jniOonj6Wfs7CJlJ0m863Xeg79Q6Thw3zPmiy+Ia+WQ+Qb29YL0tQqXag6VFwr
	weT+d2/tewQgqVpbqT/VYLhIGJmh+SM4V9ifOfD6gqDcj8fAgOpvk78AgJ+sPOsj
	g4kfKkpQELp6eK3x+V0HaScMbYcyX5sXyrZ4sqPIUY0NE4jJw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy5pprgmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 10:22:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JAMSaa012837
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 10:22:28 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 03:22:25 -0700
Date: Tue, 19 Mar 2024 15:52:22 +0530
From: Pavan Kondeti <quic_pkondeti@quicinc.com>
To: Mukesh Ojha <quic_mojha@quicinc.com>
CC: Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v12 7/9] firmware: qcom: scm: Fix __scm->dev assignement
Message-ID: <60535d91-3610-4610-ae1a-46b8e3ccd4fa@quicinc.com>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-8-quic_mojha@quicinc.com>
 <n2gomlmlzwodpg2v3gzuc62n3plewdqgiwctrv2tawdih26rig@obqd2a2ovqvp>
 <260371ff-da7a-8406-0511-4019f6b860bf@quicinc.com>
 <03367100-1ad4-4d83-8200-5879550398be@quicinc.com>
 <fce3beb8-7d70-672c-e25b-d46810c4d1dd@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fce3beb8-7d70-672c-e25b-d46810c4d1dd@quicinc.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Yq--i3YQ3gsyJFrz-T9yHuwjvWBpIP0X
X-Proofpoint-ORIG-GUID: Yq--i3YQ3gsyJFrz-T9yHuwjvWBpIP0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190079

On Tue, Mar 19, 2024 at 03:38:57PM +0530, Mukesh Ojha wrote:
> 
> 
> On 3/19/2024 6:47 AM, Pavan Kondeti wrote:
> > On Mon, Mar 18, 2024 at 06:38:20PM +0530, Mukesh Ojha wrote:
> > > 
> > > 
> > > On 3/3/2024 12:55 AM, Bjorn Andersson wrote:
> > > > On Tue, Feb 27, 2024 at 09:23:06PM +0530, Mukesh Ojha wrote:
> > > > > qcom_scm_is_available() gives wrong indication if __scm
> > > > > is initialized but __scm->dev is not.
> > > > > 
> > > > > Fix this appropriately by making sure if __scm is
> > > > > initialized and then it is associated with its
> > > > > device.
> > > > > 
> > > > 
> > > > This seems like a bug fix, and should as such have a Fixes: tag and
> > > > probably Cc: stable@vger.kernel.org
> > > > 
> > > > > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > > > > ---
> > > > >    drivers/firmware/qcom/qcom_scm.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > > > > index 6c252cddd44e..6f14254c0c10 100644
> > > > > --- a/drivers/firmware/qcom/qcom_scm.c
> > > > > +++ b/drivers/firmware/qcom/qcom_scm.c
> > > > > @@ -1859,6 +1859,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
> > > > >    	if (!scm)
> > > > >    		return -ENOMEM;
> > > > > +	scm->dev = &pdev->dev;
> > > > >    	ret = qcom_scm_find_dload_address(&pdev->dev, &scm->dload_mode_addr);
> > > > >    	if (ret < 0)
> > > > >    		return ret;
> > > > > @@ -1895,7 +1896,6 @@ static int qcom_scm_probe(struct platform_device *pdev)
> > > > >    		return ret;
> > > > >    	__scm = scm;
> > > > > -	__scm->dev = &pdev->dev;
> > > > 
> > > > Is it sufficient to just move the line up, or do we need a barrier of
> > > > some sort here?
> > > 
> > > Would be good to use, smp_mb() before the assignment
> > >       __scm = scm
> > > along with moving below line
> > > __scm->dev = &pdev->dev
> > > 
> > 
> > Full memory barrier is not needed here. store variant is sufficient.
> > WRITE_ONCE() + smp_store_release() will fit here no?
> 
> Thanks for the comment, i again have a look at it and agree we don't
> need a full barrier here.
> 
> And we can do either of the below two ways.
> 
> -Mukesh
> 
> 
> // 1st way
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c
> b/drivers/firmware/qcom/qcom_scm.c
> index 49ddbcab0680..b638fb407fc6 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1741,7 +1741,12 @@ static int qcom_scm_qseecom_init(struct qcom_scm
> *scm)
>   */
>  bool qcom_scm_is_available(void)
>  {
> -       return !!__scm;
> +       bool avail;
>   */
>  bool qcom_scm_is_available(void)
>  {
> -       return !!__scm;
> +       bool avail;
> +
> +       avail = !!READ_ONCE(__scm);
> +       smp_rmb();
> +
> +       return avail;
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_is_available);
> 

Your original problem statement: qcom_scm_is_available() gives wrong indication 
if __scm is initialized but __scm->dev is not.

This does not require read side barrier as there is an address
dependency. If the writer does it *correctly*, the reader would always
observe __scm->dev != NULL when __scm != NULL without any barrier.

Thanks,
Pavan

