Return-Path: <linux-kernel+bounces-19858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00580827585
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281C61C21002
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DFC53E36;
	Mon,  8 Jan 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GtxseQUM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB7553E13
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 408GNwe0001712;
	Mon, 8 Jan 2024 16:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sYTaiP9js7/gZK6Jp/GwAMQrfLRg8GyXuO8Ji0Fwu4A=;
 b=GtxseQUMPlCknx6coF+Y1zoeuYnTxTA+4hJhZ7RZO3IF1/xgwNvYXkEqdGC0fiSC8FgZ
 9iVY2cpa/cPipO3GYwo2+wWlGpZ9Y7VB4xw3faDwD28Gl0fViyqz9NqhCHA2nrHbFIBG
 MgFG0lPjwHVBby5zYxlDyPzJI8tnZrUcoUmfuivEpdIk2U++GBJ/d7u4w7FscuTeSL/G
 1varlej65OS6vcD1ufmZyfCFUrkepoe6197LOKg/rLTHPDqSGpDbu8RpAk/KysVQ0ShG
 lOXNFlaW1gecN0iyYDA93n4Yj/+u/+1dJBQWBGq0kmqBRvflyJpDgBdMdloB2of8ANBD eA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vgmc08njy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 16:39:38 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 408F1nKs022793;
	Mon, 8 Jan 2024 16:39:37 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfhjy9c9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 16:39:36 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 408GdZdA30212832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 16:39:36 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4D745805D;
	Mon,  8 Jan 2024 16:39:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49E7C5805B;
	Mon,  8 Jan 2024 16:39:35 +0000 (GMT)
Received: from [9.61.62.160] (unknown [9.61.62.160])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jan 2024 16:39:35 +0000 (GMT)
Message-ID: <c290495d-fd4d-644b-7dc9-47a6273e7e26@linux.ibm.com>
Date: Mon, 8 Jan 2024 10:39:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] fsi: run clock at 100MHz
To: Lakshmi Yadlapati <lakshmiy@us.ibm.com>, joel@jms.id.au,
        ninad@linux.ibm.com, alistair@popple.id.au
Cc: linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20231214171042.3889056-1-lakshmiy@us.ibm.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20231214171042.3889056-1-lakshmiy@us.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3QSFb0zx_9lwitKRbW1UDdXzGYCrMUuP
X-Proofpoint-GUID: 3QSFb0zx_9lwitKRbW1UDdXzGYCrMUuP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_06,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401080140


On 12/14/23 11:10, Lakshmi Yadlapati wrote:
> Adjust FSI speed to 100MHz for improved stability and optimized
> data transmission.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> ---
>   drivers/fsi/fsi-master-aspeed.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
> index f0a19cd451a0..b065e1bb9054 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -87,7 +87,7 @@ static const u32 fsi_base = 0xa0000000;
>   #define FSI_LINK_ENABLE_SETUP_TIME	10	/* in mS */
>   
>   /* Run the bus at maximum speed by default */
> -#define FSI_DIVISOR_DEFAULT            1
> +#define FSI_DIVISOR_DEFAULT            2
>   #define FSI_DIVISOR_CABLED             2
>   static u16 aspeed_fsi_divisor = FSI_DIVISOR_DEFAULT;
>   module_param_named(bus_div,aspeed_fsi_divisor, ushort, 0);

