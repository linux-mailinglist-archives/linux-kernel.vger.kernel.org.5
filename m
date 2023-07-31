Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF9976A1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjGaUJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGaUJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:09:57 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1965210E;
        Mon, 31 Jul 2023 13:09:56 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-686f1240a22so4521280b3a.0;
        Mon, 31 Jul 2023 13:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690834195; x=1691438995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AI4CujaNtYeF5hv5C0iQj+O+gsyjq+RPXX+49iej8jk=;
        b=iMWUvm30WPJ+InO4LiU4R7O15kJxkJpsC/Cmkcw8MN7ISjrOdqSmPYJ0QdpnRUGKe/
         xnf9wsUs82ts4yyCA3yHLfwOxWZIMrfcHxyo4ItZgO7oEmySPQm+BdtS4h74x2yDqbkl
         4V5Mbu6FBV3yssLReeQK/Gs8+MbMy2liD76BCPIapO//3dI/UnKgggoV3u/o3H+hSdMP
         s0+UuUpH2rH25vujeKbKeJcj+0OsseyCBAJyT4sNZiC3L7kbV5yfGhhA2vmP3fyAFI8y
         PreZRMy1EyATeK3JUlTseTUG+4eR5LmrjqglJSZApUtYt4e5xnP/AKHT/Lh7Bvw8ug9n
         JR/A==
X-Gm-Message-State: ABy/qLZZfNPS1MgbHdR0sqnkf0G+CwZDNB/wRej/a4/V+3GfXdFCw4eM
        oK3i4KvGHWMH8vwnYiA2Yws8M1ugWWI=
X-Google-Smtp-Source: APBJJlGD9BFqBsPyVCD8WhVzNiRQAykAg4ZdwzwOH58GdD4DOzhhvI8dNh9zFOkd6Ef/MQ4lviHg0g==
X-Received: by 2002:a05:6a20:549b:b0:121:e573:3680 with SMTP id i27-20020a056a20549b00b00121e5733680mr12741513pzk.62.1690834195090;
        Mon, 31 Jul 2023 13:09:55 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ee35:83be:6601:9c01? ([2620:15c:211:201:ee35:83be:6601:9c01])
        by smtp.gmail.com with ESMTPSA id e3-20020aa78243000000b006866a293e58sm8148401pfn.176.2023.07.31.13.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 13:09:54 -0700 (PDT)
Message-ID: <43cd0057-c6d8-bc92-08f4-d767336d2cfe@acm.org>
Date:   Mon, 31 Jul 2023 13:09:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] scsi: ufs: qcom: Add support for scaling
 interconnects
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
References: <20230731145020.41262-1-manivannan.sadhasivam@linaro.org>
 <20230731145020.41262-3-manivannan.sadhasivam@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230731145020.41262-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 07:50, Manivannan Sadhasivam wrote:
> +struct __ufs_qcom_bw_table {
> +	u32 mem_bw;
> +	u32 cfg_bw;
> +} ufs_qcom_bw_table[MODE_MAX + 1][QCOM_UFS_MAX_GEAR + 1][QCOM_UFS_MAX_LANE + 1] = {
> +	[MODE_MIN][0][0]		   = { 0,		0 }, /* Bandwidth values in KB/s */
> +	[MODE_PWM][UFS_PWM_G1][UFS_LANE_1] = { 922,		1000 },
> +	[MODE_PWM][UFS_PWM_G2][UFS_LANE_1] = { 1844,		1000 },
> +	[MODE_PWM][UFS_PWM_G3][UFS_LANE_1] = { 3688,		1000 },
> +	[MODE_PWM][UFS_PWM_G4][UFS_LANE_1] = { 7376,		1000 },
> +	[MODE_PWM][UFS_PWM_G1][UFS_LANE_2] = { 1844,		1000 },
> +	[MODE_PWM][UFS_PWM_G2][UFS_LANE_2] = { 3688,		1000 },
> +	[MODE_PWM][UFS_PWM_G3][UFS_LANE_2] = { 7376,		1000 },
> +	[MODE_PWM][UFS_PWM_G4][UFS_LANE_2] = { 14752,		1000 },
> +	[MODE_HS_RA][UFS_HS_G1][UFS_LANE_1] = { 127796,		1000 },
> +	[MODE_HS_RA][UFS_HS_G2][UFS_LANE_1] = { 255591,		1000 },
> +	[MODE_HS_RA][UFS_HS_G3][UFS_LANE_1] = { 1492582,	102400 },
> +	[MODE_HS_RA][UFS_HS_G4][UFS_LANE_1] = { 2915200,	204800 },
> +	[MODE_HS_RA][UFS_HS_G1][UFS_LANE_2] = { 255591,		1000 },
> +	[MODE_HS_RA][UFS_HS_G2][UFS_LANE_2] = { 511181,		1000 },
> +	[MODE_HS_RA][UFS_HS_G3][UFS_LANE_2] = { 1492582,	204800 },
> +	[MODE_HS_RA][UFS_HS_G4][UFS_LANE_2] = { 2915200,	409600 },
> +	[MODE_HS_RB][UFS_HS_G1][UFS_LANE_1] = { 149422,		1000 },
> +	[MODE_HS_RB][UFS_HS_G2][UFS_LANE_1] = { 298189,		1000 },
> +	[MODE_HS_RB][UFS_HS_G3][UFS_LANE_1] = { 1492582,	102400 },
> +	[MODE_HS_RB][UFS_HS_G4][UFS_LANE_1] = { 2915200,	204800 },
> +	[MODE_HS_RB][UFS_HS_G1][UFS_LANE_2] = { 298189,		1000 },
> +	[MODE_HS_RB][UFS_HS_G2][UFS_LANE_2] = { 596378,		1000 },
> +	[MODE_HS_RB][UFS_HS_G3][UFS_LANE_2] = { 1492582,	204800 },
> +	[MODE_HS_RB][UFS_HS_G4][UFS_LANE_2] = { 2915200,	409600 },
> +	[MODE_MAX][0][0]		    = { 7643136,	307200 },
> +};

Why has the above data structure not been declared as 'static const'?

Thanks,

Bart.
