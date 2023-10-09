Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D917BEBA6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377921AbjJIUdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377753AbjJIUdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:33:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901BBA7;
        Mon,  9 Oct 2023 13:33:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-279150bad13so3686291a91.3;
        Mon, 09 Oct 2023 13:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696883616; x=1697488416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=60nr4fzdTros1/1caE949JK7IrJG6r4bnbVLYmh8Yuw=;
        b=Ha1dy2Cmmp+FkYSu1SKKNG+GEZriLzFB/lJyw04F5ejqB56N1z0nSfnVICaXfC6fvY
         T1/SYVOVQK789wGletx83rLFMtMpSavyUFGGmJohGQqLe/rayLBKd3dxHjZNUGF4GCy6
         6z346WScCdAI50UsKdWEGVqUYVwCkLCPqptVu0YfzufiJkeaTS+v1GB88/PcPRpYHPZi
         nYmGiJTKLS4uwCdm4edWL7xL78tq3vZI/7nJUqAMz4E9p+8dzT2dg3QOlpYrbTMBwKlm
         SJ4LkV05waWomvkl7m4gNs4J/bz/uIWl4orr1tnTsp4FPDFBB38kjLofcAr3RZjsfFLX
         /evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696883616; x=1697488416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60nr4fzdTros1/1caE949JK7IrJG6r4bnbVLYmh8Yuw=;
        b=VeSAKkej41qeMpYAQhKuE3iyN0ObHP200nbvXVtUguiwH+hEj6AXQ7Q6wMLYlueir+
         yhuVkRy6TTrSTGKeeai8QOJNTGQaeOOKJtXkEf6+DUnfQuAIArC3RazvnC7kBMhgs5ca
         9tIioLfrpc2HxyekqM7KK0KdDHTV79aAjUMIKvYeZwCzE+rG5E60aF6o5Z1bTkESK+Vk
         +3XlCxjAYU1WGyD6IO3zDC7cDt2xK8hG53+iAor3oewXraWSqiHNRhFsqkOuMczTSRUV
         uVPE/YXdryC6rF/k5Q5V5p0iBCeTaAFy/WqagGdKP6ZyaLjGhN+D7tZItCy4EE1yOA1h
         1Odw==
X-Gm-Message-State: AOJu0YzXCJ57Z/83KWR6whUc0IsnaDjEDF5j/j9YqXxGq+E7zjJNL5N+
        HQRtzzd17W+ge7+tWwIviwuigr+EqpE=
X-Google-Smtp-Source: AGHT+IHtfmqjRKYi7waZlIAqUBoD/CWz8n6jrQ8maCUF/DbjjprWGymIFOy1bl4xsIMH726f1M/F+A==
X-Received: by 2002:a17:90a:34c9:b0:274:7725:ed9c with SMTP id m9-20020a17090a34c900b002747725ed9cmr13483727pjf.35.1696883615968;
        Mon, 09 Oct 2023 13:33:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t16-20020a17090ae51000b00267ee71f463sm6776912pjy.0.2023.10.09.13.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 13:33:35 -0700 (PDT)
Message-ID: <5c25f59d-fcd5-404d-b2b4-e77b7ca0f512@gmail.com>
Date:   Mon, 9 Oct 2023 13:33:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: mt7530: replace deprecated strncpy with
 ethtool_sprintf
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20231009-strncpy-drivers-net-dsa-mt7530-c-v1-1-ec6677a6436a@google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-mt7530-c-v1-1-ec6677a6436a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 11:29, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

