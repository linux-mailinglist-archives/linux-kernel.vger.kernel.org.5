Return-Path: <linux-kernel+bounces-163198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B132A8B6715
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E001F2249E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B4F1FA4;
	Tue, 30 Apr 2024 00:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIAGANNa"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524DA10E4;
	Tue, 30 Apr 2024 00:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714438704; cv=none; b=vE8Jhda7hHIul1CVtlsDxgyly/NdmUV0gNfYfbRv5TVC4sUiC06PMecfUWM2Gf7tVs9fvXoPKvBXmG69tClbW8+6D/HTe7oX7MiK9KOurDAY8vdnGU3kGvzfugEZ5BtZMnlJB8/KZBWY0hJHouA+8ZokZFCesb4TPHe7OJppt4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714438704; c=relaxed/simple;
	bh=i47KtvxJFjDe4TzW1eCvlwmDjtNPR2v4Ibdk+Llcacg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hh5PQtaLay3P2dItS41BsYc7Kut6R7GrJsA6OhzW7nnPmkhLzuR35eXyHakMkjE3s9/JZkKRhmrdtPHPZQI7ibvUDr+hWvx0XWaQXGHJH1GA0baWMGl+u0t+smnLYnVApMa9iv6xL+bpRQlcms5HC+WlWVMH+dulLd6Bm7gOCWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIAGANNa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f4081574d6so1321678b3a.2;
        Mon, 29 Apr 2024 17:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714438702; x=1715043502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KVrLL2iRxP+kuBnYvUqcBYVbkuD5EKt0KkMRbO2uxM=;
        b=fIAGANNawzjs0wvzHmq8QYe89b65SbuhuBc7CH7GG8oXBG75pK9VWj0okfYPR3jVLD
         RKEAZRrsGHnHrHHOL57iqXkMgYvxTyF2F5KrEceW1uyb7Eo9XlfX5Yq4mMQ9UIXirgZX
         TQmFZZXkSALCLlt+GoDnz0RVUCtwow1KlRUgPNmCR+cHiCUl5JGR/qwEeJEquLl2bKVL
         b+kQG3U7+klgPm+PVOUkGPwJDz+OOgIhgPcG3nViiUGdIgVAJXMsIFWNNgzKizXLj5VZ
         zlPsQdHFjpJLk3Bv2TYJWMytQeLr0GSaZvSUMh2T193nRhzZADFmX9VSSPQ2D+kif8St
         gCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714438702; x=1715043502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KVrLL2iRxP+kuBnYvUqcBYVbkuD5EKt0KkMRbO2uxM=;
        b=r+D4hp8qCk22ObxgYGPPQpKN2SkIsXrZuSjsVFx2cv78NIO+EI/etMyTEgd8K9fwcH
         O6DPsYXNWSfeJvEnktOs5J3DYkX0zMhxb5uD4RJ1ylw6PnSQK5Rsf22k4/3s6aB4VosS
         IzjCixkbYZhDr5uuBGbR6EpDB2Ai+pwEWrmMf0XxTgTxQVuGlJlN9TVC/VLpaw5yFByv
         BlQSRwnE5R4+nYExE3B3MicyMgOqUDb/xcFF8/jC6lqciEiG+ymIOQS567XWxkJaOjvC
         L/FzhTEYA+Ei/ZLdjjm7qedko0kthk3LN3HhDeM+CkrtSlVj5wDrRtOv/3p8QMEYaLtn
         UT6w==
X-Forwarded-Encrypted: i=1; AJvYcCXkkvPYBySiN+r9sjIlFXu+JuwUfFWNkmaBC/RtIb8TOARA2+Jj85PfjS5jbpDDUK0tuVFPmRFqb1vvP5Y7YQMqcgZ6
X-Gm-Message-State: AOJu0YyTvI8t0yBTob0EKXkvrH42Ute/8uhGzSCncnQxtONoD7zh8T/K
	1ZhjVswZXVViz8+B3MBYoKWzAvFATU5R7iAO+x+P/qrlSastQCf+R4zH2SaWVndCPFSjfMd+EjM
	RiQNxHFFTlc358F9H8HeVbkA7/i4=
X-Google-Smtp-Source: AGHT+IEsLZ8cV23eNmHkz0ueGZLIByKmmCQHvXDXgKq9YJ9jqgEC9g1+bHSnDweL2lrWxQbFCS0tlOmfGWUsHGVETu4=
X-Received: by 2002:a05:6a21:993:b0:1ad:9394:2d30 with SMTP id
 li19-20020a056a21099300b001ad93942d30mr10914814pzb.37.1714438702568; Mon, 29
 Apr 2024 17:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427005626.1365935-1-zhouzhouyi@gmail.com> <059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop>
In-Reply-To: <059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop>
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date: Tue, 30 Apr 2024 08:58:11 +0800
Message-ID: <CAABZP2y1Ge-B26BNRcCsga2h7RTdkF0jBZpUCZNcpNAusDGi4Q@mail.gmail.com>
Subject: Re: [PATCH] x86/rcutorture move CONFIG_HYPERVISOR_GUEST to kvm-test-1-run.sh
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com, 
	joel@joelfernandes.org, neeraj.upadhyay@amd.com, qiang.zhang1211@gmail.com, 
	rcu@vger.kernel.org, lance@osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 7:22=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Sat, Apr 27, 2024 at 12:56:26AM +0000, Zhouyi Zhou wrote:
> > CONFIG_HYPERVISOR_GUEST is a x86 specific kernel option, move to
> > kvm-test-1-run.sh to avoid ConfigFragment.diags in non-x86 platforms.
> >
> > Tested in both PPC VM of Open Source lab of Oregon State University and
> > local x86_64 server.
> >
> > Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>
> I like this general approach, but why not have something like a
> CFCOMMON.arch for the various "arch"s that need it?
>
> Better yet, I bet that there is already something somewhere in the
> Linux kernel source tree that knows what hypervisor Kconfig options
> each architecture needs.  If so, it would be most excellent to reuse
> that information instead of maintaining it separately in RCU.
Thank Paul for your great guidance and valuable advice!

I will do a thorough research on the above approaches.

Thanks again ;-)
Zhouyi
>
>                                                         Thanx, Paul
>
> > ---
> >  tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 4 ++++
> >  tools/testing/selftests/rcutorture/configs/rcu/CFcommon  | 1 -
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b=
/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> > index b33cd8753689..75774bc70be7 100755
> > --- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> > +++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> > @@ -68,6 +68,10 @@ config_override_param "--gdb options" KcList "$TORTU=
RE_KCONFIG_GDB_ARG"
> >  config_override_param "--kasan options" KcList "$TORTURE_KCONFIG_KASAN=
_ARG"
> >  config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN=
_ARG"
> >  config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_AR=
G"
> > +if uname -a | grep -q x86
> > +then
> > +     config_override_param "x86 specific option" KcList "CONFIG_HYPERV=
ISOR_GUEST=3Dy"
> > +fi
> >  cp $T/KcList $resdir/ConfigFragment
> >
> >  base_resdir=3D`echo $resdir | sed -e 's/\.[0-9]\+$//'`
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon b/=
tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> > index 0e92d85313aa..cf0387ae5358 100644
> > --- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> > @@ -1,6 +1,5 @@
> >  CONFIG_RCU_TORTURE_TEST=3Dy
> >  CONFIG_PRINTK_TIME=3Dy
> > -CONFIG_HYPERVISOR_GUEST=3Dy
> >  CONFIG_PARAVIRT=3Dy
> >  CONFIG_KVM_GUEST=3Dy
> >  CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=3Dn
> > --
> > 2.34.1
> >

