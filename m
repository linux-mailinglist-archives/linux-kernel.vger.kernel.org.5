Return-Path: <linux-kernel+bounces-93425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 222E3872F90
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB72E2849CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA79C5C8E8;
	Wed,  6 Mar 2024 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ctO2DSiL"
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C343E5C5F9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709965; cv=none; b=kB2T/x7odX78ObTvig16D7jyPmAzW5CezUp9eUbkRiZ3reqjJhZ5g03JbNaw5JC6eE4KECcYf2zm9njA2Vuy+xpyQF0TgQAzstYrBcnArE84GzU0G1f65LZTNgHHQ//ij8t9pKz2DmfwYlz1/raqIjepwaJpbzVJqFWaNKANVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709965; c=relaxed/simple;
	bh=Z1nsfA7d27x2MPQyf9yBVEThRd7U3+QWKY6OTCTdDOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoSYT5P4oC/zD1zPwFunxm7K64H/yYXPrzdQbW+egw4YVre1r+DqRnxGRje78zpll8Y48gL2nAIDsg1pPWLvbKBlyrK4DIWCKMTKWIqaJbVLkjjiud6kvSbTINTxSICYplDUQ0bu43Z+Fuxy6ue4JgDpviYKYkMaMzc2JqWn96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ctO2DSiL; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TqP9Z4kq6zJND;
	Wed,  6 Mar 2024 08:25:54 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TqP9Y5nGPzgdC;
	Wed,  6 Mar 2024 08:25:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709709954;
	bh=Z1nsfA7d27x2MPQyf9yBVEThRd7U3+QWKY6OTCTdDOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctO2DSiLO+vK5KmeHfs8b6V0dgjR7bszcgds6DtedXdNBQ//TV6I04aD6lQJbe1Sy
	 i/igkeHWkD3OWAroBzbK7bhwPzzUDOqqwMkgfR9SRrk0i0wXElKjMz83bx4aWqQF2M
	 rmQOaT7gT05NyZPC36vItGgZ6sQSusKmYNLbKorE=
Date: Wed, 6 Mar 2024 08:25:43 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Will Drewry <wad@chromium.org>, edumazet@google.com, 
	jakub@cloudflare.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] selftests/harness: Fix TEST_F()'s vfork handling
Message-ID: <20240306.Hei7aekahvaj@digikod.net>
References: <20240305.sheeF9yain1O@digikod.net>
 <20240305201029.1331333-1-mic@digikod.net>
 <20240305122554.1e42c423@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305122554.1e42c423@kernel.org>
X-Infomaniak-Routing: alpha

On Tue, Mar 05, 2024 at 12:25:54PM -0800, Jakub Kicinski wrote:
> On Tue,  5 Mar 2024 21:10:29 +0100 Mickaël Salaün wrote:
> > Always run fixture setup in the grandchild process, and by default also
> > run the teardown in the same process.  However, this change makes it
> > possible to run the teardown in a parent process when
> > _metadata->teardown_parent is set to true (e.g. in fixture setup).
> > 
> > Fix TEST_SIGNAL() by forwarding grandchild's signal to its parent.  Fix
> > seccomp tests by running the test setup in the parent of the test
> > thread, as expected by the related test code.  Fix Landlock tests by
> > waiting for the grandchild before processing _metadata.
> > 
> > Use of exit(3) in tests should be OK because the environment in which
> > the vfork(2) call happen is already dedicated to the running test (with
> > flushed stdio, setpgrp() call), see __run_test() and the call to fork(2)
> > just before running the setup/test/teardown.  Even if the test
> > configures its own exit handlers, they will not be run by the parent
> > because it never calls exit(3), and the test function either ends with a
> > call to _exit(2) or a signal.
> > 
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Will Drewry <wad@chromium.org>
> > Fixes: 0710a1a73fb4 ("selftests/harness: Merge TEST_F_FORK() into TEST_F()")
> > Link: https://lore.kernel.org/r/20240305201029.1331333-1-mic@digikod.net

Signed-off-by: Mickaël Salaün <mic@digikod.net>

> 
> Your S-o-b is missing. Should be enough if you responded with it.
> 
> Code LGTM, thanks!
> 

