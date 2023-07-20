Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD2375AF1B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjGTNFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGTNFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:05:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6D0FC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:05:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e29ede885so1003505a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689858304; x=1690463104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXEWaHqf0lWHOwfVBdFzP3gPi6ixm8kTT6knvLIOnrY=;
        b=wT923Xj1PAqxw+yaDhNJ/nUV/1XxpP2YqGKBg93pGqqICwOMUb0dd2qWkGps0F3RWv
         A9BYnTGB8k2Ky18llb2v3KVscxfx2n4NbBZYQU/nOjTRUYeVcwKvrbIxDaW5nFs/0hTf
         UGUk7Fr17e1IEPgeF1Qzvuole9rel2kVwbOhNDixj/ikRtx5sIMldhYoKXFxzBIthrSh
         HgCaqAFjrzZqqcNquDtWyne4GU/oTbwe4otfgdZA1SZA1EwVN6MRKYsbgrko6pkWXyjg
         uMpLOexle7flElpiGnShLxE4u16lsZnmcYSklUTMtphFCpZ7tCCpARdDy9JR1qqSSoot
         l6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689858304; x=1690463104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXEWaHqf0lWHOwfVBdFzP3gPi6ixm8kTT6knvLIOnrY=;
        b=ga3Id1bkcZT+Bp/vPlUhAClBEONIdcv6/MD5ubm7t1SgRK5MO92grVhzR3Z5gcHqxz
         nYPC1KAn6b9XzsqUcUKx0RCdCTP4McFf/bbGHZ4cFfC6cQmL41OBt+wx9Dq1KOVVMPmc
         9uKUlp1WE3tVYELji4PkHle3rO1lEe9a3DpmmKvKiUB1LWPEZae+jh2LxlKdN3lk/ehG
         M1es28AA5E4wlnU61MOB6jzD12HHPBXBw0GFf32UUbGlWNolsKxUT8bmyJk8ZNYNuL8n
         G2N1P9RiIjf5qX2V/Ue5KAjY1tN/E1peIkS5RpF5icRRXxgcB4AsAjnfR3F3DzfbSL/1
         wduQ==
X-Gm-Message-State: ABy/qLa62X99kv6lpeUlENruTY5EiMrJWlb5TEa7/0XHAZXDUkQ2tv/U
        4ETEay3kOCTuEHLHk1o/7PoU5w==
X-Google-Smtp-Source: APBJJlF3czr78AaBbYI9Dkak734DtCkiU5pcGw2eai4oYTX2OPvmfRHYRclHZY5ITbbeNeFmedVu8w==
X-Received: by 2002:aa7:c1cc:0:b0:51e:ca0:8a2e with SMTP id d12-20020aa7c1cc000000b0051e0ca08a2emr4997368edp.36.1689858304071;
        Thu, 20 Jul 2023 06:05:04 -0700 (PDT)
Received: from [10.1.3.131] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x19-20020aa7d393000000b0051bec856cb4sm734747edq.50.2023.07.20.06.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 06:05:03 -0700 (PDT)
Message-ID: <9d73d7e8-98ae-e5f1-706d-8c6128f2877b@baylibre.com>
Date:   Thu, 20 Jul 2023 15:05:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 07/11] drm/mediatek: dp: Avoid mutex locks if audio is
 not supported/enabled
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
 <20230717141438.274419-8-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230717141438.274419-8-angelogioacchino.delregno@collabora.com>
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



On 17/07/2023 16:14, AngeloGioacchino Del Regno wrote:
> If a controller (usually, eDP!) does not support audio, or audio is not
> enabled because the endpoint has no audio support, it's useless to lock
> a mutex only to unlock it right after because there's no .plugged_cb().
> 
> Check if the audio is supported and enabled before locking the mutex in
> mtk_dp_update_plugged_status(): if not, we simply return immediately.
> 
> While at it, since the update_plugged_status_lock mutex would not be
> used if the controller doesn't support audio at all, initialize it
> only if `audio_supported` is true.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
