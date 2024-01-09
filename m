Return-Path: <linux-kernel+bounces-21170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E164828B30
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FA81F25860
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AED3BB46;
	Tue,  9 Jan 2024 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="WAxrlsla"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131833BB2D;
	Tue,  9 Jan 2024 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1704820900; x=1705425700; i=wahrenst@gmx.net;
	bh=I5j3c1xtyvcY6yHIxzxP6AHvUQ/haNIG8AbnATZ4xCE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=WAxrlslaE2YYEuXqL1/wJfm1+Dxv/TiO56+OyZ0t9szNluOsOK0K9y4K8yfmTXpC
	 IIZqAYJqPNOL+W/FcIvt2YTfUHpmguktJjaJ+rH63aa3Z3BWFwpNRcPOYwfjBO3Gd
	 ao7fQ/FXBCFH9knQKgA+3qUupRGYNrpmCYvLzYPFfc5bPWrwM/KX0ZJvxJ0TiMUb0
	 ZUNvf04ZM1PZ1SvPkW4iAsebVa0zk217ZnOL9oHhIik2QsXj3kZOb2/VKXLqYdtMV
	 noBjFLatRkBD8wQaLJXRl2p9DptOW+pliQNrd0naCVEA/7/ULaUCblSHmtBECMeDs
	 IDMcTSWDM0ejpnkCbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5rU-1raXUS1mls-00M2J6; Tue, 09
 Jan 2024 18:21:40 +0100
Message-ID: <bb87cc98-ee9b-46b6-bf24-6aa69af1e0e5@gmx.net>
Date: Tue, 9 Jan 2024 18:21:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add waveshare 7inch touchscreen panel support
To: neil.armstrong@linaro.org,
 Shengyang Chen <shengyang.chen@starfivetech.com>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: quic_jesszhan@quicinc.com, sam@ravnborg.org, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, dave.stevenson@raspberrypi.com,
 thierry.reding@gmail.com, changhuang.liang@starfivetech.com,
 keith.zhao@starfivetech.com, jack.zhu@starfivetech.com,
 linux-kernel@vger.kernel.org
References: <20240109070949.23957-1-shengyang.chen@starfivetech.com>
 <99d7bb85-17b0-4b5e-a6cf-f5957ad92298@linaro.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <99d7bb85-17b0-4b5e-a6cf-f5957ad92298@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hDBW/55DqECknzawCAINwLhUiuFTWNMFk/5p8eDm1ZUOMTxJDoQ
 vlDfvRTRH0WtzbVAtorQN0ZTWd8ThqzdOPm+SFTdNcjbG+04zcKXoYx2cD6Mi21NiGg1+pl
 4F2psVbZ8sKedzbSl92Rxgf0c52dEb0rGjpb3heAjHNES0zn9a1+BwjSTAIaR9trGo8fz+U
 /0jvABs0d+eUBRf2KEWhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WzN29zLtn2I=;arJuGjhavmEGEFcpXN9wlSQM1X4
 GcL/1e7F2z6s6HSUFBjtyxsJSfoXk2tqyzMSM2zgVzS8qjm+qgirPySj3axeU4uS45cr6LQsg
 ylk9bqtVE1/LcnhHBVdcIOCN7h2vAghw7r07bKYJGvO9QR823EHygWvs4CyhK3OCJv5wZ82et
 HG4DE6fndf2C4+U22pm4ALomSsoJVRJvbmR+/fFsyRkKXpzgJpd/tOOAuMySfa1vqan/pOi7k
 JKAVDMaMPxiGXn3YJozasFnPSa1JybzS+GhyoiWauzAr4HtuV28TJ5yGETsRNk6r7fgxd8nhj
 vR9yvJpOJ/ekPY6Rn6T2I8ejdECvQf7C+RvrizRzFCOHY0ZzZE7ovp40/6C6SbPRpS5nhf+c2
 KM2hO6u/twsEclS2UqBhy7UwhFJUSw6fUxEIsPtOlUpxRcIpRqfS/lQCYNr4VtF6yHbTx6QAu
 PEvySfdV0qxkbM/8HZab9zRnM7pYoHq32zRlZi23pQnjZzHc2TALOjgJ6fnR1ENsJlweJQ02x
 WoFG/ad8YzLMVDb6BTp97E6XemH4NO74nzRI5qaohJB4omKIb4fIKsD8fPUjHhYYpJaslnNgt
 Tkx1WSi93rGY+3afLXzBpUl/ghcp+OioKM9ncZwgTSNoI4HYC5B8/g7m9OKS9iHxhjvKEQU9V
 xxGLzhun0B4su14Rfl2NF/IfD3oxAJ1KUfxMZfMC6dmvXkyMGF41OyFd8c35KMNW+HJkAMr2v
 BoVTt5ZmKW84umdCyMt9jhnJfWP0icRi0yWm4SowdVA7mKg8YX7djVyKX54/MVOxCNkLBbeF/
 R5Jlmt2k6E9DDtyEUGVUFWTNDwQdEjY1wJgESq3V4/UFuwbm8uBK5YeJCpfUEqtLYChKAw48J
 Bl/aIILgfJFTh8dXqa7ePW8SRvN5kkcH5ElnvDo5W6Zqmt437MziwtU3hkVz07O9nRDNFnYjA
 aAEft4cQdnCBdUbXlhWhO9bQLKw=

