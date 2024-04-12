Return-Path: <linux-kernel+bounces-141823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF018A23E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEEF1C2288F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966751B950;
	Fri, 12 Apr 2024 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/9N66lN"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB0813FF5;
	Fri, 12 Apr 2024 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890232; cv=none; b=J62YGn7Q1/fKyCHdBOnLgkFHyBdNr6A2EsaohWW4teAFD8Rm6mzbONE/stBu7I7QC388/yByAW+zm4hQ+7Z8TmuYxwFM9eo6VLGkDVTYJtx8eKp129UE2nXpmL7B+pv2L/ywTfhY2K9G0SEJbyj9T/+lMyTP095CZVaR+rh1hWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890232; c=relaxed/simple;
	bh=uT0MEC7EsVltlC/jI3B38b+8TYJHjBlK30NRBhrExfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVsTbpAzxnkuwBkmGDajdTZTbqBKzJYps2auvGDFWrsmoWh9FO8Owzk5jGtc9PCioEQ03yo8hEjUgFgFY5GP7cEWlE46lCwgiwRM+a/d9idTjn76DwHlj5xnAvxf9P8kAyGPjMl60cvSbfuFA8xsFHLaXNlf+AgU6rdGmxv2NfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/9N66lN; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36a1e9b94d4so2478095ab.1;
        Thu, 11 Apr 2024 19:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712890230; x=1713495030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOdfCpl4d+sWw38XgvsjR5TOxV8nbr5ndLofzmhVJmc=;
        b=M/9N66lNJY0FEiJewtGPwbVVetKjAr45SKnGBj4YHU3QPemn4HVO+cKGxC2QHjtSqz
         DwBMnt1eAztCOe+grt4fIEID/B6DymraXyYFiIgGGijCa8jWfYdqPbClMxL9Ci8kNdg8
         yXl/MHxQbwxTWqvxYit7kaKxZQpCUmWPAzzZuKGYervZJjdaiucF0SwzqkqmuW2A/8Ri
         GbyIFD95piVaKTuuDVIm4nNIevGnPgT9n48fRQJwLoMslIUtkpTPIAkJnV7rPWccijKW
         Z+LKSkgxL0Hthd0uhWK6H15s1Zq1MJs7KKFJI+Y6uPj6VG5P4mtrFQ9ITErV1PLob+WP
         bsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712890230; x=1713495030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOdfCpl4d+sWw38XgvsjR5TOxV8nbr5ndLofzmhVJmc=;
        b=iTetSTtKu2gJoSrmH7xMTxCXH9zYivdhW9X7jzrklyij4tvU/wcDDbXkThIIH8hs1T
         qrqQRu1BqLHS67P4gbGnEHaLt+4IVvZ3tyuiXvLAD0FauObqVbhglH0q8999zRlKpebq
         XdY71BIvCNVMOOn+f2R6M/E4X52ml/9HrgO4TBTG+NLYOfGmKlIw4FtAoaIiS3kdAy1D
         au+IS3cHIqZ1IQXIaAv58mQJ3murI0d3YdFf8hHsnaJDXJHb1uJ3wA+rrsxpJlMzRLW/
         YDAsZyyKMk/0FGtjm8TLGzPS/fqeh0bbnxjbNtIZQD3o6IV3es1ofJUm6L+7RARlCtty
         FDeA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ4Pqd/pudaWwQwt7yeKzottbAZJNK+UPlFtCZ1puzD71/E0tZUZAhU5RINewFwB0umijOOd+C9DWE/VY4Tf59ynoRVAAZdulJ71lBcV2tRKC1c/NyCYYaNoRc8gy4F/FsWwGkHitf
X-Gm-Message-State: AOJu0YzSSSnb88efNHeCTuogNZ6Hn/WxzIpOmUESZrz2lOUyXcsM3REl
	fSOHqi7GkKYS3fBZYkRd3hfcgIohAVJJDaajsYHhwor2EblEnB4j
X-Google-Smtp-Source: AGHT+IH+DcJ9qpHvdWnkfvBEQP13FTRtBpQdTrRUVXdq8MnpDDWWS0XFrK+rjzEvNKd91cNj3eGPjg==
X-Received: by 2002:a05:6e02:1d0d:b0:36a:92dc:a390 with SMTP id i13-20020a056e021d0d00b0036a92dca390mr1458841ila.4.1712890229935;
        Thu, 11 Apr 2024 19:50:29 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id w9-20020a63f509000000b005b458aa0541sm1759527pgh.15.2024.04.11.19.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 19:50:29 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7CE7F1871EBED; Fri, 12 Apr 2024 09:50:26 +0700 (WIB)
Date: Fri, 12 Apr 2024 09:50:26 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Zhang Qiao <zhangqiao22@huawei.com>, corbet@lwn.net
Cc: mingo@kernel.org, chrubis@suse.cz, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/Documentation: Add RT_RUNTIME_SHARE documentation
Message-ID: <Zhihch_S1_-1JhwK@archie.me>
References: <20240131123238.2332064-1-zhangqiao22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pta05BleG83gC9lZ"
Content-Disposition: inline
In-Reply-To: <20240131123238.2332064-1-zhangqiao22@huawei.com>


--pta05BleG83gC9lZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 08:32:38PM +0800, Zhang Qiao wrote:
> +2.4 RT_RUNTIME_SHARE sched feature
> +----------------------------

htmldocs build reports new warning:

Documentation/scheduler/sched-rt-group.rst:151: WARNING: Title underline to=
o short.

2.4 RT_RUNTIME_SHARE sched feature
----------------------------

I have to extend the underline:

---- >8 ----
diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/sch=
eduler/sched-rt-group.rst
index 4d8eceb71f5ed8..751113fcd35850 100644
--- a/Documentation/scheduler/sched-rt-group.rst
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -148,7 +148,7 @@ For now, this can be simplified to just the following (=
but see Future plans):
    \Sum_{i} runtime_{i} <=3D global_runtime
=20
 2.4 RT_RUNTIME_SHARE sched feature
-----------------------------
+----------------------------------
=20
 RT_RUNTIME_SHARE allows a cpu borrows rt-runtime from other cpus if it runs
 out of its own rt-runtime.

Wording suggestions below.

> +
> +RT_RUNTIME_SHARE allows a cpu borrows rt-runtime from other cpus if it r=
uns
"... to borrow rt-runtime ..."
> +out of its own rt-runtime.
> +
> +With this feature enabled, a rt-task probably hits 100% cpu usage and st=
arves
"... a rt-task may hit ... and can stall other per-cpu tasks ..."
> +per-cpu tasks like kworkers, as a result, it may hang up the whole syste=
m.
"..., which lead into system hang."
> +Therefore, in order to avoid such exception, recommand to disable this f=
eature
> +by default unless you really know what you're up to.
"Thus, it is advised to disable this feature by default to avoid aforementi=
oned
issue unless you know what you're doing."

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--pta05BleG83gC9lZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZhihbQAKCRD2uYlJVVFO
o550AQDu03i1uJtG0AxGErdDS2JmvkRZ3c/WLBTu1QSqG6Sx0AEAtqzYZcvSGCS7
u2XiNdlZMMXwZvzc1CJVuFyjGh8A/gA=
=1lgf
-----END PGP SIGNATURE-----

--pta05BleG83gC9lZ--

