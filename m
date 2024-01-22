Return-Path: <linux-kernel+bounces-32962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DAA836282
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF371F28889
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37163C469;
	Mon, 22 Jan 2024 11:46:58 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2242439ACC;
	Mon, 22 Jan 2024 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924018; cv=none; b=CwLKnJNsxmNEgYYBS26tY2h29C0nA4gw5HvqzRSOeivXNfRNCJLmHeJT8JEGWkS0jDgGJKSgY0fOu6o+mHDgV9DwEd6VVcnGBrBY1XpNEUqLBzCVsgGFzknUJBnJqGAPHMQpafgZlD+VDYGsTL/7NnQ44Dg60tI8LsJ9mVsRZkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924018; c=relaxed/simple;
	bh=Xu9dO42e0kGtP2iek34Ct8qcatx6D34+espsKKYUB0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2RCdLdLKUHBvIbbsnvIpmBPNkpXC5JFMY+9FUycI3JSjwZyUsACjj6Ydjq/eXtrgiYsi6IonJDXe8K+SQBWYOwQLkYRwGAGIkrlYIcB+wfUXPHsbJrDx+Mmrmi1N0y3DrekXdBudrapY2dZ7iNq/h2+fdB9BCNjJoBe94csT5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-598afd970e4so444465eaf.0;
        Mon, 22 Jan 2024 03:46:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705924016; x=1706528816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xu9dO42e0kGtP2iek34Ct8qcatx6D34+espsKKYUB0k=;
        b=t40yxUAs45IY8vOSH07VRXYtgly+2p0OSwT6psBy0nY+w3T06u2mljjfDeTrjAF4Z+
         ZLL8sMEbDYla+OR1gW7lzBhNUE4GyDlZ3ZkzlZONSiJPm2fZVgLBSVOGPj6nGP6o4FSR
         1PI6qFz1ft5A9CBf6RRNMdSuQcWp1qDTa73osllZJYSsdUk+gimKgSozVBhSNHlskRxR
         Waxa6ipAOpqfOCH2w+LFBn9tY7BA3p1sTP0QVPf0UyNsgofajLNJPQmiQSVK21tb1hUI
         Gjmn3vvI4p+eDH0v0vrlSn2RiAoH76emtRUCA3FduAvO3qoLLQBGzGR/W6aKYW/ienwX
         DC/g==
X-Gm-Message-State: AOJu0YyqFNYi/KK35scnejnPIqBm7ADiIitKMXpOKY8NP1dGWSXMr3B3
	hWqNOCS1zK007N8zOhFMIfo81ukyc7dtduzk3TduyveCH15DumYIPR2ux/uB5O56h5SWSdInOeb
	aoUAgRXCGx6SsiNC6nF1UHJpDMek=
X-Google-Smtp-Source: AGHT+IEaFNyIRXDCFBQIZlnYyvRFTeKr3IUazcDdu4f58xNCxAzZX4sK6mBZno00mYuQRKofhbbeEQFm/nzeRqdDtcM=
X-Received: by 2002:a05:6870:2193:b0:214:2425:9962 with SMTP id
 l19-20020a056870219300b0021424259962mr5660544oae.0.1705924016139; Mon, 22 Jan
 2024 03:46:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120513.1018808-1-srinivas.pandruvada@linux.intel.com>
 <6021639.lOV4Wx5bFT@kreacher> <c961bae053da7287bfce49b2c1c2e7e6c754710a.camel@linux.intel.com>
In-Reply-To: <c961bae053da7287bfce49b2c1c2e7e6c754710a.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Jan 2024 12:46:44 +0100
Message-ID: <CAJZ5v0iFAPW5x3gWFnjYKLQQvWoJ65gdpwRhnyEgLD2p2pWUcA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Directly use stored ratios for max frequencies
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, rafael@kernel.org, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:35=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2024-01-22 at 11:53 +0100, Rafael J. Wysocki wrote:
> > On Thursday, January 18, 2024 1:05:13 PM CET Srinivas Pandruvada
> > wrote:
> > > Avoid unnecessary calculation for converting frequency to
> > > performance
> > > ratio by using a scaling factor for the maximum non turbo and turbo
> >
>
> [...]
>
> > ---
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH v1] cpufreq: intel_pstate: Refine computation of P-
> > state for given frequency
> >
> > On systems using HWP, if a given frequency is equal to the maximum
> > turbo
> > frequency or the maximum non-turbo frequency, the HWP performance
> > level
> > corresponding to it is already known and can be used directly without
> > any computation.
> >
> > Accordingly, adjust the code to use the known HWP performance levels
> > in
> > the cases mentioned above.
> >
> > This also helps to avoid limiting CPU capacity artificially in some
> > cases when the BIOS produces the HWP_CAP numbers using a different
> > E-core-to-P-core performance scaling factor than expected by the
> > kernel.
> >
> > Fixes: f5c8cf2a4992 ("cpufreq: intel_pstate: hybrid: Use known
> > scaling factor for P-cores")
> > Cc: 6.1+ <stable@vger.kernel.org> # 6.1+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> Tested on the system which showed the issue, this patch work fine.

So I'm going to add a Tested-by from you to it or please let me know
if you don't want me to do so.

