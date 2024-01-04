Return-Path: <linux-kernel+bounces-16164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C1E8239F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655181F261EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C00817F8;
	Thu,  4 Jan 2024 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn8tdyiz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D361849;
	Thu,  4 Jan 2024 01:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEF7C433C8;
	Thu,  4 Jan 2024 01:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704330009;
	bh=YhPccyep9c7+vkew2LR1MHBYks2F3iHuMcYZNxDs8JE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jn8tdyizXuYWy3et3cfDV8Oex21VlgAgjfPLg8mcj9WenKss5F2xL/eV7hORqsg8C
	 cdo/Lxy5Zl8AaYcxzBMPvUrnrpFD7A/dUZs02bLvikeL5Hsh+D0uTk3a1U2dG1HpRb
	 P8nm4CyvrnJZ+nnQ6khZAQrbY+X4f+Ll2nHkQVR1E7kZPlgUgCbg5LqLoucXdF9cfj
	 k+XuXh8BuBOFweE4yy/HO5yaMcNxyJrNDlnlYwQ8DATrZ2xzIVJvlqXKuLBc/QWGk8
	 HOGyjm2h7MYDTwNUuuNuqEAK1I8mUC2ecqHhi+dJno8fewwnn3rfdWD1y94wA1DBXQ
	 n8xtaPpDjTqlQ==
Message-ID: <55fd522918aa41f386e01432248933da.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240103072017.1646007-1-naman.trivedimanojbhai@amd.com>
References: <20240103072017.1646007-1-naman.trivedimanojbhai@amd.com>
Subject: Re: [PATCH] drivers: clk: zynqmp: remove clock name dependency
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
To: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>, abel.vesa@linaro.org, angelogioacchino.delregno@collabora.com, krzysztof.kozlowski@linaro.org, michal.simek@amd.com, mturquette@baylibre.com, robh@kernel.org
Date: Wed, 03 Jan 2024 17:00:06 -0800
User-Agent: alot/0.10

Quoting Naman Trivedi Manojbhai (2024-01-02 23:20:17)
> Currently, from zynqmp_get_parent_list() function the clock driver
> references the clock by name instead of its reference from device tree.
> This causes problem when the clock name in the device tree is changed.
>=20
> Remove hard dependency of clock name and update the logic to use clock
> reference from device tree instead of clock name.

Please use struct clk_parent_data instead.

