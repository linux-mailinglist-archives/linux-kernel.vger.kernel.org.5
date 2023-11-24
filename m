Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D407F6B05
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 04:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjKXDoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 22:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXDoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 22:44:14 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA2F10E6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 19:44:20 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507f1c29f25so2055058e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 19:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700797459; x=1701402259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcJej9WUdZZWtLL0jZR7KWhn0SxMMquSiq9yLi1GeNc=;
        b=NVYiUHSdceY35BhmGqSbztoEpyzoDR+SJSappsLbeB1ZGPoGIMuFmgxESiy4A9btL3
         vYFvgGvDP9V+E1aJx2n6cQPTmN9fbLAK7blJFTC/wD8zoL60woQTHaUCkq4oaAeCW5dw
         Qlf7M3YsiQhftuFnEWpb/1R/VtMS4gPVYuTN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700797459; x=1701402259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcJej9WUdZZWtLL0jZR7KWhn0SxMMquSiq9yLi1GeNc=;
        b=KFRo1tkOmz6GyqGzsAZcZPzIySNGT2LV+/dmfGRq3W9UYjTBLv3MnFdi7bmySp43Wh
         2u2+ccrpiHSsZ4Zuh5Q0XEcgc8okZGcA3po3+D9Y65Ny1cL9y/AxilNcZIKUC345FDuq
         NNo+pIOM5xNz5OXrSW5PbsO/IfCWW6DwnKdIEPkEn2Y+CqdH36XmX49o2g3oiadZhMZ8
         kjEJzI56jMZVYHAVhkkFEdN5j/E3ioNPJdwzfwzwmlF9G9lD++Wjm/SUDwn60HLylbp6
         7Xuuost8YYQjCGEAh1IVGe/rCy+NbEP2RGtj78aJrQZKgP7Fetjw65kka2GX/WwqSMXr
         rW4Q==
X-Gm-Message-State: AOJu0YzqwHuwCg2allp78Ck1zzkk3s8nE1Zo4a3Gv3SuMhOAg9t54IQf
        Ew6N1+WC18u9GXs3R2DCuGJs+rN0/TYkYcUPZOzuDA==
X-Google-Smtp-Source: AGHT+IH7191VcJzspX2lbzBmIE7QpGIGT/USZRwoE7pZJ5nRJbeokYOjJ7hZq8T0ALMqi3yp2bhgV8yGSW2RcGOPhbU=
X-Received: by 2002:ac2:5dc8:0:b0:50a:a9e1:6c58 with SMTP id
 x8-20020ac25dc8000000b0050aa9e16c58mr703080lfq.32.1700797458184; Thu, 23 Nov
 2023 19:44:18 -0800 (PST)
MIME-Version: 1.0
References: <20231123133749.2030661-1-mwalle@kernel.org> <20231123133749.2030661-4-mwalle@kernel.org>
In-Reply-To: <20231123133749.2030661-4-mwalle@kernel.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Nov 2023 11:44:07 +0800
Message-ID: <CAGXv+5EcT3OjyaW6LkARugWZN2AE5TWRx=Bh5TqfVBG2tcs5Ew@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: mediatek: mt8195: add DSI and MIPI DPHY nodes
To:     Michael Walle <mwalle@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 9:38=E2=80=AFPM Michael Walle <mwalle@kernel.org> w=
rote:
>
> Add the two DSI controller node and the associated DPHY nodes.
> Individual boards have to enable them in the board device tree.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

I checked all the address ranges and interrupt values and they are all
correct. The other bits seem to be correct, extrapolating from previous
chips such as MT8183 and MT8192.
