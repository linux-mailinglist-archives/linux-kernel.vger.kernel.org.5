Return-Path: <linux-kernel+bounces-79531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC2A8623B4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817CA1C221BA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDAC1B97C;
	Sat, 24 Feb 2024 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbITO3gj"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA99C17579;
	Sat, 24 Feb 2024 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765651; cv=none; b=ILCG1Pulj90fTox692EZYFf/8RxRdXJ6UbJD363bCECUHWi90/s+8hJ8WXBLn9uWKROdK/an8mx/EQRBgweY1vYVpGG44CZqi5TUmU0/d6WLLfdvuSph0W2V4Y1c1tFeg8alf2+a8b9OmX5nSA4khojozT5XOVDX9r55iJizQqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765651; c=relaxed/simple;
	bh=4M+bZKyaz20xTlf7slVV/NGOumHE1bHwkyKsYwOdURE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G0jyXTlJ5/stwih55y+SpJQs590grnjVzRKVuC8m3LNg4oGQZYkHvILmMAFPHVFbSD90HKb9suE/Gy3tz2WLcEfE13Ut49u7U3IZ7QFSV5UWy39cllDLt17io4LsmfEksEjVNc1JHwrn70MBDxs6Yw3qMNk34fcZOSVNLPGUGik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbITO3gj; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1375198a12.3;
        Sat, 24 Feb 2024 01:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708765649; x=1709370449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4PdV2VKaPys/RwV9Ux4lRb/Xv8a//cmZyvpKpBTO+ZE=;
        b=PbITO3gjq0sljbLl9ieVotphLUQXr+zQ0SeQ/nFqT/jBedSSePQUN3qC3gjarqXoVw
         guy11pZEyvYtEcEDe3B7adpGkXHK7iahDN5Nevu6X8tOkfhxj5WNYPK3v+68XDsugzIj
         rQ/xKarwKYCr5t9N3JSqOZ4dfeN7O4zsJb3OgaziGMK5qGbfyj8p9WM01YWrIVXq101q
         RZIM+hnEsd7tl6fWbbIrqjTxkpY2ahyd7YXL1hBB+DB8DgAHTGuC+v3emeAvCR4wpK02
         le8sIZ6PCmujtGboKcpzu9xf2HfYULeNl2nPDy0OJJjWEzdeJ9lx+QBpl9MFXoe81fsc
         v0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765649; x=1709370449;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PdV2VKaPys/RwV9Ux4lRb/Xv8a//cmZyvpKpBTO+ZE=;
        b=QT9H/o2qc40fI/c9fCa+F6XYeRkndY/xa2C0UkbBuf0dxD5/ipWTJbnFFKjoR3H530
         cSrZtFWuA7FyYFODLAa1a0a5iTUa31KgPMJWzDSPiQY1Ls4Q+lHBBTYv2BTAzk9AXolT
         DhsXdEmDiThCCToUGLqxy9XZw+9chs3Et7jTHLjXonyWTuPXBATxSddgF/tGnCeC5/y4
         +8v3M2+ilIkZDB/8ZJ7NuX6E1oYRs3/9SlHfP35eWVYVZchPU/tMQkKlfDosZ3IwNS3y
         yIOl+rY/zoAUuZ9rxUsfJel8S0BkeOM4RjGjEsPS7jGXMC3YBikJ+/Im4CpVv+2+qXFV
         ZRqg==
X-Forwarded-Encrypted: i=1; AJvYcCW3bhmjZJngE1l61io4tQ8gNwnDijZPzMe+oUl1bjp80HLb0csLTJJAKkyOL02nlO8SsCS/9kA6gW4fbPkptwF/4u3OeBMHaWNf7xIHgxUF1cLnaP00YLfl/XOQvad0zoZZJ03VzQU49PYGC2I5Ybjf+CZ0s8P579wpKXzHyXFVAEnHrQ==
X-Gm-Message-State: AOJu0YxBE7dO3bVRVHgpFjoCQBhWBa1ZIe2RC9L0JbzheDHHTGj6F2Z+
	CpHtK5aiED2vk2hOEy+Ly9ypkcU4MnvgMvRSTHsRnqf0/ml2dY2/5mT9Hb1I
