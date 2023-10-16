Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEEC7CAD71
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjJPP1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjJPP1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:27:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75633FB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:27:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a3e0f8872so5998558276.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697470023; x=1698074823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7ovurzWsjAOASM7f7dWBYIXuRhsMyJ0vUleo7Ukhu8=;
        b=oY8lXNon3MNCDWtieOhkyu6SWEYrrFXRxVgEqvk47LmcQa9SUPvjdRzZ6dHI2AA6a+
         J4H+FCWi/OM+61F3vdg4JCyTIHunKmmhxxamQT1PR+xThqd9jB9r469JHkU328FWzmyl
         NRY6O6gEuAU42hK4p23/W8ywAPf24/0KmxXMl8cIXd7p2BTMLu/evCpXko6Qomtvr+te
         MSI0i+Z0XdkUp89rJYkKPn7Y3pN/i/Y9R1GZcv8YMq4bTpo8zSP6QqXlskxksgHVWj11
         YlI+LLL3XOk347NEi84P/c0u9jmZBiOaScoznKuFsYDqCJ9aftNkse8ifEr1n2upFmK4
         zr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697470023; x=1698074823;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m7ovurzWsjAOASM7f7dWBYIXuRhsMyJ0vUleo7Ukhu8=;
        b=vPwjcN6YsE5PdSCO1L0h+qWxX7GLZsie8/AjyWu1xKswDkNNAfuUwamaPe2AzCP30+
         DULnxFl5bbHT6V+4OFDCt4JCXYJR9P+tYJVPnIW0nHCeW+stCqv0G28xdWDVOVPoBgpz
         OV5ls40I6yA4h20CCfksk905F5hENtm6YpkVrXCvGQ/NFNniKV4r+1uQ8G9T0tN9ITYw
         3e+GlqNFjt3mTqOlOXMHFOvk5mXwa1lQJ+xQJ0ukqJdsVlHIvX30KpYMQigUbHxmiY0R
         gxtELH6H8asDNwQw05wvv5Y+IPIlIe+NjUgX5lTlGkQbCLt7uFbk0A+4LsCeVW4mBh/g
         DycA==
X-Gm-Message-State: AOJu0Yy9yj5e8RUSUVpv6TwY4N0kFbaG0lOPhIf0gcv01fj/CSCY6baK
        fI8VKBRJsAP0z7LTPKCLQHHgpJcaRj4=
X-Google-Smtp-Source: AGHT+IGShvzCtxVAnanpz2eSSIiN8NfxnaYM7C5IYyqrZLxjyLwGoiwRnr+SGD7F3ikxwIo3NBH/oqaqfg0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:83d0:0:b0:d9a:4421:6ec5 with SMTP id
 v16-20020a2583d0000000b00d9a44216ec5mr405858ybm.3.1697470023442; Mon, 16 Oct
 2023 08:27:03 -0700 (PDT)
Date:   Mon, 16 Oct 2023 08:27:01 -0700
In-Reply-To: <87h6mq91al.fsf@redhat.com>
Mime-Version: 1.0
References: <20231010160300.1136799-1-vkuznets@redhat.com> <20231010160300.1136799-8-vkuznets@redhat.com>
 <708a5bb2dfb0cb085bd9215c2e8e4d0b3db69665.camel@redhat.com> <87h6mq91al.fsf@redhat.com>
Message-ID: <ZS1VGvbcmH93-KyH@google.com>
Subject: Re: [PATCH RFC 07/11] KVM: x86: Make Hyper-V emulation optional
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023, Vitaly Kuznetsov wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
>=20
> > =D0=A3 =D0=B2=D1=82, 2023-10-10 =D1=83 18:02 +0200, Vitaly Kuznetsov =
=D0=BF=D0=B8=D1=88=D0=B5:
> >> Hyper-V emulation in KVM is a fairly big chunk and in some cases it ma=
y be
> >> desirable to not compile it in to reduce module sizes as well as attac=
k
> >> surface. Introduce CONFIG_KVM_HYPERV option to make it possible.
> >>=20
> >> Note, there's room for further nVMX/nSVM code optimizations when
> >> !CONFIG_KVM_HYPERV, this will be done in follow-up patches.
> >
> > Maybe CONFIG_KVM_HYPERV_GUEST_SUPPORT or CONFIG_HYPERV_ON_KVM instead?
> >
> > IMHO CONFIG_KVM_HYPERV_GUEST_SUPPORT sounds good.

Adding GUEST_SUPPORT doesn't disambiguate anything though, as there's no cl=
ear
indication of whether KVM or Hyper-V is the guest.  E.g. the umbrella kconf=
ig for
Linux-as-a-guest is CONFIG_HYPERVISOR_GUEST.

> We already have CONFIG_KVM_XEN so I decided to stay concise. I do
> understand that 'KVM-on-Hyper-V' and 'Hyper-V-on-KVM' mess which creates
> the confusion though.

Yeah, matching Xen is probably the best way to minimize confusion, e.g. the=
 kernel
has CONFIG_HYPERV and CONFIG_XEN to go with KVM's, CONFIG_KVM_HYPERV and CO=
NFIG_KVM_XEN.

> >> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> >> index ed90f148140d..a06e19a8a8f6 100644
> >> --- a/arch/x86/kvm/Kconfig
> >> +++ b/arch/x86/kvm/Kconfig
> >> @@ -129,6 +129,15 @@ config KVM_SMM
> >> =20
> >>  	  If unsure, say Y.
> >> =20
> >> +config KVM_HYPERV
> >> +	bool "Support for Microsoft Hyper-V emulation"
> >> +	depends on KVM
> >> +	default y
> >> +	help
> >> +	  Provides KVM support for emulating Microsoft Hypervisor (Hyper-V).
> >
> >
> > It feels to me that the KConfig option can have a longer description.
> >
> > What do you think about something like that:
> >
> > "Provides KVM support for emulating Microsoft Hypervisor (Hyper-V).

I don't think we should put Hyper-V in parentheses, I haven't seen any docu=
mentation
that calls it "Microsoft Hypervisor", i.e. Hyper-V is the full and proper n=
ame.

> > This makes KVM expose a set of paravirtualized interfaces,

s/makes/allows, since KVM still requires userspace to opt-in to exposing Hy=
per-V.

> > documented in the HyperV TLFS,=20

s/TLFS/spec?  Readers that aren't already familiar with Hyper-V will have n=
o idea
what TLFS is until they click the link.

> > https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/refe=
rence/tlfs,
> > which consists of a subset of paravirtualized interfaces that HyperV ex=
poses

We can trim this paragraph by stating that KVM only supports a subset of th=
e
PV interfaces straightaway.

> > to its guests.

E.g.

  Provides KVM support for for emulating Microsoft Hyper-V.  This allows KV=
M to
  expose a subset of the paravirtualized interfaces defined in Hyper-V's sp=
ec:
  https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/refere=
nce/tlfs.

> >
> > This improves performance of modern Windows guests.

Isn't Hyper-V emulation effectively mandatory these days?  IIRC, modern ver=
sions
of Windows will fail to boot if they detect a hypervisor but the core Hyper=
-V
interfaces aren't supported.
