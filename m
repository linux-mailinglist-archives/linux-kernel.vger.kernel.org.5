Return-Path: <linux-kernel+bounces-139933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5778A0944
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C61B1C21CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B25E13D63E;
	Thu, 11 Apr 2024 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXPcKkIO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB7913DDDE;
	Thu, 11 Apr 2024 07:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819249; cv=none; b=SABATtvVbwJWwYQokzhYJNywx8rgYFFotTEjzeJekx2HOqm4XwZVDt4BzhnF3oEPRiNpQAqxUnJARa7T6DgTZBwz0L4yR95e3H3GGWSlWEv1sln7xfoYITR4urXjsxguGPQ07X4N8kv+5pMKYh9D762KBl7copEFTZhAHU3KNkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819249; c=relaxed/simple;
	bh=g9w7QPP23scPB5Y2VIp+lDrwFcVCGp13oTZr88kKO30=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=XuYmzAhPUipOfrZXF9hYXjj5QDY7fmGF7FwB29sQ8XmLa4hfmCk/rJHvMsL7/K+wFNxN5nF1OYJZsNZNBIdLGvX7udJC91Z9YdWbL7ebI6SlHJBTd47KfSIlfjOhP/+Tf9w4zkFDszkYF8uzh6AnczOrAIU4WLqP5Bbq+akFO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXPcKkIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E23C433C7;
	Thu, 11 Apr 2024 07:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712819249;
	bh=g9w7QPP23scPB5Y2VIp+lDrwFcVCGp13oTZr88kKO30=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=NXPcKkIOtfXWcJ2IdcaLFnmjz5+C7cwo0GBSrQqToUPoBU+SCyXSyYPu5oI5VAVpP
	 OfGkOS9bJ03eW80WtH8vazmoJ7DPEXgMidYXJd4PXUunyE/FEoHWjeuRzO7tJsPTsa
	 rtVe2rRJ4SxJl9nA6CqvRl0rLENEfo/cZv0L6S0ZXE8PCYcol8GpcCCtVB+zocROyV
	 EFAx03FK6qPPBaG/ioMn+odph9nD0ZL2MpFzLTGZ8oTq6yl8yElqZ2vNLCyvtXJcpO
	 mjs9FrFJQ7l3V/oGZpFv+5fl2PdXB1bz2z4Wf0mwlrHEk8K93E/jVQ8z/euh9ECkyF
	 HMEPmQwJE70zA==
Message-ID: <8861e9e249e5568116094112c567b141.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <IA1PR20MB49534F37F802CAF117364D66BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com> <IA1PR20MB49534F37F802CAF117364D66BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
Subject: Re: [PATCH v9 2/6] clk: sophgo: Add clock support for CV1800 SoC
From: Stephen Boyd <sboyd@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
To: Albert Ou <aou@eecs.berkeley.edu>, Chao Wei <chao.wei@sophgo.com>, Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh+dt@kernel.org>
Date: Thu, 11 Apr 2024 00:07:26 -0700
User-Agent: alot/0.10

Quoting Inochi Amaoto (2024-03-09 01:02:52)
> Add clock definition and driver code for CV1800 SoC.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Link: https://github.com/milkv-duo/duo-files/blob/6f4e9b8ecb459e017cca1a8=
df248a19ca70837a3/duo/datasheet/CV180X-Clock-v1.xlsx
> Link: https://github.com/milkv-duo/duo-files/blob/6f4e9b8ecb459e017cca1a8=
df248a19ca70837a3/duo/datasheet/CV1800B-CV1801B-Preliminary-Datasheet-full-=
en.pdf
> ---

Applied to clk-next

