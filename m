Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BF376B66D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjHANz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbjHANzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:55:47 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D4F1BCC;
        Tue,  1 Aug 2023 06:55:44 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3719k4VI008191;
        Tue, 1 Aug 2023 15:55:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=MLBE3FzrM2b0nVsbnwYAb0B63uPqrpp4S1Mc+KvXP80=; b=Sg
        dEd91Zu30DuWa7GryPAwP1LXYKLL2tpmI8no5QnvkkOsFgg/+ekkRKfHR87XnvV1
        XW9gPHgDUY1zxJLMRnxX0zZr9kycIB1PBgkdDaNVq0yZUvFrSfSBdCjxRakKLy5i
        0iCrSaGslEvwfGAHO+ZoBN8yejkMLsfd3BKG8eTfzIvZt1/whpmGNyiR0IbvU14h
        X25yQfvk75roCaR+lLM45joaRH5VtQsgCFfkVIvJXd1LMM3FGpNM6Y03EhJRK2dl
        L/Bmn3Yl3gl2nzE4JH+F0BzO/RCSgEgapR+Sfub18jwqK2NVprphpZA4RlzvLiJc
        hw/ptO6cPsz0VNtXBDuw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s6yq6sfbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 15:55:10 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C10B9100080;
        Tue,  1 Aug 2023 15:55:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9440A22A6EC;
        Tue,  1 Aug 2023 15:55:08 +0200 (CEST)
Received: from [10.201.20.168] (10.201.20.168) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 1 Aug
 2023 15:55:07 +0200
Message-ID: <a7a373b7-1f3e-3b17-e323-cb636816fb99@foss.st.com>
Date:   Tue, 1 Aug 2023 15:55:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] rtc: stm32: remove incorrect #ifdef check
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Christophe Guibout <christophe.guibout@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        <linux-rtc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230801105932.3738430-1-arnd@kernel.org>
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <20230801105932.3738430-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_09,2023-08-01_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for your patch !

On 8/1/23 12:59, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> After a previous commit changed the driver over to
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(), the suspend/resume
> functions must no longer be hidden behind an #ifdef:
>
> In file included from include/linux/clk.h:13,
>                   from drivers/rtc/rtc-stm32.c:8:
> drivers/rtc/rtc-stm32.c:927:39: error: 'stm32_rtc_suspend' undeclared here (not in a function); did you mean 'stm32_rtc_probe'?
>    927 |         SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_rtc_suspend, stm32_rtc_resume)
>        |                                       ^~~~~~~~~~~~~~~~~
> include/linux/kernel.h:58:44: note: in definition of macro 'PTR_IF'
>     58 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
>        |                                            ^~~
> include/linux/pm.h:329:26: note: in expansion of macro 'pm_sleep_ptr'
>    329 |         .suspend_noirq = pm_sleep_ptr(suspend_fn), \
>        |                          ^~~~~~~~~~~~
>
> Fixes: fb9a7e5360dc8 ("rtc: stm32: change PM callbacks to "_noirq()"")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Valentin Caron <valentin.caron@foss.st.com>
> ---
>   drivers/rtc/rtc-stm32.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
> index 85689192fa7ae..c296e7af0700c 100644
> --- a/drivers/rtc/rtc-stm32.c
> +++ b/drivers/rtc/rtc-stm32.c
> @@ -890,7 +890,6 @@ static void stm32_rtc_remove(struct platform_device *pdev)
>   	device_init_wakeup(&pdev->dev, false);
>   }
>   
> -#ifdef CONFIG_PM_SLEEP
>   static int stm32_rtc_suspend(struct device *dev)
>   {
>   	struct stm32_rtc *rtc = dev_get_drvdata(dev);
> @@ -921,7 +920,6 @@ static int stm32_rtc_resume(struct device *dev)
>   
>   	return ret;
>   }
> -#endif
>   
>   static const struct dev_pm_ops stm32_rtc_pm_ops = {
>   	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_rtc_suspend, stm32_rtc_resume)
