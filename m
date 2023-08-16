Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC5977E665
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344705AbjHPQ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344689AbjHPQ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:28:49 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD0410EC;
        Wed, 16 Aug 2023 09:28:48 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-56cc461f34fso4310463eaf.0;
        Wed, 16 Aug 2023 09:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692203328; x=1692808128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OXgjHTAdytoLgUZyHzzq4dyrdO9fvokMGFShZim/Sxs=;
        b=qyw4CNHhKaU+ZrllPmAk3cWrbmVyZpXunhLa+YOqcH3nzzbq1D/DVyKIw2tKQB+8Ii
         4ExeXVyehEL8JzztUlM2IasuE9W/bpPCi5Oy6nh8OYSDJM6Ja8fPZzt69RbfnHNk2ekH
         RvoLxlm0LJqLVLCNEcLxJQnfxD9G1DkHbPlYwlKRg1+GRjV+ME7p5o/Dat4QRATgoYc4
         g48Asy+rNv5T6ouXLT/hmD8D6eaqU/5+MhSNxgmtDq08O77AlQhyq+yzlM0C0INS3fTC
         fpRth9QNiKiayu7KqDjn7TQOcnVI6Kud7adEhFsS0nnhNK0BKahchWp4eZMPjNPVNPL+
         yQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203328; x=1692808128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXgjHTAdytoLgUZyHzzq4dyrdO9fvokMGFShZim/Sxs=;
        b=dcxIVD5jmskKeHn8VqZyL49H3fKCn/E6u5JsZoJ/wKVjEJu/gebFfhqzOTnDzdsZZc
         cUTsHewyOzuE6dPMzMvlyeK9z2/oNZ+pNXuTmeta+c/idvamUR9nzPCUePX1PQ4YBfR/
         5Ez+sKzbOPYvGB1j3MLfljqPpX107nIn2784HR+Unoxo14TmmtLwV5F+z01o9VweKZD4
         AMOK4cCoN69xMcevi97PezT3dFqdUzXrrzAwZJeNHEeQLceQf3i98apbqCFAxnV/DWa/
         yx/rkKfJREKd+jsDOlQjFfkYphqyq+0syJMjabJ4M3hO38cYrhhF7eg93gaHVfzFHJgX
         IHUw==
X-Gm-Message-State: AOJu0YzkXkGBdOJXak5dxc7IUWboQY8QUWO8pLTY9idl0umWfkq5PIDd
        plHgxkHlAQI28NcBjWbtOMw=
X-Google-Smtp-Source: AGHT+IE7gF6G+GXuQtpoM6J4S+ngEbixSrE1pG1ziA+I7vG4LD60n9fDC6EXepNmmTmiT3gmnjdQoA==
X-Received: by 2002:a05:6358:7f04:b0:135:89d6:22e9 with SMTP id p4-20020a0563587f0400b0013589d622e9mr2669136rwn.13.1692203327824;
        Wed, 16 Aug 2023 09:28:47 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k7-20020ac80747000000b0040378535dccsm4553854qth.43.2023.08.16.09.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 09:28:46 -0700 (PDT)
Message-ID: <7d44ebf9-3d1c-d405-5c1a-5ce721dc37e8@gmail.com>
Date:   Wed, 16 Aug 2023 09:28:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] dt-bindings: net: dsa: realtek: require compatible
 property under mdio node
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-4-arinc.unal@arinc9.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230812091708.34665-4-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/23 02:17, Arınç ÜNAL wrote:
> The compatible property must be defined under the mdio node. Enforce it.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

