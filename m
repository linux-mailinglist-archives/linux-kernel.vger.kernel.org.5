Return-Path: <linux-kernel+bounces-65761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042FA855165
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6BA1C22B87
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88EC12FF8D;
	Wed, 14 Feb 2024 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyG83SQn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1183D12FF67;
	Wed, 14 Feb 2024 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933495; cv=none; b=gnn1vUqOp/aEP3TKsoLft6GPn8LUTixsyj3Sb7u+Rd+L/H6IgcTi54tnlMTN2pVFL6Vg9RjFWfz+dYApyP4NK40f5tjpw/jXkTKPfVPq9kO4S6MgMjcokEczQ1GXzsZWlLgahZbPRH5mU1u1Z6rnofpW69Y+kUZl9A5GoxlSMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933495; c=relaxed/simple;
	bh=8XAR8VG6+3dDOUtJ+wKBf06KI2MpuezZuwn0g6OrdIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3aKpXFRNdHxH2XetBo/Es6UgK+i9nwkrw3umH1JntPditSgYxkR9/GpZFJhVVMrdk8z4QatvotavR1s/oRvxf7V9FN6CWEnn58J32Ijvh8yBSSng0pDKf42PmXBSpaS55zEvLAl2W53/LzIHW83Bm2TEGEN3q6mECLIClK9Fz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyG83SQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E851DC433C7;
	Wed, 14 Feb 2024 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933494;
	bh=8XAR8VG6+3dDOUtJ+wKBf06KI2MpuezZuwn0g6OrdIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LyG83SQnZqpk6BNacTJdo/v/XFn1rd2KEdMJqcL6s5ARj4ygwmLCN+Dbi2w8ZCufy
	 EuApGzQuthxXoGFW+DowmqVNq7msqZ4vEe6cQH8AV/M9FAGWGISElLH4Av0LuN5F87
	 mN+X2FGbG3M7ycXLA1zrOJO5LlrKE/wQlqvzIF7ClEaS1hUA+YtqUOyalMCa+ab/9c
	 JNgasX+yu7QJoZMf49ToQLnh+2hw10aQYfYHpeY32N+AC0XYSm0FcWl2keIavJsYlk
	 /nDngg1C+yFSfnLU3G2o8cMEFniLI+RApZT2zQS4qVUNj1InYMoKwSYPHxT1KSZ84y
	 z246+ZSOz72ww==
From: Bjorn Andersson <andersson@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>
Cc: alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] soc: qcom: apr: make aprbus const
Date: Wed, 14 Feb 2024 11:57:42 -0600
Message-ID: <170793345820.27225.42969581094596997.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213-bus_cleanup-apr-v1-1-50c824eec06d@marliere.net>
References: <20240213-bus_cleanup-apr-v1-1-50c824eec06d@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 13 Feb 2024 11:44:01 -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the aprbus variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: apr: make aprbus const
      commit: d2e8899de71cd0a3c22a0eadfb9d54604d34eb96

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

