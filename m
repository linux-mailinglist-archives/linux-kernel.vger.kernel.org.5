Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637317A4FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjIRQvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjIRQvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:51:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370C8F4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:50:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401ec23be82so50805065e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695055853; x=1695660653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3lFpWEQNX0RgOS+vwuIIC94hCwP0MrQhLUc3uHKyySs=;
        b=M2TS0f7FH4VhfmUPOpE9TcSnZm5WZcZ8TmKzE8iVoIcPWs+f1+26GrQckzgHctpAMD
         BsTR/gEd6Sed24EU2TQrOEd1hohKrRZS01uekZLodN7mQG7hsbj7NdG7Ld8qwTUDCHSK
         GOgCdjdP8+NIaRWo90AKLNdxNk10w4vSeRtLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695055853; x=1695660653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lFpWEQNX0RgOS+vwuIIC94hCwP0MrQhLUc3uHKyySs=;
        b=aR+xvJh4LIRM3NViHEmMI7nIJB77K4rI2W8IiZNQlc7lPGLZOZRawd7l5gjnsLp3hz
         dj53tTt91NJS0/8MbPfsL+HFvEiIhk0At5fVcLMSL6XY3QIsioChRBuWjflgqLyipj+B
         519ky5Yj39lXxnSCHxqprEV6ZdP2jRJVTn6R6uUWOyNnmBaqitVfZBkrjqYYfSUmJYa3
         77frrYe+SKP0eaDQU1Ms386noZemP+NLwcjdFNwNkDdVVhmJk3yIYUgy7wfY1sAI/+et
         81y4yFmSBBCTtyhrtUsriXhXEQVO9OnCMzd5C6h+fGJLgrH5pQQXBJnU4wYpeq5WQwhW
         dbDg==
X-Gm-Message-State: AOJu0YygfCUOyUjLTHptdsW5qa4k1DYxQXxYkMpkBxk1Bl4H79fY9lsn
        2QnL64H72+KQePGOXphRdtQiZGcjLuTVyMxPsSVpfz9NugJn5Gso
X-Google-Smtp-Source: AGHT+IFnzEkphfcA1k56lMmjABKC+h4WWJYwladyvHeyaRQV3hNEF1Dw61zv3yr9gv0EEochrOGS5dXCs2GS30BWGs0=
X-Received: by 2002:adf:a3c4:0:b0:31f:f664:d87 with SMTP id
 m4-20020adfa3c4000000b0031ff6640d87mr7329776wrb.20.1695048675110; Mon, 18 Sep
 2023 07:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner> <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <20230918-hierbei-erhielten-ba5ef74a5b52@brauner> <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
 <20230918-stuhl-spannend-9904d4addc93@brauner>
In-Reply-To: <20230918-stuhl-spannend-9904d4addc93@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Sep 2023 16:51:03 +0200
Message-ID: <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sept 2023 at 16:40, Christian Brauner <brauner@kernel.org> wrote:

> What we're talking about here is a nicely typed struct which returns two
> paths @mnt_root and @mnt_point which can both be represented as u64
> pointers with length parameters like we do in other binary structs such
> as bpf and clone3 and a few others. That is a compromise I can live
> with. I'm really trying to find as much common ground here as we can.

So to be clear about your proposal: .mnt_root and .mountpoint are
initialized by the caller to buffers that the kernel can copy paths
into?

If there's an overflow (one of the buffers was too small) the syscall
returns -EOVERFLOW?

Thanks,
Miklos
