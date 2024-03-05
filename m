Return-Path: <linux-kernel+bounces-91991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED299871976
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92DA2826F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B658C524DC;
	Tue,  5 Mar 2024 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0G/oWfX"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05E5025C;
	Tue,  5 Mar 2024 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630473; cv=none; b=gYzYLlZzbz/KsI2UHRW/7jEUlToiXoCsruI0GSg1rImIwNE840mBPSdLWQFYNXKhnuBWxIBVFOf//ptf95s4OLbPA22F4QjceGKlA4IlJuvOUyG5eR5pGOb3HCIdcLWtJDBC/VkTgXVQYkxQ/IA3JgSyUZdKKjTGrzeUkE//v9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630473; c=relaxed/simple;
	bh=vakpoISFn9p2eRy7RGby03JyTimOX9GLREz0fTQD318=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GvZMOurE5dJN2A3ntngjflfVO95NzTStXZl9ClPHMC+H0hiBI3Qoy2d98EqgFwVmpEcfaIhnOp+AOkiR48ZPU8oVjGSXQGLxanfUDL4jftUQ2XkledHxmjKjNqi7GegnDlL0iIJnNj2T8w3xZ3fUacTMqrV6PFcPQzLefjB2jFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0G/oWfX; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7db26980225so1108355241.0;
        Tue, 05 Mar 2024 01:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709630470; x=1710235270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pbGkC04Cy/pZ1QahcplTQZ7GagiY8lcshK/ADkXRWs=;
        b=a0G/oWfXZ8fPNxKWOlU65i00LdAqoQz38FUQq/Bq0PJHGmy86dUAjr15CZMzX1FO7p
         doBIfBSjB0lCOC/ShpMyEfP4Inu02K2UcLWKAYp3kBF+/q5I2yMqpgua3FQrv6uKxsaO
         J3czoNeYgT5mvah9Mxo7xA0nZn1xgowdWI8sOV9IvJe6jiu8jE4lHBGnKUrAtr1DNj5I
         XuGq2rxn0E0sSwJOiForT0XwTRu0GYyiqmtmfY7j9ZnOXjIfwBVDrigHaI7SKewbMN70
         3VSLhUOjXYMH1kyFSudd043AWNJIdeJ2QNGW335JzOwmW3LRNsIs140sR/KQB49EzIzA
         xq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709630470; x=1710235270;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4pbGkC04Cy/pZ1QahcplTQZ7GagiY8lcshK/ADkXRWs=;
        b=F5zQ45POet6lVb0w9DeimDn/WnHtaq0s0k/Z2o+msVhsgwW0kLEGBMYAWgZf2/vsU3
         cEhP7avipXbkdf3V70yWGk/RgC+ymORnoDQUNX4IwtRj/rUj3k2+pqBaFw0qx3jhSjAS
         /2szOiQe95osiBrCkTVD/nm0WyoICLMySUI4i4QS6Y0MdG9xbmayCpSHAWOXI8qQLjdI
         hcMs4mJ5ipVCFyoNf2b1o+dLtfF94zfEXyQt5gZSnw01OiZ4AmNZ9uQmkv8stHg5v1rp
         g/6UKb+CuutdAM1m9YT4QmQc19vZeOUos6ncUH4veuYokN3ZxCp2y+5at2zBg2EwT9JP
         zUcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWedvbxZ46X5g64S6pSvOKmf/5xSOud1TydXad+Nu3V9uN0noF3sPkpV8LEOgCHAFsM579YamBtDTR5SyFVBQNbWXH6eJsH2JDDZX02
X-Gm-Message-State: AOJu0YwH0rnOOEeklgkPEYa6Gussn0g0du82z9eXcUc2rVRk5Xvz2bKS
	hgHQYlPt9qXCJMglYfpAnF34Lrw3sUBc0fVRb5TJ2tSXgzQcuV6Y
X-Google-Smtp-Source: AGHT+IH9OxmZNVPbKfUGigoEtvLgzzkoy5bP3D6pnCMZ/dND22qEx7jty7Xb5yzkeWwN4jpAwNNcwg==
X-Received: by 2002:a05:6102:510f:b0:472:7619:1a67 with SMTP id bm15-20020a056102510f00b0047276191a67mr1551988vsb.3.1709630470621;
        Tue, 05 Mar 2024 01:21:10 -0800 (PST)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id dn1-20020a05622a470100b0042e5c83cf22sm144043qtb.69.2024.03.05.01.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:21:10 -0800 (PST)
Date: Tue, 05 Mar 2024 04:21:10 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 kuba@kernel.org, 
 davem@davemloft.net, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 horms@kernel.org, 
 dsahern@kernel.org
Message-ID: <65e6e40618790_3cfad29492@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240304183810.1474883-2-leitao@debian.org>
References: <20240304183810.1474883-1-leitao@debian.org>
 <20240304183810.1474883-2-leitao@debian.org>
Subject: Re: [PATCH net-next 2/2] net: tap: Remove generic .ndo_get_stats64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
> configured") moved the callback to dev_get_tstats64() to net core, so,
> unless the driver is doing some custom stats collection, it does not
> need to set .ndo_get_stats64.
> 
> Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
> doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
> function pointer.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

