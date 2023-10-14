Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035DD7C91EE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjJNA63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJNA61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:58:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0944191;
        Fri, 13 Oct 2023 17:58:25 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39E0aN6V031312;
        Sat, 14 Oct 2023 00:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2Mn/sALuAGncO7Zfs3mDJhQdbV4y5KH35BwJzbtCZAM=;
 b=WhiUNd5a0vuOSUpe4BF+G9ZmBVZm6akp4HHGKJZ8zjmCzHVdOZiN4PUP7VBIBFBbla4G
 7mFJ4GPoSDzJLTfzRsnoE1z4Nh6J8CiFsJWu6lJvSd3FylZLCGwBdo5kLzH/UNsCVOAu
 ZWhvP5Vsbz4vHwmEvJN06wLz3a1iAss3sK2XLcj2G1eK7CXEbir00SBLiVJpEZICrfm9
 bQgTbE/xrZvtoXiBEjTeg/tHO+kSvCWA/ryAw7QbTLAfYM5NcpvS3MO36qYLMD88WaVo
 UB/Id4N3mgoqF+4EHHEl1hQ+jstQwTpOy0slAAMqKk0PVYLkC1Ljy7fF/yDsuJQxGtqC kg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tq5101f85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Oct 2023 00:58:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39E0w48k025410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Oct 2023 00:58:04 GMT
Received: from [10.48.240.22] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 13 Oct
 2023 17:58:03 -0700
Message-ID: <1cfc7c64-439c-437e-af82-7fce1202242d@quicinc.com>
Date:   Fri, 13 Oct 2023 17:58:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath10k: replace deprecated strncpy with strtomem_pad
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Kalle Valo <kvalo@kernel.org>
CC:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v1-1-24e40201afa3@google.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v1-1-24e40201afa3@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D4pQm2n1GAZ-B8U95Qc8FjHAJ3n19PkZ
X-Proofpoint-GUID: D4pQm2n1GAZ-B8U95Qc8FjHAJ3n19PkZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_12,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=751 spamscore=0 clxscore=1011 adultscore=0 impostorscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310140006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/2023 1:33 PM, Justin Stitt wrote:
> strncpy() is deprecated [1] and we should prefer less ambiguous
> interfaces.
> 
> In this case, arvif->u.ap.ssid has its length maintained by
> arvif->u.ap.ssid_len which indicates it may not need to be
> NUL-terminated, although by virtue of using strtomem_pad (with NUL-byte
> pad character) and having a destination size larger than the source,
> ssid will, incidentally, be NUL-terminated here.
> 
> As strtomem_pad() docs say:
>   * @dest: Pointer of destination character array (marked as __nonstring)
>   * @src: Pointer to NUL-terminated string
>   * @pad: Padding character to fill any remaining bytes of @dest after copy
>   *
>   * This is a replacement for strncpy() uses where the destination is not
>   * a NUL-terminated string, but with bounds checking on the source size, and
>   * an explicit padding character. If padding is not required, use strtomem().
> 
> Let's also mark ath10k_vif.u.ap.ssid as __nonstring.

what criteria is used to determine whether or not to use __nonstring?
doesn't the use of u8 vs char already communicate that distinction?
just want to know what other u8 arrays might require this.
FWIW the documentation referenced by the __nonstring macro explicitly 
refers to "type array of char, signed char, or unsigned char"

> 
> It is unclear to me whether padding is strictly necessary. Perhaps we
> should opt for just strtomem() -- padding certainly doesn't hurt,
> though.

concur that padding probably isn't necessary but doesn't hurt, and will 
prevent confusion if looking at this member in a crashdump

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Either with or without the __nonstring...
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

