Return-Path: <linux-kernel+bounces-82139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD74867FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971531C2371F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3251DFF7;
	Mon, 26 Feb 2024 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCSUiBJQ"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE512F59F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708972211; cv=none; b=YoaJB7yQ4+g5k1A5DUCJKnSYv9o7WISz6TwGZBY7dksqWwNv1c81Z0tVyVPawWIGrqaNskcs0xTFNqCr65u0NW/htPhsw98pqVPwtIp7jBbzbIxhkJTYdfEsD3IgWfX4j7SgC2D5tI+AW9ryr+TvGau67WPwBPjC+DRoPCkcY7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708972211; c=relaxed/simple;
	bh=xjONW/bKPGQL97hINA310i/fbG4hAfFnVLCLhtJ56rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEmyTxQFFJcvALH67wz9fKi1MMyrAsVvPMk4WcpKAwO438vw6vmRJE7qCchoWQJuFztz4NAUMILcrJKBl+FiLDYsZ3rkUpFqRjKeaXoTQj3p45+2UEvRcxbbhpgQIchir3B/TrAF/ZBgEBnHNXGROTTlsScKYiml3mBG0asIOBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCSUiBJQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-299b818d63aso2496228a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708972209; x=1709577009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOn7k2Deh/GMA9WZqq8gU7pIyVWTgJZ2VgIevVElsa4=;
        b=WCSUiBJQ6F4jpbSJZEW3an2JqUUsoIn++j5dknoGiAjotlaOB6wRH6dQNlafXH5uHj
         Ell63ktaTkJj2Iqab2a7RALTlm8JYCHWc3v8C7AVS1k6r17FN7HAWdeMkje+om8t3nd0
         AE1VKG2ofydEq6tE7ZDKxVRH9FldDB+94tGryw1//LzEHaYt4zyiupyTe1g49r3+aGJl
         2TZGxhpx3CiA9O/6XD2uJds844y750Jvssx6kwiUxMJz+QjUNls6AgyCiR4q4Co2gtNf
         O0LYQy22ccYXSAsnVoIfesxqxF4kQ464XLsw2GG5k0TsqwJb801kvtp8t6AZWTwL32S5
         Y8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708972209; x=1709577009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOn7k2Deh/GMA9WZqq8gU7pIyVWTgJZ2VgIevVElsa4=;
        b=g8bGUxf44s/BQsdUjtXBBsogwoCtSmldRaMUHY9qD5pUhOuAapRpq7wcz/23f+sOun
         44BpvRXS9aTps1FkYQ5WudqJAnl+dpOSEILhSsR5nZwFRt2G3xFr/LDUmXYss67ASt0g
         HxffUezMAvxnZ75Dim8F2ztNxytv3jr29cKjPswAsKNQiVDHjbUWvHzomDiAfICAHW5K
         vnKA6WUqFrJxlnwq0U8MWe1HTCwQ8/md4h6ftUSUZwuuo1TWXn7UKtn96Khtkg95Tevp
         3Ricl09ZGvWuBpIKGv0obU97UMfx5AXZGJT1y0Kgh2ZMTDBb2PIPEdjKNt09V4184YYP
         bPiA==
X-Forwarded-Encrypted: i=1; AJvYcCWPJJzka1fe1yKUYAHmOv3LICnG2BuTeoEu8+1pqhQ+4R4pHCYHn12BFdZGEuKeTFm9iOlZg6eIZpiK6e4sJVR83RRpD+88+yCmi58V
X-Gm-Message-State: AOJu0YysJ7FmiQgMaDbLxh/dNF26bZEd12wThycJGmYAOmDRvh6ChpDu
	2ozcg1KXo86OjiFET7LoCvpW/BH1sXg5zKJdQbec6Vh0JwBoJ+KakylCdVvweFI=
X-Google-Smtp-Source: AGHT+IFURY8vcjigTdRoDr9B4zTaCKahz+KlIo+x+BmSj7UCqZHdAy6TVIH3dj2ZmbQaoudyhJ0c1w==
X-Received: by 2002:a17:90b:128e:b0:299:2260:9a7b with SMTP id fw14-20020a17090b128e00b0029922609a7bmr10040677pjb.6.1708972208561;
        Mon, 26 Feb 2024 10:30:08 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:31e4])
        by smtp.gmail.com with ESMTPSA id pd7-20020a17090b1dc700b0029696f7f443sm6887554pjb.50.2024.02.26.10.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 10:30:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 26 Feb 2024 08:30:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Allen <allen.lkml@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCHSET wq/for-6.9,6.10] workqueue: Implement
 disable/enable_work()
Message-ID: <ZdzYroAG9ZNWMa3A@slm.duckdns.org>
References: <20240216180559.208276-1-tj@kernel.org>
 <ZdUK1jhMUSyC7yUj@slm.duckdns.org>
 <CAJhGHyC8Y7QU3TWDA1jz3D5VB3BDG9JcZ4XB_9rft1UiMF7uYw@mail.gmail.com>
 <ZdWMd2rHjCEUOfAp@slm.duckdns.org>
 <CAOMdWS+7=qD9e=Q+Rv65rMXJ1uc_KPVN43uWrJ+xUdoXoV-D4Q@mail.gmail.com>
 <202402250940.15C634D27@keescook>
 <CAOMdWSJ4WVXV+-c_dXOWmSxXadb4a-qgpBe+fLPNsZtW0-uayQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSJ4WVXV+-c_dXOWmSxXadb4a-qgpBe+fLPNsZtW0-uayQ@mail.gmail.com>

Hello,

On Mon, Feb 26, 2024 at 09:30:14AM -0800, Allen wrote:
>   I think it's best to send it out the subsystem mailing list. Ideally, get some
> testing/benchmarks run and then look at getting them into either Tejun's
> branch or via subsystem maintainers. I am open to other ideas.

Yeah, either way is fine. If subsys trees take them, that's the best. If
not, they can be routed through the wq tree.

Thanks.

-- 
tejun

