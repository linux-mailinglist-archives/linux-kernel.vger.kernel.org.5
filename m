Return-Path: <linux-kernel+bounces-31908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814D8833641
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2210C1F215AC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBBD17992;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBabWffU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B70168B3;
	Sat, 20 Jan 2024 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784998; cv=none; b=h8UTB/o/FtnmnT3GAHIdrz4G5Hec1ClfDVp8vvqOr9T11RD71CVrTljdsi2boLIOUo0DuOwMw5tm8CLChAwBmudnW9STtj2ip0CJuFeoaVC7ydSBc9BtAzQSLdvvtvNHhU2VJ+PsmyhlrLhB/kSyl4IAsyiAxsEafAXfkX06ih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784998; c=relaxed/simple;
	bh=Mh4+2rjEl/tfirk6ZrJJo/+D3Z21pmSdnoQgsLi3+Hc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Llq61J9ZrtCELNC323InzjSJbQ+G0whDvJ/0/9nmPKTQ7c90PD4W+q8LfWFGrlL2u+YC+bBA5geZ2zacOt7F8k4PivLRZWGVOTwhcxGYy+H6zUPZP0l2vBZuvD8Z/wSK6TF6Iq27ARcEBaHs32XKDYI0wwlLxnPTDn+OgNWaCPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBabWffU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3417AC43330;
	Sat, 20 Jan 2024 21:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784998;
	bh=Mh4+2rjEl/tfirk6ZrJJo/+D3Z21pmSdnoQgsLi3+Hc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gBabWffUhXIzoKs5sudLgHP01fwVoOZ8G8XJppwrSIIqTXd2XYdNBCXywvJDVmaR0
	 VQwuvGapishRyDTmmjTM7bUqzXJpyjK1h9SC1IaTrGptzQuCxjz7cLGSVqLdkBWQRC
	 u+x7wG5sj4K1RWc1aYbazrFCRwmJWgCgVz0cT4BIYB4v4S9b6GrU/rO9S/reHa6wof
	 N4QLgOaSg5v+YyptWT1v0cTgFIuK8vPMo5HUtXA80XG+dGvgSS6WLvRIwqNAUwD8ZI
	 dyzIoechWjSaFhyqfCz2xhvbCtFX2PGS9rCj03lLMuj84C855CJQHmfdu7ymB7dMmg
	 9WOYs+ahTvD2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23795D8C970;
	Sat, 20 Jan 2024 21:09:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] resource: add walk_system_ram_res_rev()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578499814.24348.4213715182572913470.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:58 +0000
References: <ZVTA6z/06cLnWKUz@MiWiFi-R3L-srv>
In-Reply-To: <ZVTA6z/06cLnWKUz@MiWiFi-R3L-srv>
To: Baoquan He <bhe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 akpm@linux-foundation.org, ebiederm@xmission.com, takahiro.akashi@linaro.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Wed, 15 Nov 2023 21:00:27 +0800 you wrote:
> This function, being a variant of walk_system_ram_res() introduced in
> commit 8c86e70acead ("resource: provide new functions to walk through
> resources"), walks through a list of all the resources of System RAM
> in reversed order, i.e., from higher to lower.
> 
> It will be used in kexec_file code to load kernel, initrd etc when
> preparing kexec reboot.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] resource: add walk_system_ram_res_rev()
    https://git.kernel.org/riscv/c/7acf164b259d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



