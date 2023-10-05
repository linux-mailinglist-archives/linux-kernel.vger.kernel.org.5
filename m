Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569267B99F0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 04:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjJEC2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 22:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjJEC23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 22:28:29 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56359CE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 19:28:25 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-27731a63481so410994a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 19:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696472904; x=1697077704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EG0WvU14z5YfOYafQHRXFgYfVojqPWSPhH10Jz++Ogk=;
        b=OgsN0YxzOTffl9jNr31rlZO34VTAhg+JApbBk0rsZF3a9Y4KqJDiZ3KJx1ld3a1Hn5
         97TLVQlakUz0Qs10GvHexm5BGwAoMTxCsATRHjCHVY7OJr033i4QhY8Ky1HVDV0WfuNh
         L8n4V8DlDionXLvCMonhgdu5smqZV7h0hlcedGDG9HL76Nl8SvA/H/oIP+iQpEf1LY+F
         V8wfwbAbTWawxnxLxDwFZz6cNYdz1U+Epnn3uA3cbuLcMzqpMNoW4jRbOBqrx9lG4tF1
         fmnqcKRZGqIeqJVHUtnqU8lrEVaHyE58G2AT1epp6/KwaU4m4p1tWgt7YOe2TLzoseSQ
         wXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696472904; x=1697077704;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EG0WvU14z5YfOYafQHRXFgYfVojqPWSPhH10Jz++Ogk=;
        b=CGqn9Fhrnpwc9SHMXw3Lmai/cmdyU5l+DvKeMdrEA94AKtTvCCo0UOcy1HgW/TfGcp
         gbKs9ZTkNqdOu0nzoLFC94vFT++pSEtOizUrIFMeXv1pso+sg0giSCHXYaABSOFbHNqV
         /RRyaKzXwKoE0QCXMrqZ6WU9tb1F9Ktuw9D22v0n/A6JLEt6/dLIfSxKDOlTc9SHK7l+
         HM9LCEikXt8UA/WGZVGGCMxxcPdRddwcVPVlqiyd2TGnhFSyRxuxGboi9/uZpAQEp0od
         WN3FRdlrQDZTwZy0jVMTmHdbVVWPsZ7YiDehX6RiNDZ+0knHPGhjHmbfz9RlX2cAvehm
         a+uQ==
X-Gm-Message-State: AOJu0YwAeVNcl+LOQfi9DePNpwzM8ThaoZb7BeDN8UkE9Tz/jGEIpj7N
        GTbH5jKQ5/ACgCEej/qCLcasvS8E8Iw=
X-Google-Smtp-Source: AGHT+IH/I3A8Y47Ln57a0JGbKLXvQd00askybajzdxc41tTI7yQGhR8p5gjM4/x6YVEG3hJREP9fmWuW5zo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:d396:b0:273:dfcd:bdbf with SMTP id
 q22-20020a17090ad39600b00273dfcdbdbfmr64288pju.8.1696472904569; Wed, 04 Oct
 2023 19:28:24 -0700 (PDT)
Date:   Wed, 4 Oct 2023 19:28:23 -0700
In-Reply-To: <f29d86b433c4cbcbae89e57ac7870067357f1973.camel@intel.com>
Mime-Version: 1.0
References: <20230714064656.20147-1-yan.y.zhao@intel.com> <169644820856.2740703.143177409737251106.b4-ty@google.com>
 <f29d86b433c4cbcbae89e57ac7870067357f1973.camel@intel.com>
Message-ID: <ZR4fR7H_do2Obzoi@google.com>
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

On Thu, Oct 05, 2023, Kai Huang wrote:
> On Wed, 2023-10-04 at 18:29 -0700, Sean Christopherson wrote:
> > [4/5] KVM: x86/mmu: Xap KVM TDP when noncoherent DMA assignment starts/=
stops
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/kvm-x86/linux/commit/=
3c4955c04b95
>=20
> Xap -> Zap? :-)

Dagnabbit, I tried to capitalize z =3D> Z and hit the wrong key.  I'll fixu=
p.

Thanks Kai!
