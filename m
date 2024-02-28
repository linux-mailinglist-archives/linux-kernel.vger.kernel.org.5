Return-Path: <linux-kernel+bounces-85807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ECF86BB02
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE401F26B27
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC51772903;
	Wed, 28 Feb 2024 22:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig2DdpEH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153C51361C4;
	Wed, 28 Feb 2024 22:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160768; cv=none; b=QAIWOPEs1D7CbuHCtU1bqfCtlhTFGvqHMqwnaALYIWshfoV2enOH/cpDbXR6dHYmZ4GOOvOvj8gJoo1pocWaFLTLefT6FOdNe3LKWYgFLpIhG8aNmq1empLbQ3nVh0aj4+A+kGk3waw6od18CK0SzXzJEK9mY61kxmF1GV0cqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160768; c=relaxed/simple;
	bh=rp5tVm36pOFi7dx64Dt/TsUDvBpUSC1wYSU105mX2PU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=V5FH5TtXzAeFrn4iRK6qaBsmc/ZrqkbTRttSWzwjhUukF3fcXaN4Vr67rmnwBkX8S2imW+/HWhOLgSe/Sk0abVDkkknGbnehgnbrWXF6v/SJZGBU5X3fICSK5KqBGBDz/Z5fOF/0uxbDJmxgsnVxAGgtlfubryrEK9ZJioE4HTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig2DdpEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9538C433C7;
	Wed, 28 Feb 2024 22:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709160767;
	bh=rp5tVm36pOFi7dx64Dt/TsUDvBpUSC1wYSU105mX2PU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Ig2DdpEHakycymqnNy15snbZp0I4HbIi4BpEasJXH1D3fcloMOav5lrFBgx6S2JBv
	 b5F+KzrIRvVT71I4eLFIgLH9uStyNgE99TftvtIW151BfnD9nyb/o4bEVtKOvW/hZS
	 QKiNwHG8uz1pywAghTvmTXfSbB0dZ2dmV3WzX74Y0HGM+H1NA1yUUVWBI0M21aOCgB
	 Rwq4ZhHvO/54OzQyYr9b1EMRZ43cWC8tO34YAQ8Y9gMIUM1ryL6V/vEQ4VHxNE3OHL
	 fLRgKF+8eeyEy2cytGn8pbbDEst5mrNBZ4D76FOjAdhXtnr3r+NOAPJyX9x3zLamUt
	 geE7IiDwdnmxw==
Message-ID: <db086a936b9583a9caca3117f830fedb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240223134347.3908301-1-colin.i.king@gmail.com>
References: <20240223134347.3908301-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] clk: clocking-wizard: Remove redundant initialization of pointer div_addr
From: Stephen Boyd <sboyd@kernel.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To: Colin Ian King <colin.i.king@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Date: Wed, 28 Feb 2024 14:52:45 -0800
User-Agent: alot/0.10

Quoting Colin Ian King (2024-02-23 05:43:47)
> The pointer div_addr is being assigned a value that is never used, it is
> being re-assigned a different value near the end of the function where
> it is being read in the next statement. The initialization is redundant
> and can be removed.
>=20
> Cleans up clang scan build warning:
> drivers/clk/xilinx/clk-xlnx-clock-wizard.c:501:16: warning: Value stored
> to 'div_addr' during its initialization is never read [deadcode.DeadStore=
s]
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Applied to clk-next

