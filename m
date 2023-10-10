Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307927BFAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjJJMQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjJJMQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:16:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E393299
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:16:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b9faf05f51so701728466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696940186; x=1697544986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nndtjHuMt0cf145zyVj0vZGF/G3X++LPFZ51I696qiM=;
        b=NZZcyXTG6Zx9ltg87ezUNKF4wfdB3C4rTzl+1aA3PX8AprsYgjY/mqCcMaxhxQBvrS
         4K8LAIYFQywW9wdhVr80NkRmBx80CGvk8wCczvO/BepRBLBXt+ybRHQ9TbNyZZPu2U9Y
         iL3saGwWdSlIrP/Bx2NrVJUhe0tmdE0LnW2L+6InLWvSx/Pv5IGhER6ZrZnTzOqO0pHR
         Rb/otAayBVUmO2rhjv+8DgThDAwUQqCC0Pt3ZzgPWpDY3J4tsnedpaW1QuzIeTgrLruj
         zrJJe4suzD2AbT5JYQafYJP1UYFxRcDHXq8vI6jBs9dcnRDs9KO5nonyL35PBMFU7/zb
         kDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696940186; x=1697544986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nndtjHuMt0cf145zyVj0vZGF/G3X++LPFZ51I696qiM=;
        b=siw7XtmuGNecycwQlTFy5HX8bhJ71kuQ2xUbImQfAgmY735JaENmzgxHxMJ58AtL9e
         6QMnNsCatEaaPnhqyzuV4ThWKSGysHnsWeO9wfBmM1Y6KpQHaaw/acgh9CflKZcxb7xP
         qKO5yy6/cvb+TsixJ52bQfIaWMg6c9RXEEvci1A7FFRkyDL0gxmE10GGMG/KhPJrSPDU
         xe0J1z4w9x4w7nyy41VQiKtQ4nRjKmS2EBmkS9Hj+2BfC+HA0MKKSP0ZbyuQrFCY3ac6
         HRgxKFC4i2QebWBImuKnrou6XJi+A0pkmIZGV36ANncEBfK7n29UEnAyh1zUcWiCJgbl
         6KYA==
X-Gm-Message-State: AOJu0YwcnHOxtfUqTpsNB+NNPdJ9bsqRfHXKfJBMWroEjMY9Pa0YhVBY
        v0D3NFZ5RucK26D6SBSYGx8N4w==
X-Google-Smtp-Source: AGHT+IGvbaphCGmTo8kI0FKFqK44m2tAKrLMU9877yBSznrJMtpCLD2SsXe+zSRMlWY5bELacdHCPw==
X-Received: by 2002:a17:907:7711:b0:9b2:a96c:9290 with SMTP id kw17-20020a170907771100b009b2a96c9290mr15848525ejc.33.1696940186336;
        Tue, 10 Oct 2023 05:16:26 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709062a5000b0099315454e76sm8293803eje.211.2023.10.10.05.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 05:16:25 -0700 (PDT)
Message-ID: <50662394-0da1-49ce-a519-c0b963d19e54@baylibre.com>
Date:   Tue, 10 Oct 2023 14:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] media: dt-bindings: mediatek: Add phandle to
 mediatek,scp on MDP3 RDMA
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mchehab@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com, moudy.ho@mediatek.com,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        u.kleine-koenig@pengutronix.de, linqiheng@huawei.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
References: <20231005104905.120544-1-angelogioacchino.delregno@collabora.com>
 <20231005104905.120544-2-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20231005104905.120544-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 05/10/2023 12:49, AngeloGioacchino Del Regno wrote:
> The MDP3 RDMA needs to communicate with the SCP remote processor: allow 
> specifying a phandle to a SCP core.

-- 
Regards,
Alexandre
