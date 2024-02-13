Return-Path: <linux-kernel+bounces-63990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6E8853842
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953F3B293B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2942604AF;
	Tue, 13 Feb 2024 17:34:40 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC0F60279;
	Tue, 13 Feb 2024 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845680; cv=none; b=Af73xbG1F6q3XRDCWsVIEUQvUMKYojNfYpCx4pEKa+o4+Io1ZruG3dnULTxaKw61tkacWT0kAvdJaaZmebtuoMJP4V9cSNKDpV1pgpzTGwKHTR9voWZFfWF84fkkhGRphaRCThyqMtB9eSyY4VIwB3jcm2r1jp6qpdmA/VF7A8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845680; c=relaxed/simple;
	bh=c/Wt2cl1adrqn+y+VTiixGgANJnxyMDGcXhZX+95cxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVqjHL2zZjJorn64Zv/Mi38PDZQU/zITy4OKYQHKx6JUEryMYelq/n/mZwP9l9e4cd8oaC8728mfQTlOkzwFJC4J+t29SjWwUkVX3O3oMb8WKWGVtrI+3IcPF2Jr+J1T10PWjBcg/5vs68o1Mw9ol8Yc/HUBxMRgW2pvEL6uljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e2f3e863fbso140378a34.0;
        Tue, 13 Feb 2024 09:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707845677; x=1708450477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYZycCqXO/IvtV9fFldFSK4bZ9WbpBQtgeMSSvaaULI=;
        b=rv94fFZxiK+htj67bp7uv9vtyDs/MTr2WSfxH3lEoUWqeuHnqtq8JBFZx1fKnHidZN
         WdHN2m+UlW+Z3XX6tcassRjFM7AmlOZvPyCfmrVdrvClpowDd6DR/Vg+nOdov+ajrURn
         oV2HjE493qwtnzKFWGYB07Ec7TPvOxrJuFIQJr7pyKwAJLGJVgA3nDeKly0Vt6AgTKD3
         FwRh2pTU5kyMMPotNj/RpxcK6DDhb1rFRSAQhM3L/dfQTtIqCW37MHIyg3vHAa+QZkad
         AXTjvbna+FHWtPhrdxmv3VXyqqUGXR58AzS/xZG2iC5xiuEQ56t1dbm3wwAr7vPmx+yC
         aMyg==
X-Forwarded-Encrypted: i=1; AJvYcCUyi9UGMp1eWa6dXCQg5Dii0eIa+nKKrfrgYkgLC7QGgquJVM2yQ2XYRO/eV6x3UF0YEPeNj2yQ/SZZp8kDeJatrEH8guhBEWn27avoH96NMIbL7UAYil6wcTzx9HGMeeYNyVTCQwy0oSPqJnjqxvaBtJ05GfD7QvkdlTG42JshcNs1ybUyjbvi
X-Gm-Message-State: AOJu0YxnS7ZVGOEls2A1oajkSeudpkJstdxXGbBjor0Z2cumSa+LRuIa
	L2wkzy7yYIviLlbiZ2Wj1mCMX/9ta8oDHbyWV+FoWlzZ6NfJK2ppYHozPAnlu7hXYTrmRziLK2I
	W+lWnPDkMhudSW7q4FIcwS+mPlgk=
X-Google-Smtp-Source: AGHT+IE7YPlABGYgUznc1VZQ7aeKs1A0NW+/lpUob1WKX1anoeFXMQ8UT1MjF+3O5wIEcr4FfxzxODOCqbuAiFyMh10=
X-Received: by 2002:a4a:e9ba:0:b0:599:fbcc:1c75 with SMTP id
 t26-20020a4ae9ba000000b00599fbcc1c75mr376859ood.0.1707845677204; Tue, 13 Feb
 2024 09:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213110852.51524899@canb.auug.org.au> <4044e07e87af766f643f89f839b332973819e048.camel@sipsolutions.net>
 <e15b25c2-2ced-4f79-b541-61980a31f947@intel.com> <82e78ebf5f84314e3fc1e6b8b1a76f948c9aeb22.camel@sipsolutions.net>
In-Reply-To: <82e78ebf5f84314e3fc1e6b8b1a76f948c9aeb22.camel@sipsolutions.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Feb 2024 18:34:25 +0100
Message-ID: <CAJZ5v0iQvOnO0FffGHVzTOrTVdfAB6jaFYgsKL1ep7BnOz0m9A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the wireless-next tree with the pm tree
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Kalle Valo <kvalo@kernel.org>, Wireless <linux-wireless@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 6:14=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Tue, 2024-02-13 at 18:03 +0100, Wysocki, Rafael J wrote:
> > > >
> > > >    2e171a57c312 ("iwlwifi: mvm: Drop unused fw_trips_index[] from i=
wl_mvm_thermal_device")
> > > >
> > > > from the pm tree
>
> > > I guess we'll have to live with this conflict, unless Rafael you have=
 a
> > > feature branch for this I could pull in and resolve?
> >
> > Well, not yet, but I can add one if that helps.
> >
>
> Well if you have a branch that has the above commit and not too much
> else, then I could pull it into wireless ... but chances are the common
> base that we have is divergent enough that'd pull a whole bunch of other
> things into the tree so that'd not be great.

On top of 6.8-rc2, there are 3 unrelated commits that you'd need to
merge along with the wireless ones.  Your call. :-)

> Pretty sure even if the conflict survives to the end Linus could figure
> it out? :)

Agreed.

