Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5669F7592FA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjGSK27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjGSK14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:27:56 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0864335A9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:27:14 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-786bb09e595so13645339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689762431; x=1692354431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVbJ90S8n4+Y/GX8BKsAT4na7uO4IaCBjmWUCYyFtgQ=;
        b=oLRdVzTfTtrUPJcxnjOfxybXRBijbPNPQTF90bAGGwtnrP2otSx3WdTHuzxFE4aTTB
         ze7W43etYcGoE1u6xIrxIaIKlIPOSKLnkHlAKwIptM4kYXH0YLnpOt/4H+yKjbotUSkC
         niw+rXgkwM8NX75XXiaUi5NoanYr+Tg+JlE+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689762431; x=1692354431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVbJ90S8n4+Y/GX8BKsAT4na7uO4IaCBjmWUCYyFtgQ=;
        b=ckdZZlK+kDbLQ5Mo4kAGO8ZTUWhUb9wuvwc5C79VVmoVMPQ7RQXSQBu+NDO7Bz7BR1
         sVGVj0qhhntwmDXo0/IJ56hG74l5Z/frMnL3e6MxxF4geVuiHUMZ7LSqAPdycPGFV+xD
         4roD9YQP6sXBo3xOetVGu3T/6NIhRHqrmKvTxOUvEdykJ5Q0mKSyn8k/nrRFDHy3BKEu
         dvJ/q+jIzFC9OFr7Y2BzrW1/tOQJAZXA61xbNc6tgbQ5bstuOjfZg6mvPN4RH+Q1ejCo
         J/4/kWQ3fbO9IpxAzYvRU0A0F0HzHfKuShiiTD0t58cDcBn/S9QbsjuKwYlApeoYSd+h
         9PWw==
X-Gm-Message-State: ABy/qLaGoclNtzcUTZDGOY5yvhexog9uSUOOgKTywwZlIouUpRLn9Kwq
        3D4SNgvLRPLPgoxSRVGRqdXQXz2muSINCeewABc=
X-Google-Smtp-Source: APBJJlHJ6nWJbb45D3Qp/KkKvb/Weq6PwUj/WcJ5vSawbG0GENNLnVQ986ASthJjrF3QaxQK8rMZsQ==
X-Received: by 2002:a92:d045:0:b0:346:3825:fa56 with SMTP id 5-20020a92d045000000b003463825fa56mr1734386ilm.1.1689762431403;
        Wed, 19 Jul 2023 03:27:11 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id o12-20020a056638124c00b0042b05586c52sm1176585jas.25.2023.07.19.03.27.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:27:10 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7835ffc53bfso14911739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:27:10 -0700 (PDT)
X-Received: by 2002:a05:6602:87:b0:787:147b:b54f with SMTP id
 h7-20020a056602008700b00787147bb54fmr1327429iob.3.1689762430227; Wed, 19 Jul
 2023 03:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230719075056.72178-1-angelogioacchino.delregno@collabora.com> <20230719075056.72178-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230719075056.72178-7-angelogioacchino.delregno@collabora.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Wed, 19 Jul 2023 18:26:34 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngWWeGuXrvsvgLrU7iVjnAm1+o2PwfPOBrQMLzsijnuHQ@mail.gmail.com>
Message-ID: <CAC=S1ngWWeGuXrvsvgLrU7iVjnAm1+o2PwfPOBrQMLzsijnuHQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/mediatek: mtk_dpi: Compress struct
 of_device_id entries
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
> Reduce line count by compressing the entries of struct of_device_id;
> while at it, also add the usual /* sentinel */ comment to the last
> entry.
>
> This commit brings no functional changes.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>
