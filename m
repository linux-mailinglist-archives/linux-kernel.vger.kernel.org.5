Return-Path: <linux-kernel+bounces-104581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F386687D068
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319AD1C22B83
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CF23EA96;
	Fri, 15 Mar 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIFGOt9W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43CC1946C;
	Fri, 15 Mar 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710516902; cv=none; b=AmYL81HOMzrKOCIatYRejR62LBy/bVAmtoy8aPtQ2vldqgf0XrJRmsRCMhNgfFgmch/Nek//QIPBfdOkVdOphzxl86SJ5gQG82dr7fLUFlNdeO7RfA/hwBfKZBaVjMddw6ho+nNc7ikjU9K1zxvV/yx7zAjRpsRwWgASGQyK7fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710516902; c=relaxed/simple;
	bh=4Mbh4wTN4l0acjOafVieNblPuAn3MVy3J0dwXOH+nZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZSbxRVuUdLz4YOJx+Ns+JYp+XXZwlHI/z/M70aDvFht0MWWocwDaud1pCXhqz1lBKRfg24sMR+Jom2mUKnQyCBIC1n7gOkZeLskPneG5MT1g7q9jdOLkoQLF24SBJ0OwMF/x1uTCM0/ODO3FJ8HChvFCu1BGBAlxz4K1FQqRV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIFGOt9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67D6C433C7;
	Fri, 15 Mar 2024 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710516901;
	bh=4Mbh4wTN4l0acjOafVieNblPuAn3MVy3J0dwXOH+nZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIFGOt9WEi+rs8n9L6/eU7bjSyoSBJYpWft4q74RdYzXL1f762aaNvFOvraBL/y3k
	 +7LT6mlQUWzv2PNrGRxp5BcWkWX+ueV0RU6UQagANB/49Ppkx3P28D2NYdB+OW8Ybz
	 XpQBZfrNVFxSFIzITonzQsLJzRwdJzeY9Il7MQL5CCuElvxbagWeNZr9VLwizu3Jm0
	 FDI41R0/OzGUAUCifShbVo/AaD5tuuxjw30B2ompS2wWU8W64E++Z9cufxUlxMAB+P
	 JPrUuOiqVukCWxkdqzA0iPoJuhg7vFrdio6NLmiMyJlIgN1qxllbcB2CjUQO8gc80h
	 8X0NWrh7E7HTw==
Date: Fri, 15 Mar 2024 15:34:58 +0000
From: Eric Van Hensbergen <ericvh@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fs/9p: remove redundant pointer v9ses
Message-ID: <ZfRqohX3x7q2p952@1149290c588b>
References: <20240229222250.351322-1-colin.i.king@gmail.com>
 <ZeXFqt1NDp9sdz7n@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeXFqt1NDp9sdz7n@codewreck.org>

On Mon, Mar 04, 2024 at 09:59:22PM +0900, Dominique Martinet wrote:
> Colin Ian King wrote on Thu, Feb 29, 2024 at 10:22:50PM +0000:
> > Pointer v9ses is being assigned the value from the return of inlined
> > function v9fs_inode2v9ses (which just returns inode->i_sb->s_fs_info).
> > The pointer is not used after the assignment, so the variable is
> > redundant and can be removed.
> > 
> > Cleans up clang scan warnings such as:
> > fs/9p/vfs_inode_dotl.c:300:28: warning: variable 'v9ses' set but not
> > used [-Wunused-but-set-variable]
> 
> Thanks for the patch!
> 
> Eric, this appears to be for your -next tree as it doesn't build on
> master -- didn't notice the [next] in the subject line until I tried...
> (I've just build-checked on your tree and it appears correct there)
> 
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
> 
> -- 
> Dominique

Pulled into my for-next tree, will try to get into a part-2 pull
request.  Thanks.

   -eric

