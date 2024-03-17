Return-Path: <linux-kernel+bounces-105457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9276987DE1D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2E62820CD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ABB1CA96;
	Sun, 17 Mar 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxbygR8P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084661CA81;
	Sun, 17 Mar 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710690593; cv=none; b=S33Im3mlrrZQsI+bkimazQ1X2kClt/W/pNq/RrjgT3ExnxvqL7DxwKIbuuwKsNRQ7pydU1D5UUDgckUQZvjNTJDjVHylj1J4xGdxzuvtcnXF5llibeTez1HmM1C+NL3UFW8HnW0lnZZo1/Otbmk0dK8E1tQ45NmmWKx/gRUmX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710690593; c=relaxed/simple;
	bh=zBeeVw9GvacUo+10PKMCjmHTesNMme7/GDSsUpdswac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwP2SQ4ZeXl/KCsp626NeQeWQbREPoCJQYLqod9TVoJfCDBOJEYTzG9EKH1piHMn0qXIO290jQzqdxdmKdm5E0axkXFMgsCMMkIz/WFnUFXm8F5fSwe7B2epjfIA5Q0EMt6Uh17gtYEb1palJdWW9o+VZFbzhzXxvoObrUxNRrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxbygR8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED76C433F1;
	Sun, 17 Mar 2024 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710690592;
	bh=zBeeVw9GvacUo+10PKMCjmHTesNMme7/GDSsUpdswac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxbygR8PB2lUqKbdTUjyhHUSAX96b8b7c9HexKdQT/gYMAwzfMANKTknMaMFzv+uw
	 Onse41VaMQLtjvzQUq7UT+rZGQyHFtqThgyaMTbP7aX21qmvkfqi6PWso1WBpb3QOk
	 AqNqpBMyUDLG6/qBWwOCMxb0NR/PuDTUpjEJusBlkYuEc4jwfzLJZfIffGsDsPwNfJ
	 eK201j+selDv0iLXCDNjI7gQnxoluna43TXPrkkySPSrSKu/QvjiVg1U2FMRLZx4F4
	 /Ff5bJLEEh+SyRb1bsGQ0bhTZj3mjZKLyprP5K1ZkK3orOAVkevaEO+B2mr/7b5BWd
	 Doe8Hzj5R7s6A==
Date: Sun, 17 Mar 2024 08:49:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Chandan Babu R <chandan.babu@oracle.com>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: Fix typo in comment
Message-ID: <20240317154951.GB1927156@frogsfrogsfrogs>
References: <20240317154731.2801-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317154731.2801-2-thorsten.blum@toblux.com>

On Sun, Mar 17, 2024 at 04:47:32PM +0100, Thorsten Blum wrote:
> s/somethign/something/
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_log_priv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
> index e30c06ec20e3..25b6d6cdd545 100644
> --- a/fs/xfs/xfs_log_priv.h
> +++ b/fs/xfs/xfs_log_priv.h
> @@ -683,7 +683,7 @@ xlog_valid_lsn(
>   * flags to control the kmalloc() behaviour within kvmalloc(). Hence kmalloc()
>   * will do direct reclaim and compaction in the slow path, both of which are
>   * horrendously expensive. We just want kmalloc to fail fast and fall back to
> - * vmalloc if it can't get somethign straight away from the free lists or
> + * vmalloc if it can't get something straight away from the free lists or
>   * buddy allocator. Hence we have to open code kvmalloc outselves here.
>   *
>   * This assumes that the caller uses memalloc_nofs_save task context here, so
> -- 
> 2.44.0
> 
> 

