Return-Path: <linux-kernel+bounces-67657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFC4856EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127E828693E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F308513B28B;
	Thu, 15 Feb 2024 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8NJAw/Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D26713AA4B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708029391; cv=none; b=tYacrbT5bNnejZilxwtVcX4+2Zei5M4i8OuM8QIMhsqYfeLDrDgxtSjAxgJw4HZkoBjDf1o6YPxo5fPMlQ5tjavoTJrCA8h4BAXpfuiT03TQnNcIOGczjnYHzCleZvNMVQisHqQ758s42B/8bj1vpT7xBtIbf65djFE0/5g5g/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708029391; c=relaxed/simple;
	bh=w+4GQYEtYb0/zUI+FYlPpcP4BX3/rQPTNBehFhxJT4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LF6oObycBrW3bgOJVj9XvzgdcHLuupbCJ99qd+cOfn+9lYIJwr9j5FjoqP6WvWviS0x0ySO1PwsxbfNgvHL0D0Z6XQ3vtv2XCsMV8A2siZixhmUkVK5aabp2jie/gTq/8ctn4+GDBfcZoLsr7gdHzvojj6y+cxrxMEQB2Mab1Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8NJAw/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F9FC433F1;
	Thu, 15 Feb 2024 20:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708029390;
	bh=w+4GQYEtYb0/zUI+FYlPpcP4BX3/rQPTNBehFhxJT4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8NJAw/Z9xiQYM8H5eWT6FTLuFCAe4wOAiQFGKvaQuhgkvG4bEZRG7cF/Ir4V8Fhk
	 twbzSYtUFp9Z+4aO557z4jvS5Nk/dMhlOQtKVP7fW0Y4VEQg3nqh8GAu2H4/ZVtkOP
	 OM5kJ49BnGHFc5emwzZkZqfAVYwUZl8jw5HtUV9vOJACak+XbyAx27tVrGG2sgYvvA
	 lDkaFdZm6aspUE8yET7bg/WIa896NwL8bTZolSlRclL6BI32coChWkCsUCcCpjkbwQ
	 4LdScP7jr+oP0f2S4CE++jXGTQ+O45ssMsCa6HlI/bPkuU5w3ImJ/sOGm2hRdWYjSB
	 Q2LUa4YPnUF/w==
Date: Thu, 15 Feb 2024 12:36:29 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH] f2fs_io: add lseek command to execute lseek()
Message-ID: <Zc51zeFF3DrUXMem@google.com>
References: <20240215201053.2364270-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215201053.2364270-1-daeho43@gmail.com>

On 02/15, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added lseek command to support lseek() for SEEK_DATA and SEEK_HOLE.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  tools/f2fs_io/f2fs_io.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index e7d286a..b5c5b97 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -1630,6 +1630,43 @@ static void do_removexattr(int argc, char **argv, const struct cmd_desc *cmd)
>  	exit(0);
>  }
>  
> +#define lseek_desc "do lseek for SEEK_DATA or SEEK_HOLE for a file"
> +#define lseek_help					\
> +"f2fs_io lseek [whence] [offset] [file_path]\n\n"	\
> +"Do lseek file data in file_path\n"			\
> +"whence can be\n"					\

Can we also have all the other options as well?

> +"  data     : SEEK_DATA, return the file offset to the next data location from offset\n"\
> +"  hole     : SEEK_HOLE, return the file offset to the next hole from offset\n"
> +
> +static void do_lseek(int argc, char **argv, const struct cmd_desc *cmd)
> +{
> +	int fd, whence;
> +	off_t offset, ret;
> +
> +	if (argc != 4) {
> +		fputs("Excess arguments\n\n", stderr);
> +		fputs(cmd->cmd_help, stderr);
> +		exit(1);
> +	}
> +
> +	offset = atoi(argv[2]);
> +
> +	if (!strcmp(argv[1], "data"))
> +		whence = SEEK_DATA;
> +	else if (!strcmp(argv[1], "hole"))
> +		whence = SEEK_HOLE;
> +	else
> +		die("Wrong whence type");
> +
> +	fd = xopen(argv[3], O_RDONLY, 0);
> +
> +	ret = lseek(fd, offset, whence);
> +	if (ret < 0)
> +		die_errno("lseek failed");
> +	printf("returned offset=%ld\n", ret);
> +	exit(0);
> +}
> +
>  #define CMD_HIDDEN 	0x0001
>  #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
>  #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
> @@ -1671,6 +1708,7 @@ const struct cmd_desc cmd_list[] = {
>  	CMD(listxattr),
>  	CMD(setxattr),
>  	CMD(removexattr),
> +	CMD(lseek),
>  	{ NULL, NULL, NULL, NULL, 0 }
>  };
>  
> -- 
> 2.43.0.687.g38aa6559b0-goog
> 

