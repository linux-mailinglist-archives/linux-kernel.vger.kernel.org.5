Return-Path: <linux-kernel+bounces-142832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E4F8A309E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071221C2435F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A501327F3;
	Fri, 12 Apr 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="lfhlR26B"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C5212D1FC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931844; cv=none; b=ERlSQAujruba2No0af6hwKbGzKFpmhBABjpCQthwFGNlMfgfjOU36q2nAt3NKhoD3zrW26vVVf0BQytK/S3jyodsqi7/QJ7xeP02V7wI0+9QojCS2rtovdASolm6TNXMIoYgYNNhxx//JzmZnYv3ZFH4PiujxtprCazYLTHAi28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931844; c=relaxed/simple;
	bh=xPJfvrJkroHWen1V+x+kRG0Fv8xPw4I9S3y/eqOkAa0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=KI5ms/at72mXGiU9bsiSGFmibHABqLolsxyb2ZbUFdNpmIUf62IQQ0yqMy6qBy3PHHgPgEbGFoLsY3xXCjMiE40XT2yPkd9FBuRiKgVd39K4xn7nb6VL5bp+haTjEagqmfReCWADIzDiWjcw817kxpPNYmTMVkoUmbkLji3WtBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=lfhlR26B; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4715991c32so122715466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1712931841; x=1713536641; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGGpBuMkk3rcfY7clPvu4R5GEYInWk7ZpVaUvi+LAPw=;
        b=lfhlR26B1CJ7iMkal+tk28o3iwUeAhLMtmPTXj9rzkjBwh69ghHQzEZ7Eg607QRIfL
         FkWxkNvk4HO+TALIUDsynEUeJunJf/POFcSaVHdCJXkWGnJk5p1rK4uzUDFk2S0YBC5a
         Wv9GQVwrpPPPGxuSZ4/hH+qMo94eCVlDf+OZ223sa+Ed9wgleQSF/kHni83zSwAReP/v
         qRSpgfKh6l9lPw34ab34kqBYfPozrlXgquzrlxK0FHKCmVWpmQksxAGucDGyx2DpVIAj
         vsjYjb+v1txV7Tm79qkLeUepvq+0SbeAHPZfWs2JdEtbqlwtnEZAABvCKmnujP+nOCrC
         w+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712931841; x=1713536641;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kGGpBuMkk3rcfY7clPvu4R5GEYInWk7ZpVaUvi+LAPw=;
        b=cNFIjquFSzqQcfn/yzrBT8TxIDw3rzcZpKfrlcykAiTd4bwE6ZFWAW8ixOOsFC7vdN
         TP8M1z30xVMFZsnCo0LbsJOol/1Js9lr1Eq+3f1ECKXlxXXZKiS7bv9q60QCan7iq7oz
         ShRzcT/l8fs5uX7y8gm8cVK5xuzSY9KUPcO5QDZGQ/8ULBup/lY9V8vbHID8D9uDAxdL
         iIEA+qSGZOJhr7gPo1OocVd8xV0ZVVOXOXeK/sujY9B13fVequdzTTAmzap+pbgWX0o0
         Y9KYRQPlNIOGTFsjEAjN61BywCdGRD+gI5Y/tNFhM7dwJ90bFNO3ht9w9Q/VMAc4DLVD
         8cvA==
X-Forwarded-Encrypted: i=1; AJvYcCXxNrEcrzEIb6twI9raNhM2iViyU9b3bGFyNHrWtFdJHIDO0bAy0bEwgk2yEnO5DFqI+59naif7OdRZXqMAYeG52bWcaYSOdgnD95Ya
X-Gm-Message-State: AOJu0Yx0XvSCbsZspU6vPDvNBbnqgA22lAJ4Pch7+OO889qrxONxwKGO
	SYN7MnWHKbajp6wZ2Kj4Vgh4lDpLa40L59iBHNDyaireGtQzcdf8c6+5b2mOqYo=
X-Google-Smtp-Source: AGHT+IFRwnYmNxoacwMYfZHwJlXDTXp4RSdWCA1aODz1NYxwf5Bx9Aehjl/icfWlQ/9r67E/c8s6qw==
X-Received: by 2002:a17:907:25c1:b0:a51:d7c8:300c with SMTP id ae1-20020a17090725c100b00a51d7c8300cmr2369381ejc.17.1712931840880;
        Fri, 12 Apr 2024 07:24:00 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id hg20-20020a1709072cd400b00a5225c87f65sm1563965ejc.56.2024.04.12.07.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 07:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Apr 2024 16:23:59 +0200
Message-Id: <D0I7NRQQGOSJ.3JB82F1X4GIQM@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Marcel Holtmann"
 <marcel@holtmann.org>, "Johan Hedberg" <johan.hedberg@gmail.com>, "Luiz
 Augusto von Dentz" <luiz.dentz@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>,
 <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <phone-devel@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Add more Bluetooth version defines
X-Mailer: aerc 0.17.0
References: <20240216-bluetooth-defines-v1-1-6c39aacc66a8@fairphone.com>
In-Reply-To: <20240216-bluetooth-defines-v1-1-6c39aacc66a8@fairphone.com>

On Fri Feb 16, 2024 at 2:22 PM CET, Luca Weiss wrote:
> Add the various Bluetooth version identifiers found in the "Assigned
> Numbers" document[0] from the Bluetooth SIG.
>
> [0] https://www.bluetooth.com/specifications/assigned-numbers/

Hi all,

Is there any interest in this patch? Would be nice to get at least a
positive or negative reaction to it.

Regards
Luca

>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> To be clear, I don't have a use case for these extra defines myself but
> some time ago when working on Bluetooth I came across this and thought
> it would be interesting to have the list complete. No other motives.
> ---
>  include/net/bluetooth/bluetooth.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index 7ffa8c192c3f..818eb142eda3 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -39,11 +39,20 @@
>  #endif
> =20
>  /* Bluetooth versions */
> +#define BLUETOOTH_VER_1_0B	0
>  #define BLUETOOTH_VER_1_1	1
>  #define BLUETOOTH_VER_1_2	2
>  #define BLUETOOTH_VER_2_0	3
>  #define BLUETOOTH_VER_2_1	4
> +#define BLUETOOTH_VER_3_0	5
>  #define BLUETOOTH_VER_4_0	6
> +#define BLUETOOTH_VER_4_1	7
> +#define BLUETOOTH_VER_4_2	8
> +#define BLUETOOTH_VER_5_0	9
> +#define BLUETOOTH_VER_5_1	10
> +#define BLUETOOTH_VER_5_2	11
> +#define BLUETOOTH_VER_5_3	12
> +#define BLUETOOTH_VER_5_4	13
> =20
>  /* Reserv for core and drivers use */
>  #define BT_SKB_RESERVE	8
>
> ---
> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
> change-id: 20240216-bluetooth-defines-b810ce543191
>
> Best regards,


