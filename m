Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6DC76D315
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjHBP5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjHBP45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:56:57 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7344A199F;
        Wed,  2 Aug 2023 08:56:51 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1bb84194bf3so875ad.3;
        Wed, 02 Aug 2023 08:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690991810; x=1691596610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DUYdxnB2FNg3/y055eS3dja8IzXKkYToY1e5G8lvIE=;
        b=iZFJPGzOKD4kuZELBjxisC36JMXIalGDi+lqY3ebDMR+uuXO+eIf1v0QtHUfTBHFD7
         BWgFbeVYTqRvtWryw4cGpcS2N7VlW0BEdopdDRwEjNrE86IUzsYinq5W8KbUaNMPNmdd
         z3xSYLG4Lcp82if/vNRTpwAPLbiQkfVEPeKqdTF3MSk6GkPgC/2L5Cbaf4Icv8UbPCfA
         Xc53JConNNEAFDZR9vxxuK4uKt4Aa6jRhjjI0pSVzNpBU+MCEOBrdr/54fVB6CNxIKpY
         Xvb0qsNIe05Zdcnhe1XxFw4+kXyTGyTkGnzU8LLcj3C1bNdu2gLeZ+0TivfVZq0u3TGX
         VT0g==
X-Gm-Message-State: ABy/qLai8Ez2rMYIB0E5jHB1OoSxa1Hl9Y7gdydYBNNBtMpM5xuj38CJ
        yWjwhJq5RXNesQT17z2LEQQ=
X-Google-Smtp-Source: APBJJlGf1pSqV9JSKYgTp/bl7ILF6WcP5BFRWmnG+g9QT6rddzR3jFN5rGzwa7EawiOqJVC/rU96+Q==
X-Received: by 2002:a17:902:dacf:b0:1bb:b74c:88f6 with SMTP id q15-20020a170902dacf00b001bbb74c88f6mr17926330plx.16.1690991810237;
        Wed, 02 Aug 2023 08:56:50 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3b5d:5926:23cf:5139? ([2620:15c:211:201:3b5d:5926:23cf:5139])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b001b8b2fb52d4sm12599048plh.203.2023.08.02.08.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 08:56:49 -0700 (PDT)
Message-ID: <3c6bd78b-c716-1c47-6d82-f6551e85251e@acm.org>
Date:   Wed, 2 Aug 2023 08:56:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] scsi: ufs: qcom: Make struct ufs_qcom_bw_table static
 const
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230802040154.10652-1-manivannan.sadhasivam@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230802040154.10652-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/23 21:01, Manivannan Sadhasivam wrote:
> ufs_qcom_bw_table is not modified anywhere. So make it static const so that
> it can be placed in read-only memory.
> 
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Closes: https://lore.kernel.org/linux-scsi/43cd0057-c6d8-bc92-08f4-d767336d2cfe@acm.org/
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/ufs/host/ufs-qcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 75a1fd295f34..0341c025e818 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -58,7 +58,7 @@ enum {
>   	MODE_MAX,
>   };
>   
> -struct __ufs_qcom_bw_table {
> +static const struct __ufs_qcom_bw_table {
>   	u32 mem_bw;
>   	u32 cfg_bw;
>   } ufs_qcom_bw_table[MODE_MAX + 1][QCOM_UFS_MAX_GEAR + 1][QCOM_UFS_MAX_LANE + 1] = {

Thanks!

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
