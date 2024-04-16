Return-Path: <linux-kernel+bounces-146903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF608A6CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB53285F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067EA12C520;
	Tue, 16 Apr 2024 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="xxXbc8FZ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3912BF24
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713274944; cv=none; b=rD3RqCAS5AbQJHS67/nzU6G5CUkrZTV0CkCuAwELDq7Mb225RhXgyX6yxkPLwgTUombbFqwikM35TDTomWD6VYwD25SASPmmRjt9ZwyfiF15KjQG5FVA34C3k5PySL1B2o2IX3S+i8Yj8DVqYl6joix7JRKuCCN6pLUr58w1sH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713274944; c=relaxed/simple;
	bh=kMawcbH4oJcmg+k/XZ5/mwGrqYfRcibfiUF4gzIlwNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7h2rRd7enK0/5X7PxLhw2fAB1W6zA6SqVPtE1W2qfbvemueW10NpXK4piZFWCb/aNPPOL9Nl73ef5iN1hB7TLkCp7Y1qcQEOdHIqP7uWiZLaLkUZtRTCEPDAQ0Ue/EOIZUNRJDOphMjsfKik4wq6a5UKV7r35tuf3XifOydj/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=xxXbc8FZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343c7fae6e4so3645717f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1713274940; x=1713879740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtRpYGlIaOwBawcvab5vfBiUnObfRbuDvN6mQAPgWkQ=;
        b=xxXbc8FZGpxwMp+36f5dy8xcMF92xssyK7CxJqFuXiBm85Nrrnd9BCWTac0Ts3X9UV
         oCC7j3Go98viNXrROs8DtSsxvySQ50nI6RvASVZJK1c4L3AugMHrI8scCkJQDOAMbCWY
         dfT7L5PKhpPz90picilWFpSSSMbikh5OAdgIwgks8Eylda7xiI/46ha2OsS5gA7kTk7j
         rio1cR5YDw7MZK6bOm8nfPOKmNLHC63zvS0SNi1XVM56BRKOy36XqxSGtGGo5CY3D1t5
         EuHqY6BBNxuszmvOb7TRHqKtPZlCwBnoNunfj+lhi/sO+hvV7u6B2ZtIuvi6iNODrX2X
         /K/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713274940; x=1713879740;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtRpYGlIaOwBawcvab5vfBiUnObfRbuDvN6mQAPgWkQ=;
        b=oIkW3HSIvcS8L7htFRXg+YKcMfqY86FN8hWsD8RkySsdmuLzcYCFdd3x8C3+yBR55C
         0OPdwQTKZz6Z7XY1EqwsQRQis88zv3CQu3nw05RPz3KNb9r5v/uDXJ8DKlGHaGD4cXxI
         ML3iiLlDGGr/hui9lazlxGEt/Wz4s2l0ibATSaFBZrSdVLwGpD64scWS8LhwzzZuxCqX
         eR7dXfxLdFO/pSy1k6BtCvz47ZvihVKnoXOmOO4Io4JTcyFUGsWWuSGgsPSH9oOMW2v0
         GugRvRcPAXISAE3TqS9cikR/jhTAHG2LZHeJ2zqzlU6jGZzPld6t1aA8HADJdQ7b+txf
         ajDA==
X-Forwarded-Encrypted: i=1; AJvYcCWookEUvzdK8H70FM9dtmR07BdeF/EW6AkFiTT+NtQWcychi3JjZoA++wsMdXk+gqnlHxx6okblfec2Yf/dy37g74osCQegQP9+8hGD
X-Gm-Message-State: AOJu0Yx6NnpHqXEpxvM+lAVgCugGdO7ZBXDyOSZN2UpkU2uZokooSDbG
	79SE9Oo1iC/tsWkATf47NCMn42ZfQBabLaa514f+23hmc3qpYNNX2OS5iMzliwg=
X-Google-Smtp-Source: AGHT+IHb2XUGXH3VYBdStkdwRwp1cNSpTWQi9dMAjeRtfvly6FxJAKALRZs42okP9GoT69KRJJu88g==
X-Received: by 2002:a5d:6484:0:b0:346:47d6:5d17 with SMTP id o4-20020a5d6484000000b0034647d65d17mr10870806wri.57.1713274939982;
        Tue, 16 Apr 2024 06:42:19 -0700 (PDT)
Received: from grappa.linbit (62-99-137-214.static.upcbusiness.at. [62.99.137.214])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d48ce000000b00349856b640bsm1353351wrs.67.2024.04.16.06.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 06:42:19 -0700 (PDT)
Date: Tue, 16 Apr 2024 15:42:17 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: I-HSIN CHENG <richard120310@gmail.com>
Cc: philipp.reisner@linbit.com, christoph.boehmwalder@linbit.com,
	drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lru_cache: Initialize hlist_head in lc_create
Message-ID: <Zh6AOaymY1kF+V8F@grappa.linbit>
Mail-Followup-To: I-HSIN CHENG <richard120310@gmail.com>,
	philipp.reisner@linbit.com, christoph.boehmwalder@linbit.com,
	drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org
References: <20240311030735.233470-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311030735.233470-1-richard120310@gmail.com>

On Mon, Mar 11, 2024 at 11:07:35AM +0800, I-HSIN CHENG wrote:
> Use INIT_HLIST_HEAD to perform the initialization for each pointer to
> struct list_head in the variable "slot" to provide more safety and
> prevent possible bugs from uninitialized behavior.

Completely pointless.  It is kcalloc'd.  Why explicitly zero-out something
that was already explicitly zeroed out to begin with.

    Lars

