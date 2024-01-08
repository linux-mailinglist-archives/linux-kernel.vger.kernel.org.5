Return-Path: <linux-kernel+bounces-19144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F91C8268B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C2C1F21D03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F09C8C18;
	Mon,  8 Jan 2024 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="cEMcvmCG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E58BE3;
	Mon,  8 Jan 2024 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704699453; x=1705304253; i=deller@gmx.de;
	bh=XgElwOJD6e4nyDVLhR8tkMhPyt8Gjuugn7w7UEWYGds=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=cEMcvmCGOZ1PNiYT6U3GyhenWjt/JQiMAbBhBBjPnGK6Pn1tfwcGR2fqZHxF3FSr
	 PE1/4Hlv7OmZ8B0Nw1dGLn+XWxJYnNHr+Ee2X6vcmWRId6yjvk7cuJpoLe69Vx46b
	 fwque85QEw6G86nv6y/nXQivwHBY7nnjYV+5erdCwVxSMkLfyxsmKUFEaP/Lu9w3P
	 WKkYDE6fBYYZrHS+xWiAmSANkxZj7ZJFFK+cAvRw/n7lbO27ZDfMj1rnKkrKQcztJ
	 +3a3GAN0Ee6UOtc7am55j8weyVPfinNPX/p8biMkInj466zSWyZi2OJTCdgiqDEVC
	 j5se660Is0ZeS5BjAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.148.84]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDEg-1qwAsH3C2C-00iEwU; Mon, 08
 Jan 2024 08:37:33 +0100
Message-ID: <b47068a7-473e-4b0e-9511-0d3f2afc4724@gmx.de>
Date: Mon, 8 Jan 2024 08:37:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patch in the char-misc tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240108135842.34543bb6@canb.auug.org.au>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240108135842.34543bb6@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HRUvsujthT/fFOI6JdjKGNCCR0Nv9L4HETnu/xjWiwDnk5fzMQB
 UJd3VVscduNdDQFD+9od6XnmkxlXM0BJgc63MDgyEHeNPrGhIqIuCbkzw1ZZGSA/8W9fFD6
 RmjFOfl/PrAptN3trRfTM1C7O7Pr1Sh88CoLy8OU0s8ZMn39V3SK3a/RooMMMgMYl6kzOQS
 XYQ/S8Rm6Rb1M5CAhmSnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PaqQDI8RUXI=;e6IMytBKTN2/3MXaeqzmzQFevyu
 9HWfVLdToA1LIRXP20wlDNGsrHsy4w9hCi+G0X/h0pRxjx1DLdAIc+ixe0t0tzfMOgpIFwknJ
 YEXdwhY2dNmHaNNDza0gN/by8UmXG22xTsHjgvL/osp2xe0zetBTTiVwYu2go20X5fMgT68Gv
 82NAWsbdFLtGpY4oIE236KBx6sx9/4O1YGL3BvjZMSJkSRO2JH1qJlab+mdxYttIamNQkgI4J
 +Fhfe08s4YdxAIts9/l4QFe6ZajHSI0umKyAtCrTZvdHl/sU4ArDY3UyxX72iUPfMZfsUdM8N
 mXFk8Pb6CTcxUAegP+HSYWYzZPIco/z/5Yk19q/tCNGDd6fPgIYIPKnB9o/KneF9UlUykLdwc
 K2dHncVHceRzLkKhYlpE6XSZgMsXI8rU/wfarIGmZqBXMIR19pzZwiR3s+CuBF/XopILuqyYL
 h4qSWOXrHaP8sq9t9mGdXEDP8wj4adqSzpsfntjncJtUPYl6PEv/J06oeJgNTy6Bq3XuwRbSm
 n69pZZQNbWWN0qtpSVJFkpER4qKN13EnbK1X0FhhIRMDioqmzBd9uf8oSbmg7PKbxB/MKRteH
 DcPau4VysMxB69KWGGDCEsiwtJROzp8o/Wj7vkFeZAbMgJwWKjQ7UveSn43/7ktFm9viI/h1J
 WI0S8tGejssbaekPdoflkOfOp3Am49MveRAIZH+lKqzCQ8+lEWBk413Je/K7gfcob+571TjZy
 zr6grH52qLzWyxdLPbnMNE5rs0gLxiFBCB0Frij3c+re+C0WBeFYt+pET+2LAQ8bmu1KcmP16
 M4Na+Zrk3B21HdtMemAxtsPs8v9jWH6zmMrUdJbC2Pe31vOoknm9z8qGqLqB6RT+Q3Y58u7fT
 T4pX9pyvDwhyBUk+Y1OgXLZQFQpauWR7yNvZgOIu9a1qymUpcHN+tboVEPGR8RsI+SvsxLrib
 06+faiaz8hOgwOvAlnEzWLDQznk=

On 1/8/24 03:58, Stephen Rothwell wrote:
> The following commit is also in the fbdev tree as a different commit
> (but the same patch):
>    110684d58bdb ("vgacon: drop IA64 reference in VGA_CONSOLE dependency list")

I've dropped that patch from fbdev git tree.

Helge

