Return-Path: <linux-kernel+bounces-22003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5848297C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B53B1C21B85
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2A341228;
	Wed, 10 Jan 2024 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bsABLVz5"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6937D3FB36
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso7110a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704883287; x=1705488087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmzfzN0zzJnyx9WB1y8fn4jQVFu6Vh2c1qnlObNp4q0=;
        b=bsABLVz5ihEahS6N7sIobE6Kqigl4JFKoWapOfjWGLkw4OFo+ChMfE7CQmh2Jo/Tc9
         U3ziIqUoEbMkdDYw7vrlwhsPj5QVeBg8v9AUROYkBk3QMYrKiYZGkmUOJKLfrua80H/u
         uWP60eERtGrVHNMnDgQbJlqycsYozLAERj3jNwHhYBh3S27FWQJyKG5dx/jkfgNbdi8V
         6DsZO2ucyhCi7VqA4rF1QscAz46um5vqitIFn59N6kc0U7kMnUgCnCZs8JxYFLGpJfM8
         OB8x1rzP5KYacQ/Ri3vwK58Jq5GdEQrqkKquFQ40JqhwJ9Dw6UrqqehLd661T2yPWjbX
         z8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704883287; x=1705488087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmzfzN0zzJnyx9WB1y8fn4jQVFu6Vh2c1qnlObNp4q0=;
        b=UBLvEw9kRFBNUhVUWq0PJ1nepaZvrKf4xSyshWGYSMRREDJg6UH7XFISzh0sHg+eGM
         uu8EtKE83/fCp2geDa7PCCHHoFhOttI+amC0GrpjU3Z0OAxP96ltczDjFMSh6dowVLeJ
         TYRJRFdoTwTH7dAtNwHYVyqIe5WrO3OXXbIdLCq8lmiNiuhZQTgnkckddjzB/aHUYiF7
         TAkv/WURXfWZCInAMXDYAPnrRGHqFQsxXOy5OytaQqc+ed5kmXz29vRZA9zIbyBXLiKD
         zkx5dIKXn2jibMpfh8Kt6T2YRetuRGnCzUoa0RQ8hOZ2dBl2HnJ6AR5F+e5Pn7UANl6d
         g7JQ==
X-Gm-Message-State: AOJu0Yyuhj73+A4x3DXnPKqGxFEHctdJFY9TOwaisR1mUytqSsaNdDbE
	c9Mu4EQUTywo980tSbngGk+OGmk/S0BFvYVFJmJG1aPUVCvXCf1VvSE4YTkbvIJ6
X-Google-Smtp-Source: AGHT+IFIR8eam6MV5NA4qhZdxcgZvP0O579ROvq/Wp+r2y+trDB4Xh8CAip7+nefjj4l4P0g9imxaI7Le8LpzwRTtGU=
X-Received: by 2002:a50:d711:0:b0:555:6529:3bfe with SMTP id
 t17-20020a50d711000000b0055565293bfemr135444edi.1.1704883286597; Wed, 10 Jan
 2024 02:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109031204.15552-1-menglong8.dong@gmail.com>
 <CADxym3azdds6dRDdvofHj1cxZ1QxcN1S8EkrLtYtKy4opoPrFw@mail.gmail.com> <CANn89i+G-4=70KA4DBJqmFRXH9T3_eaOUmVVDBDH9NWY2PNzwQ@mail.gmail.com>
In-Reply-To: <CANn89i+G-4=70KA4DBJqmFRXH9T3_eaOUmVVDBDH9NWY2PNzwQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jan 2024 11:41:13 +0100
Message-ID: <CANn89iLe9q3EyouoiSfodGBuQd1bHo5BhQifk47L9gG7x29Gbg@mail.gmail.com>
Subject: Re: [PATCH] net: tcp: accept old ack during closing
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 11:25=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Jan 10, 2024 at 4:08=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
>
> >
> > Oops, It should be "SKB_DR_SET(reason, NOT_SPECIFIED);" here.
> > Sorry that I shouldn't be too confident to compile it.
> >
>
> net-next is closed, come back in ~two weeks, thanks.

Also look at commit d0e1a1b5a833b625c ("tcp: better validation of
received ack sequences"), for some context.

