Return-Path: <linux-kernel+bounces-13835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA7F82133B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 09:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2CA1C210FC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 08:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEFA8F56;
	Mon,  1 Jan 2024 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6pesT5u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE28BE0;
	Mon,  1 Jan 2024 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bbbc6e51d0so3521002b6e.3;
        Mon, 01 Jan 2024 00:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704096234; x=1704701034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9kdxVqD5VCjAB4SwhpnTXRY8LiR8uitsc2iJ8kVJiE=;
        b=I6pesT5uFOSqG8o+BUFHce4R36JZ5xUomYd9lyAsRzQX/AocpjcIne97H+NK3G/O/a
         Zc03u4AVKQ4H4IFFPvUmvT9Sd7eMw9yG6EIlsQ2/wzmC/+Cf53o5px1uak5aP8VVeInE
         EjIQHGq0y2gLnaPCoY/uapprLLRXGKHSh7yGfiVdiKTO1UeXXu2FVUZXmjqra7D7MNgq
         UGfLOkr1RIgLgYD7/J8vkUEzci5fV9FE8sB5aIusutIr7wGEQ6gdBfIZFcPm0wIBeTfx
         6MD1cr2+z1HNzoqJ0xqKRqHzKpDez3B0n8PQPf7DwJ65T6morklGV19h4XpE3v8nRZcA
         glaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704096234; x=1704701034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9kdxVqD5VCjAB4SwhpnTXRY8LiR8uitsc2iJ8kVJiE=;
        b=q8ky7JyfLrPhE9ErgFq8tZtTL1laHokib6C4opWrPP7PhA7BQ0XQa8flAyjFAGdpnC
         cXMSsaj7WH4JaaEgF9XB8chX0OPdsLKLna1QDXR690Xk/tyWi+UWyGcpRDM0k6CyA6Gv
         DtIJbqiVZiaxnrMhM1HLMDrygS+/ddYRVPRmI06sT1zLYAY1Z9RVEJB7iBgGoBOp6b2n
         l23qiGdGNYyHWyH1eK1XwB5Bg5dKwDDNUKeq/RlRvHm/UUsz+tF1mCpWxSXPGygKkdqA
         agMnuOA6gE7aigd2AwXLiGUMCmP3jym3V4jikGwADs9+QDloUl4YnCtvnZrpAxANh4/z
         ursA==
X-Gm-Message-State: AOJu0YwXlnC/kasswAxhMwIU4rzMHQ1h17m1TknX8WXPjqiQjTt/UqCr
	mW34JB67BayYmUyba6Gcybj3aWEfkrjQCQMo360=
X-Google-Smtp-Source: AGHT+IECEZcRRgCmn2z5h+dyqAA7jaVrlSAPXeM4x1GnBY3ninqD722b7aSDtNox3a8IDQWW91+ddkkqfMyxoqt+3hw=
X-Received: by 2002:a54:4190:0:b0:3bb:c649:9869 with SMTP id
 16-20020a544190000000b003bbc6499869mr6327541oiy.79.1704096233889; Mon, 01 Jan
 2024 00:03:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231050300.122806-1-sergeantsagara@protonmail.com> <20231231050300.122806-4-sergeantsagara@protonmail.com>
In-Reply-To: <20231231050300.122806-4-sergeantsagara@protonmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 1 Jan 2024 19:03:42 +1100
Message-ID: <CAGRGNgVGJLoksSbuT5cr37HYQ+ik7NP5StxevVLN=UFz+6D8xg@mail.gmail.com>
Subject: Re: [PATCH wireless v2 3/4] wifi: b43: Stop correct queue in DMA
 worker when QoS is disabled
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, Larry Finger <Larry.Finger@lwfinger.net>, 
	=?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>, linux-wireless@vger.kernel.org, 
	b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rahul,

On Sun, Dec 31, 2023 at 4:04=E2=80=AFPM Rahul Rameshbabu
<sergeantsagara@protonmail.com> wrote:
>
> When QoS is disabled, the queue priority value will not map to the correc=
t
> ieee80211 queue since there is only one queue. Stop queue 0 when QoS is
> disabled to prevent trying to stop a non-existent queue and failing to st=
op
> the actual queue instantiated.
>
> Fixes: bad691946966 ("b43: avoid packet losses in the dma worker code.")
> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>

LGTM

Reviewed-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

