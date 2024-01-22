Return-Path: <linux-kernel+bounces-33722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB3A836EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DCAAB2D684
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB7B40BEE;
	Mon, 22 Jan 2024 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQxRzm8N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BA759B60;
	Mon, 22 Jan 2024 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942207; cv=none; b=XnZeiIFZFC56vfZMl7jRP06wOB7xNujYNuvRHowlMk8fVx1HJP8qAXvF0jJQ+8LLtFNvSuEwri3JH+0FTvdlgZqzFdIjwjpkGvBttJWejJ3h6cQyxptT2XomzIMGMxaajOnnO1+XrR/Gpl+zmdHIYWyslUKR0P6Ma+oOK+9cMmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942207; c=relaxed/simple;
	bh=q1lhDD+cIgPCZh2Kn/rq0KEGanKmuSZDdamv/rhM/cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUtJWmlLZprKyu1jiD3JgbcJdJkf/erms5c4080QosflcKt4iRE2rk2C6MFcni5Y6DmNoGp+z/ubA/waePodL6UNw4gy7G6A3AQjA1yIKAW+g+sYzWLW53gfXghylzQ8j33no433EuSvuYrPB+grp4yFQ1oP1av4IQOOZz1DO/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQxRzm8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801EDC433C7;
	Mon, 22 Jan 2024 16:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705942207;
	bh=q1lhDD+cIgPCZh2Kn/rq0KEGanKmuSZDdamv/rhM/cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQxRzm8NCjnQFzcqC0sfTzGAA2tmgoa99QOPvMV/ZpBCpbWL2DjhnJcClVT6Rum6m
	 YVqoEu52/vSDf4RnIQlO+vsJm7xMwA1xaI4DsCZh2GPAeSCmqJ+qWVYxl8RW8Wf6d1
	 fJrojsCZB8QGjAQpmjzjU+AjBlxHG4JYjmP+cbStSyo65sU71OBm0XD8Ir+LJAhmpQ
	 ShCI+TmaQyZxPJ2iDj6yO2rV8e04bd7VL6RqYhi4mKQepc3qWNh40hP8a3QZXnFszJ
	 JkcbYHo+yVMssJxFdQu5iPt5wPwOTCZnM+3aNeSoGaCLBomw2pyVJRJTqjmk2irD1Q
	 IIkbLqbhYGj0g==
Date: Mon, 22 Jan 2024 10:50:04 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] pinctrl: qcom: Remove QDF2xxx support
Message-ID: <oqggi3rbu6etf3i55hmn446xkpcbj34weppcxort367ziam2uf@oah4xwewna73>
References: <20240122-topic-qdf_cleanup_pinctrl-v1-0-0c619ea25091@linaro.org>
 <20240122-topic-qdf_cleanup_pinctrl-v1-1-0c619ea25091@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-topic-qdf_cleanup_pinctrl-v1-1-0c619ea25091@linaro.org>

On Mon, Jan 22, 2024 at 12:57:12PM +0100, Konrad Dybcio wrote:
> This SoC family was destined for server use, featuring Qualcomm's very
> interesting Kryo cores (before "Kryo" became a marketing term for Arm
> cores with small modifications). It did however not leave the labs of
> Qualcomm and presumably some partners, nor was it ever productized.
> 
> Remove this driver, as it seems to be long obsolete.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

