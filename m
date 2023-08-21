Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BEB78221C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 06:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjHUECJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 00:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjHUECI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DDA8E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 21:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692590480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K48wOkgYX/+Fqd9BgiTgVDDaxoT43hfwzWV+z1KABwU=;
        b=Tb87rWaHC+2njvP8+WeAgiyQbP02a2tbHBNYrapt8ss4laQWVwMcgRa8ytZjz/Tg2VGY/q
        ek0+ZUmIqjaHZWeF8WpxpIwP38+pOOQCSpVj+/af6R1t1pOOvfkFYvUywc/qJPka4v4dcX
        B678A1OV802706ZYwMklIjGqBHA2wkA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-Oe4EFmddOGqySKPlns0TCw-1; Mon, 21 Aug 2023 00:01:19 -0400
X-MC-Unique: Oe4EFmddOGqySKPlns0TCw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2bcba79cedcso6409521fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 21:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692590477; x=1693195277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K48wOkgYX/+Fqd9BgiTgVDDaxoT43hfwzWV+z1KABwU=;
        b=Uifr8xuhPl0mC+lb8B1G7uqzI8TuW3IDehty7TtpsfkpZ3q0v0jZy1jSMcvAZmkc1p
         DL+Qk56C+wnUrA7kQ/Pq7y/sD6PZC6zp7tG2eq2Pxatq2ROUz5iu+jXu6HZ2zaBgKZHb
         /7ksP7xbkw4L4i/OXWLcvzIbJwwQIDf9k16/4u4kB8j6n6bUgwTHetKRQZQkTz+Vf5a7
         IdCKXc+7vDL8pz6O5/njfW1x5tMFe8vdfBfD74VwWVdThpD6N7zE6Z0CnNqml61OJZtC
         xozN92DT76mztbLBn6GkMLTgYqoBoFc+ZI9wkAsydjflfT6n3p2ZqCJ4fJoYmB/TxLej
         83aw==
X-Gm-Message-State: AOJu0YyGDBxIJWgSYwAOaEGW8o6x3KFpLJJUBbeGUQb5LVRyDTvGNqNM
        CyP0sM9JV7N3NH/ZbGogxQ4ABZfMZ2Z2hVKaLPL95xIGrTiSQvK5RW75G6GnB0DZxldMy60pfWY
        Z/SLH/SWsxeJNp5WzG/N4uMJH8E9X58ari09N0vdZ4nfKddKYDeg=
X-Received: by 2002:a2e:8283:0:b0:2bb:94e4:49f with SMTP id y3-20020a2e8283000000b002bb94e4049fmr3352791ljg.32.1692590477706;
        Sun, 20 Aug 2023 21:01:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBNlrj9YNsjazLmKSqxb2YYKFRv5ifZ125cg5mmpZIBasDNsmvkUajlOqWzEspqb9PqDMdZu+/Nh/IbMwo2yM=
X-Received: by 2002:a2e:8283:0:b0:2bb:94e4:49f with SMTP id
 y3-20020a2e8283000000b002bb94e4049fmr3352775ljg.32.1692590477420; Sun, 20 Aug
 2023 21:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230821011535.1117-1-shawn.shao@jaguarmicro.com>
In-Reply-To: <20230821011535.1117-1-shawn.shao@jaguarmicro.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 21 Aug 2023 12:01:06 +0800
Message-ID: <CACGkMEukZTMdaBvUOD_FSW+Lxb6N9rfEEcSQ1Xv1UWcedJeWvQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Update sysfs ABI documentation
To:     "Shawn.Shao" <shawn.shao@jaguarmicro.com>
Cc:     mst@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, lege.wang@jaguarmicro.com
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

On Mon, Aug 21, 2023 at 9:16=E2=80=AFAM Shawn.Shao <shawn.shao@jaguarmicro.=
com> wrote:
>
> Fix the wrong drivers_autoprobe path name in the document
>
> Signed-off-by: Shawn.Shao <shawn.shao@jaguarmicro.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  Documentation/ABI/testing/sysfs-bus-vdpa | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-vdpa b/Documentation/ABI=
/testing/sysfs-bus-vdpa
> index 28a6111202ba..4da53878bff6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-vdpa
> +++ b/Documentation/ABI/testing/sysfs-bus-vdpa
> @@ -1,4 +1,4 @@
> -What:          /sys/bus/vdpa/driver_autoprobe
> +What:          /sys/bus/vdpa/drivers_autoprobe
>  Date:          March 2020
>  Contact:       virtualization@lists.linux-foundation.org
>  Description:
> @@ -17,7 +17,7 @@ Description:
>                 Writing a device name to this file will cause the kernel =
binds
>                 devices to a compatible driver.
>
> -               This can be useful when /sys/bus/vdpa/driver_autoprobe is
> +               This can be useful when /sys/bus/vdpa/drivers_autoprobe i=
s
>                 disabled.
>
>  What:          /sys/bus/vdpa/drivers/.../bind
> --
> 2.34.1
>

