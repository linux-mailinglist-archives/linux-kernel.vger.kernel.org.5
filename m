Return-Path: <linux-kernel+bounces-99583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E39D878A56
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05E21C21507
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6123857323;
	Mon, 11 Mar 2024 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k54CMSEg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A282D607;
	Mon, 11 Mar 2024 21:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194282; cv=none; b=NwSbh01q/pge3Z9u8nBPQE02mhBRy1YoPxdj0LcG5UwRg7WFG8rUbKhPzh5wKFZJEJJIPd35vgiFzc2XWYJN9Sq/H5upC0uEK5QKtoPXujFG3OEG9odz3XrGJBkc7doHuAZbMuyU8uPZ7oKPPHlV0DgtFOBkcvzN6M/jrYTmO20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194282; c=relaxed/simple;
	bh=mVrQf39TcGT+LrRP/p0MKvKDXKZM5ggz/eiWJSGusAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anvAR79SpXzdFyEmhmr5lv07qjnil7fttthYsPkWUtdW6sob79Ne5uV0OHJKwuEZfylI4HNZSAVasqDETkRYwHyFZl5aaa+PZurRSNZXVtlZIOjUFC4ccOboFEsk+bQXCzrxYGHSeGnphgpgDOyGN/fi8nNO7EoMxu1beT8DBx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k54CMSEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DA8C433F1;
	Mon, 11 Mar 2024 21:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710194282;
	bh=mVrQf39TcGT+LrRP/p0MKvKDXKZM5ggz/eiWJSGusAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k54CMSEgi3w6zyiaudhxVRr/v/UMZYF1Z8C/raMDJbP4DIswaMpuwDk8oUQ9PscGA
	 MMHvrHlrwAH28/hhr/Vy2XHAfcssTlV+7AlfATgtU/jllJUGwkVptnvyAkmpwW7tUT
	 WhWT4yE9qdmma+kez/UxHl7JPeGQYFlEGpZu6RBoVNRFuE8TMU1id2I+0ibX6web67
	 YfrRsjVrSlATJWpMB+Ln3MoKmkHQIR64bhldEfaqOQBt6o6ma0MHbvG3pMB/8h+dOC
	 /AjNLmn2KlmcCtfFE5WdK4KCVIJ9XaVoIFsKe3NGKlHd28hAQ3Sj4mXslkkiQK73ME
	 H+DVaoTqHQ+wQ==
Date: Mon, 11 Mar 2024 14:58:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Justin Swartz
 <justin.swartz@risingedge.co.za>, daniel@makrotopia.org, dqfext@gmail.com,
 sean.wang@mediatek.com, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: dsa: mt7530: disable LEDs before reset
Message-ID: <20240311145800.3840dc27@kernel.org>
In-Reply-To: <2d206dbb-a27b-4139-a49e-331797d8ba34@arinc9.com>
References: <20240305043952.21590-1-justin.swartz@risingedge.co.za>
	<171019143163.14853.15330891015381229970.git-patchwork-notify@kernel.org>
	<2d206dbb-a27b-4139-a49e-331797d8ba34@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Mar 2024 00:22:48 +0300 Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> Why was this applied? I already explained it did not achieve anything.

Daniel disagreed and you didn't reply to him.

Please don't top post.

