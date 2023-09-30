Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9497B431F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 20:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjI3StO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 14:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjI3StN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 14:49:13 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7853CD3;
        Sat, 30 Sep 2023 11:49:11 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7740aa4b545so1019294685a.3;
        Sat, 30 Sep 2023 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696099750; x=1696704550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieQO9sxh6KCnuOiZjBddD3RDHajg+Mr+k5MS8yorB18=;
        b=HyRjyADivtqdDV0lBqprqNX9evdD3TGSCN/gklL/H0YfLn3x9zAWnh+T+K9C6dwxFn
         DnyXdvUlQvi1UmEes/+7ERvk/5rNd9R8260pv8g/ocYZ7IeuR278enOugy1ByFD29Axu
         7Wj+Co5l9LHry5qM8f6nVaqR7fc2hseJCiiavi3bYOqdN3nBPIW5pTe4fW3811mv20k2
         DUvN/RfhaT0ot5wZddJN46orkhox5fmH6XcrQn0619hR32jbJVAWF7XLviRhUm0HM19u
         0l5TTxGVJkGqA3iNwSKq6X2cQzgrP0yQGJvvO9VJCG4fDu8AQl0RpM/4HoGr20Ow2PmL
         R0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696099750; x=1696704550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieQO9sxh6KCnuOiZjBddD3RDHajg+Mr+k5MS8yorB18=;
        b=ZVoRH2iQWO8KQFu7861sPq3kwOup2ug/eNxqEYAixZwoxccBTL15fk2303bO9kk+c9
         or7ViEzsyMZAozy18TQq9EQljxANpC4ZF40JJ7tnBMkQ1w2jfBlmfQYevPCXx1loux/w
         zUsCkFCQ0aABmjkIclSxjdb1gUsqv1TPSXzO6dBYgynyyj6GWCwzDbsFRrsWpagZcLwJ
         8AJgHV5Xe5LLB2x76zJW1TLgaztIRzi6VqUjD3ZJ3aKDS1BF43rwCHsPQKSFq6Xkmu/9
         M4ua+gM8//K32K8C65qLHtYB6Ef9xhJjgpAiCsgJ+yzOouWKY6kZ7PNepgYT+WpOLqdT
         ogVw==
X-Gm-Message-State: AOJu0YzW+K/rAGo48HRpphdy9klnxRBFY3YATSYEDhn5yiV0QZuhBnc0
        lgPDC7KN9eZ7yCeqnNTaQKLxPR5qgr66XUFFmAmdYgFzENHfoDxd
X-Google-Smtp-Source: AGHT+IGAs5IUo3HjONoakmz3HhBHE4LyPQIyeV6Zjld+8Pcc19WNiV+RgIdnJANX3yZwUsGSOqRMb79WYySzjhBpUvw=
X-Received: by 2002:a05:620a:d85:b0:774:179d:6576 with SMTP id
 q5-20020a05620a0d8500b00774179d6576mr8245459qkl.50.1696099750524; Sat, 30 Sep
 2023 11:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230930161443.58812-1-xubo3006@163.com>
In-Reply-To: <20230930161443.58812-1-xubo3006@163.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 30 Sep 2023 20:48:59 +0200
Message-ID: <CANiq72n+xr+3TqQMaoP3xOzM2ZqUyzKvGm2wDMd8SbsqBK7nvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: add Soft-RoCE driver basic structure
To:     AllenX <xubo3006@163.com>
Cc:     rust-for-linux@vger.kernel.org, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
        gary@garyguo.net, bjorn3_gh@protonmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

A quick few notes I noticed that you will probably want to address
before sending this to the Infiniband/rdma maintainers. Please note
that some of these apply in more than one instance, and that these are
just surface-level -- I have not actually looked at what the code is
doing or whether it is sound.

On Sat, Sep 30, 2023 at 6:16=E2=80=AFPM AllenX <xubo3006@163.com> wrote:
>
> +//! Infiniband soft-Roce devices.

Please follow the formatting/coding style of the rest of the code
already upstream. For instance, a newline should be placed here.

> +/// Soft-Roce transport registration.
> +///

Docs should not end in an empty line.

