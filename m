Return-Path: <linux-kernel+bounces-7312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B47A81A57D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF1D1C2254F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A224779C;
	Wed, 20 Dec 2023 16:41:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A42447790;
	Wed, 20 Dec 2023 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.27] ([93.228.83.231]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MN4ux-1rYUNn3Ffp-00J4X3; Wed, 20 Dec 2023 17:41:02 +0100
Message-ID: <e7c768aa-a071-4590-ab1a-d80738dce1e5@tuxedocomputers.com>
Date: Wed, 20 Dec 2023 17:41:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Werner Sembach <wse@tuxedocomputers.com>
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
Content-Language: de-DE
In-Reply-To: <2023122012-spruce-unsteady-e187@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:v7a/9MqsnCsLif5BWEk/ZMGAjDsXXiQGUf/9WsnNHh5bBIctIX/
 sh0GAzrTJJ5yDY6OLqLWdQf0ljYrPSX+Kbx7qLznB7lKcUIOl6idRJpvFpsC1cg4e/IC0nW
 gSvk7tP3cCQbhI0jCffVcBanScGDs1Twk5swWyfpzIeTBjKqHEbCdzncxLO/skR/epie3PM
 +9lLEdxiaZVnNcROna/Zg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4hiWu3jNvpQ=;hslNdFe8czamRaRbtccpXgRqhdD
 +0bOFsXuFcBs21fksfmTggVhtpDaN17b4Sb8gQI5QvfNNFQRkWsda4u5YMf3htjJpij5DnTLy
 Y7i7f/wclrhCPbBOyoUDkGNQifrFXHB+5jWsHrR5c8AlZ3NdymYsl8BeuZTgiiCP7Z2nPQx9z
 nh/3xMP0e2b0X343bjsmPfknmXA6M4CpUdDxwDjyTUj8TA/vVuR13MDmdZ3bm81WnqO/dRD4h
 aN6W8csnzyIfE+NbDQXnH5f0w3JODtI5aj2JLt47Flxanlmd0yIDip4fFts0b06BUw0+ojwr0
 bGZz/ewfF23t71E1vJS6/flr8UfFfv9eeB+NSvfZabel6xu0STGfoddhHlGOkIsWsdCro0Bby
 3Y/2sfDipMj3vnf4Uh4xV7btBAXxM3nNCcpZBo3yvCy69pWR5vbKIJGJeiK+Lux6jG6HcKmTJ
 ENSvYuip4SnnwvYr6Y2lF+FmyVNLNyAxgZVf9Kd1m11Y006omSZgcG2Z5DHGjDD1lM63gO2hd
 WQn6RANVWBEnQSZ8g/xDhFe+wyOHxb6u/UK0U1Ml8+MHmOtNLnbarmML7RMMEtxKWprowUqs5
 Y6c1kDO60yTvalG4zcFO//kq0jipdTTcRQil8tOzB8HOtMXHDf+46zTK10/TaWkWPBV4gkvax
 8Go6IgjLhv8uXHEHir43san+cY40DY0i5DlC/8lR8Sz9bLQGCteZa+f6EXj5BAESH9E+8Q9+e
 Q0G7Kfj/5woD2t+axKjgMoxDV9njJJ5eG0EMIijxRrVVPBjxv7+lEXPZxez+YOmkh5cQR45qf
 fP1SCLWRtmuslFkiCacvE6xbr5q2zp6+DhMHYcX0BSUeVcxIA93ZETDSmXopasVRSU5E9z2lH
 o2xmocgbTZAq9Wg==


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

