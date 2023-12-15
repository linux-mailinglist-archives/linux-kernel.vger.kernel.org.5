Return-Path: <linux-kernel+bounces-1141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A385814B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9C71C239C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97C8358B1;
	Fri, 15 Dec 2023 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dFZawHbc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23B9364A4;
	Fri, 15 Dec 2023 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFDwLHD014411;
	Fri, 15 Dec 2023 14:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1jwi2TaNw/idM6KvASCJXOcLUllXiF0b2T6DLjX2GXs=; b=dF
	ZawHbc8lkkd+IaIBuCV3RvswsfFPO4VYY0JL6V/1MjixsFbV0Waadzt0t2T8iZIA
	BFoMNjun/gJA36p5r/ARWBeWMMci37E5b8FQZCts2wRtjC7/gbjNPt7EvggrYKio
	RtIJDyPvNgfsWvCR+dPokQ5vj1nAz/Poz5d5hQP+OPL3eZDczHWdW0YTefpaiC4f
	gG1sX2TrhoFSb4MZUB6EbbBA6pJ7coEqI3ncmaZigOWgDSr4kGjcinwBJcs66An+
	ZdijJmS6C1MYN6+WntQpRYW9u5h9MJwFHYl268JVGYRHYZs0pPweUSN74TIuvslO
	oBWpgUzhCCxV34NAH04w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0a37jc7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 14:58:52 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFEwpR5032091
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 14:58:51 GMT
Received: from [10.253.38.198] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 06:58:48 -0800
Message-ID: <de5b8bf1-8c5f-4673-9036-3f50aedd5785@quicinc.com>
Date: Fri, 15 Dec 2023 22:58:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: Add comments for tty-ldisc module loading logic
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
CC: <jirislaby@kernel.org>, <quic_qiancai@quicinc.com>,
        <quic_arandive@quicinc.com>, <quic_saipraka@quicinc.com>,
        <quic_vnivarth@quicinc.com>, <quic_eberman@quicinc.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1702640236-22824-1-git-send-email-quic_zijuhu@quicinc.com>
 <1702647690-6787-1-git-send-email-quic_zijuhu@quicinc.com>
 <2023121523-cadillac-prologue-a81d@gregkh>
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2023121523-cadillac-prologue-a81d@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SucUcQ_HXS0ojCxNosUzLJ2XMtSXV622
X-Proofpoint-ORIG-GUID: SucUcQ_HXS0ojCxNosUzLJ2XMtSXV622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 mlxlogscore=946
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150103

On 12/15/2023 10:12 PM, Greg KH wrote:
> On Fri, Dec 15, 2023 at 09:41:30PM +0800, Zijun Hu wrote:
>> Current tty-ldisc module loading logic within tty_ldisc_get()
>> is prone to mislead beginner that the module is able to be loaded
>> by a user without capability CAP_SYS_MODULE, add comments to make
>> the logic easy to undertand.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>> Changes in v2:
>> - Remove condition checking changes
> 
> As I asked for before, please get other, more experienced developers,
> from your company, to review and sign-off on this patch before sending
> it out again.  I can't take this as-is, sorry.
> 
okay
> greg k-h


