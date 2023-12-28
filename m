Return-Path: <linux-kernel+bounces-12743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C41D381F988
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4711F24269
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE34AEAF3;
	Thu, 28 Dec 2023 15:15:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562E3DDB9;
	Thu, 28 Dec 2023 15:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF56C433C8;
	Thu, 28 Dec 2023 15:15:29 +0000 (UTC)
Message-ID: <514d8933-2b78-4427-88a2-56c0bd48f74b@xs4all.nl>
Date: Thu, 28 Dec 2023 16:15:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Update Wave521c Compatible for TI Devices
To: "Brnich, Brandon" <b-brnich@ti.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Nas Chung <nas.chung@chipsnmedia.com>,
 Jackson Lee <jackson.lee@chipsnmedia.com>,
 Sebastian Fricke <sebastian.fricke@collabora.com>,
 Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Menon, Nishanth" <nm@ti.com>, "Etheridge, Darren" <detheridge@ti.com>
References: <20231211205920.698939-1-b-brnich@ti.com>
 <4dba82cd7e264356ad66cf230c61dd89@ti.com>
Content-Language: en-US, nl
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <4dba82cd7e264356ad66cf230c61dd89@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Brandon,

On 28/12/2023 16:00, Brnich, Brandon wrote:
> Hello,
> 
>> -----Original Message-----
>> Subject: [PATCH v3 0/2] Update Wave521c Compatible for TI Devices
>>
>> Hello All,
>>
>> There has been ongoing discussion[1] surrounding the issue of having K3
>> prefix included in the compatible for dt bindings. This series removes this
>> prefix from both the device tree binding as well as the driver. Updating the
>> binding will not break the ABI at this point as the driver is still only in linux-
>> next.
> 
> I noticed this series has still not made it in linux-next. I assume this is because
> I improperly dropped the tags on the second patch [0] in the series between v2
> and v3. This series should only be applied before bindings make it into release,
> or the ABI breaks. Should I resend the series picking up proper tags this time?
> Or is it too late for 6.8 at this point?

This will have to be a 'fixes' pull request for v6.8 once v6.8-rc1 is released.

These patches came in too late to make it into our staging tree. (Christmas vacation...)

Keep an eye out for this, if it is not in rc3/rc4, then ping me and Sebastian.

Regards,

	Hans

> 
> [0] https://patchwork.kernel.org/project/linux-media/patch/20231211205920.698939-3-b-brnich@ti.com/
> 
>>
>> Changes in v3:
>> - Update example in dt bindings to match new compatible
>>
>> Changes in v2:
>> - Include more context surrounding patch
>> - Fix style issues addressed by Krzysztof
>>
>> [1] https://lore.kernel.org/all/20231201063309.tingjc3cjhsqb6r7@confusing/
>>
>>
>> Brandon Brnich (2):
>>   dt-bindings: media: Remove K3 Family Prefix from Compatible
>>   media: chips-media: wave5: Remove K3 References
>>
>>  Documentation/devicetree/bindings/media/cnm,wave521c.yaml | 4 ++--
>>  drivers/media/platform/chips-media/wave5/wave5-vpu.c      | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> --
>> 2.34.1
> 
> Thanks,
> 
> Brandon Brnich
> 


