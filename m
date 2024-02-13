Return-Path: <linux-kernel+bounces-64389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CDA853DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13A91C21B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EFC6216A;
	Tue, 13 Feb 2024 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="d3/2kqYw"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03A629F7;
	Tue, 13 Feb 2024 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861290; cv=none; b=H5hWQJ90TAPSx2fDwBAOPwNORC3mvSeXOhG3NK9kSU1SqMn/DR1iAL5PD8RLyBWbjSCsKUv0cIGQnEtaloYMWrKWzcL+fn3iYTjFpXBRSjfSfzkSuIfcYmLHQ1y4pSMZk/b82/qCwnqo5fWgF2GphgWsw2QoNTl78tfSW54iw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861290; c=relaxed/simple;
	bh=reC8I3soT88Wnp0RHmuLO4VmvUlQxjALtGehyVJMbTI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BCedZg/IhPvkbF0BAuFXpk6GiR9z+PGj7SwMlUSI9NzAhKUA/obSu/6PpAzCyCPmHL2Em9D8H2QuB0RqlRID4KjQA4ppm53cZBst4r/hzV1JgIMawIRu0qCmQs0nxOLtjDukXjvB8cHh4yeVefU15uhN8ubpZnDqdKiZuJjY07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=d3/2kqYw; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C95639C322F;
	Tue, 13 Feb 2024 16:54:45 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id SIIeMPSH3Ngt; Tue, 13 Feb 2024 16:54:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7950D9C45B7;
	Tue, 13 Feb 2024 16:54:44 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 7950D9C45B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1707861284; bh=XK+F628B2WCDvCgEDVP0Ie8v1oYwQM1KHLOPEbOC1NM=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=d3/2kqYw500kmqsBrMRqHMr/iBE9dkhrPAwl+qd9zRn661gyDrJXKwZowBnXXKnCr
	 tYnVj1ChsSHpLYFErEb7+TvOQkY4krOKXHLEFmlr++3VE1zcWos2QWdjwf/0kjO3kd
	 iCFIPPmSOa5HJVaCd6/VNdrVBNsN84wRwq2vb1QEb3ezXzOGhFS2CdW/nehaFwGrI9
	 YyIGgrI4gmFYwTkQ1WPqldWDSlRe7YJHCPmiihClEA1t8dxXj6XWlE7sx9MLErKpFM
	 jht+XM4xey3cyfoYWr2DQUZx0zEHAjk7ajAdCgGnON2T24pWTRPuVPr0yB2+NmQqRi
	 oT6elaO1LEIDw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id x8jIWcJN8Oci; Tue, 13 Feb 2024 16:54:44 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 41C379C322F;
	Tue, 13 Feb 2024 16:54:44 -0500 (EST)
Date: Tue, 13 Feb 2024 16:54:44 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Kris Chaplin <kris.chaplin@amd.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, mdf <mdf@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, hao wu <hao.wu@intel.com>, 
	yilun xu <yilun.xu@intel.com>, trix <trix@redhat.com>, 
	krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>, 
	Brian CODY <bcody@markem-imaje.com>, 
	Allen VANDIVER <avandiver@markem-imaje.com>, 
	linux-fpga <linux-fpga@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2031953666.970772.1707861284199.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <Zb9LDQP3xzrv6LWr@yilunxu-OptiPlex-7050>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com> <20240129225602.3832449-2-charles.perry@savoirfairelinux.com> <9b0680b6-1952-41d3-82f4-88c60469dc3a@linaro.org> <471d9438-e2c0-4881-8ace-778c9d14669c@amd.com> <Zb9LDQP3xzrv6LWr@yilunxu-OptiPlex-7050>
Subject: Re: [PATCH 2/3] dt-bindings: fpga: xlnx,fpga-slave-selectmap: add
 DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - FF120 (Linux)/8.8.15_GA_4581)
Thread-Topic: dt-bindings: fpga: xlnx,fpga-slave-selectmap: add DT schema
Thread-Index: nr8URtE0F+xvMtsch9fUNSxFAe+LVw==

On Feb 4, 2024, at 3:30 AM, Xu Yilun yilun.xu@linux.intel.com wrote:
> On Wed, Jan 31, 2024 at 11:03:25AM +0000, Kris Chaplin wrote:
>> Hello Krzysztof,
>> 
>> On 30/01/2024 16:09, Krzysztof Kozlowski wrote:
>> 
>> > > +
>> > > +description: |
>> > > +  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
>> > > +  parallel port named the slave SelectMAP interface in the documentation. Only
>> > > +  the x8 mode is supported where data is loaded at one byte per rising edge of
>> > > +  the clock, with the MSB of each byte presented to the D0 pin.
>> > > +
>> > > +  Datasheets:
>> > > +
>> > > https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
>> > 
>> > I am surprised that AMD/Xilinx still did not update the document to
>> > modern naming (slave->secondary).
>> 
>> Thank you for bringing this up.
>> 
>> We are moving away from using non-inclusive technical terminology and are
>> removing non-inclusive language from our products and related collateral.
>> You will for some time find examples of non-inclusive language, especially
>> in our older products as we work to make these changes and align with
>> industry standards.  For new IP we're ensuring that we switch and stick to
>> inclusive terminology, as you may have seen with my recent w1 driver
>> submission.
>> 
>> SelectMAP is a decades-old interface and as such it is unlikely that we will
>> update this in all documentation dating back this time.  I shall however
>> look to understand what is planned here for active documentation and new
>> driver submissions.
> 
> Yes, I need review from AMD/Xilinx side. Especially the HW parts, and
> some namings of variables, e.g. if xilinx-core is proper for what products
> it supports, and won't be an issue in future.
> 
> Thanks,
> Yilun
> 
>> 
>> regards
>> Kris

Hello,

I chose the "-core" suffix as it seems widely used for core logic of device 
drivers for chips that comes in an i2c and spi flavour. It seems like "-common"
is also widespread, let me know if you prefer that suffix.

As for the HW parts, here's the compatibles used in the v3 patchset for 
convenience:
- xlnx,fpga-xc7s-selectmap
- xlnx,fpga-xc7a-selectmap
- xlnx,fpga-xc7k-selectmap
- xlnx,fpga-xc7v-selectmap

We're trying to be a bit more specific than the spi interface which uses
"xlnx,fpga-slave-serial"

Regards,
Charles

