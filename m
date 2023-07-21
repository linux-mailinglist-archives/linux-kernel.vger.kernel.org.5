Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E00975D7F0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 01:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjGUXr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 19:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGUXry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 19:47:54 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD4E30DD;
        Fri, 21 Jul 2023 16:47:53 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-bff27026cb0so2366175276.1;
        Fri, 21 Jul 2023 16:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689983272; x=1690588072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zdidEn8+DgwQGZvgmO/L7F7xMLay9WsUmEDZLpMAbc=;
        b=ATeyEp3GDz4IolJEsWAOgfWaNajJWJaT7YmLW8cwz3oTgSTyQrQ1xDw+btoHCCmREk
         9mfO28n8sozhIRUV5vZaCRUiCzXPciykCwPDegkZ/65H8kCoLJCQNKQeWbVCrb9nZJH9
         NpLgK+05kMwTgoX8gSn8lp1AlxdkgMqLONwOG4WWu4yJlUCScPff9Sn+Nz2JpboIxDFY
         DRLQa0HBCEmdycRf76jWWOjagssQSqB+w/i0KZQsUxefDFvp1k9QdIYeJqhfOVJhNlj5
         TjaBU5pN81p9uMKOD4VyTrk2lbj6lS3srRD4PbcnEelCS37M6mKUPhRm898R0uGZQF0h
         BSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689983272; x=1690588072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zdidEn8+DgwQGZvgmO/L7F7xMLay9WsUmEDZLpMAbc=;
        b=Y/zfs6PcJVDWvBi3l3DN+bZleOIQ1mjL4zoF60F+sgo3Tg3V/SdJeHxv1fPXieUyVt
         Cj1QSiwHvPCC0uztWC8D26SeN6pDd+LnJjLz73dYpImmLsydlpThIadQoUgi2g4ZX1dJ
         evDYLRtWQV7GWAIavkU121j1rzCzLJkcThJlh7G37qsqPPk5NXmQ1MgBlUQhNZ7+MdGV
         XryEjU6Ut7ifdef/cI6ukPIxw+SpQ3v6DLqIFyrBdwZmYcTxgS4UfjVpfPldPkQDS7Ee
         eX7wghnaJTRuF/FzapJbvm4vTtyjyXvy9SLkUicHRFB6nopyYMi/5vIlFNe4tJ0BVlxm
         r6Gw==
X-Gm-Message-State: ABy/qLaxuLjyZfjvNhDwlpR1ViCteps+J02L+3B/C9PIToxfOE8abMT3
        rTLC+Rj9i+4NKWJ2QAwQsCmR3IEjNXjY3DW1FV4=
X-Google-Smtp-Source: APBJJlFkKQC+QsNexWYuobiHBX2ekwBWJ20OWolyOxCqLoJOHqwSCYA+fdngamCB9WAB4U8kMWo6B4XdlY0RmE+j8CQ=
X-Received: by 2002:a25:d804:0:b0:d01:6e22:9291 with SMTP id
 p4-20020a25d804000000b00d016e229291mr2880083ybg.34.1689983272333; Fri, 21 Jul
 2023 16:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230719081544.741051-1-javierm@redhat.com> <20230719081544.741051-2-javierm@redhat.com>
 <87sf9gublz.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87sf9gublz.fsf@minerva.mail-host-address-is-not-set>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 22 Jul 2023 01:47:41 +0200
Message-ID: <CANiq72=A3PLGGPGnwL=gjX7LFsQL9N8W__ojxmVpj2uCAKvhQA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] video: Add auxiliary display drivers to Graphics
 support menu
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 12:46=E2=80=AFAM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Javier Martinez Canillas <javierm@redhat.com> writes:
>
> [adding Miguel Ojeda who was not in the Cc list]
>
> Hello Miguel, could you please ack this patch so that I can take the whol=
e
> patch-set through the drm-misc tree?

A note below...

> > The drivers in this subsystem are for character-based LCD displays, whi=
ch
> > can fall into the same category of the DRM/KMS and fbdev drivers that a=
re
> > located under the "Graphics support" menu. Add auxdisplay there as well=
.

Nit: this is not exactly true, e.g. ks0108/cfag12864b (which were the
first in the subsystem) were not character-based but a very simple
black-or-white 128x64 grid, so we should probably reword slightly
this.

In any case, if Helge thinks these may belong in the "Graphics
support" menu, then I am fine with it:

    Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
