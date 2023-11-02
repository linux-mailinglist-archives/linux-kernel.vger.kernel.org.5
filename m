Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD91D7DF49F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376721AbjKBOK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjKBOK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16F3130
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698934214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QoDps1pxenwZOZ9m0T+aL+AuxWCgPC/zSX1/to1vF98=;
        b=B8wDQmzcsQjfs62mSbv1E4KaZ2F6tQZnddXKIwBkBcCmGiSKn1RdjzNgpler3M0XsO/huc
        ZC3/wrya2Nc9aptpJLczxxdc5KdKj0nRS6YoWhkTIsKwCvGDiOvmOakkHk6FysIQNumsnL
        4CRgjuFraT5zjVP9AnW6LzxjBCBlOy0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-MlciJFGQORuA7twYdwWTDw-1; Thu, 02 Nov 2023 10:10:10 -0400
X-MC-Unique: MlciJFGQORuA7twYdwWTDw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae0bf9c0b4so76260766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698934209; x=1699539009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoDps1pxenwZOZ9m0T+aL+AuxWCgPC/zSX1/to1vF98=;
        b=HVfyL5R04Oz9J7X+jzofOYtoK59Um1IE5WvIGGZeKeRJ8HcPG8q8eFOB+T3ZuRD3Qr
         NrP/LAUUf/x+6Qx29iCPUhZGDoEdkoGfPC3lH68Q+Jy076la8giPbtgzyZO/D9yDoG8Y
         lX40ho6H0RWE5avXt6772eMayICfWLLnF5GDza6gjYMUZfkKKpzN2z6tSAgmTcbZbgeR
         msE+xT+L9Kv3KYLxh6e20cHkNOan+V7DyZBn6/wQAfv5t7l36bVtZxwQCbZwpYjD92JP
         avuOUFP9EkgGWCcFd2y9r0Vv2ZD9wB2HX9Xbls7rHdfCUUbWJ6REFzVZwUpQ7mArs2KM
         bgYA==
X-Gm-Message-State: AOJu0YzaO46riGvhKSp95+1zesuLSOylB8nxWTHRJKbbqM1dSwWn1sX1
        Q3KV/KAvxdLyVbE4V5jhQQ66C7VIn2alcn0A8hmEsUswiLlTUSVurXt4bPWK8VJu3siaLzXSiXo
        mAoenCOgGMIl0EzA9VtSJznUKlExhpzfDtWdW6Xbz
X-Received: by 2002:a17:907:944e:b0:9ae:4054:5d2a with SMTP id dl14-20020a170907944e00b009ae40545d2amr3934482ejc.16.1698934209631;
        Thu, 02 Nov 2023 07:10:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbGYdqxJN3m4Nv7wv0qiHgRhXyVFeWYKkE+7liknOETb85M5Alo7t0Jt9qSHRRXvfDHVOUKhcw9Y6lkbu8Tzs=
X-Received: by 2002:a17:907:944e:b0:9ae:4054:5d2a with SMTP id
 dl14-20020a170907944e00b009ae40545d2amr3934457ejc.16.1698934209253; Thu, 02
 Nov 2023 07:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231102120053.30630-1-bagasdotme@gmail.com> <20231102120053.30630-2-bagasdotme@gmail.com>
In-Reply-To: <20231102120053.30630-2-bagasdotme@gmail.com>
From:   Richard Fontana <rfontana@redhat.com>
Date:   Thu, 2 Nov 2023 10:09:57 -0400
Message-ID: <CAC1cPGyLGEwMBRGhwoGmGBeM8qTbuuUsbeZTiiMNUvk4MT75Gw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] LICENSES: Add SIL Open Font License 1.1
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@ger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Vernet <void@manifault.com>,
        Miguel Ojeda <ojeda@kernel.org>, James Seo <james@equiv.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 8:01=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com>=
 wrote:
>
> Add the license text along with appropriate tags for reference and
> tooling. The text is taken from the text as distributed in Google
> Fonts's zip files.
>
> As the license itself may or may note be compatible with GPLv2,
> let's take on the err side and require combining it with
> GPL-compatible licenses when using the license.

I don't really  understand this, though maybe it doesn't practically matter=
 -
"It's best to use it together
+  with a GPL2 compatible license using "OR", as OFL-1.1 texts processed by
+  the kernel's build system might combine it with content taken from more
+  restrictive licenses."

I didn't check if this text is just copied from that in other license files=
.

I'm not sure how this would actually come up in practice for OFL-1.1.
I assume that typically the way OFL-1.1 can cover stuff in the kernel
is through font files, and that therefore it would be unlikely for a
source file to include any code covered by OFL-1.1. Indeed, as you
say:

> +  Do NOT use this license for code, but it's acceptable for fonts (where=
 the
> +  license is specifically written for them). It's best to use it togethe=
r

Even if that did occur, the use of `OR` is only appropriate if the
stuff covered by OFL-1.1 is actually dual-licensed.

I think it should be beyond dispute that OFL-1.1 is incompatible with
the GPL (over at the Fedora project we don't even classify it as a
FOSS license), not that that is likely to matter for the kernel.

Richard

