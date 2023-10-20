Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF337D0D35
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376914AbjJTKca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376907AbjJTKc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:32:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821FED52
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:32:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32d8c2c6dfdso456417f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697797944; x=1698402744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=igrslGOc8lOfnbcsO3yOOnOBbB2z/+ZB5557ersesus=;
        b=COix8rpRK0gECbprls+QXHnDCg1Z9FbNGRogAEbOrFiXgZ061joGgNvVjBHYDrdSmD
         N33CJr9SIH/7MlnE0UrxW0xdXKWu0Ufhwge91bnE53zKIT1VCOeLSz1xdT2n0+rlauXx
         vvDpmDmiGIRE3SpcVb4KKHx2lNPuQ7MIs530PSXKSH4lJLeb85Ac2ZlUM/tbxeODaIgL
         Sbpn2L2lt3uuXhDuMksx74NLrJR8u4mWlILQ/sz5AnZ533k5/nTRZ3r7ssWE+1JcSi0/
         iFt4H5xv6ZSoRny/Nn1F0xUs0cyfkifHbEtOBshUFj/7xOlnkN+2zD14pbLnpDaMopqn
         ZYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697797944; x=1698402744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igrslGOc8lOfnbcsO3yOOnOBbB2z/+ZB5557ersesus=;
        b=AhiGGwfy/OpCKKuWey3y5erb8JZKSzorwMQZKjakYU6WG55CWxFBWZVrTGtYCFFHtn
         wbOraKXSiOXwQBlQsy3AVLk6yCJj3ifvs8FGt/KplAV/3+wDcc+gklilrO/Wn6tSA1ET
         lBSswCscU0Xl+0j0r6+Y3DBhVb6Z1g6r+uMG65NFyRjHrIjKN7c1IpSVrp6Cmd3sR0ow
         MxJB/iC6Q62eCS7QiLbb/Kiv+GDZrG0gPqqmODesaneuuvDUre4ajdplWqW9IbVQ4x/s
         Jgg+698kflavH5i7VaUjvqQ0cDyIFPBCL3llYnPVtXspA6Nix0UC9eB6rIwXYseLDIiZ
         Pocw==
X-Gm-Message-State: AOJu0YygNMmh/ikU+ofR0ePFAf7KxuP1bI5+ItSxP2X+Thq5cN9JowZh
        PDYuyJ16/fmNPMfLlX6lJJ5d/Q==
X-Google-Smtp-Source: AGHT+IHvZz/X5JQHO3BEuu44B8mjF8wsdVBvnEP3zzsL+PMw2pSuhiBl3H5XEium7IMjvWbKbHSz2g==
X-Received: by 2002:adf:ec03:0:b0:32d:d879:1c3 with SMTP id x3-20020adfec03000000b0032dd87901c3mr1041129wrn.31.1697797943877;
        Fri, 20 Oct 2023 03:32:23 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id y10-20020a5d470a000000b0032d9efeccd8sm1396888wrq.51.2023.10.20.03.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 03:32:23 -0700 (PDT)
Message-ID: <b372ef8c-7f3f-483b-8cc2-d927a60050be@baylibre.com>
Date:   Fri, 20 Oct 2023 12:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: mtk-jpeg: Fix use after free bug due to error path
 handling in mtk_jpeg_dec_device_run
Content-Language: en-US
To:     Zheng Wang <zyytlz.wz@163.com>, dmitry.osipenko@collabora.com
Cc:     Kyrie.Wu@mediatek.com, bin.liu@mediatek.com, mchehab@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        wenst@chromium.org, stable@vger.kernel.org
References: <20231020040732.2499269-1-zyytlz.wz@163.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20231020040732.2499269-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 20/10/2023 06:07, Zheng Wang wrote:
> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with 
> mtk_jpeg_job_timeout_work. In mtk_jpeg_dec_device_run, if error happens 
> in mtk_jpeg_set_dec_dst, it will finally start the worker while mark the 
> job as finished by invoking v4l2_m2m_job_finish. There are two methods 
> to trigger the bug. If we remove the module, it which will call 
> mtk_jpeg_remove to make cleanup. The possible sequence is as follows, 
> which will cause a use-after-free bug. CPU0 CPU1 mtk_jpeg_dec_... | 
> start worker | |mtk_jpeg_job_timeout_work mtk_jpeg_remove | 
> v4l2_m2m_release | kfree(m2m_dev); | | | v4l2_m2m_get_curr_priv | 
> m2m_dev->curr_ctx //use If we close the file descriptor, which will call 
> mtk_jpeg_release, it will have a similar sequence. Fix this bug by start 
> timeout worker only if started jpegdec worker successfully so the 
> v4l2_m2m_job_finish will only be called on either 
> mtk_jpeg_job_timeout_work or mtk_jpeg_dec_device_run. This patch also 
> reverts commit c677d7ae8314 ("media: mtk-jpeg: Fix use after free bug 
> due to uncanceled work") for this patch also fixed the use-after-free 
> bug mentioned before. Before mtk_jpeg_remove is invoked, 
> mtk_jpeg_release must be invoked to close opened files. And it will call 
> v4l2_m2m_cancel_job to wait for the timeout worker finished so the 
> canceling in mtk_jpeg_remove is unnecessary.

-- 
Regards,
Alexandre
