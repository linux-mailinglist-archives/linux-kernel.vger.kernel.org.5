Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CFA7549FF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjGOQIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGOQIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:08:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B5B2D51;
        Sat, 15 Jul 2023 09:08:45 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8a8154f9cso18714415ad.1;
        Sat, 15 Jul 2023 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689437325; x=1692029325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wj4Cy8RQ6W/zc3QPSV8hmPb4p0rBodU5v6Z12U3dgao=;
        b=f1Yoji6Lk7hLFrGWvVHMB99I94iqNPLf53nN99C+Euf1eko0lDj6+rwlqw+Dgk8UQQ
         SRpsuRlsVNHD4H3CtBAY6OqSPEqSJZUwFP+cS9hB5oGMHDh1EVrIAUWdGU5BH6VhjFBW
         /z1yHF+21yYGgNq9TAwrNx1v4HfpVczxiW79BGFcmf51YVbRm8YkB2rC0PG8Wz14mMZc
         0CZz2ejtvs3mc6jFez6MjOZAENbTvA1WktKizZDkR7JMqJrAQbPdsIohUFetUtXw+PaF
         KQoa95Jtgb3QO1zhPcZxPZtw2Jc8U8JccvLv74fIUQ1k70FctgFVnPIiuRT5Ui6YXY5w
         ivhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689437325; x=1692029325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wj4Cy8RQ6W/zc3QPSV8hmPb4p0rBodU5v6Z12U3dgao=;
        b=IDXezXX+5fsAuzXAeNyV7QwKRoTISnTLuDNNxCKaCecUZXmVJPrDZ2nICAcPl+77hm
         xREgD8AOKDqIHoUV6cw+92oqddOynyvYXWAaBPFsEfrck2eZU1Ay8hWBGXjRK3kZD5rS
         9sfnMNNykrhUo+qSWpn7hrNbHVOd0ITTx03nMbaB59OQCCFittAT+8BGhZ/MSGXN+LGY
         +VQSSdDRa+Lx0O/pL0qt4zK62tpRwbuQKpQg6nC9Nuevd4JEqByOXcS92bkZ77L/fhQa
         Vcy0sOvP1knyv+exIXRVc4nlbHASz4WHqmRP+Gs1Wwl9IjCcJDNTdFT0DcdBz7qW5LFd
         jOeQ==
X-Gm-Message-State: ABy/qLaTDxOehF68+R7OkVIpm1l3m4njo0KncreHKKYeAHs2tWLtF2Oi
        7YkcNJHiJ/ZLvwqDVga3GcHPxVxoVd0SJeU5mWQ=
X-Google-Smtp-Source: APBJJlG9cTRO0B/J58Dk72R+ek7gW9xZzMEOglyV1YUlimrJNp3sZdyPb2I4AXwzW/e0UeBY9xyjV4b1/NXsL7lhrN0=
X-Received: by 2002:a17:902:dac7:b0:1b6:b703:36f8 with SMTP id
 q7-20020a170902dac700b001b6b70336f8mr8179654plx.25.1689437325128; Sat, 15 Jul
 2023 09:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230707092414.866760-1-zyytlz.wz@163.com> <538096d2-7b24-e1c7-706d-4d4f952d35eb@baylibre.com>
In-Reply-To: <538096d2-7b24-e1c7-706d-4d4f952d35eb@baylibre.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sun, 16 Jul 2023 00:08:33 +0800
Message-ID: <CAJedcCzR6DzX_aG1KBgrMHDJ1xh=RTA-FrZ+TJ_4KawWpHyYuA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, Kyrie.Wu@mediatek.com,
        bin.liu@mediatek.com, mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This issue has not been resolved for a long time. Is there anyone who can h=
elp?

Best regards,
Zheng

Alexandre Mergnat <amergnat@baylibre.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=887=
=E6=97=A5=E5=91=A8=E4=BA=94 22:11=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 07/07/2023 11:24, Zheng Wang wrote:
> > In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> > mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> > and mtk_jpeg_enc_device_run may be called to start the
> > work.
> > If we remove the module which will call mtk_jpeg_remove
> > to make cleanup, there may be a unfinished work. The
> > possible sequence is as follows, which will cause a
> > typical UAF bug.
> >
> > Fix it by canceling the work before cleanup in the mtk_jpeg_remove
> >
> > CPU0                  CPU1
> >
> >                      |mtk_jpeg_job_timeout_work
> > mtk_jpeg_remove     |
> >    v4l2_m2m_release  |
> >      kfree(m2m_dev); |
> >                      |
> >                      | v4l2_m2m_get_curr_priv
> >                      |   m2m_dev->curr_ctx //use
>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
>
> --
> Regards,
> Alexandre
