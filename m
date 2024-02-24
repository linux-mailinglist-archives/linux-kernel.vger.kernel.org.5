Return-Path: <linux-kernel+bounces-79499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 841DE86234D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 08:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E81DDB221DF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 07:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD511118F;
	Sat, 24 Feb 2024 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKDMR3V2"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D521D52F
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708759562; cv=none; b=eqqF1P188e7798P9VqWDz1JK+RuAoXt/6PhhtRgirZD5sax5dMaTDwtvM7IZUpCTB5IA5WdGrRPwNiaGfbt2QFgh8JKGsYaJWGJyaSE1lB6sTv0TT6Kow+v1CK8a8EabpF5ndmyqSQuNwk73l/Z4lrHlcRc9ZSNecuhH0VGXbZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708759562; c=relaxed/simple;
	bh=M73clpsJ4UC2VJwuflxdAKdt/hGGQ9flogi1KvVDtak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYjVYDwTs3OWBYn2NqWDajsne1Drocr95WYZxYj+lYUIETKA/4OyVxPTXglK8SBthLkZYRJzPv9lPJffMUySmuj1ZBJtFLR3wcAmRKU5UcCieX3/T6C2OYIk/mX0l2a/V813pL6SFCVdPaFpR8RnAHONmdIp+2a9hH2GdBfWjGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKDMR3V2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29a6dcfdd30so808769a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 23:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708759560; x=1709364360; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8FwIrVdhZ2az6n32/fJZBq/H4MbFnqzEludgNTAdw5I=;
        b=FKDMR3V2ejBgQae1q/6hA/o9k8BksYSlMC99JcB4dW1Vqeoy1YurCtnhWAHxpHSjER
         U78O0e8RVuLAco7CKgOf0p+PxRCHI3HMI0LtSmzEf8nlTSc5+wxxjm68fMwCCJ6llsXG
         FkuW6q2eKy4DON3Q5vUx1yfmy8l/4Mcua5EBM0NgH1aGa2AqDnX7vCHa6/01GR0HS6Eb
         lAd9t+f8gphHgcSUBgYYAy6OXXWMFENBQUWn79ef1+AdvAGy3VsiW6bunJcb5p1qekP2
         2fBk59qMmUxAH03okrHP3wAY6ZteZUmNmEH5/KJu2HZt3CfxyII7RBtLWC6Tssdu4X5U
         OZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708759560; x=1709364360;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FwIrVdhZ2az6n32/fJZBq/H4MbFnqzEludgNTAdw5I=;
        b=OS2CO5zn+wOXDUytUmSQEBrMMo6VqwjQ0nalPWan57XectMC4sJ7+rasfl+WPPXyB+
         MpCcOkK5dy/PtqGcPq8vT/0hFIGE5GnLvvMlyGgeGuRcqmJY4nFeAdh80PQb0RKrkC3i
         JVlxu+NPr+QTYA2d0BqB1dAyDH+Jlv3IYB+P9cbv8DXQ6Jr+PfQsKeQRc3yACDdVeDal
         OWNMy87NxTFFcHNXvQAgqw/O7OFZVSxkUWeUYXWd3Hj3liL8ZxfBTarBkiaNgeEf00rC
         NWG75ZLRwDnJ8G4M4Zy/bZ0S+JtyyOGDLRB61GsTqBPa3Vm2vdAr9ZsdH5Ad3KAvr/uE
         BruA==
X-Forwarded-Encrypted: i=1; AJvYcCWWPu3vlxyY3G0nGl/Ot7/8AdUo34XJSDYvRU1wojfQHSE28sH7flKTFhRn9Rfsf7XcE0U564mhe8ZWwbIWfiofBIRqTkCAm7kIZ6ty
X-Gm-Message-State: AOJu0Yw9rJgzZAjOizBiX8cOqN6Hboiifrte8q+Vgd0LD97T8y8bTyxZ
	CdxTXSYMTtmOc0kiCzZPe8gUU7YE2urZHFIwZA27tOmbt8nGRWcJ
X-Google-Smtp-Source: AGHT+IH9MCglILdIP6ug54fLmEhNX4iNeGOTd0ZiNXDK8PZDH305OShsG7z7ZfcMlrGTTXKnY4wbDQ==
X-Received: by 2002:a17:90b:238b:b0:29a:a3cc:b174 with SMTP id mr11-20020a17090b238b00b0029aa3ccb174mr83613pjb.4.1708759559781;
        Fri, 23 Feb 2024 23:25:59 -0800 (PST)
Received: from linux-8mug (220-129-204-58.dynamic-ip.hinet.net. [220.129.204.58])
        by smtp.gmail.com with ESMTPSA id s62-20020a17090a2f4400b002992f49922csm715153pjd.25.2024.02.23.23.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 23:25:59 -0800 (PST)
