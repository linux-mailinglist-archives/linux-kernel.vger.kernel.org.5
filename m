Return-Path: <linux-kernel+bounces-126166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D5389330B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0521F261FB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4EB14D71E;
	Sun, 31 Mar 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GV1ze4/b"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3B314532F;
	Sun, 31 Mar 2024 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902455; cv=pass; b=IU67PKO9XdMrjAK7os3Hp5aJeB0yz86gsr/RLuK0wDuETAEVljnCx8zbyV6+3xl7DFyMEqL3Yu5+WSCJw3hENtMpXdMgVCtIRRutM6smRaW7R2lr75JwOd6stffNn8yr+v7Wb7DydzR21m6jReiUMqiXi6MiUEkbFac0zzCSSZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902455; c=relaxed/simple;
	bh=Ns/3qZvk6Me7y5ToeEB/QaAzO9OBzvqWe05LErgFeME=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QvOBB+k749avdJ+iaBXY8L0sC0fnCOGTSAUcErG/dzfgvp3DbPVPL0nmYj+UF6cwm7K25m5UF0/BEgwFmSuzTjDAZcMspjHaUe96UNfPDg/Am05iFEngy24D3FFyfXMQchQp6uFIkcPXbRLpwt0IbJ9eroxBvyTuyQZqDdIzhnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=fail smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GV1ze4/b; arc=none smtp.client-ip=205.220.180.131; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=quicinc.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5A73F208B9;
	Sun, 31 Mar 2024 18:27:32 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ft6H1CjV8qCi; Sun, 31 Mar 2024 18:27:31 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 60B02208C1;
	Sun, 31 Mar 2024 18:27:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 60B02208C1
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 52E31800056;
	Sun, 31 Mar 2024 18:27:30 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:27:30 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:50 +0000
X-sender: <linux-usb+bounces-8669-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAL9fp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBvAAAAm4oAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 24610
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-usb+bounces-8669-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com A5E902025D
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GV1ze4/b"
X-Original-To: linux-usb@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711806404; cv=none; b=PRurmsWyDKad109HsbgKEUxlNZ5muTPP2EUI6gbKerhmX8xRq+vhVJj645342XrQ79TcR62BMaPRCNobetjitOXD/HaefdR1brXHz1c1gQ0eAzEFMdDGylsRE8MbdjyfNWIRqMxCI6pLHQX1ZGzzz5ccxBuuLGM7nIGSe3mffwY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711806404; c=relaxed/simple;
	bh=Ns/3qZvk6Me7y5ToeEB/QaAzO9OBzvqWe05LErgFeME=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IevWMIu+6JH6YGWVlA+zAzvV6ltO79Jyuh7WxBaNMxDaVmtNA8Zxx5Pb2vdrgRHhPOuXtdbSl3HEk5pM3i6C5gV2xwDM3kROsApDDia5YO7iY5LAGLnl8TOQSaGaw8vXOLxDRsAjHCbmH31TuD1SM5X/h+XzUjyUCn33b+V7Rg4=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GV1ze4/b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SVWFHV4sqPFX76VmpS4jxlnWZQYsLMqwWZI1Sedjiao=; b=GV
	1ze4/bvO54xknN6187ZJoKwvSkJrP1fqKpvr4ADOWvevrSjhHPar1y8mcA8Twwhc
	xD4abPcm2FjyqM32o6qCDmE9lqU0v7vUJEQnlmf1XJzGBFnD6imcS6k5S4hnNtvs
	S4I1p8+TaIEAlIvEojW6pwPMzKmaG1V8mIQiUMPcJsenDIgeCzvy3foYXkpMUHng
	07Ym5vkEdaBnThnaQMY+RnJhiM8uDCoOiPlWb4y+cniaP4cNaWZHEBuOvByzDSik
	eDcgPwrVKailgG8FheazZUQMh0ZVHtaV1v4fGkvhrN7NE40uDPiP2vYHWPdl3RJ6
	JLulBlELV8AFumUTY+4g==
