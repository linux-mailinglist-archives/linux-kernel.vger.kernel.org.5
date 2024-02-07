Return-Path: <linux-kernel+bounces-56899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A16B784D0FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2714DB2418F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B638595B;
	Wed,  7 Feb 2024 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNIk7sJY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED12D1B7F0;
	Wed,  7 Feb 2024 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329654; cv=none; b=dARabMFGsWk/mcq0nTnASGLyC7VBjQcvtfh2pa6IbVns7WgaZmd4xMHqgwjagX30B07n1R9kFXjVdP7/8hO61TaSAy5qDe3danrDhe8LxtqUEl52SoSeBsPvqsHn7EoS5KS7IorD1hv3HA+hmMJEzjazhE1ZyK16JND+HDm9xIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329654; c=relaxed/simple;
	bh=eP/zI19SPSRRm5KxM8isKzsQV4/zUTMHBunc8dphjiQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RM5ndtjjln+t7inZ8g+zX6G3FjPZEv5cgw3tXfZwQdsdez39+z0i134fCFbG2I3CSJWlAUPiBasgmlslf7YbKW+Ra+725IFIhmEQF5SJSVxtcn1yDkskww9rTHjy8x9JFNSqYzzgRSHk3y5Ldi8N/EaH1/jOAdXF+OdRYFtR1eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNIk7sJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE4AC433C7;
	Wed,  7 Feb 2024 18:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707329653;
	bh=eP/zI19SPSRRm5KxM8isKzsQV4/zUTMHBunc8dphjiQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=vNIk7sJY8Qm62mFrkb9lpQ2YkFwH1W4nUltIhZOtUc89p+x8O5FSy/PKtcc5BW9m5
	 PyRVmOcpwKB0kPded1Vy4YMwNAcgkr3mBQ0nnI2446aEW9E/ei3yX1dJs0Pc7/dT0v
	 vJAqPmHIGtxul7dJmmxFFuEtwCgwINP0YPmNJgFXSjHnrMV8DIK9KmqUC77ukMLM2K
	 Q9mFSYpTbJLARpyPrQ1svxG1lNFt9a5QWMGTxs4NjTNffdv9L77DBsV7tg9Sxu8o1o
	 hZu++QLeWmOkMP1Dt0bIefJNlAS4CB2PDwujEIPAGTe1tVqBMBvpTph7Dv/CjC19bH
	 qK2rWKyjMZlDA==
From: Kalle Valo <kvalo@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Christian Lamparter <chunkeey@googlemail.com>,
  linux-wireless@vger.kernel.org,  kernel-janitors@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] carl9170: Remove redundant assignment to pointer
 super
References: <20240207171524.2458418-1-colin.i.king@gmail.com>
Date: Wed, 07 Feb 2024 20:12:00 +0200
In-Reply-To: <20240207171524.2458418-1-colin.i.king@gmail.com> (Colin Ian
	King's message of "Wed, 7 Feb 2024 17:15:24 +0000")
Message-ID: <87a5ocgn4f.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Ian King <colin.i.king@gmail.com> writes:

> The pointer super is being assigned a value that is not being read, it
> is being re-assigned later. The assignment is redundant and can be
> removed.
>
> Cleans up clang scan warning:
> drivers/net/wireless/ath/carl9170/tx.c:192:34: warning: Value stored to
> 'super' during its initialization is never read [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Same here, "wifi:" missing. I can add it, no need to resend because of
this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

