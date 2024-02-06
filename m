Return-Path: <linux-kernel+bounces-54539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8920C84B07A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023FD1F21E36
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2BE12C7E9;
	Tue,  6 Feb 2024 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="bAj/eEVD";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="bAj/eEVD"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4E712AAD6;
	Tue,  6 Feb 2024 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209876; cv=none; b=qh6y6TseXKPmwZeGFbqtThCBBCLHcjcb16ymEmXy/QI5udE2+3OC9F+63dWVHp8YzQ0sPB3CWBjccsd0bD7+e6a3BGKVYonf2xrBJtJ4SG7ahCsLOWvbUjkWXqEZ58By+Mz68sMXT04XFTGq7cVwKCCPg78sEDVXOIrnccs37u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209876; c=relaxed/simple;
	bh=zWlDDsNgIAFDlXYYsMxg8m2uMuE5A3i7ukXkyc7rkmk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i+F7OD4y6fjjOmlJk+AaBkF55xXuUeqiBlYDO6Up1yyCpz7yUH+YAuVq4VQCuamzFGzA/fDxBg9S6N7tLDnNK5IBJAgmw564CGh/pj41kTW3XTERf4fMN76U1zgOb0NQGxarKXqin7kJDdLxXKQALF5nuZ47JnRurCSZoXtvLdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=bAj/eEVD; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=bAj/eEVD; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707209870;
	bh=zWlDDsNgIAFDlXYYsMxg8m2uMuE5A3i7ukXkyc7rkmk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=bAj/eEVDl+krx60izBrMvuGrvvbwH7kqpwEpjRbmw0l4mNM9BpIIM/dsrJWjObozA
	 X/6sgC+gHUgoOPGQIctMApODGluk3b61I4871jrX/xVi7C50sRSz1fa0pyaXZuNSjb
	 XcCmg6VfI917qlT7tgV7kyoXdfvb4LPRLOZXbPfk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 755F21286825;
	Tue,  6 Feb 2024 03:57:50 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id jeBuSS9UoaOe; Tue,  6 Feb 2024 03:57:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707209870;
	bh=zWlDDsNgIAFDlXYYsMxg8m2uMuE5A3i7ukXkyc7rkmk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=bAj/eEVDl+krx60izBrMvuGrvvbwH7kqpwEpjRbmw0l4mNM9BpIIM/dsrJWjObozA
	 X/6sgC+gHUgoOPGQIctMApODGluk3b61I4871jrX/xVi7C50sRSz1fa0pyaXZuNSjb
	 XcCmg6VfI917qlT7tgV7kyoXdfvb4LPRLOZXbPfk=
Received: from [192.168.28.110] (unknown [151.2.154.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id F0FE91286815;
	Tue,  6 Feb 2024 03:57:47 -0500 (EST)
Message-ID: <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Xing, Cedric" <cedric.xing@intel.com>, Kuppuswamy Sathyanarayanan
	 <sathyanarayanan.kuppuswamy@linux.intel.com>, Dan Middleton
	 <dan.middleton@linux.intel.com>, Samuel Ortiz <sameo@rivosinc.com>, Dan
	Williams <dan.j.williams@intel.com>
Cc: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>, 
 Dionna Amalie Glaze <dionnaglaze@google.com>, biao.lu@intel.com,
 linux-coco@lists.linux.dev,  linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 06 Feb 2024 08:57:45 +0000
In-Reply-To: <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
	 <c17a31e4fb30f5f9d4a337e5bd8d54cc6f99eef7.camel@HansenPartnership.com>
	 <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
	 <42e14f74d3819c95fdb97cd2e9b2829dcb1b1563.camel@HansenPartnership.com>
	 <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com>
	 <85b7a4a679eada1d17b311bf004c2d9e18ab5cd3.camel@HansenPartnership.com>
	 <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-02-06 at 00:34 -0800, Xing, Cedric wrote:
[...]
> I'm not familiar with existing TPM code. Per 
> https://elixir.free-electrons.com/linux/latest/source/drivers/char/tpm/tpm-interface.c#L314
> ,
> tpm_pcr_extend() doesn't seem to take/log the actual event, but only 
> extends the PCR.

That's the low level code we build on.  The TPM doesn't maintain a log
at all, just the measuring entity.

>  IMA seems to maintain the measurement list/log by itself.

It does, yes.

>  Am I right? If so, why do we want logging to be part of TSM
> here?

Well, as I said above: without a log you have a combinatoric explosion
of events that lead to the PCR value.

> For measured boots, I think UEFI BIOS has already maintained a log so
> what's needed here is just to expose the log somewhere in sysfs.
> IMHO, I don't think logging is even necessary because everything in
> the boot flow is static, hence a relying party can simply compare
> measurement registers against known good values without looking at
> any log. But please correct me if I have missed anything.

Without the log the UEFI boot flow is way too brittle because
measurements aren't actually static and without knowing what happened
you can't reproduce the PCR value.  It was actually the earliest
insight from the keylime project that it couldn't just define state by
PCR values and had to parse the log instead.

> > If you have a kernel backed log, the ABI for extending it should be
> > where you get the PCR extensions from, that way nothing can go
> > wrong. An API to extend the PCRs separately will only cause pain
> > for people who get it wrong (and lead to ordering issues if more
> > than one thing wants to add to the log, which they will do because
> > neither the TPM nor the RTMRs have enough registers to do one per
> > process that wants to use it if this becomes popular).
> > 
> There's an easy way to solve the synchronization problem in user mode
> by applying flock() on the log file - i.e., a process can extend a 
> measurement register only when holding an exclusive lock on the 
> corresponding log file.

Which would be where exactly? and owned by whom?

>  A possible drawback is it'd allow a malicious
> process to starve all other processes by holding the lock forever, or
> to mess up the log file content intentionally. But that shouldn't be
> a practical problem because the existence of such malicious processes
> would have rendered the CVM untrustworthy anyway - i.e., should the
> CVM still be able to generate a valid attestation, that would only
> lead to a distrust decision by any sane relying party.
> 
> IMHO, if something can be easily solved in user mode, probably it 
> shouldn't be solved in kernel mode.

There isn't really anything more complex about an interface that takes
a log entry, and does the record an extend, than an interface which
takes a PCR extension value.  So best practice would say that you
should create the ABI that you can't get wrong (log and record) rather
than creating one that causes additional problems for userspace.

James


