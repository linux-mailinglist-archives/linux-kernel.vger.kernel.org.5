Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65E976F6D2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 03:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjHDBPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 21:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjHDBPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 21:15:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAB54204;
        Thu,  3 Aug 2023 18:15:33 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RH73T4FQFzNmkn;
        Fri,  4 Aug 2023 09:12:05 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 09:15:31 +0800
Message-ID: <7c8be7f7-5757-5888-567d-d72f749aaa3a@huawei.com>
Date:   Fri, 4 Aug 2023 09:15:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] wifi: ath5k: Remove redundant dev_err()
Content-Language: en-US
To:     <jirislaby@kernel.org>, <mickflemm@gmail.com>, <mcgrof@kernel.org>,
        <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230726171235.2475625-1-ruanjinjie@huawei.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230726171235.2475625-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

On 2023/7/27 1:12, Ruan Jinjie wrote:
> There is no need to call the dev_err() function directly to print a custom
> message when handling an error from platform_get_irq() function as it is
> going to display an appropriate error message in case of a failure.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/wireless/ath/ath5k/ahb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath5k/ahb.c b/drivers/net/wireless/ath/ath5k/ahb.c
> index 28a1e5eff204..08bd5d3b00f1 100644
> --- a/drivers/net/wireless/ath/ath5k/ahb.c
> +++ b/drivers/net/wireless/ath/ath5k/ahb.c
> @@ -115,7 +115,6 @@ static int ath_ahb_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(&pdev->dev, "no IRQ resource found: %d\n", irq);
>  		ret = irq;
>  		goto err_iounmap;
>  	}
