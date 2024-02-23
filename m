Return-Path: <linux-kernel+bounces-78662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1608616BF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCBA1285B58
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A1A83A13;
	Fri, 23 Feb 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9Yi6KBM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3252232D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704157; cv=none; b=HNItIaJ2ctzoHsNpZLHle7XgacnB8MVUqRSFOsvq/F5w8syPzN3qxoLifvxsSpzWCtLfFtbRhDg//xIRRz3+bOshu6ioQX0uCDZeg+yV7kyQ4iczSOoCJdyMNcgo2hJ+OrAvWVFyfYsYvJZtj3y9hopNCYK5ePMMySm8TU+Dd1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704157; c=relaxed/simple;
	bh=yFqxB5RB3u/RLZEPPk/vFtxcGh+SHxSeLpf9kehgx0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IE+6jJyL9PASJvIFgI8AyTO2WgQKmF8GL4QuxiPRHk3YgybIRnjQ87gLa6ShY6VH6OmyoiSRdpTPqgo//y9LdS375m6ZXitvyMmOwMAkBq67tkGRBuS4gYEP+E9teD6/qMy3qAoaokVTZwqV4Iy/j4MM6sl8vMcGJNHiLXN29ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9Yi6KBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E8DC43399;
	Fri, 23 Feb 2024 16:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704156;
	bh=yFqxB5RB3u/RLZEPPk/vFtxcGh+SHxSeLpf9kehgx0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h9Yi6KBM+bfe1twyM83dVvJBJsIs1/WJF5ZDS0+AH/1r/O92tPkdd6R+KUbqwWciZ
	 9HCPsMnwXHhrlhHH7O8lEM7Gy+zMPepf8Sk0yMYwePgXoCHLEvc7Xdg3xYtXUrtji7
	 NN1MeT97AwvVNt8quniGl604q6aVHGi5huUFOYM8BR8eOh0+IVA2tcoxH8m8Imu78d
	 gwGl3Zy+xneeeeajPhG4lbFSHFAtpfKy13l3Z4egvTqXgvcwkkHRoV9BruUM+xe3kk
	 PRy6wZruwtFuRZD3lKLPXAWrPV0fS0VlkZimKfkuib1Ih7fZN5s5vnPAASKx1FM4Cn
	 RmhwBVUu2RoJg==
From: Lee Jones <lee@kernel.org>
To: arnd@arndb.de, lee@kernel.org, thor.thayer@linux.intel.com, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: kernel-team@android.com, krzysztof.kozlowski@linaro.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 pankaj.dubey@samsung.com, tudor.ambarus@linaro.org, 
 andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com
In-Reply-To: <20240220115012.471689-1-peter.griffin@linaro.org>
References: <20240220115012.471689-1-peter.griffin@linaro.org>
Subject: Re: [PATCH 0/3] mfd syscon and altera-sysmgr cleanup
Message-Id: <170870415412.1726445.3923431976204064450.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 16:02:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 20 Feb 2024 11:50:09 +0000, Peter Griffin wrote:
> Whilst implementing a driver similar to altera-sysmgr for exynos
> it was noticed during the review feedback that we should only call
> of_node_put() if the property is provided otherwise nothing has
> taken a reference on the node. Both syscon and altera-sysmgr also
> have the same issue which this series fixes.
> 
> Another piece of review feedback was not to use extern keyword in
> the header file, so I also cleaned that up whilst being here.
> 
> [...]

Applied, thanks!

[1/3] mfd: syscon: call of_node_put() only when of_parse_phandle() takes a ref
      commit: d2b0680cf3b05490b579e71b0df6e07451977745
[2/3] mfd: syscon: remove extern from function prototypes
      commit: 0db017f8edd9b9af818bc1d68ba578df1b4c4628
[3/3] mfd: altera-sysmgr: call of_node_put() only when of_parse_phandle() takes a ref
      commit: e28c28a34ee9fa2ea671a20e5e7064e6220d55e7

--
Lee Jones [李琼斯]


