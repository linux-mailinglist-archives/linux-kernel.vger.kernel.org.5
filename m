Return-Path: <linux-kernel+bounces-143104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A5A8A343F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC18C1F233E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA0E14B075;
	Fri, 12 Apr 2024 17:01:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FAF14BF8B;
	Fri, 12 Apr 2024 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941268; cv=none; b=CxPDSSjNSGO7R0UkN7VO3wYtY0ZLzvx7AMvfT/SRbHKLQpLQ/wrKo2Sg8kjDVHhTADlroB5lHCYazvK1mJz9UUyaUm2ON2mW8/KzJaI1WHXuwJKXUEhHAtxUW0IAqrdifSanmCO9tyKjrn88joKmHCH5/quukvWCyFDUv0UJwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941268; c=relaxed/simple;
	bh=59anHmEmeL1dZlS9Wp5VDXxPg2tCJdny8Tcylbay9uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZi0Sz+kMSoXTNFlDKzuaMqXRfstfmpGyIF3+nKr6iBHXTKuNU+uHmTbNVWjdI5N+Z09TJrlG5VRzYhewucRcFV+7V+r1DuqP/bM8uGLloJmXXZMRfOXnKQ+hPJ85zbstTIy5uAyYjgyPElpyRi4Rl+kS0n7pQokKxOdw0g0o5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D8D5339;
	Fri, 12 Apr 2024 10:01:35 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 193413F64C;
	Fri, 12 Apr 2024 10:01:04 -0700 (PDT)
Date: Fri, 12 Apr 2024 18:01:02 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, sudeep.holla@arm.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v3 2/2] mailbox: arm_mhuv3: Add driver
Message-ID: <Zhlozklecy0Jr1Uh@pluto>
References: <20240404062347.3219795-1-cristian.marussi@arm.com>
 <20240404062347.3219795-3-cristian.marussi@arm.com>
 <CABb+yY3yzj167ypLPPV7OvqDWfv9y9EFQeZ5pxPAx7xUyyvLVw@mail.gmail.com>
 <ZhPJlHDMzejX_W4i@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhPJlHDMzejX_W4i@pluto>

On Mon, Apr 08, 2024 at 11:40:24AM +0100, Cristian Marussi wrote:
> On Sun, Apr 07, 2024 at 08:14:23PM -0500, Jassi Brar wrote:
> > On Thu, Apr 4, 2024 at 1:25 AM Cristian Marussi
> > <cristian.marussi@arm.com> wrote:
> > >
> > > Add support for ARM MHUv3 mailbox controller.
> > >
> > > Support is limited to the MHUv3 Doorbell extension using only the PBX/MBX
> > > combined interrupts.
> > >
> 
> Hi Jassi,
> 
> thanks for having a look at this !
> 

[snip]

> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > ---
> > > +struct aidr {
> > > +       u32 arch_minor_rev : 4;
> > > +       u32 arch_major_rev : 4;
> > > +       u32 pad : 24;
> > > +} __packed;
> > > +
> > I am not sure about using bitfields on register values. I know v2
> > driver also uses bitfields but this still is not very portable and is
> > dependent on compiler behaviour. We may actually save some loc by not
> > having unused fields if we use shifts and masks. Though I don't
> > strongly feel either way.
> > 
> 
> Yes, indeed seemed a bit odd way of handling regs when I saw it in mhuv2,
> BUT it seemed it had its advantages in terms of clarity of usage....did
> not know about possible drawbacks, though. I'll re-think about the pros
> and cons of this approach.
>

.replying to myself here...I am dropping bitfields too in favour of
bitmasks...I've read too many horror stories this afternoon about bitfields
and compilers interactions and their flaky usage while handling reg maps to
still feel comfortable using them...

Thanks,
Cristian

