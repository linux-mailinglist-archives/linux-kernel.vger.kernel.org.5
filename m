Return-Path: <linux-kernel+bounces-6256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B877E81966C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA87B251FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974088BF6;
	Wed, 20 Dec 2023 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kQgBQyxg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70E179DE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5d42c43d8daso3722507b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703036223; x=1703641023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMpPDRTJH35hvvkbLxFhPjnJilPUQ+sVkxQSPUGNzAE=;
        b=kQgBQyxgba8i8B/eAJOCbjHJg3PgNNBak2NzTlQbQWhqJ3NGY85w6cSEUMZhQIbDxa
         +k3gPddy7z7CH8tW7jqmMuzp8MUpyU/E0XM+piP5lEbQ31u1YUzTJCjK9AGQBg/XM0su
         G0YlvI2/Fgye2NorxkjaV+g2fNbzyLwjtf35Dm0a00E1j6zWiz/dWziS8OXGIa7RwsJo
         i6tBfQZn+wFgbF0RAYganCZQ6i6SC0bviqykXy3ePGCR4/G4whezZWenwMPvLzD1X8PC
         znrPg4inlALehBD+cyx3fNRLWU7GSHmd2pI2iWnsTenltreUBKwsV56QF8BIvE068Tpr
         /wXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703036223; x=1703641023;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZMpPDRTJH35hvvkbLxFhPjnJilPUQ+sVkxQSPUGNzAE=;
        b=BLy/+DIqTYlsrCM3ORlQv7804UroBHw1nch5c+MZtwLquLEwysYaE0GoH9aARqM98T
         cULk/t8vqWWJsJ0IUjDpY1EI3hvUV4cuTZH89KwqOxy/rusC3JUxzS/Cb66gpdAt96oG
         gWitATTve2g06nIsNlpSBc24jyZjJeFpt6+O1k9Vx0wCmFpwtKl//OPkYuBFnZCLry6M
         fXcDTYZNyNP1PP15y2WyTAyRPdGKZVycmqrUbDmx7wsZ7UtfM03KnRGSZxSF7ORkrDwu
         +Zu7kL35LsUnh/dESh+HqGFWnukOZeInd65DI649EH2O1WZtawmGhSNt4MkYS92jjd/2
         Krjg==
X-Gm-Message-State: AOJu0Yx6Dkz1jNQn3ZH4xR5+lUmyxMR7oI9k0Wbeb2j0Wm5cCzbum2Rj
	6BtxXomnyJ9noSNbb8/y7YP73M3d3E2/TrM0tA==
X-Google-Smtp-Source: AGHT+IHkW3C5TUe1j64s0L+R/fMZTOwVtCHzR1lHKvZLh86Uotwca9XCKzPvHhUBb8usj/+FHyFqnAW4Z34=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2913:b0:5e5:d445:d9a9 with SMTP id
 eg19-20020a05690c291300b005e5d445d9a9mr688492ywb.3.1703036223803; Tue, 19 Dec
 2023 17:37:03 -0800 (PST)
Date: Tue, 19 Dec 2023 17:37:02 -0800
In-Reply-To: <CAD=HUj5g9BoziHT5SbbZ1oFKv75UuXoo32x8DC3TYgLGZ6G_Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230911021637.1941096-1-stevensd@google.com> <CAD=HUj5733eL9momi=V53njm85BQv_QkVrX92xReiq0_9JhqxQ@mail.gmail.com>
 <ZUEPn_nIoE-gLspp@google.com> <CAD=HUj5g9BoziHT5SbbZ1oFKv75UuXoo32x8DC3TYgLGZ6G_Bw@mail.gmail.com>
Message-ID: <ZYJFPoFYkp4xajRO@google.com>
Subject: Re: [PATCH v9 0/6] KVM: allow mapping non-refcounted pages
From: Sean Christopherson <seanjc@google.com>
To: David Stevens <stevensd@chromium.org>
Cc: kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023, David Stevens wrote:
> On Tue, Oct 31, 2023 at 11:30=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Tue, Oct 31, 2023, David Stevens wrote:
> > > Sean, have you been waiting for a new patch series with responses to
> > > Maxim's comments? I'm not really familiar with kernel contribution
> > > etiquette, but I was hoping to get your feedback before spending the
> > > time to put together another patch series.
> >
> > No, I'm working my way back toward it.  The guest_memfd series took pre=
cedence
> > over everything that I wasn't confident would land in 6.7, i.e. larger =
series
> > effectively got put on the back burner.  Sorry :-(
>=20
> Is this series something that may be able to make it into 6.8 or 6.9?

6.8 isn't realistic.  Between LPC, vacation, and non-upstream stuff, I've d=
one
frustratingly little code review since early November.  Sorry :-(

I haven't paged this series back into memory, so take this with a grain of =
salt,
but IIRC there was nothing that would block this from landing in 6.9.  Timi=
ng will
likely be tight though, especially for getting testing on all architectures=
.

