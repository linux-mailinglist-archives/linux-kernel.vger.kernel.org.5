Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4848780D0F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377434AbjHRNx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377440AbjHRNx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:53:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5314207
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:53:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58419550c3aso12056997b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692366789; x=1692971589;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcmJQTd7UNP5XiYb1sBnqy4rqkmZTlMQd83qoh50z00=;
        b=4CSZ0rvc4chRG6lB7b6lAhrvUkL78kkZlDm/UZotJZtuvX59E6nIlRjAtlurQNMSBu
         HO8hs3mOrtFx/z24wom2aig2viGmo+G8QB+lnbq4r/dkuTQTQ4baosOylwI8wdjadyPM
         5KN73mN7RSJHYvk5IpvV0EMENc2ARGvbIK/rysi+Nk3A/Np+BasI38m4DRrjmFXWBf4b
         cqrm6OvhidEkd9qDGobcKGXV+xPCglTrd73+16bTFRWwMPARpEO7dzD3ZdFaUvmhRQPk
         vhqqbVWnaDsoHHbxenzG9YzJLsVIh66tyxxvjPUGNre0bV42fBdFfh40F2+N4sxUwZf1
         o/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692366789; x=1692971589;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hcmJQTd7UNP5XiYb1sBnqy4rqkmZTlMQd83qoh50z00=;
        b=E14Dw+VGinvkdZHyrp2fI96lN0EVafqvFlTOJqaSABhwiGcvQo6jBMMyY17merz+mk
         G8vAv/ig+0xI+xI2L7xdvKBXZ2X0kFjmYMo835GWSS1sXKqVP32pDBXa9xO8ZHsqrrrP
         EZMAKWeROtXcucSm6IO6zEBFDRYpirlV/JwdO0E7PIURFTioI9zCs8OsRjgY4+7oIhbX
         QfBamHtkPEhaIji3yCKCwkwhOk7aS1BEpPk3Kx0Zv7xZWZzkjAUUQt+MzldrwFq4wrWP
         QozDJPVLO5jhOUGD4G+hqbIFjmbgSqE1on87h93yt6A1C5725OTmFPYN7C4BmC9UrLNk
         6u3g==
X-Gm-Message-State: AOJu0YxwknAxzyOVRI7N/8vi8p3Iywb+UD21cv9Rc4mHNmGqO8mVQxO4
        XA05rKcAB6xO/NP41tERvbt6tcS9uu8=
X-Google-Smtp-Source: AGHT+IF6I79/vPORNFMW6F+ZxKSAuKsoetE7Y6ZYqr6kfgMkwTJWo8DLPimGms97rTsh2mrL8K02HNIK8Fw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:181d:b0:d74:58a4:8ba0 with SMTP id
 cf29-20020a056902181d00b00d7458a48ba0mr11454ybb.7.1692366788875; Fri, 18 Aug
 2023 06:53:08 -0700 (PDT)
Date:   Fri, 18 Aug 2023 06:53:06 -0700
In-Reply-To: <e4aa03cb-0f80-bd5f-f69e-39b636476f00@linux.intel.com>
Mime-Version: 1.0
References: <20230719144131.29052-1-binbin.wu@linux.intel.com>
 <ZN1M5RvuARP1YMfp@google.com> <6e990b88-1e28-9563-2c2f-0d5d52f9c7ca@linux.intel.com>
 <e4aa03cb-0f80-bd5f-f69e-39b636476f00@linux.intel.com>
Message-ID: <ZN93wp9lgmuJqYIA@google.com>
Subject: Re: [PATCH v10 0/9] Linear Address Masking (LAM) KVM Enabling
From:   Sean Christopherson <seanjc@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, chao.gao@intel.com, kai.huang@intel.com,
        David.Laight@aculab.com, robert.hu@linux.intel.com,
        guang.zeng@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023, Binbin Wu wrote:
>=20
> On 8/17/2023 5:17 PM, Binbin Wu wrote:
> >=20
> > On 8/17/2023 6:25 AM, Sean Christopherson wrote:
> > > On Wed, Jul 19, 2023, Binbin Wu wrote:
> > > > Binbin Wu (7):
> > > > =C2=A0=C2=A0 KVM: x86/mmu: Use GENMASK_ULL() to define __PT_BASE_AD=
DR_MASK
> > > > =C2=A0=C2=A0 KVM: x86: Add & use kvm_vcpu_is_legal_cr3() to check C=
R3's legality
> > > > =C2=A0=C2=A0 KVM: x86: Use KVM-governed feature framework to track =
"LAM enabled"
> > > > =C2=A0=C2=A0 KVM: x86: Virtualize CR3.LAM_{U48,U57}
> > > > =C2=A0=C2=A0 KVM: x86: Introduce get_untagged_addr() in kvm_x86_ops=
 and
> > > > call it in
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 emulator
> > > > =C2=A0=C2=A0 KVM: VMX: Implement and wire get_untagged_addr() for L=
AM
> > > > =C2=A0=C2=A0 KVM: x86: Untag address for vmexit handlers when LAM a=
pplicable
> > > >=20
> > > > Robert Hoo (2):
> > > > =C2=A0=C2=A0 KVM: x86: Virtualize CR4.LAM_SUP
> > > > =C2=A0=C2=A0 KVM: x86: Expose LAM feature to userspace VMM
> > > Looks good, just needs a bit of re-organination.=C2=A0 Same goes for =
the
> > > LASS series.
> > >=20
> > > For the next version, can you (or Zeng) send a single series for LAM
> > > and LASS?
> > > They're both pretty much ready to go, i.e. I don't expect one to
> > > hold up the other
> > > at this point, and posting a single series will reduce the
> > > probability of me
> > > screwing up a conflict resolution or missing a dependency when applyi=
ng.
> > >=20
> Hi Sean,
> Do you still prefer a single series for LAM and LASS=C2=A0 for the next v=
ersion
> when we don't need to rush for v6.6?

Yes, if it's not too much trouble on your end.  Since the two have overlapp=
ing
prep work and concepts, and both series are in good shape, my strong prefer=
ence
is to grab them at the same time.  I would much rather apply what you've te=
sted
and reduce the probability of messing up any conflicts.
