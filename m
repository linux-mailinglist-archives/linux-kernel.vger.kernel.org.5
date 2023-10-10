Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71CA7BFB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjJJMRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjJJMRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:17:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BDFCA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:17:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98377c5d53eso956710766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696940261; x=1697545061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2hRT2SJvh76ItidEme0pVqcc7N97rm2ZUS1fSYhtaag=;
        b=GgBkm3265EX9yPKqAqSEGJFE+G7Aj7OXtsBgCvCvj/eB37A2YuJa2WsXzg/FbVfFCE
         MQotqCWFuvdhpDzPhdopM2OQ1SU9G123pEB41pTLl2Eb1bwXpjMDtqgeQJvnHf/Ho2H7
         3YwytHZYPQt3h9JOTq9r6wMY9bsHVT2WD/j7n9KJmLlR1GdvndxRevJI6NP/SX6B4QMj
         adQA+lRgvl8kF3jrejF4clbu2OaS7qH0nZ5IIQc4/aiYcui/X8ebpFGwazE8pvKlvccd
         xZYVE9aCg9CzZKV7h67dH4CjS6xN5FusaxzMUll0KjYPcZMWP0AjhSpOb38p9RkoaPPC
         mwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696940261; x=1697545061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hRT2SJvh76ItidEme0pVqcc7N97rm2ZUS1fSYhtaag=;
        b=hatzkYfDYZXlJ4lsQ/i++3sRZYES9JBshBwNDpXwbRAeQ8nMd+qyAnJhr5BRRy/S6h
         FQ0/dLm4x+U0HOlVYiYs6cku/k8+z7RibRGEna9OBBiCrGhFDN6dP0oi88otzLsyaaH/
         iYBFLlT+tPAFjdstap95ST1QpWZfOrmM/8N0s4NJsJr0zPBr9CikiWtVLKN7BGF1HeLc
         +SYNX+wHjXtAGkpf+aFDdu/chr2DSg1dXSjgHoxDccPXNnULvPV2VuYdNLyZnVBwWLIg
         3AkdwLb4ugN/tm6Fe3iC+7egPa6PXOkJzpfZPkt/VrZsJk50WHtYAruT/yoNYZTzwDwX
         6ZLg==
X-Gm-Message-State: AOJu0YzBYcGeuyoOCSwnxWSoGx1GPe7kKQ7wc9rpYP+YTzBqJjtYDEqQ
        11iVCCEYpaQcddbHXpM5Kh9uHA==
X-Google-Smtp-Source: AGHT+IE+V2cLrQpGWVua2yJmj70qAuFvQv3wkupweNiqkbOavf527f0ImxH5CbIZPFmvrxP11OS20A==
X-Received: by 2002:a17:906:5193:b0:9ae:5848:3f8e with SMTP id y19-20020a170906519300b009ae58483f8emr17053067ejk.49.1696940261458;
        Tue, 10 Oct 2023 05:17:41 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709062a5000b0099315454e76sm8293803eje.211.2023.10.10.05.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 05:17:41 -0700 (PDT)
Message-ID: <3500ad51-b220-41f7-926f-bb5b9d415698@baylibre.com>
Date:   Tue, 10 Oct 2023 14:17:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] media: platform: mtk-mdp3: Use devicetree phandle
 to retrieve SCP
Content-Language: en-US
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
 <20231005104905.120544-3-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20231005104905.120544-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 05/10/2023 12:49, AngeloGioacchino Del Regno wrote:
> Instead of walking the entire parent node for something that has the 
> right compatible, use the scp_get() function provided by the MediaTek 
> SCP remoteproc driver to retrieve a handle to mtk_scp through the 
> devicetree "mediatek,scp" (phandle) property. In case of multi-core SCP, 
> this also allows to select a specific core.

-- 
Regards,
Alexandre
