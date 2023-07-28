Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F91766DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbjG1NBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbjG1NBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:01:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC623AA9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:01:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso23050445e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690549304; x=1691154104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jb3oJuceNFsIyuY2+c/BQpFgMtKHX3DFUwV7BlO22rQ=;
        b=xKFkf3KeKsEZ7MlGQXbss31BqYAtexCwGSFhibddZbapf6TQJRPQdZl0EH1lvY8NxG
         G8kOfa2vdunheArARTB+wyRiRVC2fGqyz0FffoadHHyxTaAUpzsygZMHFMjd8eWKXoii
         HR6AOfvCvDIlcYo4izDNPHLqsDqoaQ6eNwCGUH8D09oZvPzRrDyh8DmpVtcWbAMpFG7P
         x0Ok1ystdOp8Gb5sHGgdKjlO3biCA3lqMj/r2wWdTNiNBMMRgvvZpfKsrtQuffCcyfc+
         3Kvwy2AKNxM6rudl5W3pIDJ8o6I2Suw6M3aHKEFvJvBfTbOQoYTm9cY0mHDYlc6hLP8g
         Q2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690549304; x=1691154104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jb3oJuceNFsIyuY2+c/BQpFgMtKHX3DFUwV7BlO22rQ=;
        b=fltvHx5RkLPiokJtIqILZGHteEqMrdMRX96V5u83Aafum2+eMFyr+PppgR0I6ETZ0b
         TFmfIIPiYyqrWiVzXpvmH9QTXKRmZwzQWgAY5c+7QaGnkjqcXfliCu1si5g+s6IOAzE8
         CceSyU4XA9CeLp+xb3Lho6WJUZJb1JuTPAYw3vLsHKDb0gOkBjoDf7u9ooLMEHZ+jtNC
         abBcm/xphPBD3B1joQlEnrTamHiBMb3DBBTykXLheTdKvG133OerJbKxX98iwQV4jFC9
         zek+2f3g+D2R0MSR1sx3WPIN1u0eezyb1hCbuGmBFm/grH0eV0mNW0b0Ou9I7ywgJqam
         O0Hw==
X-Gm-Message-State: ABy/qLbM0I0hwnnE3isbfOgbum9AsIV49pr9uaguFtM9QFjNP1Kbmf0I
        tEozq6ivnf3KT25doUfBo5ojtQ==
X-Google-Smtp-Source: APBJJlGKWeFPOrR4SRapsGW6B0B45Wr3r3nXWLAfqntpnpIaERf19EDZd2fNRukT2WrEz3kObz6QYw==
X-Received: by 2002:a1c:f202:0:b0:3fb:a0fc:1ba1 with SMTP id s2-20020a1cf202000000b003fba0fc1ba1mr1846649wmc.35.1690549304029;
        Fri, 28 Jul 2023 06:01:44 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id c8-20020a7bc848000000b003fb40ec9475sm4180321wml.11.2023.07.28.06.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:01:43 -0700 (PDT)
Message-ID: <ec9983bd-b9be-b672-8c26-d887f608de4c@baylibre.com>
Date:   Fri, 28 Jul 2023 15:01:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v6 08/11] drm/mediatek: gamma: Support multi-bank
 gamma LUT
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
 <20230727094633.22505-9-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230727094633.22505-9-angelogioacchino.delregno@collabora.com>
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
> Newer Gamma IP have got multiple LUT banks: support specifying the
> size of the LUT banks and handle bank-switching before programming
> the LUT in mtk_gamma_set_common() in preparation for adding support
> for MT8195 and newer SoCs.

-- 
Regards,
Alexandre
