Return-Path: <linux-kernel+bounces-31310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BBE832C41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E927287D44
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8018954BEF;
	Fri, 19 Jan 2024 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPjR3rN3"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E554BE2;
	Fri, 19 Jan 2024 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677826; cv=none; b=BLelx6gRvGG0ni7eSgY5kDPQUzXRwKVPZCREnE3R9ihx+EtAT6wQDD9B/hVpMfhN6mLXViS1IXtfxO0mKe9msn44JYLyyu2y0dJfzuAcjJanM5r3WyU1HZtZX7aHRZ9HR6gkeOnlrXKdC7teqXP1KZybcXPWcRJJ7jXrGDPHS80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677826; c=relaxed/simple;
	bh=cye6k0zRxl2RG68HRw4F2PS2E0vrkf+73ScpXzuyo8w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=s0o3jkwYTuuR3oPWFfx47oyDr151DJoKHJZRigUBmNClXR2xVhJAxKHSbFDmBfPSLodf2g6CdEhnLlieF5u7A2lz6eQilQt8mGxBFYShsKL1JBFGHauNISiS/GXivE0+XfL6u4peF63/bIQAFgbp6MaIJF6fLp348iYK/noo8/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPjR3rN3; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bd9ff7c2faso636405b6e.0;
        Fri, 19 Jan 2024 07:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705677824; x=1706282624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3ulTy/374JVx5skyyfqoWLrrpxUwjpXxi0yPq7nkqc=;
        b=PPjR3rN33wR6JDU2Gxn9c6IuTLlQ38VqHaFrqZ35n0CNpd19hAP4AzzMWBv1/hcUke
         UgYAldwH3xT8WbuZc/+mGKAAQxDXN4/4kDLTQlWE8vA6GRDisH4VZVteEMK9bGfK25/C
         N1aaYEZQVxMKsCmSxZm9FZ+PrRJpiiPsnTWHzkIQtUuoY7ySU8ylev2ShjhvseGCwip2
         WTyoqU6kRAlDGzfmn8HgrcRV40w4U+OpuBdykl+wMkAztkbbgoOYXh7g8nKWDMGITQHO
         guLjWaVdTfLP7OhpEWmuzbSphD2cXc1JJxdAmJSBlREP6m4L/lJAoDmVRyduNrsFcvUE
         qmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705677824; x=1706282624;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e3ulTy/374JVx5skyyfqoWLrrpxUwjpXxi0yPq7nkqc=;
        b=WSfvpQ2v7TweXVR4EguyzldE/txLflWYdEGu7Ru0hu2mjUJFDEn+5oYG5KFMyPiNIm
         Shk7w7G7qO1wmac8AmPHkewLAt9x9zAld/k8JNluFL+8/9FjO3KjVOa+3GMFWtvKGgdG
         IV5xZSuArr757TOFe9OoreeoptKmwMqe29f2qyHyhELECQqNHwh0dFPAtJfoDURhTRSo
         T6BDRTXBnXpeZlY+ucCq08Q4sVqf2XUkWTfgFBX0qhL1fGGxUnFTPOeeZWUVlSEDqaSj
         uqMUqOtkZHoXgeGc/tnXfhu/nv+PuJRO3fhbim+PtrMzbp1cE66s1fdeSwKYNMD/T/1v
         dH7g==
X-Gm-Message-State: AOJu0YzdHhjZWNnqvXwZJQe0HS7LWeKGlsiBTDFIRxyujcWuJDCAfTgh
	5fKdGryYcVITttTC/wxfXlmymJksY2NSFwLkX1P6734G7bS645/L
X-Google-Smtp-Source: AGHT+IFnFA6sm0uOXbC7bM6lDNoqHR79nIW9PZFkSWhQ8QDnZyX9IKetMoWKRcEqlDxQ4bIcoyg3IA==
X-Received: by 2002:aca:1016:0:b0:3bd:944e:f3c9 with SMTP id 22-20020aca1016000000b003bd944ef3c9mr2526240oiq.98.1705677824388;
        Fri, 19 Jan 2024 07:23:44 -0800 (PST)
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id ow24-20020a05620a821800b007831a0f6e75sm6099131qkn.96.2024.01.19.07.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 07:23:44 -0800 (PST)
Date: Fri, 19 Jan 2024 10:23:43 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yunjian Wang <wangyunjian@huawei.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 kuba@kernel.org, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 xudingke@huawei.com, 
 Yunjian Wang <wangyunjian@huawei.com>
Message-ID: <65aa93ffe0f7b_29ebd4294f0@willemb.c.googlers.com.notmuch>
In-Reply-To: <1705659776-21108-1-git-send-email-wangyunjian@huawei.com>
References: <1705659776-21108-1-git-send-email-wangyunjian@huawei.com>
Subject: Re: [PATCH net 2/2] tun: add missing rx stats accounting in
 tun_xdp_act
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yunjian Wang wrote:
> The TUN can be used as vhost-net backend, and it is necessary to
> count the packets transmitted from TUN to vhost-net/virtio-net.
> However, there are some places in the receive path that were not
> taken into account when using XDP. It would be beneficial to also
> include new accounting for successfully received bytes using
> dev_sw_netstats_rx_add.
> 
> Fixes: 761876c857cb ("tap: XDP support")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

