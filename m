Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A569775EC71
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjGXHZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjGXHZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:25:10 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD399137
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:25:08 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so5840892e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690183507; x=1690788307;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6To1AmJfKZALXGlXmCdcpZQBhgwdO8DUFybmC0BfNuI=;
        b=I0ybHvy1YLSUttFE8O1Qh6SjnmxzSFnmFPbj/00XHoyRTeHaQiLC6TZ6ZFlHQzVzWW
         Xv8slB0FYNivzUusyeUO7ItxNy/ydzn0hVu9dRvkgmFUIFCaA7fDjv1/FOUadboyKaky
         bmwaUp/gQoVCLxIlWWsSGXbTT+zapkwh7JZRaGA1AiF7fXvCVHvrNz9rIsPwZ2BbCUc3
         55nDdbJFyfK6jGOUN+h1BkkuEeDs6Cp0PLocKbZ1UaLl6UebMz6B2yQmvFi8CuV+ugi3
         UM6Ggq16DU8nO6K03iMt9pdlowN4a3IAXpVb3oggruIEH8ieOncYGw4L4x8+2OMYos/D
         KJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690183507; x=1690788307;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6To1AmJfKZALXGlXmCdcpZQBhgwdO8DUFybmC0BfNuI=;
        b=XeJYLFnIjsv22Bn1HyMyXe3kQCVyUxMQpoRkAN9s1dYSGfssYv+BuuLv1ROHb3qMDS
         8QbV5irZ5xm4lXp43+d71qxIcz57dg3ZWpbJRw9k+bdEYq1fOxmA1Px57lh63ak0DEz+
         n1HoixUPktjFjpO5EMkyxdXbucDDyPAL4YyjCO4IgLxATzxKY7OKaMDwn8ibFde+9UCl
         ezUiFQkwCe9czmBcocpGMGsqc5dJYoRCHIpDrt5ilxaaTfoWKMUDJjNaam+PRgdYMa2I
         Jx7/STpTpAg56jUILT8xvKyj5NA7NlPeAu+/e0WVJCpAyxhGe77ZrA7bPCN/Q8qi4eMi
         cl5Q==
X-Gm-Message-State: ABy/qLalwqKMSJ9IpBqGxLRecDz3HNgo3Es2uk8vJer/zbV0ehfCusVw
        SYmivY8QWsmIcFoZGL6B78TFeg==
X-Google-Smtp-Source: APBJJlF4c3ReKDhvLfkhVwoWeOuz74evpUCZ2CgKvSJySQdVz2fjNjGVbLZ0rhlEWgW66p+rwRWCxQ==
X-Received: by 2002:a19:7508:0:b0:4ed:cc6d:61fe with SMTP id y8-20020a197508000000b004edcc6d61femr4842985lfe.24.1690183507175;
        Mon, 24 Jul 2023 00:25:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id t8-20020a056402020800b0052239012c65sm303432edv.82.2023.07.24.00.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 00:25:06 -0700 (PDT)
Message-ID: <ae570cbb-08ad-5a7c-8dc9-4ad9f41d6e7f@linaro.org>
Date:   Mon, 24 Jul 2023 09:25:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/7] ASoC: mediatek: Add support for MT7986 SoC
Content-Language: en-US
To:     =?UTF-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        =?UTF-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <20230626023501.11120-1-maso.huang@mediatek.com>
 <04a1a53ebd9df265da780c644a0db86952cde8db.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <04a1a53ebd9df265da780c644a0db86952cde8db.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 08:17, Maso Huang (黃加竹) wrote:
> Gentle ping :)
> 
> Hi Rob and Angelo,
> 
> Can you help to check this latest series and share your thoughts if
> any?

You got comments to fix! Implement what you were asked to do.

Best regards,
Krzysztof

