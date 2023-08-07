Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929A9773543
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 01:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjHGX5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 19:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHGX5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:57:13 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992B6131;
        Mon,  7 Aug 2023 16:57:12 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377LXwZW017585;
        Mon, 7 Aug 2023 16:56:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=RMSLy/iKLi0oSN30QOCCykbmtbYTEuUcIQHbReM/Xp4=;
 b=QtCPP0gC1rc+k3zIHeX9ADitiZtZztSInRHVLE8c45NohQ/iGEyKB7CEm+kRZtTnFjS6
 wSapj83EcG2QqHQTOMfU6mjz/OEa4F8U0xeZaqEduR760Ac1TvwNYpEWlinaEzQVQNDg
 cZQrhpjJXEOSBE9Oa2TpYeBMS2Im+Q8Kxhb9ef20Q5ZrUdx1psg3LjTi3f9Y8VUFCd/P
 lkQZ/ZMyeSEXIa7FGC2aV0abrHEvgnSY7oStgPqjF3/8zGRMzjUPnGsI9mR+Eq3xo/0M
 2Df3K2DERLJhIN3VhiWNzKBfTpIkwwrENPAExpbhl4RZPl8i9FvPAlOp1Q47AD+2Ix5z ow== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3s9n2f1adj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 16:56:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1691452612; bh=RMSLy/iKLi0oSN30QOCCykbmtbYTEuUcIQHbReM/Xp4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MfIf5DDqrxeAa2iV9A3ez7pO/cQ+rzUoTYh0WMgsL6ntZeob6l3WDkWO1xehTMM42
         F5Uz3EYoXIFILp7FXOjxnrZUsnhlBdBltV/5C454T1/vQDKXqOb/cEitEZZDO18XAw
         uW2QHIGzmCR4XuW1u2J0V3f0EBIJ37PbvJjAiszcF+LRydaj2CqNIwamAOuVXcxwG4
         IyPzGIb6CNQbqCujz9VsWFKlfN/6oZm4P+RAE7ypdSTrjYBU8KSO/b/Vcilg6PMwYV
         V3E0o7llRef5ijBXQn6TSrVYmL3oPzUkVM47VakOEHwYKKNQACwoWQSfeMnCbb27wK
         f7Oe3/P9R1PKg==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0BEBA401D0;
        Mon,  7 Aug 2023 23:56:52 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2EA57A0076;
        Mon,  7 Aug 2023 23:56:50 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=vQ+9fE1W;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4EF8D40123;
        Mon,  7 Aug 2023 23:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnYA4AlWPATpXSTjpsZ2HKLZR8/DJ+Ca3B3lGswa63EpvUycOi7TwT49mBuk7zP2IYmazeoRAYHbLFifgPd8g6aNqW5r6DP0MyoWfsZUxDJGB9uthT29fx8cef3rMTViMIQdZ/zO6gKg6DWoBa0rKu5YImaBaQ8BRzpC67t3rNB1iod3Efd8kXrw3SNMabchGWExBrTKtssMV333DFZ2eGv+FZ+BxYldBGA4dJole30NdM2bwJGx8HoZt2U4it9eULuIbwwdjhM4amuu7lcYiNOMs2jctvQY3m4FUx+Nld+1uWPG8DOlW2BB6p3jB6o6A26MMOycpYb1PTSN96UcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMSLy/iKLi0oSN30QOCCykbmtbYTEuUcIQHbReM/Xp4=;
 b=NINOFOHYCcLIndCxvGHYSn4Rk9odwXPtftWFEcucVn5DHay2yiLUzVrhzbd/hpM7Ma4VX5F3ZAbzcmtDQMKxBAICBKvgVbsuza4shL56w/KWKb3aI79Gg2C3VUW6zDaVyNtzNHBm7VaZvqs/BML1Ba6+lJaybK13au3C8pAnv8r8bYnF/uDuEFKzydIxxY0u537ZHwodPhXalktVAafp+rfUIUJwOw0J8NH9UFQQJyqnq3iYs+mc7qBqzZJzRzh9c3Ss2BkWLbDWplTuP0JYLOMt+KGfTR5mK7lEzDk7ydZCGc6YuTsjh+LQTpd/3eFPHkFx8gSoYYXu7ssmlo0dHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMSLy/iKLi0oSN30QOCCykbmtbYTEuUcIQHbReM/Xp4=;
 b=vQ+9fE1WYi8Fzg706rM3S2SUM/J6CtnwwOI1T0ce6Gww0/6hJlS0Mi88CC4cPJyT+4uO5nY0WXytbmbCok6F3lJsWf3oBn5RMNAcB2U1V6umyeGxJZMaz7Nf8CWa/VM6+MctNiggqjXgDaTFNFPirdBUZgbN0uA4/UGMmW20xFk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 23:56:47 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9bdb:ffe:c29f:432f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9bdb:ffe:c29f:432f%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 23:56:42 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue layer
 driver
