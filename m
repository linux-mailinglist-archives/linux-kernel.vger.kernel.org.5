Return-Path: <linux-kernel+bounces-13683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BA8820AF2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85DD31C21961
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34132907;
	Sun, 31 Dec 2023 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="mIwyD0GL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E5823B1
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2356bb40e3so653547566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 01:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1704016464; x=1704621264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UMSYvbQU54i14Wl8nNwYDolPzMJV8XGJUyQsZje4uBY=;
        b=mIwyD0GLQQqdipZ3TUrib+Vdws8pi5kjz6dCN7TL5DIAENfuf8IjWPSeQrZxgDpIdh
         TKa6j9rmb0g+i28o+HG8tQC07e4cwU+RXVdbQQ1D/x+VIizAAZwd8ev1P/tqnNddynCI
         oDKK5CluVseZ5Ek7lMZrJ18DScZNSlBySFvA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704016464; x=1704621264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMSYvbQU54i14Wl8nNwYDolPzMJV8XGJUyQsZje4uBY=;
        b=umNrSfLwbQh4+Uf3Pcj5WIG9zOpBIZKf+4ZpJFaFBjVaYs4+1NDk/I7x1mwpm5+TO6
         +/9qxHrN4fa0+JbtCF+tARG6RXYWYH3B4ZVOtSPjHVdz+MEdaCuk+2CbV0gCNaLBzlC/
         TCmm/4jN3VCKiPFjyUu7SB6cBCXWz0cMHRXa3HXzcyMHrjz66v99ZK/YSM5hJ+O7jDaF
         Kjc5NaWcQKIuL52UoOTm8mbR23HmyYmxVQag1z0XqzJnpflrtI8ulPZ+YFb5ab7Loah7
         Q+8UKqf3OFnHa/0zgO6xiVv8CQ5lpV5ZgHVPQDVpQVEPiaUwPflzuY9fL4N82Y6PhSZI
         j+xw==
X-Gm-Message-State: AOJu0YzxN9eFOasbVcsgKG1w5SdY2JxObly1Asq2U9PAmwvWEkYbOpvI
	ZhAokqMVF3s1DZrNHIkcg9sUHpKvUM28iSUp1fMIz9AB+5DPog==
X-Google-Smtp-Source: AGHT+IGguVoLqG7zV7/NKjRUlfprYZvwSNt3u5/ArIaKl+XloJV19T36AckPR4r0EbobPLiRtrpZ9JopO5oPdj8AcQM=
X-Received: by 2002:a17:906:b0d8:b0:9fe:81a:c258 with SMTP id
 bk24-20020a170906b0d800b009fe081ac258mr8091222ejb.26.1704016463805; Sun, 31
 Dec 2023 01:54:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMVG2su=Kt5mkyEHGh5D4YH+1xTUFX3BhOjf-D0bcRTntav3ng@mail.gmail.com>
 <2g6gw7ybne5d5u2ewsbfpsoxslw5vie3d6whlhrcmbombkyzqs@dd6tr3se6fu7>
In-Reply-To: <2g6gw7ybne5d5u2ewsbfpsoxslw5vie3d6whlhrcmbombkyzqs@dd6tr3se6fu7>
From: Daniel J Blueman <daniel@quora.org>
Date: Sun, 31 Dec 2023 17:54:12 +0800
Message-ID: <CAMVG2sueLr7Sy58iaZqbnvvj2POtQNRiaQRNh2TjPw3gw3ei1Q@mail.gmail.com>
Subject: Re: Stack corruption in bch2_nocow_write
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, 
	Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 31 Dec 2023 at 06:41, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> On Fri, Dec 29, 2023 at 07:43:13PM +0800, Daniel J Blueman wrote:
> > Hi Kent et al,
> >
> > On Linux 6.7-rc7 from bcachefs master SHA f3608cbdfd built with UBSAN
> > [1], with a crafted workload [2] I'm able to trigger stack corruption
> > in bch2_nocow_write [3].
> >
> > Let me know if you can't reproduce it and I'll check reproducibility
> > on another platform, and let me know for any patch testing.
>
> Can you give the bcachefs-testing branch a try?

Good fixes! I can't reproduce the issue on SHA 67503f8d4 in
bcachefs.git/bcachefs-testing, and no warnings are triggered with
CONFIG_PROVE_LOCKING.

Tested-by: Daniel J Blueman <daniel@quora.org>

Thanks,
  Dan
-- 
Daniel J Blueman

