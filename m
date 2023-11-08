Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85C97E5D0E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjKHST7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHST6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:19:58 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55DD1FFB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 10:19:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so984a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 10:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699467594; x=1700072394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPzDJOHXaMQ7hDr4fQaud0AOapaYXuR24Rsqmx39kT4=;
        b=uidFvFLQKH6OQ+EuPzqiej4boBUNsl2clO/meRsB93hUfbpqTXkLPf3FjPx3FoWbpQ
         HylpPoRgBKzhjL9TF1QKNpD3q8cYuahE/2S/7OLexwPuGuMks1mJEZlcOiAaeqfpXTKc
         JEljQO4zn3svcbWtV/y4GjmW6i7fiorUUyS4eYqVHbeGjBeCDxDquxoYIMjCxlmnp6ol
         jXMq1asrezkCwEfMIDUWRdpf3v5iiQkyHlueDWN3f65NnD84DUHi1guTYV4IhHpvOhQ2
         J9IqyBdUOZC5iZbs5MH+7UTLgGe9g0AfIiaCbUEijU+oajsCAWjuQvuso3Z4rvXaS/CZ
         4PUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699467594; x=1700072394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPzDJOHXaMQ7hDr4fQaud0AOapaYXuR24Rsqmx39kT4=;
        b=j/7EE5WV3XDx54y40P2qyzWM0KAuqqrlVY0rKUzkIQy09yPJq6QG81TbeFGrKJXgM+
         nZVHqNMMviCjhBvOwzL9kaTIujSlYz6FtfjKLXJ0tf9ok5mCwujwCTL5t5xeaOLYWenV
         UA2nGWCRQfjlnhS7Gw0e4VgyivvFm0Ty5uOfq5Wsbgjj71x7wvJIgv9pmkMhuIiM1Wx/
         1qBsnNfswqCR1IZq6TILrR6pvCyRljiWCrlw9zf41ygkHP71zrYRXWxgR3CBCsVUBYhg
         jtYWZxJlZpYPYB4Vcmh9dRbZpXkme3ztrEueSXXw0iikxpmC5CNGgvi5M5HBsC8Osj35
         1IAQ==
X-Gm-Message-State: AOJu0YyrvNx9DZvkDliZPhWwEgvQA43iT1OKSACXJIZybSldO4FtyuIm
        laL8ozApL8qs5wR7dL0BN2DTxPk7YwGHprdkf3hY/A==
X-Google-Smtp-Source: AGHT+IHSTdnHpU+tkokUoN2IxJr6aTuVShMIUkzmKD2yI2R4C/2lgCPoCvm1H+r3Y/W0c7msPJZNhRs4cza7jp5Alq8=
X-Received: by 2002:aa7:d34a:0:b0:543:fb17:1a8 with SMTP id
 m10-20020aa7d34a000000b00543fb1701a8mr11251edr.3.1699467594084; Wed, 08 Nov
 2023 10:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-30-nsaenz@amazon.com>
 <ZUvDZUbUR4s_9VNG@google.com> <c867cd1f-9060-4db9-8a00-4b513f32c2b7@amazon.com>
In-Reply-To: <c867cd1f-9060-4db9-8a00-4b513f32c2b7@amazon.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 8 Nov 2023 10:19:39 -0800
Message-ID: <CALMp9eTmAR_yMMxujiMDQ6_VpUF3ghoKAdy_SYvu-QOAThntZA@mail.gmail.com>
Subject: Re: [RFC 29/33] KVM: VMX: Save instruction length on EPT violation
To:     Alexander Graf <graf@amazon.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Nicolas Saenz Julienne <nsaenz@amazon.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, anelkz@amazon.com, dwmw@amazon.co.uk,
        jgowans@amazon.com, corbert@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 9:27=E2=80=AFAM Alexander Graf <graf@amazon.com> wro=
te:

> My point with the comment on this patch was "Don't break AMD (or ancient
> VMX without instruction length decoding [Does that exist? I know SVM has
> old CPUs that don't do it]) please".

VM-exit instruction length is not defined for all VM-exit reasons (EPT
misconfiguration is one that is notably absent), but the field has
been there since Prescott.
