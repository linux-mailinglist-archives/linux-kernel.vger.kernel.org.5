Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8947DF7DC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376952AbjKBQmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKBQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:42:06 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF00118E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 09:42:02 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7d9d357faso13906457b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 09:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698943322; x=1699548122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LiJGLC2FExExiPE0J4pSxoWAHA7z3x+9vmpIcXmfSU=;
        b=JGmx0PPeto/o4g3FLUeK5rpiU7dqYj/yXbViCpXngs/OHfjs2qrslErCTBaNDfw6xQ
         TfmXow+JaXPTIaEdhkzITxe5EENJaMr82S2AF7ySkwQjlsb75Zv9SWEmXyADcP1uqaUi
         C9ddB1b9hGZDcObwtTzdRjENrDH0uPyc4/IsOHfdVuDnp01/JdXW6g+l34rF6mLI11uf
         xiFJVjpKu7t0s+1iZ+mwJIOk8J2xFOMs6UFZJUIv3qtopngDob3kwwAp0RqUD3PM0/UM
         pLT9lm2PDdub97PCPtzklmZ+3Y3juhUuqSlVMdYThi54c7dkyFUfP+cCfqyv3/VcGiaU
         ri6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698943322; x=1699548122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LiJGLC2FExExiPE0J4pSxoWAHA7z3x+9vmpIcXmfSU=;
        b=aUv2PjZ0yryrKdSrE1LcLT4u2IUw900X4KnlIFQMg15MuUpmU7wHCS4BUiGpQDJXBF
         kRQqN7gbLCiptB4JROc7VR+2+XltUUFkvu6dm97yGALtcAZY5/x/M/XoeZPgKNMbMAbS
         xxPt0Q9QYU0ucH8aytocYP7ZKLvXkRWcb2V2egPek4EnS6RKQCKLNEW3+vVUPpmhWLA+
         /rIZPHQjG42XrFUsFkInDt0urz2BtEC9bj3O02TLqTIDEBWABitDj2c/jYZIViK+2Usz
         ckTLFimyUTl9ja6Zagd7/l2h01qxPd14UWSDUbHKXoc3oC8ssEzkA6IjLJiiWmySqKYV
         oAwA==
X-Gm-Message-State: AOJu0Yy01uRQCWnWwU+1MGzoKVdB22/NaZ3Fsh3RTQmsgJW0ZGZ+FxvY
        ABEij1ouD8EnyZZ9E8Uj01Uj7HQfyGDbJkUmiR4=
X-Google-Smtp-Source: AGHT+IH2hGFHauJsq2POKqGnj+ipHZn+ZhTurRCMsTVtyyfPU2uYxtaxX3N6+D/iM3MgDMMzISXxHppYOFR/cDr2GSA=
X-Received: by 2002:a05:690c:f10:b0:5a7:c777:2be1 with SMTP id
 dc16-20020a05690c0f1000b005a7c7772be1mr318014ywb.11.1698943321842; Thu, 02
 Nov 2023 09:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231102120053.30630-1-bagasdotme@gmail.com>
In-Reply-To: <20231102120053.30630-1-bagasdotme@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 2 Nov 2023 17:41:50 +0100
Message-ID: <CANiq72==HJp6umRwKgRU2U3FNTjkNaeaEizLZkH5TPrnSZYbjg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] Documentation: Web fonts for kernel documentation
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
        Carlos Bilbao <carlos.bilbao@amd.com>
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

On Thu, Nov 2, 2023 at 1:01=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com>=
 wrote:
>
> For the font choices, we settle down on IBM Plex Sans (sans-serif), IBM
> Plex Mono (monospace), and Newsreader (serif). All these fonts are
> licensed under OFL 1.1 and can be distributed alongside the kernel docs.
> We have also considered to use S=C3=B6hne [1] instead, but because it is =
paid
> font, it is concluded that such font is non-free [2] (and by
> implication, distributions must patch the kernel to not use it).

If we are going to do something like this, then it could be nice to
consider the ones that `rustdoc` picked, i.e. Fira Sans for headers,
Source Serif 4 for text and Source Code Pro for code.

Cheers,
Miguel
