Return-Path: <linux-kernel+bounces-133399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C23089A344
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577CA2840BC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CF3172BDC;
	Fri,  5 Apr 2024 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu6sAsBk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D12172BD1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336950; cv=none; b=hyjObKNZg4JKPMawF28BgvIthgXgPWQJ3H0itvKdz6IFllsAd8dOEsBsDLXHARvAhNL6T487x0APpZOizcf+3+tCNSUgE7nmGLlg8enZvvp6PqW617VpEbJdADbPqbLxFp1DBuS4rcncxRNU17kzRc1w8RigjFqbcWR0ISnGiuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336950; c=relaxed/simple;
	bh=vMESqORx/RA9w4d/QSXK1eOJoSKOP0cUct1lvNlW1F4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GEAFZrPsudgM1UIbT7ryED28lWkqQ0jEDQ/dP1B2KTVx+kr9V7dCUdv44b4aXjEKTuiix3k+RQ4968oqeZKiVorWDSwVsn96XWQ1mDa73yt5jvX5GD/1rSxRCuhoNoV/UKFjuC4+2SbfwHdMJJbRH+WeFuxLy/pM6FGOufsVWTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vu6sAsBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E99DC433F1;
	Fri,  5 Apr 2024 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712336949;
	bh=vMESqORx/RA9w4d/QSXK1eOJoSKOP0cUct1lvNlW1F4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Vu6sAsBkgXNJbd8lq1II7NYJ9WhiuBjf3HWQGqCKHhmm3W0G1gxePoxaERv+VuRM5
	 aU9+7cLg9SB+z6f36HhOH/5Y+GzothUZ/wuSvUxbQFjdNhxJFVli4zDA8z/WKhDYIF
	 Cl1nide42Rbr704RhLJdyalaV9BcnX/zjx7YdH7olqGqGMFqsV0BxOTzX4hNb6gRju
	 F+husBsR6oAXCLdfcRkSbpLjjDHOPbqqOeDp+F6bE/FdcnDLlHfwN/m0k14jpaHH3a
	 DrzmNacmZD+dviVAdBemZ0SRZjPepVS2AX6FmtZ4ffhAQJkcl/aqnp23hFa8k9vSKE
	 /PBuyn8DqpP2Q==
From: Vinod Koul <vkoul@kernel.org>
To: rick.wertenbroek@heig-vd.ch, 
 Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240307095318.3651498-1-rick.wertenbroek@gmail.com>
References: <20240307095318.3651498-1-rick.wertenbroek@gmail.com>
Subject: Re: [PATCH] phy: rockchip: Fix typo in function names
Message-Id: <171233694670.304553.7633655553349926405.b4-ty@kernel.org>
Date: Fri, 05 Apr 2024 22:39:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 07 Mar 2024 10:53:18 +0100, Rick Wertenbroek wrote:
> Several functions had "rochchip" instead of "rockchip" in their name.
> Replace "rochchip" by "rockchip".
> 
> 

Applied, thanks!

[1/1] phy: rockchip: Fix typo in function names
      commit: 9b6bfad9070a95d19973be17177e5d9220cbbf1f

Best regards,
-- 
~Vinod



