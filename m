Return-Path: <linux-kernel+bounces-119218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 057BF88C5CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8700E1F62C38
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65FB13C816;
	Tue, 26 Mar 2024 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCdN7rHJ"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6213C812
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464651; cv=none; b=j/1D4l7cTIW8kYWtZoKnEcPPlBJogwoZOdLeXCZTaz4YStF1FeQ8yV0/SSzVuFde5Y/tApBpr+qxErLkDCz7fSYNcNeBkGZUan1z6eTCzHBIHZlK6lEwtzfQygmoESS3YaBESRkVbziNEpTSIBXviNriCckreYdlIcWJzINYdCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464651; c=relaxed/simple;
	bh=M0l3pASlijFBuC5mIXOLnjRqChsnB1fA9zTnKwjZtmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMfWXMbIIw3fuhTgcLfVANzXMb8vE8oxHcpwebOizRKZHrKKJNpqc5KKWC8PHwSyPDEoHKMRcaTvIzm5GDo0jZKB9v00BzAk8hdYi7oagqmKvWIRgmnQxhAuz0xZlHh2y0pKCS+eha5bKJxzx9Jd/Uuh5WHNCXvWhaiKUJrJvcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCdN7rHJ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso3375523a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711464648; x=1712069448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH/IJ7qi61uZRp4uFBAxZpmaH7Saq5egmRjmLZJxRsM=;
        b=iCdN7rHJFnhjoWQ7uI44GTq8asF4hKj7ZZwWei6EXMNNFLFccvM9eWX/n1dd/UrkiR
         mw4CbV5LtVjqndiT6G7RLmCPy9MxRtMLSkGBQKeHrTCNIbGmgY/MS/js+5V8r322X0yU
         7ahRNhzuxHBf+rZjACRRdADotGPdTLPCGsXr3irjBksALqdxZzqLGNpOKwzdKZS7/m91
         9XUdOeB9B2jbVNWCsNsCmsdgoHJbU5D62jiwiAEXN5vlz0pdRdg3ENbl0y65zXGvnewV
         O0NXCNqdyxr4S2ulON3YoyGIXMZoIeF2hiis1AF75vLFHHSCyR3tC6ARE0xDcQ+JH8L+
         GWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711464648; x=1712069448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mH/IJ7qi61uZRp4uFBAxZpmaH7Saq5egmRjmLZJxRsM=;
        b=aLxmew7aH/Oy1X3uBIXTXXv8VhSkhDCF6OBHCYFCJ8BafIjGB2rvEsPKouA0byxEoH
         p1xtJ3vnYq5Qi9owOLwV4JTjy1pQf2KAS/dbV41G2U4oak4uKwk/hOnyp0FBzvPKK+vy
         ZPf8sr2Ehm3dEBc/fmlsDoV0pfZZ8VMM4ItQHrcIlcamzwO4OdADiOvnVTlx45WODYM7
         +5vEg5Slb+2OkKLIm/VHTumZO+95NrV65uGhVqaoinkpvX6tPONrRGwHI4epSZ23BlWI
         MPe5kuHn5hMWBVrwr4YgDZSsvD7T6g1okIZjlON9STuCcn8Cdp4d9lXcW332NyI6DXvr
         JTeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGZf7TVH8v8oofzuFoNl/gYFLm9fMmyvJb5M3GcwFCIkmuu74OWG8oLVuAbiBMFvFaxKZKovCh9B46wD3jD3jaMfhzzbufEdzp0p6V
X-Gm-Message-State: AOJu0Yz6w3zmXLYrNFXk0H9nqfDHDHFYUmUJPY3SUsyuizb8EQY1RnDn
	eeORoXJs1cwL3eWjiIuhVyxG4NV/ag2fd7QFlW1V1zjLQEpMQCIr0jijhMvmgcMtKNnbO4lI6X1
	N2hIFsC2lUF0m1MdoOxYVDoZguE14wKVW1XY=
