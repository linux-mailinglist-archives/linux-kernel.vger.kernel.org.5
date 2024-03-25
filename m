Return-Path: <linux-kernel+bounces-117959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B1D88B1CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED15324AD2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351B75A4D4;
	Mon, 25 Mar 2024 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhZ+MvtY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F259B6C;
	Mon, 25 Mar 2024 20:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399359; cv=none; b=hBj3ok6jVROBNwRayMSWjvy+4/uXc7SSWEGb0cULSWVmHAY7l3Zci/NaUZ3EYbS0lQ0MO2riXTi/8exisLEylG7RIci62lbCx9FUM7wNwi+7yD5WDcsAuwsfsESzCuQ5/WOJVAWfGtq4V4ERf5by6BLLZ91TK8e8zgoxWK9fRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399359; c=relaxed/simple;
	bh=ygDBcH5zVAYII6sXhBLSOiW+myqvVjm/BPO9+LnLjmc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=kRu8V/HxMsxxbusANHSBc9bvX9iyawHNAfv0zotBnMoBSETAoh6wZ+YDWbEHdGAHpyPOCaLR/lLWMSSIWDzMBft5sl6502TN1dFJ1123q9CpPs2wi+ZdRDJIuiKdi4cHKziH+KaqF701Me3IQt7NAl0vgSTGQH4CVgG+trpAdiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhZ+MvtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB16C433C7;
	Mon, 25 Mar 2024 20:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711399359;
	bh=ygDBcH5zVAYII6sXhBLSOiW+myqvVjm/BPO9+LnLjmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OhZ+MvtYCstCIuxVRYzQ8FexYu/4uM0L3OgJ/Ttw/5qqFtiOBZ1xTzFD3va+NfBn9
	 LVquBM1RoB3rdMc8BZ1tceiZfRmPkJo8Vbzow4hnQ14UX/F8J8MWFFuy3wPO4rjZiy
	 o9ZBAD+uP0hOwEPV2sGpJ2z4RQtdtAbw5vWypzCFdFjC3vDa2jbhpK0SdornUGy7tt
	 KGeu6ZwhY3juf26d5nfDhB2nKJ6uA9wdqmZv2v/1l3vc2dkYZ3HC0OoKY4yZfkYyLS
	 ipfFfHQexkWHK0QXdrzrctbJvBYUnqQZky6K4PwDwGSWCIxfL5nSUXC7mQwR85Esw1
	 AEPogmNFCnG6g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Mar 2024 22:42:35 +0200
Message-Id: <D034FU5LXNT8.2QCBIDTQRB2S6@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-riscv@lists.infradead.org>
Cc: "Paul Walmsley" <paul.walmsley@sifive.com>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 <linux-kernel@vger.kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>,
 <linux-modules@vger.kernel.org>, "Naveen N . Rao"
 <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 "Masami Hiramatsu" <mhiramat@kernel.org>
Subject: Re: [PATCH v3 2/2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
X-Mailer: aerc 0.17.0
References: <20240325203755.1811-1-jarkko@kernel.org>
 <20240325203755.1811-2-jarkko@kernel.org>
In-Reply-To: <20240325203755.1811-2-jarkko@kernel.org>

On Mon Mar 25, 2024 at 10:37 PM EET, Jarkko Sakkinen wrote:
> Tacing with kprobes while running a monolithic kernel is currently
> impossible due the kernel module allocator dependency.
>
> Address the issue by implementing textmem API for RISC-V.
>
> Link: https://www.sochub.fi # for power on testing new SoC's with a minim=
al stack
> Link: https://lore.kernel.org/all/20220608000014.3054333-1-jarkko@profian=
com/ # continuation
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

I think that for any use case it is best for overall good to realize it
like this. I.e. only create patch sets related to the topic that change
behavior for arch's that are in your heavy use. For me that mean x86
and RISC-V.

That is why I shrinked this from to focus into more narrow scope.

For microarch's more alien to one, it is just too easy to make sloppy
mistakes, which could cause unwanted harm. E.g. it is for best of
arch/sh that someone involved with that microarchitecture does later
on the shenanigans.

BR, Jarkko

