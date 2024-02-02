Return-Path: <linux-kernel+bounces-49890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3A98470F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2601C24271
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2994845C07;
	Fri,  2 Feb 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="X9zvSy8U"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6541755A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879890; cv=none; b=YcpEaRO4a/hwyTpeYn0U0gn8GhWinXNtcSEIgdQ1bNRsCgKK0LS6fHsgFMOHvqm47r5R10K7fBdBPsM9a6WEdJEzfcwTUCYVNu68gLfbZTM3ikYc03Hi3QKvoaTIXLHq0Y8VRKvNf1vL98NBqUCXbcqpW/120F2T2FKC3Mk6zDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879890; c=relaxed/simple;
	bh=TVEt2jHtHb61K1i6et+msFxYPgYsZ2I/trn8BkT7X2E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BfW8iXCyO8fseHmLiNFXT1W5j8UnG+p9hE29B3gjY8opEtEWh18hyanUlPCjgZLphsTZegIJknlFglL2PAVgmNJfo8TT6qU7R/FfFQXWtxZxQGMxsWcsNITLWuUAojZRYR0xviyjqQSTFHy/6tEmCdHKT0fo1hQ6TMc5R8UV7xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=X9zvSy8U; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5113abf9981so228165e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 05:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1706879885; x=1707484685; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVEt2jHtHb61K1i6et+msFxYPgYsZ2I/trn8BkT7X2E=;
        b=X9zvSy8UrCadnt6n/JB/nDhTibJk0Ij3LkTZZkIXE7ombbI/X/iIWo258XPS0nFy2R
         qc2kAqzBVlZNyIvhIRvUDZmlP/S1YyYmIBVFB3+PjG5qWjfsg4gv3eDF8mtd2lTkurwB
         huDmp0SwFUvrE9GXcvmfWMF99pBVYifgWQNAGvXkD66ed8kWgdg7Kv8Nu6jqKuEpzFlg
         vvOvRQ9jaBAU9vAXBH5jr/liiPkFWs/drJHeoaU5E+jbr6CIBHCpUIZauJ4a1QkUr7Mu
         pN8UcZJOPEOcQFZb2bfjMNn/Fe5cQGJIeY8k4/lvEmc1rTjRXTh1/aT7X0VTUVu3l1JF
         nS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879885; x=1707484685;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVEt2jHtHb61K1i6et+msFxYPgYsZ2I/trn8BkT7X2E=;
        b=m2a67tgWjWuaCVd4OxSU6dfTakc8f7s6tQJcl6BnXDejYH63rqdHbGoyon6I56i2EP
         8cbyMBoVCnr4cxUPfgIU0QmXAHncUgMpFOOqAYMWBhf77ykvzcV4LbSBMS8oGZzo1f4L
         05IJ6HLBTHGZqdP1vzZ9aSXxPyPlQxD35pss7YUvul2r+sq9AEM1oxQjIBNbJDYrV0+P
         nqaGdh399vUnKnXGHijEXvdw2DeGrPIJ/oWANr8LYqOKJ2trE71vIYvWaiGROGUn85cn
         RubkCA33RiysMSVUoF/zJnfOQvqFnOao6ygsAFj1OHHzKA/LVxMs2JHA/+HSOXT0N5J9
         3x9Q==
X-Gm-Message-State: AOJu0Yw67z0x968nQYfQuN3mOWXfFjxavjk+vpAfO2y2ZcWYnmCdhu8k
	kgz7LzrfYq9nHIqFDaccsd3TPUctrDHGCH9nEnoeLY33jLLzKFN9i3UKWuIbuR4=
X-Google-Smtp-Source: AGHT+IE0lIO4yK60ZwridvY2MEnGVTaem9HWFCVDtVBepwgBkCdD8VOr2e2X2NFfruuUafQSbGl9UA==
X-Received: by 2002:a05:6512:3b90:b0:511:3b5c:c923 with SMTP id g16-20020a0565123b9000b005113b5cc923mr349188lfv.0.1706879885003;
        Fri, 02 Feb 2024 05:18:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUN7FYSXAnWO/n8VrUy/afhCK2ZUXPFxIE80ljlumLt8xuxRlW8wXI0ENzbmNyKKoXdUmChhC1hAzoLpNVsIieoKQyHNGtvEymERFG8deVN5uNQf05U7TxZvt8hSoaa9SJ+d0Y8iFXFtoqD83JXtzcRCt1/5m3tlxJqwCuDFejT9C/QfN1kng==
Received: from smtpclient.apple ([84.252.147.250])
        by smtp.gmail.com with ESMTPSA id c18-20020a056512325200b00510133ea456sm302476lfr.277.2024.02.02.05.18.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Feb 2024 05:18:04 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] [v2] hfs: fix a memleak in hfs_find_init
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20240201130027.3058006-1-alexious@zju.edu.cn>
Date: Fri, 2 Feb 2024 16:17:49 +0300
Cc: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <464B735B-EE9E-4AAC-8AA5-B746D707D69B@dubeyko.com>
References: <20240201130027.3058006-1-alexious@zju.edu.cn>
To: Zhipeng Lu <alexious@zju.edu.cn>
X-Mailer: Apple Mail (2.3774.400.31)



> On 1 Feb 2024, at 16:00, Zhipeng Lu <alexious@zju.edu.cn> wrote:
>=20
> In every caller of hfs_find_init, `ptr` won't be freed when =
hfs_find_init
> fails, but will be freed when somewhere after hfs_find_init fails.

Current statement sounds confusing for my taste. I don=E2=80=99t follow =
it.
What do you mean here?

> This suggests that hfs_find_init should proberly free `ptr` in its own
> error-handling to prevent `ptr` from leaking.

I assume you meant properly here?

>=20
> In particular, When the switch statment goes to default and return an =
error,
> `ptr` should be freed.

I assume you meant statement here?

Also, you mentioning `ptr` but we freed fd->search_key here. It sounds =
confusing too.

>=20
> Fixes: b3b2177a2d79 ("hfs: add lock nesting notation to =
hfs_find_init")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
> Changelog:
>=20
> v2: Improve commit message to be more clear.

Currently, it sounds slightly more confusing. :)

Thanks,
Slava.

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


