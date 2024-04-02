Return-Path: <linux-kernel+bounces-128100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F28B895621
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8621F23284
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71A885C46;
	Tue,  2 Apr 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="lS+FaL/p"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5997F84FA5;
	Tue,  2 Apr 2024 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066710; cv=none; b=HmMrL8/FolsKtML/oieq8C5cpjcWsYHxV7+cWlnhlKPmVuPgyLzqw2POCvm4QVeRKDAvimYX2OFMO+Nc/5jvFDzJnQMLyX6q3YZ0j++td3eM4+NpxZQ67nWLEL2FOfX3j82s5bMYy+fR8nGn40/ybqh94s52oVslBBunegBcHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066710; c=relaxed/simple;
	bh=1KQpE/wKkfNXVZjIY5YSWJ0L+8xMoq5VTVkgItzgIGA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XeKXYSiEyIujVK2pET5icZWGiMe7978r88Bk4A1ewgGXXDXXzkmjgCK1Yn9EegFsI4DmfFYALHWLVmkxUDNp2rqfGbv0OlvPJjtyHvBd4bNeqGnvBqJve/yeU6FFLcSM/i7y2eitcUeF5XNVtiAur/D4uOQpg6JJIV72F1Jfk8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=lS+FaL/p; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2D0559C48A7;
	Tue,  2 Apr 2024 09:57:14 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id VcCNgTxHjS3s; Tue,  2 Apr 2024 09:57:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D375F9C5513;
	Tue,  2 Apr 2024 09:57:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com D375F9C5513
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1712066232; bh=ALDYI6XuaPNWtm94gEWunCW8yXYfE1h1vT+jsdoUx/w=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=lS+FaL/pA8mxzosDbxfotWTwNjY+id7g17zK2cbkhvolCl1IVqe5FRmEZ+sT7ZkU4
	 kvtTX3OmQ6qJlngTz0Emk//t+eIY+zHnEHvOr8uknpByLCWQ/7fLYR+x9W4j5+idKp
	 gFDYQndiBlHZJMpkGVFmHmOEMB72KUbEDQ1VxruHwhX06bjurxNq9Z9lH42MhysG6t
	 /pxsJMEXyWmmFYj07t+VeQRmO0QMa7pd4iWUjm+yrJlVCfpcWtjtra9nzPqw6RnlkQ
	 hgkw5GYw/VpoK+6pZxC69qHbjV6KA9JCPmOTqSmsdGBlWlqy1VDL7l+hDLJuhvfBn4
	 u0z9Ho4+cSZsg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id S17stuCxxIkB; Tue,  2 Apr 2024 09:57:12 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9780E9C48A7;
	Tue,  2 Apr 2024 09:57:12 -0400 (EDT)
Date: Tue, 2 Apr 2024 09:57:12 -0400 (EDT)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: mdf <mdf@kernel.org>, Allen VANDIVER <avandiver@markem-imaje.com>, 
	Brian CODY <bcody@markem-imaje.com>, hao wu <hao.wu@intel.com>, 
	yilun xu <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, 
	linux-fpga <linux-fpga@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <1609084823.2225067.1712066232087.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <Zgl4I6rykg7shI2K@yilunxu-OptiPlex-7050>
References: <20240321220447.3260065-1-charles.perry@savoirfairelinux.com> <Zgl4I6rykg7shI2K@yilunxu-OptiPlex-7050>
Subject: Re: [PATCH v6 0/4] fpga: xilinx-selectmap: add new driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - FF120 (Linux)/8.8.15_GA_4581)
Thread-Topic: fpga: xilinx-selectmap: add new driver
Thread-Index: TMcs+RZQxoWgE3ur0JfiynebDmdisQ==


