Return-Path: <linux-kernel+bounces-81801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA07867A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A450A1F22F12
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2C712BEBD;
	Mon, 26 Feb 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5VB1e+G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C37D12AAEE;
	Mon, 26 Feb 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961296; cv=none; b=HO8NZZ7/Eddvif/VN5Kcebz1DPYAfiZOxluOkNn319x35kVcTTTbu7IWREdIf+pX/K7BSx416j4wbGgVAfe86uAPj0jj0BvlS+FUEP3/4E7Tw/mVO2RNrRPWNIF8Fzv7lY6yfx/ii8klMqiu5XU6PQk50azXmQ3QcwFmZiLGm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961296; c=relaxed/simple;
	bh=kn8CsHxeqDeP0T8Y+7WnbCgzGRh3dcKdz1ZaTvleJR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lamFvMTPhf8agC0CI3ih+oT3c7BEnugSU0k59VTv9qKuOQO4g9wU3W6Cydoj33zNdoKBLLTRIuu59LsbdMmkGCVjN8ETkN4wkd3a2iUH/Um1m9cYAJd1sR6TUqIlPK77Oklf5K65CgrgMuHEV7vBlbYUbHuw2S0xoqsglfh6aWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5VB1e+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6413CC433F1;
	Mon, 26 Feb 2024 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708961295;
	bh=kn8CsHxeqDeP0T8Y+7WnbCgzGRh3dcKdz1ZaTvleJR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r5VB1e+GKBGqyMISOJnMz7UmKSCHQI7f6E9Hz2sT1hHrDS1+gakIQz2YaMUfuQ/Pc
	 gpzrJtfVOJo3Yj9bdsVYbI9wvKMdGzBdL+jtOsEo/5EVPRBscKdC6nolxMib7xQsxp
	 1mLUs4+CpjR3zvgNcrg0LgVI1e33Hfbywurhqjs5YmaaA8Twahk/BCZtbv1IUXIv6g
	 u+kQArVJvHcuU+TqoFNLWkPCvBCEkYDzup4DwVtvFyE01URwBv1ZG2adQC9d3L1CkW
	 PQi4jb9TxdVSRtPG4jbAv6m02/ga4bi8V8ZhWAD9lSUTOufO+5dyRD1cp0xPLjMSdU
	 gSZPjU+3VuM1w==
Date: Mon, 26 Feb 2024 07:28:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: wenyang.linux@foxmail.com
Cc: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Joel Granados <j.granados@samsung.com>, Christian Brauner
 <brauner@kernel.org>, davem@davemloft.net, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] introduce sysctl SYSCTL_U8_MAX and
 SYSCTL_LONG_S32_MAX
Message-ID: <20240226072814.1d9ab85f@kernel.org>
In-Reply-To: <tencent_275FF7F351D515B570D0F82447BA30F3AA06@qq.com>
References: <tencent_275FF7F351D515B570D0F82447BA30F3AA06@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Feb 2024 12:05:30 +0800 wenyang.linux@foxmail.com wrote:
> The boundary check of multiple modules uses these static variables (such as
> two_five_five, n_65535, ue_int_max, etc), and they are also not changed.
> Therefore, add them to the shared sysctl_vals and sysctl_long_vals to avoid
> duplication. This also reduce the size a bit 

You provide no data on how big the reduction is.
Eric's suggestion to encode the values directly in the table entry
sounds great, please invest your time in that, instead of half measures.

