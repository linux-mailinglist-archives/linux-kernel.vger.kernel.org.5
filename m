Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA087E4A29
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbjKGU4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbjKGU4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:56:07 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEB510CC;
        Tue,  7 Nov 2023 12:56:05 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b565722c0eso3665886b6e.2;
        Tue, 07 Nov 2023 12:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699390564; x=1699995364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6Rou90ZC/YyyJYxVbEOGHfj5WMXYWOx1f+Ff7XOa1I=;
        b=kJFUmv/ZA9/G2P+0wIHxM+Rr5zXCIwmeWWtk/GffoM23Msp2zpDT0tu0rlBKWtNgIB
         6dPxp3fagbPuJbB4gl3JBlodnRO98WxhWFJlnq7VIB3GKxDFMlZ2Y8drUGF3AqT2xrAv
         cwKGLrlTFctN8aEiUUY8U2QnoEpdRtLW9IEGlAbWYb4ch10co96Jj3J98XtBEPVynPWa
         GOz8yYf82HD7YKospHyej3BA4tHylLblAQcwoxWRzXj5RpJ9kbHXKVI/vSJURTBa0Yxz
         AvzldFDcWmKnSclWLPz2sHGLU1x4x3C1kogyXx9E/cPJXQTKmjrMW8x//Vm7msijQTFG
         vhyQ==
X-Gm-Message-State: AOJu0YyPlKBLRmE/m7vm8VJVODatOl7rZl9X0/54Er3Q+5NNXxCbyRIK
        Apti5hnRdeVdA1mIvu7fj5s=
X-Google-Smtp-Source: AGHT+IHaVgJsDpMhGNCp2vy1e2k6VSsMSNXCGuVJSbryRe2BREjphu4QS4E0vpDG6xSv+mpyajdD2g==
X-Received: by 2002:a05:6808:3993:b0:3b5:ae0d:b208 with SMTP id gq19-20020a056808399300b003b5ae0db208mr213931oib.6.1699390564172;
        Tue, 07 Nov 2023 12:56:04 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:403c:7209:147d:958d? ([2620:0:1000:8411:403c:7209:147d:958d])
        by smtp.gmail.com with ESMTPSA id x11-20020aa784cb000000b006b225011ee5sm7644220pfn.6.2023.11.07.12.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 12:56:03 -0800 (PST)
Message-ID: <74f98f63-3200-4485-bbf0-819800837ee9@acm.org>
Date:   Tue, 7 Nov 2023 12:56:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] scsi: ufs: host: Rename structure ufs_dev_params
 to ufs_host_params
Content-Language: en-US
To:     Can Guo <cang@qti.qualcomm.com>, quic_cang@quicinc.com,
        mani@kernel.org, stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Brian Masney <bmasney@redhat.com>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-mediatek@lists.infradead.org>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <1699332374-9324-2-git-send-email-cang@qti.qualcomm.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1699332374-9324-2-git-send-email-cang@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 20:46, Can Guo wrote:
>   /**
> - * ufshcd_get_pwr_dev_param - get finally agreed attributes for
> + * ufshcd_negotiate_pwr_param - get finally agreed attributes for
>    *                            power mode change

Since you are renaming the function, please also change the description
of the function into something more meaningful, e.g. "find power mode
settings that are supported by both the controller and the device".

> - * @pltfrm_param: pointer to platform parameters
> + * @host_param: pointer to platform parameters

Please make sure that the argument name and argument description are in
sync.

Thanks,

Bart.
