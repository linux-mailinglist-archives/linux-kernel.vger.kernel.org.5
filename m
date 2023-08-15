Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6106077CB5D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjHOKzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbjHOKzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:55:36 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB0AE51;
        Tue, 15 Aug 2023 03:55:35 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-64189860374so26565816d6.0;
        Tue, 15 Aug 2023 03:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692096934; x=1692701734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS6E+WA17qoMBKuZQMvsTvVktQ4enVdWMkHZuJJzAq8=;
        b=KM8azyCxAA4PnsLYTcs72VPk4rQ9DDCVVBFL1mWrgCV1wh+2hiYGH2UHaEYQvWYYHX
         bzZ5Y4t71bEW0Gi1cUJAPYPwcQ0KnOqT1vKm6fvebtO7/PSc1OkBz9duOcrIMyJxkXW1
         MEUXiCyt+175oX1rVbB7rtG1GJ3oGq8IykjOxBIQxovfwQU7RW7xcW4zQxTIvLZcjCsT
         WxTtD+WdrQVyB4DRySn/KMGtcI5uDnMpC9twkCprLprTKNxljZojkPKQpaDzY2fJ52M1
         8NPPydcKdZi2WFzC+j+k4AzMOwzT8owxEz+V887gp3xP3n2NT/ug3bc1/j97KuRa1RyC
         17fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692096934; x=1692701734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nS6E+WA17qoMBKuZQMvsTvVktQ4enVdWMkHZuJJzAq8=;
        b=L3md9JEaBQejPwywAwRBnRay9RKvFrUVK6oGyFId1fAjEeRn7Cxvk93kQX2W1tqglN
         +NDuKU6AeL3O69lOl9mlK1yTckEUheEkLnrG8T8nTrYgyALAKUuYTdKitJa0kYOHrJWZ
         po3YBqWt15DGUvvcpuYTbvRSxTsFGN60kepybmQz9k9iII+0u4YdyOK3SduRRBzGbqBg
         73cFqXtvFs1lAznd8TMW6C2TqvbaplnZdM+Ndi6lwp2XT+M/xwAybmGDSFLdvR6Yrt5E
         202zPijXKrqZte8X0swZoQkPOAfIAtYUkMWp6POF2YFesGf3YKFrYlh1V3hFoN6AQYmA
         Gwxg==
X-Gm-Message-State: AOJu0YwxFRD6KYw6YEEQMZk6iRF/3HtvZ8ODQmPVUDKlvDY/HJYe29Ac
        hafPbFrMiCQpWlXFlBzof7OZigYLA1Z1LSrK/G0L+bga5pk=
X-Google-Smtp-Source: AGHT+IGLZrlEMJT++dwwy8fiSAzJhP/msapLnRt+a2knKvYq/QbBej4gqD4J+ZD1nDgZoENq93D2QrLmrBslyraSatY=
X-Received: by 2002:a0c:b205:0:b0:63d:77d:be74 with SMTP id
 x5-20020a0cb205000000b0063d077dbe74mr13199961qvd.59.1692096934348; Tue, 15
 Aug 2023 03:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230815014057.13589-1-wenchao.chen@unisoc.com>
 <e66ee2ba-1668-cb88-f7ac-7c7722387fe7@intel.com> <CA+Da2qyuh-WcXdj2emkWcUkqH57W4p6aei8wijFw5fA7og0eaA@mail.gmail.com>
 <a241ac07-c9d5-ba76-44da-267006713365@intel.com>
In-Reply-To: <a241ac07-c9d5-ba76-44da-267006713365@intel.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Tue, 15 Aug 2023 18:55:23 +0800
Message-ID: <CA+Da2qxf0o4C-yQZ4EirSRZCGs7a+BZLdxpmXeVM1zsMxG9rmQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] mmc: sdhci-sprd: Add SD HS mode online tuning
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com,
        chunyan.zhang@unisoc.com, yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 6:37=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 15/08/23 13:29, Wenchao Chen wrote:
> > On Tue, Aug 15, 2023 at 2:21=E2=80=AFPM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> >>
> >> On 15/08/23 04:40, Wenchao Chen wrote:
> >>> Change in v2:
> >>> - add mmc_sd_switch() and mmc_send_status() to the header file
> >>> - split up core changes from host driver changes
> >>> - Use pr_debug instead of dev_info and dev_dbg
> >>> - Optimize the best sampled value algorithm
> >>
> >> What about hooking ->set_ios() as Ulf suggested?
> >>
> >
> > I've tried that, but it's not a good way to do it.
> > We found that sdhci_runtime_resume_host() calls ->set_ios, but we
> > don't want to do that.
>
> Given that sdhci_sprd_runtime_resume() calls sdhci_runtime_resume_host(),
> it should be possible to determine when to tune, right?
>

You mean like this? For example:
static int sdhci_sprd_runtime_resume(struct device *dev)
{
...
sprd_host->need_hs_tuning =3D false;
sdhci_runtime_resume_host(host, 1);
sprd_host->need_hs_tuning =3D true;
...
}

> > We just need SD HS mode tuning at mmc_sd_init_card().
> >
> >>>
> >>> Wenchao Chen (2):
> >>>   mmc: core: Add host specific tuning support for SD HS mode
> >>>   mmc: sdhci-sprd: Add SD HS mode online tuning
> >>>
> >>>  drivers/mmc/core/sd.c         |  12 +++
> >>>  drivers/mmc/core/sd_ops.c     |   1 +
> >>>  drivers/mmc/host/sdhci-sprd.c | 152 ++++++++++++++++++++++++++++++++=
++
> >>>  include/linux/mmc/host.h      |   8 ++
> >>>  4 files changed, 173 insertions(+)
> >>>
> >>
>
