Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7307AC445
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 20:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjIWSD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 14:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjIWSDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 14:03:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55702FE
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:03:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99de884ad25so484625866b.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695492226; x=1696097026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xze0269DJpz1msfiE6vhhaaDti5lnwQMTzvMi8h07ck=;
        b=ni15YvwyVjCFJSgbL2tqjOQSjlM9/1FMvPgWq6Ttrcj8Rr7LAnA18ZhlKnwQWdjrCH
         5n5DaxV8/34gICbKdumfnKo+2QnJC2IPaEfg6zZD+BIU7gkToCFm5Hc0c0elrSXWDBVk
         UHQxTbmYNY2IVUvWl2fGpMNLOdanD/QOoIztW9OiIJRwBsDjunzpL2r05i7BiPnitVjC
         fAjBcybG4TS46faP1CFhyuC6oM/yChMz3g8TWM1WeaHj9HWvu80kRWJjY4Dsbk4arIbt
         8a6qHkwGPjnRUqEqgJ/0p/hx0ntyNKlQXR9IM/GdejX4Z0bSJGHa7YTbEKJ2u0maDVMn
         7Skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695492226; x=1696097026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xze0269DJpz1msfiE6vhhaaDti5lnwQMTzvMi8h07ck=;
        b=LdbFsvL5TN5FwX0ZPDTfKMuHapYzIY85xLj1aOONpSDnOG2D19TygYu1II9n9W/Ke2
         uQku536E5qrWU/iMEy9gDOA+v/LdJlC4TGhPVqJaNTaEL8Ie3UsyfxcbUz4dK52Qav4I
         yoJLgzXBmjdd8tWiiKOLsR1gIyiSp8+9Y1cGzpArPfXteVOLay2EtK/HKMATrm9G2LnG
         YBmLYCSOOQ80RHg0MFfx44Dgf/aRKHfnNYWZ7Z7Zouo8dQbxzvJfnWy7hjrVNitSLden
         0GOxlC62ShuX0pBb2y87MEBRDTUSv9RxfDbZ6nz+n5r2/6yYLlcWIpiA9an3zYk8EBB7
         /xwQ==
X-Gm-Message-State: AOJu0YxYv7zOWSeuH+L3vVU81I57MvgQ/PoaFQG+LwBK7rprtU3fxHhm
        QM3ssjRMI3rAx0rsawAS7bwahw==
X-Google-Smtp-Source: AGHT+IFIyimj0pgZ7ge+avAiCLM3XDnvT7w8KKsHu4Up7SRj6VF0hmPmN9BzVV/4AJRLlC92qYiVLw==
X-Received: by 2002:a17:907:7897:b0:9a5:ac56:3b63 with SMTP id ku23-20020a170907789700b009a5ac563b63mr2138758ejc.63.1695492226723;
        Sat, 23 Sep 2023 11:03:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id gs10-20020a170906f18a00b009ae40563b7csm4129447ejb.21.2023.09.23.11.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 11:03:46 -0700 (PDT)
Message-ID: <5d528036-e506-7b95-69bb-7748b26d2aa8@linaro.org>
Date:   Sat, 23 Sep 2023 20:03:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 07/15] mailbox: mediatek: Add loop pkt flag and irq
 handling for loop command
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Elvis Wang <Elvis.Wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230918192204.32263-1-jason-jh.lin@mediatek.com>
 <20230918192204.32263-8-jason-jh.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230918192204.32263-8-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 21:21, Jason-JH.Lin wrote:
> CMDQ client can use a loop flag for the CMDQ packet to make current
> command buffer jumps to the beginning when GCE executes to the end
> of commands buffer.
> 
> GCE irq occurs when GCE executes to the end of command instruction.
> If the CMDQ packet is a loopping command, GCE irq handler can not
> delete the CMDQ task and disable the GCE thread.
> 
> Add cmdq_mbox_stop to support thread disable

How or where do you add it? I do not see it in this patch. Your patchset
looks randomly organized.

Best regards,
Krzysztof