Date: Sat, 24 Feb 2024 15:25:20 +0800
From: Chester Lin <chester62515@gmail.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Matthias Brugger <mbrugger@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Olof Johansson <olof@lixom.net>, krzysztof.kozlowski+dt@linaro.org,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	soc@kernel.org, NXP S32 Linux Team <s32@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Add maintainer for NXP S32G boards
Message-ID: <ZdmZ4JC0CsX2qs5C@linux-8mug>
References: <20240221120123.1118552-2-ghennadi.procopciuc@oss.nxp.com>
 <f4465547-1fb1-4578-9a69-7d399e7661b3@linaro.org>
 <403e32c2-910e-4745-9ebe-fbf377c3fde8@linaro.org>
 <ad856766-8903-46c0-93af-24e101ad51dc@oss.nxp.com>
 <e538ded0-bd3a-4ca4-b2bd-8d20d8c8c3fe@linaro.org>
 <bcb79af4-56d9-4204-9503-cff996f1ba41@oss.nxp.com>
 <e6f6070e-8355-4a0b-a904-1a24970f249b@linaro.org>
 <e530d504-dfa3-4d39-b903-b2570bb8b014@suse.com>
 <c3e68c62-b81f-475b-9b15-c983c94aed8b@app.fastmail.com>
 <Zdiu8s5Cgz9s6dLP@dragon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zdiu8s5Cgz9s6dLP@dragon>

Hi all,

Sorry for the late reply since I lost connection with upstream due to a
health condition, which affected my eyesights for a while so I tried to use
my eyes as less as possible. Please accept my apologies anyway.

On Fri, Feb 23, 2024 at 10:42:58PM +0800, Shawn Guo wrote:
> On Fri, Feb 23, 2024 at 01:29:10PM +0100, Arnd Bergmann wrote:
> > On Fri, Feb 23, 2024, at 13:02, Matthias Brugger wrote:
> > > On 22/02/2024 12:13, Krzysztof Kozlowski wrote:
> > >> On 21/02/2024 18:00, Ghennadi Procopciuc wrote:
> > >> 
> > >> Andreas or Matthias,
> > >> Maybe you could change your R: into M: and take s32g patches?
> > >> 
> > >> If not, then I will ack this patch making Ghennadi the maintainer.
> > >> 
> > >
> > > Normal process would be that Arnd would contact Chester to see if he is 
> > > not able 
> > > to do the maintainer work any more. In that case maybe Arnd could take 
> > > over.
> > 
> > I was hoping to see a reply from Chester one way or another,
> > I see he has been on Cc for the entire thread but not
> > chimed in.
> > 

Before leaving SUSE I reached NXP to see if anyone could take over it but I
didn't get response unfortunately. Maybe it was too rush to find a right person
at the moment but I still wish that someone can take over this role based on the
following reasons:

- Since I have returned my S32G boards to SUSE, currently I do not have a platform
to verify S32G patches unless I could get a new one. I wish I could still help
out but hardware & doc resources will be the biggest challenge to me.

- My current employee may have competitive relationship with NXP in automotive
field, which means I may not be fit in this role unless nobody cares.

> > > I'm not saying that Ghennadi won't be able to defend this, if it ever occurs. 
> > > Basically because I don't have a good track record of him due to missing 
> > > upstream collaboration.
> > >
> > > I would prefer that Arnd (or Andreas) step up to take the maintainer role. I 
> > > already have one and it's difficult for me to find the time to do it in an 
> > > acceptable way.
> > 
> > It appears that we already cover the dts files in the IMX
> > entry, whether that is intentional or not:
> > 
> > ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> > M:      Shawn Guo <shawnguo@kernel.org>
> > M:      Sascha Hauer <s.hauer@pengutronix.de>
> > R:      Pengutronix Kernel Team <kernel@pengutronix.de>
> > R:      Fabio Estevam <festevam@gmail.com>
> > R:      NXP Linux Team <linux-imx@nxp.com> 
> > L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > S:      Maintained
> > T:      git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> > F:      arch/arm/boot/dts/nxp/imx/
> > F:      arch/arm/boot/dts/nxp/mxs/
> > F:      arch/arm64/boot/dts/freescale/
> > 
> > Added everyone there to Cc, having any s32 patches go through
> > the imx tree would be the easiest way as far as I'm concerned.
> > I've added the maintainers to Cc, let's see what they think.
> 
> It's unintentional that IMX entry covers s32 dts files, as they have a
> dedicated entry.
> 
> ARM/NXP S32G ARCHITECTURE
> M:      Chester Lin <chester62515@gmail.com>
> R:      Andreas Färber <afaerber@suse.de>
> R:      Matthias Brugger <mbrugger@suse.com>
> R:      NXP S32 Linux Team <s32@nxp.com>
> L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> S:      Maintained
> F:      arch/arm64/boot/dts/freescale/s32g*.dts*
> 
> However I'm fine with collecting and sending patches through IMX tree,
> if S32G folks help review them.
> 
> Shawn
> 

This looks good to me as well.

Regards,
Chester

