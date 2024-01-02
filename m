Return-Path: <linux-kernel+bounces-14651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E3782204E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5EDB1F20B63
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12988154AE;
	Tue,  2 Jan 2024 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N1oS3OB2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0451D1549A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso102954a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 09:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704215874; x=1704820674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgtWc4bjvDKktlLz4D30hy1CsKyGq7mUpxpjxQf3kwk=;
        b=N1oS3OB2zJT2WzfIWhxW6toOJHs/6S9T4ujZtAAbQQisEGWdGhYA0jf/4X6zvFsWf3
         0JmqssxOCZ/ZZq8FL4a7LoSZQRPBAz+8I+Gs8QCPZBV9qewqrK7+AzH3XWiJr9o5AF8K
         dnIqNHY07E23EAMw5sOG5WyjRWemDyJJ+gcBnmy5YxGUTC7nYFuHz9xvMvED+WirM/4J
         5d09gKVyHZAnJWJZwYNxKfKw9P3xIpxA4bnWUO34nO/XjooI5Nzm83hkbf4BgR2EW8Ty
         TVWv1smzk8sJhAmSH7eqpVr+K1zSBH1Buf6JSV1672KN33iC+L7OHkV2YEuGPPzVfI4z
         tAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704215874; x=1704820674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgtWc4bjvDKktlLz4D30hy1CsKyGq7mUpxpjxQf3kwk=;
        b=gPhzK9Pe7jJA6O2NvoWGAiHfZ6TGllMwnhPhxbeV+3x0lQ9YL6dvaYAqIpC2LJHOyp
         +e5Qiq02gSFvDnmWld8YWMEyXj8uCznD0/QSccKQgFWs6hkoVF3nByKVqQ3T7Qp6RJlj
         tCukEm7A8RAMUyMuPQZ8FnJzCFK9dsC7jyZyXJmdPAOMB+HYp8LJaRnBxckdRZlO5GKx
         13MZjbq9mE7PZtecRfSjhTaAVjciPerdy1OXf4uVCcOBO+sbAp5+DW4LmgbBkZ/PQQNw
         20gFjtpC91LEKBvAuFwIDWay1/Uifk7iZOOVD6k4CkOwo4leY8uXEof3Q6KSfMWQxdfj
         HPkg==
X-Gm-Message-State: AOJu0YxGinK7K2tB9MkVBTT1xG3qCbSliUfzUIViuyTN4YV+K1b26Gtf
	Sz3UJIxXIBf/CmAviq+ybMFbWL134TPJblWpo13G1qPgkUPm
X-Google-Smtp-Source: AGHT+IFSQFJ6y37Me8JP7cpY4ttMgqnrVMI3iBeMC4VfQ7jrTarAphtUeYinjK8DA/bPta+atVQa3JVJ64wjvRhTgKc=
X-Received: by 2002:a05:6402:5249:b0:554:98aa:f75c with SMTP id
 t9-20020a056402524900b0055498aaf75cmr827598edd.5.1704215874148; Tue, 02 Jan
 2024 09:17:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <127b8199-1cd4-42d7-9b2b-875abaad93fe@gmail.com> <27d4cc21-1ce5-4417-bd0c-6dd43a92e4aa@gmail.com>
In-Reply-To: <27d4cc21-1ce5-4417-bd0c-6dd43a92e4aa@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jan 2024 18:17:40 +0100
Message-ID: <CANn89iL9Q16gKhupno-7GVC3D=-A4L8eWXhwkNsGrB8GsoFzAg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] net: gso: add HBH extension header
 offload support
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 2:21=E2=80=AFPM Richard Gobert <richardbgobert@gmail=
.com> wrote:
>
> This commit adds net_offload to IPv6 Hop-by-Hop extension headers (as it
> is done for routing and dstopts) since it is supported in GSO and GRO.
> This allows to remove specific HBH conditionals in GSO and GRO when
> pulling and parsing an incoming packet.
>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

