Return-Path: <linux-kernel+bounces-25066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29CA82C722
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53457285054
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925E817747;
	Fri, 12 Jan 2024 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMZNmq5f"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE2179A6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dde5d308c6so2357438a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705098006; x=1705702806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ1fE0zMIdBTRXTZzC0pYGjjHoVS0GZdkj3k4G9P/8k=;
        b=HMZNmq5fBG+6yintXaoXeHT/tPcZ1zDgVfeuy9UPQhW+vpTTISix/NGLeYnQwV1bzS
         Oglb9RHietWQSRx/Bdo2qVNdkO1LXyEdeIEMWy6Wg395rxNVWCAZ4clV8SL3PmWDk5Cn
         MYfJc/82rd/cR/jye+eu8J9atEvY/oD1KQNIAIGszsViuAlSr/QO5p0oU+HJcmYXOvdl
         YOU/szZx65RNaGeiNTCzv9DIUVx3vbD2U4GdrIJTo7vdWvly2N2Z6Fq9wKnkjDmnZfoU
         5KQhvSEIi1WMkkZP7MF/i0MZcXh8K6UwVhIlxCq1fyaLEue/E5/jsL3Qd9XPiGmVPkgF
         qY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705098006; x=1705702806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZ1fE0zMIdBTRXTZzC0pYGjjHoVS0GZdkj3k4G9P/8k=;
        b=jwcixcbUK0cbU0TUsL82scIkYfGEIyg4zS6P2wlrtkAPxuL4McElmrWVcBlFROXQbM
         bGUTJKW5hzEQez5Lxf76dBr2S3VCnqK/djdterxus96gz/tGa6v1zi5M6arsGDG/kNqW
         Q42OMSeddRpOGCITWsYkUJrZISgRJuV7YDWDCpEfm7AyyjUvzyfU+lrJiEmMUMznTAtx
         JkCjylcWqta019rPRaxNN3IOUCgbde/hPYGXiCxiUTYZeqUxDs006xnSzV486hi+LbMv
         gj+AjxSYs5l9Qor4vJFpEL+S+8qBStz0EyrLP5dAmVKYFOgbFfh1+L6uIOlfL+yA5TMD
         zObQ==
X-Gm-Message-State: AOJu0YyabnKeil+RONsQaniDRcCA05LrUMDIS5Nmn6MjdVZF+LH9hITJ
	oF3ro+dcSI7Zd7YxNOypYNbIgRgQnB+VmOHyqJ0=
X-Google-Smtp-Source: AGHT+IF3nLiZdIVfIpj/tS0ArCYtqeD9qYJvdJym55Bt1+GH6gLfy6yhR92PURPrqVl8XlX8IimHnbmfH6hWYE2Nqy4=
X-Received: by 2002:a05:6830:718c:b0:6db:ffa6:6c4d with SMTP id
 el12-20020a056830718c00b006dbffa66c4dmr2586243otb.24.1705098006595; Fri, 12
 Jan 2024 14:20:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111064208.2969599-1-chao@kernel.org> <20240111064208.2969599-5-chao@kernel.org>
In-Reply-To: <20240111064208.2969599-5-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 12 Jan 2024 14:19:55 -0800
Message-ID: <CACOAw_wrktRjueox2FQC129jjVVNVEMpCDM06iQXv1p0gpYvXw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v4 5/6] f2fs: fix to remove unnecessary
 f2fs_bug_on() to avoid panic
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

On Wed, Jan 10, 2024 at 10:43=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> verify_blkaddr() will trigger panic once we inject fault into
> f2fs_is_valid_blkaddr(), fix to remove this unnecessary f2fs_bug_on().
>
> Fixes: 18792e64c86d ("f2fs: support fault injection for f2fs_is_valid_blk=
addr()")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 69e71460a950..ab710bb6d8b3 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3470,11 +3470,9 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sb=
i,
>  static inline void verify_blkaddr(struct f2fs_sb_info *sbi,
>                                         block_t blkaddr, int type)
>  {
> -       if (!f2fs_is_valid_blkaddr(sbi, blkaddr, type)) {
> +       if (!f2fs_is_valid_blkaddr(sbi, blkaddr, type))
>                 f2fs_err(sbi, "invalid blkaddr: %u, type: %d, run fsck to=
 fix.",
>                          blkaddr, type);
> -               f2fs_bug_on(sbi, 1);
> -       }
>  }
>
>  static inline bool __is_valid_data_blkaddr(block_t blkaddr)
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