Message-ID: <44bc6ea4-eba9-4b80-bb07-3b744eb7cce6@quicinc.com>
Date: Sat, 30 Mar 2024 19:15:57 +0530
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Add gpio-usb-c-connector compatible
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Miquel
 Raynal" <miquel.raynal@bootlin.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Bjorn Helgaas" <bhelgaas@google.com>, Kyle Tso <kyletso@google.com>,
        Fabrice
 Gasnier <fabrice.gasnier@foss.st.com>,
        Heikki Krogerus
	<heikki.krogerus@linux.intel.com>,
        <u.kleine-koenig@pengutronix.de>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20240329071948.3101882-1-quic_kriskura@quicinc.com>
 <CAA8EJpqx+VFW8z6oG=+pnhPN97Q3R6z+ygf85Uspve-9syQsUw@mail.gmail.com>
 <6f2df222-36d4-468e-99a7-9c48fae85aa9@quicinc.com>
 <CAA8EJppa4hVBSenLgxc5MYxTfzPPf4exHvh8RWTP=p8mgB_RCw@mail.gmail.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CAA8EJppa4hVBSenLgxc5MYxTfzPPf4exHvh8RWTP=p8mgB_RCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i-7mgUWTKegtutg-30OaQLWt41ipl3Tl
X-Proofpoint-ORIG-GUID: i-7mgUWTKegtutg-30OaQLWt41ipl3Tl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-30_08,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403300112
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10



