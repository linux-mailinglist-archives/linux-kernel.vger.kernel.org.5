Return-Path: <linux-kernel+bounces-55428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADC084BC98
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D5A1F2613C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75444DF5C;
	Tue,  6 Feb 2024 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkL8A1xC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62C0DDD2;
	Tue,  6 Feb 2024 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242179; cv=none; b=OEq+siMHuhe0XUJSeJ6H9+sBzBimeNtUnRjLutfW5uAbnRh0YkbxDVBr+GKvgO4OrRw4GpgtX51V61X3XnburwLwJO7HpThXsGl5Hx1aLk4diGWYQuH6qd76M+AvqyI9QyMTHD1kkIArvHmsJRJXCD40euhZHqEnCc8Gf9wRlsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242179; c=relaxed/simple;
	bh=pfj+UtF7zsGS/RC9920xUYfQDQHC6Qd17Xl6bNbnKh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc1r4QuFKAPb7n7Zzn9S8VH2MDWb6BcD6+uPk0RkeP4WmFgtrp02RAo8+5hcWExyzU9VNxPvTK6VXBvgxS6SQpxSHWIvw2wjVIw7RxJ85H7MlZZrqF6i6Vynfcv66rTeHU3HdjbkaJ16XU2PFKSi9t6Bv6iAjm2ddXr6FBvv6g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkL8A1xC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D310C433F1;
	Tue,  6 Feb 2024 17:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707242179;
	bh=pfj+UtF7zsGS/RC9920xUYfQDQHC6Qd17Xl6bNbnKh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YkL8A1xCK0+Q8mu7fIAhPgxsg0BCU5dMof1kXXldS7Ki51Z9Ze2qQMRwIrXEQCouz
	 GYZLOxMJ/g5yv78xOVHLW/xgh9r9WfvDyeiIzCjZ0v9u37i2fxUBPZb3PPQ2dQMts0
	 t8bkiuj+7axEN9eb8o/aLMQaFPr/en/7DWosQbJKi7a767GgRe32N38Upmn94XRg5Q
	 aXRzwyiU0rDPSMTumPihS0NLXZ3/1Tgbi83NO7u38Rcyf1NXvrCGtpfhZKASR2DVoE
	 0NXl0L65ld/0yhc1wIujXGek5T3fRqQxnqxvvW4pKqf0ZHTHPt1OCoHNnMF+u4snHR
	 VunpOzorCPgVw==
Date: Tue, 6 Feb 2024 17:56:14 +0000
From: Simon Horman <horms@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>, linux-kernel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH] net: tipc: remove redundant 'bool' from
 CONFIG_TIPC_{MEDIA_UDP,CRYPTO}
Message-ID: <20240206175614.GG1104779@kernel.org>
References: <20240204131226.57865-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204131226.57865-1-masahiroy@kernel.org>

On Sun, Feb 04, 2024 at 10:12:26PM +0900, Masahiro Yamada wrote:
> The 'bool' is already specified for these options.
> 
> The second 'bool' under the help message is redundant.
> 
> While I am here, I moved 'default y' above, as it is common to place
> the help text last.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks Yamada-san,

this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

