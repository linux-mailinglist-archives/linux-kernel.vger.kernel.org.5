Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DECE75763B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjGRIJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGRIJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:09:32 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6D111C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:09:32 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-78372b896d0so251316439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689667771; x=1692259771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUZL14WYA0DLZ0DKyW91vgmsuwYwiL4W9V/M4FZV2mU=;
        b=lvLEx2hLpY2H0FHWFky1bIMahN5KEjJKoFm5Gx0swmpHj5nKgFiAlseWKhFYVmQRxb
         lxKdCMa27BhJ7prdrxdrHlYSrPcissRX7WwfaaAEIwJ6Y6li9I0DcdNvQcPg1ucnWq0+
         iQ25cRSkGFVCpr89DPgeaIuklynoskxzrKzyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667771; x=1692259771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUZL14WYA0DLZ0DKyW91vgmsuwYwiL4W9V/M4FZV2mU=;
        b=VLUvF99XqOXJzDZztybiEnLaBMMxsyi038q2xAe21FPUMmCogD9OM3BdlN/kMK+36v
         VX5gZfkOQNcwMyBnYK2d2QibLjkAPuU7w9mBWlz/Jc9SpEhs2+SbzbzuO1TEE4uTCut/
         j1YcuqS8oG9lOsjKw0jOAFygv/QuSFvB60sYhOJjhFBjRQ9Qb84mccM1hf0faHThLJBz
         2J/0Kw8IfyXdDseG2G47LRhP3LK9dXCPL3aCvkVfwLIZfr4HjR7Wbr69p6HOeBTZPdMZ
         wuYVkZzJCK3ysDY3yzCs+kjK6VjlJUpSHIVzym1XggL6AWQWRGzysfPbXXqJFSLSga92
         jFHQ==
X-Gm-Message-State: ABy/qLY1+814jBPYAoxwo27NOxpvqsp9prbmrcVNudhwTT/h7DPKAqfi
        xmSq58p5JHEYy7Qr2xKrSrgiuyThUK/3TY6S/YI=
X-Google-Smtp-Source: APBJJlEVv2tr6+8KrSDD7esFlRt5xT2/BNgG3sYO+hCa9bvlTJf7/V7AYHJGCJzHHRtMVK2NTCrvNQ==
X-Received: by 2002:a05:6602:220d:b0:787:8cf:fd8e with SMTP id n13-20020a056602220d00b0078708cffd8emr1837286ion.11.1689667771459;
        Tue, 18 Jul 2023 01:09:31 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id y14-20020a02a38e000000b0042b37080b23sm378012jak.73.2023.07.18.01.09.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 01:09:30 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-345a8a78bcfso26570175ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:09:30 -0700 (PDT)
X-Received: by 2002:a05:6e02:2144:b0:348:8aec:179c with SMTP id
 d4-20020a056e02214400b003488aec179cmr2013630ilv.32.1689667770016; Tue, 18 Jul
 2023 01:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230627063946.14935-1-shawn.sung@mediatek.com>
In-Reply-To: <20230627063946.14935-1-shawn.sung@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Tue, 18 Jul 2023 16:08:53 +0800
X-Gmail-Original-Message-ID: <CAC=S1ng0sLRt0vhB2Rpk_vetQLu9Kro+JREWf-wpkkO6dNKiwg@mail.gmail.com>
Message-ID: <CAC=S1ng0sLRt0vhB2Rpk_vetQLu9Kro+JREWf-wpkkO6dNKiwg@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] Add display driver for MT8188 VDOSYS1
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsiao-Chien,

On Tue, Jun 27, 2023 at 2:50=E2=80=AFPM Hsiao Chien Sung
<shawn.sung@mediatek.com> wrote:
>
> Support MT8188 VDOSYS1 in display driver.

I'm testing this series with my local MT8188 setup + an external 4K
display, and I feel there is something missing in it.
With these patches the external display can be lit up on my end, but I
only see glitches and no meaningful content is rendered.
Could you check again and send the updated series with the fix?

Thanks,
Fei
