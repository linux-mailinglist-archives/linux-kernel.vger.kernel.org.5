Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E8A807BA2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjLFWpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjLFWpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:45:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36160D5B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 14:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701902718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZn1S9TK1RDCj7RxM/b8SSbDoPqt7weXZUABUV6sUMI=;
        b=WFld93N9K5z6wyBcqpg0qJN0WX7tCbgmv95pPON2ocdUeZCmLKIyic3EzoJ/koU9WBiP5O
        /fmadk46Xur/UbmfPq7m/FgTxG7vIr8An4ZM5TwZ+cVMJvoAjGw7o4ncczPY3q0T+plgcp
        NmN4/X68mYarkjpOR3zp4Jr8LGPmSl4=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-Vbb0H26-PBOvPvM1mqKO5Q-1; Wed, 06 Dec 2023 17:45:16 -0500
X-MC-Unique: Vbb0H26-PBOvPvM1mqKO5Q-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-7c5f24e2b06so17744241.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 14:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701902716; x=1702507516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZn1S9TK1RDCj7RxM/b8SSbDoPqt7weXZUABUV6sUMI=;
        b=oOFb706k4r1xcagnV7D7W/FnJMcJ91Aq4tj+SHlXUThQHCdhwoIdghHzWO/WzH5rsy
         Ajycp1OZSLTtAkf5h2WGGplY+Th0MPY5VFIjTEx6Brh/uA3LmmcXYyd3tKbZqBPxZy+7
         siKhAHJ5ZjSM86j8yZw78RXBZ+wkErfUmnewzXSNqT6NCZ0T39ZLBpvdN0SESVT8VGSm
         5Ka8dTPSGPe63GePHIgXgRof1hCK9+WaNBQXJprxyat637v5jmS/V88C3dQkju6gl6zw
         Hd1BolcA5N63Y7OE2LGUJPndyTQF25hjKfRobwwU66cE5JP2ei9Pl/xxU5ai7FnoxzqP
         b51A==
X-Gm-Message-State: AOJu0YwV7tjtVSkwEmEv3iY297QXcoj0Ji9PYqQIEE7ppjkegr/6KL7o
        GeUcdXLt5oIimBTaQYqQxeQgdFYdrHMFYnCqiXUvXRXVeXjDoJ2uyRnaRwmV7IfrwR1/IyittAl
        +d93FkVfQRV29uy3GYeBopeLbn2Oz+dTeCwJsAzlF
X-Received: by 2002:a05:6102:6d1:b0:464:cac8:a03e with SMTP id m17-20020a05610206d100b00464cac8a03emr1957067vsg.1.1701902716171;
        Wed, 06 Dec 2023 14:45:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyLxIvkPiRa2M7n8tSqh+BF6QFOiI3tq/gZRUueOYOXw7oyWK3kLWbW/nDqJ4G5XcLMXhDdWeJGlMU3YLuzyc=
X-Received: by 2002:a05:6102:6d1:b0:464:cac8:a03e with SMTP id
 m17-20020a05610206d100b00464cac8a03emr1957051vsg.1.1701902715890; Wed, 06 Dec
 2023 14:45:15 -0800 (PST)
MIME-Version: 1.0
References: <c858817d3e3be246a1a2278e3b42d06284e615e5.1700766316.git.maciej.szmigiero@oracle.com>
 <ZWTQuRpwPkutHY-D@google.com> <9a8e3cb95f3e1a69092746668f9643a25723c522.camel@redhat.com>
 <b3aec42f-8aa7-4589-b984-a483a80e4a42@maciej.szmigiero.name>
 <CALMp9eQvLpYdq=2cYyOBERBh2G+xubo6Mb0crWO=dugpie4BRg@mail.gmail.com> <00fa768e-eceb-48c3-ae23-1966f110ec49@maciej.szmigiero.name>
In-Reply-To: <00fa768e-eceb-48c3-ae23-1966f110ec49@maciej.szmigiero.name>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed, 6 Dec 2023 23:45:02 +0100
Message-ID: <CABgObfb_hv=_ksOrDLRSKjFpkQtjWh4oYHxzvK6oH=_YLgTn0A@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Allow XSAVES on CPUs where host doesn't use it
 due to an errata
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 5:05=E2=80=AFPM Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> On 1.12.2023 00:57, Jim Mattson wrote:
> > On Thu, Nov 30, 2023 at 2:00=E2=80=AFPM Maciej S. Szmigiero
> > <mail@maciej.szmigiero.name> wrote:
> >> I think that if particular guest would work on bare metal it should
> >> work on "-cpu host" too - no tinkering should be required for such
> >> basic functionality as being able to successfully finish booting.
> >
> > I disagree. Let's not focus on one particular erratum. If, for
> > whatever reason, the host kernel is booted with "noxsaves," I don't
> > think KVM should allow a guest to bypass that directive.
>
> This could be achieved by either adding special "noxsaves" flag
> or by setting X86_BUG_XSAVES_AVOID instead of clearing
> X86_FEATURE_XSAVES on these CPUs.
>
> Then the core kernel XSAVES code would check for lack of
> X86_BUG_XSAVES_AVOID (in addition to checking for
> presence of X86_FEATURE_XSAVES) while KVM would keep using
> only X86_FEATURE_XSAVES.

This is feasible, on the other hand the erratum is pretty bad. Since
the workaround is easy (just disable XSAVEC; and maybe XGETBV1 as
well?), you could just do a printk_ratelimited() on the write to
HV_X64_MSR_GUEST_OS_ID, in particular if:

1) guest CPUID has XSAVEC and SVM

2) host CPUID does not have XSAVES

3) guest OS id indicates Windows Server 10.x (which is 2016 to 2022),
which should be 0x0001040A00??????.

Paolo

