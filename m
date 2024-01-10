Return-Path: <linux-kernel+bounces-21990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85889829793
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7DC1C20CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FC845BF4;
	Wed, 10 Jan 2024 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="0fGjliuc"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017393F8F1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e4afe9ea7so33085e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704882362; x=1705487162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2mX1mh3rNqNne9tNDzhN4xY1fsjnh+ojT0izFC+U7M=;
        b=0fGjliucmpnXI+Y91Hnbol0BCPcJ9+AEOm+7LhKwux+ux21l+yeGpLi2PO65Hn6iR3
         xN13dLD64weFzTJEgHzYvbtPfOp2DJ7vEyTPX5ZV5dlTDftStLOY8hQB+cpmd5IrVFe/
         pRrpGHEsKQ8QFcglWaonp72Tgsie41NeEPQRYXgjP67Bm828vTQ4lnJMI2VwbgIXOwyA
         N0iIl3tQ7pTNPbfrkJvofwRYjpHjSSVRsZMInH5Aw+2vfOEcX8JzVBNg0NX/AJOIaj+9
         zdIIjaRCowrfDM2ml9Lhaxuz9fCfg0HpDaFxkYHJn3OuUDSs4W8pMQYXZksgpyBnKgj5
         Uz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882362; x=1705487162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2mX1mh3rNqNne9tNDzhN4xY1fsjnh+ojT0izFC+U7M=;
        b=E+ZqHdAulZDhsBpWnQ1cS0G5MFhKOvmCxbtlR1Dxboedbe8TeJ2E1SHDGGIw2r+D9H
         SuIPdiD3+wBTYSdQNEPM4/Ro1Ff/DCrM7JvMIxKEBylOgarIFEvg6jX5m/A45oJNkyL5
         Ly2cK0AbT01NBeZMz6JZspkxg5cF88hRzq00XTuoO8cV6r3VZx58wiW1qSHD2wxAfAIt
         c6Jv9yfIqDyHbLsOxQ9GE304Lt1dmwUFYOT5Fq25SnrShqHwXXBYFMOKWOt+u7tUCDXy
         q0Th2UcprtveeZvRpJ5v29uxLiuWKH0V83cQkzrRp+8frI/NPqPSgIkLz8qhkw96CM9Y
         jgDw==
X-Gm-Message-State: AOJu0Ywj6TXPKvBIFSNd7mMTf4f/89cvJ070sz3hZCryHm1a2u5/kxjC
	WrSOAnE5SBUY/4C67Yi06qJaigON3VzmwcvNoqn+Bz6FqPDp
X-Google-Smtp-Source: AGHT+IErl8hJGq1W3zjVyvsN0hUhsZgbrKc0QOwyz56OnXnouGgTlK7BYf8TX26SkUkGu3Ly7bNVkmMo2vvJGHfLJ24=
X-Received: by 2002:a05:600c:4f93:b0:40e:490c:48a9 with SMTP id
 n19-20020a05600c4f9300b0040e490c48a9mr130976wmq.3.1704882362035; Wed, 10 Jan
 2024 02:26:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109031204.15552-1-menglong8.dong@gmail.com> <CADxym3azdds6dRDdvofHj1cxZ1QxcN1S8EkrLtYtKy4opoPrFw@mail.gmail.com>
In-Reply-To: <CADxym3azdds6dRDdvofHj1cxZ1QxcN1S8EkrLtYtKy4opoPrFw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jan 2024 11:25:50 +0100
Message-ID: <CANn89i+G-4=70KA4DBJqmFRXH9T3_eaOUmVVDBDH9NWY2PNzwQ@mail.gmail.com>
Subject: Re: [PATCH] net: tcp: accept old ack during closing
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:08=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
com> wrote:
>

>
> Oops, It should be "SKB_DR_SET(reason, NOT_SPECIFIED);" here.
> Sorry that I shouldn't be too confident to compile it.
>

net-next is closed, come back in ~two weeks, thanks.

