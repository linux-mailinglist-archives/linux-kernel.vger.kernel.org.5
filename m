Return-Path: <linux-kernel+bounces-95707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9F8875192
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B55AB23F52
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E5212DDAE;
	Thu,  7 Mar 2024 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEVX5gVf"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A22E83CA7;
	Thu,  7 Mar 2024 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820705; cv=none; b=gwU0uNFlqq6dRgzh6VOqGp/zOuxDA9x7DihbyCol3yyrEg1zJ6m+JpDRph+R6TXyamI3v4vDrJ5UGEAGuUWWKwktmik9nyDHHEGPr2s/6uooCZiLnSA313GZc1p4l+I1NPzB4IbkCZldLnmUCsO8B9IqiWtJcU0JsVpv8zjYvQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820705; c=relaxed/simple;
	bh=j0mA/Sb2NYhykpOmGUbF+PdY3ukQW1OL1PdXzEnekRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RosnyxPbgc+JkR63w4HYt81/n1i5T7KBu1nZPMnxFoHj3Fj9IGhj/1FHzYbp1UONmfHYG2VXhvsgmK9hfz1llqrCMq0yJdSUMCObeU3n0llhLp+cOy50/a4p4ncuklqWu9kDmQrdfAVDYvdqLyIBbpNB7fzJtseDlfL23kW8XiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEVX5gVf; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso738832a12.3;
        Thu, 07 Mar 2024 06:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709820703; x=1710425503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfwer8XXczzwIW44mKPVsSf57S+ewbqnXIkK5KC8Spc=;
        b=XEVX5gVfb7UYzFdCHhAD1m42znCVYp08bx0eL+hvYRaoaGUfiPJ2yyibkkYga3DYod
         2A7hHrEgsWO0pocs0AXM0uQl06Z8H4FV9d7t44C6W42DVvZIfN2Gi8JQ399wgpsO3eFT
         rZaKEgVcyFWZAsLK/LrozTOxzegENpQCceZx+A+nXjcE/ObsFOqEivZrDFaaPxBfnE32
         WqbA+9nsnVqhAs7pg+O95OnNNIVFbIutlPM/iWyDC5UuNhILff//2aj1M5GZrcqfSHNm
         Ju2s8pK5wnayq0a89agEne0bKaBnLTpYfJS8mTub/lLysu1344lXXvDJsa3KyQEe9QfB
         o53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709820703; x=1710425503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfwer8XXczzwIW44mKPVsSf57S+ewbqnXIkK5KC8Spc=;
        b=UFyF2SDEM825QyBxJoOBqnU36Hm6sMJsSUcamZEetfVrMGJYym/APaGbdSt/PQbjvY
         Wc34doUk4jIQk2LCJH88YmS8enwG41rk+dTuukpHU5zFuQsG+2gNmW89rlv1Pjm66zdT
         MAFJMqcG7l3Wxl0JlBalwEVrhoDobPFCWwDYailQ1eVL4hl3nhpxi2q7Wnxyp4b1qb9m
         80tyghqCsbJuAjauL3EWEnzk6cddj4ZTVLbALPsgJL4wsltwCZXD+V5FThBM5RjJzLyd
         tXonClATkf5B6PYe2WYcVUscr/0EnQow5bZUjcI2P0AW62jqQh/F31NjoVtQwFtraWlX
         9beg==
X-Forwarded-Encrypted: i=1; AJvYcCVkWHoO5QzCJOGA8PZtZAaxv355QsOdAWmdS8i/ALtD9xpqJYnKCMRCA5U62zy+ufeMTwHjVaLID7uQmJetCgKyd0x7dsseAbOkFILzHD0sZm5j9kxuwzwAt7z2ygO3uhTIO8wEc0oScnUO2rMLup86BLIW2g/I3Yij/aBojFn1pHorNG392+qDNSkv
X-Gm-Message-State: AOJu0YzuFTu/GgxnkuKrvUfL907YaBAHpD2lv0WjrAGKXKMMEn5Wx+id
	9jF3/aMVdqXlycgCGs/kF9MuvtEawEd9VXnjRUGXZA3dV/zf9lQOsq7OPDmCpPMYU1Og0S7fsdZ
	iGo2C95Lxhx8/3YMGISMuswBh5mQ=
X-Google-Smtp-Source: AGHT+IELOAw76zrd2EKPhQWJD44/OyTabAu/xyaX1leOvbMFK+PySmZNQkiJ28Dm/4qWJV3R2luyZUxa3K4jXysNSOY=
X-Received: by 2002:a17:90b:1256:b0:29b:5c2:76ac with SMTP id
 gx22-20020a17090b125600b0029b05c276acmr16829531pjb.5.1709820703262; Thu, 07
 Mar 2024 06:11:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227034539.193573-1-aford173@gmail.com> <20240227034539.193573-2-aford173@gmail.com>
 <63199ea3af86986545fcec4e81fa3a38f18a160f.camel@imgtec.com>
In-Reply-To: <63199ea3af86986545fcec4e81fa3a38f18a160f.camel@imgtec.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 7 Mar 2024 08:11:31 -0600
Message-ID: <CAHCN7xK18gA-im4C16Ax-xevCOOqy1C8mXsUCEXNHnEPxxsuOA@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: gpu: powervr-rogue: Add PowerVR support
 for some Renesas GPUs
To: Frank Binns <Frank.Binns@imgtec.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"magnus.damm@gmail.com" <magnus.damm@gmail.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	Matt Coster <Matt.Coster@imgtec.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"airlied@gmail.com" <airlied@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"geert+renesas@glider.be" <geert+renesas@glider.be>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, "daniel@ffwll.ch" <daniel@ffwll.ch>, 
	"aford@beaconembedded.com" <aford@beaconembedded.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"mripard@kernel.org" <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 6:41=E2=80=AFAM Frank Binns <Frank.Binns@imgtec.com>=
 wrote:
>
> Hi Adam,
>
> On Mon, 2024-02-26 at 21:45 -0600, Adam Ford wrote:
> > Update the binding to add support for various Renesas SoC's with PowerV=
R
> > Rogue GX6250 and GX6650 GPUs.  These devices only need one clock, so up=
date
> > the table to indicate such like what was done for the ti,am62-gpu.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.ya=
ml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > index 256e252f8087..7c75104df09f 100644
> > --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > @@ -14,6 +14,11 @@ properties:
> >    compatible:
> >      items:
> >        - enum:
> > +          - renesas,r8a774a1-gpu
> > +          - renesas,r8a774e1-gpu
> > +          - renesas,r8a77951-gpu
> > +          - renesas,r8a77960-gpu
> > +          - renesas,r8a77961-gpu
> >            - ti,am62-gpu
> >        - const: img,img-axe # IMG AXE GPU model/revision is fully disco=
verable
>
> A new set of items should be added for 'img,powervr-series6xt' and the Re=
nesas
> models along the lines of [1].

Should I rebase my binding off the one below, so it applies to your
branch or should I attempt to base it off the mainline?
>
> Thanks
> Frank
>
> [1]
> https://gitlab.freedesktop.org/imagination/linux/-/blob/powervr-next/Docu=
mentation/devicetree/bindings/gpu/img,powervr.yaml?ref_type=3Dheads#L16-19
>
> >
> > @@ -51,7 +56,13 @@ allOf:
> >        properties:
> >          compatible:
> >            contains:
> > -            const: ti,am62-gpu
> > +            enum:
> > +              - ti,am62-gpu
> > +              - renesas,r8a774a1-gpu
> > +              - renesas,r8a774e1-gpu
> > +              - renesas,r8a77951-gpu
> > +              - renesas,r8a77960-gpu
> > +              - renesas,r8a77961-gpu
> >      then:
> >        properties:
> >          clocks:

