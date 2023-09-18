Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5EA7A4773
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241177AbjIRKow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241309AbjIRKop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:44:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB28D1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:44:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500bbe3ef0eso5129458e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695033876; x=1695638676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGkdCcI18B7hgDeo6RzVWYQ9sD6aoucVKvw6M/xbnDU=;
        b=H1gsuGrvAXb1M4YT6F93VgqWxgpsLrwuYs2tgfKd1JBXnmcfJdnCnPkGnn8SCJp/VY
         h3FaKURPMH+SC4cDX+rLL4cCMzgbnMxDDqeoBitiQkJ7giBYI6k/51im3O7GJ6QrH0JP
         IIRbz8e567Omq9mDQL71ZGJgsjbhfD+CwBME4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695033876; x=1695638676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGkdCcI18B7hgDeo6RzVWYQ9sD6aoucVKvw6M/xbnDU=;
        b=kv6zMbzP9lmQ9uGYW5HPAC9tVXoDinGEjn0ntzWFTZuykQn6UDRY9YVa8tK5f6cMFz
         jWincaNReI5r+ZZxS0FLaP2DZbUH/tIY+041MSj6bxkD9emzCaaZ3Kc0hAwq/93ksRXO
         0wA3vxhuZ4FJUBA7f+XzWqZqPdVl1BogXbn6/jwOXs4Nz4DaMZRIvb0KK8mwLqOV4wLb
         +A6TqeGC1CNtnvwGl2ItzzgnwJ//8TLDDA/gOcOjBGyKq9dZCvTDifw2IlUD5ib9SSpt
         mZDJe0uZEBBos/EoIvJnFZK3h/BREytYbeST3ATjk4wu3RTz1SvkDLSRjeS15dTURLT/
         TAEQ==
X-Gm-Message-State: AOJu0YxO5jlwc4jUhmSf+6EgBgVeDtR6YjDyD5R/32Z0H74blBSqPOlH
        sRM1RBVD6QYntsq8L3pkqqhJiuTVM8QaPWXNCsOA/w==
X-Google-Smtp-Source: AGHT+IGIg/CJtdEmuQQHM8i7T4H6aOlEi6CRY6h6lVig1fzQNxD9WQD0b+EvqCe7Iv5e6XJyFKEGdbI+7C1+JpTi2ro=
X-Received: by 2002:a05:6512:1599:b0:501:b872:8c6c with SMTP id
 bp25-20020a056512159900b00501b8728c6cmr4185650lfb.27.1695033876680; Mon, 18
 Sep 2023 03:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <ZQH2dG+l/dONUsyi@p14s> <20230918103141.126271-1-laura.nao@collabora.com>
In-Reply-To: <20230918103141.126271-1-laura.nao@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 18 Sep 2023 18:44:25 +0800
Message-ID: <CAGXv+5Esi=G0xgkP=+Bhf39Xs3gMN1PBzarxKBKduOjgwDijAA@mail.gmail.com>
Subject: Re: [PATCH v17 00/14] Add support for MT8195 SCP 2nd core
To:     Laura Nao <laura.nao@collabora.com>, tinghan.shen@mediatek.com,
        angelogioacchino.delregno@collabora.com
Cc:     mathieu.poirier@linaro.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, kernel@collabora.com
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

On Mon, Sep 18, 2023 at 6:32=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> > Other than patch 2 and 14, I have applied this set.  The remaining patc=
hes will
> > have to be resent to Matthias.
>
> > Thanks,
> > Mathieu
>
> Hello,
>
> With patch 2 missing, the SCP is not probed correctly anymore on asurada =
(MT8192) and kukui (MT8183). The mtk-scp driver relies on the existence of =
the `cros-ec-rpmsg` node in the dt to determine if the SCP is single or mul=
ticore. Without patch 2 the driver wrongly assumes the SCP on MT8192 and MT=
8183 are multicore, leading to the following errors during initialization:
>
> 10696 04:33:59.126671  <3>[   15.465714] platform 10500000.scp:cros-ec: i=
nvalid resource (null)
> 10697 04:33:59.142855  <3>[   15.478560] platform 10500000.scp:cros-ec: F=
ailed to parse and map sram memory
> 10698 04:33:59.149650  <3>[   15.486121] mtk-scp 10500000.scp: Failed to =
initialize core 0 rproc
>
> The issue was caught by KernelCI, complete logs can be found here:
> - asurada: https://storage.kernelci.org/next/master/next-20230914/arm64/d=
efconfig+arm64-chromebook+videodec/gcc-10/lab-collabora/baseline-nfs-mt8192=
-asurada-spherion-r0.html
> - kukui: https://storage.kernelci.org/next/master/next-20230914/arm64/def=
config+arm64-chromebook+videodec/gcc-10/lab-collabora/baseline-nfs-mt8183-k=
ukui-jacuzzi-juniper-sku16.html
>
> Reporting the issue so that patch 2 and 14 can be resent and merged soon.

This being a backward incompatible DT binding change, maybe we should rever=
t
the node name change. Or, the driver could simply count the number of child
nodes that have the "mediatek,rpmsg-name" property, which is required.

ChenYu
