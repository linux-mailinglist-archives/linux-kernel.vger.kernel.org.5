Return-Path: <linux-kernel+bounces-10116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF12B81D06A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758841F22B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36EA33CF8;
	Fri, 22 Dec 2023 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="k9DvNeSF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556A333CE6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c6839373f8so1585768a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 15:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1703287351; x=1703892151; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8Gxr2TTVHcLRuDspv6E8NM+79Hh0/v74/4HhPV7JuY=;
        b=k9DvNeSFtTi+vtCqhDj7t10Nvx0QDGeZh/v+ogrZOwBhBHCsWMelO/jwyq0JuZMREA
         nRweCi567BbgEDeKSzvKm9TbSHKk2ygZDoGQN2opMIe/BjQEFDDAMtzQ05YhEqWHVcvb
         P4DHlCf3PQzJ5VUKTgeefYkffLLnPn6e+f2zpv1qZ+errtalTLr/IIuL3WRab9WZLZMa
         4J05tqA96HEMoNeL0ztW+b7SFp/seUzjt3tEgn0MMIwel7z/mVkbt77d+X2322AIdBfM
         x3LMMcLRkAtAMJjRRv8Kl4nsLQuVr00eNa/LBKO9cU1qX67paeKUuqC6dHg1mHfqwHNB
         Q87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703287351; x=1703892151;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8Gxr2TTVHcLRuDspv6E8NM+79Hh0/v74/4HhPV7JuY=;
        b=TSlx2PiALohwpdSBzGG8AOjI9wy5HJFduH89A6duwZg62QvuitItvmbw+WO2Im4SjX
         wIcINgkyzspFHHhtImiCOydhJ3tn2CDtrA2SG6oVqQtS/vrH4s4UWl1RgF202POBNwir
         xKQU6Fjs+uhTrOb4zuK7d7vS9O0oQHTKHam6SVRZEXaawMTj+i4FQHVHKNrRmHrwt+np
         tqLYZRq2Ff4gNbK0FV0jm0tDNr7Qmfdk/SXzBCjFEIuNH5lbxJ6zAHsYbbjrygqxloik
         WjvSiTGGgav1PfRhZgRQQxuj93Y6JlgPrMtMtl6PHhouaZrIfKuCS+tzBQhnljVOa5mR
         +jvg==
X-Gm-Message-State: AOJu0YzsGKyKuh9kp7g+nNj1TLlBwDtXUUk856cP5xhIShtMoyPl+Ezm
	70H+Q4XOr8e8IQR/9PY/RosWYCRU2LSRdQ==
X-Google-Smtp-Source: AGHT+IEF0sC78738oz40zbK9j1a7TNFK3Ja2lqrFOIVBZIGiOiPi8b2DKos8QOSVL5NLT2UHxlLvYQ==
X-Received: by 2002:a05:6a21:a5aa:b0:195:61de:b72 with SMTP id gd42-20020a056a21a5aa00b0019561de0b72mr138327pzc.11.1703287351165;
        Fri, 22 Dec 2023 15:22:31 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id i18-20020aa787d2000000b006d9a039272asm79820pfo.82.2023.12.22.15.22.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Dec 2023 15:22:30 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <A0551254-5464-429A-9D7E-98065BB544D7@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9EC47313-BC83-46B4-80D3-BB34DE69435F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] checkpatch: ignore deleted lines for comment context
Date: Fri, 22 Dec 2023 16:22:29 -0700
In-Reply-To: <2b294dc33ea64d1d605cf146741d92677b13006a.camel@perches.com>
Cc: Andy Whitcroft <apw@canonical.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
References: <20231222230551.95425-1-adilger@whamcloud.com>
 <2b294dc33ea64d1d605cf146741d92677b13006a.camel@perches.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_9EC47313-BC83-46B4-80D3-BB34DE69435F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Dec 22, 2023, at 4:15 PM, Joe Perches <joe@perches.com> wrote:
> 
> On Fri, 2023-12-22 at 16:05 -0700, Andreas Dilger wrote:
>> From: Andreas Dilger <adilger@dilger.ca>
>> 
>> Don't consider lines being removed by a patch as part of a comment.
>> Otherwise, false "WARNING: memory barrier without comment" and similar
>> issues can be reported when a comment does exist on the previous line.
>> 
>> For example, a change like below was previously incorrectly flagged:
>> 
>> 	/* matched by smp_store_release() in some_function() */
>> -	if (smp_load_acquire(&list->tail) == head))
>> +	if (smp_load_acquire(&list->tail) == head) && flags == 0)
>> 
>> Signed-off-by: Andreas Dilger <adilger@dilger.ca>
> 
> OK, but:
> 
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -1972,7 +1972,8 @@ sub ctx_locate_comment {
>> 	$current_comment = '';
>> 	for (my $linenr = $first_line; $linenr < $end_line; $linenr++) {
>> 		my $line = $rawlines[$linenr - 1];
>> -		#warn "           $line\n";
>> +		#warn "LINE($linenr): $line\n";
> 
> This is a superfluous change

Sure, I can resubmit without it if you want.  I found it helpful when
debugging why this code didn't work in the first place...

> 
>> +		next if ($line =~ /^-/); # ignore lines removed by patch
>> 		if ($linenr == $first_line and $line =~ m@^.\s*\*@) {
>> 			$in_comment = 1;
>> 		}
> 


Cheers, Andreas






--Apple-Mail=_9EC47313-BC83-46B4-80D3-BB34DE69435F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmWGGjUACgkQcqXauRfM
H+B1fg/9HrL3HAO+54BMABfLd0piwVWdoOf3aVx0JEqkjFJhIXWeQbGr3Hct7ccf
nQPMc1QOt9lWMeeTkbog1IMqg8W0tE+Xv5IKkjb7QrwVcWaP27VD7ctlD6qEs5Xe
jasDBzdig/Vgxd8bfelaeM9hFJMSAxC9cwmnBUQ8OXFo8X3//ieIQfHycC0K9MTI
TuHqkHiON85JM3aE/j0iyjKS5owYxKyonJ8+B1J+Nwxqu961LRRpnpoISKO/Je/3
9b2it8kzIBJgRQjNxgxrQXNXSTgsZeRmdZ8b0aw8PAjkOTk9e6hJl4mQeSTwi8rx
FvjpXbDd9sJ4BNGRhmOq1VmoOwTun8yKc+Cgv1LizuVFByy2F4AsIUILxFv7MbpF
G5G8CE2O1BqX4Qkmg/m+27yEvjAaDZuY+DyOnCxdoil6LlJPDF429JyS/9jHUlI5
Q2sV/XKjWmE01q9XxlZZ5dUfIKl4ekYuH0DFTqoimAQyuiZmjIuf8qr7SM4WXHnz
ZTKiPlFyK3DTTv6mSY/MjNw+HZHzpEHc6CAGHZexF3x+o5cuopShAnleMrQy28xU
JeCAFDLSjlp//Fizn3CaKT2afDi3LpKH4wzhhPMxVvoLm5bkGTO+peAfh29RvVTe
4PKi695DlHJtOzROVaLGGDI5+WnVEn8BwOZ96jEGgdsYSZwQ5UU=
=3Scm
-----END PGP SIGNATURE-----

--Apple-Mail=_9EC47313-BC83-46B4-80D3-BB34DE69435F--

