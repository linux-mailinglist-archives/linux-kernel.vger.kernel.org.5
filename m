Return-Path: <linux-kernel+bounces-133868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB0A89AA19
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099FA2836A2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC7D3714C;
	Sat,  6 Apr 2024 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbmoL1MH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B0822EE8
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395173; cv=none; b=IbqZ2/yizj1Q2k7jNv3ePmdpVGV81ZmDf5u3Bvq00jP+IHgc78tUOdwB3JguVXUrccsP5t4D1cbP+bY0y8InkZ+k8nwUmgg2uHIfq9x0Mf0D+vbaTYu1cuBT+3A5it5IsKRqKFevC+5H3rBWb26zT1RDVVbuFy018h6A9Cr1YJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395173; c=relaxed/simple;
	bh=TD60yYsSeKuKEn0H7kCBzjt2joQqvZ+9T1R4Avjktzw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l+htuhpCAMSTcMBjAboVVXh8613ME8Fc/KNr71/NMEu5unrNq3Ws9MuJ1pK4ZiyRSVy/yv82ywRRFSShtrYhxaP/bPnf1cehkzkrUycPhXh/ubxxtFwH9PHh9zkpz5nwnJ0RtnFtsaVVoWQ7EqR4QiWPiBSDBkATVkWr5CuHlHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbmoL1MH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A704C433F1;
	Sat,  6 Apr 2024 09:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712395173;
	bh=TD60yYsSeKuKEn0H7kCBzjt2joQqvZ+9T1R4Avjktzw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hbmoL1MHGnXv4ia11ywmYLuNWHfsYJnBybcUwcq92tM3eonpaflABnd0s+cNv7zPN
	 WsS9O+i1/vitPpqz854yptlqRJsYBxK7JZq4V2u3A25q1i/5SC3F5aquEbdB0QinTS
	 yawmFXzh8scbn5IvcpSd3wMzolDdsgH2vYxbhttn3qPntOAk3wbsd4DnNyTz/tWY2T
	 pHwChp4vv+n7pAeYWcsRU2CQlOzH1FUjlZqHM55r2I8q/X8jFhLEDKNQ8tiys2kTy9
	 KR+aWuxcE8z2UtxJvdBUqLUwUbPO1B911+Y3gB3fzSHW+XP3ykF/XGF/4Z591xrGup
	 zqaVAmkDlYDbg==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240305-class_cleanup-phy-v1-1-106013a644dc@marliere.net>
References: <20240305-class_cleanup-phy-v1-1-106013a644dc@marliere.net>
Subject: Re: [PATCH] net: phy: core: make phy_class constant
Message-Id: <171239517126.352396.9441266148456614839.b4-ty@kernel.org>
Date: Sat, 06 Apr 2024 14:49:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 05 Mar 2024 15:18:51 -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the phy_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> 
> [...]

Applied, thanks!

[1/1] net: phy: core: make phy_class constant
      commit: db704bf6dccc8fef77ee4a8326bf2013b828205b

Best regards,
-- 
~Vinod



