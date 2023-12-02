Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF26801BCE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjLBJrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjLBJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:47:49 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2106.outbound.protection.outlook.com [40.92.91.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8E9197
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 01:47:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oajFP/fkvy438F5A16JGKzWRPlzFQHfFORz6iIhll7Rp34YtlEmnRFVpjiet1mlqg3j+65njXd9qU+pyg2fYr1gJ0dEBu0xO8DqbE45DPlF4O0rXbq5SJEJ6wJi7jMKStTQghzLsQfjzyqnw5U6rzXn+/Y44sip5fxbdt50n0wfxVb+anTrbDYjRTvHvZMlmOe3QtGDJlz1W8uR8bjbPpqKRkasxO2jiYd4trbVdpaRM3SCd1iZ/RX4+uoxj0L0x1Du4CeNjsM1QS/aWwpjPE0Eh+qD3ma6PNYzTHebhFfkwDTd3RitEELjW9tvtQRxvNz1u0fOiCTzhDVV9zdlGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdM6E8TygjaIsgGDagSeLc0OgxcHOi3NfXOUkWNcqjY=;
 b=O8vM8P/nTMdQ3JuHJ0R2aJfknet0qlXWoE38vUHJXt+h54PH7cQhvGgJEsN0Hs2TO0XmXTTKSxVb7A/UnwD7xw/ZMFjk1NpNVj+B+sRUfBBJ4JbejHpAO8RixSld+s/DhJz+ui5HpFL3+h1QuuSvgMlZ1SpOxCDXYpDWxQ29m7x968MRiiAQOtmYAJ6F+Ar2kByI9GbBq0IJKxjUhuR5hM9Mo27iZykrMrBRWVTEKW5FFWoLYAp1ha1dkD7S+N2Eyfj8fgX3B0QTNOUllKs9YSczcUj2l7/9g/ayMUSSyWccFXhoIEppArJZ5Vx2euql0G9EVFgYN4+N2fFOGRcH5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdM6E8TygjaIsgGDagSeLc0OgxcHOi3NfXOUkWNcqjY=;
 b=OAfDcfZNBtbDc8G/bJeDLJix9/fk+g1XefS3p+UmPvRxnZIL5nxKuB8Kc0+R+Kz3kYHKx6K5bI7GqMbKUQEGuQQ4ySKrUv+rBK3YmCxYPtBNssgOzLJBvjAvUsoQFpNVqQichR/cabqMPwcmNGWZo14fTlKaqWRR4VnuinM4KZzFjfQ/EY2vgZ53Lth1grk4rl60NaG5v/BsLWvojCsegMMuCh31r3jV6sqZwtki1Z4ds5zVlqlVpInfw02AARg/z2xA48RKGKJwW67GoY5Ds8SlJzdsBGh7uwCVHH8/6c/gfiwF+tKVWpCcQsB+Npf0Qe5Zh3RibtjjHR3KwDmD2A==
Received: from AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:172::24)
 by GVXPR10MB5861.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:69::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Sat, 2 Dec
 2023 09:47:53 +0000
Received: from AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1fc4:7df9:3d95:eb28]) by AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1fc4:7df9:3d95:eb28%6]) with mapi id 15.20.7046.028; Sat, 2 Dec 2023
 09:47:53 +0000
