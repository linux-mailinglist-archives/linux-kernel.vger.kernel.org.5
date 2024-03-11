Return-Path: <linux-kernel+bounces-98990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D9D8781FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D2E1C20EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E1240BF9;
	Mon, 11 Mar 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQ6RPbAo"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0F41740;
	Mon, 11 Mar 2024 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168516; cv=none; b=izyqGzWxJ7L90OHhkkR6jNxVEFfruHMIzVoR/bvH0L+W+3BlrO0fNs+0KVFgqH5I1amGPL1xHsZyVa+HaQSFN9JzMV6ZygZ1+cr5zN6zQds5NOy5fL3f+mTZ2xZfKzcNZwxsFwAR4RqTM1XNh7HXblI0ZaBUbi5uLXk8ygqEUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168516; c=relaxed/simple;
	bh=IR8Rw7R6tlXgp1dNF24paSxTLyfrch6BTzvZhpaULa0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iAw94YkZssGpUP4eNCZqkmu+iNoTCJ8tfnRob1M8Gw5XXw+9XaS8Sq5raKaxnZgSBse38FfP2HD0KH8KTplAGaoToI8ck4eIiYtMyB2j1eKsMU42QqUaLrWVLHp5tZbYPh9hNR9cUEptwzXObkAqrwmw6iy4wybzmkk4lukW6Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQ6RPbAo; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512e4f4e463so6055106e87.1;
        Mon, 11 Mar 2024 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710168512; x=1710773312; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ddB4TyhSFcJPopfOJaqWR0bgzqo9ldABM++8wxjWoXg=;
        b=OQ6RPbAo4hBeuHAktYxCJYZN9id35Nd+tt8l64SecXAPRRQdpI5UtzhMkRa+mi8uwB
         XPpMbDxzlEFQq1xEmjpoT0hZ6mu6VJ5hFrUpw7d3sNho6cqHTkbqFKHBd3yRV4PD51cl
         ne/rvI+XgK2tt4V7NBEJOeW6v0KQP9q+q55mBCEoTt671Ag2ZltkbkR1RD2QJremOjEW
         +OFAwqlYBRKd4M04rJzl/fAFSHYFj9CkLTTHXbtF9nftN2061ZJ7e/FdjaQXbLWE0mSS
         MDgcKTICK+RjoI9sGamrBOUiJ1dJb48UiqFhcHd/l8C2/xy/nUjRLdhwAfRS6kPET+Sz
         ZLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710168512; x=1710773312;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddB4TyhSFcJPopfOJaqWR0bgzqo9ldABM++8wxjWoXg=;
        b=Uk7TGfJ8VgFVxqVGChhLfaTWdwX1BihOB4FfFyAZ8g1za/RAzuV/1UcGiuuLoQTwKG
         iTzsbCWitnyPJ5NepjlHbGVbm4c8Zy4mOFtjzxKtaFq5Nc3m6xJJxATSXFehOTwUSvZ9
         vIKbQPgGoc78/YGsRyEC15pbsqPKoA4DMVu4kVjTL2K3UIrADJ9AiMKMo4oBzbPa8eFU
         kU/ZqlxbEZaTLh2jdt8W5PK6KHYv8y6ruWx3kZavbtwffNs69hzEaPsfzHS5AwjWuduc
         aCvWuGmr6PGEOpf/+1m1gBmyxjbLaj6lLhTcZcGyji9aEXa/wwykyyV6PVaQbdylXdDJ
         yauA==
X-Forwarded-Encrypted: i=1; AJvYcCWJqW0lQiiLd7VMNvqSBi9DxVgBAoJAUNiI6ZotTfLnXWJ6nDA5hWnLhqRtJpCOyWtLXMogWG4wt4QrzcbFmPtGcxGZg8I4EvjkXz8Ks12Ch+g6VCm676rjfCYObzDoRn9ES5Jk5rt62h3byNdrqwewHnWAJ3/hS1vP
X-Gm-Message-State: AOJu0YwKWHYppJ58yotKsfG0oaCxj6AoVQTAnfhcPwjOAuRd30CjggTH
	JHnvOUiW62J5UB2+0Oh3OEo32oUYicZcVfhwA1xcyBe1Db5J4vP0
X-Google-Smtp-Source: AGHT+IHVwZWNAEFkEevqKJoH5+48Z7sExLdiH9I+11qeXRtg6lcSHLpliy123iTToDf3Eszv0VArZA==
X-Received: by 2002:a05:6512:3b12:b0:513:2329:4308 with SMTP id f18-20020a0565123b1200b0051323294308mr553457lfv.14.1710168512173;
        Mon, 11 Mar 2024 07:48:32 -0700 (PDT)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c4e8f00b00412ea52b102sm16206787wmq.34.2024.03.11.07.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 07:48:30 -0700 (PDT)
Message-ID: <5f1446d409322de91946a569edc0b836daa52aae.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix oob in btf_name_valid_section
From: Eduard Zingerman <eddyz87@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>, 
	syzbot+cc32304f6487ebff9b70@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net,  haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org,  linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org,  sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com,  yonghong.song@linux.dev
Date: Mon, 11 Mar 2024 16:48:29 +0200
In-Reply-To: <tencent_E4EB1B6A2584BA2BBBB733409EAE1B524B08@qq.com>
References: <00000000000081fb0d06135eb3ca@google.com>
	 <tencent_E4EB1B6A2584BA2BBBB733409EAE1B524B08@qq.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-11 at 21:16 +0800, Edward Adam Davis wrote:
> Check the first char of the BTF DATASEC names.
>=20
> Fixes: bd70a8fb7ca4 ("bpf: Allow all printable characters in BTF DATASEC =
names")
> Reported-and-tested-by: syzbot+cc32304f6487ebff9b70@syzkaller.appspotmail=
com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  kernel/bpf/btf.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 170d017e8e4a..dda0aa0d7175 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -816,6 +816,8 @@ static bool btf_name_valid_section(const struct btf *=
btf, u32 offset)
>  	const char *src =3D btf_str_by_offset(btf, offset);
>  	const char *src_limit;
> =20
> +	if (!isprint(*src))
> +		return false;
>  	/* set a limit on identifier length */
>  	src_limit =3D src + KSYM_NAME_LEN;
>  	src++;

Hi Edward,

Thank you for fixing this.
I wonder, maybe something like below would be simpler?

Thanks,
Eduard

---

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 170d017e8e4a..3d95d5398c8a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -818,7 +818,6 @@ static bool btf_name_valid_section(const struct btf *bt=
f, u32 offset)
=20
        /* set a limit on identifier length */
        src_limit =3D src + KSYM_NAME_LEN;
-       src++;
        while (*src && src < src_limit) {
                if (!isprint(*src))
                        return false;


