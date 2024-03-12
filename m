Return-Path: <linux-kernel+bounces-100526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52479879923
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097BF1F24135
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA69E7E11F;
	Tue, 12 Mar 2024 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeT/+pI0"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A279B15BF;
	Tue, 12 Mar 2024 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261568; cv=none; b=c49T55fZh0Hm6cUc9zcZBnijTAQFIhmnmCeaAPcxCZh16++XHEn+eFxNHKroCg5RbD+E8IzSU2sDcngAMTNJPXy3ESaO1EeZ4zZU2Wapa5Qmp4VVGRRZppDew8oPcTALDJrDMq3mWXqYHbE/WQjSrrCmj3ZBB3EE55+wt4ve1bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261568; c=relaxed/simple;
	bh=I2yYkyIZAUOobZ+PU29yAMI1mvt35XxTPqGNlgykIf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNE9eDUUk0UYK3yOQq1JIk1+EZ5VV7QK5LAUt+cXIJa0QiyPbq14ZSmQeG2LEMNPi1BHHbLLk+P9e+7mI2fBPTSIXDcWm1CaKqYXpLKVvOyHCv3c5NHzIAm4ubDX0tMey+sQiN7slqbFZ3gKcROgNupESZlpH2DP0SJupTxT66o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeT/+pI0; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a1d1a28da2so1230760eaf.1;
        Tue, 12 Mar 2024 09:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710261565; x=1710866365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mSImzSxmXOyBGgGyqPE7UK1kzpq6nd8Az9TYKDgnRs=;
        b=ZeT/+pI04Pz24AVH1SB1GLdNPaM+UJRmcZWnoqMhBq5Za/CCef+C0MCT7s71aVhri7
         I34HA0o+iJMxVCEqCNaJ0/J1R6mr+T1ah2THjFvVggtxb4Cf5KO/3Tcu7KmkpasWwlIX
         qfspKI3T+N8GzeEOouvFtD2cYb2iAwjgL+yLfNnyTxT61EEduhWeqeTk+3EoEFlc1AHB
         vDAb35KcK6CNMMH4ctnqZh+791/Yb8hjENNDVJxeCFhEcz2HZQbYMr5mRclNo21oYucs
         ThCZ3LxcEjrJB8LEFZmRwFXhUy5wQdqZkioKu9Iy5UzVcophGVj5QiS63Fq2rwIioHFp
         GpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710261565; x=1710866365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mSImzSxmXOyBGgGyqPE7UK1kzpq6nd8Az9TYKDgnRs=;
        b=e7fIF8nU3xYrMyuxBpvlha7co/s77o/CbkdDXHrXeh88+tICT+9yWNY0+shjzVmTi0
         zTVD/AUFktpEykpre0oKDIn+rieS/4U26VKjyGRdTvWmV5lZ+hNctuWov9u5+VNwAUD5
         F2gC4bjuNW6nu0UtgUao+sRYBKQubELiUrJW6/4yn7OsYJsxPcU2aU2ZnxR9AOs2BLe2
         7yF7vEGnbmflA2XeH1qbmo6j+y021JL82HIrZTCo6hc53GxKUhcbtJBYN3FtVgRcYskp
         gKFGTwgtRpBmZPfA8pEPTdWwL1y4DsmoMMLf3exULo0Y3A33ohk5l6yNT1WaZP1xe2QO
         qoDA==
X-Forwarded-Encrypted: i=1; AJvYcCX8FRhG3CLx1+2YTUKPImGLR6UREdyQUI7K+NAYL04Y0S+4vld3OgxoolNaUYUmUIOTC4hhrGdmfXXj6y4D2VNTfNSEDpoxioj8xTOoDS772C6hDdOBQz5hqzC6WIYEw+0MteW8
X-Gm-Message-State: AOJu0YwKTnImA6zBM7Pu91/gHgXYGU7kGWgs5pPSH6rTVnFw7Imge9Wb
	CfKc1/b3Ae76NBkROwXodZ+VMNmdJLtsuIJEI9c+CwvmVztpZYwN
X-Google-Smtp-Source: AGHT+IGgYD2whmhaip7IqFkMiOSXp9sHYtYDAcIcBcMfD55CiLoD5tohapN2hWRU/Z8le8yhDyr25w==
X-Received: by 2002:a05:6359:4c1a:b0:17e:69d4:ddbb with SMTP id kj26-20020a0563594c1a00b0017e69d4ddbbmr5960829rwc.14.1710261565558;
        Tue, 12 Mar 2024 09:39:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c13-20020a63350d000000b0059b2316be86sm6266409pga.46.2024.03.12.09.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 09:39:24 -0700 (PDT)
Message-ID: <4ad2bfc0-531e-4d66-b071-9bb983d8051b@gmail.com>
Date: Tue, 12 Mar 2024 09:39:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/bitmap: Fix bitmap_scatter() and bitmap_gather()
 kernel doc
Content-Language: en-US
To: Herve Codina <herve.codina@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yury Norov <yury.norov@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240312085403.224248-1-herve.codina@bootlin.com>
 <ZfB30-rLXEnJtjrY@smile.fi.intel.com> <ZfB4BOknvWRFbn6O@smile.fi.intel.com>
 <20240312173556.4727ebbf@bootlin.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240312173556.4727ebbf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/24 09:35, Herve Codina wrote:
> Hi Andy,
> 
> On Tue, 12 Mar 2024 17:43:00 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> On Tue, Mar 12, 2024 at 05:42:11PM +0200, Andy Shevchenko wrote:
>>> On Tue, Mar 12, 2024 at 09:54:03AM +0100, Herve Codina wrote:
>>>> The make htmldoc command failed with the following error
>>>>    ... include/linux/bitmap.h:524: ERROR: Unexpected indentation.
>>>>    ... include/linux/bitmap.h:524: CRITICAL: Unexpected section title or transition.
>>>>
>>>> Move the visual representation to a literal block.
>>
>> ...
>>
>>>> This patch fixes de5f84338970 ("lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers")
>>>> available in net-next and linux-next
>>>
>>> Not sure about rules of net-next, but I would add Fixes FWIW:
>>>
>>> Fixes: de5f84338970 ("lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers")
> 
> I think I cannot add the Fixes tag as the de5f84338970 commit is not yet
> merged in Torvald's tree and I am not sure that the commit hash will not
> change during the merge process.

That is not a reason for not providing a Fixes tag, it does not have to 
be in Linus' tree.

As a matter of fact, let us consider someone doing a back port of your 
patches into their custom local tree, they would like to have that 
information that this patch fixes a problem introduced by an earlier 
commit so they can take the entire set of commits as a whole.
-- 
Florian


