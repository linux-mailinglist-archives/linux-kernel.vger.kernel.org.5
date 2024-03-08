Return-Path: <linux-kernel+bounces-97536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A1F876B9A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE535283302
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AA85B66B;
	Fri,  8 Mar 2024 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="TVpfsy5z"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DAF5B5D6;
	Fri,  8 Mar 2024 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709928661; cv=none; b=RJOJOhXZ20NB6FIwH6Moir/XlYvQNNNynMeSioc6aAMtC70GArSGVZ4u3e0nhMtppgeEQLv2lgnxYIoZaAzrxrwHIaPSvbeJACLVVsLzXxYq43TEQNrt1TQWtUtWx87fXBM855HMzOWxe6CXgoB2Qk9EiBM293RkmujvZjhtsQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709928661; c=relaxed/simple;
	bh=neQwbdw1yLPYJXkxKc/FISqqenfam9MUiXWCEuGu2N4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pdBgQE299u2fpHLzLW0ukxmPrGlB3w5RV6ydTCo4sckwhZYVhj4CyAyu2IZeW7iB85ZH0UJpns89N9eJ2mmPbKFnDI0WMOfSHVKz6kVeRX7SNhcXz3C4dTqFLXEQGTZykDD+yswCN4NpU4puBch4nayym1G7hX1seIQZ0gOBHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=TVpfsy5z; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Try3P2cPGz684f;
	Fri,  8 Mar 2024 21:10:57 +0100 (CET)
Received: from [10.10.15.2] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Try3D2VQ1z6848;
	Fri,  8 Mar 2024 21:10:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709928657;
	bh=JRhGEq9uZ6Vp9hWu99RmsfqSEWaRtAnKR+DBLuclBzY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=TVpfsy5zEBnpv30AH9HP26awuHv4AGrRu6DmqLOny1VSPr+CJp0RaMNQKRmFz5fqv
	 QC1gEbUvG/Nkkk7tUlLhgmfC4YTaYgyEyrizAwrmSO3iv4LxL9k04Kpw6hcWc6KOdw
	 Sbg9u/E+QSD9Eq/+eUAIFRmGEAwtfGYJ1NGWm6P4=
Message-ID: <5805f289-9851-4b8b-9d12-ae0187b7859a@gaisler.com>
Date: Fri, 8 Mar 2024 21:10:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/fonts: Allow Sparc console 8x16 font for sparc64
 early boot text console
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
To: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Sam Ravnborg <sam@ravnborg.org>,
 Randy Dunlap <rdunlap@infradead.org>
References: <20240307180742.900068-1-andreas@gaisler.com>
In-Reply-To: <20240307180742.900068-1-andreas@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-03-07 19:07, Andreas Larsson wrote:
> Allow FONT_SUN8x16 when EARLYFB is enabled for sparc64, even when
> FRAMEBUFFER_CONSOLE is not to avoid the following warning for this case
> 
>    WARNING: unmet direct dependencies detected for FONT_SUN8x16
>      Depends on [n]: FONT_SUPPORT [=y] && (FRAMEBUFFER_CONSOLE [=n] && (FONTS [=n] || SPARC [=y]) || BOOTX_TEXT)
>      Selected by [y]:
>      - EARLYFB [=y] && SPARC64 [=y]
> 
> by allowing it in the same manner as is done for powerpc in commit
> 0ebc7feae79a ("powerpc: Use shared font data").
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> Fixes: 0f1991949d9b ("sparc: Use shared font data")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402241539.epQT43nI-lkp@intel.com/
> Cc: "Dr. David Alan Gilbert" <linux@treblig.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>

Picking this up to my for-next.

Cheers,
Andreas