Hi Neil,

Am 09.01.24 um 12:19 schrieb neil.armstrong@linaro.org:
> Hi,
>
> On 09/01/2024 08:09, Shengyang Chen wrote:
>> This patchset adds waveshare 7inch touchscreen panel support
>> for the StarFive JH7110 SoC.
>
> Could you precise which SKU you're referring to ? is it 19885 =3D>
> https://www.waveshare.com/7inch-dsi-lcd.htm ?
>
> Are you sure it requires different timings from the RPi one ? In the
> Waveshare
> wiki it explicitly uses the rpi setup (vc4-kms-dsi-7inch) to drive it:
> https://www.waveshare.com/wiki/7inch_DSI_LCD
i don't have an anser for your question, but the Raspberry Pi vendor
tree use different timings than the Mainline kernel:

https://github.com/raspberrypi/linux/commit/222b9baa97cc4c880d040a8c6a5da8=
0d6a42c8e8

Additionally the
arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rpidsi.dtso suggests
that it uses the Raspberry Pi 7inch, but uses the timings of
powertip,ph800480t013-idf02 from panel-simple.

Maybe Shengyang could test these timings with the Waveshare touch. At
the end this rely on a proper implementation on the underlying drivers.

Sorry, for adding more confusion.

Regards
>
> Neil
>
>>
>>
>> changes since v1:
>> - Rebased on tag v6.7.
>>
>> patch 1:
>> - Gave up original changing.
>> - Changed the commit message.
>> - Add compatible in panel-simple.yaml
>>
>> patch 2:
>> - Gave up original changing.
>> - Changed the commit message.
>> - Add new mode for the panel in panel-simple.c
>>
>> v1:
>> https://patchwork.kernel.org/project/dri-devel/cover/20231124104451.442=
71-1-shengyang.chen@starfivetech.com/
>>
>> Shengyang Chen (2):
>> =C2=A0=C2=A0 dt-bindings: display: panel: panel-simple: Add compatible =
property
>> for
>> =C2=A0=C2=A0=C2=A0=C2=A0 waveshare 7inch touchscreen panel
>> =C2=A0=C2=A0 gpu: drm: panel: panel-simple: add new display mode for wa=
veshare
>> =C2=A0=C2=A0=C2=A0=C2=A0 7inch touchscreen panel
>>
>> =C2=A0 .../bindings/display/panel/panel-simple.yaml=C2=A0 |=C2=A0 2 ++
>> =C2=A0 drivers/gpu/drm/panel/panel-simple.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 28 +++++++++++++++++++
>> =C2=A0 2 files changed, 30 insertions(+)
>>
>


