Return-Path: <linux-kernel+bounces-568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 997D1814307
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4D21F21536
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8753510A17;
	Fri, 15 Dec 2023 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dxl+4YOA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7D10952;
	Fri, 15 Dec 2023 07:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF52C433C7;
	Fri, 15 Dec 2023 07:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702627015;
	bh=GQzlbYxdmN/odCSG1aUf4K3A+XwEp54m5ZTi8W6hKww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dxl+4YOAjJwEgsD7CL5xrmBDvcB8dbRWGz+RglwQZ/0y8rtTGZpJXQ57IjutzE7K9
	 hMBLdQT3Q7CxkGNYVC9/82HAAt1sRkQmJtOhIooFsJwOqiQhp0F3KVu+0T1NxoE7n1
	 g28OEuxcYsXTRv6aSAXsXgpThnH1MlB+r5YrrcyiE/O8d4TfQB4dm7WrX351ramkBT
	 9zA6WrFonH57rRZ6T/YivdDBcXimr60ztmDi8gQg//x2uNXE0ZpbQv1xGMIzj4Hnxm
	 GNZKjS8uQfJwepXkRDyLflFKaUZ0NgyPkgpfGQnl1+V4JkOmg2f4jTrXytl8j3suOD
	 8WRBAQUje3fRQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rE33y-0004mT-2B;
	Fri, 15 Dec 2023 08:56:50 +0100
Date: Fri, 15 Dec 2023 08:56:50 +0100
From: Johan Hovold <johan@kernel.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Foxconn T99W265 with new
 baseline
Message-ID: <ZXwGwknjavRzn9C5@hovoldconsulting.com>
References: <20231201020950.34770-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201020950.34770-1-slark_xiao@163.com>

On Fri, Dec 01, 2023 at 10:09:50AM +0800, Slark Xiao wrote:
> This ID was added based on latest SDX12 code base line, and we
> made some changes with previous 0489:e0db.
> 
> Test evidence as below:
> T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  2
> P:  Vendor=0489 ProdID=e0da Rev=05.04
> S:  Manufacturer=Qualcomm
> S:  Product=Qualcomm Snapdragon X12
> S:  SerialNumber=2bda65fb
> C:  #Ifs= 6 Cfg#= 2 Atr=a0 MxPwr=896mA
> I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
> I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> I:  If#=0x3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#=0x4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> 
> 0&1: MBIM, 2: Modem, 3:GNSS, 4:Diag, 5:ADB
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Now applied, thanks.

Johan