Message-ID: <AM7PR10MB39233A00FBC280A9B4A5B3C38E80A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
Date:   Sat, 2 Dec 2023 10:47:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Kernel problem with multiseat on one card
Content-Language: en-US
References: <AM7PR10MB3923E07D6024434077E95EBA8E82A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
To:     linux-kernel@vger.kernel.org
From:   Gert Vanhaerents <gert.vanhaerents@hotmail.com>
In-Reply-To: <AM7PR10MB3923E07D6024434077E95EBA8E82A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
X-Forwarded-Message-Id: <AM7PR10MB3923E07D6024434077E95EBA8E82A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [v46ofhGDuYpw/CndJFrgzKDsFBfnOCB1]
X-ClientProxiedBy: AS4PR09CA0001.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::7) To AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:172::24)
X-Microsoft-Original-Message-ID: <d3d7ae50-bc6f-40e6-a93e-edea3608fc4d@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3923:EE_|GVXPR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: ce89ab63-0a3b-44e6-b1a0-08dbf31bc14c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gtNNIKs6UQFNnJis6CE78NRld9O8ftCkavr1Gw+LUcKh6/k9rztGhMlez7ZPun+9KkS1Tyx2F5pwOiaNk65E9Q3JpG/SBqEWgbQMZ9VaNM3mZZLnp6sWVKDo4Y9YgWBCvc5ujzY3wst8Q1KgtB77lC2UBPEIcSKDY6t89RrNtDT15yGw1IQ6m7G0K+tMtAI7a+nxyVTXEfQB5iZgC+ON8ZZRup67kMBRsHqsazR++IaLreaGOY6Kx00/BTMuEOcq6+7KhFxjs/lF/F6Jo1vCCHErDmbHte8ouUNTVJegqEXbxMtMuxZyJCVldpobuergWWuYvsI0WARETOVetYj0/slx0awJn83xW+v4oUWlu9//w3F8W23csFH/iq88MuO2VTqBOr6iXBpVktPxmvO+BFrU6cSZOr8tD8kxhP3CGcnXezPu7r4mY24Ko906SRK1Z026YNXEpCnG5Y/n5fuSao2MMis0L5JdiX2GrTf9XRK2QODHIatenpYo9Xa6HLi2eU+FJWTD17U10MqFq7jxOHMGy9X5CtZWURrBHIJPfOIGnV2vqmLrGcD6WhsQfXYI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHU1MEIxTU1qaDMrU2hRdktEaWVKemJ2dmIyWFp2aHVLeEVGZERzSDUrb1hj?=
 =?utf-8?B?UngyZE04cTNVbTlaY3g4MXJ2NXlkcGgzZEpzS3VQbjBlamltVUZNNHIwZUhC?=
 =?utf-8?B?NFFRT1NycVBJQWFLUTRzTXltcVRsMWhXQW1QdWoxQkU0OUcrOCtJai9RelJG?=
 =?utf-8?B?RkN2VFNybHRmQy8zSnEzbkJxQzFaR1hmTHJhV3NSclJVdjBsK2I2bm9Zc1Z4?=
 =?utf-8?B?MlBGZzF0ZGwyV3cwcUZ4cCtyUWhNUFRkNHRqS2FUM3RNa2EzdUw2S3JkbDR2?=
 =?utf-8?B?Uy9KZnE3MFNubkwvaFFidTU0RkpEWWh2NmY3MmJsNzZQdXlsQW5aeDBBb3JP?=
 =?utf-8?B?Zk1uVVB2c0ExNUROQ3o2NnZrcG5JWHRjdG40YUMwTFU3dXhTVmM1dlowUTRJ?=
 =?utf-8?B?UkgycUZyVjg2cUpJVnJmNUpLcVAxRkhCN3lTZ1EzV3ZEUHR2YXk4Q1IwZEVy?=
 =?utf-8?B?Szh4Qi9IME56UjEwajdWM3ZUNVJIQ0ZDbnJGdGRZZmVkaWlNc2V2QkdFZHBC?=
 =?utf-8?B?bm0zaTdTb05QNERpNktsRWhMTHRkRzdPbkhDOTM1UTk4TGI3cUFBODU3elZm?=
 =?utf-8?B?QlZQN25UTThBQUwvQnRyWFJOQW5xTW5vdHVaK08yZnhWeXdzZjNkMkc4cm80?=
 =?utf-8?B?TlRMUG5WRDUrT0J2OWltNFZ2ZlBaUzFYcStvRE5CdU9mTTl4MSsxNmNKVXRT?=
 =?utf-8?B?U2I3Yk5vNlM2dTh5ZVBJSnFWamZZVVFzcGVodWNHV2M0VzdlenNQNCt6dzhN?=
 =?utf-8?B?ejNxTzcvMEY5dXNtOVJ0cmlVQW9aTEg1TWVDS21rZjZ4UnRKNW1ZMklBNEpZ?=
 =?utf-8?B?RHprMFRFSTQzcmlJR2JNQnBhdHpNQ1dlZks5dlorMGRaZWNMTzJSbXRtemhm?=
 =?utf-8?B?QlVrQ1J1WUpMc1E4dzFaNUttRzZSSGRJcXRoMXRjcGJFbTN1MjJ4L3ppMXlS?=
 =?utf-8?B?aDRMTi9GZGhrL2xrcnBmUG0xQ1ZXMDFra0lIeHR3NHlYWk9XUVZUOHFoRHJh?=
 =?utf-8?B?OS9ZRGg2N1ArcVJKMG5vdlVoY1I0M3BYbkljMVNYWDRHalFQdmRJQUY4SjRj?=
 =?utf-8?B?T3dvNVBMZFNQWGJ2bVVlTlJVVE1zYXBjbGw5bnhTOXJQVE5xa1NtL2gxbWdO?=
 =?utf-8?B?cG1Cb1BwbUhON1lJdmpXOExoWjNmUTZycVJZVUNlWjVaUDk2Z1RtVWxPV29W?=
 =?utf-8?B?NkVTd1NtRTcrZUdTbmoydm9DbUhtQTZKRndiUENyRFFxZjBFWkZuc1dQMUhH?=
 =?utf-8?B?UDVPNWwyajBYa2J2V3U3US9aWUo0Qnh0aGdjNWtjZy9MU0NDVThEYU90clFO?=
 =?utf-8?B?QlR2T1RVM3ZodFlycTFIRUxjOFZ6aU5sb1MwdzltbXVrRThLbjhncFlzbzJr?=
 =?utf-8?B?aVhQSUczamg4V0w0eThKN1BXS1lUdXRFbCtRa2VFN1ROcWxBbjlvU1FrdklG?=
 =?utf-8?B?bkVXdzR1ckwxSDJqMTkxNU9sMmRvNWNwVHF1Ri9aQVBUNk1LRDIrYzV4MWJk?=
 =?utf-8?B?UjZhZGJld2p1UXRPN2xFYnNSMG9TQjhjUEFsUWlYcU5MbU9wdWRpdElRZi9R?=
 =?utf-8?B?OU5jWFhvaDlVRTNiRU8va3NEb05KbTNrUkNYWTVRTlRiS2FOZWo4bHltdStF?=
 =?utf-8?Q?koJDN0bM/CYC/wUrfVvL58ciK9MQHN2XOYUSPqkFaQWY=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ce89ab63-0a3b-44e6-b1a0-08dbf31bc14c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2023 09:47:53.7365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5861
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kernel list,

