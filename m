Return-Path: <linux-kernel+bounces-144130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8108A4228
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDBA28233A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F873C46B;
	Sun, 14 Apr 2024 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pD7V3xwZ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A57D28E11
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713095794; cv=none; b=GGp2lwfgCpXWy5JM4QffEKDy36kXGFaPyhdr5Psw1DQCTMIQnT+Kno7qgKA5/OUIH+s5TWEFXlNVToo7xvtMsC55D6S6yMqIVLPtb/Z8mHA7m/hDwtOBiH4wD/wZAb0DxRCHWoqPy9jvg65vHwu7EMbApp49shpp1JB67fXITSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713095794; c=relaxed/simple;
	bh=te8d8HOM7tGSKKyzjBD+iKaH64bmDCXn5BVnXjLGOy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9PbU6CSomj4jhkve3OAy+O4uoZnej95KOdpR1t+wnLrYfeG2IXSx43wl/gk+2udUh5sxH6WZ5rb4kmCmDr80lY7Ukw5IuU59o2vFyayOWE71lJN21t5umnaEG5tlXYQw+0RGqUjbTFLoBUHX90foqPQzDo40ol25FAt9p6VG+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pD7V3xwZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4702457ccbso277990466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 04:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713095792; x=1713700592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0J44Ja/Bzh4tals2v4JnH0Q75YFMRHuB9+NeZkXE5FQ=;
        b=pD7V3xwZeoxYJjqlisBYeGhY9Csobc6PhHHQVaKVKH7GJIIGKPIRAHQ2fGiMpkPNZb
         x3WscDg6kgQKlZ7RV8mKOGqyw/Mgk/+VJwMn59TjS+xFjQm8pRuXO4gGpuW/oNJ5l9bf
         G9NfVP9XAFR+3tjHzOcoj5vmNPBB48FZvAw6jQj+y3ZtAUrXHi2JoDk36CqPvg34OZe8
         Rtwh74J2o1PHhE4l2nLeR9qooAj6QB2urBtQbLhOuSNu/ePLi0g3yTWApeEoO70q/OjB
         8MlMgjN6eoa8U43QRNg+vIE8X/DkzoeCFU5rqxnoCXwOrhtFmMVFLmYdVYxJ5BOxwEV+
         ibCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713095792; x=1713700592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J44Ja/Bzh4tals2v4JnH0Q75YFMRHuB9+NeZkXE5FQ=;
        b=wKWvo6cLCdwLZ71ffK3A8i3Lb1simg4mw8FHYbNCg0qAtz4RtHiXlh3WqGL1LhGZ1R
         WIVsx8lqBu2ygtplByqoXh/Xv+OX1WPwoGjSLqGeR+6VpNhuOR7ffHDZP2034EH88WyZ
         u9vH40yAxUoGBGlq9s6p+h5CvBI76BMRIiTNW56m1b+itEuv3NPWS2PQoBeJCXNssV4O
         9MODnyT7i+dDJkkczVrnNy83tDqAdGPbH77Ext05vnSRrLzZzlj5j7S0TnAut0JfUxcD
         3DAyHlTcqsDOG63SV2aj7yMmupAyJRWMl9EwUxiXIId0LS8LfmrNkKF6j7lZn9S+Yl/n
         94cw==
X-Forwarded-Encrypted: i=1; AJvYcCWtqvjUmQIjZkRdV0+C9x0ptOuPTvMEX6mjyn4OgxTtJxn8vLUziKcFvBLvKdCU4PNkJFiGfOLM25kBeBWvh+DgQjiN7u+YdNZOsPwv
X-Gm-Message-State: AOJu0Yz0LgfG5yGK8IGH0PzuPIdJXJCZS4xjQITR7nxFSxw2wIzHIiqB
	BgEFAtMK2Aod28gNcfkJJAFacr//s4iaQHRsyo2FrNVZepgCG1afv9G7xfT6DIA=
X-Google-Smtp-Source: AGHT+IFINQBAAaoyQpplk9rEzgUdjg4KQ+JmoOqwBweFaAw5lfnYNzNR1zPQ/pl8mk0xi5cID1KKnw==
X-Received: by 2002:a17:906:1b14:b0:a47:2087:c26f with SMTP id o20-20020a1709061b1400b00a472087c26fmr4621383ejg.73.1713095791494;
        Sun, 14 Apr 2024 04:56:31 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id qw17-20020a1709066a1100b00a473774b027sm4125719ejc.207.2024.04.14.04.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 04:56:31 -0700 (PDT)
Date: Sun, 14 Apr 2024 14:56:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: sumadhura kalyan <opensourcecond@gmail.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	gregkh@linuxfoundation.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace function alignment of camel case by snake case.
Message-ID: <67995611-dccf-40bc-a6fe-66f6fcc613ac@moroto.mountain>
References: <20240414102443.98927-1-opensourcecond@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414102443.98927-1-opensourcecond@gmail.com>

On Sun, Apr 14, 2024 at 03:54:42PM +0530, sumadhura kalyan wrote:
> Issue found by checkpatch
  ^^^^^^^^^^^^^^^^^^^^^^^^^
What is the issue?  Keep in mind that when people are reading email they
often don't see the Subject so it's fine to restate things.

Look how your patch looks to reviewers:
https://lore.kernel.org/linux-staging/2024041457-outshoot-voyage-3e5b@gregkh/T/#t

regards,
dan carpenter



