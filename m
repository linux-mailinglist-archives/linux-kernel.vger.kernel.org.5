Return-Path: <linux-kernel+bounces-98342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B5D87789E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0274DB20E5D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9D03A8C5;
	Sun, 10 Mar 2024 21:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGl4npe9"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEA11170B;
	Sun, 10 Mar 2024 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710106790; cv=none; b=dVQVKC0GDbHHc0lwMecypXhibDmkOx3TjFEI6cXIZexmJhFWSz8MMViDn7VBZX708QqF9d/rQgLk8kKmF2Rv4j1UZ1X95eIowR1wIykCrtj0TUrizyD33a7neH5LPkoDVoIZtLUvlXJk11yA5KaEh0I8KtOQOiqr9notYkFa0sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710106790; c=relaxed/simple;
	bh=lAMumxo+5YEbcTAV31v6JVTgM9MrsKjwH6N6Z0+nfVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0ON1KGTGCrjpuoBbid/jGI2oDXPYZQ/VuZs4sPps+o0Je9GRkhm71bOCOTl4GqsyLgFFNwT1y7GA/AatwKSOdTJ+gwrMIl5u6WjaNdM6jGHFu3W+kBWXkfEByEK0E4FFdhQ2WRjp5/ZGUqzF7Fa05tkV2JagjjMCwma1qMPs94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGl4npe9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dd74a009bdso5508355ad.0;
        Sun, 10 Mar 2024 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710106788; x=1710711588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lAMumxo+5YEbcTAV31v6JVTgM9MrsKjwH6N6Z0+nfVE=;
        b=NGl4npe9MtIkOqRFMllLm6ue+Dc589noKdj21uHR0gzhxKBc3jou/OxTZUZX5hfgln
         OX59KYWjnaQkn0SNwjZ2vj+5/GPN4zLzfYNx7XpySy22pO1N1mouEha+wpKXO8a2pXy1
         E4aIulyU4qske7/vjkCcox2w75ItEtsJyzYQ1Bo4MPrYy4ICeYqfBGqUIY7HgV71tmVj
         6rLxliiEnGdWECyWTE9D/eIt3uxGxpQ1fyzKm4TBjQMyrfZYGmlukDv3PArUqFtuH1LM
         W6zkNt7d0G4W4inYKZyNzx7lCQBqmM769J/1JIqG43/nIrRFyEhbzNwcMllSiUdcXIWT
         FtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710106788; x=1710711588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAMumxo+5YEbcTAV31v6JVTgM9MrsKjwH6N6Z0+nfVE=;
        b=PVBiV7/ekAgSqecbf1zR6k13o7iHa8G0te1ZRPRhdC7cxE6gsBfnH8JvgfFi5lZIDj
         qaG9wdB+TrPiUyOvqsfd8+xXppWFhLx7l+AwM9+LW0/TPHYFwBjvRayH3VoetG+ZsB8G
         r9Vbv1+hYCxaXGrF1gxT0p2vHSzlBv7dppKwBVo5kCbp6uea/OpOu5WIJ8RzueB/UHCC
         +Mfod7w5xHgtGDMLvdkOUZz2NENxP6/aaqJ9HVC+GdGQXw56uaBnWz+Wr15ufIUS8/aI
         vhZeynaD70MRVlqFe97QEOV6SjVuTO6i/sAFEehJvgbWGfFn8mIr/C4SlfzbZ1r5osXk
         27qw==
X-Forwarded-Encrypted: i=1; AJvYcCU1HhPrKrnc9yMUHCNA9rAauyIALwL+uU5iVZ3uc+roYuwDaurYg6SKFEx2mjSWts4UAveAY6vBmG6zkp/3LMspkKDbirYvWoTfox7tDHT9UZUfFi2C8z/VQ7ioapzNRqJmbHfn2HyVNus=
X-Gm-Message-State: AOJu0Yws/T1HS6Fs5+smLG/Uf+3WRM2h73xQE1DRqNsg/D4AJyHtVx0N
	pzz3UcE0h7s/K4n+MN+0uDNLsbV3Q3HIh3SaH02lBSxSSKhGW7q2Gfl0xe+xnyT1inxp5Rh1gMP
	nrJwd2AIs5bvvPWY7PSgbQN1Jgtk=
X-Google-Smtp-Source: AGHT+IF75g5xn57pcGs4rvuY9pxzwKMxpygxy4kODZSoghxPqrP3DcTCTkuSijGB8IeEOcKCi10M00Bs4nedeHTkHiA=
X-Received: by 2002:a05:6a20:d386:b0:1a1:8008:8cc with SMTP id
 iq6-20020a056a20d38600b001a1800808ccmr7874174pzb.3.1710106788117; Sun, 10 Mar
 2024 14:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310180322.25508-2-tinozzo123@gmail.com> <2TCU3VNKI7TD9.2PWW1CG9ZHYBA@homearch.localdomain>
In-Reply-To: <2TCU3VNKI7TD9.2PWW1CG9ZHYBA@homearch.localdomain>
From: Martino Fontana <tinozzo123@gmail.com>
Date: Sun, 10 Mar 2024 22:39:37 +0100
Message-ID: <CAKst+mDxA6XySavNEhK0KQhtFT7pKS3hF9fr32p=bswjAgFDtw@mail.gmail.com>
Subject: Re: [PATCH v2] HID: nintendo: use ida for LED player id
To: Silvan Jegen <s.jegen@gmail.com>
Cc: djogorchock@gmail.com, jikos@kernel.org, benjamin.tissoires@redhat.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ryan McClelland <rymcclel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi

> The PlayStation driver also destroys the allocator on module exit. Do
> we not have to do the same in this module?

I forgot to do that...

If everything else's good, I'll send a v3 that fixes that.

Cheers,
Martino

