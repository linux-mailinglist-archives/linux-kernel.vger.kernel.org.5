Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3510A7FFFC5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377332AbjK3X5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377294AbjK3X5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:57:49 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359F710E2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:57:55 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so2483a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701388673; x=1701993473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QS+i37UcwGBx82n3McWzPFFtU6IxiBbMiMBLppZu2kY=;
        b=Ic6Dz9jZfE6/ShcyS9VI6yS8/XexbAMApKWQvuPLd3vusNRU0uMwg8CmKgXLMiOgif
         Aqz5y81MVZ+xfNsgUgPneanmnzOpzc8mF3gUm5/wkeU5NKfhKmV3skBZEnrb3SHqlZRd
         bSnbyXCbfqKbk/o+6+cYrkpoZiiNMyBGmC9SoUFC9hZ0FPzI3YqCaZ0obPUaQ/BknDOa
         EbeonPvHvQBfdj8ZdnwlLRiWANO6o7a2IR5NChYC6sgK3stGe+OP/J9acbC4e+EtB0ka
         DhDScowlMZexBAirkg5dQjYkDRzyCoEMTbYRpEIn89QyCXHO0Il6T8wIJHrb+bg5ZL8g
         M7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701388673; x=1701993473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QS+i37UcwGBx82n3McWzPFFtU6IxiBbMiMBLppZu2kY=;
        b=YAgeemUI+TFnCvGRL+WXmQwr0OMoTW5jE03L2mjLgPTmaEFwIODjuSXKQX3wW+bT5K
         9ullyNn/eMORBsikSadwprxFQcr9PbbGyqLNjbngmEJg70z6cou5BZ2387EiQyhWCq0a
         0XLY1r+iwE0ANeNtI3mAzpS8vVORkpYacjhRno8+ATXv72beNCt2hnA++rVh0hb1RjN4
         JWUENy7645Qy5O3sH3D09xSZ6+9WpsUJ8Gs2Nk0pWrXXA31J5V647vUsGDceklolS4lJ
         GCCzuieK36MNqk6QkXf4SNlbpl9qoCrzKp3fDq3W0ui9rPnBzqB24bsWU9GqJ8qaul4J
         641A==
X-Gm-Message-State: AOJu0Yy2XAogA7qRv4HD5V3b7PfgSunk9TO7jQRAlsMDlfnbHQIwATRz
        JR9/UPdHpYrsrQa1De2JGsEWjGjJFGQg+rldxN3gmojrIosEmMqX6I8=
X-Google-Smtp-Source: AGHT+IFUkxAQaLbevOaGiXUhKdK7+EP/riejmQgJRc5b0rDX5HNmOqxcvx5tGuqsp6Y7XMu+Kkypu6GSGnyboSO2hfw=
X-Received: by 2002:a50:d083:0:b0:54b:67da:b2f with SMTP id
 v3-20020a50d083000000b0054b67da0b2fmr6508edd.7.1701388673458; Thu, 30 Nov
 2023 15:57:53 -0800 (PST)
MIME-Version: 1.0
References: <c858817d3e3be246a1a2278e3b42d06284e615e5.1700766316.git.maciej.szmigiero@oracle.com>
 <ZWTQuRpwPkutHY-D@google.com> <9a8e3cb95f3e1a69092746668f9643a25723c522.camel@redhat.com>
 <b3aec42f-8aa7-4589-b984-a483a80e4a42@maciej.szmigiero.name>
In-Reply-To: <b3aec42f-8aa7-4589-b984-a483a80e4a42@maciej.szmigiero.name>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 30 Nov 2023 15:57:38 -0800
Message-ID: <CALMp9eQvLpYdq=2cYyOBERBh2G+xubo6Mb0crWO=dugpie4BRg@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Allow XSAVES on CPUs where host doesn't use it
 due to an errata
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 2:00=E2=80=AFPM Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> I think that if particular guest would work on bare metal it should
> work on "-cpu host" too - no tinkering should be required for such
> basic functionality as being able to successfully finish booting.

I disagree. Let's not focus on one particular erratum. If, for
whatever reason, the host kernel is booted with "noxsaves," I don't
think KVM should allow a guest to bypass that directive.
