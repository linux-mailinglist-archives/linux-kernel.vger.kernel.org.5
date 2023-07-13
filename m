Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670C8751AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjGMIBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjGMIBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:01:24 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D1C30C3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:00:03 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7837329a00aso11345639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689235186; x=1691827186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bNjmQBLzRndIeDOo3XPwwSKET0eUhbNEBYsBMD/HWg=;
        b=QLw4Vwt8hxPTWGJatZxpqd2ELYnQAZuZkdvvNDQDElxkk4KfP4kockhDp9RRz52imF
         msSheeQUB033kv4xjSYBV9QtqoL+aH6EDS5PIWOzohJptv9Hfzv1LlhNMnrhy+Qjv6cj
         TvBnlZzFI8TAbql0M0a24ghgqq354A6k3LK7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689235186; x=1691827186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bNjmQBLzRndIeDOo3XPwwSKET0eUhbNEBYsBMD/HWg=;
        b=kX83g136m2yXz8avswrg7OMQlgRVkva4pBI6KpPPZImfZaKlGivm9uxD728y6ci1yy
         t5Zk3NrblZOF2C+9YF2SeeWTxRmgJZnXdpiy2NRqZ02t5dsujJETDPgUlcuuwHPex4m8
         tg2wEP1bDXFYYj2Pyrd8xvHdJnmp6cc+60K8kB+vIUdgs6lNdDbk7nrLZsThHvn4gG0k
         NmLFAlX0nLZSDnVsHB+1FSphxJobeWPivlGurWeXkbV5WqRLoWiviAge9JfI3yVEfvIh
         DubctKSB0gFtQKmE+LcrcQ5agTgLFyb2GTLdRoNdP/0THM0k/pLG/AZVHLDW2rCfMKUg
         z1Ag==
X-Gm-Message-State: ABy/qLZPboEwaOMDgfT4B8ZhGJBXA7n7wWN8eeqX1NAJaTHzrLGg9Qa7
        aO2GHOx2sb6keLqiv5rsrHivJ5Dyhx3ZfJaKNbo=
X-Google-Smtp-Source: APBJJlEBblKd5WhNwwNXuIveEQAPSEyWcg70RoFdB0NyvRlPU3I/n3pEF+Y+NiVx60brGoU/W+9Raw==
X-Received: by 2002:a5e:a803:0:b0:783:3899:e1d0 with SMTP id c3-20020a5ea803000000b007833899e1d0mr1273850ioa.6.1689235186325;
        Thu, 13 Jul 2023 00:59:46 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id h26-20020a056638063a00b0042afd174c62sm1720114jar.99.2023.07.13.00.59.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 00:59:45 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7837329a00aso11345039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:59:45 -0700 (PDT)
X-Received: by 2002:a05:6602:356:b0:786:cd9c:cf9e with SMTP id
 w22-20020a056602035600b00786cd9ccf9emr1296590iou.2.1689235185426; Thu, 13 Jul
 2023 00:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230412115250.164899-1-angelogioacchino.delregno@collabora.com> <20230412115250.164899-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230412115250.164899-3-angelogioacchino.delregno@collabora.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 13 Jul 2023 15:59:09 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhpsUFrAz7dS5K-G+Vjw50vxN=n7OFQCB1d-JF6_n-nXw@mail.gmail.com>
Message-ID: <CAC=S1nhpsUFrAz7dS5K-G+Vjw50vxN=n7OFQCB1d-JF6_n-nXw@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/mediatek: mtk_dpi: Simplify with dev_err_probe()
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 7:53=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Use dev_err_probe() across the entire probe function of this driver
> to shrink the size.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>
