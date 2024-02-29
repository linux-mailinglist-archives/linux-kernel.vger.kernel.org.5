Return-Path: <linux-kernel+bounces-85891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B875386BCA8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9061C21934
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E0B63D1;
	Thu, 29 Feb 2024 00:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA8mAUbJ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F30823DB;
	Thu, 29 Feb 2024 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165860; cv=none; b=uffY+O1ZegXXeQxoEQfOIAfGFfhDauXuiXOPkFdxN6YWuyH1UarAC+omHMsEuWVabWiynCZi+/il0Ezzqh7NgoAUViCasVk6b5JpGT9uo6tBZwjs6w6dJGKUunIHTYEswq/8zjwKeYb/6f/I2aMULaBMBLXrhcHm5tzOnrQzZ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165860; c=relaxed/simple;
	bh=A13rBuLVSIDybkKSBfuKo7JY39JEFK1c6EyxhunAoNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4+kDnfRIrB60m9ESWtN7GEzQ31sCSaPuZ34yvNteb4uUKk7JlKj5Wz94DgWR6boi4JEWVlcjWp7CghCg1fNzaqZm0004DBig9fsn184AbleDy8Ys1E09tEM/ZtN6WxmiHCiDxoELOMEkF5+pBzwjrHfsQT3bclFFkbbL516ti8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EA8mAUbJ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a444205f764so3272366b.2;
        Wed, 28 Feb 2024 16:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709165857; x=1709770657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8rCAw2z9zs66RJeYr65+ZavbW8aat8OfjJwJ3rblxo=;
        b=EA8mAUbJuGVtEVmL8K/w36fkt82rvsEBrc7Jj9curX4C1Pbdn2UUVhnLQTexepsYXa
         Ra2SI2tZVHUN76eFnwRZLJDw3d1b6wGa/hCOo57/vMjvZtnNOM+IOWpT6hX4L/s/UzBB
         9WxXcvAC2a1UQ77ozFXYRVjVL6v7oU3dO7ZXhzVnDKcsVFf5Clr6S8MJIJvRACFSNmqM
         2Yr3UqkJqTTvx1tTRWuxhsvrf7Q+o06Vo5lYnfAP7c44olqEwoYyUSH4NlDZhkjnTewF
         GT9TzwVES2ThR75A1f5bEbi8ZQC+f6TPa3j0mkyvFre9zAsUugMP6Py0Lex6j2puuhsD
         c7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165857; x=1709770657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8rCAw2z9zs66RJeYr65+ZavbW8aat8OfjJwJ3rblxo=;
        b=f4yUWTrVjlykVkiUcPjqOjHqPdj4M+ryfeIDZKgcxR9IJAD3kPeGpzgjS0T1X3l5gO
         rruHaUsSKYFWe0Zx4XrTmAVr/Qg3+rPFed9dOAtrGW+u4hLv+JAi/8XHkXqDNCdVCJiU
         1C4S5ut0vZTST3onwkWLVRX55jipkDoztCfWS4lbKCPnIn2Kcr6kkZx+q713RqBmT4Dw
         JLdvCg/qHp6mojJDwMC0v/gMPBrsLUwfqMmHsrb1OtJz2PFUN9XN34KKdkPzcuFq/Cvz
         w/wcxpZaavPbvBW9j1K6SUhyFYB/euiyuV9UuY9TZBNqEANWdkPjs383Sr3x9OouSeLf
         xjag==
X-Forwarded-Encrypted: i=1; AJvYcCU/9znQ0eJ8DSSslKKmVJHAKy8hQKgsWJxmivRNZsaNNhD6iUmgKpDn/DiI9sVosC5D1lkEddohBHdDxFeonBly5QaSqW59099A6djSsBx9ZFbMp1+H0HWeQrwCVs0s9FC6BAtZC+wBS2m36jRj/b3l
X-Gm-Message-State: AOJu0YywjU9dFb8RbwVFsb3DbNhQo0XqklPst2vyE4f5pM1h3LLUmurk
	axff/vqz5nIoxr4tlTY+Wee91qfbthdajZPNMbIdJtrL62pxKorg
X-Google-Smtp-Source: AGHT+IEz4pXkzI7v7mnnRyh2MjDkBgjqqrHxiELiDYhG8SJx+250Pq7fVPqhPfscjqy2xoAEZQfv2g==
X-Received: by 2002:a17:906:7ad0:b0:a43:9857:8112 with SMTP id k16-20020a1709067ad000b00a4398578112mr312730ejo.20.1709165856356;
        Wed, 28 Feb 2024 16:17:36 -0800 (PST)
Received: from andrea ([31.189.122.3])
        by smtp.gmail.com with ESMTPSA id ce18-20020a170906b25200b00a3f2dcdf18dsm69575ejb.33.2024.02.28.16.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:17:35 -0800 (PST)
Date: Thu, 29 Feb 2024 01:17:31 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <andrea@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: Remove superfluous smp_mb()
Message-ID: <Zd/NG9IveQpamdDc@andrea>
References: <20240228175149.162646-1-alexghiti@rivosinc.com>
 <20240228175149.162646-2-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228175149.162646-2-alexghiti@rivosinc.com>

On Wed, Feb 28, 2024 at 06:51:48PM +0100, Alexandre Ghiti wrote:
> This memory barrier is not needed and not documented so simply remove
> it.
> 
> Suggested-by: Andrea Parri <andrea@rivosinc.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea

