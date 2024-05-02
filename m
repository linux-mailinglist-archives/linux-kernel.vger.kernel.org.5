Return-Path: <linux-kernel+bounces-166516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5008B9BBF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714E8284696
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B04B13C692;
	Thu,  2 May 2024 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co9U6Tax"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE36613C687;
	Thu,  2 May 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657284; cv=none; b=UNXwmPOMGpspt29/qEzQCGYkO/TyrCftUpVr1kKrse9UeZvv25gEFOj5ouuZD8olfRzTU+oEyvnoecuyDf05K7myNtF+IWP69F8QtOAMz43Py2CCorcSEY4OiwISrsTBJu5HvmDCLS4Z5+ezh89SUkLGeUS3L8B77d/iP6nX0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657284; c=relaxed/simple;
	bh=i/1dVEqwkmjfInCh6AgBy+Ih1TKNisJ6Cjyzv9iZzCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiRUGcq5SHq3Hc+AYZVY0AUML/OFbVUYuE/rATtZFA4+HNk6Z7N09xULklXq3ziPSEUHnMxIUjJ1xZxsrm9cX1cdkgWPdzdwyxsoEsk9okwbVHtAhcQ4rEc8oXgVa9Zxtsd0s6Inf2AnTs3dIz4E0zD5IvSqalf/AmImyuJc+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co9U6Tax; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ec4b2400b6so25958135ad.3;
        Thu, 02 May 2024 06:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714657282; x=1715262082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nxd33Xi7ZoYSNclbCJAjQlz1BlP19LjGVI5r3OgMdk=;
        b=Co9U6Taxsh6plbkK2QJqodUVQVlr2hvamdrTO64uuYmEl66X6Ihf5IK1qM5Pdv9G6N
         OkIlhIhL2j4T05B6uypOBrDPr9QHu8xdoRlgfYHZQuVl2edeappXMX/g6+7HXCJUbsMq
         BF+JZ5aUbMDK4n7TkZc7qb2scp3fuISEzVNt/v7FG8YeqrK7gGsQjDxsoNzx7DYa+e9j
         rpy+YpYaNhH6rPCelYWk0OIfQo+A15Mc+QpRH+DjVz67btT0XVSpzrhHvpZo3yshF9EF
         O5GQg2LxVVbdKb9A7CrZFnT+1UwTAriD/kci/jrQpR4zgVirs9qQMqrZ62FN2OEvMxq4
         hGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714657282; x=1715262082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nxd33Xi7ZoYSNclbCJAjQlz1BlP19LjGVI5r3OgMdk=;
        b=cFavFmbFTKNK2jE0wNqm1UffA6a2KRqlLKC9vKj0z1rlLiO11gUZn9yk0b31T2Y6YJ
         jmQJoT/TdMdusLgfa6iKe+9PSZomgugTODxAUmGm5T40MSVIoZVEwJFfRwjFEyYzWbpb
         fUWHvVuNPKZAuIIt3CB8rvXt79y2R8AWmQg5uwrZaGA5aiQZOsYnRz51CdTslYlrlwSJ
         0d1wJ34tI7dcQn+1bEZ4yyrMu9yuxe9t7XleWUDBsOV+D8bdXKoyqOfO37SIyGPVqGcz
         HxmmVCtuWu80ZJxc/GSzbDmYTpCEwAMrVNDnNIAtPyNFutRmIZOfUF3oo7Xb4cXGBd6v
         9ZfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHqNngMUwLrCjuhTY8wxkG/DPkNYthHcI7ZrYfU5zVRuuu+aZeaNz9ribHudLQVk7tntP3TIt2mdrDkcVGYY7usvkaH5vTLSeEaHZ54Wh2RtiljCj5nVEMZyQzU6FWNXwEH9hm3h3CYtSE
X-Gm-Message-State: AOJu0YwAhDuH8Kbv/wAf/64P+MYhuhZ0ADIB4Jnol8Iu+L8bplt9Exvc
	X40asAFMeu+EoDJlOVTOM/WYJeiV4x2fXnqBqh3L8uA+R8jv52PF
X-Google-Smtp-Source: AGHT+IEdipkDZCgqRkPVOJitGbl9naK2nUNOobgvnzr6LYchUoycriBULK/4/rlgzTU/+FVwQHsvBQ==
X-Received: by 2002:a17:902:f610:b0:1ec:28e4:691f with SMTP id n16-20020a170902f61000b001ec28e4691fmr2726025plg.63.1714657282028;
        Thu, 02 May 2024 06:41:22 -0700 (PDT)
Received: from hercules ([68.69.165.4])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902ea0800b001e2ba8605dfsm1267830plg.150.2024.05.02.06.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 06:41:20 -0700 (PDT)
Date: Thu, 2 May 2024 07:41:19 -0600
From: Aaron Toponce <aaron.toponce@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random: add chacha8_block and swtich the rng to it
Message-ID: <ZjOX_4aGUoY0msib@hercules>
References: <20240429134942.2873253-1-aaron.toponce@gmail.com>
 <ZjIzz5Rdkc8kxo4g@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjIzz5Rdkc8kxo4g@zx2c4.com>

On Wed, May 01, 2024 at 02:21:35PM +0200, Jason A. Donenfeld wrote:
> There are probably better ways of speeding this up (e.g. my vDSO work,
> which should be coming back soon) than just removing rounds and hoping
> for the best.
> 
> The problem is that there's extremely broad consensus that ChaCha20 is
> good at what it does. There's much less so for ChaCha8. JP's _probably_
> right, and it all seems like a sensible risk analysis...maybe...but
> also, why play with fire? Is it really worth it? I don't think there's
> much harm done in being really conservative about all this.
> 
> Another consideration with the RNG is that most everybody else's crypto
> relies on the RNG being good. If some consumer of the RNG wants to use
> single DES, so be it. If another consumer wants to use a cascade of
> ChaCha20 and AES and Serpent and Keccak for something, okay. Those
> aren't our choices. But we shouldn't prevent those choices by weakening
> the RNG.
> 
> So while it *might* be kinda overkill, there's also broad consensus that
> what we've got is *definitely* sufficient for all uses. At the same
> time, it's still pretty darn fast, there exist other ways to make it
> faster, and I don't think it's /overly/ much.

ChaCha20 reminds me of cascading encryption actually. That's a good analogy.
VeraCrypt offers several cascading options choices, such as AES(Twofish),
AES(Twofish(Serpent)), Kuzneychik(Serpent(Camellia)), etc. While there isn't
anything technically wrong with the approach, most security-minded folks would
agree it's overkill. Using just AES, or just Twofish, or just Serpent is more
than sufficent. ChaCha20 is kind of like that. It's extra security because "just
in case".

ChaCha8 is certainly aggressive. As another analogy, it's a 10 character random
password. While a 10 character password hashed with MD5 is *probably* fine at 65
bits, 13 random characters (80 bits) would definitely be safer. But 20 random
characters (128 bits) is certainly overkill to protect against even the most
well-funded orgs with distributed GPU resources cracking password hashes.

ChaCha12 seems like a good compromise. It's 5 rounds of security away from the
latest known attack while also providing a solid performance improvement.

Cheers,

-- 
 o .   o . o   . . o   o . .   . o .
 . o   . o o   o . o   . o o   . . o
o o o   . o .   . o o   o o .   o o o

