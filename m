Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84E37E6CA4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjKIOsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjKIOsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:48:23 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676E53588;
        Thu,  9 Nov 2023 06:48:21 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A98DQRa012834;
        Thu, 9 Nov 2023 06:48:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        proofpoint; bh=G1+K+Mlo0/O15Za/BLzEfxh42M8Hcta/XNOPMk5jOgE=; b=p
        FVPYHCUG6JouWIvb4sXYVtv0VG1Bw/Mrpu2C7iUbYLK4ehEF9RMFP3HQs903Yuh5
        Yn6udBh468fgVi66H6JP23exJOVz1HV8KlQM4D7rYeuPXmYOF+dBo3OZWBKiJD6u
        QWv6H9TgceDbaeF4xyB89LOJ7iCSvvXEqcgl5DnebZpDLoZfAYYUheYq+TpXuzem
        Ac9YJiTr5PFuJIS3zLivsETKAH5PejHz8DMot8S6y1rxsx797UbyIQ5MqeVuws7e
        cofk9k7IsKUW8QubdJRodEuf0gv6s/rk5setSozgw1qwkbyejX7hK1bzCf1zLZyQ
        ufTJU5GjDIXpqgdKcDaqw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3u7w248yqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 06:48:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxEO/qlnYJ3RcMVL9XoigxCXr5GON+5ypWf7semHuxfIxBxsDtWhfmZl9YL39OODseuQZSsAy/smtSqZhF+N/y5rhfmF5+ttsXMAKvdKk0IS74YOrYCA4vNnHA4Da6NdcwO4YjpCwD9R8d9uwmwdm5NLdy9w3KEv0Y8FOI5cZAmTY4LCtVzat545K9ecAYL0i66jt78/j7KpzLppqK9+KUJJDJRHZIhBFtCh6FLugMQJDXI03eEy8RYqBiSXghTuXK/g9ccsAInPZfl19ILSZ8jdPG8NZP0ypKL2EOfMQyBJCuHSJOsiIkrPHurhHJtiaqlBmWgZ9JL6cTJ1PCXfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1+K+Mlo0/O15Za/BLzEfxh42M8Hcta/XNOPMk5jOgE=;
 b=YXro22iR7zruhT6Aar0/LhnuBUrCAgS0S7FxzQtEnsYDJyuOEPwooUtrPxcxxK/1Q1eGxNJpnAMkjyztKSGxjTb9WbtY7W21FvHKdLisziJLHSwKa065PNDYWZyHhYrNuuPWKSPCxa1kVOJnxTiFsBEFbQdjQdzpgNpzZJ8LXOnTWrbOrEWcnoHmJuUiGt2cQfHlr2Jc/vBLp/ccHkpQzE9TbdFXUmaJQdd+QKU7FMcUH+mgnK8OoSKT8G22VW72StDxZzGN+1zoom9d1snaqyPW+FsTE/hDmb6ZZzEj/wIXahcZzZ88HM8Wd/7xJ0Qgv09awkXfEsfeyaC+fsZQxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1+K+Mlo0/O15Za/BLzEfxh42M8Hcta/XNOPMk5jOgE=;
 b=vfqh324yBzR5SMfK94cSMchSLU48VJnwr6G8/4aEoGSaD8ukrrPvG2HPJH6Vqi1niBpdjCTm27LyXJd4OyHNvbKInBWb7RSzKlWD9KvToWLFDo41RttnQg2LrLrcfmfal6+DqDcvArZIkQ1hpN4OYM7y54sheubdfy2Q2FqUfs4=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by LV8PR07MB10023.namprd07.prod.outlook.com (2603:10b6:408:1ed::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 14:48:08 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::349b:3cfa:d8e3:df26]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::349b:3cfa:d8e3:df26%4]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 14:48:08 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: Fix deadlock issue during using NCM gadget
