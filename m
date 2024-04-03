Return-Path: <linux-kernel+bounces-129691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487F2896E80
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41791F2163B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B1714389D;
	Wed,  3 Apr 2024 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHHcIyW9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA3573506;
	Wed,  3 Apr 2024 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145091; cv=none; b=PpRmOGGrmCNb8i0BGfG1hc/Hsc9ARnSUEVYYGRPJpYEXXO5KQ+8GhFjl58qi8gOE3IGya4jagmiidJYcwbXs4lMl9/T8M+CxiYXjxlvFqjo/IYmtIq0cBFsskizLlYNtWNXkawmP9g+L/cTZ5tSihfPveMcP+mmwuhdw4m+iqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145091; c=relaxed/simple;
	bh=XlAG1mEPljxo5vG2IKqYuNqmgp2p50tEKUNOCO2+Tr0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KxVthcjizTEGYIz+Hnsqm0G1PZCcAz4hjsxZ/IJXGu6xP22j+zEnzd2OlI0sFgcXKnfwELMnEbZ36lkptIl/44ml3Ezbpf7EAhvTdYhWcmF9muLeO5Co0+Iwrz3fmueAQA83Kn30JtipuOoSY5ASOK77H4lIazgJ7X3VFnylopE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHHcIyW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE38C433C7;
	Wed,  3 Apr 2024 11:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712145091;
	bh=XlAG1mEPljxo5vG2IKqYuNqmgp2p50tEKUNOCO2+Tr0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=MHHcIyW921pqNb3RodYeBp5JKnRi6C0O3djSxTGfY+qJ5b3kKO7sQuC9O9nc/RZPB
	 H9qyYFXwAQnsdPKTrE71QtNq9EwUb0r6KAewAHtUEMqyK+eJZSHv4efAeISKD/M83X
	 yrdQX9eJohN6MdYWUUI6sTHSe+V0Db5Y6hf2FZ44WCJlWIasfmVAw/3CgZW3hE6E7O
	 mqbW2kgT3IA3qakXfnnGGPWs4pNXrF+K3zgoQuo71smbHMz79mkhG5MNnsp+h6ZTVM
	 X3IHCBaxe2LB09fX45PN6S+5P+WYPyPUQb9oqOiwLc6TO8ch6tfC+2EUXidM5jTudP
	 U/S8wRyqPG2gg==
Date: Wed, 3 Apr 2024 13:51:28 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] HID: uclogic: Expose firmware name
In-Reply-To: <20240322100210.107152-2-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2404031351210.20263@cbobk.fhfr.pm>
References: <20240322100210.107152-1-jose.exposito89@gmail.com> <20240322100210.107152-2-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 22 Mar 2024, Jos=C3=A9 Exp=C3=B3sito wrote:

> Some vendors reuse the same product ID for different tablets, making it
> difficult for userspace to figure out which table is connected.
> While matching the device name has been used in the past by userspace to
> workaround this limitation, some devices have shown that this is not
> always a valid approach [1].
>=20
> However, if userspace could access the firmware version name, it would
> be possible to know which tablet is actually connected by matching it
> against a list of known firmware names [2].
>=20
> This patch exposes the firmware version name in the hid->uniq field.
>=20
> Link: https://github.com/linuxwacom/libwacom/issues/609  [1]
> Link: https://github.com/linuxwacom/libwacom/issues/610  [2]
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs


