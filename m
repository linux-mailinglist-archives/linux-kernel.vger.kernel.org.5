Return-Path: <linux-kernel+bounces-137066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF7389DBE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18622B25298
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ED912FF80;
	Tue,  9 Apr 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcmNOzfF"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420412FB14;
	Tue,  9 Apr 2024 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672002; cv=none; b=PiX5Bq7KrgfFfF4zBSIa4/VoxdHqGLWxrtXHu23niD4vK6rfRJoUIX9C1pDwIYrqG0hf0MHclCICGFQ7aX86BFU0saMF0oQBh6JsUFzL8tFIi87qaQVvzhYGDnotNANpUOeL3CNNtO67qiB2wOln3lyZGePf8aHRzNYLnjp/sOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672002; c=relaxed/simple;
	bh=uVFj3eEWGusMGg0TJT4HW5K8dPUQ3fTRX3RDNimTIeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzSAmJjy6kfnBwMSzevd4O8Lu67h9zqZBdGpOmuDqfaCb4m2HpDYGvpqF8yA3aOYiM1qk7aaqFDAT96DXUbh9koqCG4ZKm3pDu0wLvujXfTCvQIEFVqAjgxo5LuSJJoChJdacvUOQMg4UVPl7KJ9wQ+kaomMsLJORIHwxKpkmpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcmNOzfF; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d87660d5c9so33385281fa.2;
        Tue, 09 Apr 2024 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712671999; x=1713276799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhUjQDS0NzeGHvz85xqgzQ8HO2kzFaCylmDchNxvoNg=;
        b=bcmNOzfFO1LeRZQXXjDadQPgm2Zpg95Km0IpYiTDDOybgsBlsOYCjmrKykRAmOybx1
         c+sLVHi5BPcacDzf8TSJbOnLRc6LG3c7NLv9q6mU0qzuI0palQai7Izh4PCR37PI6XCT
         ZKQZzJMXnyIU8vKWHShBjdiHktYPxNpajUSd/bh/YqCSKmAk42O6BzK8SzMdealvzloc
         azDV1Om7RfhxY9tmeZs4wtOulBi4imCP5mjcSppq03kYKf08Z+Uzo9xXsHBMGdXNxn7l
         +3L9qu7BmFgFKgLcACgXwLQI/LT6ycle3QNjqMTdwqOQ8BOgf1a1ppVX/03J6tosBybf
         eGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712671999; x=1713276799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhUjQDS0NzeGHvz85xqgzQ8HO2kzFaCylmDchNxvoNg=;
        b=Lch1EQyW8UZBSEozuGpBve6wRn/r5+1wjRAjjUpzPK2ra0hAGVvq/WoCqC9AP5mGhE
         Y8XpDZLdLWFRVUGy8tCtVXQcNVMmqAFApFgKRBOMn9IEue9F+o8TpUa21heXMwiTt9wt
         sikb9OZVOEeUeRp70zf7pKV1wUMBdwuujen64FrZKY9kJBHhWh8ALzYzNVtTFFzMoGyc
         nzrSifno2M8KFHAjVhkyGV9sbsJ+ygkoo36ydmZ6zoZPjBII4G5ZkR1L0S7PLPF2qyXj
         4qOU7GR2K74YgZAxGmroeNnfbVIBRruro62VlMb4bLvOT5bBdB51QWvZJRPsCBxX755y
         wgOw==
X-Forwarded-Encrypted: i=1; AJvYcCWOqYtIPar+jvu5/mQGBqozuM6jlTqGbRPMtrhgbeKlaTlkAoL3UT9UmOd/vZYs00ys4N3FqVEwOVPmlaVAyYFUu8mK7fV1XWTclrOmpfYpKEkH4gn/Ek397B0qwwOd1DDub1rPoomu5oIZ/7dOnQLgS4kwL4TVMTJgIiLQ8F7jFalBs7ij
X-Gm-Message-State: AOJu0YzcsaUXYcG6u4DPrLLDTmeWVHLJy11gDeD0yU8AkNvU9eWOjOga
	Ox4wZ8Dgyv9SSfDmFP67jk5MRRDZaLbT2tfAcAr/6WztoHlEqqWENvdBtp2MYPkPC/ISwqLFJLB
	eMJvTNfX/sklzWDu803/fTFS9ARM=
X-Google-Smtp-Source: AGHT+IEczva+4SCPbTs7vBV2lQA0NUDuhzBicKjkrY6Jll2b3zgVf7tYe2m56GMlccMbhYvj7MTDd/efmZAUt6DtVWA=
X-Received: by 2002:a05:651c:220a:b0:2d8:3d0d:aa03 with SMTP id
 y10-20020a05651c220a00b002d83d0daa03mr10666462ljq.29.1712671998459; Tue, 09
 Apr 2024 07:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000007558ae061553f41b@google.com> <tencent_EDCC88A7DB46D3D2F7C64449976EC56EE006@qq.com>
In-Reply-To: <tencent_EDCC88A7DB46D3D2F7C64449976EC56EE006@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 9 Apr 2024 10:13:06 -0400
Message-ID: <CABBYNZLA_AjSXTooBTqLccJschR4gUJ717hM_m1rcKv3fhye8w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix oob in hci_sock_setsockopt
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+837ba09d9db969068367@syzkaller.appspotmail.com, 
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Edward,

On Tue, Apr 9, 2024 at 9:42=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> If len < sizeof(opt) it will trigger oob, so take the min of them.
>
> Reported-by: syzbot+837ba09d9db969068367@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/bluetooth/hci_sock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 4ee1b976678b..cee7ec1adbd2 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1946,7 +1946,7 @@ static int hci_sock_setsockopt_old(struct socket *s=
ock, int level, int optname,
>
>         switch (optname) {
>         case HCI_DATA_DIR:
> -               if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
> +               if (copy_from_sockptr(&opt, optval, min_t(int, sizeof(opt=
), len))) {
>                         err =3D -EFAULT;
>                         break;
>                 }
> --
> 2.43.0

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D35d2c39b23fffa3d5a216142cc51d86354024363


--=20
Luiz Augusto von Dentz

