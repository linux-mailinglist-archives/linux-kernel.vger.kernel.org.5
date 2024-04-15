Return-Path: <linux-kernel+bounces-145483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A80108A56BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126C6283DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411A47CF16;
	Mon, 15 Apr 2024 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAZigk2V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826261D52B;
	Mon, 15 Apr 2024 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196068; cv=none; b=RAB57pIYW++bK1jMcfCgf4qrkjgzf2tFXXjPRwy74sNGlDNN0kUP7e8D3hsgAJ7QO+B27qao22It+yw5CslnM57zMOZr1jpigc+lxwnE8H8Ixx/kwow54Upx1cJAlj0X0zfM/F2eHSsE3ODcGDVXvpxO/hIJkm7LGGe/5E1M8vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196068; c=relaxed/simple;
	bh=LyrtEuKV9ZvjtcoP/1RDmpRdxB6ZNTui6MpsvktmFoY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=p271IIFct1Wgts6AlWOthj2PH1w2lJ32pJ01Wv4NEt1Sw7r8hKgJq30+eWOoT3thK1RN9uXPgFJ5z0gqRMldC4Y/MLA2HByKhOWe6y4WfpoV8ponjaolmSjoVQTm+SSxDAIHPrJDRUPXP1ab2PzGrexeOVxIC5SEQUVx9nEQfWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAZigk2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A81C113CC;
	Mon, 15 Apr 2024 15:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713196068;
	bh=LyrtEuKV9ZvjtcoP/1RDmpRdxB6ZNTui6MpsvktmFoY=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=eAZigk2VmOcYYwmk1M4lmTsnXRdGmuopR/nxEQK9WOtoGFxWyf/8tHVoYRHZ/UbYf
	 4Fi1qcDgoXWeB50UAuo8+bZiVgdS2oPN75X6qPNhm18MVkUmKo8Q56tX5GEnUs0pgN
	 G8ZqYbCAES0dDhZyesP6H0p0N9xCETb/iH6c8IE2ghw2y+lRiRrYqGhh8sFL2h3+Lu
	 Iv+iAWkQ7H20TKDYDl+SH5kzeVhV8dypOe2OnLUcWEuWmCt3av1kPZ+EbaAjuOLFvp
	 kQ6E+9bCHtyPLag6tFmUlnaN8MTotQZFFh3MCyc3JGjImoM877KS6caHfOOKG1k6wH
	 KZ0tcocFCto8A==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [kpsingh:static_calls] [security] 9e15595ed0:
 Kernel_panic-not_syncing:lsm_static_call_init-Ran_out_of_static_slots
From: KP Singh <kpsingh@kernel.org>
In-Reply-To: <CACYkzJ4G7hO0DNSBy4wpJG1PSgNkifuYcfOeTTpyVBtBtWvQSg@mail.gmail.com>
Date: Mon, 15 Apr 2024 17:47:43 +0200
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Kees Cook <keescook@chromium.org>,
 Song Liu <song@kernel.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 kernel test robot <oliver.sang@intel.com>,
 linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 lkp@intel.com,
 oe-lkp@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <A9568514-FCB3-4715-9794-696383B2B7E8@kernel.org>
References: <202404151225.ce542e38-lkp@intel.com>
 <757538DA-07A4-4332-BAFA-B864BFD06A76@kernel.org>
 <30876b80-c437-4916-b982-97c1a95c0747@I-love.SAKURA.ne.jp>
 <CAHC9VhS=hQuvv+Sw6cc2HwzcLApO7Rc3dAnqHytyzBpC1rokFA@mail.gmail.com>
 <CACYkzJ4G7hO0DNSBy4wpJG1PSgNkifuYcfOeTTpyVBtBtWvQSg@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 15 Apr 2024, at 17:34, KP Singh <kpsingh@kernel.org> wrote:
>=20
>=20
>=20
> On Mon, 15 Apr 2024 at 16:23, Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Apr 15, 2024 at 9:21=E2=80=AFAM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > On 2024/04/15 17:26, KP Singh wrote:
> > > This seems like an odd config which does not enable STATIC_CALL, I =
am going to
> > > make CONFIG_SECURITY depend on CONFIG_STATIC_CALL and make the =
dependency explicit.
> >
> > If CONFIG_SECURITY depends on CONFIG_STATIC_CALL, architectures =
which do not
> > support CONFIG_STATIC_CALL can no longer use LSM ? That sounds a bad =
dependency.
>=20
> Agreed.  If the arch doesn't support static calls we need a fallback
> solution for the LSM that is no worse than what we have now, and
> preferably would still solve the issue of the BPF hooks active even
> where this is no BPF program attached.

Actually I take it back, when CONFIG_STATIC_CALL is not available, the =
implementation falls back to an indirect call. This crash is unrelated, =
I will debug further and post back.

- KP

>=20
> --=20
> paul-moore.com


