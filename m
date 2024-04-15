Return-Path: <linux-kernel+bounces-145941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6138A5D19
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561B32864BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FA61586F3;
	Mon, 15 Apr 2024 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSjxWS+5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF2823CE;
	Mon, 15 Apr 2024 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217153; cv=none; b=jPHo7/V7iM1+zUnCyYofMeJyolFdVuiuNTzKCHxBUwKZJ/XzAEA4NO8Cz8IlcKS3g/TU+CAsEIG2Sxzn9GkAkOUMc+JHzRuQZ/UMbZ0NI5aLVLUDVwChwL0zn828Pcldgaofx4kCE9nNN/lNMpiqrQOe2hZVghs0EC8LS21sanQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217153; c=relaxed/simple;
	bh=humnfQnPK1rgJcqy6II8SICWwJj6C/MQ8EAQtW605Dg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pGxhiMn1aW+tnmYpl4gf+SGalCv6L3HJaPYZ4R+IvB5y77qbQKpHt7vYUOh15GB/BzleeZ+jEF+UsknolSZeU9jUY8Rc45qJP9jHHudyQf1aFwCggPURwVmKDI2eefkZGc3I1qwYr0+41/gEduIIM4fR9jA+je0FHIQj6+hbF+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSjxWS+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DD7C32781;
	Mon, 15 Apr 2024 21:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713217153;
	bh=humnfQnPK1rgJcqy6II8SICWwJj6C/MQ8EAQtW605Dg=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=RSjxWS+5reZxNnia7nWR2CzOBEb3jwK3ue6UExkY463XUI8u7q8u+BUOmtKBL8LXW
	 0lW196ngBfwPLQYcUL5pQ+3Bz3HOkiij1wvAzBmv7pmskZyGBwf12j/fGpfKRZs8Rg
	 oJj1LPzMCpuF/cg7febxdf49DcXjn5RYUKYlFnTKJndqq/6OPRvOke/NI8XiOfIFTF
	 OO0tw0vlcpXpXgB8iByqXAXnMO6HxEyN6eeJbHkF9gOvdxTo8u8tj0dG3K4qqiOXZ9
	 meLJSCxLmgMVBSilETegwUoAfXO7Rid6FdbZfJFpQE+wzNWP4nz0CzksQ+ecis+cBv
	 oePcbnlfT6LkA==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [kpsingh:static_calls] [security] 9e15595ed0:
 Kernel_panic-not_syncing:lsm_static_call_init-Ran_out_of_static_slots
From: KP Singh <kpsingh@kernel.org>
In-Reply-To: <0a4ebcd2-7772-4832-885d-221e0c6f6c04@schaufler-ca.com>
Date: Mon, 15 Apr 2024 23:39:08 +0200
Cc: Paul Moore <paul@paul-moore.com>,
 Andrii Nakryiko <andrii@kernel.org>,
 Kees Cook <keescook@chromium.org>,
 Song Liu <song@kernel.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 kernel test robot <oliver.sang@intel.com>,
 linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 lkp@intel.com,
 oe-lkp@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <11DA2A00-28F4-44F8-BBA7-012400FE1050@kernel.org>
References: <202404151225.ce542e38-lkp@intel.com>
 <757538DA-07A4-4332-BAFA-B864BFD06A76@kernel.org>
 <30876b80-c437-4916-b982-97c1a95c0747@I-love.SAKURA.ne.jp>
 <CAHC9VhS=hQuvv+Sw6cc2HwzcLApO7Rc3dAnqHytyzBpC1rokFA@mail.gmail.com>
 <CACYkzJ4G7hO0DNSBy4wpJG1PSgNkifuYcfOeTTpyVBtBtWvQSg@mail.gmail.com>
 <A9568514-FCB3-4715-9794-696383B2B7E8@kernel.org>
 <CD57788C-C9D6-4BA8-8352-90EBB6600D39@kernel.org>
 <0a4ebcd2-7772-4832-885d-221e0c6f6c04@schaufler-ca.com>
To: Casey Schaufler <casey@schaufler-ca.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 15 Apr 2024, at 22:54, Casey Schaufler <casey@schaufler-ca.com> =
wrote:
>=20
> On 4/15/2024 1:42 PM, KP Singh wrote:
>>=20
>>> On 15 Apr 2024, at 17:47, KP Singh <kpsingh@kernel.org> wrote:
>>>=20
>>>=20
>> [...]
>>=20
>>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>> On 2024/04/15 17:26, KP Singh wrote:
>>>>>> This seems like an odd config which does not enable STATIC_CALL, =
I am going to
>>>>>> make CONFIG_SECURITY depend on CONFIG_STATIC_CALL and make the =
dependency explicit.
>>>>> If CONFIG_SECURITY depends on CONFIG_STATIC_CALL, architectures =
which do not
>>>>> support CONFIG_STATIC_CALL can no longer use LSM ? That sounds a =
bad dependency.
>>>> Agreed.  If the arch doesn't support static calls we need a =
fallback
>>>> solution for the LSM that is no worse than what we have now, and
>>>> preferably would still solve the issue of the BPF hooks active even
>>>> where this is no BPF program attached.
>>> Actually I take it back, when CONFIG_STATIC_CALL is not available, =
the implementation falls back to an indirect call. This crash is =
unrelated, I will debug further and post back.
>> Apparently, when I smoke tested, I had CONFIG_IMA disabled so did not =
hit the bug. Well, now IMA is an LSM, so the following fixes it:
>=20
> You'll want CONFIG_EVM as well, I bet.

Indeed, thanks Casey!



