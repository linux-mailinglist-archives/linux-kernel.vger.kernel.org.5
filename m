Return-Path: <linux-kernel+bounces-7290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CAA81A4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76AD11F27175
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECE1487B0;
	Wed, 20 Dec 2023 16:23:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23627482DB;
	Wed, 20 Dec 2023 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.27] ([93.228.83.231]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N62mG-1rE1Hf1jHk-016Nlq; Wed, 20 Dec 2023 17:23:15 +0100
Message-ID: <30cf5b62-4b4e-49d2-910a-5f8cd824c599@tuxedocomputers.com>
Date: Wed, 20 Dec 2023 17:23:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thunderbolt: Reduce retry timeout to speed up boot for
 some devices
To: Greg KH <greg@kroah.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231220150956.230227-1-wse@tuxedocomputers.com>
 <2e00a0dc-5911-44ee-8c50-a8482eb44197@tuxedocomputers.com>
 <2023122012-spruce-unsteady-e187@gregkh>
Content-Language: de-DE, en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <2023122012-spruce-unsteady-e187@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VnzeexlXxtn0dqGC3DkGchGf4sqU6cd7AkK7XQctWYheV28WKkY
 BZu+eZ4l+Wu4j/q0VLBKoDLq/DyVsiJc9IHpFmUZxKjpxOHzloGeB7Uu7jQMV6suhjXSibA
 F416PJhRzqOAy+rW21VhhPIeioKR2FEmW/q100HzG81Bn6r86Ra7XcjGN7Va/Q7Sxh+Q9nI
 OzluoOruct+ZHC6/7vivA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8vA4dr7eehw=;rqTdw6uheFbOEgNsEAuSw5I28Kf
 O6uRBwRxDXkFZolDsex7c2JxunLtJIS6FhqEgZf5I02DqkYJpKYNItFJEEK7mrbVWAQZRbyri
 YK99k/XsQyVLe6C0vPjQUT8MmCUbiEBuNtUfH4RocVFo95P/Z3sfFz4sOl2/ARsZQpqwlYfeC
 hEpXHBoHKWyRnJkuLEWgooCVSKV105s/+hzTeHYruMSAI1Bex4nzMXd2+QO38R+We0jInYf0X
 4X6IrIEyJADW2hl5YBZ129TNDifHokinC4gHq2UgmAFUaAM0YhzEWhrw+12Uz9hbQSSiG+H0a
 c9bOhd4LaoH3JbVOYBVM+Fd4PwJIcU1vOUNdFMiQkTqCO33UnsmDDdCiUmEk1NVQjcjMMiCNi
 NCeBPP145hxqwX+H7yNgF83rFbNHuEhzwkAtXnVhlvXuX0l6LSWNNPx0diSrp6ifNaAePyL9O
 ED9BccCeJxtiEU206qtfaJKtFcfoIW4NXlZ8T9yYi8LY3PuXm+glwBi3d8R7pnLuZFrLONyI3
 Ukrerg5NbtBBC50U8hkq8wO9kzTNXx29qP4qEOvUuwuQBzKCiXjGH+9wjHpswgWTmj2b5pQWg
 VrWpXJQaSzGtfwZhsFEaleY584UgmVc8DHMdBiD4CrzaAPwvne4shDm0SS7snrwho7pS8glNh
 UsBOI0E4EVEhczhbG14yjReekaKV4+xdZ1zg1F+DX1THmzL0WJYc5WpzBkRSWWurAEcCYB7eV
 pTwc2D4hQ4zR4Cq8YtZdAnXIEplTnx8wsb5OXrXCWySFh89BDGOAAhRcDQCLfSGoNEXQH9ND2
 jQo19ozu8yj/P6Y/vZ2EEntNA/jwsKb9uDDgn7XaT9BBUHKL/VSbpAJGu2PLb8Pkqg2NPUP4S
 AvUepFbNVzDvFog==


Am 20.12.23 um 17:04 schrieb Greg KH:
> On Wed, Dec 20, 2023 at 04:23:15PM +0100, Werner Sembach wrote:
>> Am 20.12.23 um 16:09 schrieb Werner Sembach:
>>> This is a followup to "thunderbolt: Workaround an IOMMU fault on certain
>>> systems with Intel Maple Ridge".
>>>
>>> It seems like the timeout can be reduced to 250ms. This reduces the overall
>>> delay caused by the retires to ~1s. This is about the time other things
>>> being initialized in parallel need anyway*, so like this the effective boot
>>> time is no longer compromised.
>>>
>>> *I only had a single device available for my measurements: A Clevo X170KM-G
>>> desktop replacement notebook.
>>>
>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> I wonder if this could also land in stable? Or would it be to risky?
> If it's really a bugfix now, why would it _not_ be relevant for stable?

Because it changes a timeout that could cause issues if set to low: This 
Patch sets to to 250ms. Set to 50ms it causes issues, currently it's 
2000ms, 2 people tested that 250ms is enough, but i don't know if this 
is a big enough sample size for stable.

The advantage is significantly faster boot time on affected devices 
(~12s down to ~3s), however they do already work fine without it.

Kind regards,

Werner

>
> thanks,
>
> greg k-h