Thread-Topic: [PATCH] usb: cdnsp: Fix deadlock issue during using NCM gadget
Thread-Index: AQHaEiZr0BFSPbe58km6Ah0OXHLYHLBx+oYAgAAWWfA=
Date:   Thu, 9 Nov 2023 14:48:08 +0000
Message-ID: <BYAPR07MB53810A64B7DAB7CD20491377DDAFA@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20231108093125.224963-1-pawell@cadence.com>
 <20231109131948.GB48178@nchen-desktop>
In-Reply-To: <20231109131948.GB48178@nchen-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZmQ1YmJiZmYtN2YwZS0xMWVlLWE4ODQtMDBiZTQzMTQxNTFlXGFtZS10ZXN0XGZkNWJiYzAwLTdmMGUtMTFlZS1hODg0LTAwYmU0MzE0MTUxZWJvZHkudHh0IiBzej0iNjU1MiIgdD0iMTMzNDQwMTQ4ODYyOTYxMzQ2IiBoPSJHSTE1Zm16VHVVMXZqNzNSRFhacHJMWk5HcjQ9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|LV8PR07MB10023:EE_
x-ms-office365-filtering-correlation-id: 9fc18d57-0295-4c8f-14a9-08dbe132e36a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2J1bmGWD3+bMvEworUs1Ign4Oo7SKFejhhjgoRDmdZDD/S8adGNLr3bKPubVZO+G4tqNpV0TandAGBX3AZquclni9irjckhIBbD4qvGphTOI1LPsQMjA7jh/8w8A2dY9czj26aMq6B5oxDXrl3RpGYcVKL2rgraHG6NkUtBnknB8HtjLMBx3Dnhp8tU4ukGXTCYyU1qrg5oVcd9Ee9W3AFtriZ2x8f0/0Ojb9nPeerP/pw5BYkb3w+0+4Bwa+jecjggBT9JfGD2JUnL/ZsmR8d4JLcjVJz/GXOSGbiAyRy7S/Bv49n98zJGegey3f3S8PSsY2ewekEuKQY0vwYUpnUGOEHR2HMDBSXMyLZv9EtqZrg6TTZqchRTAdRCFszBnf2b/BZcmp7RJs9T8b1Iwd+8lxhcokf6dCASy3mLfowk8m9kMthKSsZK+armRrqq7X2P2Jg5ANBYfZAVkx10tsZgmwwIkJ3SOPSXsUAvzYXDLLe1YtPmQ/J2YgmiOKzSA6RkHUayaYuWakAWu+1IU42evQOZyf6FGuMEjSM8hQuV91+mqsFKQ1bOukPsw3pqVhOghbotGx2pC8u/GWZl/a0g2Zvw0SuqYPHVixcnrWqs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(52536014)(66446008)(5660300002)(54906003)(76116006)(66946007)(316002)(64756008)(6916009)(66476007)(66556008)(41300700001)(8936002)(966005)(4326008)(8676002)(478600001)(55016003)(2906002)(71200400001)(7696005)(6506007)(33656002)(122000001)(83380400001)(9686003)(26005)(38100700002)(86362001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?trDBkfHt4yVBCNFpHkyFDZzB3EMYpyrjeFJG801wz+s04X3qGQVxmHMJZTge?=
 =?us-ascii?Q?jaZ1HV2CAAuxInumwtxRCuNMxFA/mZFmXpky9LdvacsKvrqp6NMQ2PCUm1GK?=
 =?us-ascii?Q?mNFsSfKNATLSUaUb5ZJimv42+8ccrFYMVBABrhGowdn1faxB3UmDI8RPxFx1?=
 =?us-ascii?Q?LrkUFbcaSCsR2/ygqvogQlpV+Bwvv77QHm6psQgDbvsHJVQxyfshrytwyfA7?=
 =?us-ascii?Q?051oap62fukZFuzMQOsmAnra4U+ns/wlOUvoP6gTZVfVHpJCY5Ks+2aFVs2X?=
 =?us-ascii?Q?BLCnSZxdZ8ShmJ3l23+jU4oE0ODLvyA8jDUHqD+m275wQicsWBaNjbwwz6BM?=
 =?us-ascii?Q?MNleQBmREK3A7Phd+hE8VVHyMvurICr3AEWOmHMJwq057g0efYT5nZCm5kbF?=
 =?us-ascii?Q?HRZ9g6X4BwQWlRaFBOjWsSujcTJ3A/sgZpEX11kP8xIQEUJJrVye38EZ+1gO?=
 =?us-ascii?Q?AYiC0QYBbHz6OOaoEpvOguuc0VQYvYIyxZZ7SqStAkZeDyqhCvN6AwDu251+?=
 =?us-ascii?Q?sXiWJouw/J6tEAsh9nXOe6c6QKKX/4OH6xPvBCgKYd7KWySexYOEtrVMbHjs?=
 =?us-ascii?Q?w0ka52jnCMmsjulnCFfRPShgY0RguvbU4OWpEeeZMGTUavNYZesFsfxNlBxN?=
 =?us-ascii?Q?iEoHUe0I8sHwmqPi0Kg0kC8RFf0Qt2uDecAoHvQYYIeRIe5UIHAlDlS1fD2s?=
 =?us-ascii?Q?SZ7hPR5meh8Bxu/ByZT8Lw0i9tbK6xcaBEpikPoUM/h33NAW7l6u6mXYF/ZN?=
 =?us-ascii?Q?8900P913/8T8pgR4fraWMKBZpsA6Fme5uiuIvl05I2sGYvdo+lmWabceM3oq?=
 =?us-ascii?Q?stM1lEacu/1LVK/1GFUFoh9nctuyKoP7k0Ad44yRtXsE3IMx+su8KTkf6g8q?=
 =?us-ascii?Q?bc31qw3UJEvZC0DWi0M48YZgoEgTyGnm+iInp0ramC2NDRwCIGj6qq2r8Bzd?=
 =?us-ascii?Q?RHITGUtXK1awWnU6/bCWS+THV4RSIS/0EO4djtZ3ABy18OoIPd+wDjCvSMT4?=
 =?us-ascii?Q?qvDsztub74/gzhgca/0pi2GhqxyGO9HUI7Z+NJ9daEteLqlDWa/YGEv/Y08L?=
 =?us-ascii?Q?iJ5dAOJYUJmLD+skefxTze3hShwAx7vpK0HA84MHkwqIcS1ToIuwwvOS72wS?=
 =?us-ascii?Q?cWDiFDW7iW1m+Zv04g946R/8cYieBViFbR+lBUCnJ48msi6wMX6Jjvdwv6AA?=
 =?us-ascii?Q?HQ/O0ifWQ3sm+Vph6JiGbS8BKCKWgGnM0iOmOKu+CNu5uHoOQLWPfLx4ceUl?=
 =?us-ascii?Q?QLSTDO2LMg9VqVlGIZVEs35gwaVaah8Z4Ifgtm+PQHwFaN7FYfouBt6wUPTI?=
 =?us-ascii?Q?bSslHD4qU7KINsY3vHU74blKGinS1Ck0BtNt5hv27Rqii1FOVsYsQcSdVd72?=
 =?us-ascii?Q?XovNzM5ugcdRCqndo7a+8+ydllHWlkf6yoQhuliyKeqO8+9ibXU/GzVCOvz1?=
 =?us-ascii?Q?A/QAbLAvHvONM7FjinSUHYtZAYUUb5VPwj5KHBZXrtCz4FL0LGWwtY1XTbhO?=
 =?us-ascii?Q?6q1bPUDjJ8Dl0jb+VGGYXOEbL4sGo5xXNAlZkUpG1yK86zhZ3JjM3zW6emM4?=
 =?us-ascii?Q?rNXFPmp/o3hLlq2q8PlHmB08ZfeQ6gn0y6+bo2+/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc18d57-0295-4c8f-14a9-08dbe132e36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 14:48:08.2929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p4SrpoHxjOyFM2jnwTeFsZ2ndQIYW2mnoCdf/Fs1VWRe5eNtOwiq85lXFuOLo6nsP+BiafIl2KO4r9gx6nF1E4+AH4u3qzQiqoWDOZBzWpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR07MB10023
X-Proofpoint-GUID: 2cvPJ8bWVHFdkZGbYmL3nOL2PMyje8ob
X-Proofpoint-ORIG-GUID: 2cvPJ8bWVHFdkZGbYmL3nOL2PMyje8ob
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_11,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=2
 priorityscore=1501 mlxscore=2 phishscore=0 malwarescore=0 impostorscore=0
 spamscore=2 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=162 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311060001 definitions=main-2311090112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>On 23-11-08 10:31:25, Pawel Laszczak wrote:
>> The interrupt service routine registered for the gadget is a primary
>> handler which mask the interrupt source and a threaded handler which
>> handles the source of the interrupt. Since the threaded handler is
>> voluntary threaded, the IRQ-core does not disable bottom halves before
>> invoke the handler like it does for the forced-threaded handler.
>>
>> Due to changes in networking it became visible that a network gadget's
>> completions handler may schedule a softirq which remains unprocessed.
>> The gadget's completion handler is usually invoked either in hard-IRQ
>> or soft-IRQ context. In this context it is enough to just raise the
>> softirq because the softirq itself will be handled once that context is =
left.
>> In the case of the voluntary threaded handler, there is nothing that
>> will process pending softirqs. Which means it remain queued until
>> another random interrupt (on this CPU) fires and handles it on its
>> exit path or another thread locks and unlocks a lock with the bh suffix.
>> Worst case is that the CPU goes idle and the NOHZ complains about
>> unhandled softirqs.
>
>Would you have a diagram to explain how things happen, and when the
>network softirq is scheduled in this case?

I don't have any diagram, but similar fix has been also applied  for dwc3 d=
river.

https://patchwork.kernel.org/project/netdevbpf/patch/Yg/YPejVQH3KkRVd@linut=
ronix.de/

In patch content you can find link to some discussion about this issue.

The similar fix I'm going introduce for cdns3 and cdns2  drivers in near fe=
atures.

Pawel

>
>Peter
>>
>> Disable bottom halves before acquiring the lock (and disabling
>> interrupts) and enable them after dropping the lock. This ensures that
>> any pending softirqs will handled right away.
>>
>> cc: <stable@vger.kernel.org>
>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>> USBSSP DRD Driver")
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/cdnsp-ring.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-ring.c
>> b/drivers/usb/cdns3/cdnsp-ring.c index 07f6068342d4..275a6a2fa671
>> 100644
>> --- a/drivers/usb/cdns3/cdnsp-ring.c
>> +++ b/drivers/usb/cdns3/cdnsp-ring.c
>> @@ -1529,6 +1529,7 @@ irqreturn_t cdnsp_thread_irq_handler(int irq,
>void *data)
>>  	unsigned long flags;
>>  	int counter =3D 0;
>>
>> +	local_bh_disable();
>>  	spin_lock_irqsave(&pdev->lock, flags);
>>
>>  	if (pdev->cdnsp_state & (CDNSP_STATE_HALTED |
>CDNSP_STATE_DYING)) {
>> @@ -1541,6 +1542,7 @@ irqreturn_t cdnsp_thread_irq_handler(int irq,
>void *data)
>>  			cdnsp_died(pdev);
>>
>>  		spin_unlock_irqrestore(&pdev->lock, flags);
>> +		local_bh_enable();
>>  		return IRQ_HANDLED;
>>  	}
>>
>> @@ -1557,6 +1559,7 @@ irqreturn_t cdnsp_thread_irq_handler(int irq,
>void *data)
>>  	cdnsp_update_erst_dequeue(pdev, event_ring_deq, 1);
>>
>>  	spin_unlock_irqrestore(&pdev->lock, flags);
>> +	local_bh_enable();
>>
>>  	return IRQ_HANDLED;
>>  }
>> --
>> 2.37.2
>>
>
>--
>
>Thanks,
>Peter Chen