X-Google-Smtp-Source: AGHT+IGvYt1rAYvBJqUKJk6hEYneUZeFwHr2eOm2WaAs4M8jDi5h0/8Lqjjz3HxqiIhKXp/k4BYojM1GkrAmfrtHNko=
X-Received: by 2002:a17:90a:d148:b0:29b:6e9d:5897 with SMTP id
 t8-20020a17090ad14800b0029b6e9d5897mr47119pjw.23.1711464648476; Tue, 26 Mar
 2024 07:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312165905.1764507-1-andriy.shevchenko@linux.intel.com>
 <20240325211915.GA1449994@bhelgaas> <CAPf=4Rc2vQrWqcs=-ND3iOZFJyKE7FdPoqU9w6DKjoSaJo6KaQ@mail.gmail.com>
 <ZgLefFQanbq-ozKM@smile.fi.intel.com>
In-Reply-To: <ZgLefFQanbq-ozKM@smile.fi.intel.com>
From: Mateusz K <mateusz.kaduk@gmail.com>
Date: Tue, 26 Mar 2024 15:50:37 +0100
Message-ID: <CAPf=4Rdc6pHy34dSKex_KOmeAo2bsuaGv5X6MyJ6+Se5h3Mo4w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI interrupts
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Maybe it's much to ask, but I would really appreciate it if someone
looked into intel-lpss supporting these devices.
Been using a laptop without a functional touchpad over months now.
If that helps, there is another thread here
https://bugzilla.kernel.org/show_bug.cgi?id=3D218444 with perhaps more
details on the problem.
Battery and speaker are not a big deal, but the not working touchpad,
which I believe should be handled by an intel-lpss driver, is kind of
painful.
If you need any help from my side, testing patches, don't hesitate to
contact me.

Regards,
Mateusz


On Tue, Mar 26, 2024 at 3:41=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Mar 26, 2024 at 11:06:38AM +0100, Mateusz K wrote:
> > I tried the patch that changes PCI_IRQ_LEGACY into PCI_IRQ_ALL_TYPES
> > and it seems I get some other error now
> >
> > [    1.477341] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
> > [    1.477466] intel-lpss 0000:00:15.0: can't derive routing for PCI IN=
T A
> > [    1.477468] intel-lpss 0000:00:15.0: PCI INT A: not connected
> > [    1.477488] intel-lpss 0000:00:15.0: probe with driver intel-lpss
> > failed with error -2147483648
> > [    1.489572] intel-lpss 0000:00:15.2: enabling device (0004 -> 0006)
> > [    1.489688] intel-lpss 0000:00:15.2: can't derive routing for PCI IN=
T C
> > [    1.489689] intel-lpss 0000:00:15.2: PCI INT C: not connected
> > [    1.489715] intel-lpss 0000:00:15.2: probe with driver intel-lpss
> > failed with error -2147483648
> > [    1.501886] intel-lpss 0000:00:19.0: enabling device (0004 -> 0006)
> > [    1.502034] intel-lpss 0000:00:19.0: can't derive routing for PCI IN=
T A
> > [    1.502036] intel-lpss 0000:00:19.0: PCI INT A: not connected
> > [    1.502067] intel-lpss 0000:00:19.0: probe with driver intel-lpss
> > failed with error -2147483648
> > [    1.514288] intel-lpss 0000:00:19.1: enabling device (0004 -> 0006)
> > [    1.514535] intel-lpss 0000:00:19.1: can't derive routing for PCI IN=
T B
> > [    1.514538] intel-lpss 0000:00:19.1: PCI INT B: not connected
> > [    1.514570] intel-lpss 0000:00:19.1: probe with driver intel-lpss
> > failed with error -2147483648
> > [    1.526291] intel-lpss 0000:00:1e.0: enabling device (0004 -> 0006)
> > [    1.526555] intel-lpss 0000:00:1e.0: can't derive routing for PCI IN=
T A
> > [    1.526557] intel-lpss 0000:00:1e.0: PCI INT A: not connected
> > [    1.526604] intel-lpss 0000:00:1e.0: probe with driver intel-lpss
> > failed with error -2147483648
> > [    1.538130] intel-lpss 0000:00:1e.3: enabling device (0004 -> 0006)
> > [    1.538233] intel-lpss 0000:00:1e.3: can't derive routing for PCI IN=
T D
> > [    1.538235] intel-lpss 0000:00:1e.3: PCI INT D: not connected
> > [    1.538253] intel-lpss 0000:00:1e.3: probe with driver intel-lpss
> > failed with error -2147483648
>
> Hmm... I have a unique board to test :-)
> Let's revert it then.
>
> Bjorn, in such case your tree should keep conversion one.
>
> Lee, do you prefer a revert or can you simply drop this from the queue?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

