Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75282757210
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjGRDHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGRDHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:07:13 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32110E56;
        Mon, 17 Jul 2023 20:07:13 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-55fcc15e109so2223025a12.3;
        Mon, 17 Jul 2023 20:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689649632; x=1692241632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZR7e5E+WmOjH4SVZ3PNZKQQ2pHiOOZ9mhP0U68A34Cw=;
        b=HUHR94cp0/UyIKqtiyeZR237f5pSW8N8ZgQeHBP69YoNqbDBpIRRspMez7/dR1nSbA
         D5qJU15tV4LQDuoPeHx89HfUhOvGAvlGJvcEcI929f/Hf7zgzkNWNFGMJzI29PCKoWFZ
         Q+Q+KjcYKiZkXEef/XVx+m7w17eXuuo5Im6eQtys0XDz671hCNxckfAIvKtd6bREZzaX
         Vg647wlCoZixVN3W6uwFW4cQrqIaj69+VKx37sM9j6spDuWw3n53TOCC4UA9YYQJFCwe
         i3LRzJd25ksEZlUmDvDuAD5KJBQn6mWePTI/l+yd0/W8dWubcXYiqlxiqDSzu7zEnaUw
         Hk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689649632; x=1692241632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZR7e5E+WmOjH4SVZ3PNZKQQ2pHiOOZ9mhP0U68A34Cw=;
        b=fRGdGDCAjFf1oOz8zyFTkfPsgmkcdi4kRB+UHEBz06odEtGssK/yt42MwtzKrwSgYp
         qE7m2om9nb7uWn1sjGV7Ok71XRqMINp0kmpT0eYO4ee6i4OYox9bmPTt5KdgvOnz5+Ac
         gZ00/p8zyR2C6uj0Tk498KdapnzbV6n39NCtMGGDpz3oi8A+Ql6T8z6arDdBB4wQPPYw
         adsXNh3GJRVqws0+AOooB9KWxQJyv/A2cAHr+NZqUNmyhL6mFQC7bsywqBp+diORTo+f
         b9gc+1rlcz21YcBcppoLXq3Q6j0ShudKkYYjsFE5h0qle1Rd/kia+3Tr1uELpdiVm8fp
         P4IQ==
X-Gm-Message-State: ABy/qLYYU7NTv7KqEuMqfc4YNzQPe0U+ap0nZhvnfh5p/V/8fN3mVEMu
        nZjtQnTZy8eXjME1+pFwsGkBeaU7eva1buz20So=
X-Google-Smtp-Source: APBJJlEIXk60X1gz7KXtucZl+go0i+pO9jKQGEd+WuXxiukOtcA+L0Dmx90vVupkDTpQaP2XilHviR9/o2lJNd7yl9A=
X-Received: by 2002:a17:90a:fb83:b0:263:f3ad:64af with SMTP id
 cp3-20020a17090afb8300b00263f3ad64afmr10685369pjb.45.1689649632428; Mon, 17
 Jul 2023 20:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230707092414.866760-1-zyytlz.wz@163.com> <538096d2-7b24-e1c7-706d-4d4f952d35eb@baylibre.com>
 <CAJedcCzR6DzX_aG1KBgrMHDJ1xh=RTA-FrZ+TJ_4KawWpHyYuA@mail.gmail.com>
In-Reply-To: <CAJedcCzR6DzX_aG1KBgrMHDJ1xh=RTA-FrZ+TJ_4KawWpHyYuA@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 18 Jul 2023 11:07:01 +0800
Message-ID: <CAJedcCyKv-hdDhWcogDZrC-kY6qtO-H1fDYqjTXMJvCR19MxYg@mail.gmail.com>
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

Friendly ping

Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=8816=
=E6=97=A5=E5=91=A8=E6=97=A5 00:08=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> This issue has not been resolved for a long time. Is there anyone who can=
 help?
>
> Best regards,
> Zheng
>
> Alexandre Mergnat <amergnat@baylibre.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=
=887=E6=97=A5=E5=91=A8=E4=BA=94 22:11=E5=86=99=E9=81=93=EF=BC=9A
> >
> >
> >
> > On 07/07/2023 11:24, Zheng Wang wrote:
> > > In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> > > mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> > > and mtk_jpeg_enc_device_run may be called to start the
> > > work.
> > > If we remove the module which will call mtk_jpeg_remove
> > > to make cleanup, there may be a unfinished work. The
> > > possible sequence is as follows, which will cause a
> > > typical UAF bug.
> > >
> > > Fix it by canceling the work before cleanup in the mtk_jpeg_remove
> > >
> > > CPU0                  CPU1
> > >
> > >                      |mtk_jpeg_job_timeout_work
> > > mtk_jpeg_remove     |
> > >    v4l2_m2m_release  |
> > >      kfree(m2m_dev); |
> > >                      |
> > >                      | v4l2_m2m_get_curr_priv
> > >                      |   m2m_dev->curr_ctx //use
> >
> > Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> >
> > --
> > Regards,
> > Alexandre
