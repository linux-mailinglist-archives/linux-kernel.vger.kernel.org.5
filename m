Return-Path: <linux-kernel+bounces-51148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017B384871C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFA91F22789
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB815F547;
	Sat,  3 Feb 2024 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gpf+gTlZ"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A3E58206;
	Sat,  3 Feb 2024 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706974112; cv=none; b=jleVlb0C+ggGiyKLgKjE2HXn8I6agN0N/Im0MbkDLPPAFg+FX16vtUzrXH1F68PEfMly/mz3s97tqtb40kVzMnGaXq6Mbw3lAOotw2QEIB90hf2AGRylCCIPMHmLFr5PufJY6Dt/W3Kpax0/lQpPFw1GKxUIEpARasK4fwdbIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706974112; c=relaxed/simple;
	bh=Z1eBrxNxqM/kyYRT6w23i+affJIwdsPZx5ypg5FDsec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlne+D0dJYCwOi4FKUZHhFyWivLv9Z1t3Wdu0wPKdPxwFRQnTPpuxM4adUy+zx27b5sVBsC2fUgASQ6VLb9TeIZPwgbHvLCUL0bfqVV2/6bgNXO+lrSfXqA+cC9yFl6KnaS1nLyy5hvrRn8vKqtKcWGCGV+BBWcICvMCZbWXigo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gpf+gTlZ; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59a910a1265so1674666eaf.1;
        Sat, 03 Feb 2024 07:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706974110; x=1707578910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4MXHNjW+3TW74SFPNk16h7YsfWAXkb7kmdm8q7xjLc=;
        b=Gpf+gTlZq+lHFN2kD8I1N1CM1jAasNjhBWBFHDHFSMn7pt7K/UmrTQ7ynH864ETLaw
         cICoT+Yf1udM6eR9eNSGdBR/mX+3GSjDXrCi0LAPMkLHQI1mv+0agfyS3IIknOYOpjjA
         ZHJsuFom2EGDcGCyqUsNQrcWQa4VJ8w+bVfkITiXdnHzxgp2HxOa5HmlfKQ760OajEpx
         DvvZrcYN/Zm53BKeHQsBSQhmy1DbObT9tcRvtRfFBPC4q5qqTpgUT0Tuda9XdZjt3uxw
         jlCy8cGoxi+EOYey3z/E3HYds4d+Eq7XAnWRkQy5kghYapXgOLN5VWU1pDKjy2K4qgRd
         ACzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706974110; x=1707578910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4MXHNjW+3TW74SFPNk16h7YsfWAXkb7kmdm8q7xjLc=;
        b=vzHQdlT3zQwcSt/pmuIXExcP5rG1EkCUBcfmpv4Vh3Lzb7GXVdgz2V19ArQsqz60S1
         /yjr3wgPHH6KinQfeJbqFUI7G/2xAdvlxPeZ4lxlwS1pG52aYpi4wdgbUofbLeL1mO9m
         zEN2/encOYOM9wsjQ4h32/IGvVb6Q+5+CImqmjU1qgA0JOqJxgEFfNCquigAGBfS0NWA
         qXXwvBQys+6JknuHeZdR4s8FDDgyyoCF9r3E3glNrk5Q8d296I3/G41+ZGf6g7N+bV0u
         UX1EcRm8m4NujPyfba/fPjpJ/zfgkr+Bl2XNSKB3kmyqGJiax63nXkMmwMoSsfsJMpJ+
         sR6w==
X-Gm-Message-State: AOJu0YzoFuXI/GyjqYY3yokgbXieWisFOu6Z1GGJnS4S+V9K1E78xDWY
	wjzoTyPW+td7S5Rg6QyPFUswWGocDLC5wCnd1uQND7b51H0OrWzrDiEmBUKjk13UzgbhZqpqABO
	5SSIgnZ82Qf7oTcjnMhP9cy37zd0=
X-Google-Smtp-Source: AGHT+IGejb+39506xYRD04If91RNf9v3LcAXOuCrzLQson7SehNnWvNWTnkJYS0utZcAT5pi3N6ieKNhEj937IpriAY=
X-Received: by 2002:a05:6358:340f:b0:176:40fb:cf3a with SMTP id
 h15-20020a056358340f00b0017640fbcf3amr10746219rwd.14.1706974109996; Sat, 03
 Feb 2024 07:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202093907.9465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240202093907.9465-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240202-explain-harsh-b5d81cb5f59a@spud>
In-Reply-To: <20240202-explain-harsh-b5d81cb5f59a@spud>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sat, 3 Feb 2024 15:27:52 +0000
Message-ID: <CA+V-a8u--97k82xUdCnCRqo7cj+JAkmzAgcZqnD2neSGvtgznQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Update interrupts
To: Conor Dooley <conor@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

Thank you for the review.

On Fri, Feb 2, 2024 at 5:07=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Fri, Feb 02, 2024 at 09:39:05AM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > RZ/{G2L, G2LC}, RZ/G2UL, RZ/V2L and RZ/G3S SoCs have ECCRAM0/1 interrup=
ts,
> > reflect the same in the DT binding doc.
>
> Renesas' naming scheme really does not help here, but using the
> shorthands in the commit message when the diff uses the long form names
> is not the easiest thing to follow. (:
>
Sure I'll elabore the SoCs according to the binding doc so that it's more c=
lear.
> >
> > RZ/G3S SoC has ECCRAM0/1 interrupts combined into single interrupts so
> > we just use the below to represent them:
> > - ec7tie1-0
> > - ec7tie2-0
> > - ec7tiovf-0
>
> I think this information would be good in the itemised description,
> since that claims these interrupt are only for ECCRAM0.
>
Sure 'll update as below:

+      - const: ec7tie1-0   # For RZ/G3S SoC ECCRAM0/1 interrupts combined
+      - const: ec7tie2-0   # For RZ/G3S SoC ECCRAM0/1 interrupts combined
+      - const: ec7tiovf-0  # For RZ/G3S SoC ECCRAM0/1 interrupts combined

>
> > Additionally mark 'interrupt-names' property as required for all the So=
Cs
> > and update the example node in the binding doc.
>
> Why? You've not given a reason for doing this, so it just seems
> gratuitous.
>
Previous assumption was just the RZ/G2UL and RZ/G3S had the bus-err
and eccram error interrupts, but where as in actual all the above SoCs
have this interrupt so making interrupt-names as required so we can
parse them based on names.

Cheers,
Prabhakar