On 3/30/2024 7:09 PM, Dmitry Baryshkov wrote:
> On Sat, 30 Mar 2024 at 11:13, Krishna Kurapati PSSNV
> <quic_kriskura@quicinc.com> wrote:
>> On 3/29/2024 6:23 PM, Dmitry Baryshkov wrote:
>>> On Fri, 29 Mar 2024 at 09:20, Krishna Kurapati
>>> <quic_kriskura@quicinc.com> wrote:
>>>>
>>>> QDU1000 IDP [1] has a Type-c connector and supports USB 3.0.
>>>> However it relies on usb-conn-gpio driver to read the vbus and id
>>>> gpio's and provide role switch. However the driver currently has
>>>> only gpio-b-connector compatible present in ID table. Adding that
>>>> in DT would mean that the device supports Type-B connector and not
>>>> Type-c connector. Thanks to Dmitry Baryshkov for pointing it out [2].
>>>
>>> USB-B connector is pretty simple, it really has just an ID pin and
>>> VBUS input, which translates to two GPIOs being routed from the
>>> _connector_ itself.
>>>
>>> USB-C is much more complicated, it has two CC pins and a VBus power
>>> pin. It is not enough just to measure CC pin levels. Moreover,
>>> properly handling USB 3.0 inside a USB-C connector requires a separate
>>> 'orientation' signal to tell the host which two lanes must be used for
>>> the USB SS signals. Thus it is no longer possible to route just two
>>> pins from the connector to the SoC.
>>>
>>> Having all that in mind, I suspect that you are not describing your
>>> hardware properly. I suppose that you have a Type-C port controller /
>>> redriver / switch, which handles CC lines communication and then
>>> provides ID / VBUS signals to the host. In such a case, please
>>> describe this TCPC in the DT file and use its compatible string
>>> instead of "gpio-c-connector".
>>>
>>
>> Hi Dmitry,
>>
>>    My bad. I must have provided more details of the HW.
>>
>>    I presume you are referring to addition of a connector node, type-c
>> switch, pmic-glink and other remote endpoints like in other SoC's like
>> SM8450/ SM8550/ SM8650.
>>
>>    This HW is slightly different. It has a Uni Phy for Super speed and
>> hence no DP.
> 
> This is fine and it's irrelevant for the USB-C.
> 
>>    For orientation switching, on mobile SoC's, there is a provision for
>> orientation gpio given in pmic-glink node and is handled in ucsi_glink
>> driver. But on this version of HW, there is a USB-C Switch with its own
>> firmware taking care of orientation switching. It takes 8 SS Lines and 2
>> CC lines coming from connector as input and gives out 4 SS Lines (SS
>> TX1/TX2 RX1/RX2) as output which go to the SoC. So orientation switch is
>> done by the USB-C-switch in between and it automatically routes
>> appropriate active SS Lane from connector to the SoC.
> 
> This is also fine. As I wrote, you _have_ the Type-C port controller.
> So your DT file should be describing your hardware.
> 
>>    As usual like in other targets, the DP and DM lines from type-c
>> connector go to the SoC directly.
>>
>>    To handle role switch, the VBUS and ID Pin connections are given to
>> SoC as well. There is a vbus controller regulator present to provide
>> vbus to connected peripherals in host mode.
>>
>>    There is no PPM entity (ADSP in mobile SoC's) and no UCSI involved
>> here. Hence we rely on usb-conn-gpio to read the vbus/id and switch
>> roles accordingly.
> 
> This is also fine.
> 
> You confirmed my suspicions. You have an external Type-C switch which
> handles orientation (and most likely PD or non-PD power negotiation)
> for you. It has GPIO outputs, etc.
> 
> But it is not a part of the connector. Instead of adding the
> "gpio-usb-c-connector", add proper compatible string (see, how this is
> handled e.g. by the spidev - it is a generic driver, but it requires
> hardware-specific compatibles).
> Your hardware description should look like:
> 
> typec {
>      compatible = "your,switch";
>      id-gpios = <&gpio 1>;
>      vbus-gpios = <&gpio 2>;
>      vbus-supplies = <&reg-vbus>;
> 
>      ports {
>         #address-cells = <1>;
>         #size-cells = <1>;
>         port@0 {
>            endpoint {
>                remote-endpoint = <&usb_dwc3_hs_out>;
>            };
>         };
>         port@1 {
>            endpoint {
>                remote-endpoint = <&usb_uni_phy_out>;
>            };
>        };
>        /* No SBU port */
>     };
> };
>  > Note, I haven't said anything regarding the driver. You can continue
> using the usb-conn-gpio driver. Just add a compatible string for you
> switch.
> 


Got it. So the "usb_conn_gpio: usb-conn-gpio" in [1]  to be replaced 
with something like a "typec- " naming convention and add a new 
compatible to gpio-conn (something specific to qcom-qdu) and use it in 
the new DT node.

Thanks for the suggestion. Is it fine if it put the whole of the above 
text in v2 and push it for getting a new compatible added to connector 
binding and usb-conn driver and then send v3 of DT changes or mix this 
series with the DT series ?

[1]: 
https://lore.kernel.org/all/20240319091020.15137-3-quic_kbajaj@quicinc.com/

Thanks,
Krishna,

>>
>>    Hope this answers the query as to why we wanted to use usb-conn-gpio
>> and why we were trying to add a new compatible.
>>
>> Regards,
>> Krishna,
>>
>>>>
>>>> This series intends to add that compatible in driver and bindings
>>>> so that it can be used in QDU1000 IDP DT.
>>>>
>>>> [1]: https://lore.kernel.org/all/20240319091020.15137-3-quic_kbajaj@quicinc.com/
>>>> [2]: https://lore.kernel.org/all/CAA8EJprXPvji8TgZu1idH7y4GtHtD4VmQABFBcRt-9BQaCberg@mail.gmail.com/
>>>>
>>>> Krishna Kurapati (2):
>>>>     dt-bindings: connector: Add gpio-usb-c-connector compatible
>>>>     usb: common: usb-conn-gpio: Update ID table to add usb-c connector
>>>>
>>>>    Documentation/devicetree/bindings/connector/usb-connector.yaml | 3 +++
>>>>    drivers/usb/common/usb-conn-gpio.c                             | 1 +
>>>>    2 files changed, 4 insertions(+)
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>>
>>>
>>> --
>>> With best wishes
>>> Dmitry
> 
> 
> 


