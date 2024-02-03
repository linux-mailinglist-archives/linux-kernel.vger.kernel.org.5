Return-Path: <linux-kernel+bounces-51269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D3784888B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BC651C21C70
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192865F561;
	Sat,  3 Feb 2024 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="dAvweoYY"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963D85DF31;
	Sat,  3 Feb 2024 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706988612; cv=none; b=nbBwkza8YxjG6ohpSdW2mtJiuYoV9tIwlEahlmoRhPvfNg7iU/ZtJBH0aAkjM/ZNxrsUrOodPO4D0Ey9mnQ4zBpHPeIsDl3UyagFjY7irthzfRZGq8KzPtjagpmym2ovMFkHXj7yVIOH3CP6hlcLcLBqoIbzsRo4BgA5zbka/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706988612; c=relaxed/simple;
	bh=LB+tEP8N9nouNEotQM2sUzLKU7fiqJotlHQx9XCpmTA=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=HsBP3II1EbhuOmoT2IomGfpDBZWnXuIsxTbXe9NmxU7xrpje/PigfwrvoYNNPnq3pAjhF0KtaVJ9jIKl2OT3akJ/8Obp5lb+NG0XcxyXnYtF/CrKCsds20fEYkpiSWkYnJBilRKME+8SNCMy2NOs2GMgUp4a77s2iAqa2tDdhuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=dAvweoYY; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706988607; x=1707593407; i=rwarsow@gmx.de;
	bh=LB+tEP8N9nouNEotQM2sUzLKU7fiqJotlHQx9XCpmTA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=dAvweoYYOhxF3KLK+5pQdcdlNJ8mP6B6yfo+TcqwRGVfFcVdh4OdtaAmNO2wm3ON
	 lb4IFNvj+1bAWUi9Gh6r/CJyCMl+ETGlsHRZymSutG0MlrvNJfMjQmurl4KVFTG1+
	 5C3ZTuZx9PszGOgNO46FFptUqauK2q80ESDYO6eA1CD15tMIbDAamBfSbjulTseSt
	 F/O0myJ4J5LCwV8xi2W2srKcUwknt9o+7KLzPEhB4Jnm3VDnw85bZqN1Ymn3jdSGe
	 3QG8KBIBqAe13DzecYb8iLxIzN4wp+xu21mpQlMn1aAmQlIf8vW4h00Mlxvk7S/ev
	 pZp+UI5JY7jwTkqZvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6qM-1qkxCE3RM4-00lUMI; Sat, 03
 Feb 2024 20:30:06 +0100
Message-ID: <6719bb63-7857-4da4-8f18-a97602c1e27a@gmx.de>
Date: Sat, 3 Feb 2024 20:30:06 +0100
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
Subject: Re: [PATCH 6.7 000/355] 6.7.4-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Gpo9SfqyDCluo+siy/hrFZ8+HNAwSxQ9+rVULhZwYlaqBnW8jZU
 TVC2Kq7P4y49mnxnWQcsj0cj4HyIwl7w7CCfPcjDvYD0Lni3RI1xul2HDmQN8v/mcB6ZetK
 nZf6i1ay3h+xfPQG5ZqZpyWBfPgZH9hfbQDo/pp1/VHbny66/4H2WNm9o1tHTX6yURTORFX
 ttInVYRenc4+Yk7zPTMIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MQC/wcCccdQ=;wFM8+KvGjKIPfbVh7f8seU16bRw
 Fn3jP79EdpE1w/vR5QLbztMSsJErsNM61j29/f5SJB0JjofnCQqYOViGpGEGB9QjxCR1HWt+r
 5pXf8Cg42dCxww4ZVS+wM7kXKFSId5tqIdUIVevL+G/UwgDHI6otM0U/DJO9lpDb/VMSZkK5x
 2CwQymy8c1+F8/Ddd+9olDVva51bP04B8AxbtA87NanF9lpq36YgWtGI0+a99sn6k/t+/pKlH
 MSFI6mQG7SwTqCd6qJckm57vot5m249UuQQelAgPEcfAuemK6RWv6V0ebdwryd5jdgyaN7Xwc
 77wWoyXvcdFv7vfJu70ZEK+uBV1m3hil/BiwwDODRTUPUcd7yVPlmBjqAiNcgRqB2lNHuuRHn
 8KsT0ltgyTeM49uE2X7Ddce2LLmCo7gD6NuY+hSetcSG5zhtbCBQmSNZuGKZtmlcie0PydhyX
 gTpaFuw/z6xBprPjzLlq7nfR+I7GBARwO7fWlZIWh0s+X6iCA9gHpV2yeISQgMIQ2CCd/8mo1
 9As5FrEfQNCCTBUx86z9+D+s/gPx+V8/A9V73RlECy9yTyN9jf+ahz0+Jo2VHYMFE7sgZ7xkT
 mAiBiVR7ohG31oec1zMIDJiWUenQpoPjiwLFrQTu4VSIOiA0od1lnlwc8Kw8CjVdPS7a8msDV
 VTL+tTJgRAQRlTTRFuNnltoJ8fpTALDidW5YoefV8U1M1CkZrJr9wtvu24QdpEafXPD0kgU3+
 kDOMZBdvyq33DXXNXnPzIphOyTgDrgAH2JFDxJ6B4ElcUjZc0KW26rLZHRn5uwI5Bi0yU37po
 uqehQpKB9j/nPY/b+ao5s3zvWhBljb3o1//UEmBr2CFMo=

Hi Greg

*no* regressions here on x86_64 (Intel Rocket Lake: i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