On Mar 31, 2024, at 10:50 AM, Xu Yilun yilun.xu@linux.intel.com wrote:
> On Thu, Mar 21, 2024 at 06:04:32PM -0400, Charles Perry wrote:
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
>> Changes since v5: (from Yilun review)
>>  * xilinx-core.h: remove private fields kernel-doc
>>  * xilinx-spi.c: rename conf into core in xilinx_spi_probe
>>  * xilinx-core.c: introduce the new gpio names in patch 4/4
>>  * xilinx-core.c: remove kernel-doc on xilinx_core_devm_gpiod_get()
>>  * xilinx-selectmap.c:
>>    * reorder includes in alphabetical order
>>    * xilinx_selectmap_probe(): remove unused resource *r variable
>>    * xilinx_selectmap_probe(): use a single gpio_desc* temporary
>>    * xilinx_selectmap_probe(): declare variables in reverse xmas tree
>> 
>> Changes since v4: (from Yilun and Krzysztof review)
>>  * xilinx-core: use sizeof() instead of hardcoded immediate
>>  * xilinx-core: fix module compilation (EXPORT_SYMBOL_GPL, MODULE_LICENSE,
>>    MODULE_AUTHOR, MODULE_DESCRIPTION)
>>  * xilinx-core: add private/public qualifiers for struct xilinx_fpga_core
>>  * xilinx-spi: remove struct xilinx_spi_conf. This struct isn't needed as
>>    the struct spi_device* can be retrieved from the struct device*.
>>  * dt-bindings: remove usage of "_b" and "-b" for the new driver. We
>>    agreed that the spi and selectmap driver will use different bindings
>>    which will be handled by the driver core and that the legacy names will
>>    be used only for the spi compatible.
>>  * xilinx-core: select between prog/init and prog_b/init-b
>> 
>> Changes since v3: (from Rob Herring review)
>>  * Fix an error in the DT binding example compatible.
>>  * Drop the renaming of "prog_b" to "prog" and "init-b" to "init".
>>    Patches 2 and 3 are removed.
>> 
>> Changes since v2:
>>  * Inserted patch 2 and 3 which rename "prog_b" and "init-b" into "prog"
>>    and "init" for the SPI driver.
>>  * From Krzysztof Kozlowski review's:
>>    * Use more specific compatible names
>>    * Remove other missing occurences of the slave word missed in v2.
>>  * From Xu Yilun review's:
>>    * Fix vertical whitespace in get_done_gpio().
>>    * Combine write() and write_one_dummy_byte() together.
>>    * Eliminate most of the xilinx_core_probe() arguments, the driver
>>      needs to populate those directly into the xilinx_fpga_core struct.
>>      Added some documentation to struct xilinx_fpga_core to clarify
>>      this.
>>    * Removed typedefs from xilinx-core.h.
>>    * Moved null checks in xilinx_core_probe() to first patch.
>>    * Move csi_b and rdwr_b out of xilinx_selectmap_conf as they are not
>>      used out of the probe function.
>> 
>> Changes since v1: (from Krzysztof Kozlowski review's)
>>   * Use more conventional names for gpio DT bindings
>>   * fix example in DT bindings
>>   * add mc-peripheral-props.yaml to DT bindings
>>   * fix various formatting mistakes
>>   * Remove all occurences of the "slave" word.
>> 
>> Charles Perry (4):
>>   fpga: xilinx-spi: extract a common driver core
>>   dt-bindings: fpga: xlnx,fpga-selectmap: add DT schema
>>   fpga: xilinx-selectmap: add new driver
>>   xilinx-core: add new gpio names for prog and init
>> 
>>  .../bindings/fpga/xlnx,fpga-selectmap.yaml    |  86 +++++++
>>  drivers/fpga/Kconfig                          |  12 +
>>  drivers/fpga/Makefile                         |   2 +
>>  drivers/fpga/xilinx-core.c                    | 229 ++++++++++++++++++
>>  drivers/fpga/xilinx-core.h                    |  27 +++
>>  drivers/fpga/xilinx-selectmap.c               |  95 ++++++++
>>  drivers/fpga/xilinx-spi.c                     | 224 ++---------------
>>  7 files changed, 466 insertions(+), 209 deletions(-)
>>  create mode 100644
>>  Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>  create mode 100644 drivers/fpga/xilinx-core.c
>>  create mode 100644 drivers/fpga/xilinx-core.h
>>  create mode 100644 drivers/fpga/xilinx-selectmap.c
> 
> Applied this series to for-next with a nit.
> 
> Thanks,
> Yilun
> 

Thanks again for all the good reviews Yilun.

Regards,
Charles

>> 
>> --
>> 2.43.0

