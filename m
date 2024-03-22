Return-Path: <linux-kernel+bounces-111575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83704886DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A501F2285A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B3246525;
	Fri, 22 Mar 2024 14:07:56 +0000 (UTC)
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6F146435
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116475; cv=none; b=U7FDxhEslXBJYSrODFphCPACFP57Yh37HVbK3JiKHH9FBsWlbDLclgSzAMWoEfD/8vd63ZKEKn0xZmfM+552P91MZC64rj/A4dtgDx82CwoE7x7ZQujPbh9msZET0qEFNkDFEWYc7IwQk4dwGB9K8JRlgAYoNkU0al24ngz0dmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116475; c=relaxed/simple;
	bh=g8FIvGSbCjzbLwow6pOtlOb5D1NJisaPBfKV0nWX/LE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s+cmBKqs4tQi1tAS0oxZMiTISTgPkZIAkLO2eet27R43LlUZ7eJBJRQzq2Kc8sp7ood/PIvgG0EcXHmfZfuF/G/1knNlp1hIDDHxq0zOTkWTbrjW7WRZFdCQYDAyZmlen8FZPBOGsr/c/lRkUflqytWkxEaAn5CD/w96isUcpTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 2F354205DB9A;
	Fri, 22 Mar 2024 23:07:45 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 42ME7hv2198824
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 23:07:44 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 42ME7hlU1198250
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 23:07:43 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 42ME7htj1198249;
	Fri, 22 Mar 2024 23:07:43 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next v2] fs: Add kernel-doc comments to fat_parse_long()
In-Reply-To: <20240322073724.102332-1-yang.lee@linux.alibaba.com> (Yang Li's
	message of "Fri, 22 Mar 2024 15:37:24 +0800")
References: <20240322073724.102332-1-yang.lee@linux.alibaba.com>
Date: Fri, 22 Mar 2024 23:07:43 +0900
Message-ID: <87msqqtl5c.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yang Li <yang.lee@linux.alibaba.com> writes:

> This commit adds kernel-doc style comments with complete parameter
> descriptions for the function fat_parse_long.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Looks good.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/dir.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 00235b8a1823..8236807eb7f7 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -269,6 +269,16 @@ enum { PARSE_INVALID = 1, PARSE_NOT_LONGNAME, PARSE_EOF, };
>  /**
>   * fat_parse_long - Parse extended directory entry.
>   *
> + * @dir: Pointer to the inode that represents the directory.
> + * @pos: On input, contains the starting position to read from.
> + *       On output, updated with the new position.
> + * @bh: Pointer to the buffer head that may be used for reading directory
> + *	 entries. May be updated.
> + * @de: On input, points to the current directory entry.
> + *      On output, points to the next directory entry.
> + * @unicode: Pointer to a buffer where the parsed Unicode long filename will be
> + *	      stored.
> + * @nr_slots: Pointer to a variable that will store the number of longname
> + *	       slots found.
> + *
>   * This function returns zero on success, negative value on error, or one of
>   * the following:
>   *

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

