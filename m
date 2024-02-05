Return-Path: <linux-kernel+bounces-53089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 245D384A08A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FFE1C22276
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E14844C91;
	Mon,  5 Feb 2024 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Fo4cC1jD"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5F445949;
	Mon,  5 Feb 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153696; cv=none; b=N79zMzhhlAQjn/zwcvkznvYg9YNgL/SSxQtHDcRO/S+5rDgLyOKnGTO8+NOugI4faVt9EHv8ic44CxN/LCu14E77ZtT1nphV1fNZLLHpborDOAxgmlkJFAdyGe1cFrq/zZ/ca+PSvXG5IvmkIdh2QggYth1xvLG9ogYC2wtQ320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153696; c=relaxed/simple;
	bh=ea63PLwNl5FqbQxrrg0hqVQX7rjVFV72BlE5+I4cLi4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KTK0mjm38jAmbSDBw6N5+KM7P83T+pgdIbIx1QFySXpob+Et8i3Nao8whpvO6cY63PBHbIBmlbnRzN4DEH1gtPel+6lhMnoS2M/pfTQfLJK4qlJQwm8q9poI4YkSaYmekIt/KTDcAHrmNXs3lmDeA3KrhyOwpLgbYKdfFeO8bdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Fo4cC1jD; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E71F745ACA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707153692; bh=oUb/ZU0m956j09lY1gorLyKNp+KeEuERLzbirHHa85U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Fo4cC1jDMUuD6qduIUoKQnuDFwgP0txmSggZ9PXwf1J78xx8mmvxLKquPfJDLbzPQ
	 RPI2vYUb9npi5wdHHpyqMeCOoC4WmUFnLLA0Iy/jdiix8ZH8V3NqsEDN+/zabhumNz
	 WZG7IKrW5R7JM4ImER0DV58CLThf26geHBITzvSqZ99ddz4cjkQflKgYtDptXVGiJV
	 3ZeR0KFFt0MuoIOkwAFh3CFKso2sKmXioYuunnLjpXIIDyiLzYAMXQ2677R9H5WCj0
	 0MJaofuZZomnnXzZksj7jTvJ4BQImDHRDfIFAmFIwuLYA3QoLs1wixRlTQ4Nfn3CNi
	 FEMgHD3exuXqQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E71F745ACA;
	Mon,  5 Feb 2024 17:21:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 rdunlap@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, kernel@gpiccoli.net,
 kernel-dev@igalia.com, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Changwoo Min <changwoo@igalia.com>
Subject: Re: [PATCH] docs: Document possible_cpus parameter
In-Reply-To: <20240203152208.1461293-1-gpiccoli@igalia.com>
References: <20240203152208.1461293-1-gpiccoli@igalia.com>
Date: Mon, 05 Feb 2024 10:21:31 -0700
Message-ID: <87h6imvnc4.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:

> The number of possible CPUs is set be kernel in early boot time through
> some discovery mechanisms, like ACPI in x86. We have a parameter both
> in x86 and S390 to override that - there are some cases of BIOSes exposing
> more possible CPUs than the available ones, so this parameter is a good
> testing mechanism, but for some reason wasn't mentioned so far in the
> kernel parameters guide - let's fix that.
>
> Cc: Changwoo Min <changwoo@igalia.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

jon

