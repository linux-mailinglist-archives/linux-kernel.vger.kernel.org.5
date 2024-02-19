Return-Path: <linux-kernel+bounces-71106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62FC85A0A8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E222833A3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B68C2C1BC;
	Mon, 19 Feb 2024 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT0hFkyx"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E02C1A5
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337561; cv=none; b=F+nBXOtWUedktBdFbY9jEZx7EEybkFbl7yjwHHBBj+2I2okr+GR4K8sb0YNiDFQWaea05LQDeRXFzQhKfNe00J58FdxImPjRSBJLuC6iRQS9Bvn0ClW5c/fyigDFKuq8Ttt7bv8HhTcMKwWI9Gr97dh8pVBu+cp5fVH3AWKMMaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337561; c=relaxed/simple;
	bh=kAawhW7nJkJvpWwv5BQSUc40HFTyHO8ko4s/6caR8ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHgkAT7uYmAWRrY0Qc7sPsbo8sEEPSB73oxEv987Ocw8U9mGYYqfdrvfprMEMftU5bde94J7NpZ26I2psy1bGRmQyUzmpqKFOfR8sfaqfdMsy5Olwygow2SeGk3N0VmEAEjepb/vkuwsNU9xpaCGf3M10DwYNLI2upFn/g79gag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT0hFkyx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3e921f4802so101038166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708337558; x=1708942358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgeM8dG/n4ZXzp2IsdonmD1u0nnBnqJlHW8kJO8yOgs=;
        b=TT0hFkyxrDSzZsNzWo8YD+w8vYWd+z7upTMjpLegheoTvRkLYgyFsgCbjzHSE5XF8A
         ak24FawEjNbB2g8Vle+mpXApUpDNtrKO6bJMdC0KV77h3zaf6o3qONXZB9hL7X247yeu
         b10WG9l1Rh8qi2xeM9VuqBL9nj0wWyZypg0pqWPi3SvwVpIze7xbztlimcazokI9LouK
         dtR/T9P0JJ+I/KA/BXWIyG1jC8ulrcFvN5aAuSxwjzRyQiJat5O1n8vk+NHJsOW4iJcr
         m3zo1PbBFJn6EQykdZsJ/vuWSbb5AHQMCO+zQ7x32hFyl8lPCBmbXWdthVRyAvjpMZ7d
         fsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708337558; x=1708942358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgeM8dG/n4ZXzp2IsdonmD1u0nnBnqJlHW8kJO8yOgs=;
        b=L3E7f+M/rLwChoyTt0KwE5ldGUG4A+4F5T++pGCvYC/61dXpopubIY2MQPDE+C8ZPb
         FrNXI/HhE852WUtD86rJI6nSs+9Y/n1H+PAcRaagQjfr16I32jGidA7l8c/oWw6FelqA
         7xsGAw4TNdI7bFLEe66P5GXmtcZRyuqFZYa2lJeXUGjx5D7O5jUkxi9c+D9HPt8kOjhs
         bA3iWsi/qYgRCVADHiDPa4yy70dFNboQdhkXNjua1oyMXwkUmwGaJk3GNmGf9sO3q63I
         FiGRLimPSMcJb+DthTo4UNq/rnYdOxmNjGk/IijHpU0mzWDCe7Rf1iTCHDKhDUygsYTE
         g65g==
X-Forwarded-Encrypted: i=1; AJvYcCXZqaEQQzKitY+bl5fihe6w1ZnxyFq31BsXIzOkz07nMRr2iry3hrexd5Q6xW4ji5cdzX5prgy8vNlroEjKuAByAYnHhdIvDGNDlPX5
X-Gm-Message-State: AOJu0YyqjbF/FzyKR0kdPnZmaehTMLggFoUzqP5QWPopHPzkctN7yYy9
	M71io1DnmLjYNmPghSsOtjSn2vLZ8QrkAiecmZny5kurL8B9IlyF
X-Google-Smtp-Source: AGHT+IGPaP61nqjHVTMc/x0JkW/xd0y45abMJsxgxvQEar0eKVaEJwH8BFRHSBIOwQ6v0oxR64ryDA==
X-Received: by 2002:a17:906:5f8b:b0:a3c:f4d6:657e with SMTP id a11-20020a1709065f8b00b00a3cf4d6657emr7757560eju.69.1708337557282;
        Mon, 19 Feb 2024 02:12:37 -0800 (PST)
Received: from andrea ([31.189.39.37])
        by smtp.gmail.com with ESMTPSA id fj6-20020a1709069c8600b00a3cfe376116sm2792190ejc.57.2024.02.19.02.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 02:12:36 -0800 (PST)
Date: Mon, 19 Feb 2024 11:12:26 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Eric Chan <ericchancf@google.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	conor.dooley@microchip.com, emil.renner.berthing@canonical.com,
	samuel.holland@sifive.com
Subject: Re: [PATCH v6 0/4] riscv/barrier: tidying up barrier-related macro
Message-ID: <ZdMpij90S0iTT5XQ@andrea>
References: <20240217131206.3667544-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217131206.3667544-1-ericchancf@google.com>

> Eric Chan (4):
>   riscv/barrier: Define __{mb,rmb,wmb}
>   riscv/barrier: Define RISCV_FULL_BARRIER
>   riscv/barrier: Consolidate fence definitions
>   riscv/barrier: Resolve checkpatch.pl error

LGTM.  For the series,

Reviewed-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea

