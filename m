Return-Path: <linux-kernel+bounces-56693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F3884CDAE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CB828E94A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DAA5A118;
	Wed,  7 Feb 2024 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="INl58ngs"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B07E58E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318496; cv=none; b=L8EM06+CyGpSnmcI4+4J+Dojeil+w8LOP+heLB8wNUXfb/5iRjmeWZbFZu0FIKugw4aYcC3dGf4n2nqJk3R3Y6y5NmMmC8DPWk8kRTrKWQ1lELcNe9sMtlI9nYpq+TScgS7RYXWKFU/3sBbZDNpdWe3BEMHMYgfJZV9xfE47RwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318496; c=relaxed/simple;
	bh=1MSigGlUwsLDuS+rgZM2EfvMEhe6b0TG+BujN/YzgN8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PKQ02acmCDjyV2MjjGugm2e4TnrB+G51f0oIa7VyVRxmqkHtROZey0stLOBVAwaIeYQ4D9NemRuSQwjAd9FI4C3MXXrQyP5zMyxzBtCZ1tJl82C6lpVcMl6r/JKOZQvYm/QJWF1EWWC2cRptWdF1Xrd4MHk4Zol/of7MNQwH5Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=INl58ngs; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d073b54359so9628461fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1707318492; x=1707923292; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WpTtrSOAciENAFEaWu2UZ0XGYhJn1CS0iU/1Ll3UhU=;
        b=INl58ngsk/Ja+k21JMbQKItz1OsGlCoHx4sMOGjaqkZ+YEL3vHZ4C0XfvPMh41Pti1
         DC14DKB33MGYRnIxGyWkLSzdzrPMSFdUjwgaXdQ6LbL5s4XE2OWgxOE7hKpXO9YXnwUv
         1H+TqHBVhIe+PyAvfxYFxB+HllpYAOUj7lJUwUUnesbe1PfKXdNni2XWQzjWt4eCsgEv
         Eg0cnjZ+qwIdqM6kFxnX/D5cmHaVCJb8FB0og45cFaMEgQtyPRh3MPT5JNGm7gN+WRjN
         beQRS8DNzMFKObqY4i33CYIvuc8ofsLHFn2Q5rC983IFbB7eELdQ/cnChiV5PkuW35i3
         kBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707318492; x=1707923292;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WpTtrSOAciENAFEaWu2UZ0XGYhJn1CS0iU/1Ll3UhU=;
        b=CsJKsdb2AwsL+7R+nAaIFARqpMIh8NHgp+lROaSHf+vxCcpHYSC+grH30Oh/VBtmEv
         HTVh5HZeAILNUiBk8GlBU7n11IiKjMVEUbqQDHkf/1B4ppFBJx3A3wfiZtQx5jLP7IC4
         783JYj57Udu1M2xGGRfuYenUiKzEx5JsPQpGkxp8sNH2OkzR/jHXQtL976NN8S/0HfpX
         HHCS5NtBrtUfYITiWDo58YPc1VI6OXd7vU9QUkLSrlAUNInEPxqs0bRxGoGXf+SPt4mL
         drfEOZpsp2P4Z+QPHyPv5P5DnsdqpEednHPK3+N+EBdmDAZ/WsCZQfSznb+fY9/ldoYc
         dYoQ==
X-Gm-Message-State: AOJu0YxU1VrJKC+dS67IOdt1BLDJx0B/j1qIW9L5+gap0yR5BbPDbpgH
	UH4cXHY/KVa11Ln0fPTA+DKp+h+TuO7Nq5XBDDdCYojCH4xunp1o4b6HcZs83Xc=
X-Google-Smtp-Source: AGHT+IHkyA0Wh/4Wz1ZB/Ybxp87lVfY5uDn8t9yBY+FNecSLEqy0URL39VMmZqhh7H+6Sdw3ji7KZw==
X-Received: by 2002:a2e:95c8:0:b0:2d0:ccda:228c with SMTP id y8-20020a2e95c8000000b002d0ccda228cmr1001220ljh.41.1707318491659;
        Wed, 07 Feb 2024 07:08:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVStxBFedKRs9R5BGu0CXxltq4M+c+8pXWbGwaZQwlnVVPRpQRVvSvj14swzGYMZ+HuIqTP+uyuGxTurGwDfWvgcDP9nbvtOJKYnxuiOIr9/NFdAT25OWnfCumikjLEK+M4ifareFMjfgHXGx8FTlKYhrgjvUiGYHWIPS2O8EUqHKxAtvVa1A==
Received: from smtpclient.apple ([2a00:1370:81a4:169c:483e:32b6:87c8:d693])
        by smtp.gmail.com with ESMTPSA id k2-20020a2e92c2000000b002d0c85a8197sm206327ljh.76.2024.02.07.07.08.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2024 07:08:11 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] [v3] hfs: fix a memleak in hfs_find_init
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20240207121202.3142524-1-alexious@zju.edu.cn>
Date: Wed, 7 Feb 2024 18:07:43 +0300
Cc: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <70F6A045-B985-4C23-BA2F-D6BD7F38A522@dubeyko.com>
References: <20240207121202.3142524-1-alexious@zju.edu.cn>
To: Zhipeng Lu <alexious@zju.edu.cn>
X-Mailer: Apple Mail (2.3696.120.41.1.4)



> On Feb 7, 2024, at 3:12 PM, Zhipeng Lu <alexious@zju.edu.cn> wrote:
>=20
> If hfs_find_init succeeds but some other function called after it =
fails,
> the overall cleanup function of hfs_find_init (i.e. hfs_find_exit) =
will
> be called and `fd->search_key` is freed. However, if hfs_find_init =
fails
> and returns an error, neither external nor internal deallocation of
> `fd->search_key` is triggered.
>=20
> This observation suggests that there could be a memleak problem in
> hfs_find_init. In this patch, we add the missing deallocation in the
> error-handling path (i.e. the default branch of the switch statement) =
to
> prevent such memory leak.
>=20
> Fixes: b3b2177a2d79 ("hfs: add lock nesting notation to =
hfs_find_init")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
> Changelog:
>=20
> v2: Improve commit message to be more clear.
> v3: Update commit message.

Looks good. Thanks a lot for reworking the comment section.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

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
> 		mutex_lock_nested(&tree->tree_lock, ATTR_BTREE_MUTEX);
> 		break;
> 	default:
> +		kfree(fd->search_key);
> 		return -EINVAL;
> 	}
> 	return 0;
> --=20
> 2.34.1
>=20



