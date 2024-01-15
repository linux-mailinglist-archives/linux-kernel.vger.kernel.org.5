Return-Path: <linux-kernel+bounces-26033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE0682DA2D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EABCE1C21865
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B0A171BF;
	Mon, 15 Jan 2024 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="V5GiTUoY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D5917543;
	Mon, 15 Jan 2024 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4455B40E01A9;
	Mon, 15 Jan 2024 13:34:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Oa5bjbg3mu8O; Mon, 15 Jan 2024 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1705325657; bh=67halwUYkwEtIEMK/7EejoC0n1IsXerTwoWSSrGNLE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5GiTUoYKMi4a0y18jMfa9A4ExSqn8mTzrzLOQf+Td7ujsAJwkvQNyNSODlJVRRkv
	 a99TUAi1Oi5O936lSg1y4j//5MzDj51j1lkXJ+uqQ7h79zz6vflnWpt+lnrJ3wCaKk
	 cYMnQe4ZQ6YPO2g+oHh01JM5P2JzaZTMBALnHQ/2GDyOpFTQyvuuWvf3puidluAptG
	 YAiKbITvlXluuezUIl1FMwcsZLYdtZrBaNDwLW/bzNPvIjPSQxqv8y3o7LuLznhxjT
	 AOybizNOGexkKU7SbPSlTKUC+5iQ0/XVENWld3+u6+7j1P6sBjiYmsk0K+tST6x9PT
	 9JaEkYZadJu7YESK3fMp4DHqa68MNP2bjZ+yw49OU2y4HGhqws/elT9LBj1dk+8Wv5
	 fKjL20kbinNRwh1j3F3pLBMsgzKLzS21x5fRvW1N+eohQ2MiVl6BdwNsGB7Mdtxpvf
	 Xkz/SSDGNEIlo/eBG6ZpITCdC1Yg3j5Uova+k7RRKq3LZ9lW3ERPmawTvdRRLH3qeu
	 p9ovZIF22h/WJ5GcK5WRSumL33YgwDP0NySPdZDbUA9noAx9Miz4gFrtDDAqt9Qnlf
	 rMGTHMJkbkY4hjUmm3uIkcqnvQ1qb4BJO4KXWafLEJdJfmFzjdwzFUdGQAf3NMN80v
	 x9Bg4dvIm5nY2JmATMDn/+hA=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4061340E016C;
	Mon, 15 Jan 2024 13:34:01 +0000 (UTC)
Date: Mon, 15 Jan 2024 14:33:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Tong Tiangen <tongtiangen@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-mm@kvack.org, Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v4 0/3] minor improvements for x86 mce processing
Message-ID: <20240115133354.GFZaU0Qk2lYmMSkwM9@fat_crate.local>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
 <e453b190-d387-4b74-bb2c-fbbd2a5c488d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e453b190-d387-4b74-bb2c-fbbd2a5c488d@huawei.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 09:25:57PM +0800, Kefeng Wang wrote:
> could you give us some comments about it, many thanks.

Since we have a (suspended=C2=B9) merge window currently:

From: Documentation/process/maintainer-tip.rst

Merge window
^^^^^^^^^^^^

Please do not expect large patch series to be handled during the merge
window or even during the week before.  Such patches should be submitted =
in
mergeable state *at* *least* a week before the merge window opens.
Exceptions are made for bug fixes and *sometimes* for small standalone
drivers for new hardware or minimally invasive patches for hardware
enablement.

During the merge window, the maintainers instead focus on following the
upstream changes, fixing merge window fallout, collecting bug fixes, and
allowing themselves a breath. Please respect that.

The release candidate -rc1 is the starting point for new patches to be
applied which are targeted for the next merge window.

=C2=B9 https://lore.kernel.org/r/CAHk-=3DwjMWpmXtKeiN__vnNO4TcttZR-8dVvd_=
oBq%2BhjeSsWUwg@mail.gmail.com

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

