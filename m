Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FD777B511
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjHNJEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjHNJEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:04:40 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C80E63
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:04:38 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-790970a8706so190088539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692003878; x=1692608678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/7tv75kyLF04/hNRx8/Qrlee5igGYasqrhVSHaQy+E=;
        b=LchWXGcbREjS02VJe+/qz/M45zFlWNx+7j7IAw0Qp5Q6Nug/0lGgbA5oPrk9kQEkTn
         B0LYQNbLQ1svAjtsBJsge8o2z/dtQNfPhGBT5lIRFxHQOiTyhXBIBOvvaJlJd4ae0w1b
         NKJ/Xzyrk7cymjdYf1AZ5jReUj2rya+ojic+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692003878; x=1692608678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/7tv75kyLF04/hNRx8/Qrlee5igGYasqrhVSHaQy+E=;
        b=gD9VCE52/Vls9EAgOJhSSEoGBmmveQZgWlctUpHebjVqLbl/tj87ueASYDzvTmw9oa
         hAx9pgJXP0e7yIKTGOoxx8VIGw/6veuSBVq20Ag1pt+ffp/IBzmaAqlVkWmFLu8y9TXZ
         7ePh67rfFUKvpqU8YKXAhIOSnp4b6pJW3YoTQoOuE8nbZD/qjc0NigCeIOGhGnYB0Cl2
         n0m/yWAt91ioi30Mw1hG8bSn/EiT3wVQApV04krINJKjmuIXcmhhbKr8fzatb5OvG4QX
         l396zc23SGjHnxzfpbd/fFofXfFQdSoIub7UZaaQhADg+Fm2REr21VpH7so24iuEN/kO
         zQPw==
X-Gm-Message-State: AOJu0YxyOvt6GxlrJiPBWBt/FrxOmH+XR4qBlYD8QNmwT+dG2dutQ8Zc
        569zDBzNHNnUwq72md/HsYxefM9vkEoNzh5DKPU=
X-Google-Smtp-Source: AGHT+IFr8lwB9phHCeQGTe47q0CJVMhPlzWX01dujtg4TB01GAxntdC6zoYXtsHeWWmxYxe4eGlEKQ==
X-Received: by 2002:a5e:a811:0:b0:787:8cf:fe8a with SMTP id c17-20020a5ea811000000b0078708cffe8amr13524351ioa.2.1692003877976;
        Mon, 14 Aug 2023 02:04:37 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id o12-20020a056638124c00b0042b09036e5fsm2847806jas.175.2023.08.14.02.04.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 02:04:37 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-791262638ffso190321539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:04:37 -0700 (PDT)
X-Received: by 2002:a6b:6b02:0:b0:787:822:30f1 with SMTP id
 g2-20020a6b6b02000000b00787082230f1mr13847848ioc.1.1692003876732; Mon, 14 Aug
 2023 02:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230814072842.28597-1-shuijing.li@mediatek.com> <20230814072842.28597-4-shuijing.li@mediatek.com>
In-Reply-To: <20230814072842.28597-4-shuijing.li@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 14 Aug 2023 17:04:00 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngr0JS-rP+q2xukNdLFE9HcLJ0-RmbKOOtT0EK1P588sw@mail.gmail.com>
Message-ID: <CAC=S1ngr0JS-rP+q2xukNdLFE9HcLJ0-RmbKOOtT0EK1P588sw@mail.gmail.com>
Subject: Re: [PATCH v4,3/3] drm/mediatek: dp: Add the audio divider to
 mtk_dp_data struct
To:     Shuijing Li <shuijing.li@mediatek.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        jitao.shi@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 3:28=E2=80=AFPM Shuijing Li <shuijing.li@mediatek.c=
om> wrote:
>
> Due to the difference of HW, different dividers need to be set.
>
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>

Reviewed-by: Fei Shao <fshao@chromium.org>
