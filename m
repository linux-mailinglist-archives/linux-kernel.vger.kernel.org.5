Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BDF766DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbjG1NCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbjG1NCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:02:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A613AAE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:01:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so21090785e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690549316; x=1691154116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KM9G9UWL460MIs8mOf1NTrNT8jPvFV0ecdNaflzST6o=;
        b=046PezP1WWtv6k0s1Qd7IazqPsZ7Mc4/Cb5Xdfdcm0LGbRFNtDxy7tcvfk4heZHqtK
         kuMMgOAAKuEMn4VsPefhlYkxjN3+a+0AAVZSGxx5ZBpMpmo3scR6Q5BKPhglz9jEvCMT
         xRUDEYA38LxXpU6hmyVMGBwJZF5IVOhGPvcF15Jz/hf7o35Uvp3CGGnc9wb0JxTzqf4z
         rgOeqCF4C2LO3bECXABhd3Hy+N++80m4QGxugzp5/4l4IgeVZhx6/7A65jfmEIdQH75K
         2px4uO1TbhQnQNnPeSiq1AokeTglJQwp8RcqM1TddI086DLJQzovjITFToz/yCeHg7jy
         JV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690549316; x=1691154116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KM9G9UWL460MIs8mOf1NTrNT8jPvFV0ecdNaflzST6o=;
        b=R9qesqHZU9SAJxpfDauI8meVDluI9T/9+aDmkwOntn2HeEHogVbir7yw7PjBpqapUc
         v58+omRq8S/MXm/dsusH7AHrNj6S9YfX9gWGgFDpksLivAkg2akbVIMtWM+xttWiGi5W
         NMLmDvkH/A4euZcNdoBLHlIJ/ZSD5hjtgysSAQzoIpGpmb+QbdUR96H2d/3V4JSV65Kw
         mcQdePPR/x6a02q8EgMfmP12vHf2eSb4cxO/gyy1Z5NrljTeuy2joVxXEALLilsa993S
         DLIJcaLPijoAyIlJW//tVMz1nSgigjfpsij4BZ38noQuAJpTS7XE13Mk3PvIhjXzfPcr
         q/zA==
X-Gm-Message-State: ABy/qLYuzPx3+9z9y9mTfMOmbSPvT61lNd15uWnkdUJYk4TNMOPWoq9J
        6/OyL4MDZVsgLb2R0bZy+a9nwg==
X-Google-Smtp-Source: APBJJlEDFKNwbvv1WM27Au+d3FTJnT6D4PrRXlESZAGL6BtAJ9OoikVkz4a+s3hD1klzf2rdjQLeLg==
X-Received: by 2002:a05:600c:214d:b0:3fb:9ef2:157 with SMTP id v13-20020a05600c214d00b003fb9ef20157mr1592571wml.28.1690549316788;
        Fri, 28 Jul 2023 06:01:56 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003fa95f328afsm1505130wmi.29.2023.07.28.06.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:01:56 -0700 (PDT)
Message-ID: <e0d09d7f-09a3-748f-426f-beba43413fc7@baylibre.com>
Date:   Fri, 28 Jul 2023 15:01:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v6 10/11] drm/mediatek: gamma: Make sure relay mode
 is disabled
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>
References: <20230727094633.22505-1-angelogioacchino.delregno@collabora.com>
 <20230727094633.22505-11-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230727094633.22505-11-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 27/07/2023 11:46, AngeloGioacchino Del Regno wrote:
> Disable relay mode at the end of LUT programming to make sure that the
> processed image goes through.

-- 
Regards,
Alexandre
