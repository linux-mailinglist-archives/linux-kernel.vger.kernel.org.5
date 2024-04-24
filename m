Return-Path: <linux-kernel+bounces-157420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C778B1171
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838241F27BCD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E3316D4E9;
	Wed, 24 Apr 2024 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDmgGL6x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07216D4DD;
	Wed, 24 Apr 2024 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980871; cv=none; b=lyLk/PdhDr3kkvu0/VyCN85F/aa6tSKG1fwAiYwSRmidqo+j6ZFtO1CxI0dqH9WTBCP3hzHOlju5Bg0HvvvQqgk+Waq3QcO7bs/UQVGDcjkZ2MFK0yPWMTKUNhQH3MWcA9TyHuy0SLWOhpeWcRxokRKFB38RqPxE6YXBHAlbHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980871; c=relaxed/simple;
	bh=a+n74rxaOF4+DkOVqzem1w9+0wK2gMczlxpyXMAMSc4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=DwSb5lsM0eh5OPTyX9NlarU3zDJikjKJKWn5ds3qQe35onXnWLiLyLgdE3gj4spWnh/96Bb09PW/qgkv/g8qDHSLrxvdi/dC+kocrXY98e6bmttXfFVKOtoiIOByLAEAix76gr31j24DtNwr3L7Ch5JUNdmeePOZDH6DNLY8zns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDmgGL6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68F1C113CD;
	Wed, 24 Apr 2024 17:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713980870;
	bh=a+n74rxaOF4+DkOVqzem1w9+0wK2gMczlxpyXMAMSc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDmgGL6xi8606me5qaR5+4uSai8DhMTbeOnm3XCe7aV4lCga+EFQEs19L3ofUS3ga
	 vHoELpWL6BPdv+faFoP8NpGx+JXmlRWWqdM8nVCLH29wuQa+knkAaZ1efDTBuBtipz
	 yeGM2Z9vV3jI58juoQbJfd6e0AWgrkQpAqu2aeF0bTf0ZEIOOstkiRVxd3vr+Rwpwv
	 sMRn3Mr2P88U0JN98Zn9/PGwFes6UCa4GXLOppD7MA5BhOT9QDPa1sYJ2i34OQFuZm
	 Z+DQBrhS+8NXgPkKmsqo8QYtWg4cLy0c+/DqtsLtpPXllDC+tUiju86gZaci+5F8tP
	 b06pL4HGFRHHg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Apr 2024 20:47:46 +0300
Message-Id: <D0SJIC3GSSKA.3S3RTNVWC55TB@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Bojun Zhu"
 <zhubojun.zbj@antgroup.com>
Cc: "Huang, Kai" <kai.huang@intel.com>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, =?utf-8?b?5YiY5Y+MKOi9qeWxuSk=?=
 <ls123674@antgroup.com>, "Chatre, Reinette" <reinette.chatre@intel.com>
Subject: Re: [RFC PATCH 1/1] x86/sgx: Explicitly give up the CPU in EDMM's
 ioctl() to avoid softlockup
X-Mailer: aerc 0.17.0
References: <20240423092550.59297-1-zhubojun.zbj@antgroup.com>
 <20240423092550.59297-2-zhubojun.zbj@antgroup.com>
 <02fe00c3b10e4476d500ad7a34024b7eae5e3c97.camel@intel.com>
 <85dfbebc-a2d5-4828-b3b9-f929cd6e30cf@antgroup.com>
 <D0S5S2NL1N5P.3Q0SM01VIZBJX@kernel.org>
 <D0SAGP6DPKXF.2EHTXI9UH0HQ9@kernel.org>
 <D428BE51-20DA-42C5-A2B0-B264D7564700@antgroup.com>
 <D0SJFJIPUE1M.36M8JVVXO89YQ@kernel.org>
In-Reply-To: <D0SJFJIPUE1M.36M8JVVXO89YQ@kernel.org>

On Wed Apr 24, 2024 at 8:44 PM EEST, Jarkko Sakkinen wrote:
> On Wed Apr 24, 2024 at 2:50 PM EEST, Bojun Zhu wrote:
> > I still have some questions:
> >
> > It seems that the variable "ret" is set to 0 if there is **some** EPC p=
ages have been=20
> > added when interrupted by signal(Supposed that sgx_encl_add_page()=20
> > always returns successfully).
>
> Ah, ok.
>
> Returning zero is right thing to do because it also returns count of
> pages successfully added. I.e. the function does not guarantee that
> all pages are processsed but it does guarantee that the system is in
> predictable state.
>
> It could be that e.g. sgx_alloc_epc_page() calls fails.
>
> So, it is a bit like how read system call works.

Good that you asked that had rethink for a while.

What I would suggest that you just put out 2nd verson out and then we
see where it is going.

For sgx_ioc_encl_add_pages() it is important to maintain exact semantics
as we need to maintain backwards compatibility.

BR, Jarkko

