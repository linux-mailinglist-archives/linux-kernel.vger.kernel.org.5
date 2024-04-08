Return-Path: <linux-kernel+bounces-135345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C4C89BF47
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5031F21284
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554F96F061;
	Mon,  8 Apr 2024 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="foj/BEl8"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4556A348
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580186; cv=none; b=GoUy+D/SoYFkkgBQfcGRr440fSEQ9qtXxQA5/Qjp8KmxF2lU+w76w3x4OfUqY6JiUCyzabe/VGxuVYdxSvyOkEJriYE9tk1A9g9W5tQJmZCir5xB4daRh24KUnRdioU44hPNcc3erWCA3YlhmK9IV+m5dxkYr9PLzzD8meZHfAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580186; c=relaxed/simple;
	bh=bj+zCFiaSngsf1RnmUNrOHE0R/4I7AH4K4X2+QbvPnA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=llK+rWznzHQ+t6wGafj4l/QnQvHKnklbzzekJ5hJbLBfCBySz2opj3gD4nn9yLLvqLvygBxj/fhKHnjoOQlC6PmOobowpmjhjE20/5M+XPxEXFLXoNnVgvqEEvKDCJWCYJcOzLU6K6H/U/ooOMCBLqWDDt2zfvEKMxLH5MNnP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=foj/BEl8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51d05c50b2so149481866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 05:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712580183; x=1713184983; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bj+zCFiaSngsf1RnmUNrOHE0R/4I7AH4K4X2+QbvPnA=;
        b=foj/BEl8mHLsFcxY/4hSaHE9Z0jZARB2tEr+pyWbtIJzZll6jgyar4fp/dtIubnUFl
         pZsfy/2FTWZ2hXEWkUsRazxX5YgjS9ejzO3ggVcjbu3WpQJI9jG6gGJUkyp+NcVSl7gI
         wIVEukPyCjfU0pGJ5IvrAAnIlzsfhDw4xjF+ceEIaDqh0m3PQbyOBLrjFERf8K8JndMe
         wmTm8Kiw1tPTC0gRyfD5CgIcb4Ppn2/Y8eUdv6iP/+eYwdIGujph6YSxeSLTPGX7K/LF
         BSlgXDlk8Z8qsqCvIb02JXBvlo3CqAiK1CD+dzpbyrjNrlReVp29DgvaNzo37zUaaxos
         Rk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712580183; x=1713184983;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bj+zCFiaSngsf1RnmUNrOHE0R/4I7AH4K4X2+QbvPnA=;
        b=vmxtfjgC2rsr5g+GJUTnmt9pSouC1YkDwefByASrdcaKIIhGoF8cEXlXP3g8vSJJ/R
         ygVputy86WPC9Y+4+cEzTuWci8+OB/YBHjp68aRiLTaLbG4PEQxiaW80GDdkB9SL844n
         6nsimGSg2DclbIbKAukU/yOPMPrd7KXsg0i6MmyccrQXOxX2cIlwZpScI8GNFfkoyIpm
         ZZ1QbslFg9Z92wg7dMxxicrkPU+hjecfrqhNpAa6zlA06WhEV9WARpAIpTMU+ZH6fTzF
         kcMlgwrZNhEctGM8TVXtqKbl6NYV/LUUT1mx8rctgEZUgsWJXl41XzDa1HZEqgs7nK/h
         4PJw==
X-Forwarded-Encrypted: i=1; AJvYcCVMnQbsJnHZ9M0IJwVj1FkvjnQk030JWhGttPqg5B7USjCReT4Sbbur+qBIqM6rc0dtKRqxrWhw02yrI8FvslAGcxYQMB0xF1IEFuId
X-Gm-Message-State: AOJu0Yy660kq9maNdB23Ovz+mppnleTCkkQEo7kEnEyz76bdWcdxxLFS
	tjqu/Uawd8hTgOeipCDK5u9h/2yCH3ygyRnF/EsisjhyZYTohk9a/PVRWr1zI3M=
X-Google-Smtp-Source: AGHT+IGDD2DAXc57z2cnZ7DXnGu+eOjPdA/p1faP571apS05EgwVdkCDrTge5mJIsjcO3AGCGFfWPw==
X-Received: by 2002:a17:907:9496:b0:a51:bc68:fa94 with SMTP id dm22-20020a170907949600b00a51bc68fa94mr5218668ejc.21.1712580183218;
        Mon, 08 Apr 2024 05:43:03 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10c6:ce01:bd98:da4e:9b4c:75b3])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906c21500b00a4e28cacbddsm4384024ejz.57.2024.04.08.05.43.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2024 05:43:02 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] s390/tools: Use ARRAY_SIZE() to fix Coccinelle warnings
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240408115104.9447-C-hca@linux.ibm.com>
Date: Mon, 8 Apr 2024 14:42:51 +0200
Cc: Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7934000F-958F-4B64-BCC1-2686DCAF87B5@toblux.com>
References: <20240408105515.2328-3-thorsten.blum@toblux.com>
 <20240408115104.9447-C-hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 8. Apr 2024, at 13:51, Heiko Carstens <hca@linux.ibm.com> wrote:
>=20
> Let's wait until a compile bot reports compile error. It would be
> helpful to at least compile patches, before sending them.

Sorry about that. I usually compile the patch before submitting it, but =
missed
this one somehow.

Just including the missing header file also doesn't work.

Please ignore this patch for now.=

