Return-Path: <linux-kernel+bounces-158928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CF48B26D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A281C1F2438E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD5714D6E5;
	Thu, 25 Apr 2024 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vwaP65CK"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334214D2A6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063767; cv=none; b=ClbZGlhSD8Y8Pg934c0lJBAut8RvoLbs9v/5rt4960F2x63DWC+zzrO7vm+5Fgx5BfHxjEjbP3rk/BAtGRopMb8O3n6oL0zq9CWq/V8IqRZ8t5yc+GOL/NMjDuHxjJZ3Vxv/djZUx6+jf6TALy0InY07vU5vSZUqBD6RY7wZj50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063767; c=relaxed/simple;
	bh=MKvfwVZ3VjEw+spXFJ1a2UjO6QfAGuRev73DVWZbaUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cm7/ERULX9y7zBLxS0e1EPWXw3YvfWsh3hwfPZ0d/e7U7zqCtWBeodsBRNrveK/VROrlu0vFs+ee4qPjZD2g2XJGDwy/RBsV+/Aw+XoBCyxBH3TRf2MvtTb7EY6Up49mESOHGmuuBvX/x3sxLdZUMLSLtT5bemfMJ6DiIF6I+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vwaP65CK; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22edbef3b4eso449813fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714063765; x=1714668565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ukGEv4eef9O4oU5FT2ArMRccMeqiVjOsIZWttkttWM=;
        b=vwaP65CKWUR3Hgjrge/MD9U3FiR0QCLRSgkkd6qnbHpKwaqwezALAMIrPNLr4PO6Th
         2UuTdThPNxET3UfZsx3QG0bleJjXqL45JtT0a4C8LsomG1e/UGuU6tTEbIjxWXlmO4fc
         eKq40JXudTgJNVjUX8AY24dKyzSIQEw1I0Gevxx+oCAojID+5Gwi2hriLKsbX1mt1881
         x75IB2RaRGMiNbyjK4p8FLdgZB+Sr4Uco0EafENGEjJahSFGQjL8KdgBTCno5uCfmm8z
         lTteC30TYtJggxSSy6Iep4KPkoQKjdR62UhCogPpFW6zZA5MgHlIPX+oyK1lQG8y6hE/
         Q2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714063765; x=1714668565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ukGEv4eef9O4oU5FT2ArMRccMeqiVjOsIZWttkttWM=;
        b=PxK5LIlDXux4pnZPC86AJgjYHbbLgDDOvsvC1j9qwzNO5xXmzgKn6ymeRP/W8JFrUK
         21+U1LlYUqmCySQW4lj5hh6TPJpQO1tswt3wsemDtxdUDTSqObFUeOewD41h8tTMVXaX
         mqSRmswpew+7MUurcz+ng/TIrpuJtvmeZ7/iw4SaNvXwncsvw7oWxLd/0CJJqu5Cjh1d
         1ZYJjTXOvzOhPgoxWKGCJQ4GyJu9BvZy0iA3zP+eurCmeqcyH85lI06B4GMzM84K3k4b
         FnmziL3lRXs6lusTa/0mVahnFIGH0oLf7rb2rpXUUCD2ZFUC7lDocGy5AlMxouPdrxZC
         pbyA==
X-Forwarded-Encrypted: i=1; AJvYcCUC1DG7X1rGzmVWMZmBiFgNhTgNRb4xBqNASMU7klwaiC2tYwGXMfdj0eOcEsjAbkasF/LKuxuyODNM+sYeHYQLhK29CPSPkVDCJXyL
X-Gm-Message-State: AOJu0Yw6Lr539WmEMkoUhxl78LrBMqlBkOcVXrCdsSl/du8UCseyK7J0
	DuvF+uj1nv8jAgSVs8XthuxxmdsUQxuHLG3tlMxF35NTEW4AmuFxLXAAePLxWDNZTKj+pYz8X3/
	hBRE2VI1zoTuqn4dzLXIQf7o5kcfp8UM1CaXpeA==
X-Google-Smtp-Source: AGHT+IHZ1YGe8mBmpi+s6MNal/Tnn6pc3qt4P8KtR6rNBxE+ojMFISn6UD+3xJRSRmAITd10pNraylhnueFfb1V3Mzo=
X-Received: by 2002:a05:6870:4201:b0:22e:e26e:73ad with SMTP id
 u1-20020a056870420100b0022ee26e73admr6867939oac.58.1714063765265; Thu, 25 Apr
 2024 09:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423205006.1785138-1-peter.griffin@linaro.org>
 <20240423205006.1785138-4-peter.griffin@linaro.org> <20240424195318.GA367166-robh@kernel.org>
In-Reply-To: <20240424195318.GA367166-robh@kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 25 Apr 2024 17:49:11 +0100
Message-ID: <CADrjBPpQE2bMkVUHQHmBBZfRO8Hjb86xPvLQgSvn4BN0guY9xQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] dt-bindings: ufs: exynos-ufs: Add gs101 compatible
To: Rob Herring <robh@kernel.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org, 
	s.nawrocki@samsung.com, cw00.choi@samsung.com, jejb@linux.ibm.com, 
	martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com, 
	ebiggers@kernel.org, linux-scsi@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, saravanak@google.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

Thanks for the review.

On Wed, 24 Apr 2024 at 20:53, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Apr 23, 2024 at 09:49:55PM +0100, Peter Griffin wrote:
> > Add dedicated google,gs101-ufs compatible for Google Tensor gs101
> > SoC.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  .../bindings/ufs/samsung,exynos-ufs.yaml      | 38 +++++++++++++++++--
> >  1 file changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> > index b2b509b3944d..1179527d29d1 100644
> > --- a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> > +++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> > @@ -12,12 +12,10 @@ maintainers:
> >  description: |
> >    Each Samsung UFS host controller instance should have its own node.
> >
> > -allOf:
> > -  - $ref: ufs-common.yaml
> > -
> >  properties:
> >    compatible:
> >      enum:
> > +      - google,gs101-ufs
> >        - samsung,exynos7-ufs
> >        - samsung,exynosautov9-ufs
> >        - samsung,exynosautov9-ufs-vh
> > @@ -38,14 +36,24 @@ properties:
> >        - const: ufsp
> >
> >    clocks:
> > +    minItems: 2
> >      items:
> >        - description: ufs link core clock
> >        - description: unipro main clock
> > +      - description: fmp clock
> > +      - description: ufs aclk clock
> > +      - description: ufs pclk clock
> > +      - description: sysreg clock
> >
> >    clock-names:
> > +    minItems: 2
> >      items:
> >        - const: core_clk
> >        - const: sclk_unipro_main
> > +      - const: fmp
> > +      - const: ufs_aclk
> > +      - const: ufs_pclk
>
> 'ufs_' is redundant.

Will fix.

Thanks,

Peter.

