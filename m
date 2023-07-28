Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD16766B54
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbjG1LEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbjG1LDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ACD2703
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690542191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YRDAIP7TWOWzkcjHET3GgHuSuYBQhkcL+zbEgtv9LlA=;
        b=QKRPLJ4sFeEu+QaHdyAbV0Fw/hpI+vQBNyogVttq4PXc+TCe0ZEEKFRDlwOPJWubs0ZUDC
        wzteGfaQT09cgP+nij66rPPWito0w3PagLIRoVZtjTIx4HTSGlijnNAKEnRTDsltF2KlJ0
        3a07HrBtH0zLzXMJKjDg6uHK3ck0JWE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-RlY-Kqj4MNSwZ3QrLZsw3A-1; Fri, 28 Jul 2023 07:03:10 -0400
X-MC-Unique: RlY-Kqj4MNSwZ3QrLZsw3A-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-56385c43eaeso1219198a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690542189; x=1691146989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRDAIP7TWOWzkcjHET3GgHuSuYBQhkcL+zbEgtv9LlA=;
        b=azJGUbGUvQx9EDiIlGBfuK7qpCa25015Xk3wjbuv5dnABObeIM3Ac1bINADEtUfpLh
         qIRv0cYzJR6bfkHwZpUCf/+CLLiPI1/9PHSCbRolTXV7IwzwqOY4Dm+LvVCtlrEgRRx/
         aq9/H5MqKCcT0DX4qfWUyFc+n1nMZ5nK+P15YVpLmH8jLpMKH0+vZfKS+Hsh4iEK6JXQ
         6p1FjKubaCQy+NjROUdqD63Rv++oct/58T1k9yAg5JxzxG2uXNJex8lHEv22FyqTpSj1
         dBUR3CfM505YN5YlmBCacgIwzBZZeyA+J9FFNvuhNfxpqzV3mK/SuIN25NbuoN3JrkLr
         gJzQ==
X-Gm-Message-State: ABy/qLYdO6A+3avuRwCm1sbdUrDiuWpGVDWRl4gUx6ddocWFUbVN3Thd
        cxQc+6t7bymSvz4uEzDnfN37rS2MJWxH4io0+vTeoeyenG8D81+Da7/OWp4iY1LK1mQaYEyH1dh
        0kMHmoL9xsnMUQvPBpxYivLbFNxKJu0SYgwOMYnlr
X-Received: by 2002:a17:90a:c210:b0:267:f8f4:73ab with SMTP id e16-20020a17090ac21000b00267f8f473abmr1972293pjt.16.1690542189379;
        Fri, 28 Jul 2023 04:03:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFpM31f8xiI5XV4XQ4pPKorUiehU8YoIyXepdh/t5x0b+PJODmj9I2IfnV6k11CAK+Fxd67QVKBY4VbC4WYnMo=
X-Received: by 2002:a17:90a:c210:b0:267:f8f4:73ab with SMTP id
 e16-20020a17090ac21000b00267f8f473abmr1972270pjt.16.1690542189073; Fri, 28
 Jul 2023 04:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230620131223.431281-1-omosnace@redhat.com> <87edkseqf8.fsf@mail.lhotse>
In-Reply-To: <87edkseqf8.fsf@mail.lhotse>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 28 Jul 2023 13:02:58 +0200
Message-ID: <CAFqZXNtsCKsr0YHPCSJJQ5An=RoMhf0dufgr7P_SnAAv7CrLjw@mail.gmail.com>
Subject: Re: Login broken with old userspace (was Re: [PATCH v2] selinux:
 introduce an initial SID for early boot processes)
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 4:12=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> Ondrej Mosnacek <omosnace@redhat.com> writes:
> > Currently, SELinux doesn't allow distinguishing between kernel threads
> > and userspace processes that are started before the policy is first
> > loaded - both get the label corresponding to the kernel SID. The only
> > way a process that persists from early boot can get a meaningful label
> > is by doing a voluntary dyntransition or re-executing itself.
>
> Hi,
>
> This commit breaks login for me when booting linux-next kernels with old
> userspace, specifically Ubuntu 16.04 on ppc64le. 18.04 is OK.
>
> The symptom is that login never accepts the root password, it just
> always says "Login incorrect".
>
> Bisect points to this commit.
>
> Reverting this commit on top of next-20230726, fixes the problem
> (ie. login works again).
>
> Booting with selinux=3D0 also fixes the problem.
>
> Is this expected? The change log below suggests backward compatibility
> was considered, is 16.04 just too old?

Hi Michael,

I can reproduce it on Fedora 38 when I boot with SELINUX=3Ddisabled in
/etc/selinux/config (+ a kernel including that commit), so it likely
isn't caused by the userspace being old. Can you check what you have
in /etc/selinux/config (or if it exists at all)?

We have deprecated and removed the "runtime disable" functionality in
SELinux recently [1], which was used to implement "disabling" SELinux
via the /etc/selinux/config file, so now the situation (selinux=3D0 +
SELINUX=3Ddisabled in /etc/selinux/config) leads to a state where
SELinux is enabled, but no policy is loaded (and no enforcement is
done). Such a state mostly behaves as if SElinux was truly disabled
(via kernel command line), but there are some subtle differences and I
believe we don't officially support it (Paul might clarify). With
latest kernels it is recommended to either disable SELinux via the
kernel command line (or Kconfig[2]) or to boot it in Enforcing or
Permissive mode with a valid/usable policy installed.

So I wonder if Ubuntu ships by default with the bad configuration or
if it's just a result of using the custom-built linux-next kernel (or
some changes on your part). If Ubuntu's stock kernel is configured to
boot with SELinux enabled by default, they should also by default ship
a usable policy and SELINUX=3Dpermissive/enforcing in
/etc/selinux/config (or configure the kernel[2] or bootloader to boot
with SELinux disabled by default). (Although if they ship a pre-[1]
kernel, they may continue to rely on the runtime disable
functionality, but it means people will have to be careful when
booting newer or custom kernels.)

That said, I'd like to get to the bottom of why the commit causes the
login to fail and fix it somehow. I presume something in PAM chokes on
the fact that userspace tasks now have "init" instead of "kernel" as
the pre-policy-load security context, but so far I haven't been able
to pinpoint the problem. I'll keep digging...

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Df22f9aaf6c3d92ebd5ad9e67acc03afebaaeb289
[2] via CONFIG_LSM (or CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE on older ker=
nels)

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

