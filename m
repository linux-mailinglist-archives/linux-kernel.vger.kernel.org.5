Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738127E52AE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343838AbjKHJbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbjKHJb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:31:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DA41BB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699435838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rIJ9Sp4WDXeLHrAHmgcW3eORTPdG2Gg4lSkUwSA3Tro=;
        b=Mt1dXD+zqKrYLEgdt33A1vK/He9oQ2KrmqQR8s9og0vtpg0H5NsLa0EMATH8zxqXz/RT8e
        FUWGi+WJNqV4RpC/Dc0WrOr1j3zK+ubmCpjNigg1+I92qQJB0X53S9KiV5XTlWPrui5Pzj
        l1Bchkl1XRKnAmKLPFrm4hJjEpDa17o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-OLUKTo8mOh6zrdYr89rJiQ-1; Wed, 08 Nov 2023 04:30:37 -0500
X-MC-Unique: OLUKTo8mOh6zrdYr89rJiQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28003f0ecedso5089692a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 01:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699435836; x=1700040636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIJ9Sp4WDXeLHrAHmgcW3eORTPdG2Gg4lSkUwSA3Tro=;
        b=lETtMXeGAn4izTS6ynAl7B5SzHpxZo1iSP8Gd/dUZIkrDa1E77Jf4yErW5JYOLw1QC
         7A5svv4iWNqBpzbd0FJ1+Cew4X3kHJHIyBlVa+2XeOvxcpr6KpxDp56zCklza70abtlP
         Xcm+wCzkUG/3o0Its+f7XoXYBCZf/gn6VYrlaNiUAqGbBvwrrMJOGtCzZllPOeadZoKU
         OXnOqEdaW1bQwhooi2tMAafTA80woTZaCVLHFoDns+TTv6DNIfyUdqLlpnmaSey+qPZz
         NGht9ZVLxTXmaeu6rHfM2wuRuvVzkQ4Oz3gP/1Vll5OcNKWZhNdB5ToJ3u7J2pJu1Cc+
         TezA==
X-Gm-Message-State: AOJu0YxkEM5k+9l60XuBFOUn8HMbsBCP8+4VrKl98cLpjJVnRQsifZkg
        du8FzfkyLUihGgT2xj9dqkCq+WmJAgLbxhrCAwLFQPh3RcGLYRhHOA19DSQOzVyU/DUgNLS6W4W
        yElNcPjGdCLXX+/8AuHHLrxGwZs7G1ESirkJeKfePlortsklx
X-Received: by 2002:a17:90b:1d8b:b0:280:9074:eb3d with SMTP id pf11-20020a17090b1d8b00b002809074eb3dmr1121681pjb.22.1699435835968;
        Wed, 08 Nov 2023 01:30:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9bZILe3c2bhpCe4q7fc/KlUogt9ffT/7VG+Gw1ANZMxAhcGHfxel/wE9IvMJsNgengT/52pMt+83K3i+PiE4=
X-Received: by 2002:a17:90b:1d8b:b0:280:9074:eb3d with SMTP id
 pf11-20020a17090b1d8b00b002809074eb3dmr1121671pjb.22.1699435835705; Wed, 08
 Nov 2023 01:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20231031123207.758655-1-omosnace@redhat.com> <CAHC9VhRo2GzW0jSqmm0Sv3z_-q9PTsvScV5oQwF5uNh+ZcWreA@mail.gmail.com>
In-Reply-To: <CAHC9VhRo2GzW0jSqmm0Sv3z_-q9PTsvScV5oQwF5uNh+ZcWreA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 8 Nov 2023 10:30:24 +0100
Message-ID: <CAFqZXNtFfZ3FEoVAfM5r_a-mTqphz7qw=F3_Em87dRz6ca4EaQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] lsm: fix default return values for some hooks
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 4:12=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Oct 31, 2023 at 8:32=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > Some of the default return values listed in <linux/lsm_hook_defs.h>
> > don't match the actual no-op value and can be trivially fixed.
> >
> > Ondrej Mosnacek (2):
> >   lsm: fix default return value for vm_enough_memory
> >   lsm: fix default return value for inode_getsecctx
> >
> >  include/linux/lsm_hook_defs.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> These both look like reasonable -stable candidates to me, what do you thi=
nk?

Yes, that would be my assessment as well.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

