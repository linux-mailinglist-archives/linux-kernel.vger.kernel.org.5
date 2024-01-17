Return-Path: <linux-kernel+bounces-28443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3966982FE92
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3661C242C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C38D67C6F;
	Wed, 17 Jan 2024 01:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozMk7K8I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5F1385;
	Wed, 17 Jan 2024 01:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705456410; cv=none; b=sI3BGdsvyOmG+6zsPbhgBL3EolR+C5nG/2Et/eVoUBoPwKd3x4qNSpQktynpwNx/rQTv2oQF4W75y9GLZIDNIucb8pdJPcJ6xMUk3uhWjCEW7yqFJ/8JweyNQpHilpuyZD77H9nZa/Ujo4n/RgiT371UUYQqPuuWMwzCpC96TIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705456410; c=relaxed/simple;
	bh=BElXs104GGWyneznFWlmSje+zAUEH5lxUrbFygcCijY=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=kxB2uDOC5nNDL89mPsdwDm159OX/SCgR4Eqez3zPMQ3vSJYC6rozUYia3Prd7WqRaBaN2KcFFAaGH/KiAXGht/peFZ0IZZleDXn3AZ6RYz0aIhOjTGAbWvBe7KJGvBOIPPuoRHoBRfKdl4bfr/WKvVf+RRWcXmkW+qy22etR1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozMk7K8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C93C433F1;
	Wed, 17 Jan 2024 01:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705456410;
	bh=BElXs104GGWyneznFWlmSje+zAUEH5lxUrbFygcCijY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ozMk7K8Ian3IYofgxo4tGXyMnrSkXFAM0Imbj3BzW102RHMvznMN3OoGL9urFPbTs
	 fZWU2v3OA3eUT5TSM7vzZVILJZrZNfjxYpJje0gpCADB1q2wiu1cP3lc33S7s9cjIm
	 2dswo+u1SK2l91N+SOFwcVpLiqEHh081QcyvOJ8EpaN56VR9qFOjtI0F/BgWG79cUW
	 j5VSTUlSvyr+1gweW5woWRp0NK8pS6vMl6RajE8ulfQ3fgDb6KrBxMPuxJVk6xXnX1
	 ldKYmZerAWcZaODBLPW2tj9PoZE3S2qL4yeOeBBXue5Dqrs7PBTzxPOlS/2ZFDnAA3
	 /vr7+NePMR5eg==
Date: Tue, 16 Jan 2024 17:53:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
 <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: microchip: sparx5: remove redundant store to
 variable clk_hz
Message-ID: <20240116175328.2d6902af@kernel.org>
In-Reply-To: <20240116161847.2317011-1-colin.i.king@gmail.com>
References: <20240116161847.2317011-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 16:18:47 +0000 Colin Ian King wrote:
> The store to clk_hz is redundant since clk_hz goes out of scope on the
> return. Fix this by replacing the *= operator with just * to remove
> the store back to clk_hz.
> 
> Cleans up clang scan build warning:
> warning: Although the value stored to 'clk_hz' is used in the enclosing
> expression, the value is never actually read from 'clk_hz'
> [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

For consistency - same story as:
https://lore.kernel.org/all/20240116193152.GD588419@kernel.org/
-- 
pw-bot: defer

