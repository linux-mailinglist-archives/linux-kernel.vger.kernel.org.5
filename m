Return-Path: <linux-kernel+bounces-46601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21268441D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210F01C2211C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65DC84A53;
	Wed, 31 Jan 2024 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="AWs9MlCU"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C5B82897;
	Wed, 31 Jan 2024 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711127; cv=none; b=nYagDrdFN+gpIfRCg9HfX6mMbPuCSFtN66zkEjxKKtNMkq3rFe3ENLDIMGiaBawqEbsTZogbUSoRewEmKcUnKCM2Oz2MgoJHnStfQqGMd6f84E2emYXmM8Vj72MJCup5B2yK1sqhgvdUU4eKlTcfLWY+p/sQKjNpehdiwAxrwnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711127; c=relaxed/simple;
	bh=jSLcBRT/JBS3CuOSt5RIMTpse8yunC2EQvSqCC8NviE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qk5Y/PC5V9Zo9YMNIicZFr74FZt4oTWfkM1wlXLzKFt8I+4VO5cBen0LD6X7/Wvb+JGVXPqHwmtRy5WMIbeVwU2BOCWU+mvMvqKlG19HkSSXfPTY8J+bqCERSUFJ2y4i5ANKyRXEuFdWXBUDlPDhozCVPO/3h8Hyhelw5EMICP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=AWs9MlCU; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3BBFC47AA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706711119; bh=FEM/DbaFWYJWTHsxmCC7qANz8rbrQnNBM98qBCXz9Ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AWs9MlCUOEfbI/IsoUFloM0XlMFsobTu6eOTm66RoXzm3C3Dq7GCqgRfgYOpBTcSm
	 jbmUTm16iEVfbgnO9Vu3Ud3aApvrrwDI/Frunb/CYzD0wd8oQJM/v4kMvjI7fWwyoE
	 33hb3z10vR2T80Wrf6zuzNzdy/greRRxycDwBZVzHqYsenQDQREzugY1VVXIoYIam4
	 EQNmmDFLbqB4OzW0Mzgcz3PCa6LkkngncGSdv9dtTBQobjruRWo4BFOP8Xu3YerE/Z
	 Oakyd24otlM021WOYocT9BTreYu2f9/r4oYojBk3cLfaQkQD88lQ+3C1F1h+zfFn7B
	 H9GOeLQytsE3w==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3BBFC47AA8;
	Wed, 31 Jan 2024 14:25:19 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Bartosz Golaszewski
 <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson
 <warthog618@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the gpio-brgl tree with the jc_docs
 tree
In-Reply-To: <20240131115838.4af8131c@canb.auug.org.au>
References: <20240131115838.4af8131c@canb.auug.org.au>
Date: Wed, 31 Jan 2024 07:25:18 -0700
Message-ID: <87r0hx7f75.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Today's linux-next merge of the gpio-brgl tree got a conflict in:
>
>   Documentation/userspace-api/index.rst
>
> between commit:
>
>   8722435d325b ("docs: rework the userspace-api top page")
>
> from the jc_docs tree and commit:
>
>   32a0a0da530e ("Documentation: gpio: add chardev userspace API documentation")
>
> from the gpio-brgl tree.
>
> I fixed it up (see below) and can carry the fix as necessary.

That seems like a fine fix.  Part of the purpose of the userspace-api
reorg was to, hopefully, reduce the frequency of these conflicts going
forward...

Thanks,

jon

