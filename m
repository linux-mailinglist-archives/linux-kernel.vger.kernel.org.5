Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC2C751E30
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjGMKFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbjGMKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:05:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8767326B8;
        Thu, 13 Jul 2023 03:04:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e590a8ab5so628922a12.2;
        Thu, 13 Jul 2023 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689242688; x=1691834688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG0tftJGRVz+edfVy1HASxGCbkPbMa+Ya7MsRka1IMk=;
        b=GlPdBTJKtNXurT9JZybgKrI0dvbFIOquoPg2+wj0f2VNWSGCpc5nvlFsjV7BM7RWvu
         XuPX6Vaqvn1rZIn2e5pXhkoatYDRvzOEzNVNa21+fHRsSdrjd4Hu/74UyGgiW1uICBpq
         L2e2auTqldrd6WXj5OQQIbNusW5b2RYWgX+A7iqy3yra3QFsufgTPA0mJB4HfIcnEQIn
         mEZIMp6+MnQj4awRyOp/Rpy8soO3JORz+WIJr5oDQKJ5PA2ViQ/Pfu4fv7dV+EBFMVSF
         NNXJ1IIQq5h9rD4P1MFk9WYX2nEPtmlYjFHiN1lHNERv4TatYgFh9smfht0QO476Z58d
         DlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689242688; x=1691834688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AG0tftJGRVz+edfVy1HASxGCbkPbMa+Ya7MsRka1IMk=;
        b=BuJYspotjnwa2lD2YTjAa6d6NDd+dptlhi3ihCjQzJKoReXkZKLWuu6SFq4B05YyxW
         IgeqwLb9IJaulAPIQme4DDib9VINeRH40/JbYhiJxVtcomx9zBZMUkbg05gsJLmN4kC2
         fM2XxYErQHy779wRU1q+QPG9TTBzBFuYgpaANKfUsOEqEFXWyJphIdR/52fLB5nPky4P
         ALekFkBAzZgU79QmNMT2eopz/RrqloTUpd7w5qzdxdpmrauRZHKzkcizaurW4PClUheT
         8xb6d9jxQXHJ8012bZedsaiVmu7Nz51gcW0O3QdPoZbm+HNbHDoldwZgCQEV7q3gXtRJ
         +lVw==
X-Gm-Message-State: ABy/qLbiN8FTg1SfU0rDd5gYJjOmpZUrQyzCvuju7Rf4djeZpqXBcC/p
        Ojv1d1KUvnc2txCQ/CaIPDLINTCzWiaegP7Nvjc=
X-Google-Smtp-Source: APBJJlGTsPG7qROrK9c6x4dqWbJryjQgq60jKxVsQy49wVkCX3YAqX3GbLggc9QIi0jeewxZwA6wL53aP2DjcgYFxFA=
X-Received: by 2002:a05:6402:1511:b0:51e:362d:b172 with SMTP id
 f17-20020a056402151100b0051e362db172mr1474885edw.32.1689242687762; Thu, 13
 Jul 2023 03:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230712224220.26430-1-iuliana.prodan@oss.nxp.com>
In-Reply-To: <20230712224220.26430-1-iuliana.prodan@oss.nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 13 Jul 2023 13:04:35 +0300
Message-ID: <CAEnQRZAqW4zVOrtRRUNHtR4rW0n3dXQ5+4PPaM3jSW7D70Gy9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] remoteproc: imx_dsp_rproc: add mandatory
 find_loaded_rsc_table op
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 2:13=E2=80=AFAM Iuliana Prodan (OSS)
<iuliana.prodan@oss.nxp.com> wrote:
>
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>
> Add the .find_loaded_rsc_table operation for i.MX DSP.
> We need it for inter-process communication between DSP
> and main core.
>
> This callback is used to find the resource table (defined
> in remote processor linker script) where the address of the
> vrings along with the other allocated resources (carveouts etc)
> are stored.
> If this is not found, the vrings are not allocated and
> the IPC between cores will not work.
>
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
