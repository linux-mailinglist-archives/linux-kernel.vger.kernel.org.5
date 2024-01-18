Return-Path: <linux-kernel+bounces-29743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E28312CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D397B2832C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBD1C127;
	Thu, 18 Jan 2024 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="H51l1XWa"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB3BE48
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705560075; cv=none; b=PngrdXo9KOVv9XF9xyGnc1kAX1WwcrFIufi8at8TmZLxIelzYU4QzLiAH4bme3sJXf5XEDGWzuQjC0BARVahHXiYxLZGvYEW2TVEbgGz5BkAEsFRgk2MxDNja8Rkr1TL5PRlGt/OdGzU61xrquZMSRmX9O4WHVoQCYHbz6+tTEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705560075; c=relaxed/simple;
	bh=1cC9leEGTGc4x6fHOxemTcDD5JFxZ+j1edv29HJ9AUg=;
	h=Received:DKIM-Signature:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:X-Google-Smtp-Source:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type:Content-Transfer-Encoding; b=HVTiOdwYTt8QDRaVJSv/rQ0aV6uu/G6t3UOcQBeeZMoEvrQu2cmXA8AqOCeOlnjcD/Nuv6mv7QfsJlt2evfuLtXl6pOc/U/M5Q/c/CAqLLjFTMpLRZ7Mryj2ebbExhM+DBJ5yRcZoB7OqlyV+XzrRyxf7U5TCvI9FWyczWwU+i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=H51l1XWa; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2FB463F272
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1705560064;
	bh=+ovjldvH3e07lZ8Vs4tOwzS5lzJ5LEH+FujyOCK9DFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=H51l1XWaHzSDOOkEDLoomsUzWrQjMjXuuLza/poX/d6f1wDGqqF1439U4iG18D10q
	 X8V0DKbN0WIptxaLcZCB3D5diCV6Wwzlnl1nW26AgDKLgxD+55BMYmxpxJ38TjudYm
	 l3ZbOj8ANsV5tF0HCvbX6TrdHVoz5S8owHdXy+z2OkVKD3m59KfWucjAz7yxRea3XJ
	 n3VSqmkEUITYf6gALTyqsXgJDiDJfsxJcprh8LxiWcv6zESJX7n63cM5agZvfJMPfb
	 6XoAatQyU3F6C9W5vMYmaqyIERJau+o1BrywX6zHfQddaL5Cf/XiLDha/EZzheRKZr
	 AnXjmMoqW+hLA==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28bd843b040so8367151a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705560063; x=1706164863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ovjldvH3e07lZ8Vs4tOwzS5lzJ5LEH+FujyOCK9DFM=;
        b=uDDBeEwzyxZjar00B+DF0nVfzeqKBjtiZ5XOmgEGNrabXQkXT6TxxxVGm9BZ636h1q
         qwGwfgjDuGP9YQJHwnSK71VyCI9xZK/5+P/FUxbcwE23B1p2eCgNEONmLXzIh6rDDZzJ
         bvDJL1k+e/PKtpeYXVdFoquTDvq10P57EJIBMbgcIRfCSCs7OHcc3HjbFLCgCpzp4WFc
         httzKEoTMIe0XRFb7qv+oRDh2UlLIddarGXvC6G3a7tppZ6BTNz9Ny8ld33oLrmHqspy
         hskv0ybdw/LJy8rmDxL6FBIHlhfiDyyd25ra81D6Ie6AEFBpYMlgMLFGc8IBOei/tNp6
         bEHQ==
X-Gm-Message-State: AOJu0YwYMJqwXPYSPAY7EGFrX1fQXiQQAerL343nnEnk0Hq6O/A8U9VP
	F4B38KSUfcCz0VWg1KBkKmgg8aHqRUYu7kOINcX5l7ih+WwfEQMiDb4szAY0n6OAFNssEJrW+5O
	hqIXoflb/uOXaLx6mUl8vMmr/7h4wehkINZB71Sf4HheXta2F0UaGNQwoF9WrA7aRQ/hRaZ3gMk
	jLhQYeBmb5OHN5bj3XjODQRCyjQwHvkopgp06cAYxWnr9AfQ971tes
X-Received: by 2002:a17:90a:fa0e:b0:290:28de:7bd4 with SMTP id cm14-20020a17090afa0e00b0029028de7bd4mr127951pjb.14.1705560062792;
        Wed, 17 Jan 2024 22:41:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH48tQ184w0nzKZbSlBIyAL//E5b/XRoUqFvU5JEAKRVnmqWFY8U/+n7XwITj/4re0JT/MwaOdxCzO3I+2KrJY=
X-Received: by 2002:a17:90a:fa0e:b0:290:28de:7bd4 with SMTP id
 cm14-20020a17090afa0e00b0029028de7bd4mr127939pjb.14.1705560062512; Wed, 17
 Jan 2024 22:41:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAd53p7ZwYNau1c=SDpGd+cqP2qO_7km9Q3-bow-Jqzo6STVFA@mail.gmail.com>
 <20240112173704.GA2272968@bhelgaas>
In-Reply-To: <20240112173704.GA2272968@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 18 Jan 2024 14:40:50 +0800
Message-ID: <CAAd53p6qE76QjJmjr5ei0mU8xcSNE32hJMOE9Frwz-BuC3gDkA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: GL975x: Mask rootport's replay
 timer timeout during suspend
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, Ben Chuang <benchuanggli@gmail.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 1:37=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Jan 12, 2024 at 01:14:42PM +0800, Kai-Heng Feng wrote:
> > On Sat, Jan 6, 2024 at 5:19=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > >
> > > On Thu, Dec 21, 2023 at 11:21:47AM +0800, Kai-Heng Feng wrote:
> > > > Spamming `lspci -vv` can still observe the replay timer timeout err=
or
> > > > even after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask t=
he
> > > > replay timer timeout of AER"), albeit with a lower reproduce rate.
> > >
> > > I'm not sure what this is telling me.  By "spamming `lspci -vv`, do
> > > you mean that if you run lspci continually, you still see Replay Time=
r
> > > Timeout logged, e.g.,
> > >
> > >   CESta:        ... Timeout+
> >
> > Yes it's logged and the AER IRQ is raised.
>
> IIUC the AER IRQ is the important thing.
>
> Neither 015c9cbcf0ad nor this patch affects logging in
> PCI_ERR_COR_STATUS, so the lspci output won't change and mentioning it
> here doesn't add useful information.

You are right. That's just a way to access config space to reproduce the is=
sue.

>
> I'd suggest more specific wording than "spamming `lspci -vv`", e.g.,
>
>   015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the replay timer
>   timeout of AER") masks Replay Timer Timeout errors at the GL975x
>   Endpoint.  When the Endpoint detects these errors, it still logs
>   them in its PCI_ERR_COR_STATUS, but masking prevents it from sending
>   ERR_COR messages upstream.
>
>   The Downstream Port leading to a GL975x Endpoint is unaffected by
>   015c9cbcf0ad.  Previously, when that Port detected a Replay Timer
>   Timeout, it sent an ERR_COR message upstream, which eventually
>   caused an AER IRQ, which prevented the system from suspending.
>
>   Mask Replay Timer Timeout errors at the Downstream Port.  The errors
>   will still be logged in PCI_ERR_COR_STATUS, but no ERR_COR will be
>   sent.

That's phrased much better then mine :)

>
> > > 015c9cbcf0ad uses hard-coded PCI_GLI_9750_CORRERR_MASK offset and
> > > PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT value, which look like
> > > they *could* be PCI_ERR_COR_MASK and PCI_ERR_COR_REP_TIMER, but
> > > without the lspci output I can't tell for sure.  If they are, it woul=
d
> > > be nice to use the generic macros instead of defining new ones so it'=
s
> > > easier to analyze PCI_ERR_COR_MASK usage.
> > >
> > > If 015c9cbcf0ad is updating the generic PCI_ERR_COR_MASK, it should
> > > only prevent sending ERR_COR.  It should not affect the *logging* in
> > > PCI_ERR_COR_STATUS (see PCIe r6.0, sec 6.2.3.2.2), so it shouldn't
> > > affect the lspci output.
> >
> > PCI_GLI_9750_CORRERR_MASK is specific to GLI 975x devices, so it
> > doesn't conform to generic PCI_ERR_COR_STATUS behavior.
>
> *Could* 015c9cbcf0ad have used the generic PCI_ERR_COR_MASK to
> accomplish the same effect?  Is there an advantage to using the
> device-specific PCI_GLI_9750_CORRERR_MASK?
>
> If masking via PCI_ERR_COR_MASK would work, that would be much better
> because the PCI core can see, manage, and make that visible, e.g., via
> sysfs.  The core doesn't do that today, but people are working on it.

I don't think so. Please see below.

>
> > > If 015c9cbcf0ad is actually updating PCI_ERR_COR_MASK, it would be
> > > nice to clean that up, too.  And maybe PCI_ERR_COR_REP_TIMER should b=
e
> > > masked/restored at the same place for both the Downstream Port and th=
e
> > > Endpoint?
> >
> > Since PCI_ERR_COR_REP_TIMER is already masked before 015c9cbcf0ad,
> > so I didn't think that's necessary.  Do you think it should still be
> > masked just to be safe?
>
> Did you mean "PCI_ERR_COR_REP_TIMER is already masked *by*
> 015c9cbcf0ad"?

No. The PCI_ERR_COR_REP_TIMER is masked with or without 015c9cbcf0ad.
That means before 015c9cbcf0ad, Reply Timeout error was reported with
PCI_ERR_COR_REP_TIMER masked.

So using PCI_GLI_9750_CORRERR_MASK is necessary for the endpoint.

>
> If masking PCI_ERR_COR_REP_TIMER using the generic PCI_ERR_COR_MASK in
> the GL975x would have the same effect as masking it with
> PCI_GLI_9750_CORRERR_MASK, then I think you should *only* use the
> generic PCI_ERR_COR_MASK.
>
> No need to do both if the generic one is sufficient.  And I think both
> should be done in the same place since they're basically solving the
> same problem, just at both ends of the link.

Do you mean only mask PCI_GLI_9750_CORRERR_MASK during suspend?
That will not be ideal because accessing its config space (e.g. `lspci
-vv`) will have many errors logged.

Kai-Heng

>
> Bjorn

