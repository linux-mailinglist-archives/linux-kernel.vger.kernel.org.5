Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0837592E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjGSK02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjGSKZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:25:46 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9826826BE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:24:57 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-78372b896d0so317625539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689762289; x=1692354289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9ZDAcRcEb4EcOQItHJdczS495JLkwEqfSdpm/d3I5s=;
        b=eeUXFsNC6JkS1yWsEnlbibzVOaUw4iyaw9+9IEMNq2UipZPdVXpIO5CNDZTEWkOfsi
         hQN97Bi5G+ajQRqNVN3jCFvB/BpFl29KTazHH2u6FPf2Q9iLcRaKbjhYwlRwAwDNlFdr
         YHypId86jhjCihxQ4RkjS+LvUBZRA+y3CkQBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689762289; x=1692354289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9ZDAcRcEb4EcOQItHJdczS495JLkwEqfSdpm/d3I5s=;
        b=JbHI+m9csOV5McELJWy8On8hyQF/ORQ2l781qNUD8gX4Rf/iqBsh8LDbKR6YdAw3fV
         xSHyuGapYSYwjunku1bK9YYdbsKQ5C8JCs2UIsYueVf4JDMxHHzUhIXUcdnZ0LaYS4/7
         PJh1ZNBRvdsP5DGtH16KypOE0iY5Spf327ijRF5J9u+Ghz0vaI0rVXumzTVpxWHwDt4G
         qhjFOYYbQ7Db/pmb83G3fbWRI5oSJW4ecZSZt7qjE+xyjY+4ZBa5/3T6a+JtxMYIWbTs
         PQYMOGaH19qCEp6qQpIUG5Hf/px4CBclcoWmK1AEjUFnDIRQK5QwsBE0otYTOnUGA19i
         tA3g==
X-Gm-Message-State: ABy/qLZJmd1VDK7JgIG6zjutHvT5j3Q3C916sLEcGqV4TeCqtgn65OXN
        uy9QY5DzsIWZmlbCMV8mvF3m+zT2ca0LeOAwLjM=
X-Google-Smtp-Source: APBJJlE2M44KoYQHz4CKx6sxPjZY5sp/e5t5pBENvG9IeDMWmFq4//3IV575DI+EdMp59a1xt4MbiA==
X-Received: by 2002:a05:6602:d4:b0:787:7700:2b5c with SMTP id z20-20020a05660200d400b0078777002b5cmr4819568ioe.6.1689762289656;
        Wed, 19 Jul 2023 03:24:49 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id r19-20020a6bd913000000b007862c74cec6sm1254861ioc.1.2023.07.19.03.24.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:24:48 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-78666994bc2so318444639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:24:48 -0700 (PDT)
X-Received: by 2002:a5e:950a:0:b0:787:1568:5df7 with SMTP id
 r10-20020a5e950a000000b0078715685df7mr5145284ioj.9.1689762287751; Wed, 19 Jul
 2023 03:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230719075056.72178-1-angelogioacchino.delregno@collabora.com> <20230719075056.72178-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230719075056.72178-5-angelogioacchino.delregno@collabora.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Wed, 19 Jul 2023 18:24:11 +0800
X-Gmail-Original-Message-ID: <CAC=S1nguPCc8HUkWqNQgBWzNNaq83q7UdTdbv1i5_jH2ZZy4eA@mail.gmail.com>
Message-ID: <CAC=S1nguPCc8HUkWqNQgBWzNNaq83q7UdTdbv1i5_jH2ZZy4eA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] drm/mediatek: mtk_dpi: Switch to .remove_new()
 void callback
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 3:51=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The .remove() callback cannot fail: switch to .remove_new() and
> change mtk_dpi_remove() to void.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>
