Return-Path: <linux-kernel+bounces-40239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AEF83DD01
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7458D288F82
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171A11CD34;
	Fri, 26 Jan 2024 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="CRZ/YJgz"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231CD1B970
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281372; cv=none; b=KfG+iZ6UnjzfqKARpEBPqgCdFKXDq59zDs0KbM1TK8kNtzK1BvAKehII7ZTcmXAySmod0hU25FVO1aczXwctfkVnv83/R3Lf8mJzbD9uKOzJJQ/XKoX/IwvNkcT5o+47AvvdR8iwr/2dNw4xpAchhy2H20R9dYbZvmL1EykZt70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281372; c=relaxed/simple;
	bh=JsxP7toU+yaQhyM85mOfisB9eNURYXeJZZvgfcckwgo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=u7c0rAT1UKG7CfP5RvunwvphlY1hSZZiXj/bBJsR3i6O/9Nx+I73DV7bTSsKaYFxrVizbM+x/x56PtKVCg5ia6UIvM9exs8d34zvXWFFTrvMAE6gYGTegMxpuNKgsEqKkPGDgvfugW66y59NjHMxZzj3VJxa/5gmwRzksNwpDyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=CRZ/YJgz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5101ae8ac40so582794e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1706281367; x=1706886167; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsxP7toU+yaQhyM85mOfisB9eNURYXeJZZvgfcckwgo=;
        b=CRZ/YJgzYD5N5KWq15AxTWpEQ5RWgQVuC+8pw6Lmu17LHhvJuTQo6m6/Bt6cN2G4HH
         cTn7xc2CAKgpNc5V25fhwxnBz73WsRD1nzDkTO4D/wkBtQ6cuTqrdmDWlmKqSB/PLFtq
         WBqmC7Ex6wtlApJav4DkWpw9AJHhOzP5vPu9Vx9g+213U9N783A6M677B+3up8GKLcR7
         yyGP6teEDyPddKv3HCM/om9pM48/OKFmw94kpWkKmu5cNzEGGRXEZoubixGSNPTS9TtX
         Xpfolc963eYBi22isSrSQMYTAfVYvfIVmpzTtpw8WqNSmViBDSJ5egiZdhEQzuIoG6uz
         s/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706281367; x=1706886167;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsxP7toU+yaQhyM85mOfisB9eNURYXeJZZvgfcckwgo=;
        b=s4M+uhxsEehkmUaO2d+jITndasUYT7HlifvaJmxYN2nqfh3ddJkT8AsEjEIeyf1hWn
         ZzPqRUU9tgbtI2lSl8gNAqs0hURUOm7spCJZWjZuHvnx9efnu48TYD8SVR4Lfj2k7KMw
         /S9j3mBkrPcfn75Q8RDX9LVI8mLt+AaaMMeJsxLXTzP9XFFgqdA9Wufov75ck0wHR7rn
         2I0wYh0BuVY8VgpIXE0wjwYahwc70Ktgv6T3wqK7tMuH2AsWQkWOz6jMuEDHENhVWitx
         crmNodnOp8uCvcvZvZqKhxEIjozk/FDmZUme2KMCdqIZSIGTxrz3G6fzTXlp6qe8/Zz0
         VomA==
X-Gm-Message-State: AOJu0YzgeaGmSZBqgphIz5aUFRolHTqVYegypoPCQn7tToWePHPP6xYk
	59RK0MVU9DXY2OBnLiggEIloF4Q3LvhX+iYx78nwxAir9727aGescOqCVoKXAfU=
X-Google-Smtp-Source: AGHT+IHF+mmyHTGOk00si2Y5/cuhZYWBxwC8inIRzI2KQ0mNT1wWw/ycoPdqIaDsdcQkRfWRT6iyHw==
X-Received: by 2002:ac2:563a:0:b0:510:1721:4784 with SMTP id b26-20020ac2563a000000b0051017214784mr724538lff.72.1706281366950;
        Fri, 26 Jan 2024 07:02:46 -0800 (PST)
Received: from smtpclient.apple ([84.252.147.253])
        by smtp.gmail.com with ESMTPSA id x23-20020a19e017000000b0050e758ee006sm204457lfg.205.2024.01.26.07.02.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2024 07:02:45 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] hfs: fix a memleak in hfs_find_init
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20240122172719.3843098-1-alexious@zju.edu.cn>
Date: Fri, 26 Jan 2024 18:02:34 +0300
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F36C0C80-DAF3-4D8F-8EA3-5209E8FB5BE3@dubeyko.com>
References: <20240122172719.3843098-1-alexious@zju.edu.cn>
To: Zhipeng Lu <alexious@zju.edu.cn>
X-Mailer: Apple Mail (2.3774.400.31)



> On 22 Jan 2024, at 20:27, Zhipeng Lu <alexious@zju.edu.cn> wrote:
>=20
> When the switch statment goes to default and return an error, ptr =
should
> be freed since it is allocated in hfs_find_init.
>=20

Do you have any memory leaks report? Could you share it in the comments?
Which use-case reproduces the issue? It will be easier to review the fix
If you can share the path of reproduction.

Thanks,
Slava.

> Fixes: b3b2177a2d79 ("hfs: add lock nesting notation to =
hfs_find_init")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
> fs/hfs/bfind.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> index ef9498a6e88a..7aa3b9aba4d1 100644
> --- a/fs/hfs/bfind.c
> +++ b/fs/hfs/bfind.c
> @@ -36,6 +36,7 @@ int hfs_find_init(struct hfs_btree *tree, struct =
hfs_find_data *fd)
> mutex_lock_nested(&tree->tree_lock, ATTR_BTREE_MUTEX);
> break;
> default:
> + kfree(fd->search_key);
> return -EINVAL;
> }
> return 0;
> --=20
> 2.34.1
>=20


