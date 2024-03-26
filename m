Return-Path: <linux-kernel+bounces-119538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F1888CA26
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E31E321C99
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88BD13D610;
	Tue, 26 Mar 2024 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUc5lWG6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3321613D510;
	Tue, 26 Mar 2024 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472560; cv=none; b=pVDljssNeCuHdMsUcpbOE61ZkzZYHE/oAhGJ6O44NqAwt9biFfh2iXUV+zRBXelscuGdsHb38ASMmmv45rWo08d5Q4DscoqGrXDhY9eqPIuMgioxRy7NhZyfcsaYGRkHp2dX13ykvi3H7wUeTfl184HfQhrZJpjgXQF6e5mlY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472560; c=relaxed/simple;
	bh=roKL18Iq6vEkeHwH/EmIDwPxZ0jMl/Uc5dYGgsfMSO4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QqEHEYdQPoN/CC0Hjw9jx2yOISK9aHRl38xnfaU1bGlrg8Xys65ArJCdLR5UcRMBtrZpfjvdESS+nSI0+Zc/fGrRkOaOF0LrDDpIkvbbXssKs2t0fg6H8xpScUT0iIKlbVDKbW37RzTTKpcLSjeltyKyKYzsxtoKxusLSNp94Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUc5lWG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8936DC433F1;
	Tue, 26 Mar 2024 17:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711472559;
	bh=roKL18Iq6vEkeHwH/EmIDwPxZ0jMl/Uc5dYGgsfMSO4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=PUc5lWG6y39nmrM45vLSsOBbCL4CcdaA+LLN2nagKsdktRigY3tIilFdMWrdn9zXV
	 TvJ9HQEgMnZS/vvz6R/NKKoog/u/LDZ2FpoyzvuJ0qVLk7LQbKVcutHzM0EeyjTNYv
	 jCgdCnkLv5DxUqY1d31ztmUZDB/jPuLlED0ADog9NSzHg25zYzCirF/cDZCNI668vk
	 g3kD+QVXmilX0K610SW1kxN1kV7GViAQ/uaMXHyoWRftQKD443K96LqGf3RFs9kHMq
	 BuT9lK7yHN4Z8vrA4rNjwx+ghcXLh9SO/gT+PUFImATK/osoVVOfJWsW87JMY79qdq
	 66RCM0Vsebosw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 19:02:35 +0200
Message-Id: <D03UDXV4OKIK.5HOOVU4LDW5D@kernel.org>
Cc: <linux-riscv@lists.infradead.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>, <linux-modules@vger.kernel.org>, "Naveen
 N . Rao" <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 1/2] kprobes: textmem API
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Masami Hiramatsu" <mhiramat@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240325215502.660-1-jarkko@kernel.org>
 <20240326095836.f43d259b7747269a7c0b9d23@kernel.org>
 <D03AL7A5G3M2.3UK4ASWILGBJS@kernel.org>
 <D03B7XJYRFC1.2L3I2TO5HNQD3@kernel.org>
 <D03PM9A6IS79.3D6BW7KBLH9C3@kernel.org>
 <20240327000520.ec13b2646ed1cd621e5b1d9d@kernel.org>
In-Reply-To: <20240327000520.ec13b2646ed1cd621e5b1d9d@kernel.org>

On Tue Mar 26, 2024 at 5:05 PM EET, Masami Hiramatsu (Google) wrote:
> > According to kconfig-language.txt:
> >=20
> > "select should be used with care. select will force a symbol to a value
> > without visiting the dependencies."
> >=20
> > So the problem here lies in KPROBES config entry using select statement
> > to pick ALLOC_EXECMEM. It will not take the depends on statement into
> > account and thus will allow to select kprobes without any allocator in
> > place.
>
> OK, in that case "depend on" is good.

Yeah, did not remember this at all. Only recalled when I started to
get linking errors when compiling just the first patch... It's a bit
uninituitive twist in kconfig :-)

BR, Jarkko

