Return-Path: <linux-kernel+bounces-116523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D91988A052
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A591C36DED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9008413E6CB;
	Mon, 25 Mar 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXNezA5J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EB61C257E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711341756; cv=none; b=TpHl7IS07Uhk85tSIGxjpiUgDZ/SPHV49GQE7XrIVzyDutgLmH4Iu5kZOTPmPX+hGY9wW3M+S4Djpy+y1vM9p4WxNKU+WzJu5iL4fbe4V1BfGBPAC3LQkRl+1ts9Ockg3Yv8EUkTOwVbIbc42vOVDpYWnclUz9tS0ZXZ6ickE5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711341756; c=relaxed/simple;
	bh=bBw56LJubXCStxVYQUSiFNc8WgVMrbS3NMqW6gTTz8k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pzo0U6BD08weHTTpJKqRBX06NX/Kd/RvhQq5WFS0q48MKjEcFeYecqJ7FAUg6I+F431Jv+NbZMyzAZBRRQ5K+vkwfO4jPedx0qJV2BVI1RsPSRnalaMIMW9WLN+uyav6bjjE+5R1TXZzINLc4f7kgzkrL/KtmN3SUHq6iuTXTX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXNezA5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1E17C43142;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711341754;
	bh=bBw56LJubXCStxVYQUSiFNc8WgVMrbS3NMqW6gTTz8k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UXNezA5JyU+tGdGowOVGyO/cxwigyBxXofjJbIlEHctB7kxJVlpjIMY8YGrfzoad+
	 DNOfdeJOz/E1Hv8J+YYCzXUqryOoYbzjCfZPcO98eEsZLMcEznBlZAG2wk/P2LDP5A
	 btZesN49bjjxxR7WBR1D/sjk3AzEEMrywqDdLn+h/Ahh9xfdyDvBngI097Q0tH1iMZ
	 mF6L0MmuePAyOHzJWIT/XWp/RUl00B3tSrybObifexTD4E8gqC2oXaBDKV4LU4fVkC
	 xtTVhsgYjPmkPbzIEaSCvdUvMYMlLxH3zusNe2o2HoVSWssmW3XgSPLzhWHnlxR3dX
	 HOApdiMb/gbBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C60C9D8BD1C;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] MAINTAINERS: Setup proper info for SOPHGO vendor support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171134175480.18749.10483414416084336702.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 04:42:34 +0000
References: <IA1PR20MB4953B158F6F575840F3D4267BB7D2@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB4953B158F6F575840F3D4267BB7D2@IA1PR20MB4953.namprd20.prod.outlook.com>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, unicorn_wang@outlook.com,
 conor@kernel.org, chao.wei@sophgo.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Inochi Amaoto <inochiama@outlook.com>:

On Tue, 30 Jan 2024 09:40:42 +0800 you wrote:
> Add git tree that maintaines sophgo vendor code.
> Also replace Chao Wei with myself, since he does not have enough time.
> Since sophgo vendor code is maintained, remove itself from
> `RISC-V MISC SOC`
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Acked-by: Chao Wei <chao.wei@sophgo.com>
> 
> [...]

Here is the summary with links:
  - [v2] MAINTAINERS: Setup proper info for SOPHGO vendor support
    https://git.kernel.org/riscv/c/0f46e1339ef1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



