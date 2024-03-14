Return-Path: <linux-kernel+bounces-103218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4890387BC82
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514661C20CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297136F086;
	Thu, 14 Mar 2024 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RBD3ucM4"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7011F2A1D1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710418108; cv=none; b=Q+8ozQrKRyAZEaSqXCzX0prmU35ry6AMfY7Mx78oR12HPUtuBo2RK3EEBsfhpwN870M7eYW1JkBqShZNOovdoXSi8jVbKhXWcHkkFFFlAiErSeVsff8i/DQtnnKodkN51QSzuTNIV68DXfIHJfRRLzaD9v472nRJl3098t+HeJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710418108; c=relaxed/simple;
	bh=87uP8oEYL3f2ij7QYXwCxHx44HENNcaMzXars/E0xg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mdk9uwXFYrCYA4AWXVZ5OEObkVFJxs3KjxkOFuT0G+CJaAVwgIZ7xiwzOnPhafTEltRZIEhQ+9yXK6udnfBIp+K/bVH64szNHaOLAWAPI6rSv4D4OBNIzHdXjFl3WbgMbO7CdMFjsPIF7z/o/OU/9vqVCpEzpNlGRR60DbKi7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RBD3ucM4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B455840E0174;
	Thu, 14 Mar 2024 12:08:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZsZY8AkmAoD8; Thu, 14 Mar 2024 12:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710418100; bh=zNtuTeS9qes33qsFVye1Oybb6j0XFIdSwIB4GsdgiDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBD3ucM4L85fB2p8bZDLPnfGrjiN5hhkK4WBEN+DVvBO0qYXAGs9RZ08krk+79nkC
	 mbFiFHw5wnk7zS8Qwhed+xUebv2qwiLW19mI2bxHVsjMq5wxjXDiH8MhnhKOlYNdHr
	 ER6j0xZvM8JbQvS8HlRQ4wq+uBJfiWglOffwamZkZ945sljNUOCSDPPdRpk3Cl40SH
	 hHLMo6+KZijd7ua7VROxyZ62vQ/R71H6rl9wqEQrmViiBCu60xR2l8650N0ezoDDtu
	 3QBAusX2IAXhfWsayzAEsdkqe/VIDNSHQ2NHG3JhIGlxpFS77muEf+8AtpsCH19MLG
	 kVUkR6ce/Yu7IeIhdD5DTC20LLMcevcpo9y7rclWAXa5N7y13SDvb66xRkJcAfaciK
	 2cwHLodnyJD0kh8SZFGmu80ND6F5L2FpPelpY4O4c03PYObnaAxlQ2HD2PmtNT4O2d
	 NXgMwXmTkrH9qYJCu6NJMJxmw5lJ1byLNRSO3XKdu+OWt/6Y8N6y4tmE0N6TVmARct
	 zvhZ5LyEw0OwOquh/e9ePGW0PUtA+hV8rDelSLs4suvhqQYAULt4w7AD43qLkmspxJ
	 xUD5nCsLiXlPZqgJ5AngXqEqpf37L/1CAhN8mLCnWe+OHVXEUGhrSUsCTsmu/omc2K
	 4sxPI6eRl1OTgR6R/w82eyRQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A3F6E40E0028;
	Thu, 14 Mar 2024 12:08:00 +0000 (UTC)
Date: Thu, 14 Mar 2024 13:07:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"andy@infradead.org" <andy@infradead.org>,
	"arjan@linux.intel.com" <arjan@linux.intel.com>,
	"dimitri.sivanich@hpe.com" <dimitri.sivanich@hpe.com>,
	"feng.tang@intel.com" <feng.tang@intel.com>,
	"jgross@suse.com" <jgross@suse.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"ray.huang@amd.com" <ray.huang@amd.com>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>,
	"sohil.mehta@intel.com" <sohil.mehta@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"wendy.wang@intel.com" <wendy.wang@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [patch V6 11/19] x86/cpu: Use common topology code for AMD
Message-ID: <20240314120755.GCZfLom-s2D2uwleOc@fat_crate.local>
References: <PUZPR04MB63168AC442C12627E827368581292@PUZPR04MB6316.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PUZPR04MB63168AC442C12627E827368581292@PUZPR04MB6316.apcprd04.prod.outlook.com>

On Thu, Mar 14, 2024 at 10:21:34AM +0000, Yuezhang.Mo@sony.com wrote:
> I ran xfstests generic/650 and found that it failed.
> 
> The reason for the failure is that this appears in dmesg:

Can you send - privately is fine too - from that machine:

* output of "cpuid -r"

* full dmesg

* output of "grep -r . /sys/kernel/debug/x86/topo/"

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

