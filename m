Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222667C8B28
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjJMQ3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjJMQ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:29:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5BC210A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:27:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9be3b66f254so15657366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1697214421; x=1697819221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dDChyjARcHDkjDQPX6XB8cVwDI75Vj0OVvNyqfGNTb8=;
        b=s3cNDlsldiqyjzOLg547DBYOsLYWWbgb6vsLhuV0Y8zYJFWObDbWfQayX07PPazwy3
         kj4r4qXeU8T8YUbExJ+PwPRssFn5eIsLRE2yzpK32dBYrWEBECdplmy1+tA0wlSCsQRz
         stE9FPJqLNUju96XVYsoe7bD8iAE87W7WgUASDq7P4qegELjSRlxJXadZ7eq0Vyro9Ri
         hiV79oeRFHXlAwlE86Whb2IKKAtxqaf3hEOITkM4Ok5AnhKZ759/SMyS2SeMWB5mFy6b
         5O/541Ubm1QvqN7VcqHH6BzDk0s8zTOU+x6Fmf3hVHF9BqbBFyHrjCmmK/K5gmgu+BM5
         awsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697214421; x=1697819221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDChyjARcHDkjDQPX6XB8cVwDI75Vj0OVvNyqfGNTb8=;
        b=pgIWESVWPkBJvtFWsCba5PU2uxoph9hlbNoBPQdjaKm+mt+rtkB0SDeRxkfRWzy39t
         W6B9jI++HOA2qHTdpP/J/cOfKXphXinOHiDzIU3YkYHhkOJ/Lj7tTX9By9oYaJSW3/sB
         XvRQWxnnK7IqfqsWDHTGwcFx92QADQBuBuXWqoGVIdiu2KmrV0fCEVPqk/gi0Z3DYcnz
         8nwGip8/bHqwJAaYbZw3kYfKn//I8nCZZXGavAOQcKFet0S3Jfws1+tl8xxpAfDjCnKg
         vahUN478dDYMMxU6wm7iHXcxg4HwnkAsJ7bOFq+okEz009cG2mSercWaTdiRxb+Z3MWB
         Ck/A==
X-Gm-Message-State: AOJu0YzvsNM5R6lv52a9iaehjZZy5JGDDW3JJDJNgD2Pn9gjQJ06ocuV
        3dO5ZkW59x+Cn8pcoobCjJrlk7m8cf/zzUf4KSXV8Q==
X-Google-Smtp-Source: AGHT+IH4mCWm8Z2elsfB5wPDuFnQnwc2DSuvszMcvKnLJwB6uCPWL0qpI196Srkb4PahcQqJyczrTAjD9wvlQcukgRA=
X-Received: by 2002:a17:907:74b:b0:9bd:bbc1:1c5f with SMTP id
 xc11-20020a170907074b00b009bdbbc11c5fmr1802252ejb.35.1697214421164; Fri, 13
 Oct 2023 09:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231006073831.10402-1-shawn.sung@mediatek.com> <20231006073831.10402-5-shawn.sung@mediatek.com>
In-Reply-To: <20231006073831.10402-5-shawn.sung@mediatek.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Fri, 13 Oct 2023 17:26:47 +0100
Message-ID: <CAPj87rMUbP12uwzyhV=94wR7LkQK4JfTB4kEMGADq2YJOk8Vrw@mail.gmail.com>
Subject: Re: [PATCH v7 04/23] dt-bindings: display: mediatek: padding: Add MT8188
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Fri, 6 Oct 2023 at 08:38, Hsiao Chien Sung <shawn.sung@mediatek.com> wrote:
> +  Padding provides ability to add pixels to width and height of a layer with
> +  specified colors. Due to hardware design, Mixer in VDOSYS1 requires
> +  width of a layer to be 2-pixel-align, or 4-pixel-align when ETHDR is enabled,
> +  we need Padding to deal with odd width.
> +  Please notice that even if the Padding is in bypass mode, settings in
> +  register must be cleared to 0, or undefined behaviors could happen.

If I understand the driver correctly, padding is automatically applied
to compensate for unaligned dimensions. The first/last rows/columns of
the overlay area will be filled with a specified colour (black?) to
preserve the area. This is unfortunately not OK to do transparently.
Userspace must be aware of this policy decision and specifically
request it. If not, the atomic request check should fail and tell
userspace that the requested configuration is not possible to achieve.

Cheers,
Daniel
