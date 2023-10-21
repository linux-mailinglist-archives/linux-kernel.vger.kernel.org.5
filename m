Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EC97D1F92
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 22:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjJUUfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 16:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUUe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 16:34:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3CC119;
        Sat, 21 Oct 2023 13:34:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9be3b66f254so283851166b.3;
        Sat, 21 Oct 2023 13:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697920496; x=1698525296; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3XHrNWuB2xCxWV1xS25yFPA+pQI6IX5HCckbBT68qYs=;
        b=gQJMNiQgrfi3GojnJ1XH8axEZ2PFLdEDvPXDahPzYjIJ20VVxJpt+tT1lR48NnL7/S
         6tmme9W1KaWXloSw6tywQSynr3KWy2YHd3tmTOvve6hm2o+Ou56mTUP9HCMOmXKMKM6A
         tK38ujcA9iqO+90176KgVvWIqsRE+eSzS2hVcYjntG9seBVDmAgHLSnbKemhInat6H2l
         j+pgUV3uh1j/VwUmkiCg6ngL/m7wEjVpz77Z9mMQrKqQDpGjUNe7EJoBequFFv8UCfVv
         9hGXvs93i5Mm+9RwsSyPxNw7+DuSfGd/C8i8DEIPujLLqzJHWpb03KnZA0sddfnHlATS
         GafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697920496; x=1698525296;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XHrNWuB2xCxWV1xS25yFPA+pQI6IX5HCckbBT68qYs=;
        b=AeyCzP2qrrY4xuz2ZEDN6EUx0XLWBKKm3pbRIj873q7Z8ZyRAqgegivR30aV6OVwL3
         Nt7mBTvyRK8x5XJXap0tgpMBqpL9rHChq03GPoQG70cqXAVY8yitjpGm+TovaOECaNnW
         NdQSQ9mJvqwkwunQkWrlI1OkcSOJPaVgLvEadL0JcmZ/Pn3XoxRDn0skxLPgJl4O7Hb1
         1IwAFU3SW8UKGXg8I9YORJ8NJJ7Uvc7Sneok09LU9FD7Ok9re3HtHnHlY12eYXfFnNNZ
         oigA+Llph1/aPC5OlfWIGh/fnA6hlOgpZgf3LQGhgJ0AVcY35MevjTaGumtB6kW3s5RX
         f83g==
X-Gm-Message-State: AOJu0YzriaAfvYVKOH5/ftTM1oKzRTQ/dxZ/v9vbpPTcd0KPNuPi6qx4
        YxWP99J0nNqGgS4InSReXG0UjATOgFHAR+tksH0=
X-Google-Smtp-Source: AGHT+IEpizVCkq78mP6QE92RpUDpj2LQ+n2Ma07XT4Eqgq3k5JJqUBtHoVJPruxE2/WxcnZmr8i2/3RmcRfcWrszYlQ=
X-Received: by 2002:a17:907:d29:b0:9bd:f902:9a61 with SMTP id
 gn41-20020a1709070d2900b009bdf9029a61mr4449889ejc.18.1697920495469; Sat, 21
 Oct 2023 13:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231021203403.215023-1-lukapanio@gmail.com>
In-Reply-To: <20231021203403.215023-1-lukapanio@gmail.com>
From:   =?UTF-8?B?0JvRg9C60LAg0J/QsNC90YzQvg==?= <lukapanio@gmail.com>
Date:   Sat, 21 Oct 2023 22:34:44 +0200
Message-ID: <CACi=Ov6hgbMX0c2mEodJdodm7Fsvjb-QWgb7ypBJKRSfSgFSbw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] From: Luka Panio <lukapanio@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Sorry for all the spam.
Thanks,
Luka Panio
