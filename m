Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6427BAFB1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjJFAuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjJFAuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:50:08 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47925D6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:50:07 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-27731a5b94dso1227091a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 17:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696553407; x=1697158207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUKYaImsjspTkj35EmmP6AWb1lj7L35RrtfieUZ1qUI=;
        b=0U+qyVpdmdWTJEtIcRwJQD59/oeZeLdW3Y+arhBAE8m4UXylbOXrYL7BulZGYuKwkd
         iWM3AXzm3XXY5b7weIhiMOOsjXdOZb1LDGxj1vgudU48UE7JwrWq0SZcunVd7O1IwKOi
         2ssk/xo9wMmZwZO2WGfemRoWNCBmdbGFMa/oMKl0dvF2wj5GsLNZXLyhE4+MRG7bbhd9
         BGrm6q/6P7cb8fK4+K75fQWphGgmviHItd94LO4jDFBqCmYBm6tohkupSQZyfukBbruu
         vEpTcNbs5b4Ud0ajtjGyPB7P0l5SJI2pduVms15Lh0SomSTTb5M4VCQ/3tzk1taDyrqe
         d9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696553407; x=1697158207;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wUKYaImsjspTkj35EmmP6AWb1lj7L35RrtfieUZ1qUI=;
        b=OIMasOdDmtYpKUxkMnkA11ntuuj7OQNTTMLN7FARzY3ZloczBSpybnsXpHs/7ilYoA
         1hgHg/tL8eIj/Q/B7wWXLvqz/yD2NsFRzdURTo6njAxwj041YUtpvdQbHyuWXwx4DRhf
         bRNWy6e2GDnr5SwQPN2jN8J0KdJ4xd0BULRjWw55CxX2d3HegQf33fCxILGAoye+mZ8Y
         o2knDLJBVJw4Yn/QkDmyYOSdU9CWTLe12pCsoCXLVLCCR0spJTARx/dGbQZBTOIW1m14
         JEooQeNIRHpyk/+XxXpdgsbWvvaFsohYuJ7AWLDiEZ1jDvFPztGMiHpePtFj2dtbT6s0
         tDhQ==
X-Gm-Message-State: AOJu0YwziMEm+PORVF10m6ePLn1Iqz0oIcV5c3ETxGqHjU320MCwL00B
        NFvm4qS5ZUh47lwOmSguDuIQ0SAQOi8=
X-Google-Smtp-Source: AGHT+IHB5RmrKOskOylaYL6DvQ4b1ZS9uRLE4Iik3gpdpLjnMO7aKe5cKex0AzR/xQh5n/r9N7Cw6pHUjgY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:f68d:b0:268:2de3:e6b2 with SMTP id
 cl13-20020a17090af68d00b002682de3e6b2mr110146pjb.5.1696553406559; Thu, 05 Oct
 2023 17:50:06 -0700 (PDT)
Date:   Thu, 5 Oct 2023 17:50:05 -0700
In-Reply-To: <ZR4fR7H_do2Obzoi@google.com>
Mime-Version: 1.0
References: <20230714064656.20147-1-yan.y.zhao@intel.com> <169644820856.2740703.143177409737251106.b4-ty@google.com>
 <f29d86b433c4cbcbae89e57ac7870067357f1973.camel@intel.com> <ZR4fR7H_do2Obzoi@google.com>
Message-ID: <ZR9ZvegWmuR4PBIv@google.com>
Subject: Re: [PATCH v4 00/12] KVM: x86/mmu: refine memtype related mmu zap
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yan Y Zhao <yan.y.zhao@intel.com>,
        "robert.hoo.linux@gmail.com" <robert.hoo.linux@gmail.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        Chao Gao <chao.gao@intel.com>,
        "yuan.yao@linux.intel.com" <yuan.yao@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023, Sean Christopherson wrote:
> On Thu, Oct 05, 2023, Kai Huang wrote:
> > On Wed, 2023-10-04 at 18:29 -0700, Sean Christopherson wrote:
> > > [4/5] KVM: x86/mmu: Xap KVM TDP when noncoherent DMA assignment start=
s/stops
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/kvm-x86/linux/commi=
t/3c4955c04b95
> >=20
> > Xap -> Zap? :-)
>=20
> Dagnabbit, I tried to capitalize z =3D> Z and hit the wrong key.  I'll fi=
xup.

LOL, the real irony is that this particular patch also has this in the chan=
gelog:

  [sean: fix misspelled words in comment and changelog]

Anyways, fixed.  New hashes are:

[4/5] KVM: x86/mmu: Zap KVM TDP when noncoherent DMA assignment starts/stop=
s
      https://github.com/kvm-x86/linux/commit/539c103e2a13
[5/5] KVM: VMX: drop IPAT in memtype when CD=3D1 for KVM_X86_QUIRK_CD_NW_CL=
EARED
      https://github.com/kvm-x86/linux/commit/10ed442fefdd
