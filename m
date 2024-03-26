Return-Path: <linux-kernel+bounces-118864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8CD88C06D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D62B1C31641
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1894CDFB;
	Tue, 26 Mar 2024 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnahrbcw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E843D52F;
	Tue, 26 Mar 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451926; cv=none; b=f5nfFR8bLlPYzQDryCvpedd7uZ+1WjrL3dddDXlR+8bd5VQ3TyX+2F/gxA7XwDrHlHWWviu8B/sDjsGD8em0mA6tjhb0ggfsvis46tYmg4Xk/1xm9WUU/ppSKfqhRLOHlmUdX6Xue8bUPG4kDOsE221S04F7/GxjboisD8VpfeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451926; c=relaxed/simple;
	bh=c3DT0yLem2b3enR7udipH6xBBSV9/V0+ZqfgXpeBGP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOsJ1LUfSTeHRRD+l9b6sSnD7hDfOLxXrKgwK64vSPI4pzXy9fvcIEVqEa5PeMruPaY5uH1fPJkNVn+2+gJTQA++cRaULGXqKQhw5+y5lipBP5yM7eNlG3CnjqpCv5+xuJg/cYiZX8Vrh1Ww1ouG9VnXW1VVyT0KtlggPsohYBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnahrbcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DC2C43390;
	Tue, 26 Mar 2024 11:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711451925;
	bh=c3DT0yLem2b3enR7udipH6xBBSV9/V0+ZqfgXpeBGP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cnahrbcw6XINevHPRqe90R2bmhq/HqiYP/nHdQxaHKSr8oAWLJ6s4aw9GJiwtqYDU
	 MyJmLAFZEySQStNw9kMO/lzr72mIV6bxJyHtK+RWPHbC6juj1D0o9si9woKMlIlD1M
	 PT1kAATHUK0QRT/1oVnafIXIYCIDEywvMkljlFWdvMJgVSJHSksPyy4hZbGT/Izcto
	 BOZjkGh6JFVhRvNX5XMZ7XwZ0FGEM5XnO1roa3c2YbjGjsXz7x1QzMA/0+TrAuX5jo
	 7/p+hqGFCXtvTdSFE2sq+vQqiLsTx56gkLzPmqfbgg4WgJjLrKrCLqo15TsHQdz5Iw
	 UaIQQkiUJApFg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a47a3786dbso1590316eaf.0;
        Tue, 26 Mar 2024 04:18:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4kHPEK5onhgQ00rMgCYty7CLodlUutDL8w8wmzCbxDN1tsY5eh+phYrpDYN+SWdoibwMcDhBbhdG32MmKwxfMPphOcjAqqbq2t8eZo2wfAQrMg/dmwWXxdogpAUoBJE7zSENbTOpQng==
X-Gm-Message-State: AOJu0YxAQCMWJiIphFpfEgeaNzPrVBR8g3At520QLHYZxFIPrQatKdMe
	io862AFjkWb1Uu2Xqj/1cr5MWUUTYUMM4J7oaT5E8ETJcANe+buUUasthi2qcINMyhrXE7FGdi4
	4pcWMMERK1ZuXiVYZs4lH5r9sImM=
X-Google-Smtp-Source: AGHT+IEp4Yj1kWediwy97HZIkIJVGhqp3U4oQXnlyVq/44GG2xbedKNyvZGtdMFmVVFO1CpKrFR9EsAIgtUkRwDMnUY=
X-Received: by 2002:a05:6870:65a0:b0:229:ee6d:77da with SMTP id
 fp32-20020a05687065a000b00229ee6d77damr9425596oab.2.1711451925292; Tue, 26
 Mar 2024 04:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320180302.143707-1-arnd@kernel.org> <65fb3fee96ec7_aa222949b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <CAJZ5v0ivpUuKGx9pW+QeQPSSXNWSSbJwN2oN9p_hmE-nV5VQKA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ivpUuKGx9pW+QeQPSSXNWSSbJwN2oN9p_hmE-nV5VQKA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Mar 2024 12:18:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iKbquyA8st=ywUd+WtcJ0A3FYDuhCqSq_3B_koi0RYXg@mail.gmail.com>
Message-ID: <CAJZ5v0iKbquyA8st=ywUd+WtcJ0A3FYDuhCqSq_3B_koi0RYXg@mail.gmail.com>
Subject: Re: [PATCH] acpi: EINJ: mark remove callback as non-__exit
To: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Avadhut Naik <Avadhut.Naik@amd.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 9:00=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Mar 20, 2024 at 8:58=E2=80=AFPM Dan Williams <dan.j.williams@inte=
l.com> wrote:
> >
> > Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > The remove callback of a device is called whenever it is unbound,
> > > which may happen during runtime e.g. through sysfs, so this is not
> > > allowed to be dropped from the binary:
> > >
> > > WARNING: modpost: vmlinux: section mismatch in reference: einj_driver=
+0x8 (section: .data) -> einj_remove (section: .exit.text)
> > > ERROR: modpost: Section mismatches detected.
> > >
> > > Remove that annotation.
> >
> > Looks good, not sure why the build robots missed this while this was
> > sitting in -next. Yes, this was a side effect of reusing the former
> > einj_exit() as the device remove callback.
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >
> > Rafael, can you pick this up?
>
> I will, thanks!

Applied now, thanks!

