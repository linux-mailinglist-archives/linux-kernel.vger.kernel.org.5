Return-Path: <linux-kernel+bounces-83125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5314868ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22BA01C24CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9366313A263;
	Tue, 27 Feb 2024 11:28:47 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75EB13A255;
	Tue, 27 Feb 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709033327; cv=none; b=O2uNABVrjorLN7Iv+QqOgaabWmi1eOZ8O+BaokSsIZetVEvLX/5A4BPfEFuyu0OQZLLF5c5NEyTZPN//bVqH2pzG31x0Rgso/tmgzhs1tMPTbUAAeGAo91aOE6dS3XVyoz50VZ0tr22z6roCRDN01Yq2bq3/FZbId1GYwuTfM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709033327; c=relaxed/simple;
	bh=olawrkIf763TyDJBSdS+BMEVTPSM6dh0cJaug71x7i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kC7EUs2VMkSA2eY4CKzotyZfEDLnzLHJYA8OPDY10vsgs5S75uv3HCGJKHKTS7VRD+OXm/pgvry6cboVb512B65dn5WgvRsgorhVOL/M1CpcZySrVf4A+THNrWL/K7BWOaGTKeF+MdwtN7ZYp8yRiD7++eIrKJwqUMMnN1CuHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e45f7c63f4so380083a34.1;
        Tue, 27 Feb 2024 03:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709033325; x=1709638125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5EZQgvYzf+Di85HQE8BTviHNfeUCSHk+RcP+d55ags=;
        b=EgccJp2U8MEvUZuWMPKGpkkJH7aWu2fYDZArnCRYmQfkMk8wAv278rGIr7vwfwSR1U
         Cm76DLezNeX/ibuxw3OPUDeHHowpuoQaknUNxCyOPRzMGUa6hhPoWq3Eqscb5+xnitGg
         jTXaq5WsYS0pqKBKBNQtVEHNuPo7DxcK3brhitS/Bz66PwE1kxOixMebPSiKQZGpkF0O
         yiFZxV352cBC1fQB6ht3PBX1Eo8/JrzrmisyHXhARGMAcROM/N1qlWuRni5hnLYVuLfk
         6EAf0BlqLjvANsLh7K7Vj+mn5I9AXfAbc7SNRejxiM3BqJjOdH7noMbl/L3rBm8r3bPS
         2hFw==
X-Forwarded-Encrypted: i=1; AJvYcCXzzpnMLauIr92x9/qDCTcAw9oPSOxnZ7lgcknflgQ5zqTKoo7Xi679BdtV+yHlTpWU62svbSgDhnFzccxTBuhU1lcW37pvF+ABlKw79DsKAZlinSLpHwRsTJPqp4jV0IdjZm9FDeA=
X-Gm-Message-State: AOJu0Yw6ES5Q71Q/97knQ4sY/ANyfOPAkno4l7wgwwOpWb+zVxWif27s
	WnnoiLi2Dxksb8s6uuguiZAFzaQGwAS739qRcpcUjiaPeNlwXxBArD6K5uOWSqYFC1gTb2UmDfJ
	kPEHD+tQGEeQe/aMDvpnbpygh2mdw3lLb
X-Google-Smtp-Source: AGHT+IHlg2LZu8z6kyFlZ6fKhXldHIW301ZiBKZfmt7pdBwtvCOwfWcupoStfpObVcPX8OLs+1PLtrzHQGJE8XJoCxc=
X-Received: by 2002:a05:6820:2b15:b0:5a0:396d:2489 with SMTP id
 dt21-20020a0568202b1500b005a0396d2489mr9336880oob.1.1709033324837; Tue, 27
 Feb 2024 03:28:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223143833.1509961-1-guanyulin@google.com>
 <CAJZ5v0gM=0rU6a1A6Bh2Ed=4=1AtQ3p5aDJVCOioA6qxGv1jtQ@mail.gmail.com> <CAOuDEK1NdFSZgy8_ebO_zSxbU-gLJHsCzjd6JSr2cckQAFgaTg@mail.gmail.com>
In-Reply-To: <CAOuDEK1NdFSZgy8_ebO_zSxbU-gLJHsCzjd6JSr2cckQAFgaTg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Feb 2024 12:28:33 +0100
Message-ID: <CAJZ5v0g0WgYWyOfMaq8PhOkCmBFuDRb3XbCxPpcbpJuJza0+cA@mail.gmail.com>
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
To: Guan-Yu Lin <guanyulin@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, pavel@ucw.cz, len.brown@intel.com, 
	gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	petr.tesarik.ext@huawei.com, rdunlap@infradead.org, james@equiv.tech, 
	broonie@kernel.org, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 10:45=E2=80=AFAM Guan-Yu Lin <guanyulin@google.com>=
 wrote:
>
> On Sat, Feb 24, 2024 at 1:44=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Fri, Feb 23, 2024 at 3:38=E2=80=AFPM Guan-Yu Lin <guanyulin@google.c=
om> wrote:
> > >
> > > In systems with a main processor and a co-processor, asynchronous
> > > controller management can lead to conflicts.  One example is the main
> > > processor attempting to suspend a device while the co-processor is
> > > actively using it. To address this, we introduce a new sysfs entry
> > > called "conditional_skip". This entry allows the system to selectivel=
y
> > > skip certain device power management state transitions. To use this
> > > feature, set the value in "conditional_skip" to indicate the type of
> > > state transition you want to avoid.  Please review /Documentation/ABI=
/
> > > testing/sysfs-devices-power for more detailed information.
> > >
> > > Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> >
> > Please explain how this is intended to work.  That is, what exactly
> > you expect to happen when the new attribute is set.
>
> The sysfs entry 'conditional_skip' for a device indicates which power
> transitions (e.g. PM_EVENT_SUSPEND) are omitted within the system
> power management flow. During the processing of an identified power
> transition, the device's power.entry will not be added to the
> dpm_prepared_list, preventing the device from undergoing that
> transition. As 'conditional_skip' is modifiable at runtime, a device's
> participation in system power management can be dynamically enabled or
> disabled.

So this idea is completely misguided AFAICS.

First off, why would a device be skipped in system-wide suspend and
not in hibernation?  Or the other way around?  Or why would it be
skipped in one phase of hibernation and not in the other?

Second, but not less important, why is skipping a device in
system-wide transitions a good idea at all?  What about dependencies
between that device and the other devices in the system?

Generally speaking, system-wide PM is designed to cover the entire
system and there are good reasons for that.  If you don't want it to
cover the entire system, you cannot use it at all.

