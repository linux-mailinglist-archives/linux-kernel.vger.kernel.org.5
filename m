Return-Path: <linux-kernel+bounces-123792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3D3890DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0001F22AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4E6548EB;
	Thu, 28 Mar 2024 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVkDgH17"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713778F6B;
	Thu, 28 Mar 2024 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711666803; cv=none; b=hj2RaJi+gQVJrwLaTCyIW75HI/qVZN+zrKbDUzxCDtEWAfjcdFqyxtp0e02RbPWqihklYx9nKrdnb4bysgWopGGrFWFJl5xnQLlUAJ4dUsL+ZvxN0BmDZsRu/3xOAnsm3EzPMl8xd7/Tb3dS93+6ROOA/w0IBDYvpizswmfrcpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711666803; c=relaxed/simple;
	bh=QwcIs7KpIAiawzl4YLtzgEKHBecDVCX3HkOsrjsohvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJv3vWyaOzOW7C/YjH+06uynVfTbKPuMtHtx6KZ4amJWCbNb5suXtuAnMBDtetBWVBQOItWai7EP3SfdH4hgxIgW8knevAx2MxRwRLiWUqb+Zw3HImXj0VgHWlVHvNooNABjhrwZG7kHcpePGRqT/dCkvf7fkd0gmLkzfuFSBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVkDgH17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4966C433F1;
	Thu, 28 Mar 2024 23:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711666803;
	bh=QwcIs7KpIAiawzl4YLtzgEKHBecDVCX3HkOsrjsohvo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mVkDgH17hEkiKBZzXZvp5iPHCr2I7ihxDPFounV7hMMz4PHmPo8UvcdatNny5Vf9+
	 aibO8eQ8yMfIKLREj6PK71qnh1kzlQrRRn2imbuGlzq39QJZ495vAJA7TCDtF09uJM
	 fwTr5t38cUNv0UAfygrEXgRN6wa/nED8lK3k2D7Y9uZxWPvaLBmh+g5mFxrLx/wwL7
	 xfUu4kgpOukgyv/DkqtLfpKsTRAyqgkSg5cvoKMDHzQGKKWjK6bht4GRHPIgHy+XFl
	 6RsqLQtWlxwMmrEetOM2AVmle9uRzHsrDF1O6FdfUfFXd6efGXXjmGclbPmXjnG45/
	 sF3OPTs5GrOvw==
Message-ID: <595a03f6-e93a-4f2c-bf0a-01e428897c15@kernel.org>
Date: Fri, 29 Mar 2024 08:00:00 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10/5.15] ata: libata-scsi: check cdb length for
 VARIABLE_LENGTH_CMD commands
To: Mikhail Ukhin <mish.uxin2012@yandex.ru>, Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>, Pavel Koshutin
 <koshutin.pavel@yandex.ru>, Artem Sadovnikov <ancowi69@gmail.com>,
 Mikhail Ivanov <iwanov-23@bk.ru>
References: <20240328150026.9129-1-mish.uxin2012@yandex.ru>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240328150026.9129-1-mish.uxin2012@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/24 00:00, Mikhail Ukhin wrote:
> Fuzzing of 5.10 stable branch reports a slab-out-of-bounds error in
> ata_scsi_pass_thru.
> 
> The error is fixed in 5.18 by commit ce70fd9a551a ("scsi: core: Remove the
> cmd field from struct scsi_request").
> Backporting this commit would require significant changes to the code so
> it is bettter to use a simple fix for that particular error.
> 
> The problem is that the length of the received SCSI command is not
> validated if scsi_op == VARIABLE_LENGTH_CMD. It can lead to out-of-bounds
> reading if the user sends a request with SCSI command of length less than
> 32.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
> Signed-off-by: Mikhail Ivanov <iwanov-23@bk.ru>

This looks OK to me, but:
1) Please stop using the wrong email address for me. Use
scripts/get_maintainer.pl to see the correct email address (the one I am using
now). And maintainers & main list should not be on cc but part of the "to:"
addressing.
2) Please read Documentation/process/stable-kernel-rules.rst and see Option 3. I
cannot take this patch. It needs to go through the stable tree after I Ack it.

> ---
>  drivers/ata/libata-scsi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index dfa090ccd21c..77589e911d3d 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4065,6 +4065,9 @@ int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
>  
>  	if (unlikely(!scmd->cmd_len))
>  		goto bad_cdb_len;
> +
> +	if (scsi_op == VARIABLE_LENGTH_CMD && scmd->cmd_len < 32)
> +		goto bad_cdb_len;
>  
>  	if (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ZAC) {
>  		if (unlikely(scmd->cmd_len > dev->cdb_len))

-- 
Damien Le Moal
Western Digital Research