> +impl<T: RxeOperation> Registration<T> {
> +    /// Creates a new [`Registration`] but does not register it yet.
> +    ///
> +    /// It is allowed to move.
> +    pub fn new(name: &'static CStr) -> Self {
> +        // INVARIANT: `registered` is `false`

There is no `# Invariants` section in the type. Please check other
types we have to see how it is usually done.

> +    /// Registers a infiniband soft-Roce device

Docs should only have a single first line/sentence and end in a period.

> +        // SAFETY: The adapter is compatible with the rdma_link_register

Please use Markdown in code comments, just like in the documentation,
and end sentences and comments in a period for consistency with the
rest of the code; e.g.

    with the `rdma_link_register`.

> +        pr_info!("loaded");

Debugging code?

> +/// soft-Roce register net sockets

Please be consistent in the documentation, e.g. you used "Soft-Roce" above.

> +    /// Init ipv4 socket
> +    fn ipv4_init(&mut self) -> Result<()> {
> +        let mut udp_cfg =3D bindings::udp_port_cfg::default();
> +        let mut tnl_cfg =3D bindings::udp_tunnel_sock_cfg::default();
> +        let mut sock: *mut bindings::socket =3D ptr::null_mut();
> +
> +        udp_cfg.family =3D bindings::AF_INET as u8;
> +        udp_cfg.local_udp_port =3D 46866;
> +        // SAFETY: [`bindings::init_net`] and [`udp_cfg`] can be safely =
passed to [`bindings::udp_sock_create4`]
> +        // [`sock`] will be pass to [`self.sk4`] later, it will live at =
least as long as the module, which is an implicit requirement
> +        let err =3D
> +            unsafe { bindings::udp_sock_create4(&mut bindings::init_net,=
 &mut udp_cfg, &mut sock) };
> +
> +        if err < 0 {
> +            pr_err!("Failed to create IPv4 UDP tunnel\n");
> +            return Err(Error::from_kernel_errno(err));
> +        }
> +
> +        tnl_cfg.encap_type =3D 1;
> +        tnl_cfg.encap_rcv =3D RxeUdpEncapRecvFuncTable::<T>::build_func(=
);
> +
> +        // SAFETY: [`bindings::init_net`] and [`tnl_cfg`] can be safely =
passed to [`bindings::setup_udp_tunnel_sock`]
> +        // [`sock`] will be pass to [`self.sk4`] later, it will live at =
least as long as the module, which is an implicit requirement
> +        unsafe { bindings::setup_udp_tunnel_sock(&mut bindings::init_net=
, sock, &mut tnl_cfg) }
> +        self.sk4 =3D Some(sock);
> +        Ok(())
> +    }

Some networking abstractions will be needed here, instead of calling
the C APIs directly. There are some networking discussions going on in
the list and in our Zulip -- please take a look!

> +            if err < 0 {
> +                // EAFNOSUPPORT
> +                if err =3D=3D -97 {

The error code should be added to the list that we import from the C
headers, instead of hardcoding the value.

> +                    pr_err!("IPv6 is not supported, can not create a UDP=
v6 socket\n");
> +                    return Ok(());

Should this really return `Ok`?

Does the C side print errors too?

> +            if self.rxe_net_notifier.is_some() {
> +                // SAFETY: [`self.rxe_net_notifier`] is Some, it was pre=
viously created by
> +                // RxeNotifyFuncTable::<T>::build().
> +                unsafe {
> +                    bindings::unregister_netdevice_notifier(
> +                        &mut self.rxe_net_notifier.take().unwrap(),
> +                    )
> +                };
> +            }
> +            return Err(Error::from_kernel_errno(err));

This looks like it is undoing an operation before returning in an
error path -- there are usually better patterns for this, like RAII or
the `ScopeGuard` type (already in-tree).

> +config SAMPLE_RUST_RXE
> +       tristate "Soft-Roce"
> +       help
> +         This option builds the self test cases for Rust.

Nowadays we have KUnit support for running Rust code documentation
tests -- you may be interested in those.

Also, more documentation, including `# Examples` sections in the
abstractions would be very helpful, I would imagine.

Cheers,
Miguel
