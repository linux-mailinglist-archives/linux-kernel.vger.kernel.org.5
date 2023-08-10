Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C09B776FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjHJFqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjHJFqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:46:35 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC7BF3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 22:46:34 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-791071b9a5eso16965839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691646394; x=1692251194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixxcqOL2uF7LCUOvdRaIHgyC4OBsJP5mDbm84ewIiXU=;
        b=FF0RRhsaNB7/RzrIYnV/Z2NT6Iq8Syvm5eYE4UuU4Hrn2LRM08OMlgmDco3xoqt+4Z
         qJ2b0SIQjnNYRndeBAeQ3oZag/rMI280pTcMhRkVcRsZvPt9FA3YZpTWkL27KwATEWnE
         V/NlUwcAnxBh1nW8i61lggEUp6U8dRvQVxMHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691646394; x=1692251194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixxcqOL2uF7LCUOvdRaIHgyC4OBsJP5mDbm84ewIiXU=;
        b=hJxRaDFpSr3cYiOo7W3xfPvBtB+M+HLB6k7vnFjWHa7cEGS+x5ZPzKlgWQvCEC/MB+
         DSTV4f27IRYrGFHC+mgRGlJep3HhiLswyr07rv0DpItyode7zgrDQOKoOem2qgWAcME3
         D/zc0GxGqzXOHovafWFM3aUrWNFoRC9G96tCz3Lf6L7qCX7ljLWZraPqPKREwXpUuAd5
         xy39SjLLcRgt5pl+kJ+m/i7lnO0739ilk8kP9BeGESjme5/Yh+1rluPKuh+wcBE9rCey
         eu1yeXbOwIKcBnmpHrtB1Im/WpnN2P1HvbzDyiVMJHv63lixFG+BUsXmWZfE6yw6rDks
         Ir5w==
X-Gm-Message-State: AOJu0YxmoElWpjoeqWcB9fKHA2tU9wFWoHahMIM/biYbVxf4VLEKo0LY
        vj2poeemPikYXthJQIm83WtzAGg2OO69qaTC2Mw=
X-Google-Smtp-Source: AGHT+IHLQjzrKide5xvqGZ9MMs82YZnFhDpRn6Eq79Q54ajF/tcsGe+5PGiMJe8joMFohu0ZHcBSZg==
X-Received: by 2002:a5d:8c83:0:b0:787:34d:f223 with SMTP id g3-20020a5d8c83000000b00787034df223mr2009374ion.11.1691646393901;
        Wed, 09 Aug 2023 22:46:33 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id t3-20020a056602180300b00790af7745b1sm251773ioh.20.2023.08.09.22.46.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 22:46:33 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-76c64da0e46so17551839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:46:32 -0700 (PDT)
X-Received: by 2002:a6b:7301:0:b0:791:60c:4b4f with SMTP id
 e1-20020a6b7301000000b00791060c4b4fmr1873165ioh.17.1691646392647; Wed, 09 Aug
 2023 22:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230809181525.7561-1-jason-jh.lin@mediatek.com> <20230809181525.7561-7-jason-jh.lin@mediatek.com>
In-Reply-To: <20230809181525.7561-7-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 10 Aug 2023 13:45:56 +0800
X-Gmail-Original-Message-ID: <CAC=S1nj2Z2Lqf9se1EJZx6P3LvyMamb_iCjeRokL2qD7ij-fsw@mail.gmail.com>
Message-ID: <CAC=S1nj2Z2Lqf9se1EJZx6P3LvyMamb_iCjeRokL2qD7ij-fsw@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] drm/mediatek: dsi: Support dynamic connector selection
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

On Thu, Aug 10, 2023 at 2:16=E2=80=AFAM Jason-JH.Lin <jason-jh.lin@mediatek=
.com> wrote:
>
> Add implementation of mtk_dsi_encoder_index to mtk_ddp_comp_func
> to make mtk_dsi support dynamic connector selection.
>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: Fei Shao <fshao@chromium.org>
