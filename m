Return-Path: <linux-kernel+bounces-48907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 758D6846316
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE825B21959
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1653FB26;
	Thu,  1 Feb 2024 22:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/FJId3R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A393EA73;
	Thu,  1 Feb 2024 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824967; cv=none; b=JBdb30UQfSeevTRel93vY4K+o1oU70Mnfbspa/JCsrCfhEUDMYLL3pmM8eFYSNK7TnN3PO1bJzRbawp5XTBCl7HnP0R68OMkyPMqrxFkl7vqG4QigUIvwvnDs6PKyrnJF6TQjXksosKQki29aPN16F2pNvHyHd+Xqeje3vIk3yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824967; c=relaxed/simple;
	bh=QiNfWmRaFs425HrmGWK3F+bpacxbRPm2xwsnX64FA8Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VDhoUZ034JJyBaehpstqyGCCQiDjW9PvQyCJN3JstYcTtXTdbmeOWQ/z35a972OPUp5AAydU9rULRtBX/SyYiSK30fmVU78KwxWUGzJyD4mabX/mG/ijrRvonYEBP7aJO3DAqqCcRmgzxSaSGBA2lFsX2W5nX+CesydwVLeYIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/FJId3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5B8C433C7;
	Thu,  1 Feb 2024 22:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706824966;
	bh=QiNfWmRaFs425HrmGWK3F+bpacxbRPm2xwsnX64FA8Q=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Y/FJId3RPFGnOsy5WCk4US14TJujegs9EmwDK/7fUB7Ua5L0Q13q3eQR2WagTHyjm
	 vYEvGEPEqd1WQ2Cs82aMiAWuDFkcM7tan/CSID4finnSe6Ccxh/nTYpR1AMchinJmD
	 QZbBvqBU36C0Dv/Z87ShjBxs+iXhwoq+JjaG5j1dDZN1KdIhgfettcLK/3EbB69gB3
	 q9PxMXfskRB4mjWQs43rz/5UwRHQ0pfGs6bftyMII/JjjUU1T1U456eD70Ed3VSErq
	 0eO5b2np2wgd7Pr2MDBQ5Oyo8KPpbg99HnK41gXQrB8PCSPBJA0p63lh2zSDD++a13
	 WGIRCyCXdZQBA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 00:02:42 +0200
Message-Id: <CYU2YB3KWV7V.1NHLFEN71HC3N@suppilovahvero>
Cc: "Kuppuswamy Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>, "Qinkun Bao"
 <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>, "Xing, Cedric"
 <cedric.xing@intel.com>, "Dionna Amalie Glaze" <dionnaglaze@google.com>,
 <biao.lu@intel.com>, <linux-coco@lists.linux.dev>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Samuel Ortiz" <sameo@rivosinc.com>, "Dan Williams"
 <dan.j.williams@intel.com>
X-Mailer: aerc 0.15.2
References: <20240128212532.2754325-1-sameo@rivosinc.com>
In-Reply-To: <20240128212532.2754325-1-sameo@rivosinc.com>

On Sun Jan 28, 2024 at 11:25 PM EET, Samuel Ortiz wrote:
> Some confidential computing architectures (Intel TDX, ARM CCA, RISC-V
> CoVE) provide their guests with a set of measurements registers that can
> be extended at runtime, i.e. after the initial, host-initiated
> measurements of the TVM are finalized. Those runtime measurement
> registers (RTMR) are isolated from the host accessible ones but TSMs
> include them in their signed attestation reports.

Please expand "TSM" acronym and explain what it is.

> All architectures supporting RTMRs expose a similar interface to their

Please expand RTMR *everywhere* ot "measurement registers". It is
totally useless terminology.

> TVMs: An extension command/call that takes a measurement value and an

What is TVM?

> RTMR index to extend it with, and a readback command for reading an RTMR
> value back (taking an RTMR index as an argument as well). This patch seri=
es
> builds an architecture agnostic, configfs-based ABI for userspace to exte=
nd
> and read RTMR values back. It extends the current TSM ops structure and
> each confidential computing architecture can implement this extension to
> provide RTMR support.

This patch set should simplify its gibberish terminology to common
language.

BR, Jarkko