X-Google-Smtp-Source: AGHT+IHlffaot7kk6mKJc3F2NLJoUKnYQyBLp+zO6mSMscVzXiOV/ygy7I2JnwzeUfjzdPJnRhic2g==
X-Received: by 2002:a05:6a20:c791:b0:1a0:9ab5:1e83 with SMTP id hk17-20020a056a20c79100b001a09ab51e83mr3221512pzb.24.1708765649023;
        Sat, 24 Feb 2024 01:07:29 -0800 (PST)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id c2-20020a63a402000000b005e45b337b34sm728127pgf.0.2024.02.24.01.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 01:07:28 -0800 (PST)
Message-ID: <22187737-e0ad-4cc4-98fd-5e43ebc5ecee@gmail.com>
Date: Sat, 24 Feb 2024 18:07:28 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: linux-next: build warning after merge of the xfs tree
To: hch@lst.de
Cc: chandanbabu@kernel.org, corbet@lwn.net, david@fromorbit.com,
 djwong@kernel.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 linux-xfs@vger.kernel.org, mchehab@kernel.org, sfr@canb.auug.org.au,
 Akira Yokosawa <akiyks@gmail.com>
References: <20240223140619.GA30519@lst.de>
Content-Language: en-US
In-Reply-To: <20240223140619.GA30519@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On Fri, 23 Feb 2024 15:06:19 +0100, Christoph Hellwig wrote:
> On Fri, Feb 23, 2024 at 09:55:09AM +0100, Mauro Carvalho Chehab wrote:
>> but it is very weird for the ones reading the text file. So, what
>> we do instead for pointers is to escape the entire declaration, like:
>> 
>> 	``*inode``
>> 	``struct inode *inode``
>> 
>> I hope that helps.
> 
> In this case it says *foliop for an argument that is a double pointer
> and the comment refers to what it point to.  I'll see what I can do
> there, but the whole italic and bold thing seems entirely pointless
> for kerneldoc..

Indeed.

How about teaching kernel-doc unary "*" on param?

Substitution would look like:

   (kernel-doc)       (RST)
   *@param     ->  ***param**

Sphinx detects double asterisk, starts strong emphasis, waits for
another double asterisk to appear, and stops strong emphasis.
Hence you would get boldface "*param" in pretty printed docs.

Diff below (against docs-next) should add a rule for param_deref
(only for RST).

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 136104804375..bdd6f3b489cc 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -65,7 +65,7 @@ my $type_constant = '\b``([^\`]+)``\b';
 my $type_constant2 = '\%([-_\*\w]+)';
 my $type_func = '(\w+)\(\)';
 my $type_param = '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
-my $type_param_ref = '([\!~]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
+my $type_param_ref = '([\!~\*]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
 my $type_fp_param = '\@(\w+)\(\)';  # Special RST handling for func ptr params
 my $type_fp_param2 = '\@(\w+->\S+)\(\)';  # Special RST handling for structs with func ptr params
 my $type_env = '(\$\w+)';
-- 

And you would be able to write the kernel-doc comment in question
as follows:

diff --git a/mm/shmem.c b/mm/shmem.c
index 750ab1dcae27..0aad0d9a621b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2152,8 +2152,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
  * There is no need to reserve space before calling folio_mark_dirty().
  *
  * When no folio is found, the behavior depends on @sgp:
- *  - for SGP_READ, *foliop is %NULL and 0 is returned
- *  - for SGP_NOALLOC, *foliop is %NULL and -ENOENT is returned
+ *  - for SGP_READ, *@foliop is %NULL and 0 is returned
+ *  - for SGP_NOALLOC, *@foliop is %NULL and -ENOENT is returned
  *  - for all other flags a new folio is allocated, inserted into the
  *    page cache and returned locked in @foliop.
  *
-- 

How does this approach sound to you? 

        Thanks, Akira


