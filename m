Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AA67ED715
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbjKOWSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjKOWSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:18:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8991A1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700086698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A0/rh1GWMWqNOAuzi+E/D5JJGdyRKtEN1IIz+9EJyJc=;
        b=cX4N4tpD053mtMhWD4SbdgdIY//gyI6pEdZqxBx0VGEFc1vpk9r9NY74T7PGCdwWdGejtr
        etgis2Q5CpLcgbnJ8AWw0kM59LEyomknAX0WhyxPzLVl+JSzrzIcf/XZI+R4V8OP+KQTGy
        R6CLtJG0LjVKZkfqdmnfRITfVe9VETo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-zeY_1MkUPGWSvPG4sGZEyQ-1; Wed, 15 Nov 2023 17:18:16 -0500
X-MC-Unique: zeY_1MkUPGWSvPG4sGZEyQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc3130ba31so2330205ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700086696; x=1700691496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0/rh1GWMWqNOAuzi+E/D5JJGdyRKtEN1IIz+9EJyJc=;
        b=Rshulrd0Yt6ov3GJhGXvpykVypXwrUqAB29f4oI4x/z5vCESr+VacIw6FsKIjgrLbA
         mbvlGBoKgT/Z06LiuuPk0E5xyuyFvptSNpPEAt8Xppfe8SThz80pQ07eKA3s0g6fOGqE
         F27pG3hUrIPpLzGWRczUs5dz6+JNKFJnVkUz7cS2oBJbkLtkVv54SLhHtDjl9wYl1geZ
         WfICm8cTjsS9rClyAoFUwij4eaVrQifdYemaf40vIQtrqV5qZc7DrGmUszZBvgl/N9Kj
         Juaxh6P6Y0xsoxJx+6TYhbZ5TCcCslUf4SA2KDPfu+GSD2+FnEmdUfFMxwZL6E4Lu81m
         cq0Q==
X-Gm-Message-State: AOJu0Yw7K8OBP8BjLdzKC99w4NqYK3eI5AQ5qUurXbz5uLHHND5KhJ88
        dnlum7JGf8j8C7AYY6uWwlDhl081Dr76MDuJyScForWE2hKta8+86L7vWIE/4HDvKBrEVVbkapP
        c8tp3XnSTDbIEHGveOjHAgrOeI5u2tOFNA6/KCeuh
X-Received: by 2002:a17:902:d2cf:b0:1cc:41e1:ba38 with SMTP id n15-20020a170902d2cf00b001cc41e1ba38mr7943523plc.66.1700086695796;
        Wed, 15 Nov 2023 14:18:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFG1mh7ByOW2vMg8PJsNJgWpyGvG6kR0o2/0CQ9wNsnIup4FnKH5m/Qnxi9gYyv9HJaS+LfeBtQQrMrVgPzRX4=
X-Received: by 2002:a17:902:d2cf:b0:1cc:41e1:ba38 with SMTP id
 n15-20020a170902d2cf00b001cc41e1ba38mr7943498plc.66.1700086695397; Wed, 15
 Nov 2023 14:18:15 -0800 (PST)
MIME-Version: 1.0
References: <20231116073950.02c0610f@canb.auug.org.au>
In-Reply-To: <20231116073950.02c0610f@canb.auug.org.au>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 15 Nov 2023 23:18:03 +0100
Message-ID: <CAHc6FU5qLYLw=EVodktQbEuBVZmV-tT1FpTvvaoPD1ezvRso1A@mail.gmail.com>
Subject: Re: linux-next: contacts for the gfs2 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Whitehouse <swhiteho@redhat.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Nov 15, 2023 at 9:40=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
> Hi all,
>
> I noticed commit
>
>   2e6ef8aaba6b ("Remove myself as maintainer of GFS2")
>
> Currently I have
>
> Steven Whitehouse <swhiteho@redhat.com>
> Bob Peterson <rpeterso@redhat.com>
>
> listed as the only contacts for the gfs2 tree.
>
> Should I change that to
>
> Andreas Gruenbacher <agruenba@redhat.com>
>
> or keep Steven (even though he is not listed in MAINTAINERS)?  And should
> I add the mailing list as well?

I think it would make sense to put me in instead of Bob. Steve hasn't
been working on the actual code for a while -- even though he remains
a valuable source of information for GFS2 -- so I don't think he will
object to being removed here.

For the time being, I will be the only person screwing up the upstream
gfs2 repository, so I'll also be the person to fix things up again. In
that context, would it make sense to add the gfs2 list? Is this what
you would commonly do?

Thanks,
Andreas

