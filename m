Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E8977241D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjHGMdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjHGMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:33:31 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB50B10D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:33:28 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so4905988276.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691411608; x=1692016408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ju0JTiSAt7H2sdYn0rtiDpCv8Kvh+43Ggyv06DVuNm0=;
        b=LOBOAeXcuy76YT5VaYYeRYaRMLIKZ67pQtKjzHV6uQNGhUu2mCOTCxrH3qKbW6ooQH
         VZYX2Veeo+i2IwrxWDhwvIJsXMRpLD7WmdnwyndQlRb41uhocNh2iJVU3rRGoP6yics0
         LmjQzw6SAn0HOPwzM+QmzsGJUcme7QiHetSQQg0mHbxF+5J2QvfyisrQHARjlXP4frgr
         aTC7BcdP4rRMeAT7ISx85e1gHiz1H1CM2KRhrNPxaYA6n0TomukfzjD7dDandb8cwfQN
         KZXKJxl7ZKYULIZgpP/9a1kse+Jhf0egiGX66p5K1YUDc6p6mnc/GYxMzsTYmu6oZ0LQ
         CaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691411608; x=1692016408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ju0JTiSAt7H2sdYn0rtiDpCv8Kvh+43Ggyv06DVuNm0=;
        b=J0lAUfJKcibizfGrXW3vnkjKaWp0xSZxn1lV355NmgXBK0mJdMJaf8LDNq6qQnMUyS
         2BzJQoCcT2z6deTR83/TKVpzm/5XrGNbtdjF00NUNoN7uu8k1S8acbKg/GZXV0ftADe9
         XIHed2mKgHcwM9PFDvXWIa4jG4XsoTtgKmyqjQlYbIBQusVNpEJjjvfahOAIe3W8xT8B
         mfhKJBrzfyEEXkMopc21rOVDfLf9KwHDUjBezQnk93Rp3PXNAlwY3LkomXAglcIRcUJu
         TH6GzgSPlkJQIchB8Q07JrBzJ04nd7A8nlsQw+u6qn14YIW/O/aWPm7zWgl1uAswweOb
         6O0g==
X-Gm-Message-State: AOJu0YwKZDDRFc7fnm+Ku5Vx1M8xupwDqJSO8+8t6DVwqxnyeQ6qyRpY
        S2DW0wWIj6aGHUECEG9uZG6UJXmc1BXtZoZvtJUIeA==
X-Google-Smtp-Source: AGHT+IEOGAC7kuIRNqwPv63t3dht3OWnCrbV8mcLpccYfHyi/dP3uLOTVID5cgAlaqXvE6ZBQSj/lBs5w4azJGseHsA=
X-Received: by 2002:a25:8706:0:b0:d15:a265:4c43 with SMTP id
 a6-20020a258706000000b00d15a2654c43mr8904953ybl.61.1691411608067; Mon, 07 Aug
 2023 05:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230725123740.149559-1-krzysztof.kozlowski@linaro.org> <20230725123740.149559-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230725123740.149559-2-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Aug 2023 14:33:16 +0200
Message-ID: <CACRpkdZhX_Zec6RDFLMYz2DxSYj_EgrNUvwYsY9a_RuFDNcj_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: mfd: stericsson,db8500-prcmu: Add
 missing unevaluatedProperties for each regulator
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 2:37=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Each regulator node, which references common regulator.yaml schema,
> should disallow additional or unevaluated properties.  Otherwise
> mistakes in properties will go unnoticed.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks Krzysztof!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
