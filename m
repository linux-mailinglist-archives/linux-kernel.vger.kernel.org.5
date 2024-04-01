Return-Path: <linux-kernel+bounces-126580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F408939E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1CF1F22431
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670DE11738;
	Mon,  1 Apr 2024 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3SqtwPW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8B10A3E;
	Mon,  1 Apr 2024 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711965631; cv=none; b=j4+RnL9WUhRNlSK4bDhFHjQx0L40Kcyp7APbIYZSXAcJCMraMbaHAybXwjveUO4lpB9e+2ozLcH11oWkLWaqSPaG2lJ2i4fToxB8MmpU4l4Rgnye4F4UX9Mnkyfc3amjhZpwO27mbfNrakvkISrsBWYA+HdbtZTcOHVNV3wXHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711965631; c=relaxed/simple;
	bh=avnVeOJaQFjaYOjK967D1lorb/XUUS3L6ARM3VnA0N4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DjMljiyRm/H5X33Pyg6RrPLIMONpqAcF0ZFuhPxiBxEvsEqUREOvSIrWDw1y0cpPxObFo4sEh1mkffBg+UXItI00KDNDAl8hIjqSbLtmNNQ1asi45nK1ekbdiGWmUs8q5DGwG8PPc4KHMfw6mKxHYjfkEHj4zLj9YWmvSvOZOl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3SqtwPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4ACBDC43390;
	Mon,  1 Apr 2024 10:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711965631;
	bh=avnVeOJaQFjaYOjK967D1lorb/XUUS3L6ARM3VnA0N4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j3SqtwPWNed9OJQrDlUNqkCNeykoHdIccQ4hdEtAlInzF4sYk2/yyfI38Mbbg0J2m
	 coTjUL+XJeEycTV3oy9T6Ca1GqKip1G5HMsjt+0boFZeoWEyS2M4RRSpzB0Ld6ETIm
	 NnukEsEeIHsv8y3lWXnKkIRPc5W+iRb/l5kZithFBiBc8usbyGyjDDvflPDF9NhB+y
	 DCmLE8hwn7mGdVq+k7TWDR3snfgVvfyod+C3mhgk3exRnif51eev9ETSMMzMt7wt5C
	 Hv4siYarq/rQ+tq+tWb7vopsZGrEK9b3DFatSVeXOiUdaf49ZoJFWOWMSeYz5pOkwT
	 HFXSmk9gTKKhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 310E1D9A159;
	Mon,  1 Apr 2024 10:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 00/21] ice: add PFCP filter support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171196563119.11638.12210788830829801735.git-patchwork-notify@kernel.org>
Date: Mon, 01 Apr 2024 10:00:31 +0000
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
In-Reply-To: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, yury.norov@gmail.com, glider@google.com,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 27 Mar 2024 16:23:37 +0100 you wrote:
> Add support for creating PFCP filters in switchdev mode. Add pfcp module
> that allows to create a PFCP-type netdev. The netdev then can be passed to
> tc when creating a filter to indicate that PFCP filter should be created.
> 
> To add a PFCP filter, a special netdev must be created and passed to tc
> command:
> 
> [...]

Here is the summary with links:
  - [net-next,v6,01/21] lib/bitmap: add bitmap_{read,write}()
    https://git.kernel.org/netdev/net-next/c/63c15822b8dd
  - [net-next,v6,02/21] lib/test_bitmap: add tests for bitmap_{read,write}()
    https://git.kernel.org/netdev/net-next/c/991e5583647d
  - [net-next,v6,03/21] lib/test_bitmap: use pr_info() for non-error messages
    https://git.kernel.org/netdev/net-next/c/f3e28876b6e0
  - [net-next,v6,04/21] bitops: add missing prototype check
    https://git.kernel.org/netdev/net-next/c/72cc1980a0ef
  - [net-next,v6,05/21] bitops: make BYTES_TO_BITS() treewide-available
    (no matching commit)
  - [net-next,v6,06/21] bitops: let the compiler optimize {__,}assign_bit()
    https://git.kernel.org/netdev/net-next/c/5259401ef8f4
  - [net-next,v6,07/21] linkmode: convert linkmode_{test,set,clear,mod}_bit() to macros
    https://git.kernel.org/netdev/net-next/c/8fab6a9d72e4
  - [net-next,v6,08/21] s390/cio: rename bitmap_size() -> idset_bitmap_size()
    https://git.kernel.org/netdev/net-next/c/c1023f5634b9
  - [net-next,v6,09/21] fs/ntfs3: add prefix to bitmap_size() and use BITS_TO_U64()
    (no matching commit)
  - [net-next,v6,10/21] btrfs: rename bitmap_set_bits() -> btrfs_bitmap_set_bits()
    https://git.kernel.org/netdev/net-next/c/4ca532d64648
  - [net-next,v6,11/21] tools: move alignment-related macros to new <linux/align.h>
    https://git.kernel.org/netdev/net-next/c/10a04ff09bcc
  - [net-next,v6,12/21] bitmap: introduce generic optimized bitmap_size()
    (no matching commit)
  - [net-next,v6,13/21] bitmap: make bitmap_{get,set}_value8() use bitmap_{read,write}()
    https://git.kernel.org/netdev/net-next/c/b44759705f7d
  - [net-next,v6,14/21] lib/bitmap: add compile-time test for __assign_bit() optimization
    https://git.kernel.org/netdev/net-next/c/7adaf37f7f10
  - [net-next,v6,15/21] ip_tunnel: use a separate struct to store tunnel params in the kernel
    (no matching commit)
  - [net-next,v6,16/21] ip_tunnel: convert __be16 tunnel flags to bitmaps
    (no matching commit)
  - [net-next,v6,17/21] net: net_test: add tests for IP tunnel flags conversion helpers
    https://git.kernel.org/netdev/net-next/c/5b2be2ab76d1
  - [net-next,v6,18/21] pfcp: add PFCP module
    (no matching commit)
  - [net-next,v6,19/21] pfcp: always set pfcp metadata
    (no matching commit)
  - [net-next,v6,20/21] ice: refactor ICE_TC_FLWR_FIELD_ENC_OPTS
    (no matching commit)
  - [net-next,v6,21/21] ice: Add support for PFCP hardware offload in switchdev
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



