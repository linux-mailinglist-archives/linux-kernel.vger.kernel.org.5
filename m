Return-Path: <linux-kernel+bounces-75093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EE985E2F2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C70BB23C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCD481745;
	Wed, 21 Feb 2024 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRYMvhGC"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5507F7CF0F;
	Wed, 21 Feb 2024 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532498; cv=none; b=RBpgYPyvPGJFoxxjMj/klHdV7OD0YMoLcdRc1qYhLbJYelbEu/RzdC/9boHm3ziZ9Qp3ylQk7QVF7w8oDRcTfyfMRMWILGQZX5vRWlJgjs6z5i1KkWIcjHmNWC/3OHazzy4RhgqLL794gnye0RjfpgvGNjHvm/ejzADJ49m+0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532498; c=relaxed/simple;
	bh=H2g8Sjo94t+3EppcGyPtOMSH1Arg7D4YsENxoJOz+Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkzCTB5s/cTeHNOkcdaOP8e3cPFBOJgEqtprxoOatZEGLbn+9JmI8TCfCHRdZa6mL55VJCAG/ja3rJd2RsD/oGF6dJy4+G4T12jKP+ZrtWGnD615BOik+s7VNufcbMlyN4pfWDHw/uKwp4XhHXd8clpnAf3Gs3oY68RS1IcmzVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRYMvhGC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4127855308bso4547355e9.3;
        Wed, 21 Feb 2024 08:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708532495; x=1709137295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivfF/a/CySd30i46ylvdeLae84HmE51Wg4xzC2rxlvM=;
        b=aRYMvhGCUVweqcRl0444QHdvni90+KkdvtFwtCp3Z3ov3zXYit2FkP9KLEPkUCZtEt
         1CPm33u76HuoTKiF60WHthRLdUrJjgc6fgbgs+mACw5hgo2l7/Sm6vIqki1odXjFT1oo
         LwKJadL6h1p6U5s3uak2c7LIlMquc6FaLODFToyM0fpGs3i8TPavIuqc2LOLySerDQU6
         i1Zq5CMHdSmCFbIzn4HZEUtxsGVApVEfMcFcTTO/U5hZ9G8T4+YVTZ8UMEMwvlvR4j7l
         9gr2IRw45Z3q/IXATDrcAtf2GyRqjmRdhwAPP73/O+FmYTKroOyKZyjToOJ0OdKP27+4
         8ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708532495; x=1709137295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivfF/a/CySd30i46ylvdeLae84HmE51Wg4xzC2rxlvM=;
        b=mM6hIIyLPPtzD07v7xoTGgL49mQrCfDtgZ29Haw3g62tbVMnH61hKDUWfWGvUQ1jZl
         8bmyCd0AgYt2PtHqnOotQzQcY38pO9+e6UnPRU29hmOjgpK/8JtSHh2IR9EvKCKGmexB
         Tq1IwluCjD684doWClK3poe6XldRzlQt/hXbS3moR4+aB56fILl9pL6bQU1k/1uolaVS
         GQPAtIhZqFw+HC3jTDvI+pXiGRizGgGAkyG+jDbyLNIp8U451buC1CoJuVYpsIIqK6i9
         jjexvh13cfACFCHxd0zyALgnSKoPLkZbeni9E5P/43Iiud3ybHLFU3AuSTEkFyoQkwYK
         5FGA==
X-Forwarded-Encrypted: i=1; AJvYcCXmbog7+HBI2EMdh7YoQQglclYvcT9RK/O6xkf4TQE6uFERERsT1z5It+pcTNFHsAS0A3OLy36tZASLC40DkeuOZ+LYfZk+nm3MRRddUMPP
X-Gm-Message-State: AOJu0YyZn8L76ra7/UKrICDFvejaUxa7L6Bk2liFsOvMHgoDqhpOCyNm
	glTFr9vyKTk9w87cw3oQ0hnD92jj3XLCwjKUMBc5rpZ5BZBeWWG9Z0qWzle9
X-Google-Smtp-Source: AGHT+IFvY7wqvsJ/4n9al8DqWBF6uK7wwLrllp9V0/muawX0kRzi14WlMK3v7ybYcLbPGQfdWnUumQ==
X-Received: by 2002:a05:600c:4749:b0:412:6de9:ebad with SMTP id w9-20020a05600c474900b004126de9ebadmr3921518wmo.8.1708532495149;
        Wed, 21 Feb 2024 08:21:35 -0800 (PST)
Received: from localhost (p200300e41f2d4600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f2d:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id t4-20020a05600c450400b004127057d6b9sm3059371wmo.35.2024.02.21.08.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 08:21:34 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: linux-tegra@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	cocci@inria.fr
Subject: Re: [PATCH] firmware: tegra: bpmp: Return directly after a failed kzalloc() in get_filename()
Date: Wed, 21 Feb 2024 17:21:27 +0100
Message-ID: <170853189530.559171.12608569719019318541.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <07ca2474-560f-4cbb-9740-db987227416a@web.de>
References: <07ca2474-560f-4cbb-9740-db987227416a@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>


On Mon, 25 Dec 2023 20:18:44 +0100, Markus Elfring wrote:
> The kfree() function was called in one case by
> the get_filename() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.
> 
> Thus return directly after a call of the function “kzalloc” failed
> at the beginning.
> 
> [...]

Applied, thanks!

[1/1] firmware: tegra: bpmp: Return directly after a failed kzalloc() in get_filename()
      commit: 1315848f1f8a0100cb6f8a7187bc320c5d98947f

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

