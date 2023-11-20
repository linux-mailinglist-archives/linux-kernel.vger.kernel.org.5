Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179BC7F137D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjKTMh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:37:56 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145E4110
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:37:52 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso12763975e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700483870; x=1701088670; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4atkjwStmvZxjHp5SDNM/cbMwICPzQFU+wT6vfftIs8=;
        b=iS6BBgeuvmFxNkRyg4rXcUNa68Ot7hmPsV9TlKY+FqMGXaAXpOkipxofzLDZ4j7O3j
         LBUmBYn2dh0hEZxm0olE9g3uO36eRmEx1qmdhTe/l5irK3wzW0E2xD9sATSp4s4/LBr2
         UTN5W4Ek4CoSTrJfPrH/9A0FcsiDXQnPIZ8C4JbqEE0flyYTBCDOOz5I2ve/kTRFHjuq
         Zmag0kF8gakHXOkHpwqSr8/eO8VKRdCwp44+bBBgy8BZjDRhClZDGypHsc3lwLsVv01K
         FxSC1CfPqCPf3KGs9Zo5MI7Mzcdk9+k3O/jo8cPV/8kGXewUiOLobVZY/7oeAFgJ6o9J
         aJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700483870; x=1701088670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4atkjwStmvZxjHp5SDNM/cbMwICPzQFU+wT6vfftIs8=;
        b=VpYSQ6lyT2HuSYx24QBDLnoiXoe8EOQZu4mT181+vftCOxogCRjDE1XYecICzRitY0
         iL9FI66NCKeQ/fMqdLmNSuutHObi9obQl9DMcOxgfJo95Brt8sX/5qIOnZYrBgJY+uvK
         VqWrfxXzTRx0P5VJ2G3+mMd4hkd5ge2CW8+KDdx1US7C5jSkhr/an3XiOkSCOLNzC4wG
         T0o02UXAjPV+Ssump7CkKDOLYFjwmbekQ3yigsV3tKZpRtZ2J1xSL6wKA9AlMOEIhqMy
         zWEswNTz++a6AogiZlFi7G0RLnwwKtihSZvHISX6HVj9a2KQOJr311P26NMld6U8VkIT
         F/hA==
X-Gm-Message-State: AOJu0YypsKtCxZrP4lcEddMA+pu+j12lyk1uui+UIGw/tuN3Ot1ox/aM
        fwmqYN++RsEqqyU2pN5in5lCkQ==
X-Google-Smtp-Source: AGHT+IEs5lAuavrkwKGpRZ5AkeCSKymW/RWPSADLBndhDv2LJ9rELvqHNmj4T3wJSogI6J0K/0ehDA==
X-Received: by 2002:a5d:47ab:0:b0:332:c514:641f with SMTP id 11-20020a5d47ab000000b00332c514641fmr2915054wrb.13.1700483870457;
        Mon, 20 Nov 2023 04:37:50 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id q15-20020adff94f000000b0033169676e83sm11203792wrr.13.2023.11.20.04.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 04:37:49 -0800 (PST)
Date:   Mon, 20 Nov 2023 13:37:48 +0100
From:   Corentin LABBE <clabbe@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     davem@davemloft.net, heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org,
        ricardo@pardini.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/6] MAINTAINERS: add new dt-binding doc to the right
 entry
Message-ID: <ZVtTHEr-zVZFuvHT@Red>
References: <20231107155532.3747113-1-clabbe@baylibre.com>
 <20231107155532.3747113-3-clabbe@baylibre.com>
 <6ba4585a-b7a1-46f9-ba89-a1e605cbdda3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ba4585a-b7a1-46f9-ba89-a1e605cbdda3@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Nov 07, 2023 at 05:20:46PM +0100, Krzysztof Kozlowski a écrit :
> On 07/11/2023 16:55, Corentin Labbe wrote:
> > Rockchip crypto driver have a new file to be added.
> > 
> 
> It does not have sense patch to be separate commit. It's not like you
> add new entry. New file is introduced in a patch? Then this patch
> touches maintainers.
> 
> Best regards,
> Krzysztof
> 

I will do it
Regards
