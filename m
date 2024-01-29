Return-Path: <linux-kernel+bounces-42894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88417840838
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44AEE283483
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEE466B3D;
	Mon, 29 Jan 2024 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="WCv3wOx+"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4752D66B25
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538352; cv=none; b=PunbjJaoDzaOtToWVj7RpRbYV3FiRwN4Es3wHPF/ePdTZNGZl5LJt48br0u746/BTiDPMUGq9uz8NJWYqqm6jZaea5XbnuhrF5DmJM1bhSj0PdbvzRjjdLtJT729p5WKO7+2OqtjJRXVEf3mNTkDY8mSP339ZuU8DcK/dBiI6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538352; c=relaxed/simple;
	bh=e17Rkv1b2zsSeeqMrexTc68GxjbjLQz9ZAoYZ7+OZ5c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jnrFb+aHp4AYxXFSF1sKsQM9nGXAhZQ/BiASta+IkT+4LeXLkmC6Mwv+LFBfZKiHZZ+vZRjU0qiz4BXFzQczgXNOXhkIsH2XxChpHeo7rm5Ywxt/KMo7LSkWgIED4CEhF9hjhdKbVafbKSU5gOOF2JjIgqqXGOjD58rRIj4HvQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=WCv3wOx+; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cf33b909e8so39008251fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1706538348; x=1707143148; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwSVowneYmPFoCOKARAGdH4LO9xvR38K95NUycdd4WU=;
        b=WCv3wOx+GMfJ9gaQ4PIj4r6eINyGfZNpTH5R08krlxG/QLbzKYDnSIxAAtXAV6z9ER
         z4uJpMiIEzaGXKbw6EWzS1e3eQ020BaFtqHTqHjS1cKReNDYlVFFQ60waO2adtMa9wIH
         ZxVWasFDvIioMkf6kDIE5NzltAdRinBaaAZT1Wu6DqBv7/K3EHs8udYNwhc4d0BFhQwk
         IY4pW/R/WdnoDrCAHuklqGN3d7e3j9qT023HPGq7TT/2iyvUqUfRHV8zgc5AgOlun4uk
         ybbbkpcm8XnVtz9NbZuMTEA3ZDrP5syysx8rdtzm4SPXo7ikXumIoj7MEogW0gSTKp4N
         C10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706538348; x=1707143148;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwSVowneYmPFoCOKARAGdH4LO9xvR38K95NUycdd4WU=;
        b=cXP6ZKZrmHShp7HhiAyedDCDkWd5VboPuL/b7/Sd95aI9WZcW6ERojcNRhpHc6b1g3
         krnb6W6hHrl07IROq3E1RQwukTTI/0nBcnWQZ0Nn6CSZtKzl1Z0QI1yoGsvQoxv+boGF
         WD0PhfMWWfsUS89R1HIwY5hrGTmNGhYkxbttzfXmqnWbUsBuhI1W5PiTYc+QS+RwzCwZ
         /OmODCVZFdSuPbqhGTylw4MIb51N1AdQ0w1Tfxzy3ci9Rydu1KdOTXHipZoztw5BVr/H
         GfAPELNUkvWSiz8iW27V9B0iCTyplfknuaVPqIgLIAJS12SAUbD0JvdFv+kakAstVfXs
         wt7A==
X-Gm-Message-State: AOJu0YwNlHO4OePVm8S8TM2uef3S+6OoFmzGfbjdDAaPlKdAR0CyckHv
	gPhou4JMh5OhJobDXqDU5MXTm3YNLvx7EdXq45YBuKuyqRTnHF+kS/dFh/veFQA=
X-Google-Smtp-Source: AGHT+IEabj504gYXXe4D4PEHMJg6a1FtXh3NfgJV/TjJ5fhQu4YxTrEI9z3hdikxYRV4R7GfF8W3+Q==
X-Received: by 2002:a2e:a78e:0:b0:2cc:78b7:1ef0 with SMTP id c14-20020a2ea78e000000b002cc78b71ef0mr2957712ljf.4.1706538348044;
        Mon, 29 Jan 2024 06:25:48 -0800 (PST)
Received: from smtpclient.apple ([84.252.147.253])
        by smtp.gmail.com with ESMTPSA id x12-20020a2ea98c000000b002d0524ec71bsm164546ljq.117.2024.01.29.06.25.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jan 2024 06:25:47 -0800 (PST)
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
X-Priority: 3
In-Reply-To: <38fd9f3.214a.18d5548ac0c.Coremail.alexious@zju.edu.cn>
Date: Mon, 29 Jan 2024 17:25:26 +0300
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <DCBF7671-E982-49F2-8687-DF030D2A99C7@dubeyko.com>
References: <20240122172719.3843098-1-alexious@zju.edu.cn>
 <F36C0C80-DAF3-4D8F-8EA3-5209E8FB5BE3@dubeyko.com>
 <38fd9f3.214a.18d5548ac0c.Coremail.alexious@zju.edu.cn>
To: Zhipeng Lu <alexious@zju.edu.cn>
X-Mailer: Apple Mail (2.3774.400.31)



> On 29 Jan 2024, at 15:54, alexious@zju.edu.cn wrote:
> 
>>> On 22 Jan 2024, at 20:27, Zhipeng Lu <alexious@zju.edu.cn> wrote:
>>> 
>>> When the switch statment goes to default and return an error, ptr should
>>> be freed since it is allocated in hfs_find_init.
>>> 
>> 
>> Do you have any memory leaks report? Could you share it in the comments?
>> Which use-case reproduces the issue? It will be easier to review the fix
>> If you can share the path of reproduction.
>> 
>> Thanks,
>> Slava.
> 
> Well, we found this potential memory leak by static analysis.
> 
> We found that all of hfs_find_init's callers won't release `ptr` when 
> hfs_find_init fails, while they will do release `ptr` when functions 
> that after hfs_find_init fails. This tactic observation suggests that
> hfs_find_init proberly should release `ptr` when it fails, i.e. in the
> default branch of switch in this patch.
> 
> Besides, we noticed another implementation of hfs_find_init in 
> fs/hfsplus/bfind.c, which is essentially identical to the one in 
> this patch (in fs/hfs/bfind.c) but calling `BUG();` in default branch
> to trigger an error-handling.
> 

I see. I believe it makes sense to add all of this explanation
into comment section. Modification looks good. Mostly, hfs_find_exit()
does freeing resources and if hfs_find_init() fails, then hfs_find_exit()
is never called. Maybe, it makes sense to set fd->tree = NULL too but
it is not critical, as far as I can see.

Could you please rework the comment section of the patch?

Thanks,
Slava.


