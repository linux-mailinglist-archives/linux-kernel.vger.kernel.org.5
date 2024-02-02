Return-Path: <linux-kernel+bounces-50558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1DE847AC9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606662880B2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0C17C6C3;
	Fri,  2 Feb 2024 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="HKYY2VFE"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385831804E;
	Fri,  2 Feb 2024 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907233; cv=none; b=Y6tU4BhsoCiL/76BPQdiVSaFkahHd2vxVm2m/ccUbI0ISwV5masbmvmc7sXiuN0xmsgR4iO9JRgf5gPDE7sj/vWq0f1MW9U3RitA6NtgpC+mh9oPlmBqzCDPlV2SXcR+Rv359ci5qRyBz+r/bvD0gweX0DUI2kPYiNWSuQ7tv20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907233; c=relaxed/simple;
	bh=ckGZUBoQ1F3whDLkHoQyHfSZkTvxaDN5wvB2UmzpAOo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QeJ+KxrXHpaZFcU3lxaV/kqx81K4RbDPRgNsZXjl9TweQo9wTKR1MYPDDFtXh3+bJHWpBdh3UC+XAIZxJTP8E/+n3cIER4vloKCWaOpXrHvOAhH4elKhSecGqWRLtvyJZGtt5FJG3fVFT0SU8f/Z9/ILjFwibkQ0xIzrje9NpSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=HKYY2VFE; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3A50A9C15A8;
	Fri,  2 Feb 2024 15:53:48 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id flMfL2uwBDPh; Fri,  2 Feb 2024 15:53:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id ABDC79C33F3;
	Fri,  2 Feb 2024 15:53:47 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com ABDC79C33F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1706907227; bh=HjOTfW84z6WlZLIlDp5/qd2mO3qsjLhZuFlY6j+xp40=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=HKYY2VFERClr2sLusdFwB/qs6d2WuD5xRmO8YOUZ5wo7Z6aXgssF1t0OjNxgE4t7K
	 WPKbvdG9hpzJsWgFnVWM/PmpG6c31+1+Ah7wmEMU9X0f/050sJniTHgPS5UL7UqggQ
	 Ky05T4qYP7jfUKviCkYj5tLHF7355DkUKYTLbItOnUUarQ67DkrDgibQH8W2YyPEZE
	 4LPYjDaItdWQfTB5gw25e2f49zPldxGtVvgcICeqAo/terZzMk3WWfzfMwkuaBZ3pC
	 ZGzEH4cW9GQ2AAteiZqrCcsSEqLXYantDq5EqbbdlPmIs59cMn/5feTPQZ5oVWjgFo
	 bHTtmw2p6yD7w==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 4-9MN7DBNiAY; Fri,  2 Feb 2024 15:53:47 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 759A99C15A8;
	Fri,  2 Feb 2024 15:53:47 -0500 (EST)
Date: Fri, 2 Feb 2024 15:53:47 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: Rob Herring <robh@kernel.org>
Cc: mdf <mdf@kernel.org>, Allen VANDIVER <avandiver@markem-imaje.com>, 
	Brian CODY <bcody@markem-imaje.com>, hao wu <hao.wu@intel.com>, 
	yilun xu <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, 
	linux-fpga <linux-fpga@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <840358370.469058.1706907227423.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <20240202201646.GA903809-robh@kernel.org>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com> <20240131230542.3993409-1-charles.perry@savoirfairelinux.com> <20240202201646.GA903809-robh@kernel.org>
Subject: Re: [PATCH 0/3] fpga: xilinx-selectmap: add new driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - GC120 (Linux)/8.8.15_GA_4581)
Thread-Topic: fpga: xilinx-selectmap: add new driver
Thread-Index: MPhuH8qDC3JIZ5Xmftm01iQPgu4MyA==

On Feb 2, 2024, at 3:16 PM, Rob Herring robh@kernel.org wrote:
> On Wed, Jan 31, 2024 at 06:05:30PM -0500, Charles Perry wrote:
>> Hello,
>> 
>> This patchset adds a new driver for the 7 series FPGA's SelectMAP
>> interface.
>> 
>> The SelectMAP interface shares a common GPIO protocol with the SPI
>> interface which is already in the kernel (drivers/fpga/xilinx-spi.c).
>> The approach proposed in this patchset is to refactor xilinx-spi.c into
>> xilinx-core.c which would handle the common GPIO protocol. This is then
>> used to build two drivers, the already existing xilinx-spi.c driver and
>> a newly added xilinx-selectmap.c driver.
>> 
>> The SelectMAP driver proposed only supports 8 bit mode. This is because
>> the 16 and 32 bits mode have limitations with regards to compressed
>> bitstream support as well as introducing endianness considerations.
>> 
>> I'm testing xilinx-selectmap.c on a custom i.MX6 board connected to an
>> Artix 7 FPGA. Flashing a 913K bitstream takes 0.44 seconds.
>> 
>> v2: From Krzysztof Kozlowski review's:
>>   * Use more conventional names for gpio DT bindings
>>   * fix example in DT bindings
>>   * add mc-peripheral-props.yaml to DT bindings
>>   * fix various formatting mistakes
>>   * Remove all occurences of the "slave" word.
> 
> Please label the series with the version number and don't send new
> versions as replies to the previous version.
> 
> Rob

Ok, will do.

Regards,
Charles

