Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D95776FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjHJFrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjHJFrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:47:37 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F80DC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 22:47:37 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-790ba9cf42aso17521239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691646456; x=1692251256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPPMg3PRamF1jAKZwUwGlqsGYxlh91mVVXE6o4NQgM0=;
        b=emKQ9KZhNfyU+K4CBqvUrz3AXX4YkK9LDAd2qJOM1QcnF9UPBNRN5DIozvO34DYvhs
         kOpHSiVjUdQuYCmJlGNhaVnwlBeVHvwmI2X3m/eY6jQURCQfFZfuzX5SNA0gPQwk1y5n
         HUZuq4idUu/KOto06WHnl3qxBTm7cRrAh6FU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691646456; x=1692251256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPPMg3PRamF1jAKZwUwGlqsGYxlh91mVVXE6o4NQgM0=;
        b=QlrDaxAZecBUuUHa7DCC5j7agFRlIPncJ5NAShFQSDw/HtcbPLak3r0iboHmBAf00H
         I3+OmymW8QEGM6nQzA0RbUiDDixCDpJvrlJIyJAg+RWEPZUWfgV0nPNSzZ9omYqBmKma
         O2MrP8MHx62TNqR3qlyftOW07DCYBHgw53f45kt162RSjw86lmCYNi3BPnjWd2k2BQWC
         fUZajyHqxdrmyUY2USu4LofcupaPsYFkucrNp8M5i+Qzz/Rfs0dLZE1TgH+1cY+60liY
         qDoeh2C8Sj/YapNLLKOwCrC3a61oDNlK+HERY+Gd5I6bBxCCqDemn+FTRs01nqadg7ty
         0+kw==
X-Gm-Message-State: AOJu0YwAEWuxpLgD/tgu64fzWYZMdZeLhLwj/C55rdqy+IitQVVQF0Nr
        Sh3B6o8JzwwXKaauyyUIDelvzYdyJNoGE9Tax7k=
X-Google-Smtp-Source: AGHT+IHd8hHGO/qoOaaOJGlox+j0uI8vL4iHlgfLNLupbr6uXdDlX/P+NXjzZ3o0Dt1eej08KXl2yg==
X-Received: by 2002:a92:cb05:0:b0:348:8158:c386 with SMTP id s5-20020a92cb05000000b003488158c386mr1997576ilo.8.1691646456299;
        Wed, 09 Aug 2023 22:47:36 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id y5-20020a92c745000000b00348edca2abesm228595ilp.47.2023.08.09.22.47.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 22:47:35 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-78666f06691so18372539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:47:35 -0700 (PDT)
X-Received: by 2002:a05:6602:2085:b0:790:bb3e:78e9 with SMTP id
 a5-20020a056602208500b00790bb3e78e9mr2150940ioa.16.1691646455213; Wed, 09 Aug
 2023 22:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230809181525.7561-1-jason-jh.lin@mediatek.com> <20230809181525.7561-8-jason-jh.lin@mediatek.com>
In-Reply-To: <20230809181525.7561-8-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 10 Aug 2023 13:46:59 +0800
X-Gmail-Original-Message-ID: <CAC=S1ninuuuD7LEG=ST5bWX=tDYbfA6Xzf0d3o5XGSnFd_v19w@mail.gmail.com>
Message-ID: <CAC=S1ninuuuD7LEG=ST5bWX=tDYbfA6Xzf0d3o5XGSnFd_v19w@mail.gmail.com>
Subject: Re: [PATCH v9 7/7] drm/mediatek: Support DSI on MT8188 VDOSYS0
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Nathan Lu <nathan.lu@mediatek.com>
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

On Thu, Aug 10, 2023 at 2:15=E2=80=AFAM Jason-JH.Lin <jason-jh.lin@mediatek=
.com> wrote:
>
> Add DSI as a main display output selection on MT8188 VDOSYS0.
>
> Signed-off-by: Nathan Lu <nathan.lu@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: Fei Shao <fshao@chromium.org>
