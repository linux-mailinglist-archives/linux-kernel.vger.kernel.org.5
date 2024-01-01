Return-Path: <linux-kernel+bounces-13833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2271821336
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 09:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22442282952
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 08:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AAC1FA6;
	Mon,  1 Jan 2024 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4MCEs1H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399517C9;
	Mon,  1 Jan 2024 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7815ba075f9so343881485a.0;
        Mon, 01 Jan 2024 00:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704096082; x=1704700882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPooq24nmLWCaZX2jfGUOgIVUIvLHSvmfsyxrT2QUuU=;
        b=j4MCEs1H8+aIu0/OehoiA106gWpq/ubZrL57Jatq1rgo+cz//lafESA5L1FT/OSNtf
         jfonpdL6Md3joY4nB1BwUW4L5TOyXUtwZ0/x/2XZVdGT49JI3qzirRuWpePBx09uw0j8
         1G/DX8knVn1D+oZGej73fVP5Wb+5GdHIPJjG6NXfgjc9m4E4usH9EY4uPXteh89MD/TU
         unwElApxSUPUnYx8TsVetiJ6Vqr1zCwX7IhQuB6+UnkXH8oEeqGaF8LiX3EB6r+fsENm
         JNl0mLleYsu3jg4Sbxu7+zR7Fr4ra3gqxCfVh72U1+OF8WPGdW7Yyy5IHrg9c63ZVQzc
         P36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704096082; x=1704700882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPooq24nmLWCaZX2jfGUOgIVUIvLHSvmfsyxrT2QUuU=;
        b=coM1s620pgukGS+rUwOJbKfx2n098eR/YvfnEj9XneZz9BQk8GaApok1CN+7BzeBUA
         AR6xauypdCIkRxvj3moEtyEuqKfe6Mt/Ou6ZCcuYuHc+xCO6kuEgGzFKwlr4v0Fi58Nq
         gFTs5B/4mF+Xclb32QjYMTaqd1wXrWx/u7ls49mTheXES8JVOokiwhpB7M1wfsjsE1ib
         fjiswdjSZW2lg3rwoAnQR/gLqLAA2RUtzpvoTqHkgAK0xaSNgnJ9vqy+/WBVBaZyzd3U
         ssDOs+tTkPougkll0G6pvAlIvRNPyBQ2cQ2Kx+vQ457uk3nm7p+jvzh5aenNPZOTF9TD
         cBWQ==
X-Gm-Message-State: AOJu0YwMW3lbrE0OftB30i6GSnOb/xAGcWYkDOUlOnZ0sdxPCGqXdy61
	EhD8+DIMOs1hCe92UaN+pLGwvUsT0fB4eLlqcTs=
X-Google-Smtp-Source: AGHT+IGeruNLmF7WNsQyaGBwW/2vToMFFLLiFXkLYQ8tCnAdR0vCcgtHGFAEby2Juw9UGTCHVP92AtxC8ik1GAB3m80=
X-Received: by 2002:a05:620a:126d:b0:77d:863a:69d4 with SMTP id
 b13-20020a05620a126d00b0077d863a69d4mr17257169qkl.71.1704096082608; Mon, 01
 Jan 2024 00:01:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231050300.122806-1-sergeantsagara@protonmail.com> <20231231050300.122806-2-sergeantsagara@protonmail.com>
In-Reply-To: <20231231050300.122806-2-sergeantsagara@protonmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 1 Jan 2024 19:01:10 +1100
Message-ID: <CAGRGNgWjmae+OOp1YpejtKuPwvz0RKDKF+M+UAGx91OX+bJrcA@mail.gmail.com>
Subject: Re: [PATCH wireless v2 1/4] wifi: b43: Stop/wake correct queue in DMA
 Tx path when QoS is disabled
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, Larry Finger <Larry.Finger@lwfinger.net>, 
	=?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>, linux-wireless@vger.kernel.org, 
	b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rahul,

On Sun, Dec 31, 2023 at 4:03=E2=80=AFPM Rahul Rameshbabu
<sergeantsagara@protonmail.com> wrote:
>
> When QoS is disabled, the queue priority value will not map to the correc=
t
> ieee80211 queue since there is only one queue. Stop/wake queue 0 when QoS
> is disabled to prevent trying to stop/wake a non-existent queue and faili=
ng
> to stop/wake the actual queue instantiated.
>
> [snip]
>
> Fixes: e6f5b934fba8 ("b43: Add QOS support")
> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>

LGTM

Reviewed-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

