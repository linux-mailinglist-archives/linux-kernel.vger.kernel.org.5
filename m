Return-Path: <linux-kernel+bounces-41266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D4D83EE37
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC462841F2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7252C191;
	Sat, 27 Jan 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUpjuXyY"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE525764;
	Sat, 27 Jan 2024 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706371586; cv=none; b=C5wZioUn2McsQuct9TzyLigrAui2iHN4PUcqJLi86Il7OMtvF8E0SrzFpTAnTOKIEsWOEcgItS+KundiRfWZ23OWxKOtRVuONsgpqaQuuG8jnjcjkCPOBYLc2Hf7I5kNgSA+bZNrJ811yzURYRA52SfSvJPKRRt+Y0WIW7nmkp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706371586; c=relaxed/simple;
	bh=0b+Fc0OLP1xwiUwEjb+UIjcwfA3RtHX+defXLD+CgN0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZxWs++s8ypC7ckOPuNk3nLWLLTpuie5C7A4c0D/Bu5coTCfG3diviTcRqwtESsi8ynUKsol1SULzL5z/Dq2tkifp59iIePAWXZiCbjFxV0WI7XVuG4v8LY7nE/TUgbBEJvUvmFTf+AFcs/3wz92NJdjsA9M+wyiSQAKLv6OyWuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUpjuXyY; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a8af3c10cso6491121cf.0;
        Sat, 27 Jan 2024 08:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706371584; x=1706976384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=790nGr4fxuNI+xFbDQMERosAfDIXV6m5tYkf7fACxZw=;
        b=NUpjuXyYSp0+aGjoHwtYAszHL1NpfVIcn3iBRJEc5wgQJPusY3ps/giDY/GsucDNpB
         8Y211LQNJHWJIs3AY4U2gUYHs0FL4gemX7NvYAs+AyMiSnVMgUQJqyss4EF+VS7oWujR
         aBmN2skhzcbeM+fQMNCALKB0FGcf1ZIowXnzIPAtr3UBojLysRxVixRw0zY5KG8hqj66
         bklyMo9qIHqBMFgEGh00HctHiJiCw2l3e8XsMu0Xidh2pHcmDX9+OYcW6p3fz/Jn2BFV
         pWrGhRe3uQgYhrkuqzwjFH5T6MzG+9bZHBLZn493qfweGEhAd2cZgFgmISzikw2XseIo
         09nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706371584; x=1706976384;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=790nGr4fxuNI+xFbDQMERosAfDIXV6m5tYkf7fACxZw=;
        b=VO1CYhyMQ7J4IeUgqPzoJUdcqhg8Nb+wlPUDdCrYPb7EWiRlc74iGeGHhDaJL/jF3j
         LU/fxoN6qPi0fAWdLOS6Qasm7ypXuJpMMjfWE1SivAQKpTRqeSzwDBNGMVCa3oVBQkkV
         PITfOLEpB4B2DwZ4yfvR+u2hl/MdyPAJQYCQI0m3vzdoyjqcUOgjwjWBszdTlV0tMVEd
         GK1F+CjPcIln7dWJ7PztRqLOg11lDUdJL/xxmXgLywkkRl2NZz3hN3ZVcucsc8eOZQir
         YNKMpV+Efob9x9UqtEM9+zsEW6zFDHy9uohxY0PT9lV+SvL09IkGN/b4mNCFMtDu7++Y
         w/5w==
X-Gm-Message-State: AOJu0YwnzJjdapKxm8+voqbM+pzcK7xw13XeHf8rRdbL7gDcAzNaultI
	uMBRFufGzcPDpKoPDypFA/4NDKP+DLx97FrrZWDSvufb3ca2RZu+
X-Google-Smtp-Source: AGHT+IG0+AooEdjbaiRETSdlbpv3v7HbGI1Ln+Yg6nAdJy9JxDZouPHu3lqF7ipIO61LQTEUrccCkg==
X-Received: by 2002:a05:622a:a14:b0:42a:1609:eb18 with SMTP id bv20-20020a05622a0a1400b0042a1609eb18mr3302103qtb.137.1706371583752;
        Sat, 27 Jan 2024 08:06:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVEBxehnMrRblNcAuiLMMuHsvcuOHhNlyAwKue0whF98IUpc+Dfo4VsiCySh6iRJU6Hf4lnwwU4b3X+CvN5+8WKQN5/LB4gyuDbPy/FlvNPa1jlQ3NpLNcSlJrHwxW+axJH6//q0hF4ZoFoQ//tNafu1LKteFjFCp3cUu+ZjHwOdXs44r3DsiS9Jkv/p6HHIt3m3mCbKV89uhPjoJF0t4/W0X/0cOkZXRUKIw4FvfoWs2l8qEzwkHxsIBaCb66LmMUErMopXUfv/RtAA91fFaVSOSUszXjl6aiuzIbmBZkULtZuxNdVXvAs
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id s40-20020a05622a1aa800b004281ce041f6sm1633997qtc.21.2024.01.27.08.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:06:23 -0800 (PST)
Date: Sat, 27 Jan 2024 11:06:22 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>, 
 netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org (open list)
Message-ID: <65b529fee37d5_3a9e0b294d9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240126002550.169608-1-stephen@networkplumber.org>
References: <20240126002550.169608-1-stephen@networkplumber.org>
Subject: Re: [PATCH] net/tun: use reciprocal_scale
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stephen Hemminger wrote:
> Use the inline function reciprocal_scale rather than open coding
> the scale optimization.  Also, remove unnecessary initializations.
> Resulting compiled code is unchanged (according to godbolt).
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Targeting net-next

Reviewed-by: Willem de Bruijn <willemb@google.com>

