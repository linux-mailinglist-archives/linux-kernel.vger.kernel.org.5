Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F97766DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbjG1NC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbjG1NCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:02:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28FE3A8D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:02:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so22341775e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690549336; x=1691154136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0IweAoRlrs81Hqx3ju5nKOAZc7hekwdByAQiZx3BgI=;
        b=MFIkdh2MxKwZLX00E+7feiCDIvAAfb+BjKqW1IYNP9UN+HZbLXUXjV3zIGMQtXOjrz
         ljVocwo7jsA+CZLnvltvU+cqIYP7zwcGnDSI6GA0W7czWDL19UmROBhbo6JtVK5wkW2H
         r6MKh85kYkdzrREN+SPXU2ctkr5nS3Vsxu/o93KCsqmdis81mV9pcHtq9KooPM1d5L3K
         ExdpkIK/rh/dDXyYxwhmq5POxbiTmkfMg4wa01ZMPXlB38xDJ0I5739PFy6ujC8yHVvt
         JA95yIC6iHks4izPJBfwVj5HfqT28YGi5BKfjwhaCBKY+IOF4AvoA+UHhMVk/HbjBHzi
         6YgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690549336; x=1691154136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0IweAoRlrs81Hqx3ju5nKOAZc7hekwdByAQiZx3BgI=;
        b=klPG+o1HFkJRFAr27Kz2gjy61QTlug6ctMv5a26Nj5061JzVikGsfaGoTeFKVsku7M
         EbrrxVk2V8CJkcI/Lu1UXya4sPdnRmkE9/Nzj4lbesLTcDpxobITNkyqvA3+etOSMvXB
         0svEjuNditHUEHZ0VrSRNCnFs/RIhZLz+RMQHH4oJFiS8pMZ4SavvLLjIY9b/0nxy6Es
         JlyH9eqMeonGXcwZ1YLR/4gBRyAgMyleQ4tVtXGn517OUq8UdHulVjzI4g6jLrd7E7c+
         MsJg2QjWgMxDbSCKod8MMSqcXsvnMgA6vGr9xq30hElXTq+m/IcKJgDALSBfqLNzz9Uu
         kTQQ==
X-Gm-Message-State: ABy/qLbQsyWWxHK7MjoI+7oofGPtMy7H14Gk6NFafGC/RCxSzOg7+KZv
        D3WBe2XPv0KE308AWuZ4pWWh/Q==
X-Google-Smtp-Source: APBJJlE6Qtmoe8hIQ8IB/hjAI5S514771NnW9Mpe7jo8MzfBMxn3T4fQGMpr8MjUP0wB+/7mlCn3Bw==
X-Received: by 2002:a05:600c:2288:b0:3f6:9634:c8d6 with SMTP id 8-20020a05600c228800b003f69634c8d6mr1572683wmf.18.1690549335836;
        Fri, 28 Jul 2023 06:02:15 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c025200b003fd2d33f972sm6925221wmj.38.2023.07.28.06.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:02:15 -0700 (PDT)
Message-ID: <b6c962ad-d5f5-bcb2-42b6-7d956b0ec3de@baylibre.com>
Date:   Fri, 28 Jul 2023 15:02:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v6 11/11] drm/mediatek: gamma: Program gamma LUT
 type for descending or rising
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
 <20230727094633.22505-12-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230727094633.22505-12-angelogioacchino.delregno@collabora.com>
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
> All of the SoCs that don't have dithering control in the gamma IP
> have got a GAMMA_LUT_TYPE bit that tells to the IP if the LUT is
> "descending" (bit set) or "rising" (bit cleared): make sure to set
> it correctly after programming the LUT.

-- 
Regards,
Alexandre
