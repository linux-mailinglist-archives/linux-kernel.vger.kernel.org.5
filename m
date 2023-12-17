Return-Path: <linux-kernel+bounces-2427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FF4815CFA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 02:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F13C1C215C3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 01:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA71A3D;
	Sun, 17 Dec 2023 01:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugdcy0A2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B037F4;
	Sun, 17 Dec 2023 01:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C23C433C7;
	Sun, 17 Dec 2023 01:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702775713;
	bh=+jdymlouo2oLdL7TWg09M1pd471V3CkdDnsXRsTkWSk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Ugdcy0A2ov0A0T2b8AUftEEYDfMXAjJBoqxod+VnWlKf7GAoLAIk4Km9djgUGICaN
	 QFRD58aLYm9O7/9qKtbscF8qaYZEoqYjuOy5dZtGogDG9EQPY6ejmayUZHcgSclLzX
	 pygRGLZyBgLhBDRO4UQrhrND/cBkNKXA8fS3IZdZCAg8KdqdnoId660+IfLiPPX7Vx
	 o1GS9TVslLEJ2sUOA4UjyMEiHdiO0ZoqmhSy9JM/yVsJ2E/TquJ692sycSJ2y1KzdP
	 n4cJHMkDqqo7q74G+E/wdBdhClkkMfcx1Whi3Gxh/xIfOuAXEagXV4ee8KKRvCWVjE
	 rw0SGiNEWiCIA==
Message-ID: <530a92788ef6763ecb359347a1fcaafb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231210175232.3414584-1-visitorckw@gmail.com>
References: <20231210175232.3414584-1-visitorckw@gmail.com>
Subject: Re: [PATCH] clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()
From: Stephen Boyd <sboyd@kernel.org>
Cc: duje.mihanovic@skole.hr, conor.dooley@microchip.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>, mturquette@baylibre.com
Date: Sat, 16 Dec 2023 17:15:10 -0800
User-Agent: alot/0.10

Quoting Kuan-Wei Chiu (2023-12-10 09:52:32)
> In cases where mapping of mpmu/apmu/apbc registers fails, the code path
> does not handle the failure gracefully, potentially leading to a memory
> leak. This fix ensures proper cleanup by freeing the allocated memory
> for 'pxa_unit' before returning.
>=20
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---

Applied to clk-next

