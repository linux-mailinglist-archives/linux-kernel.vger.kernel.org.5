Return-Path: <linux-kernel+bounces-18533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A07A8825EE2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 09:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12361C234D1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067215380;
	Sat,  6 Jan 2024 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsAB2/Q9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E15D522B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78158569dc6so41181385a.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 00:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704530294; x=1705135094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kppXyXVQVtZYAC+jpLWN5j5UxASoZa6NImaunFYNEuc=;
        b=GsAB2/Q9sLMvHZ7VJN4DAxlwj2luW4djqwTnJvH0zRZh1xs5cvR0b2BQRk/B0pv7RJ
         +7uEQ9zML7xFkHcchCISi5xQRHU/b2qczgYsacwNG9Bw+Ki2tTkUW/pYrd1wwOBPQyGU
         HMq1dkgUpnWXGxLc3I2tKjRhL/9spZgQCGRkk/ycmjHpqFpx3R9tYFtTOg/nqqnGwvej
         ZoskpgAh7qywkF64EhZ0fy2BQLsdgJk5Y1T7IkUlsFaRdz+oS55C4AjDEK2/gGXTPkYI
         Ib+ZErJMtkH6hKNO170yWSjRojsW+uH7pSOaRf9BEqsTFNipum+icaMYrGkmq6qqUI7s
         0nYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704530294; x=1705135094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kppXyXVQVtZYAC+jpLWN5j5UxASoZa6NImaunFYNEuc=;
        b=SJJVHdQKNNPBpS+feKqbJ8VfuZCHVvudenpAiqmsD1DToWtG7STs/6kcVy/dFE6+ca
         VIoknEAIwOUmHX1/1VdrlqHJBBSUyesorXT4jir+qr9kTDgNq9yIgvmNt4+Pfo7p+Cyk
         HZ6JexPRftKltcs55e+JeV9O+8A2YPc5tsXHM38OECQQ+1zBWXgH1eB0tspBpzqnqi6G
         baHuIg/PtUptqT0tFYyGjai0X1x73FIqRYqW7sZKtWfp2UV2JLig3lXmNNo7zXgYjx1A
         ZXlLUZp9QsvyQHuiCyzgHBbSZ0GRF/zsGSWohXN938TP1MzM5ttUTJYlN/fWgLkxfwSi
         5V2w==
X-Gm-Message-State: AOJu0YwW7P/TahU84MVvsSAcHif1OA1yf2gpwwbMHHxPwI8vUAaj5m2/
	AE1m4X4iZFTD+QSE7W9VPYZ3hwk45uYn9snnFcIS10pQIjQ=
X-Google-Smtp-Source: AGHT+IF1ptMzrzkP7UVAJOyCkG+0k2rHWOY17WnNkENu8LWtrGvMgeOeoVP9787nJtW/Dm65hPB84tkJzXu+uJUhxyM=
X-Received: by 2002:a05:620a:1197:b0:783:11d3:8ffe with SMTP id
 b23-20020a05620a119700b0078311d38ffemr611611qkk.91.1704530293837; Sat, 06 Jan
 2024 00:38:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105193331.1180331-1-xzou017@ucr.edu>
In-Reply-To: <20240105193331.1180331-1-xzou017@ucr.edu>
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Sat, 6 Jan 2024 08:38:02 +0000
Message-ID: <CAK+_RLm93haEd13Z0hVPSRqG4STsDHMHfu4FBdaBW1QP0m_c6w@mail.gmail.com>
Subject: Re: [PATCH] fs/bfs: Null check to prevent null-ptr-deref bug
To: Xiaochen Zou <xzou017@ucr.edu>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

On Fri, 5 Jan 2024 at 19:33, Xiaochen Zou <xzou017@ucr.edu> wrote:
> Similar to ea2b62f3058 (fs/sysv: Null check to prevent
> null-ptr-deref bug), bfs is lack of return value check for
> sb_getblk(). Adding a null check to prevent null-ptr-defer bug

> diff --git a/fs/bfs/file.c b/fs/bfs/file.c
> index adc2230079c6..35688424bde3 100644
> --- a/fs/bfs/file.c
> +++ b/fs/bfs/file.c
> @@ -39,6 +39,8 @@ static int bfs_move_block(unsigned long from, unsigned long to,
>         if (!bh)
>                 return -EIO;
>         new = sb_getblk(sb, to);
> +       if (unlikely(!new))
> +               return -ENOMEM;

Thank you, yes, that makes sense. Please apply the patch.

Acknowledged-By; Tigran Aivazian <aivazian.tigran@gmail.com>

