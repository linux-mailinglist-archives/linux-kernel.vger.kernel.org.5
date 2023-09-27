Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF337AFDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjI0IKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjI0IKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:10:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74F712A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:10:43 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso752608266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695802242; x=1696407042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+G3VE8bLfC7FRcRjfb8N9PNI/qpVRz0H3I7jxJ+ZrlE=;
        b=T+00bZFekfKtLmRIVTy/BU9/khSNdTwAKQDWLFgZijEnQxcKkD9X5PKAeBDNtLQ1vF
         Tjh4kazm21dwDf/Eip+770VubwG/AnErc18POrHRHYliffpAJWz+N9g64SoLf0tHnOox
         unAWBT8ZXFEua3T6TlmF9VasHBc4FaNdHur10mIUmXaTqganBjo7ykRqT+WFy1pv3Rlk
         0hbvVfSmR+06UE9E/NX+M+ZdZ3iV38deXxiU0+f54gpbmSJzh6/qFPjIZUZLjpdqK8/d
         M6t56ds/rfRYLAuAlpn9XHYjf6MoQ0i/4A9Lbx4NZMxGQr5hn1CJ9/mUphrmmmSE6OmA
         MucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695802242; x=1696407042;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+G3VE8bLfC7FRcRjfb8N9PNI/qpVRz0H3I7jxJ+ZrlE=;
        b=Ho+K51gCfBlmasZrSR14hcgY8SM/h26gzgaVy/9UOqJNnminwj49+QUFC0+A0mUWie
         VNdyNwDbhUobUdbiY+VZedh2rr2ki93sDDBiZlvDztBV5KMI2gXF2lmg/9nOgDlbYBvG
         FhsFRE3g2D2Hk7T488LopPgfzTZkaRj/0an5cDgXWgxfSfL/4JliTHiyLwYnDIIyx6P+
         bzGLDxxfOafQfEA56r7FX9HBz0Jt4JkqZxazT4UHcugatlVkvWlHYLOYVumB18vraD57
         h8qTBXdersS0mwkZHdRv8hzJEWN2BjOlZiiTONxOmZiP3XrY2CH3ka+gFC0L44Gb3G+f
         5dXQ==
X-Gm-Message-State: AOJu0YyLToFEK7i6aNUSKMCr7emxY652LcSVA1ZMbLQxZisNGFC6q+gk
        FFgLAfe8pxbr/B3XwI+p67FWOg==
X-Google-Smtp-Source: AGHT+IHFTBMsRFro7Q7iw+nXy/6vudOXRPelV81MHMibrohwyvmaVnwB1el0yulBfFKVMA0T7qQ/0A==
X-Received: by 2002:a17:906:11d:b0:9b2:abda:2543 with SMTP id 29-20020a170906011d00b009b2abda2543mr1149599eje.65.1695802242286;
        Wed, 27 Sep 2023 01:10:42 -0700 (PDT)
Received: from [192.168.1.162] (host-87-4-82-94.retail.telecomitalia.it. [87.4.82.94])
        by smtp.gmail.com with ESMTPSA id qw25-20020a1709066a1900b009b293d1f2eesm2997199ejc.107.2023.09.27.01.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 01:10:41 -0700 (PDT)
Message-ID: <54c87219-de9f-4c5b-9c70-11de22c7c612@linaro.org>
Date:   Wed, 27 Sep 2023 10:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, Conor Dooley <conor@kernel.org>
Cc:     "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230926101000.13392-1-ming.qian@nxp.com>
 <20230926101000.13392-2-ming.qian@nxp.com>
 <20230926-slackness-target-b74e33ab1031@spud>
 <AM6PR04MB6341B0D9EC8146149CF8ADB0E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <AM6PR04MB6341B0D9EC8146149CF8ADB0E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2023 04:10, Ming Qian wrote:
>> From: Conor Dooley <conor@kernel.org>
>> Sent: 2023年9月26日 21:26
>> To: Ming Qian <ming.qian@nxp.com>
>> Cc: Mirela Rabulea (OSS) <mirela.rabulea@oss.nxp.com>;
>> robh+dt@kernel.org; shawnguo@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> mchehab@kernel.org; hverkuil-cisco@xs4all.nl; s.hauer@pengutronix.de;
>> kernel@pengutronix.de; festevam@gmail.com; X.H. Bao
>> <xiahong.bao@nxp.com>; Eagle Zhou <eagle.zhou@nxp.com>; Tao Jiang
>> <tao.jiang_2@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
>> devicetree@vger.kernel.org; linux-media@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Subject: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign slot for
>> imx jpeg encoder/decoder
>>
>> Hi,
>>
>> On Tue, Sep 26, 2023 at 06:10:00PM +0800, Ming Qian wrote:
>>> There are total 4 slots available in the IP, and we only need to use
>>> one slot in one os, assign a single slot, configure interrupt and
>>> power domain only for 1 slot, not for the all 4 slots.
>>>
>>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>>> ---
>>> v4
>>> - improve commit message
>>
>>> - don't make an ABI break
>>
>> What does this mean? Can you please try to explain things a bit more clearly
>> in your changelogs?
>>
>> Also, where is the code that actually makes use of these properties?
> 
> In v3 patch, I make this property required, make it an ABI break, so in v4, I remove it from required, and default to the previous behavior if it is missing.

So say that you dropped line making the property required.

> 
> The code patch is sent before, but the dts change is not applicable, so I send it separately. The code patch link is as below:
> https://patchwork.linuxtv.org/project/linux-media/patch/cdadb4a23697fdc97def958c69b12cd00f547212.1685430841.git.ming.qian@nxp.com/
> 
> But in the patch, the property name is "slot", not "nxp,slot", I will make another patch to fix the property name after this patch is reviewed.

Format your emails properly. It's difficult to read it.

I already NAKed it, I will be NAKing still. Don't embed OS specific into
the bindings nor into the DTS.


Best regards,
Krzysztof

