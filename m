Return-Path: <linux-kernel+bounces-145883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B28A5C50
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202BE1C2212D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B6A156672;
	Mon, 15 Apr 2024 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wj4sjHtB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32671DFEB;
	Mon, 15 Apr 2024 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713213745; cv=none; b=BCYD5zMXwPLXXkzkyZGkYuc+A6M2Ssi18sSHGTe8N44f2X1JHg0tSzKuCKZvlDGcKBEzZKCiagc1sLWHWwqdye/hYWhltj4gUnHfjwgsO7jC/FArQKP9u7GQpzwVhTG+8QxDL2qOPpSIfcON00i/l6qc/0KyXXkbHkHsDjydMmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713213745; c=relaxed/simple;
	bh=WWhd2MD/OkFbRlau85vf2fAlZdF/HP4MEvIE/7EhBhU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DbNGQKgInJgfZZFBzX1S1fO5rhTRg7q6KlxO/yquxLy60+C9W9Diqzch+SfYZ2Jhgl4Kjit438tQbH3z0YVdsuAWjGbwfuX3oM3baohM/fiwmsD+q4U3Jwl76FAuBqLDENviA+lSLDssYSf+2W3VJCRwmD37+brit/G7tGnoj0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wj4sjHtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02994C113CC;
	Mon, 15 Apr 2024 20:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713213745;
	bh=WWhd2MD/OkFbRlau85vf2fAlZdF/HP4MEvIE/7EhBhU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=Wj4sjHtBhAMSpn9QrQVOe/FnRHXl6bY7gsAH30+kmK8fv9Q49lsN3/r9N5vUWl+Y+
	 1esmu9NZpOthDadc94K3gzkrqI7r/V5uaJJLmGY9Ja67pT3DO0Fwa2IsRRASrC3D8Q
	 to3550cYpk92uzlJfkKCKldmWvx8ge2K+Dhf9zzLmR/NB1e57WSAFhd/eJcjV92Yh+
	 17COv7mXIdPrZ9za4KN6/GqUL3ZjbDir0xxoUVzNV9VwrqZa41QWRWGd/nmd5UfvY3
	 PtNpdqCjDgxoZ0f1MwahQuprxaupBYVmwON/zTWVs+5MYM+AkmigqtHlEvX0QbWz2r
	 aURugM/OjgHyQ==
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
In-Reply-To: <A9568514-FCB3-4715-9794-696383B2B7E8@kernel.org>
Date: Mon, 15 Apr 2024 22:42:20 +0200
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
Message-Id: <CD57788C-C9D6-4BA8-8352-90EBB6600D39@kernel.org>
References: <202404151225.ce542e38-lkp@intel.com>
 <757538DA-07A4-4332-BAFA-B864BFD06A76@kernel.org>
 <30876b80-c437-4916-b982-97c1a95c0747@I-love.SAKURA.ne.jp>
 <CAHC9VhS=hQuvv+Sw6cc2HwzcLApO7Rc3dAnqHytyzBpC1rokFA@mail.gmail.com>
 <CACYkzJ4G7hO0DNSBy4wpJG1PSgNkifuYcfOeTTpyVBtBtWvQSg@mail.gmail.com>
 <A9568514-FCB3-4715-9794-696383B2B7E8@kernel.org>
To: Paul Moore <paul@paul-moore.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 15 Apr 2024, at 17:47, KP Singh <kpsingh@kernel.org> wrote:
>=20
>=20

[...]

>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>> On 2024/04/15 17:26, KP Singh wrote:
>>>> This seems like an odd config which does not enable STATIC_CALL, I =
am going to
>>>> make CONFIG_SECURITY depend on CONFIG_STATIC_CALL and make the =
dependency explicit.
>>>=20
>>> If CONFIG_SECURITY depends on CONFIG_STATIC_CALL, architectures =
which do not
>>> support CONFIG_STATIC_CALL can no longer use LSM ? That sounds a bad =
dependency.
>>=20
>> Agreed.  If the arch doesn't support static calls we need a fallback
>> solution for the LSM that is no worse than what we have now, and
>> preferably would still solve the issue of the BPF hooks active even
>> where this is no BPF program attached.
>=20
> Actually I take it back, when CONFIG_STATIC_CALL is not available, the =
implementation falls back to an indirect call. This crash is unrelated, =
I will debug further and post back.

 Apparently, when I smoke tested, I had CONFIG_IMA disabled so did not =
hit the bug. Well, now IMA is an LSM, so the following fixes it:

kpsingh@kpsingh:~/projects/linux$ git diff
diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
index dbb3c8573959..77803d117a30 100644
--- a/include/linux/lsm_count.h
+++ b/include/linux/lsm_count.h
@@ -78,6 +78,12 @@
 #define BPF_LSM_ENABLED
 #endif

+#if IS_ENABLED(CONFIG_IMA)
+#define IMA_ENABLED 1,
+#else
+#define IMA_ENABLED
+#endif
+
 #if IS_ENABLED(CONFIG_SECURITY_LANDLOCK)
 #define LANDLOCK_ENABLED 1,
 #else
@@ -103,6 +109,7 @@
                LOCKDOWN_ENABLED        \
                SAFESETID_ENABLED       \
                BPF_LSM_ENABLED         \
+               IMA_ENABLED             \
                LANDLOCK_ENABLED)


We don't need a CONFIG_STATIC_CALL dependency, th static_call code =
nicely falls back.

- KP

>=20
> - KP
>=20
>>=20
>> --=20
>> paul-moore.com
>=20


