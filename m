Return-Path: <linux-kernel+bounces-98431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4BB877A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE17128172D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6511C33;
	Mon, 11 Mar 2024 03:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX9AkxYI"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF8A1841;
	Mon, 11 Mar 2024 03:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710127590; cv=none; b=dhK6PxClf/aO3ROOQkcLp0U8tRxs4JxMNRK+aEXWlgCdsPcMykfUoJhzDgkkqL/bBAlQdOvtS0iFgDcHM2Mjz0kGKc0ho50QjwfPTgjcteIS/T50V+ApaU8ESYUQdb19Ve2JkNOPkkPHZC/OEIhBFjeru8pIketUtXxK9NUpfi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710127590; c=relaxed/simple;
	bh=sn8yzQnfAvzFkzSGVlfp8vWZGjAdHC8xK78c9kz8srQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFcLv3aUZfOAcXHFwiBxQrPIn0m2iYdN9IwdG5JhNQyB/pKZoszmtvtxDMtZEA0jFRO6d9gZFz13Umj8cqhSwzr/vL3zYwODSYOSkZnN63Lbq3dlBV3nyLIDLdCRtDnbYHB8QA2+DZrUvq3OVEdK4cZB5ze9f0XOAzR98Mfg5Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX9AkxYI; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-221830f6643so2236242fac.2;
        Sun, 10 Mar 2024 20:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710127588; x=1710732388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sn8yzQnfAvzFkzSGVlfp8vWZGjAdHC8xK78c9kz8srQ=;
        b=gX9AkxYI5WeAYtuYTDQ88mj5vWezENAWPMIHgL9tF50f/qrHoiz7u0ZtwJM2LYXnTt
         xb+ydeKxD8Q1USaFrwYCmaNpFeNIQjgcdjCGrATwubxXjIXvdyAAWD9RYakZopt5GIh3
         E96QUM3JxfuQtDWfmzMcgVbB7aMT4qDmb1Fpos9AjbLzGxsr9z2m/dMAKQsK4VDazr5Z
         DQZVcCEUhH+Uqo0Cut7aTpuWtK4Eii82P26qPC6GIVqlnO5xmnqtddZFL5fS5eGz0BMZ
         lb3PREW5g6U+Io/H93wcErcmWVKYHlxFyStVwRNGUQJb7Ag2nKqINzYXqSJkcdG3IkKs
         fZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710127588; x=1710732388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sn8yzQnfAvzFkzSGVlfp8vWZGjAdHC8xK78c9kz8srQ=;
        b=fMyX/nKJyi7xG8cHpYvyU88kn/beuzuoWiYk3NdBOB9TCNwYYdv31wbFNFkonl2Iej
         Hg8/2eRgbX1vxtJBmXQC6b/7RKhBuHpTXuQV+adx5d3fA7GZCv9hy89fkUTOTNN2I/ZJ
         Mz4EQlZ1IDFQ/oRF5jHXPS6Ujads6Dmrv+oqibRVYIeh6t+TnWlk/PA3aPjRQgQwRwbB
         tyFgb0Ys00/Sre/38Ju83LqOUxEoBQ35WaR6aVjfCAtEQCA9I3mtknTkuqdYl+5dLZsA
         zsWduxJoNb+PnsK3VtZK+V+nKSPJwyNmMqd766cvCF7SOr7NtX6Ym9qHLsDfFYbXZSEo
         7VOg==
X-Forwarded-Encrypted: i=1; AJvYcCX498i5V9lj+4iqKXxJrpY+nYHZXAw5bI4no+JMqBTC9jtqqwkvdr2LRqWT7B5wQbK6RbE7MaiTTuN019kV77b5FtEQYLD68lyDWCZvCiQ5DcTo+P1+uthsg1JUTJGbF+eKMVUt2W7d251l8yPR8oK9PHPnhhJt/gPmRSJN+V/SJfsNHw==
X-Gm-Message-State: AOJu0Yzt5KXDTnNR6Z+wU+QX27IZD1mwdNTOAzpO9TJSqxLZR+o5Bdgh
	F7SxbTFZBXxGtc+KSXJsB82cy291ek/9b5D9PpL+PeqlYWfg6aUYTq6jo6+r6M4s53P0dBej4fa
	RteVefFznAqt+DG9EkBvafmkFEls=
X-Google-Smtp-Source: AGHT+IGBzj8BOLNA6pZTcF5z4LL7CexPeACg2TGTYOFbwcGTjcY5k8uz0+hEaE06CL/KwVkLUu5/+F09iQ23kRYFBzA=
X-Received: by 2002:a05:6870:1707:b0:21a:1aff:cceb with SMTP id
 h7-20020a056870170700b0021a1affccebmr6347590oae.18.1710127587928; Sun, 10 Mar
 2024 20:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310175217.20981-1-animeshagarwal28@gmail.com> <448f9d20-8b45-4794-9440-89d6a6888aee@linaro.org>
In-Reply-To: <448f9d20-8b45-4794-9440-89d6a6888aee@linaro.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Mon, 11 Mar 2024 08:56:24 +0530
Message-ID: <CAE3Oz81KCzFVuVeGiCvFi5jHD6gBMTLx5fHd6DO_ySz2X488og@mail.gmail.com>
Subject: Re: [PATCH v6] dt-bindings: imx-pata: Convert to dtschema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 2:00=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> What is happening with your patches? It's 3rd or 4th version the same
> day and while it was improving, this version has some weird changes.

I'll stick to 1 version in 1 day from now on.

> Why did you changed the sentence from imperative? What for? Please read
> again my comments.
Ok, I'll change it back to imperative.

> What is imx31-pata.dtsi? Where is this file?
Sorry for this, I will add the complete path now.

> These are not sentences. Please use regular imperative mood with full
> stop and capital letters.
Noted.

> patch 6 of what? There is no patch 6 here.
I wanted to say patch v6.

> "Convert foo bar to DT schema format. Add missing fsl,imx31-pata and
> fsl,imx51-pata compatibles during conversion, because they are already
> being used in existing DTS."
Got it! Adding this in the new patch now.

> Why adding this blank line? It was not here before and no one asked to
> you to change anything at this place. How it is possible to edit one
> piece of file and cause some entirely unrelated changes in other places?
> Please use an editor which you are comfortable with - which you know how
> to use.
Sorry for this too. I'll be more cautious while posting.

> The use `git add -p`, to see what you are adding to commit. DO NOT USE
> `GIT ADD FILE` or `GIT ADD .`. Almost never... Think what you are adding
> to the commit.
Noted.

Thanks for your patience and time.
Animesh