I'm the IT person of a school, earlier we used multiseatcomputers for 
the school, i have maded with a XGL implementation and it works fine but 
not so fantastic. The school wants that i build new computers but the 
XGL project is too outdated so i can't use it anymore.

How can i make a multiseatcomputer with more then one user on one card 
with systemd? I have asked already to the makers of systemd but they 
said it's a kernel problem.

With Systemd loginctl and the nouveau drivers you have this:

─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0
           │ [MASTER] drm:card0
           │ 
├─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0/card0-DVI-D-1
           │ │ [MASTER] drm:card0-DVI-D-1
           │ 
├─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0/card0-HDMI-A-1
           │ │ [MASTER] drm:card0-HDMI-A-1
           │ 
└─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0/card0-VGA-1
           │   [MASTER] drm:card0-VGA-1
├─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/renderD128
           │ drm:renderD128
├─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/graphics/fb0
           │ graphics:fb0 "nouveaudrmfb"

So it will be:

loginctl attach seat1 
/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0/card0-VGA-1

For the seat1 (the VGA d-sub output for seat1 and the other HDMI output 
for seat0) and of course the mouse and keyboard.

When you do this, all the graphics outputs are on the second seat 
(seat1) and not anymore on the first seat. So i need to move only the 
VGA output to seat1 and not all the outputs.


When i install the proprietary Nvidia drivers, i have the following:

[MASTER] pci:0000:08:00.0
           │ ├─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0
           │ │ [MASTER] drm:card0
           │ 
└─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/renderD128
           │   drm:renderD128

─/sys/devices/platform/efi-framebuffer.0/graphics/fb0
           │ graphics:fb0 "EFI VGA"

So no VGA, DVI or HDMI items.

Linux is a very good multi-user system, so it is frustrating that it 
does not work. It does work under Windows without any problem, so it is 
certainly possible.Can you please check this or give me a tip somewhere 
so that I can continue looking for a solution? According to systemd this 
is a kernel problem, can you please solve this.


Hopefully someone can help, the children and school will always thank you!
Thanks in advance,
Gert


