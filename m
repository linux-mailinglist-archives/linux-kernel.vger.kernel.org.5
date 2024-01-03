Return-Path: <linux-kernel+bounces-15711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2258230B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C071F248A2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071EC1B274;
	Wed,  3 Jan 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5wYjywN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B03C1B26C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63891C433C8;
	Wed,  3 Jan 2024 15:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704296576;
	bh=GarURSTcP+YnofkLmtfNQMJqwx2ZzQwSNEcqtEu05iI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n5wYjywNLObbEFcWJCkbDmq0GycIVVA2zmUKE6BMPjyLA7wF61ye8oRhCVGRyWi3I
	 p1PNIDK93u53bwXvUyylrYbcYwkYf09KAsU9sx11eyWc/KqTlaSxE2mX7N/qT5dxhg
	 fzwKqRPQHddMEHZ0JamWiDLdHeACgB9fzQ4OuVbhmI5tErXQdVmEoin/zs4xNufnpA
	 TvWhnpEE/vqFiJLP6z7tthgFFLyuHt2PONPRgSOAOQtj71MIbcMgAUSzQItYiqhti+
	 3kg8V1R90l71wGYjFLqMGfOEVbtFAPbR7xOz0mVSRV6ETq13TVrpIdzQ1V/CCwonxP
	 boshpWWnySp1w==
Message-ID: <b3732d2b-f6cf-4bf7-af1d-3ee7c4acfd3a@kernel.org>
Date: Wed, 3 Jan 2024 17:42:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/accel/habanalabs: Remove unnecessary braces from
 if statement
Content-Language: en-US
To: Malkoot Khan <engr.mkhan1990@gmail.com>
Cc: fkassabri@habana.ai, ttayar@habana.ai, stanislaw.gruszka@linux.intel.com,
 kelbaz@habana.ai, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20231228210858.114111-1-engr.mkhan1990@gmail.com>
From: Oded Gabbay <ogabbay@kernel.org>
In-Reply-To: <20231228210858.114111-1-engr.mkhan1990@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/12/2023 23:08, Malkoot Khan wrote:
> The coding style in the Linux kernel prefers not to use
> braces for single-statement if conditions.
> This patch removes the unnecessary braces from an if statement
> in the file drivers/accel/habanalabs/common/command_submission.c,
> which also resolves a coding style warning.
> 
> Signed-off-by: Malkoot Khan <engr.mkhan1990@gmail.com>
> ---
>   drivers/accel/habanalabs/common/command_submission.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
> index 3aa6eeef443b..39e23d625a3c 100644
> --- a/drivers/accel/habanalabs/common/command_submission.c
> +++ b/drivers/accel/habanalabs/common/command_submission.c
> @@ -1360,9 +1360,8 @@ static int hl_cs_sanity_checks(struct hl_fpriv *hpriv, union hl_cs_args *args)
>   			return -EINVAL;
>   		}
>   
> -	if (!hl_device_operational(hdev, &status)) {
> +	if (!hl_device_operational(hdev, &status))
>   		return -EBUSY;
> -	}
>   
>   	if ((args->in.cs_flags & HL_CS_FLAGS_STAGED_SUBMISSION) &&
>   			!hdev->supports_staged_submission) {

Thanks for the patch.
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next.
Oded

