Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A1F7FA645
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjK0QXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjK0QXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:23:06 -0500
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FFE99
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:23:13 -0800 (PST)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTPS
        id 7Uf5rd1dzKOkL7eO8rQanB; Mon, 27 Nov 2023 16:23:12 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 7eO6rzmjt1b9N7eO7rsZxu; Mon, 27 Nov 2023 16:23:11 +0000
X-Authority-Analysis: v=2.4 cv=FLYIesks c=1 sm=1 tr=0 ts=6564c26f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=yGeM7+xMb5a5VK1DGQx1ew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=COk6AnOGAAAA:8
 a=Ln01kCxmXRaHJmvONIYA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=TjNXssC_j7lpFel5tvFf:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+Q7Pri0fJihW9QCH27OFmaRs5wYVEoLLYvRhIYgKafM=; b=caFWUgSLCTaYPsXEwcpS88m2tX
        Wae30zMmAoCLFoGLaGiozVIJlBLvvIoCg6iC7IbwjWF2Vgy/9iFq4q6tZbtG+uHbSrNTpBQmtS/uB
        udxzNMAzpsmSWp+trbQHVlOWY/9NExYuF0rXrC5A0ADTpzEVyBV4hMfHYlNg9/ng03rnpwTRWcNxp
        KxBUC1/OBl6qs/qq/5Q4+j8PA3AjmXI2UIN3SmyMUTV70kzuNu1KUnYOPhpwwTzsjM0PAIL0HRQ1f
        mr6hrmjU3BoNpYx1ZuQIymER6Xv+yUa78lQQfxuJmecO2wzK7/K7ZOZSfoev5GorSX/SzXG7TTXBf
        94flIJXg==;
Received: from 187.184.157.122.cable.dyn.cableonline.com.mx ([187.184.157.122]:35864 helo=[192.168.0.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r7eO6-003aet-0l;
        Mon, 27 Nov 2023 10:23:10 -0600
Message-ID: <4f2a486c-c6de-43e4-8bb6-bdd3f819b0a9@embeddedor.com>
Date:   Mon, 27 Nov 2023 10:23:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] wifi: ath11k: Use DECLARE_FLEX_ARRAY() for
 ath11k_htc_record
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231127-flexarray-htc_record-v1-0-6be1f36126fd@quicinc.com>
 <20231127-flexarray-htc_record-v1-4-6be1f36126fd@quicinc.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231127-flexarray-htc_record-v1-4-6be1f36126fd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.122
X-Source-L: No
X-Exim-ID: 1r7eO6-003aet-0l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.122.cable.dyn.cableonline.com.mx ([192.168.0.9]) [187.184.157.122]:35864
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP0lXrsOs5tRBu7MUOflQBrJZ+Vf2NwaiByrNVqFkvNs5YOB7U4bSqiP6rOnuxjtGm2uiAYtjm0ZsTCLLuuLNcVQuaqgwX7Kf8oz50FKij8ZDlVQ16wz
 Dx4dNDWzAGwMb6nsUAdf97W3GbxTB7kiFoDH5eR++/PYnHsd/EFQF84OvKyUW4KcRW1MvXZeLkmaPfwooMV37ri2mPfPwe1BDRDbUT80lsaqqB3oj17Hv1cD
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/23 10:14, Jeff Johnson wrote:
> Transform the zero-length array in ath11k_htc_record into a proper
> flexible array via the DECLARE_FLEX_ARRAY() macro. This helps with
> ongoing efforts to globally enable -Warray-bounds.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/htc.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/htc.h b/drivers/net/wireless/ath/ath11k/htc.h
> index 84971cc9251c..e0434b29df70 100644
> --- a/drivers/net/wireless/ath/ath11k/htc.h
> +++ b/drivers/net/wireless/ath/ath11k/htc.h
> @@ -151,7 +151,7 @@ struct ath11k_htc_credit_report {
>   struct ath11k_htc_record {
>   	struct ath11k_htc_record_hdr hdr;
>   	union {
> -		struct ath11k_htc_credit_report credit_report[0];
> +		DECLARE_FLEX_ARRAY(struct ath11k_htc_credit_report, credit_report);
>   	};

Why not removing the `union` and just do a direct transformation [0] -> [ ] ?

--
Gustavo