Thread-Topic: [PATCH v2 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue
 layer driver
Thread-Index: AQHZxFow++w3UXyhskGxvNTqsfGMb6/WNIgAgAB47gCAAQXsgIAAcwYAgAEQrgCABV1QAIAA+H4A
Date:   Mon, 7 Aug 2023 23:56:42 +0000
Message-ID: <20230807235636.mlos5tpeg5foymnz@synopsys.com>
References: <20230801092541.25261-1-stanley_chang@realtek.com>
 <20230802011400.v4jim6ajsqc3tvei@synopsys.com>
 <ff9ca6f15936450696bff502c0047708@realtek.com>
 <20230803000417.qfuwsx5we5a7lfvd@synopsys.com>
 <7d47cbfdbc31436b89d3d92bf980c8fa@realtek.com>
 <20230803231156.laggnj5bzuhugwfd@synopsys.com>
 <ae619edfcce545b78697c6bcdadfff27@realtek.com>
In-Reply-To: <ae619edfcce545b78697c6bcdadfff27@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA1PR12MB6702:EE_
x-ms-office365-filtering-correlation-id: 710d817a-439e-41e3-49d6-08db97a1f2ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: elCCBfaVAKBqhi6mBPJzpfMVmCaqmfNTCzeuh675cqIbNnQUAYap8bCwLVKmDQHy4KLHf2MH8MXO8oaXlX62vmmFHyiZ/NGhC8xo7hokGJ6Yb8HQKGVQdo8/KzdLE72jp4an5nf7Yrvsp1lHXNy0KrfOiABqIKCzOLJQJAmnboBZbpttUzAPOZbC9c9hrNF/35M/gPtcWHQLC5MqU5IblZfIIU3GtXLLgS4lDlXYQ3z3qX9IT6uJ5f8AXtO+lOKDDuIUqBJBtmE4/+00KyTu3ilGqRJV0ZCJLPLLdecvJAi/HKubQOrQmlKe/mYJhPeaw5iKvILYJoSX35iKTqK4LW690yFOjkTTpdK9b+4G9yZxN1YcrzIZy/OztxnD9iEs7EpI7M513mVV9Su98PsiPRH1RwzeXXZGPtWZRTS7mKXHmAlefzq+uRdu8ESbXrUNka1dzb9MTSkCXzyDrhKZDDoq1aJLmbAvDYsOHAZUXUp/6g0luumZxDnmVIhCWTTnpc3wuVl2sPy3y3mhUW9R8ivEBjC/Ki5/OjYLHEtNALikiVlOK4d5ZaH5rqnfU60oouuwFPNoFJyAGGlJURinWHCjbmbFv8xsVIpnhiGjgOjqzokh8jtMdK174U7j/e1/yqaolsvcR+BJfakxuDnb3fkiBdEDnduT8STegkm0OAY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(376002)(136003)(39860400002)(1800799003)(90011799007)(186006)(90021799007)(451199021)(83380400001)(2616005)(54906003)(2906002)(6916009)(4326008)(316002)(5660300002)(8936002)(38070700005)(8676002)(76116006)(66946007)(64756008)(38100700002)(66446008)(66476007)(66556008)(966005)(6512007)(478600001)(122000001)(71200400001)(6486002)(86362001)(41300700001)(6506007)(26005)(1076003)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEMxK09ob09mZVdQeWpFc2hZS2dMTmNNc09xakhPOEVxbkJUOFZWdkZvK1B6?=
 =?utf-8?B?aUNrSFZ1YndzdnpnQ0Y3aTBuT21lS0xDcGlzZER3UjJUc0R5empVeE5LVUwv?=
 =?utf-8?B?ZWNWMUc5YWoweEVUS1BxbVlubGRSYUZ3TjdZNXN6T0NzV0lUTjBCMWlXTk9W?=
 =?utf-8?B?eUFoQjRuSXZqWm9UTjI0RGNaWW5vR29uSWNSWnl3VWQvQVZkNjM2a0JiWlpV?=
 =?utf-8?B?TGVxRERlc3p4NXZFUUdGZzJGTDh2SEtxZGlzNitHclBHMjB1dWVzdTYraGdm?=
 =?utf-8?B?NStKbDhkUE03UklOOFZ6TDVEVmZvbElGWXBkWlgzZnJHZlRqajk5ZlBKOTcx?=
 =?utf-8?B?UVlNcGRGWlFRaW1ScHlUVG9kUDZrU0JSMTFHdlV4bTRBOHV1RkdtbnZyWVY5?=
 =?utf-8?B?bCtBZy9NcGFBQzNNSWxWM2RYUEpqM3g0RDZNZlZYR1BvWk9RMXgrZzJnOWtE?=
 =?utf-8?B?OCs1N3ZZSnBPSFRJVmE2amIxV1lHcDc1cWtYcHRwWHp6NGp6MUVBWGZQOCtv?=
 =?utf-8?B?blFGcFVNN0w0SzY2MlZsWGUvSXdZa0NjZ1ZHNXd0dXhkSzRpVXlvTUV2NDRh?=
 =?utf-8?B?MUtFYnJVcnFsSWJvU0NJODNrTndJRThIYk5iZ2ttc1N3ei9GMlZyd1RWTS9o?=
 =?utf-8?B?dCtianE5RXVYN0FldGkrQW8yMDRFbG1vWklKWGxrNTQ1bzhaY2l5UDBOd2Jo?=
 =?utf-8?B?ZFhrYXptakFZQmdEbFF5b2lWaVFNSnRWVitnbksxeG8zQ3FwOHg0MzI5MmhE?=
 =?utf-8?B?UWVuMWhLeVRISUlmdkxJUC9kSmdsOVVnVzdVT2Ezclh2ZHVYazRsd1lLcDBt?=
 =?utf-8?B?NExGN1pWSUUyYS8relFLUmVqZkRnVVpWd0hNNTR6anpVMW1Oam5XKytoYkFQ?=
 =?utf-8?B?VEZWQzJ5dnJ0QU9QZm4wVHozOWV5UHZDa04vUFpwQWlRM0d0OVBBSlc0TmFy?=
 =?utf-8?B?NDVPVXJlTWpLeDg4WElsUDBlbWhpdGxkSDN0MXgxeXQ5YUR6UlMzWjBwc1Ux?=
 =?utf-8?B?d0hPbnc3SEtpSzV2SmJNVlNHMnlKMlJLdDVOWGVWN1hsWUhXREJraHdIVWZv?=
 =?utf-8?B?Y3Y4cHVGNXhaZm9LZE5qbkhHR3FqRTRwS1BtcmdzZmJES1oyUGFRanlnR2xp?=
 =?utf-8?B?aC9Vdk1hM2F6UW1LK2dkenRRdGhqQTNpUG0zL2RaeFFhdFhDUFpxcEY0a2Ru?=
 =?utf-8?B?Vmg2YzdiUC9XbGsyV1RJV2NpKzdrd2ZPRVR5QXNXQjl0TG10azhkMnV4czdn?=
 =?utf-8?B?R1lxT0NwMStzZ2VSNVMzN1FLRk9KQTd0ZG1aTHA0eXVTbUlmZ0pVR3pBK0ZU?=
 =?utf-8?B?RmhQeDF2Z0xmaTFrT1gweUdtMDRLQzlsV1YvMk84OXEybVBxeEpOQ1JJbWt4?=
 =?utf-8?B?QnRSYkNpbEk3TkZaYVJYWTZNV0FoQjgyNHZMMEszY2xkZndvNkRHSjRnL3Qr?=
 =?utf-8?B?OEMxcGEzMWE0c3A3VndNcGpCc2RSUTNUSkI5ZC9JZGh6cy9YdFhncnlQSW0x?=
 =?utf-8?B?a3NtQ2lMWGM1aHhLemRvRUpKbld6anhQV3pNcUZNemI4SjBLb3hUZmhGTDdN?=
 =?utf-8?B?M1k5WUtMOFprK2dCdy84NFZhL3E1VW81Y2l4a0Z1VC9paHN3MkxGazE5T1hq?=
 =?utf-8?B?cERUQ0JjTC9GTVZHU3FIUjBLTUJyUkZyNHI1V3EzZnVVeDhNa0toNG50WXF5?=
 =?utf-8?B?U0pGa0w3RHBYWlRpTXdSQzBhNURjbFpwMldaOGJuUkdNdzl1YzlxNUUwcnRo?=
 =?utf-8?B?WTFXcWhoWFNNSWUxNm14NzFSS0E2eVAyWWtCV1dGS1BUOXVQZkdNaXErODVH?=
 =?utf-8?B?S0R5dHJwRWswaW5mRW02ekdRODZsK2U2ZXJpV2QwWDlDdmI5WVg2bGJQTC9B?=
 =?utf-8?B?VnhWb3RTV2h5cTBUWVQyYXFIRi94SzR4ZFdLZ2xFK0NpOXdkOEMxUktTb1JO?=
 =?utf-8?B?UzJJeVRLVDVQNlBIRGdxQnVqN3dYL2dMQVRodDVKVHhuR29TTzZDTTBLeWN4?=
 =?utf-8?B?NXUrNFE3Qkt5WElubmROYVVPS1VGcm95U2djUmxWLzYwZEJoV3VJUWxWRFRL?=
 =?utf-8?B?TndyR1VqRXptcnBudDBVT2V2aVBpbmFSelBZenlPK3M0ZEswaUthSSs0K3F4?=
 =?utf-8?Q?xvVr94H56Y8t24XmFJzcQDt23?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D064EBEFE52394389EF15F4D7447361@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VDROdVZucnZCVk5uS0NKcmpBYmMrL2R2R0VwNWZ5eDJFb2p3OEVaZkNZSlR4?=
 =?utf-8?B?aE1EdEdWSEp0dGFWdlJRU2lIQURnT3B2dG9EMGdYQjY4MHg0YXY2Y2JyL29z?=
 =?utf-8?B?cWYzYUtyVjJMYlhKaHVvaGg5WmEzOVovUFdFd2x2QTIvOUQxUThqOUVvTEhw?=
 =?utf-8?B?eWFpSlVlNTdqUnNZcnhJMFF1blVvQkxEdmU3Ykk5OEFWVmFENWFpd0tjckxU?=
 =?utf-8?B?ZVQ2R29UWkFqYU1FUTUxRFFMbjlKQWFZOCtPMWZINFRaZnJ3WG5BRStkWUNE?=
 =?utf-8?B?R25PWFA4elg5ZkQ1amFBS1NVZWtNWVZWVnFPZElZWWI4OEd6eHczYytZcmpx?=
 =?utf-8?B?b0swaHdXcUNPVmRKRmF0OFQ5NU0xK052bkhPM0J1TzdBTkd0eEdEVUNPK2cz?=
 =?utf-8?B?Tjladmo0TlArQWhjTnZIOUFncW1hTnZWT1E2bWFMd1hpc29jQnRDbTNQbEZX?=
 =?utf-8?B?Q09ISGtUcWF0d1ZsM1o5b1ZzM2RuVVVRVW5iK0pZREtPclRlK3grYTNtV0lB?=
 =?utf-8?B?bFVQMjlXb3VGUlVIa0ZBTFNjaG01Vm94K05RNUZtd2txQVBpaXloMTFwQk1y?=
 =?utf-8?B?cUU5OWEvTG4vdVhxNXNoRGQ5eFA3UGRvMWIxVktNeXRUa3ZDS241YTM5Mk1k?=
 =?utf-8?B?eWt5bTVrQk9lSkw3V2w1RWhDS2djVU9DeWQ5Uy9BK2RTMEI2TTQwWjQvYVZI?=
 =?utf-8?B?N2hCWjhMSWJNMHpPU0hpNFdZMFRFam1Dd1BYMTl5TzRtTGRZNkFaN1ZiVnFI?=
 =?utf-8?B?S05uTGRHamdFbmdGTnNud0RrczVyb0JEOG1KUy9kNEt6Wk84MTJxbmd0UDJo?=
 =?utf-8?B?aGxDNWY5dHY2SnBPd2NTSE1WSUxNOGI4ZjRXRHluWXdDK2M0bUVlV25VT1lq?=
 =?utf-8?B?Sk9PeXlsWnQ2QkpGbmFuOUVobnJLQ2ljRThONWdYWXNlaTEvNmt5NWlZOUVi?=
 =?utf-8?B?dlAzdnZQekZBZzN1QnN0dk9LQTkyR1pSY3ZxT0J0cTIwMm5ndEJZUmR1MUlF?=
 =?utf-8?B?VC9qTm11eVFjSk40VkJocnFwZExObVpLSnRUcFdHN01TRGNTcGt2c3pDeGpN?=
 =?utf-8?B?R1hOaWlQZ2o2Qm52cllKS3luc3EyWnhVdFA0Y2Z2OCs5a1U2QkRWSDI0L0w5?=
 =?utf-8?B?TnR1TTJ3QnlRaVFOOGI2QVBXUTIzMng2bFlmaGtoTTBpOUgzbVIySFRqOCs3?=
 =?utf-8?B?a1g4TFNMTGRzbC9qWUI5K0duRXY2QWJhQWlrUkZ2VkgxQnZYTHhTbEt4aUYw?=
 =?utf-8?Q?48y8XlXaFL8kP8P?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710d817a-439e-41e3-49d6-08db97a1f2ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 23:56:42.3647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7uPkq8v3CJ8x8AoK0qKah+5Hbq5UkW8sI39UAPjFoDoWshBkMnasRxDDWGIgEfbz7R7VmVi1fckopdH94RsSGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702
X-Proofpoint-ORIG-GUID: xLMFcQhMU4nwemMEWrxpBjpIleOdusa_
X-Proofpoint-GUID: xLMFcQhMU4nwemMEWrxpBjpIleOdusa_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_26,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308070215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMDcsIDIwMjMsIFN0YW5sZXkgQ2hhbmdb5piM6IKy5b63XSB3cm90ZToNCj4g
SGkgVGhpbmgsDQo+IA0KPiA+ID4gPiA+ID4gPiArc3RhdGljIGludCBkd2MzX3J0a19zZXR1cF9y
b2xlX3N3aXRjaChzdHJ1Y3QgZHdjM19ydGsgKnJ0aykNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiBBbnkgcmVhc29uIHdoeSB3ZSdyZSBkb2luZyB0aGUgcm9sZSBzd2l0Y2ggaGVyZSBhbmQgbm90
IHdoYXQncw0KPiA+ID4gPiA+ID4gaW1wbGVtZW50ZWQgZnJvbSB0aGUgY29yZT8NCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gQmVjYXVzZSB3ZSBoYXZlIHRvIHNldCB0aGUgdXNiIDIuMCBwaHkgbW9k
ZSB0aHJvdWdoDQo+ID4gPiA+ID4gc3dpdGNoX3VzYjJfZHJfbW9kZQ0KPiA+ID4gPiBpbiB0aGUg
ZnVuY3Rpb24gZHdjM19ydGtfc2V0X2RyX21vZGUuDQo+ID4gPiA+ID4gSW4gZmFjdCwgc3dpdGNo
X2R3YzNfZHJfbW9kZSB3aWxsIHVzZSB0aGUgcm9sZSBzd2l0Y2hpbmcNCj4gPiA+ID4gPiBpbXBs
ZW1lbnRlZCBieQ0KPiA+ID4gPiBjb3JlLg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEkg
ZG9uJ3QgdGhpbmsgdGhpcyBpcyBhIGdvb2Qgd2F5IHRvIGdvIGFib3V0IGl0LiBEbyB5b3UgKHRo
ZSBnbHVlDQo+ID4gPiA+IGRyaXZlcikgY3JlYXRlIGEgcm9sZSBzd2l0Y2ggc3RydWN0dXJlIGFu
ZCByZWdpc3RlciB0byB0aGUgc2FtZSByb2xlDQo+ID4gPiA+IHN3aXRjaCBkZXZpY2UgdGhhdCB0
aGUgZHdjMyBjb3JlIHdvdWxkIHJlZ2lzdGVyIGxhdGVyPyBJIGRpZCBub3QNCj4gPiA+ID4gZXhw
ZWN0IHRoYXQgdG8gd29yayBhdCBhbGwuDQo+ID4gPiA+DQo+ID4gPiBJbiBvdXIgYXBwbGljYXRp
b24sIHRoaXMgcm9sZSBzd2l0Y2ggaW4gdGhlIGdsdWUgZHJpdmVyIHdvcmtzIGZpbmUuDQo+ID4g
DQo+ID4gSXMgdGhlIG9yZGVyIG9mIG9wZXJhdGlvbiBiZXR3ZWVuIHRoZSBzd2l0Y2ggZnJvbSB0
aGUgY29yZSB2cyB0aGUgZ2x1ZQ0KPiA+IGRldGVybWluYXRlPyBBbHNvLCB3aGljaCBvcGVyYXRp
b24gc2hvdWxkIGhhcHBlbiBmaXJzdD8gSXQncyBub3QgY2xlYXIgaG93IHlvdQ0KPiA+IGhhbmRs
ZSBpdCBoZXJlLg0KPiANCj4gV2UgaGF2ZSBhIHR5cGUgYyBkcml2ZXIgdGhhdCBmaXJzdCBjYWxs
cyByb2xlIHN3aXRjaCBpbiBnbHVlLg0KPiBUaGUgcm9sZSBzd2l0Y2hpbmcgZnVuY3Rpb24gaW4g
Z2x1ZSB3aWxsIGNhbGwgdGhlIHJvbGUgc3dpdGNoaW5nIGZ1bmN0aW9uIGluIGNvcmUuDQoNCkhv
dyBkbyB3ZSBrbm93IHRoYXQ/IFlvdSdyZSByZWdpc3RlcmluZyB0byB0aGUgc2FtZSBzd2l0Y2gg
ZGV2aWNlLA0Kd291bGRuJ3QgdGhlIHN3aXRjaCBldmVudCBub3RpZnkgdGhlIHN3aXRjaCB3b3Jr
IGluIGJvdGggdGhlIGdsdWUgYW5kDQp0aGUgY29yZT8gUGVyaGFwcyBJJ20gbWlzc2luZyBzb21l
dGhpbmcgaGVyZSwgYnV0IGlzIHRoZXJlIHNvbWUNCm1lY2hhbmlzbSB0aGF0IHdhaXRzIGZvciB0
aGUgc3dpdGNoIHdvcmsgZnJvbSB0aGUgZ2x1ZSB0byBjb21wbGV0ZQ0KYmVmb3JlIHRoZSBjb3Jl
Lg0KDQo+IA0KPiBUeXBlIGMgZHJpdmVyIHNldHRpbmcgc3dpdGNoIHJvbGUgZnVuY3Rpb246DQo+
ICAgICAgIHwtLS0tPiBTZXQgcm9sZSBpbiB0aGUgZ2x1ZQ0KPiAgICAgICAgICAgICAgICAgICAg
fC0tLS0+IFNldCByb2xlcyBpbiB0aGUgY29yZQ0KPiAgICAgICAgICAgICAgICAgICAgfC0tLS0+
IHN3aXRjaF91c2IyX2RyX21vZGUgaW4gZ2x1ZQ0KPiANCj4gPiA+DQo+ID4gPiA+IEhvdyBhYm91
dCB3ZSBjcmVhdGUgYSBjb3VwbGUgb3BzIGNhbGxiYWNrcyB0byBkd2MzIHN0cnVjdHVyZS4gT25l
IHRvDQo+ID4gPiA+IGluaXRpYWxpemUgZ2FkZ2V0IGFuZCB0aGUgb3RoZXIgZm9yIGhvc3QuIFNo
b3VsZCBhbnkgcGxhdGZvcm0NCj4gPiA+ID4gc3BlY2lmaWMgZGV2aWNlIG5lZWQgc29tZSBpbnRp
YWxpemF0aW9uIGJlZm9yZSBpbml0aWFsaXppbmcgdGhlDQo+ID4gPiA+IHNwZWNpZmljIHJvbGUs
IHdlIGNhbiBpbnZva2UgdGhlc2UgY2FsbGJhY2tzLg0KPiA+ID4gPg0KPiA+ID4gPiBlLmcuOg0K
PiA+ID4gPg0KPiA+ID4gPiBzdHJ1Y3QgZHdjM19nbHVlX29wcyB7DQo+ID4gPiA+ICAgICAgICAg
aW50ICgqaW5pdF9nYWRnZXQpKHN0cnVjdCBkd2MzICpkd2MpOw0KPiA+ID4gPiAgICAgICAgIGlu
dCAoKmluaXRfaG9zdCkoc3RydWN0IGR3YzMgKmR3Yyk7IH0NCj4gPiA+ID4NCj4gPiA+ID4gc3Ry
dWN0IGR3YzMgew0KPiA+ID4gPiAgICAgICAgIC4uDQo+ID4gPiA+ICAgICAgICAgY29uc3Qgc3Ry
dWN0IGR3YzNfZ2x1ZV9vcHMgICAgICAqb3BzOw0KPiA+ID4gPiB9DQo+ID4gPiA+DQo+ID4gPiA+
DQo+ID4gPiA+IHN0YXRpYyBpbnQgZHdjM19nbHVlX2luaXRfZ2FkZ2V0KHN0cnVjdCBkd2MzICpk
d2MpIHsNCj4gPiA+ID4gICAgICAgICBpZiAoIWR3Yy0+b3BzLT5pbml0X2dhZGdldCkNCj4gPiA+
ID4gICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIHJl
dHVybiBkd2MtPm9wcy0+aW5pdF9nYWRnZXQoZHdjKTsgfQ0KPiA+ID4gPg0KPiA+ID4gPiBzdGF0
aWMgaW50IGR3YzNfZ2x1ZV9pbml0X2hvc3Qoc3RydWN0IGR3YzMgKmR3Yykgew0KPiA+ID4gPiAg
ICAgICAgIGlmICghZHdjLT5vcHMtPmluaXRfaG9zdCkNCj4gPiA+ID4gICAgICAgICAgICAgICAg
IHJldHVybiAwOw0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIHJldHVybiBkd2MtPm9wcy0+aW5p
dF9ob3N0KGR3Yyk7IH0NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gWW91ciBnbHVlIGRyaXZl
ciB3b3VsZCBpbXBsZW1lbnQgdGhlc2UgY2FsbGJhY2tzLiBJbg0KPiA+ID4gPiBkd2MzX2dhZGdl
dF9pbml0KCkgYW5kIGR3YzNfaG9zdF9pbml0KCksIHdlIGNhbiBjYWxsIHRoZXNlIGNhbGxiYWNr
cw0KPiA+ID4gPiBhdCBzdGFydC4gSSBhZG1pdCB0aGF0IHRoaXMgbWF5IG5vdCBiZSB0aGUgZ3Jl
YXRlc3Qgc29sdXRpb24gc2luY2UNCj4gPiA+ID4gaXQgd291bGQgcmVxdWlyZSB0aGUgZ2x1ZSBk
cml2ZXIgdG8gYWxsb2MgYW5kIHJlZ2lzdGVyIGEgZHdjMw0KPiA+ID4gPiBwbGF0Zm9ybSBkZXZp
Y2UuIEJ1dCBJIHRoaW5rIHNob3VsZCBiZSBvay4gSWYgYW55b25lIGVsc2UgY2FuIGNoaW1lIGlu
IGZvcg0KPiA+IG1vcmUgaWRlYSwgaXQnZCBiZSBncmVhdC4NCj4gPiA+DQo+ID4gPg0KPiA+ID4g
VGhhbmtzIGZvciB5b3VyIGFkdmljZS4NCj4gPiA+IEhlcmUgaXMgYSBzb2x1dGlvbi4gQXMgeW91
J3JlIGNvbmNlcm5lZCwgaXQgbXVzdCByZWdpc3RlciBjYWxsYmFja3Mgd2l0aCB0aGUNCj4gPiBj
b3JlIGRyaXZlci4gSXQgbG9va3MgYSBiaXQgY29tcGxpY2F0ZWQuDQo+ID4gPiBJIG5vdGljZWQg
dGhlIHBoeV9zZXRfbW9kZSBhcGkuDQo+ID4gPiBNYXliZSBJIGNhbiB0cnkgdG8gbW92ZSBzd2l0
Y2hfdXNiMl9kcl9tb2RlIHRvIHBoeSBkcml2ZXIuDQo+ID4gPg0KPiA+ID4gcGh5X3NldF9tb2Rl
KGR3Yy0+dXNiMl9nZW5lcmljX3BoeSwgUEhZX01PREVfVVNCX0hPU1QpOw0KPiA+ID4gcGh5X3Nl
dF9tb2RlKGR3Yy0+dXNiMl9nZW5lcmljX3BoeSwgUEhZX01PREVfVVNCX0RFVklDRSk7DQo+ID4g
Pg0KPiA+IA0KPiA+IEknbSBjb25jZXJuIGlmIHRoZXJlIGFyZSBvdGhlciB1bndhbnRlZCBzaWRl
IGVmZmVjdHMgdGhpcyBtYXkgaGF2ZSB0byBvdGhlcg0KPiA+IHBsYXRmb3Jtcy4NCj4gDQo+IA0K
PiBJIGRpZG4ndCBhZGQgYW55IG5ldyBwaHlfc2V0X21vZGUgdG8gZHdjMy9jb3JlLg0KPiBJIG1l
YW4gdXNlIGV4aXN0aW5nIGNhbGxiYWNrLCBhcyBmb2xsb3dzDQo+IGh0dHBzOi8vdXJsZGVmZW5z
ZS5jb20vdjMvX19odHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni40Ljgvc291cmNl
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jKkwyMDNfXztJdyEhQTRGMlI5R19wZyFkT0sxaDlaMDND
Zm10d1dsTmVQay1UaUVkSFFqYVA4cU1tWTRCZ01mWW0weVRpNU5UaExxS19QT096ZE04OXRTejJ6
RFJrZkdHOUJTemI3OHprTEZodHR4b2VmVTV3JCANCj4gDQoNCkFoIG9rLCB0aGlzIHNlZW1zIGxp
a2UgYSBiZXR0ZXIgb3B0aW9uLg0KDQpUaGFua3MsDQpUaGluaA==
