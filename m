Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82594786A64
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbjHXIng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjHXInD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:43:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B90B172A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692866537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zbW1FngvFUK7KWlxfPdST+Zwcl1JxZSoJl2PteoHaDs=;
        b=ZGw6PVEkyoEtIgDHELSkeKEC2z2gyYTFbACQ3rPa8K6C1MG6DZ/BGwCIKyjFxd/02Kw066
        b8yY4X49ZmM+rG5vcwJoPigXhh37rhTiAAcjL5014ajps5Paf9HPul/NjiqZRDNX9kk2O8
        zbxpMh4VojN102Lz5QbkIiEH7RzyrY8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-NHh3YYHEOM6jlxfgmirdgA-1; Thu, 24 Aug 2023 04:42:16 -0400
X-MC-Unique: NHh3YYHEOM6jlxfgmirdgA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2bcc0c073ffso9016681fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692866533; x=1693471333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbW1FngvFUK7KWlxfPdST+Zwcl1JxZSoJl2PteoHaDs=;
        b=URo7dRPcy4LGJiurfiF7f17pmLsixd1cfv2L6/bP++hEUzV/tuUJhSg0/lzAgYuXJC
         33izG//eo9YHI/NY08f70AmVCPelyHoMXENsxAFkLZjy8cyOQ4FEyrsGPJ8zqPj1HW/Z
         +9ayyDEfwWXsBd2TutGbjEy6ombYdHhPKZBp56H6UkdhyU828t04snKfBtQxRf0hnEmB
         8WHN/L3C89RdVvgl9mebDxifk+qMkPJNsuBZPWi8tgpWO2GGx9V8DZXEIysy4PczdCtT
         jLvV7ObEsDeDANhdCEhycXHz3h+BPSFsIgaai3DtGXeOp+hkzS5VtnNHUzn8HwMiaVa0
         Jaiw==
X-Gm-Message-State: AOJu0YxdlMM7tl2XLxAJbx/ZL7oeszymFrNItb8p7PfsSNFrIRBziDto
        5WQh+XSuSoOXppX/q18TUqh5/KVOzjeSVn3emmHt2h+3AdsjX/bWgrQshy8GJyE4MirjO2TP+so
        mvpIl79sSwqtFZl3GnlL0abEtvpq+b6QuMJkc0JF/ea3bgkhHVBs=
X-Received: by 2002:a05:651c:102f:b0:2b7:34c0:a03a with SMTP id w15-20020a05651c102f00b002b734c0a03amr10216704ljm.3.1692866533702;
        Thu, 24 Aug 2023 01:42:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElJNjBNGCil9PiBaG5sCBxmyOojBV3da4X7jH+b9AMAG6B3VNG1VxewojaAZwNQ4H48vofhmQ8taWfMFeXp1c=
X-Received: by 2002:a05:651c:102f:b0:2b7:34c0:a03a with SMTP id
 w15-20020a05651c102f00b002b734c0a03amr10216692ljm.3.1692866533551; Thu, 24
 Aug 2023 01:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230824073710.2677348-1-lee@kernel.org> <20230824073710.2677348-7-lee@kernel.org>
In-Reply-To: <20230824073710.2677348-7-lee@kernel.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 24 Aug 2023 10:42:02 +0200
Message-ID: <CACO55ttW6gmTLNOW+Ty34s77yOBw-FhL6gWZnuXYqQYjw4WxOQ@mail.gmail.com>
Subject: Re: [PATCH 06/20] drm/nouveau/dispnv04/crtc: Demote kerneldoc abuses
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 9:37=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c:453: warning: This comment start=
s with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide=
/kernel-doc.rst
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c:629: warning: This comment start=
s with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide=
/kernel-doc.rst
>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> ---
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/no=
uveau/dispnv04/crtc.c
> index a34924523133c..5454dbb669566 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> @@ -449,7 +449,7 @@ nv_crtc_mode_set_vga(struct drm_crtc *crtc, struct dr=
m_display_mode *mode)
>         regp->Attribute[NV_CIO_AR_CSEL_INDEX] =3D 0x00;
>  }
>
> -/**
> +/*
>   * Sets up registers for the given mode/adjusted_mode pair.
>   *
>   * The clocks, CRTCs and outputs attached to this CRTC must be off.
> @@ -625,7 +625,7 @@ nv_crtc_swap_fbs(struct drm_crtc *crtc, struct drm_fr=
amebuffer *old_fb)
>         return ret;
>  }
>
> -/**
> +/*
>   * Sets up registers for the given mode/adjusted_mode pair.
>   *
>   * The clocks, CRTCs and outputs attached to this CRTC must be off.
> --
> 2.42.0.rc1.204.g551eb34607-goog
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

