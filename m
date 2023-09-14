Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663767A07DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240814AbjINOtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbjINOtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:49:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50941FFF;
        Thu, 14 Sep 2023 07:49:12 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EE8ZlM027382;
        Thu, 14 Sep 2023 14:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aL++Hd0s2d7IrNOsxWTei1ji/pjM+JhOfFszoIJYSMA=;
 b=Nh3IfxgSoU46L4p9ldF3wIAOzk7Fofe5fxlElC3vnWaZcPRM+z9J5kyt+Toc//f3b6kT
 A9p2ax0nLIm2ndL+WGPeKj3OCUdn35YHrZYSbwAgo2hlaEqda51YXS3UBfJZonZ+NfPe
 67q2jklcWHSTcrjLcJc+gX7i+JJfdhW5TB8iArslR2IjLquqS2X8qXprjOPRsZrP5Sgg
 YAdgEgXffFiWpEOlsJVxh36nlUC4XeAjWl4IgWcImrvdI6PccDkfLDI57bqKCHW+7MVY
 dullUEjq/Cms3fhaxmLfFU7nF5eZutZhq52SKf5coBk1fabU+qaMr08m143EX8AGjQIY Mw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t40tart0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 14:48:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EEmuLj018476
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 14:48:56 GMT
Received: from [10.111.183.186] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 07:48:55 -0700
Message-ID: <7855cee1-c554-40b7-885f-d7f8d3d90979@quicinc.com>
Date:   Thu, 14 Sep 2023 07:48:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 6/9] wifi: ath10k: Remove unnecessary
 (void*) conversions
Content-Language: en-US
To:     Wu Yunchuan <yunchuan@nfschina.com>, <kvalo@kernel.org>,
        <toke@toke.dk>
CC:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20230914040517.1170024-1-yunchuan@nfschina.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230914040517.1170024-1-yunchuan@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UFWaF2sTRwLgOAH9vtvK2J8JDZ4uPXlr
X-Proofpoint-ORIG-GUID: UFWaF2sTRwLgOAH9vtvK2J8JDZ4uPXlr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=611 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2023 9:05 PM, Wu Yunchuan wrote:
> No need cast (void*) to (struct htt_rx_ring_setup_ring32 *),
> (struct htt_rx_ring_setup_ring64 *), (struct ath_softc *)
> or (struct ath_hw *).
> 
> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
> ---
>   drivers/net/wireless/ath/ath10k/htt_tx.c | 6 ++----
>   drivers/net/wireless/ath/ath9k/pci.c     | 6 +++---

ath9k change should be in a separate patch since it has a different 
maintainer than ath10k

