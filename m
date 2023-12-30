Return-Path: <linux-kernel+bounces-13513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3970820787
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 17:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36611C213C3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AC9947F;
	Sat, 30 Dec 2023 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="HxONOoO+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C69474;
	Sat, 30 Dec 2023 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1703955463; x=1704560263; i=rwarsow@gmx.de;
	bh=XgIomNQU40rhAEDA8HFv5+/yl6BS6ns2p944vemrwgQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=HxONOoO+cHg3h7HMClzYuidxwLYoqYdMqjQH3zJ1BieHT7kFs2uf3KAAXE1CNlre
	 B6e7NP4qQgn1Pkh1zh02LjsXhmz4rg72I977wXdoTclUX+GwllXwzGzEHjhydbr9w
	 VyazeEdIAhtsp8pAueIdaP6WF9yxYUee8p3ZEWwauc3VCCGin2gS/hjl+P6GGC2OL
	 1LCNNTno7/3SESkq94JOe0ueIm/jwcWcSkQPYtpDr8EbTiCLU6IDS1/8gDToPEHWD
	 F0J8wCoucuUTDSl1OaSlhSucJ5JP9bA9Ptq0SpzR36o2gwPQFaIksAUMmdmXXGgqN
	 J7EAVIx6Je9VWSugIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.8]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRVb-1ricjk2EUF-00Xwwg; Sat, 30
 Dec 2023 17:57:43 +0100
Message-ID: <b3c10023-460a-4075-8201-0fdbcd819eed@gmx.de>
Date: Sat, 30 Dec 2023 17:57:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.6 000/156] 6.6.9-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:s3oiM48fWZpuDYRbDVnEDFrECHbus6xm51CBfOTqOJkThXdhNYM
 Lnp6bHWzNV7jMbRcxL4euxUx3j5XV2jCZrsBzBNrJGinKyxPWmagNnyupvznUnYxY3TCWZC
 oExgp2mvDz677ZqCe8fwj9frdSXAzUk2vcWLoydZ/pXLRecFv59Diw4Vh0fLooqlI4JpQUt
 0YdBgdqYl2XWH4GFYxy4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iO8pmD8+pKg=;Nbv6qloUPAxrgimdNdYGs++yRrt
 3kBRsXi2kR+USrRVpjfuxo7OcSo5/oA7jlfjDJLYV+SM4hOwvAz5hdujqQRIx85tH5pvgRIjl
 kZ5aF57GRL53AmRyylJNxgtjo2LOqFN2h7srtvsAtpWtVKA1Mj/EMVdXwAUezv78L/WP18b9D
 yU+croqOUzBO0Vr43tEardDEbN1RfzNCO3rqzlf3+GtTVYwi73BKBdno5L7JkaA3xf81amHtq
 0HyjSQ6KaaJadId8lXWub8iJgJkqaZdK6h17CfpPpl15OHYYaczp+yy68FeDJ+fRzU/2ktg4K
 EPOUWwMj7H/v2VsKLj0bgCUFXeGQGMSVvYnuYd7sF29MDQzkrdqezU0ceejWH4E3qCshwUNTD
 T6avH3YQ0X4N8HDX7KpJXf2TNZyTUGu0b4Gneauo+txFi4IO7NPLqMaIsudAkqpkztvp177m0
 AedrpgMOuux9qiLppR0E2mwWUUdifYh8eKZdu74ef6qihfN424aydhxHVyhLOuGICBUXGRfrQ
 HSKEeUEhlsCTfibypCbHIhT0DcfHI5sqf70Lik19zIJK3F5zp7rFRjRx0TucRbjxQgnFWkahT
 B7KYVyxuUd60wdL9eC8Rq5lLVlxh0oc541NnPVRgTyninY8DW8gPGbAw5ZL/mLoo/ZN56/Twc
 UdCiosLnGOdKGs2v7VVwHKJsou11GGljhnL/DpGN39p367XkwyhqonFXACUp+orW7qKYyBZ7J
 fLBrVdddz+ja1ld0NIDyZcD6TLr9LN/bspk6S6wn36kqTaC1R8fvHggwqRbOSOR4G1PgUHkf/
 6E7/4KT6OocZv9pLI8weDUqF6D9lK/WacJpCaJCFdLqxDaaBWtcHjkiS4hDdxXeSgnqT86/oE
 PmQH68sT9WqYsUPs5wPzsswexXWJTIK6Z02v7F5WzZpBjc+CifipRG6AB3BqXCSezKzhqKXGD
 xPj7Bg==

Hi Greg

no regressions here on x86_64
(Intel Rocket Lake: i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


