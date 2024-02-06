Return-Path: <linux-kernel+bounces-55304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E28A084BAA8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1263B27284
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51462134CD4;
	Tue,  6 Feb 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAPrFaH4"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D874134733;
	Tue,  6 Feb 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235930; cv=none; b=d8WZhvcDaAxO4JrA6Iryc4K3FajBRRiHhLDEjbLkoBkpqawVzxQquTMMQe5j3X548SHWLtT6ULWH3MpGXPMUyvnLHvhl+d3ej2/6KFLeDOcQZBobUFdh/R654spB/zYgY8CVkTve6o8p0I/m8sBJtU/HiQWGUx+J8TsCvRB0TpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235930; c=relaxed/simple;
	bh=tFSFcGdDnM+rydUls8zgVSLgcWLUPOJYBlu445fpp0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fElaQB6Hn9ayPgJIzs4fXhVdUFGC32qjngIZu1tGTMJzi8z28+BVexaaLHobZ0lS5epgRkMoYj3l6jYLSsW17gNiY1HIawonM7hOwvi1nSc4NUZAzcJRbhayxLv5SlLiqx/yKOs8nxIGEZ+IwEK9CmLVCytxHDsDVpHYbqwSTaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAPrFaH4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-296c562ac70so866765a91.2;
        Tue, 06 Feb 2024 08:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707235928; x=1707840728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WsbXJfrd3Ched6eXICsVzo2aA/bknCN/SpOUD1C3kw=;
        b=aAPrFaH49mNmvSaVML/EgP6qEmRCsC2GiqezWWwL2DqkFaWillr+cAp2XSL9hsfBwL
         Xu1IPzoa62s7Kn6ArciWhKNJ9aUCpXYZzc3I0tq6UNGprTpTi1RAaQAyAO7ATvL4I6jO
         9epSt4BGK+e4o+DM5qKFCUZ30oWXQPg3RGjrHtxfXH2YxP6p/Hp+AZLC/C//L5VuZNwQ
         BldDINCA7Dj8ab2FUY8PZvHddgitsSpmMwBzy3hDVKe+3mDBeca7mdP2D9wDJfBvhjxN
         JtlBKg6LKIbR5NjfiF/qWiiubz/ONC0Q4CPZTUoFnEn+o8Mmz/asSmZjSszG6IIWhIDc
         30Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707235928; x=1707840728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WsbXJfrd3Ched6eXICsVzo2aA/bknCN/SpOUD1C3kw=;
        b=qli3jnqujGT4bmV5NeTK25tF2FauDKAnpobEZVcfxMmYTBDZxMlBHyeey7cqJkXYX5
         VMNtbBJZ+m0qGqT4CwNBhUZQg3vBkf1w5/x/HKktchT8+NiJrfxaJMcYNkX7lVBFHi8f
         PmKWq2xTMLVqDNf0X12GAn0ctf371D3weJcax9tD8Xb1ejFnLC2MQnJD6pyiyM7fPOGi
         vVPRhuNM8OI8AStw2KNuHQ1GRUN+b46q8TgOrbxDrHll++lUKfUF1ZjilV2HDFA/CNhj
         5PtrTFCbjrTp0rMMdzIxZ9IuevBifhATdxC543LJRyEekyCmteI2SthEdv0I0/NlLQfO
         OjAg==
X-Gm-Message-State: AOJu0YxQIBdiL6n3Vc242RnBjIG7xGtH03E1NJHC2C0sEKnAq9brdLXI
	uy36gEu8FkNI9kh++L0NuDaSQfrzCX2eCTnOwpPRvzHDzZw6hDys47+9yorFMgD8QVbM4tXn1eZ
	IcOBIeIOli1QAtQwXQz9/lQpkFg==
X-Google-Smtp-Source: AGHT+IGJ1b9hXkB/M8biWDr88GO5WtDG/gGIEQ1R9wABIRBxaNQY5dXWAnywJapuBDNAQ5bFJvdPqoCGBhukWh0UvSU=
X-Received: by 2002:a17:90a:6d44:b0:296:1cf3:e5b0 with SMTP id
 z62-20020a17090a6d4400b002961cf3e5b0mr2876280pjj.29.1707235921047; Tue, 06
 Feb 2024 08:12:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205191828.998783-1-frut3k7@gmail.com> <fb9767e0-c5a8-448f-b3f7-e6f81ef008e6@linaro.org>
In-Reply-To: <fb9767e0-c5a8-448f-b3f7-e6f81ef008e6@linaro.org>
From: frut3k7 <frut3k7@gmail.com>
Date: Tue, 6 Feb 2024 17:11:49 +0100
Message-ID: <CAKEyCaAXqhzMbTQL8WhLze39cey_DuE-LYOrK+oitD=NiZMuTQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Add qca,spidev
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Naresh Solanki <Naresh.Solanki@9elements.com>, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, Peter Yin <peteryin.openbmc@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@amd.com>, 
	Lakshmi Yadlapati <lakshmiy@us.ibm.com>, Lukas Wunner <lukas@wunner.de>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Fabio Estevam <festevam@denx.de>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 8:44=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/02/2024 20:18, Pawe=C5=82 Owoc wrote:
> > Add Qualcomm QCA4024 to trivial devices.
> >
> > Signed-off-by: Pawe=C5=82 Owoc <frut3k7@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/D=
ocumentation/devicetree/bindings/trivial-devices.yaml
> > index 79dcd92c4a43..50efbdf2a735 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -309,6 +309,8 @@ properties:
> >            - plx,pex8648
> >              # Pulsedlight LIDAR range-finding sensor
> >            - pulsedlight,lidar-lite-v2
> > +            # Qualcomm QCA4024 Multi-mode Bluetooth and 802.15.4 SoC
> > +          - qca,spidev
>
> There is no such hardware as spidev and you even mentioned it is called
> QCA4024, not spidev. Please don't use that name but a real name.
>
The compatibility will be changed to "qca4024" and a new patch version
will be prepared.

> Also, I have doubts that Bluetooth is a trivial device. Such devices
> need supplies, have reset/powerdown GPIOs.
>
> Best regards,
> Krzysztof
>

