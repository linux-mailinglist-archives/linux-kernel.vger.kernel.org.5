Return-Path: <linux-kernel+bounces-157417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9A88B1164
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E78ACB24470
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8381116D4E4;
	Wed, 24 Apr 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBwqcKuq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74C8143894;
	Wed, 24 Apr 2024 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980651; cv=none; b=Rxa0FanF6FV5JRbAL+P18qM2kYIj8A7wjBvJH1Pyx1GWyGcJdgdjbCmiW02s+7lXWhDdUApubbNBcGfP29PWNpEyDty21oKe38tRzNF3ZV+hLCQehLi90YEbiCozaBgMQY8+dj+Mh3gmGjAgMIekTeAbDhdFs74qnFxNnOnXCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980651; c=relaxed/simple;
	bh=eYVD8Z9xSvz2gs7A+pzr7wakcJaFEoHRpnTag60HIcs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=T/fNjfyDaKrmeab62G96zgSXVjQsAQpFNo6JHL1GXeNIk9pYJ+C9twKOxqA6K0xBEiXPv2iwCgknKraaoULkj4ixqFiFMSDCN0Qmlg4aenYyDSKq1rliPk+NMiwUO6IfIW97WrI/4syVLXSZQldmTxEtXwIoWP4VBeFVjlliDX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBwqcKuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF56C113CD;
	Wed, 24 Apr 2024 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713980651;
	bh=eYVD8Z9xSvz2gs7A+pzr7wakcJaFEoHRpnTag60HIcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBwqcKuqtuTIo4oBaFeYtzRMxoxT8t9KPqUuRqz6sS5VwZ24YPt4NBmbggEORjNzA
	 n0qdo6YmZT+q0JbZK8mvFsggbpLLU99wUUoEGBd91ZTb1Ptj/JJL4bhXIauQkPkYRu
	 /H1Yzn2braHG98Cm992HXC5iwiCEU4uTzxWZiVeWmOSCdmSt12HMB379YdDKk3PAIb
	 VSnZPbjiggDA+1AefkXozPnqYvPHI9R4Zha+gncyHaOmyMnbaVLAD/GCH1bJEviPAx
	 mw4vc4Iq6jw5xs8ljMFqTNIrKg/7AQtbroHaHlSmg8pGgO2lOZZNfu3AsfVKBbdEUJ
	 9Px4R+kD+8T3Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Apr 2024 20:44:07 +0300
Message-Id: <D0SJFJIPUE1M.36M8JVVXO89YQ@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Bojun Zhu" <zhubojun.zbj@antgroup.com>
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
In-Reply-To: <D428BE51-20DA-42C5-A2B0-B264D7564700@antgroup.com>

On Wed Apr 24, 2024 at 2:50 PM EEST, Bojun Zhu wrote:
> I still have some questions:
>
> It seems that the variable "ret" is set to 0 if there is **some** EPC pag=
es have been=20
> added when interrupted by signal(Supposed that sgx_encl_add_page()=20
> always returns successfully).

Ah, ok.

Returning zero is right thing to do because it also returns count of
pages successfully added. I.e. the function does not guarantee that
all pages are processsed but it does guarantee that the system is in
predictable state.

It could be that e.g. sgx_alloc_epc_page() calls fails.

So, it is a bit like how read system call works.

BR, Jarkko

