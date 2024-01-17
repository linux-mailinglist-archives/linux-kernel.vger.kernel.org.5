Return-Path: <linux-kernel+bounces-28736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1FC83026A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4DC28602B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B449914AA1;
	Wed, 17 Jan 2024 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="djKypmE2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD214A97;
	Wed, 17 Jan 2024 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484120; cv=none; b=m/Z8g+2c7nyHnb2NtVxMS3tdsa9H+UJ4gEy0/lB/hcHitFjY0X7crZW5SjDnmy7aHPGGrRE/OXXfgCn2C4zlloedwg2eMglK7VHS7ED12C5VQx/UZENg5iHjs2524jCPxQZEZUpnyW+c1uXHAOR5hg9Xdpr3jNuZiYtxUKbCiGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484120; c=relaxed/simple;
	bh=x0Kcp/pwxTMh/ECqiJKT11P/bFTpgUJY8Nj46rmjhsQ=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:From:To:CC:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=DSg9alKAL1JkQoCqO4h/HNmgrm2qYS/axFAZYgFGKaZSxpX+qlJ2F2j5ik59cWQQwheJjDb2iXKyGf/yCf6VCRiWesSX0lyMM3q5dRgcwOU6+ygLirDgCKwIbZdDehXw07X/db6KDdt6SJKTdg0a0sLhMqmp1EHzXB+59Q3B4Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=djKypmE2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H6n0nh000436;
	Wed, 17 Jan 2024 09:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vMOS0DlzBel23A1Z1cIJQ4jSth1nNH9SdwsW3j+1mMY=; b=dj
	KypmE2zjnI33oLWvCF+4H3OnMNrMKyx3M0PcAiCS3nR7Fx0zvW0HbVIvOFMBr+Ra
	eKdyZ+UkHGp2O5sGxpgnJ6aR9WXZd/4hl0kn5V6nBzkknrP3HMYZKJc62WglhZeq
	epTh0hfLhQCWu343un13/FKGynEKOSPadgkxDM0CHmU1phNGeH+WaZSv3sJ8ENym
	KrI6IuAuEJ49d4w1j0UDIZRx80PCgpqNser2litrmc0IhLXysnhAXBn0nEt9v0Ap
	Pxx3hov+FJysXrTpBjCgorfTmE4Fc47NiXZt0XpPpFjrzGkt8LV60PoX2xrbI96g
	oOHtOXWjYfMMWq7MusCA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnrndaw1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 09:35:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H9ZD9N018617
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 09:35:13 GMT
Received: from [10.218.39.189] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 01:35:11 -0800
Message-ID: <8ba84432-bd07-3e59-3638-924d5fadec30@quicinc.com>
Date: Wed, 17 Jan 2024 15:05:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend
Content-Language: en-US
From: UTTKARSH AGGARWAL <quic_uaggarwa@quicinc.com>
To: Kuen-Han Tsai <khtsai@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
References: <20240110095532.4776-1-quic_uaggarwa@quicinc.com>
 <CAKzKK0qJOz_+pNAVAD8Ub6TZ9uhFOzuDC_bws9MVzxNa7RqYhA@mail.gmail.com>
 <77ffee9a-cd77-6a09-10ee-bdf17bfca5ec@quicinc.com>
In-Reply-To: <77ffee9a-cd77-6a09-10ee-bdf17bfca5ec@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _imoAAgSBlqQomJwOPibXrLFUxParQxb
X-Proofpoint-ORIG-GUID: _imoAAgSBlqQomJwOPibXrLFUxParQxb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_04,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=481 clxscore=1015
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170066


On 1/17/2024 2:52 PM, UTTKARSH AGGARWAL wrote:
>
> On 1/17/2024 12:47 PM, Kuen-Han Tsai wrote:
>>>          ret = dwc3_gadget_soft_disconnect(dwc);
>>>          if (ret)
>>>                  goto err;
>> For improved readability, we can remove the goto statement and move
>> the error handling logic here.
>
> Hi Kuen-Han,
>
> Thanks for the suggestion.
> Does this looks good to you ?
>
>    int ret = dwc3_gadget_soft_disconnect(dwc);if (ret) {        if 
> (dwc->softconnect)            dwc3_gadget_soft_connect(dwc);
>
>        return ret;    }    spin_lock_irqsave(&dwc->lock, flags);    if 
> (dwc->gadget_driver)  dwc3_disconnect_gadget(dwc); 
>  spin_unlock_irqrestore(&dwc->lock, flags);

Sorry for the mistake.

int ret = dwc3_gadget_soft_disconnect(dwc);

if (ret) {

       if (dwc->softconnect)

                  dwc3_gadget_soft_connect(dwc);

       return ret;

}

spin_lock_irqsave(&dwc->lock, flags);

if (dwc->gadget_driver)

        dwc3_disconnect_gadget(dwc);

spin_unlock_irqrestore(&dwc->lock, flags);


