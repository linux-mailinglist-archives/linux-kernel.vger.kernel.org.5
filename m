Return-Path: <linux-kernel+bounces-119675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBAE88CBDD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD2A1C3E917
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E758627B;
	Tue, 26 Mar 2024 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l50yWZPZ"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C21CD30;
	Tue, 26 Mar 2024 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477096; cv=none; b=Z1Pm/3tNY/7WvJEZoPDISwmYgjsDOkedm1DSaEAjnGrgXWo3L8GGz8+vWaEbMrWLH35puCCNH1FFFrPNCEMiZFcewug2pQ3tBWZZmYg4snq+iGhK3XYJs3BV7fkMUH0yN9n/MQVqJo/Sfn3Vsczv8XxjGaA80f0xkHtppwPzU+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477096; c=relaxed/simple;
	bh=bru9qGl3c7myCGBTRFHIKEMfOfekl3TRWSLbdw8e6I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJA0IreV9gZZRWB7rDPs3aW6fq504S5JqqJ2MgWvrDpYS6X8vnaygSkcsXdsYglJERVW/mWJCQsPTbMu6PKDi3Nn39XMEH0M/4zFtPVSzCoZ5DENOm9R847wE6Nkx5QywdeU4MKQ4Go1H9cEn2iXwOBI2lqkb/SJn8W2STlt3V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l50yWZPZ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e6e37d33c5so787976a34.2;
        Tue, 26 Mar 2024 11:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711477093; x=1712081893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bru9qGl3c7myCGBTRFHIKEMfOfekl3TRWSLbdw8e6I0=;
        b=l50yWZPZVXTd8hh5Z095MAKEuoapdn+wHtjwmMAF3ZBadTbDzb07T71742Ic01CGNU
         uQeKX5j3eYulXF209xkHwoBZXw0jXWlARHK4CIfJekFl81DJ411HEarJGBz/vO0FljUr
         Y7C9I7rFSIrG9u1fD0f7XxxWP02UxNQYK86wRkE1oWGdUF0M9jwgt32IRyhUsT0kOH9s
         g7gutJbwxD89iTGpnYXQNa6pEIg+HRy2rlcsoBSQ3+hbCxMCuuEY1O2P4BC98lmWAJPH
         azufhXkOteMgnfe3c+LaGdAbjrwueRW5aW5+vvG1Hgc1c9YwAcj6ufyHPAdOSR3WqMqZ
         2DjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711477093; x=1712081893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bru9qGl3c7myCGBTRFHIKEMfOfekl3TRWSLbdw8e6I0=;
        b=a7tnXNigUEtQMaDjNmm2Liyub9WWbSIABPtnChLgeVFq4CfIsqUbNvBvn+2XMLhEOm
         JR25oVpHvlmQsgzxeW/LUKE7sF/dKRDFzNNxfI359sW2Yf3iOqNsE+WdqCR79dhXee2z
         NU1IAh7Hvv9XeskdacWmb58pKPz0rWgyYHRbgtreaDfKxPWbGS3j6dT23KaGiunIKGRB
         OPJtKYwSarLXW2I641MiFnC2bj84APaFDRIGSGqhJLWyaf/xlUONtQJj5aarfhUvD1PK
         UFqM3J8bl2PM1014tatBfLkoyToiVKeT3gctDTyQW9/+6K8lZFGsjk6OOHa/LdmdQfnN
         fv3w==
X-Forwarded-Encrypted: i=1; AJvYcCWPPAxqGrUXxDvwPy17BGUJ6IUMXIT3+qWEHxXjH06YO2zU5e2XZNTFt63fWY1Q3LFFFOmc85bJcvr/3mGH3EATad+Wx9HmZ04rCeXuwuixJis1g+bVxem14NKzmOBJ8onTfNMx29aY1A==
X-Gm-Message-State: AOJu0YzO7sN2U9FORYELQN1Eug+6hBxEPh+l4J5GIsg0D0amzl301LEN
	C8u0GzqJLTeIRmLT3r0ZZKKYoQUKunMpyJAD05fdCjSNjJjlS5DykL72JNyhen/XgnNGoht25em
	pMTSAFbuctrloPQGp/yCiHpYsiuA=
X-Google-Smtp-Source: AGHT+IH2ly91IPSIa+yP65mHp82XQ5L+Y3yDpftt/YTMohO1eWhVxahmWQ95TpJbtTuxwLPLQNjjcrB6LsZBT9ybZ4w=
X-Received: by 2002:a05:6830:1c3:b0:6e4:e360:c387 with SMTP id
 r3-20020a05683001c300b006e4e360c387mr370351ota.26.1711477093626; Tue, 26 Mar
 2024 11:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325210045.153827-1-afd@ti.com> <2024032631-excursion-opposing-be36@gregkh>
 <CAOCHtYjauA+BAxZJBMTaxxaMGcvipP9=ZPeWe4FiNFs_jpq6dg@mail.gmail.com>
 <ZgME0qSL3KXCD07I@chinchilla> <ceb391d3-c7f4-4d46-9f97-b651e1f5451c@ti.com>
In-Reply-To: <ceb391d3-c7f4-4d46-9f97-b651e1f5451c@ti.com>
From: Matthijs van Duin <matthijsvanduin@gmail.com>
Date: Tue, 26 Mar 2024 19:18:02 +0100
Message-ID: <CAALWOA8beMzNVma0KCyCCGW1jH0jf-57-fQX4QnZO5Ss7dbJVw@mail.gmail.com>
Subject: Re: [PATCH] uio: pruss: Deprecate use of this driver
To: Andrew Davis <afd@ti.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Kridner <jkridner@beagleboard.org>, 
	Drew Fustini <drew@beagleboard.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 19:02, Andrew Davis <afd@ti.com> wrote:
>
> On 3/26/24 12:24 PM, Matthijs van Duin wrote:
> > I'll write a more in-depth reply when I have a moment, but right now I'd
> > like to point out that the uio-pruss driver in mainline linux is for the
> > pru subsystem on the freon/primus family of ARM9-based SoCs (OMAP-L1xx /
> > AM17xx / AM18xx / TMS320C674x / DA8xx), which is not currently supported
> > by remoteproc-pru.
> >
>
> I'll wait for your full reply, but a quick note, for those devices listed
> this driver isn't usable either after they all moved to DT. As this driver
> never got a DT port and relies on platform data (which is gone for those
> couple devices).

Ah I wasn't aware of that. But then the reasoning for removal is "we
broke this driver a long time and nobody seems to care enough to fix
it" rather than saying they should use remoteproc, which does not
support these devices.

Matthijs

