Return-Path: <linux-kernel+bounces-161984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D04398B5434
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1912827D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3530624B34;
	Mon, 29 Apr 2024 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUIJPw3R"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9223772;
	Mon, 29 Apr 2024 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382746; cv=none; b=qyaPzMVuOSUFUaioJUzuzvsHGEFSakuGPXpBhxGkUFYupTI9McsGoa8OWcc8SKouILg7XIBgBjs+Nsbb/jFY/JZr9LkSn9F8b9/qXrE76bDxmXcpiJhdK/9UCcD8lkQJ6jjL5l36t6ccJVo/wuJzv+noAl1BWhXq+zFqFVJXUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382746; c=relaxed/simple;
	bh=kdnD/DH4jvb/O3LOSmeEHCTBm6BfAhdFEqG0B1S1Mx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyiYbDksxRgpU7lLg9YfCtynfYKecmR8EQ0KUOAzVF1Bv6Wv48b14ZXzVCe8Qb7/Dyh3X2NFY2WIkMaQo/w1g5zuPPgxr6/rC0MEJ27It6Pu4BHDoAuv60FeOinz9CkZlE2Fd/MxB3jjdqGt2W5DjSoznz/9T/HvIaUH0rO9CEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUIJPw3R; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5aa22ebd048so3338620eaf.1;
        Mon, 29 Apr 2024 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714382744; x=1714987544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbWYzCSEoyxumsvR08bPig+519NlxGiw91GX3ABWAmI=;
        b=eUIJPw3RKa4xGT6t5M8knhpCtT4exhoUT5BR2rtOU0c2ZqULurcbl5iwMlxRNcCvtG
         44Xd2+xatShl+9E7HMOf5bwQNNMZF2HfvQpY9Q+V8HkqlBeOloHvWkYLyHKNbGEiGn2T
         yepgCkT82xb/JQN5FwSyrsqVKSv0Ir0ajeaJy7vx9PzoRBi9kfotQI119I+ikPpMX07x
         Kx4A+WVBPPTpZal4ztT4Jg39u+HJpENkxUYWqspFCQYjAMUW8+WGaPn5ULUyONaxb168
         A42brIV8RNTfElSnNKJP1jbpMLhmz/lVkKpVeetOaXvF70ionAgZLCnaESZpe6/ddLxZ
         C8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714382744; x=1714987544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbWYzCSEoyxumsvR08bPig+519NlxGiw91GX3ABWAmI=;
        b=ZzCD1xwOzCUX/BrDg6NkOxiDPCQhiSWXPxdS2ZitaeKe70+k9affws3aCJzFTGRTlf
         qAbhffQyFrDS0NyB4C7d0iuHuE7aA0zWvwV8aMyyxqVA/jRCksP+lh2i8f3X1mHLQ92I
         fAeEmyPjZ/vbm4QZpteK5RQopLoXjC4QHn9YfzSarWJlujWBqH/QgmwKecoZHsxjwDpy
         r9oMamHls8z0DgLrI3SzMwPA8m7nkoKXA9Q+DiuTQzv/8k3ZFkh9p7W4PloEMeyuWvKs
         dJzOs5ASVDpX5VDKrXOeqz56bnMiFhshD+UdaxwzA25fGtxuPJdHoCF9xy5k3IRBaWBp
         wYww==
X-Forwarded-Encrypted: i=1; AJvYcCWx2/t+bOYE+8qv+wwoIyYj6UdcsiYhOt+zr8vjZ8pP36eTr8PXMD3IuflQZeF3OTaTlFaWXE9NoIPeRGjAh4VyfI/48LXyGzH6cWq1lo8eh4eaC/zraT0c0yNSRLX0pmcepvhmvBS7j1tFMCTBo34Pgvtgomg47n1aNrWwqT4r6j667g==
X-Gm-Message-State: AOJu0Yx2it7u9g9Phk83PLYNkrZ7LCTsxgYvIT75tb97kKY4M++KgdLd
	ykqjlLO96MyDQbWmTzgjWsMWsYfS707lOMxoZqM6/wZWqEOndDw0qz0jHnVm62mVuoMNEqoky5n
	1mwBCU/TMI+M7qRRSBNqtcVIpw1w=
X-Google-Smtp-Source: AGHT+IFYt5gw9zhGrhOiSzSqMiit+DxbvdfCvNpQBl3bbGxw562cT0dhGTU+x1sG3KWCX8QEEWIDzPg+gk6CXCaiFjg=
X-Received: by 2002:a4a:347:0:b0:5aa:3b8a:b491 with SMTP id
 68-20020a4a0347000000b005aa3b8ab491mr12049732ooi.4.1714382743967; Mon, 29 Apr
 2024 02:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427075426.662671-1-qiujingbao.dlmu@gmail.com>
 <20240427075426.662671-2-qiujingbao.dlmu@gmail.com> <40eee0ca-fb15-40c7-80be-a1198f37663d@linaro.org>
 <CAJRtX8RztQfeoBhGjdAZZBW5h9PQT_pYhyKCRsbXwx83SbCExA@mail.gmail.com> <1bc01cc9-313d-4433-9995-49a5738adeca@linaro.org>
In-Reply-To: <1bc01cc9-313d-4433-9995-49a5738adeca@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Mon, 29 Apr 2024 17:25:33 +0800
Message-ID: <CAJRtX8Q0RYFBrecSwWsDHQi8YaZ0hFAND8qj011j_p+uCjRHpg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: mtd: add sophgo spi-nor-controller
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, unicorn_wang@outlook.com, inochiama@outlook.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	dlan@gentoo.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 2:43=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/04/2024 08:41, Jingbao Qiu wrote:
> >
> >>
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>
> >> No clocks? No interrupts? This looks incomplete.
> >
> > If necessary, I will add clocks and interrupts.
>
> Does your hardware has them? Binding should be complete, so fully
> describe your hardware.
>

I will provide a complete description of the hardware.

Best regards,
Jingbao QIu

