Return-Path: <linux-kernel+bounces-10480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB1B81D4DD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16041C21360
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AC4F9F7;
	Sat, 23 Dec 2023 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Euz9bDg4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7C9E56B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33687627ad0so2372146f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 07:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703345425; x=1703950225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRh4LSoHPvR5hdO5Fh4hn7/CMtmNDbR5Zs1aa9AeKus=;
        b=Euz9bDg4F9rYwIr9q/Ezbb7fGXO/rFAaa3rlHx6QCUdASv/iWQ9tpSAcQki2T2dHM5
         XhG4bqVNUJmamkkW3mD9yyY6f8B8bvIQSutEgyzVtWunXdZkET+t2SwSigHZlp/fcpky
         bnmpCBjDo0s5IBF9V3ZaDQCgQFzsuC4viO4KR38zQEy91Mqj8CZBC/4TWPy7zvEqDre0
         xddu6RW6grMjIoxb6fgluftcos5K5o5qqUlFAhhJr06738eQ472YserTJn2sRNa9ruHM
         tSTiw8qcX+WduGngi2cVsEd8ot/2dIYuAgmcFDJru+YJ06IDGadwBEfI2nrpe8NPq3+k
         yNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703345425; x=1703950225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRh4LSoHPvR5hdO5Fh4hn7/CMtmNDbR5Zs1aa9AeKus=;
        b=jJmolZPWgCRJnscg284W0H4HOIcL94w18uZiBBv8au5jdKZ88ncGohw4sWXaWvqRrH
         h0hUK6g48T/3TilQWcgbx7Qiom5OqUfl0tL6n6Gr2lzC3UqNif5gTUpqbLCyzB15tYBd
         w9VZNvk7y6rwJGGnNGAv4ElYQMaZwCJtPNUunS/VKz9x5CoRSE1P1NZWHIfQ3bHJskWw
         RYcDZDSadsCf24eYjmddrd1rDJYMD3wPPeOO9N3oSxAnm8WXc5JJkhLVwM23rl0vFBwk
         uASq1StmuA948He21NE7aDMdotY4BkkqYW8jcm52NZfuQM0WHJh7Vv96Dy5Ii+Lr5G5w
         DwCA==
X-Gm-Message-State: AOJu0YxFH9LXNvjks/Fg2DZ2aTGHiQmZ9M+xRguH8Ttpm/sOiHjBmaYO
	hDuA8vdSY2sp7ys0mv526uAzCL62nNxEwLjeVC4=
X-Google-Smtp-Source: AGHT+IEdfVGa/VwDeS9ks0Tsxsmh8hu0lbBLVkXTWtxNMMhXDGu1jTLRO9WwzGyAMnf101w7LiNfXUf6rf/woEX5aug=
X-Received: by 2002:adf:e790:0:b0:333:41a0:ef39 with SMTP id
 n16-20020adfe790000000b0033341a0ef39mr1807515wrm.105.1703345424949; Sat, 23
 Dec 2023 07:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221130930.32634-1-ruipengqi7@gmail.com> <e9aa311f-6f13-410e-bb35-20320275668c@linaro.org>
 <CADHLONGLZaZT4Ot56AnxOf=ROrTWvge5=NUx5uqKqJhpJibfOQ@mail.gmail.com>
 <6fe05804-da74-45cd-a6f1-df4644671d99@linaro.org> <CADHLONE2YnBJGJUp2-vn_XEpc7+quTMWF7y1zpV0ygeL2VpQxA@mail.gmail.com>
In-Reply-To: <CADHLONE2YnBJGJUp2-vn_XEpc7+quTMWF7y1zpV0ygeL2VpQxA@mail.gmail.com>
From: ruipeng qi <ruipengqi7@gmail.com>
Date: Sat, 23 Dec 2023 23:30:13 +0800
Message-ID: <CADHLONHHZAeubePPfZbG1N0Nv3ZJM5OWaJWqchBUpiN5Q27UdQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] [RFC PATCH 1/7] osdump: Add one new os minidump module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: catalin.marinas@arm.com, will@kernel.org, bhe@redhat.com, 
	vgoyal@redhat.com, dyoung@redhat.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, zalbassam@google.com, dianders@chromium.org, 
	mark.rutland@arm.com, lecopzer.chen@mediatek.com, maz@kernel.org, 
	arnd@arndb.de, yury.norov@gmail.com, brauner@kernel.org, mcgrof@kernel.org, 
	maninder1.s@samsung.com, michael.christie@oracle.com, samitolvanen@google.com, 
	linux-arm-kernel@lists.infradead.org, qiruipeng@lixiang.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 11:13=E2=80=AFPM ruipeng qi <ruipengqi7@gmail.com> =
wrote:

> > I don't see a problem why minidump cannot do it.
> Qcom minidump allows one kernel client to register its region to dump, an=
d then
> driver will create and maintain one elf head for it.
> But osdump will dump thousands of non-continuous regions. If you register=
 one
> by one, and add an elf head for each, it will cause heavy overhead. So it=
 store
> data in binary, and reassemble a standard elf format file offline for deb=
ug.
>
Osdump will only dump useful data, which may have been allocated before but
freed now. In a word, useful data are changing all the time. I think this i=
s not
suitable for Qcom minidump's framework=E3=80=82

Best Regards
Ruipeng

