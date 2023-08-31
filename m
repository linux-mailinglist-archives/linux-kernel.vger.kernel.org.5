Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A3378E7B3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbjHaIOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjHaIOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:14:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABC21A1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:13:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c0db66af1bso3349175ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693469638; x=1694074438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lI5HuTSJh4kLrQZ9upvSPMABH82Jidmy6stP6xhqC70=;
        b=oY+8y7Kaaih1HnO/4yYSzk5copwxp8hKgmcoLYvqYtDmeISGftsuZV4gaBxA5vVriW
         JcqVljtj/57ni0c8jCiy3RRsPFiF1DyR4S3Ez9mM4rq0kguv7FCwq2jwO3/mZvkZijVz
         A1mJSfTq4rTcKZZQ1nqkUbF1JikeE2b042ZDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693469638; x=1694074438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lI5HuTSJh4kLrQZ9upvSPMABH82Jidmy6stP6xhqC70=;
        b=bxLJv3OEvJb6y404EOBEYgXrP4ay/O0aSZcovS7AU7MM51pk5I4ZXAXtue97+bIDZT
         V/mDHmgVBVCdFIg6Akm7uoHv91umhQ6PwkvscI8pAWPKxXUfMh5b6faex3KWXGccKQTM
         g28DpM7nhO3nn34ueLZtyDgT8u9UwMalCZPk7NaLcUVos6RnCmuaUS0bxLVtuB4gub09
         KhJYo2JUDNXRcbz5BQqqRCb6Ug1t6FzmvpeYCOCuWCjel4uo/5m8BkQZL/E4dWsKLgDc
         bpYB5C1quepTVkO+1X+wVhnfmejzO19WzF54oclEyRn4xSvS0N8A5KkK08vz0qAp9qI5
         r1eA==
X-Gm-Message-State: AOJu0Yw/ftq0ObZl1nqvCACXnrkV+FlHLIXwtxH3vw/Skm6XX+umkvPD
        rbuUxYKojvUKM3yf23jv3KIHSmALjchcEoL1FR8=
X-Google-Smtp-Source: AGHT+IGAFnIR9n9hqWX9CXYlAK0mYrncEVKj1gV53y8QPeOQVUiYpdBmgM/yuTgsxzrXKFMGx1espg==
X-Received: by 2002:a17:902:e84d:b0:1b8:2ba0:c9c0 with SMTP id t13-20020a170902e84d00b001b82ba0c9c0mr4586553plg.59.1693469637722;
        Thu, 31 Aug 2023 01:13:57 -0700 (PDT)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com. [209.85.210.175])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902a70500b001bbb22652a4sm721134plq.226.2023.08.31.01.13.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 01:13:57 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-68bed2c786eso432755b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:13:57 -0700 (PDT)
X-Received: by 2002:a5d:9d15:0:b0:786:fff8:13c2 with SMTP id
 j21-20020a5d9d15000000b00786fff813c2mr5435565ioj.11.1693469197856; Thu, 31
 Aug 2023 01:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230714094908.13087-1-jason-jh.lin@mediatek.com> <20230714094908.13087-4-jason-jh.lin@mediatek.com>
In-Reply-To: <20230714094908.13087-4-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 31 Aug 2023 17:06:00 +0900
X-Gmail-Original-Message-ID: <CAC=S1ni1LvViXbP-euO8trwmwn68Y7-=UxX4W77fc10+TVi2PQ@mail.gmail.com>
Message-ID: <CAC=S1ni1LvViXbP-euO8trwmwn68Y7-=UxX4W77fc10+TVi2PQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] drm/mediatek: Fix unintentional integer overflow
 in multiplying different types
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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

On Fri, Jul 14, 2023 at 6:59=E2=80=AFPM Jason-JH.Lin <jason-jh.lin@mediatek=
.com> wrote:
>
> 1. Instead of multiplying 2 variable of different types. Change to
> assign a value of one variable and then multiply the other variable.
>
> 2. Add a int variable for multiplier calculation instead of calculating
> different types multiplier with dma_addr_t variable directly.
>
> Fixes: 1a64a7aff8da ("drm/mediatek: Fix cursor plane no update")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

Hi CK,

It seems like the series was accepted but this patch in particular
didn't make it into the tree. Could you take a look?

Regards,
Fei
