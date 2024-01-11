Return-Path: <linux-kernel+bounces-23305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196D882AAC9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCEF1C25E40
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441C912E7E;
	Thu, 11 Jan 2024 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+HHQivC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9BD12E5F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704964913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18eURhzPqjh6OO9ktQkfsRySWY9tUDGvnWhEFURW+fY=;
	b=J+HHQivC6LN52GtERTJ+pHD1BcH61f6+oJ/dEwTmB9Wrw6/RolgbaIvXQqrJ3IOcQwrS7e
	fHb7ZxHCE2En/VDlwlGCuHv/2ynLgdmNv12sP49DyVIyeFsl0LT0aHRZsmTvY6fwiTmjAq
	DXi5SqQoYUOjS5s7Fp7ytzn3NLmj+FE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-VB-_lx03M_aa6uiVhn_TJA-1; Thu, 11 Jan 2024 04:21:50 -0500
X-MC-Unique: VB-_lx03M_aa6uiVhn_TJA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d50d0e552dso8851625ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704964910; x=1705569710;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18eURhzPqjh6OO9ktQkfsRySWY9tUDGvnWhEFURW+fY=;
        b=uSUvdQh74Gau+0dBlUyqlK0xFS/L2ABt2zocHeiidKa6UCH0D4t+4QsTpL8mKtSIoZ
         XV9aGP4ZA4lU364TALLjiN4bA1eJuVzpYBWBDs2w30NFnqTa2YmLOKmGxhyiJxZqXFBU
         NHQmH59VWMWBtPM8UW9MnlsNFYc2NXxv+ZRIx0coGHI501piCR11hwn8NOHXjY4SrkRC
         h1W83kjPvBYHQFamnYOZmYvindlooZFQdXnCztgxfuok5apklLHtXWZDbZ4bFs+xYBY0
         0mVIwbEBnl4jFxq5GhqumA8lKMsKS3WKKUAfId3QLtHzfPWCw6GupisBoAZRlTZLJt0z
         E78g==
X-Gm-Message-State: AOJu0YyIzIYWCGsTOHdkP3itlFeGkdFKfHbNrNbafciwKcuhIR/EEgNt
	8zGWEJ0tYZgsmd/snG22ZJIcw1fGG90eIKrr2SPCzVmlEheyQ8V6dIH83tHTg5ZDaGlcgYdBzTW
	LFw2AWw4TpTZxr3DSrwQw0cbiRDTdw6TG
X-Received: by 2002:a05:6122:4104:b0:4b6:e3fa:7599 with SMTP id ce4-20020a056122410400b004b6e3fa7599mr1397000vkb.0.1704964487940;
        Thu, 11 Jan 2024 01:14:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsCflr1cnBg8FbDO4MmTrvarkaVOthrTYfY/uZOhpa7zT35UnHSVpI8slHFl4ak53EWIvl9w==
X-Received: by 2002:a05:6122:4104:b0:4b6:e3fa:7599 with SMTP id ce4-20020a056122410400b004b6e3fa7599mr1396985vkb.0.1704964487656;
        Thu, 11 Jan 2024 01:14:47 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ch7-20020a05622a40c700b00429970654b6sm281418qtb.33.2024.01.11.01.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:14:47 -0800 (PST)
Message-ID: <42cf5ca70c940b3e68c8ad0e4bab6f14f87d4486.camel@redhat.com>
Subject: Re: [PATCH v5 RESEND 0/5] Regather scattered PCI-Code
From: Philipp Stanner <pstanner@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas
 <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Randy Dunlap
 <rdunlap@infradead.org>, NeilBrown <neilb@suse.de>, John Sanpe
 <sanpeqf@gmail.com>,  Kent Overstreet <kent.overstreet@gmail.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Dave Jiang <dave.jiang@intel.com>,
 Uladzislau Koshchanka <koshchanka@gmail.com>,  "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, David Gow <davidgow@google.com>, Kees Cook
 <keescook@chromium.org>, Rae Moar <rmoar@google.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, "wuqiang.matt" <wuqiang.matt@bytedance.com>, Yury
 Norov <yury.norov@gmail.com>, Jason Baron <jbaron@akamai.com>, Thomas
 Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>, 
 dakr@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arch@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 11 Jan 2024 10:14:43 +0100
In-Reply-To: <43478eb70cf5f1120316739803c7622ab5f9e16a.camel@sipsolutions.net>
References: <20240111085540.7740-1-pstanner@redhat.com>
	 <43478eb70cf5f1120316739803c7622ab5f9e16a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-11 at 10:03 +0100, Johannes Berg wrote:
> On Thu, 2024-01-11 at 09:55 +0100, Philipp Stanner wrote:
> > Second Resend. Would be cool if someone could tell me what I'll
> > have to
> > do so we can get this merged.
>=20
> I don't even know who'd merge it, but um doesn't seem appropriate...

UM isn't a recipent, I'd guess it's some mail filter which might make
it appear that way :)
The lists I sent this to are
linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
linux-arch@vger.kernel.org, stable@vger.kernel.org

Anyways, PCI is for sure who should merge this, since it's 100% about
PCI.

> >=20
> > @Stable-Kernel:
> > You receive this patch series because its first patch fixes leaks
> > in
> > PCI.
>=20
> Too early for that, stable just ignores stuff before it hits
> mainline.

I know, they're in CC because of the "Fixes: "

P.

>=20
> johannes
>=20


