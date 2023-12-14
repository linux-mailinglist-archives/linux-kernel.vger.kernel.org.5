Return-Path: <linux-kernel+bounces-261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75358813E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3107B283651
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0242DB6C;
	Thu, 14 Dec 2023 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EUOiamSg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA526C6FE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so34540a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 15:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702597996; x=1703202796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2vr8wpG8JZogZBD1SoHqQxA1hO0CmvmdHIdK9DqzWc=;
        b=EUOiamSgIdBaO7Re8e4NBX5yYd1QWJc6Yg86PlUiDdw0OfZst3nLhxgLaUtSdvL6J6
         C+7I2TUz0aWSatbAhOVJeVAGc2XuWGGj+vHm7lMPjPA1wlBXDCD23cSxLRjUgRvGQkVw
         TZYapr2nZz5TDeASPPXAmbFpee8eSH1+arftG5LG5z8hnOypo7uNNRdSyhpkO5+SJDmu
         3aR0D2jC1eGWmOldoIMYd7fUgRPuLLTPBODRpRPJW8bwAuQa/y7n3Lbg3HlqtbZuEFFh
         9PI+pdiyzjaTDJTKKnPkYUrrWWHVnhtZoWbUplF44sGsuFfzbOwFi5vlclDZRwY9fAKy
         MeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702597996; x=1703202796;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2vr8wpG8JZogZBD1SoHqQxA1hO0CmvmdHIdK9DqzWc=;
        b=YxKlkn7eB9+8mir/30YeO3XG0ofvmSmuRL5BZH2qWMUqucFktcU4i3QFyICtsfA2iv
         /VGbcPjYeri+gfr8wv6ZmVo8qTNj6+cbzJKG4x1r8OER68gkjC2KSnhxaFnMAwZWsAOi
         5VFhZsdkdplPFRkst7amIM7+lZxcirbmH3HkSCDmoWLCxdHUhFCsYEOIsFbrzj3oDPCv
         cy4Nld+5wsRkiSQO2BDfe/OJcE92kJw1sA4GzC1tzzUQv+9ln0MQF7jdROv9EVVJ+XOb
         Q1ygp6wU7BkqNq3s9wifXCSgK8WnR4tdhUC3FCJUEHSv10uXtZ3WWs43yqS4p+OxD6DF
         Th2w==
X-Gm-Message-State: AOJu0YzSWpj4qnH/dQ1EVj3AaFGJ+KjfpWWSeI5+8n2gzBV2jtVpmG+v
	byhgyQJSlQQaiYP7OEJZDJ/zvALjkd+51aDoqnTVMA==
X-Google-Smtp-Source: AGHT+IEeexnTETX2c1nFwQZXovhV6Sios0dAmzf8StZwyBO/mpo9MTUtUq1Pmt6IFP3/mNPEccJ5QQ==
X-Received: by 2002:a05:6a00:2401:b0:6ce:4f4c:d475 with SMTP id z1-20020a056a00240100b006ce4f4cd475mr23105297pfh.3.1702597996082;
        Thu, 14 Dec 2023 15:53:16 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z19-20020aa78893000000b006cb884c0362sm12178060pfe.87.2023.12.14.15.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 15:53:15 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>, 
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
In-Reply-To: <20231214213408.GT1674809@ZenIV>
References: <20231214213408.GT1674809@ZenIV>
Subject: Re: [PATCH] fix breakage in SOCKET_URING_OP_SIOC* implementation
Message-Id: <170259799501.410702.15075202098496334749.b4-ty@kernel.dk>
Date: Thu, 14 Dec 2023 16:53:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Thu, 14 Dec 2023 21:34:08 +0000, Al Viro wrote:
> 	In 8e9fad0e70b7 "io_uring: Add io_uring command support for sockets"
> you've got an include of asm-generic/ioctls.h done in io_uring/uring_cmd.c.
> That had been done for the sake of this chunk -
> +               ret = prot->ioctl(sk, SIOCINQ, &arg);
> +               if (ret)
> +                       return ret;
> +               return arg;
> +       case SOCKET_URING_OP_SIOCOUTQ:
> +               ret = prot->ioctl(sk, SIOCOUTQ, &arg);
> 
> [...]

Applied, thanks!

[1/1] fix breakage in SOCKET_URING_OP_SIOC* implementation
      commit: 1ba0e9d69b2000e95267c888cbfa91d823388d47

Best regards,
-- 
Jens Axboe




