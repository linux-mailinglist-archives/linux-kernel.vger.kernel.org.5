Return-Path: <linux-kernel+bounces-13936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370BB821512
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 19:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6776281C00
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 18:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263F5DDB7;
	Mon,  1 Jan 2024 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="JtyWj12N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84AEDDA7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bc1414b48eso230022b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 10:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704135059; x=1704739859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbYCUJFY53U9gRpJbfuC37YC1Mxo6+GgjWkmqV3oS5M=;
        b=JtyWj12N+0uOPsOTDncS3AsJcWw79Dk46Mc+oAlekj4VSlY94vkpE3A1nFt+pZt7lq
         89iFqLGJnjRB+zFiUZ3yw3Anwz6FqluE/NZRML7cHx8/xEsEYBwONot0qIcVzanE+uAV
         eV3g4FUvpvshgusUXuR7EL/PaFd/7vodLsLJA7G/Fq4sFaIT47CAbRkdfiUin+htPBOj
         ApD/jNdoRWaSLQbbHNDrHyZl7Z8nfEl0uFPP+favVx8VCG85q/TZupWTa3rqAb8aNKcW
         SwsUpf0YVQm5uWKZpitqUggoDskaGSKEeumFtSzNf/9cF5hdbGXojO3XjWh7zjUaAb3+
         wXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704135059; x=1704739859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbYCUJFY53U9gRpJbfuC37YC1Mxo6+GgjWkmqV3oS5M=;
        b=aFjMe0U4eei8imLPHnaww0xyaUpsrAJf7LN67Q+v671r3Kr8XZbrwEX29GT33sg7RI
         +UUsn4kIy3aeltha2/5M/Uv1oHld8rJn27qWDVfso5oVmX01XJUT7g2JYell15KgN+23
         sZbKrtLQoOapTtTLC1O2+dASqg5b0yjsE/MX43cc64NhY2WNXAruGPE+vXlOGODmyJaP
         jF37hIWBk0cy6UpfJUN8pWD2df+3WpmWgTOumqMWNettSrqu1T/AC1SfRYpNFgk5X4LS
         glaYhQBnr4fTScd5ag79t9BsHyh/E19aisuBsOrhmZyi39OepkF9wALy8t5MqdGw5mQD
         nQsw==
X-Gm-Message-State: AOJu0YyhKMkUQ0bJesn9JqH92Ioiu1OABYyHLoFV9OSTKyJK8P2Za3Vy
	HTpuNqk42kQpCown3zT5JQo8kjhO1g6tag==
X-Google-Smtp-Source: AGHT+IGDMm+FVjTXA72pnuAwLWup8Jaz/FJ4gAq6/Vwi5wJKsbICW/ENAk0MDLKGDqiUWKyDNw0CGQ==
X-Received: by 2002:a05:6808:3c4d:b0:3bb:cdd5:17c4 with SMTP id gl13-20020a0568083c4d00b003bbcdd517c4mr13254821oib.83.1704135059018;
        Mon, 01 Jan 2024 10:50:59 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id gu5-20020a056a004e4500b006d96662ef22sm14799175pfb.16.2024.01.01.10.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 10:50:58 -0800 (PST)
Date: Mon, 1 Jan 2024 10:18:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, Anjali Kulkarni
 <anjali.k.kulkarni@oracle.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] netlink: Move an assignment for the variable
 =?UTF-8?B?4oCcY2JfbXV0ZXjigJ0=?= in __netlink_kernel_create()
Message-ID: <20240101101851.10c640ef@hermes.local>
In-Reply-To: <d250255b-fd88-4ea9-aa08-bc8d911143af@web.de>
References: <90679f69-951c-47b3-b86f-75fd9fde3da3@web.de>
	<d250255b-fd88-4ea9-aa08-bc8d911143af@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 31 Dec 2023 18:48:11 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 31 Dec 2023 18:16:26 +0100
>=20
> Move one assignment for the variable =E2=80=9Ccb_mutex=E2=80=9D closer to=
 the place
> where this pointer is used.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

NAK
Useless code churn, no improvement in performance or readablilty.
Compiler optimizer will do this already if it wants.

