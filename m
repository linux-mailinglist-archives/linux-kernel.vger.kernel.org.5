Return-Path: <linux-kernel+bounces-31431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B27832E46
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFD61F2538B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A0355E6F;
	Fri, 19 Jan 2024 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hglvHBT1"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F455E70
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685848; cv=none; b=S3q37nte3TIMShXLupCjnAmRw4h5Kz4O15yRTWbWifHj3SfD/Z+10QwUqWMhj6DN0sMIEwYJn09hf6e42OEnlzt/jx+ccOiLaAlbJsNx9DSniz+DX6K3b58X7Fy0A7C7IpSknritw+XR3nsMNufnXLaZNHOyG8ky5FPU+Fq3I7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685848; c=relaxed/simple;
	bh=IBhAo+p4QBZS3eSqDGhhgoM0tENX26Pe9NJRy76DXQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZXRA2wYEnRDaf+wIjZQnFDnFqvXZbJZbR87q6PuE6Lgk/260vBzY5q9QMQBo90skabUZu07HrzGvGb+3dHn3WM7rPuFTm7WTop786AvdV80YxY2LnPUerehU6yx0OhKbW8ioUq66MUAb/HjXt3+lIM0Q8NCES1hRlra1mEROO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hglvHBT1; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6dac225bf42so761015b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 09:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705685846; x=1706290646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T7tAFdEcqbuZdGMmYYdZCfxqKm3ZPSINk39pDgE/fPQ=;
        b=hglvHBT1FlbDe0ELg8C3Lg9V0DxXId6gDwS1PNLXNKw0UcY7p7jOPIW8bbVExibKaN
         vrQvB492eDKHT05Z+ARcPO183AQVArUhtoU0/AjdJK8UTmM5RKdVx+m8ft0Y1TxX3Gi7
         b0o9O22TR253NHV6ooWi4nwJwh6vzK/VDEhTqWgGS4PDKk/fpSUB/zX2NkpvQvBsbAzB
         3H1yQ7y8pgOMp7EbnuHfiitn4jFFD0+Rw5w7Nrg6VQikob9eGRCnBNjmYaMRpAq9HgZ9
         j3OwwZN6K+93RJysyVlNJIOr0pPdAfoha+8RDFWIpSpF6rOZ6wPk06dwZS/+dpBlcR99
         4oeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705685846; x=1706290646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7tAFdEcqbuZdGMmYYdZCfxqKm3ZPSINk39pDgE/fPQ=;
        b=cexHxsjrgJztQeatSLvfi+sfm0C7nVLdbA0YloAG9HPXDiEScZBBqpqg+wU6n5zU4R
         K7ffpvDLJ1G3mR/vfD4RBcEG91yJ61xspVfzsUz46DdZ1oFuj02I/fKwhGKGPrs703zB
         x82a0Szr2bDp8zdK44/IEvk/E7YdIuAvKLcFoUgwmc/R6qoXjqQSP77b4uaRPHhPRkPj
         mN4n72VnSzL+g7O1dLJXq/R+4rN8z5pUdHOOAt+HtiVGKUfPYh2C8+qV9BRDXDICJ3id
         VAGh3vjA1xj7ck12srgIbqPDrTUxlY1G8a7PD5Sz0KM69/W4dtm3OpuFSdkJODpwbe5F
         eFpA==
X-Gm-Message-State: AOJu0YzMoQjyz8XngdtXMBcn9Drpl+2vBDVHFmTia0ou97DZuolcJKSx
	qeowtW9u6DUW1qu+uZBRFy6dV2XkXJdQ3WmzCW9bH1weq/wIHYA/qX9KE6+38g==
X-Google-Smtp-Source: AGHT+IGgMFruydOS7Ra3zGpxrBpq2uYQnrpAUcCrjC4myT4M4Cp7q7j6gRHI8G5qx8WZHC73J2u5FA==
X-Received: by 2002:a05:6a21:185:b0:19a:6830:2334 with SMTP id le5-20020a056a21018500b0019a68302334mr222044pzb.46.1705685846389;
        Fri, 19 Jan 2024 09:37:26 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id x34-20020a056a000be200b006d9b4171b20sm5371824pfu.112.2024.01.19.09.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 09:37:25 -0800 (PST)
Date: Fri, 19 Jan 2024 17:37:22 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 03/28] binder: fix race between mmput() and do_exit()
Message-ID: <ZaqzUrkfSqw0jKkG@google.com>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-4-cmllamas@google.com>
 <Zal8A95q3jVl4nu5@google.com>
 <2024011935-placidly-justifier-4338@gregkh>
 <ZaqsBTQ1x5lQG9Rq@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaqsBTQ1x5lQG9Rq@google.com>

On Fri, Jan 19, 2024 at 05:06:13PM +0000, Carlos Llamas wrote:
> 
> Oops, here is the complete info:
> 
> Commit ID: 9a9ab0d963621d9d12199df9817e66982582d5a5
> Subject:   "binder: fix race between mmput() and do_exit()"
> Reason:    Fixes a race condition in binder.
> Versions:  v4.19+
> 
> Note this will have a trivial conflict in v4.19 and v5.10 kernels as
> commit d8ed45c5dcd4 is not there. Please let me know if I should send
> those patches separately.
> 
> Thanks,
> --
> Carlos Llamas

Sigh, I meant to type "conflict in v4.19 and v5.4". The patch applies
cleanly in v5.10+.

