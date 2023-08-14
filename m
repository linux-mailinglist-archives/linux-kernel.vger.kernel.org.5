Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A84B77B53C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjHNJPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbjHNJPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:15:07 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DD4130
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:15:06 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7910620f45dso161677739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692004506; x=1692609306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=symJGMsghCtGvBGMFumnnn8XSl8s5K5BSajbCGhbLM0=;
        b=W8L6qECFUQs1Myvfv9v5ek+Xg8PYEt9zYX0c8mN9P/yrTQx0r+6Mh94HbVbrWQbJjt
         qQDJGyit9JqUJWnFYC6jPsWVJEm4pbtEpnLNV7O8Lt2zqmnX85TKCGu5P+PfLtXkgnay
         gIz4kK8PC4yfopDc9OMtzj46242EyoiF0D5IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692004506; x=1692609306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=symJGMsghCtGvBGMFumnnn8XSl8s5K5BSajbCGhbLM0=;
        b=DMMEtp+DcY/RtuD96i9tIyuhAb+/uGfUqFIa2+0cWxTg1mLhzvJ9W4JCQ3NlDqaIJt
         6CJzrTS5WpAQ3l3dnqMU8ulkcqO3a+Ug0gLXmoMjdAX6gMM81lFyd8lGPCRdeHLnbkLQ
         Ukv5pIIV1RSm4os57YplRJDxym/thxupd2EOex8hywqjwE9SiF7M2RPJgusJ6h9Y0LZb
         JNPAuyHQq2FQaoxsEfiFaJq/XSUReWRw57I18dupBuaO12AZkJXHQMLDwMmYT9t8iPLP
         eD4NfpJfG3rMCZpZkilfgny6SnahaiMwTzxMYbWSyyW9+f0Kp5V/LOcxsZB2phQV848k
         +O5Q==
X-Gm-Message-State: AOJu0YwpBa6vjOyp/1JV5UJccbxlrYbQa0aHq42V0OAlMUOjLwPg24Vo
        X3tMTufsQx9Wz1K0U1YJ3BLnSbQkOBCwQLi3obE=
X-Google-Smtp-Source: AGHT+IGhV6jQfLY9Fx3cVbSS7cn/hBx6hbS8Mc/nEEe5o55Sww3tBw/qwLS54a0dKa+ovv6FMV8QbQ==
X-Received: by 2002:a5e:8b03:0:b0:783:72b9:ed67 with SMTP id g3-20020a5e8b03000000b0078372b9ed67mr12339611iok.10.1692004506100;
        Mon, 14 Aug 2023 02:15:06 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id gg21-20020a056638691500b0042b3a328ee0sm2922284jab.166.2023.08.14.02.15.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 02:15:05 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso161329639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:15:05 -0700 (PDT)
X-Received: by 2002:a5d:9ada:0:b0:787:4b5f:b6cf with SMTP id
 x26-20020a5d9ada000000b007874b5fb6cfmr11533549ion.5.1692004505047; Mon, 14
 Aug 2023 02:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230814072842.28597-1-shuijing.li@mediatek.com> <20230814072842.28597-3-shuijing.li@mediatek.com>
In-Reply-To: <20230814072842.28597-3-shuijing.li@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 14 Aug 2023 17:14:29 +0800
X-Gmail-Original-Message-ID: <CAC=S1nh9QtE7CNpsUujqSAM-Q10Mb8dOfXYtJQebvw4RifqOBA@mail.gmail.com>
Message-ID: <CAC=S1nh9QtE7CNpsUujqSAM-Q10Mb8dOfXYtJQebvw4RifqOBA@mail.gmail.com>
Subject: Re: [PATCH v4,2/3] drm/mediatek: dp: Add the audio packet flag to
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 3:29=E2=80=AFPM Shuijing Li <shuijing.li@mediatek.c=
om> wrote:
>
> The audio packet arrangement function is to only arrange audio.
> packets into the Hblanking area. In order to align with the HW
> default setting of mt8195, this function needs to be turned off.
>
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>

Reviewed-by: Fei Shao <fshao@chromium.org>
