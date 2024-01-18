Return-Path: <linux-kernel+bounces-30641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D44E832265
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FB01F22BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A711EB43;
	Thu, 18 Jan 2024 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Tr2hSSgB"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8853D1EA66;
	Thu, 18 Jan 2024 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705621944; cv=none; b=n2K93M4mf3mZBdnthJ+gjT3OZUJgLiucSKHsW/rio1LeaHziNUBuVg5noirSp9cxiHi6NYPf2MmyRTXzM5hqPjX1+TuqUzmbpHyhixkG50LmmoCijyev96C3NJR6VSg4OCj1F0mifXYZEwnyhK62wzFnTDbpo1kILsU7Jp2DcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705621944; c=relaxed/simple;
	bh=5Y49qao2TEBYAh3zbMzGnVU3z2Sn+Hk/yl0ojczX4nc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=fYbrlixegMw2nG2XHvvSb6lOAnFq7lKfCyNQHyabKRrkayf08w+XZ14FuVcPVih8M7pAX4y478Z3DJg4KQs2V7ctpaBsD8vNs2BJD1JyGRVAUeQpVxBGxQBmjML9tOAcQ4Ghio/9u33t3ZcW3nffmfmjet5IaWzEzeP/9Nc60kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Tr2hSSgB; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.85] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 13DC44025B;
	Thu, 18 Jan 2024 23:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1705621933;
	bh=eG7DznVqyLsKmJ1D8OEmMt/Nkq0A9HA7Gw76/3J1s0g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type;
	b=Tr2hSSgBRd4hD6N14xAY4OfELMPYusV1I1ZHGqFxfnbqQ+C/l86HygiGpy5h+ngqT
	 hDb9LnGAUki12eYI1pXQIXu4GQaZN5o2Y7tcPDi+gV0W32Jlo9LfYdWtb6bTvAYgJH
	 S9PY4CxHgQ7FJX+M7up6ZVfGqSbXhqpadnp6su+Kua7X5RcC1ChQ8PoUQZ6C8mEIBj
	 oWh8MET0dm2+5W4X+D594VKWvTSsV93AhJkHW4bHDquTdhSbQzojIcxWflww4PCMDD
	 LBQlgea7OUPpjSB+MCEAShMT5Idx5u9kAYpIjrSP5c72wEy4AMrYXta8UHQvB8r8QI
	 qJPAW9D3MFJUw==
Message-ID: <9fd4ffcb-3f88-4c4c-b580-86895396e933@canonical.com>
Date: Thu, 18 Jan 2024 15:52:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] AppArmor updates for 6.8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKLM <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following apparmor for patches for the 6.8 merge
window.

This PR adds a single feature, switch the hash used to check policy
from sha1 to sha256

There are fixes for two memory leaks, and refcount bug and a potential
crash when a profile name is empty. Along with a couple minor code
cleanups.

These patches have been in linux-next and been tested while in there,
and have also had a merge and regression test against your current
tree as of this morning.

thanks
- john


The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2024-01-18

for you to fetch changes up to 8ead196be219adade3bd0d4115cc9b8506643121:

   apparmor: Fix memory leak in unpack_profile() (2024-01-09 01:45:25 -0800)

----------------------------------------------------------------
+ Features
   - switch policy hash fro sha1 to sha256

+ Bug Fixes
   - Fix refcount leak in task_kill
   - Fix leak of pdb objects and trans_table
   - avoid crash when parse profile name is empty

+ Cleanups
   - add static to stack_msg and nulldfa
   - more kernel-doc cleanups

----------------------------------------------------------------
Dimitri John Ledkov (1):
       apparmor: switch SECURITY_APPARMOR_HASH from sha1 to sha256

Fedor Pchelkin (3):
       apparmor: free the allocated pdb objects
       apparmor: fix possible memory leak in unpack_trans_table
       apparmor: avoid crash when parsed profile name is empty

Gaosheng Cui (1):
       apparmor: Fix memory leak in unpack_profile()

John Johansen (5):
       apparmor: declare stack_msg as static
       apparmor: declare nulldfa as static
       apparmor: add missing params to aa_may_ptrace kernel-doc comments
       apparmor: cleanup network hook comments
       apparmor: Fix ref count leak in task_kill

  security/apparmor/Kconfig         | 12 ++++----
  security/apparmor/apparmorfs.c    | 16 +++++-----
  security/apparmor/crypto.c        |  6 ++--
  security/apparmor/domain.c        |  2 +-
  security/apparmor/lib.c           |  1 +
  security/apparmor/lsm.c           | 63 +++++++++++----------------------------
  security/apparmor/policy.c        | 13 ++++----
  security/apparmor/policy_unpack.c | 13 +++++---
  security/apparmor/task.c          |  2 ++
  9 files changed, 54 insertions(+), 74 deletions(-)


