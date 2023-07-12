Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB16F7513CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjGLWzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGLWzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:55:40 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AA7136;
        Wed, 12 Jul 2023 15:55:39 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CGWu0k013516;
        Wed, 12 Jul 2023 15:55:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=jpSCrtLeMsa01y6cjgdCmv3LpC5NOzEGKDDfFHCjbV4=;
 b=Sryxu8drSCAHHrNdVB3fhpH0l7ZnQN0ycFUFRyZ106fAdi38GLtljgS6KOjmF6GoKeqz
 WHvyh4KiYMjzeg2eRujTg4rGHI3SW2Kk3KdguNSN28z5XNu5D8V/US1Sl1tg0Ey/YUwN
 cNi9eT/pYFPMoTH9AhGDWofmCeoXTeuyJkgMm4amEO1mQ515D3w3Br8GPpCQzCBn8KPi
 YRBksgzbE2sh79YPijFtv2E/5TZAereziWV3NrnlPGKcbJoXFuiCDZzagkqgRhijaaaO
 g1nr1aMy2qfCzxixmf5JOgF7tRsvI0ViLg4WquaVvKBPFn47BkUsDuBIrdrJpB7+OQnx pw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3rq6tmu6pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 15:55:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1689202530; bh=jpSCrtLeMsa01y6cjgdCmv3LpC5NOzEGKDDfFHCjbV4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CaADpxVKOPxqTv8lxf/Sa19cf348lBP6WQt/ZtX/V6qUmog5kMcY4AVOScuJjxykZ
         1IxF8GO2qIaS3/WxoDKv7SWBcVzyscr80AA4bU2pIopwCRaA2gNe8q9hsdK7lIv98Y
         hJlThJ9SZ8VizaPobE40EjaBN4whr9G5CF8wbnAxWwmfBRnLESYB2tCrfiSt8vXmkE
         fs0EYP1Y7IC3oqrhZLH4DNjdY2EkKSvSw6uPwnZnEz8qgBQ+Lhytp2VIJ8Os3TrUwm
         qu8dJ5MZ+MSgL6RXeb+JkqnN89XznsIvJ7PFFutflgJze+AyVYKLOQidL9hobLGWDg
         QojarZFbtLCAg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 165724013F;
        Wed, 12 Jul 2023 22:55:30 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 129B5A00EA;
        Wed, 12 Jul 2023 22:55:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=pX4cVVJH;
        dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 483E84013A;
        Wed, 12 Jul 2023 22:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKT4jpFuO6HV+YbQixynCPn3BTyIBUSOAYOM/dhsgY4+mdkWbPtQxS+Tb6Jieevful30aeHEFo8pywjPOBdeHd/z2Hv/XImWDfFUHNVqIHDJBL15Oc7OIfyKf20KdL7eemQvJYpdHg4KwN1dYo4WmccW4QDJ8MlfQhkw1wzMDW9gXtgi9GJa9uWnbRQONgHGQamGyw2KFM7Z7CyZjTv+uDwJrganp0NKSz1ahW7EOq0H3A04sfHWpZWaJOnRtstAdndSUGVVLH2U2V6m+QIruNeTMbmnhbIwe6HLlGKXhilXrWqEACQ3TiXEAEtrYzALF9ixNeDENE6jKOIVTkAURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpSCrtLeMsa01y6cjgdCmv3LpC5NOzEGKDDfFHCjbV4=;
 b=Y5nR1HU3IRQQzbLT3dgCs51F+teiulabfSU9ShwMHuKS4ICGF8efzXmMftyhn3knyQUlOG4d2ERpxLPQZoiIMwckBCsuU1gAQH6jQBIfUQ20QJsamOVL5QL9OBale83KurQN9I1DbPFQxJ9HOZ1gyT0rYkKjvw1W3XjMJSm7nhP2cM9iy1BQiRiG9eY5hAPmkm3rqAiQNi34AFfhKcf+hOahk/uNAwzD2I5NqB8SM1kZYj9GCUM/d4gqjMST2uB0VINM2HXOAzYGr3SgZzD33lUKB0wFE9RtnS5djBQ70Sq66O+S2yoQ9vLmTMMATeociULyqpB4TTE95P8BXf15NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpSCrtLeMsa01y6cjgdCmv3LpC5NOzEGKDDfFHCjbV4=;
 b=pX4cVVJHyCoYVnxFONfYi7yieeu3oq+s2qkO9bf6MWpjt4YCIfC/MG7pNHKF3pz/bk7AVkhM1DWvUNUTLUep2jInPJypBqapR2DeeAeAV5rKVKqoZQ94TYYXvvlGuUgoUa+j57Hw0pVJyBOkIh1WVohAx7w2jCGdLyEwMj2wvw0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ0PR12MB5504.namprd12.prod.outlook.com (2603:10b6:a03:3ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 12 Jul
 2023 22:55:22 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d%3]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 22:55:22 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jakub Vanek <linuxtardis@gmail.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mauro Ribeiro <mauro.ribeiro@hardkernel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] Revert "usb: dwc3: core: Enable AutoRetry feature in
 the controller"
Thread-Topic: [PATCH v2] Revert "usb: dwc3: core: Enable AutoRetry feature in
 the controller"
Thread-Index: AQHZtRH48Sq/Tgk2QUi4aRRtTUa5ua+2vbcA
Date:   Wed, 12 Jul 2023 22:55:22 +0000
Message-ID: <20230712225518.2smu7wse6djc7l5o@synopsys.com>
References: <20230712224037.24948-1-linuxtardis@gmail.com>
In-Reply-To: <20230712224037.24948-1-linuxtardis@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ0PR12MB5504:EE_
x-ms-office365-filtering-correlation-id: 15897864-be30-465a-21f3-08db832b12be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0/HLsQpd+J66HJfrkTv1TIJdOzMXT5oGHTP/R9xd1Ll6aQ2FpMoxCibaKIFZquykeWOvSP4ABQbDBbIL5o1MykvIxBnuOqbyheJFfqMFf8Kxe1IjCY/hOgmXgVl1iyXNB6RiviFyhBCQp1C7Vk85xyG0diKsbCDTwhufCFw+RGa2/QWHMQnfzPkM0DmX86/xp24V4ycTfZMLHW6mjOlK4fEvUAp6eTom6vpulKDRY/D+7wfsbPA/LvwEtutMBztcuD2M6AhhQrFaJr2+YGp7MzIiARfWq0DnFnUJQXgk+1Mt1Vm/Shymn2au6w8JpgvGacpXxGoR5ulXW4Rdxh1YvAZF/Yo1uaSReVfT3cPVgZFapgmWcK6kd/wsijB3HlscV0hXe4/rUPqhPfoNgsFmR4R0xnj1DIdmyNnAmqdtCoz9QXi4rIZuxMilzTpN3aBBSgFKuZG1IEsLKgF9SbiAei8COfrJ4wf5BRZz+zdkY0G1qgSs3kIBZF7NAsC5KYiMDfeiY7NRugfjUAVVk34WoUSkMpw4QFkbdtY2vbPPUZsvAEqUl52HuAmGLVe/HIix95QQnrqSbdsqlq4Nz7xXFqfjSvbTnrMMpNk8CetJ3z4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(6486002)(71200400001)(478600001)(83380400001)(2616005)(26005)(6506007)(1076003)(186003)(966005)(6512007)(36756003)(316002)(2906002)(38100700002)(41300700001)(122000001)(4326008)(76116006)(66446008)(66476007)(66556008)(66946007)(6916009)(64756008)(8936002)(86362001)(8676002)(38070700005)(5660300002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDZQM1dXK1hOOU1Eem5LRjRuY1c2eUVBR1FjRnRmZnRnc1hCa2NiR1JIQWtu?=
 =?utf-8?B?eE5xbGlZNjFRL0VIKzZ5bWsvblkyODlSZ1Y1czd6R0hIMXM2MlU4MVJiZ3Ir?=
 =?utf-8?B?R24xL0lFY09rMnIvVUUvRFk2RUNQSGhpb2JhZkdkOUVHSFM0cVRtaTJFcWFT?=
 =?utf-8?B?Qnk3TVptNjRnNEU4Q3labjVKeXhJamYyakRUMW96Qlg5K040UEVsS1NGRmNK?=
 =?utf-8?B?RWIxZ3ZRSEFLSy9vUnFONXdFdHhlWFhEYm5lWlVOQkZrRFVCbm5PM0hKak5Z?=
 =?utf-8?B?dndnY2luR2YrSGg5MFBJcWF0OWU5cmlSQjlYTi8vS2c2Njc1UG5EcUpnb3F2?=
 =?utf-8?B?NG50TkVEbm5nVG9tZENCeGUxU0NtMHVGRU5YK3JNWlJNTktidmhRdGlCU0Rk?=
 =?utf-8?B?UjNtNi9jbnpMU3Zrbng2QTRRUjltMnJnUGZ0QU9qekFXaU9oVUVuWEFVWWU4?=
 =?utf-8?B?SENpUXNBTnhOcFNHekhtWXRYVjllU0dOOHhCMjZrRVRQR0d6amR1a2pUSXpH?=
 =?utf-8?B?WEVlZDJnSEJsSENZK0p6TnNVY1BPUmJpNk9MV29nYzFrR0FmU0VwS2I4dHRC?=
 =?utf-8?B?UldMNStqenFzTkE4YUhBeDVqS3N2MUpwR3dhWDY2Ky9KSW1kRnRnRFNSL2NN?=
 =?utf-8?B?ZXVsTytKMFgwS0UwaC9Ba1dxK000M0J4NEc0Sm9wTmRkVm5ISlAwN0tkUzUr?=
 =?utf-8?B?LzYzcHExNVlqRmRCdEM5dkFzWjRyeGREN2pobVpCdlQrYmpxdDVrT3JLcVpp?=
 =?utf-8?B?Y28rR1MvdEN3c2tFWTVuYnZzQ214NGtmUGtEWE04aUpKbzVkZ1UrZHdHSHMr?=
 =?utf-8?B?QjJnREk4ZjRPbWNFaldFeVVKMkNXN3hvcWVLNERGRlA1NEtreUdOVVFmdmgy?=
 =?utf-8?B?KzhzY3oxRHdyb0MyZmdqbmEvUUVIc3dZVTd2SWNzay9vaWZnMzl3MFpySUJy?=
 =?utf-8?B?bVkycWw5VWFtT21aWkwxelRQeHZMdTRnaXZhWkdGRmpHbXVGOGlYSW5sWGRU?=
 =?utf-8?B?RVJ6YmVZRTJoOFlVV2lKWDQ3amhlR2hwejViQitPQXpOWmNucTFRbFBXRTNF?=
 =?utf-8?B?L04yUlFNN1ZzZUpzSU1lUzNQVTBmYWVpL2ZxN0tJdGJUUjRYaDRFeWo0ZGxk?=
 =?utf-8?B?dDZYVG9Qdk03dm9OS0F2dVNWYzhKeUVQY3J5cHVFa0pST1JDU1lyMnNyc2Jk?=
 =?utf-8?B?aW9VSlNERlV4VHVCVUJuZC9DNldjQTYvSlFvTzdnNzV0VStEcGsxV3BZNkow?=
 =?utf-8?B?NVdqWEFJNXZMZkMydHNTUkNiNnVUbGQ1cmlWby93V0hDNG01OWhSRWxKdGhI?=
 =?utf-8?B?WERuTnlLR2pLS1dnUHgxanl4TmxjdEJmM1lKTGZobmNpTS9IV0RLcmRWUjdL?=
 =?utf-8?B?cnFlK056OHdZWUQwK3hKdUNJN0tsc2VsQWZGakNZdUx0cUQ4Qkw3ZkxTSkFZ?=
 =?utf-8?B?L25IU2xKOStmQmJkZndGcDdnUHNYeWdrYWpLRUI0aWxjcFJ3Rm1CVjRuL1Bo?=
 =?utf-8?B?T081UjlMdzNueUhKL1BCRW5QUXV5eFE1YlREVFhaQk15SkZwTk8vVkN6NWV5?=
 =?utf-8?B?aGdlQVdIQjVVVnN5VlU5dVZQNGhBWWErTGtwOFBmWGI3RlpiY2FkeDVlSEJI?=
 =?utf-8?B?T3RGWmtzRDRWbWplK3BXYTRiOHhxQ1o2ZVZ3azhDb3hBWTlSZWZwT2pLWWxu?=
 =?utf-8?B?ekVSdGFwVVlxMFd5RXhTRGxkcjZhcFZpaEo1RXBaNTNsWG9PT0c5bytGZkNx?=
 =?utf-8?B?QmMrZm40OWhwZDl5U2dMUTQ0Z1V4R3FjZjZkbVhoYUpPUW53T2h3amN5eUVO?=
 =?utf-8?B?NDRzbjdueThqQ1l2bXdSbkVGODhua2RKelJTdkt6VUFNa1NkS0lveTR0dnlq?=
 =?utf-8?B?S1g1Mkt4cmI5YnkxVTIzQ0lHdlR3NXNSYXpOMlZOUFNIWFJCdTFJemxVbExr?=
 =?utf-8?B?cHdEKzBUSU5HcENNZ0pTRlIvZ00zV0E5NDVWK1RFa0hFalh1TVNSNVJUMjVk?=
 =?utf-8?B?ZjVJZWMxSjdiWHJRdEgzOHdsQU84UnZGRDEvcDhsMkZHZmZoZ0tpVUd0WStG?=
 =?utf-8?B?eFBFb1BjWENmSHBUWVVmMUc4ZUdFTVA4ZzlBNGJQd1Mvc1VNRHNVZE83cFdi?=
 =?utf-8?Q?vBKsYNNhnO9vfmWckELPMVN14?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F3E0F337238C049B43A774DB85CE3C4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZCtjZHc4MXRFR2tGbEJyeVVyZzBqNjB2Z0hocFlvZHpEZER3QlJjZEt4WUxl?=
 =?utf-8?B?Z0QzZlhsWTRDcEg5Q2VTVTJFQndKZU82TkF1bTJFMkk2aTgwUkRoVUZEL1py?=
 =?utf-8?B?ODV1SjliUTZVL1Y2NkhVaG1uY0RkMnp6TCswMFRDZW4vT3pFcFE0SDA2V3hY?=
 =?utf-8?B?NGNNbDdLRDdXTkxaRGR0RTZHTUtZUGIrcFhyait0M0lxMEcvZFdKa0YzRDZw?=
 =?utf-8?B?aUVXS0dBamdPNGQ3bkhEeG5FWTliNld3TmcvaEJUQkRQa0tVSnpmWEFQa0NM?=
 =?utf-8?B?VmVpQ2JjaDZTT2gvRUkvRVhhb1ZWR1F4SlFCZFlNK0I3MFBvMFQxbnVBYXAy?=
 =?utf-8?B?bjBRbTg1ekt4ekR0dWN5RnAwN3l0UlJ5UXpZc2FGdkg3dmZnZWJYZXJYRTQ3?=
 =?utf-8?B?eFVZQ2dhMVhyS0k4bkZhU3BGQUIzY29QRU9yQU50dnpRbVg2b0NsVHltT3FP?=
 =?utf-8?B?Q2piMHp5UnBreC92b2wvNEh0d09mMVB1cjlXcGhVSHgxclhWVDNoR0hRZndO?=
 =?utf-8?B?OWdEK25kc0FLREtUU2s5UjIyYVlPSWE2eDBXcDBlL1o5QUw2N2tRNFIyQnJV?=
 =?utf-8?B?TmU4YVZzRSsxWVNnZElhRFNBR01JdTVVSVg0V3F2OGZETFJPZ0dqd1NWM0Ru?=
 =?utf-8?B?VjduN3Q4Z0R3Nnp6NTFiZm9IbDRUam1hT3FrQml2REIyTVhSbzVUdndvOTJr?=
 =?utf-8?B?dWVXOFRHYkhRZzMrZ0wxbml0K2lhMHFRZ2xaejRUUWtOcHE4emVuL3N2Rmxk?=
 =?utf-8?B?dTA2WkNja2VwUTNyYUR3SFIxZVd0TU91UVZ5TjU0bzRQcWlQbDhlSlBjMUpk?=
 =?utf-8?B?eDFSakdVUXcrYytQYXNmbmc2MGRlU0w0ZnUwUDFQNlNCTXZvQWs3YkdsR1NW?=
 =?utf-8?B?anMyRVFWVTZnNXBCdkY2dXI3a3dIYzUwbEc5U3k5OHVPbld3UVVIQnI1ZjhQ?=
 =?utf-8?B?YTZSVVRkajVIYzBVaFhZV3BDVE5pNVJxcVF0ZHNNdmF5eTJjaHJpcnBiWXhh?=
 =?utf-8?B?VHVOVjhQenZBVDhKT2NTSFlIeDM0NENWRGlSQ3J1TE8xR0NCbmMxbWZFL2g2?=
 =?utf-8?B?bzRZcUlpRWhXd3lmTElwOXNUaXB6M1pLUU9zR2F0MExJZm5UVHFFN2lLd3BR?=
 =?utf-8?B?K1NHRkxhM3h1c3R3ckVVeXlWbVB1YWtOdlBLbmc0NTFXWUMvR0k4QVpQWjh3?=
 =?utf-8?B?TFkzdEd5bFM3RWxoRU11aHJUMmozS0dPUHU1aW5ZT0EvczlqTm5GVzVkR24r?=
 =?utf-8?B?U3JDK0tQVnluREhhSjdzSkY2VjRLSUZiRHZqNjVkR3lRMEI5Zz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15897864-be30-465a-21f3-08db832b12be
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 22:55:22.3919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HLdvqNkk4MmQgLe6+JoFxHBNUSm0eCq9jnv5gQOco3V7MjmH/CYku9Oa4R5BLd8pm/XKQkBMTV5/fetmCoEc9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5504
X-Proofpoint-ORIG-GUID: 87Q_rfT81545qs1lFJS_rs3wCX5GrWf3
X-Proofpoint-GUID: 87Q_rfT81545qs1lFJS_rs3wCX5GrWf3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_15,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKdWwgMTMsIDIwMjMsIEpha3ViIFZhbmVrIHdyb3RlOg0KPiBUaGlzIHJldmVydHMg
Y29tbWl0IGIxMzhlMjNkM2RmZjkwYzA0OTQ5MjViNGMxODc0MjI3YjgxYmRkZjcuDQo+IA0KPiBB
dXRvUmV0cnkgaGFzIGJlZW4gZm91bmQgdG8gY2F1c2Ugc29tZSBpc3N1ZXMuIFRoaXMgZmVhdHVy
ZSBhbGxvd3MNCj4gdGhlIGNvbnRyb2xsZXIgaW4gaG9zdCBtb2RlIChmdXJ0aGVyIHJlZmVycmVk
IHRvIGFzIHRoZSB4SEMpIHRvIHNlbmQNCj4gbm9uLXRlcm1pbmF0aW5nL2J1cnN0IHJldHJ5IEFD
S3MgKFJldHJ5PTEgYW5kIE51bXAhPTApIGluc3RlYWQgb2YNCj4gdGVybWluYXRpbmcgcmV0cnkg
QUNLcyAoUmV0cnk9MSBhbmQgTnVtcD0wKSB0byBkZXZpY2VzIHdoZW4NCj4gYSB0cmFuc2FjdGlv
biBlcnJvciBvY2N1cnMuDQo+IA0KPiBVbmZvcnR1bmF0ZWx5LCBzb21lIFVTQiBkZXZpY2VzIGZh
aWwgdG8gcmV0cnkgdHJhbnNhY3Rpb25zIHdoZW4NCj4gdGhlIHhIQyBzZW5kcyB0aGVtIGEgYnVy
c3QgcmV0cnkgQUNLLiBXaGVuIHRoaXMgaGFwcGVucywgdGhlIHhIQw0KDQpGb3Igc29tZSBjbGFy
aXR5OiBpZiB0aGUgZGV2aWNlIGNvbnRpbnVlcyB0byByZXNwb25kIHdpdGggQ1JDIGVycm9yLA0K
dGhlIHhIQyB3aWxsIG5vdCBjb21wbGV0ZSBlbmRwb2ludCByZWxhdGVkIGNvbW1hbmRzIHdoaWxl
IGl0IGtlZXBzDQphdXRvcmV0cnkuDQoNCj4gZW50ZXJzIGEgc3RyYW5nZSBzdGF0ZS4gQWZ0ZXIg
dGhlIGFmZmVjdGVkIHRyYW5zZmVyIHRpbWVzIG91dCwNCj4gdGhlIHhIQ0kgZHJpdmVyIHRyaWVz
IHRvIHJlc3VtZSBub3JtYWwgb3BlcmF0aW9uIG9mIHRoZSB4SEMNCj4gYnkgc2VuZGluZyBpdCBh
IFN0b3AgRW5kcG9pbnQgY29tbWFuZC4gSG93ZXZlciwgdGhlIHhIQyBmYWlscw0KPiB0byByZXNw
b25kIHRvIGl0LCBhbmQgdGhlIHhIQ0kgZHJpdmVyIGdpdmVzIHVwLiBbMV0NCj4gVGhpcyBmYWN0
IGlzIHJlcG9ydGVkIHZpYSBkbWVzZzoNCj4gDQo+IFtzZGFdIHRhZyMyOSB1YXNfZWhfYWJvcnRf
aGFuZGxlciAwIHVhcy10YWcgMSBpbmZsaWdodDogQ01EIElODQo+IFtzZGFdIHRhZyMyOSBDREI6
IG9wY29kZT0weDI4IDI4IDAwIDAwIDY5IDQyIDgwIDAwIDAwIDQ4IDAwDQo+IHhoY2ktaGNkOiB4
SENJIGhvc3Qgbm90IHJlc3BvbmRpbmcgdG8gc3RvcCBlbmRwb2ludCBjb21tYW5kDQo+IHhoY2kt
aGNkOiB4SENJIGhvc3QgY29udHJvbGxlciBub3QgcmVzcG9uZGluZywgYXNzdW1lIGRlYWQNCj4g
eGhjaS1oY2Q6IEhDIGRpZWQ7IGNsZWFuaW5nIHVwDQo+IA0KPiBTb21lIHVzZXJzIG9ic2VydmVk
IHRoaXMgcHJvYmxlbSBvbiBhbiBPZHJvaWQgSEMyIHdpdGggdGhlIEpNUzU3OA0KPiBVU0IzLXRv
LVNBVEEgYnJpZGdlLiBUaGUgaXNzdWUgY2FuIGJlIHRyaWdnZXJlZCBieSBzdGFydGluZw0KPiBh
IHJlYWQtaGVhdnkgd29ya2xvYWQgb24gYW4gYXR0YWNoZWQgU1NELiBBZnRlciBhIHdoaWxlLCB0
aGUgaG9zdA0KPiBjb250cm9sbGVyIHdvdWxkIGRpZSBhbmQgdGhlIFNTRCB3b3VsZCBkaXNhcHBl
YXIgZnJvbSB0aGUgc3lzdGVtLiBbMV0NCj4gDQo+IEZ1cnRoZXIgYW5hbHlzaXMgYnkgU3lub3Bz
eXMgZGV0ZXJtaW5lZCB0aGF0IGNvbnRyb2xsZXIgcmV2aXNpb25zDQo+IG90aGVyIHRoYW4gdGhl
IG9uZSBpbiBPZHJvaWQgSEMyIGFyZSBhbHNvIGFmZmVjdGVkIGJ5IHRoaXMuDQo+IFRoZSByZWNv
bW1lbmRlZCBzb2x1dGlvbiB3YXMgdG8gZGlzYWJsZSBBdXRvUmV0cnkgYWx0b2dldGhlci4NCj4g
VGhpcyBjaGFuZ2UgZG9lcyBub3QgaGF2ZSBhIG5vdGljZWFibGUgcGVyZm9ybWFuY2UgaW1wYWN0
LiBbMl0NCj4gDQo+IEZpeGVzOiBiMTM4ZTIzZDNkZmYgKCJ1c2I6IGR3YzM6IGNvcmU6IEVuYWJs
ZSBBdXRvUmV0cnkgZmVhdHVyZSBpbiB0aGUgY29udHJvbGxlciIpDQo+IExpbms6IGh0dHBzOi8v
dXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9yL2EyMWYzNGMwNDYz
MmQyNTBjZDBhNzhjN2M2ZjRhMWM5YzdhNDMxNDIuY2FtZWxAZ21haWwuY29tL19fOyEhQTRGMlI5
R19wZyFhQ2UwaXNObVg2M3Q2SUxFMlR2MmNYNFVucnBERm82TFhXYjZvUzMtT1lGWWZYODhpZ3Jm
cW1XNFo4VWRPN3NXejBtZGNvNnZiQnJSX0tNellhY2NwTEY3S3ckICBbMV0NCj4gTGluazogaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMzA3
MTEyMTQ4MzQua3lyNnVseW5jMzJkNGt0a0BzeW5vcHN5cy5jb20vX187ISFBNEYyUjlHX3BnIWFD
ZTBpc05tWDYzdDZJTEUyVHYyY1g0VW5ycERGbzZMWFdiNm9TMy1PWUZZZlg4OGlncmZxbVc0WjhV
ZE83c1d6MG1kY282dmJCclJfS016WWFlNzVUOEdDdyQgIFsyXQ0KPiBDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogTWF1cm8gUmliZWlybyA8bWF1cm8ucmliZWlyb0BoYXJka2VybmVs
LmNvbT4NCj4gQ2M6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGlu
YXJvLm9yZz4NCj4gU3VnZ2VzdGVkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5v
cHN5cy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEpha3ViIFZhbmVrIDxsaW51eHRhcmRpc0BnbWFp
bC5jb20+DQo+IC0tLQ0KPiBWMSAtPiBWMjogVXBkYXRlZCB0byBkaXNhYmxlIEF1dG9SZXRyeSBl
dmVyeXdoZXJlIGJhc2VkIG9uIFN5bm9wc3lzIGZlZWRiYWNrDQo+ICAgICAgICAgICBSZXdvcmRl
ZCB0aGUgY2hhbmdlbG9nIGEgYml0IHRvIG1ha2UgaXQgY2xlYXJlcg0KPiANCj4gIGRyaXZlcnMv
dXNiL2R3YzMvY29yZS5jIHwgMTYgLS0tLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy91c2IvZHdj
My9jb3JlLmggfCAgMyAtLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTkgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYw0KPiBpbmRleCBmNjY4OWI3MzE3MTguLmE0ZTA3OWQzNzU2NiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMNCj4gQEAgLTEyMDksMjIgKzEyMDksNiBAQCBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0
KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVUNU
TDEsIHJlZyk7DQo+ICAJfQ0KPiAgDQo+IC0JaWYgKGR3Yy0+ZHJfbW9kZSA9PSBVU0JfRFJfTU9E
RV9IT1NUIHx8DQo+IC0JICAgIGR3Yy0+ZHJfbW9kZSA9PSBVU0JfRFJfTU9ERV9PVEcpIHsNCj4g
LQkJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VDVEwpOw0KPiAtDQo+IC0JCS8q
DQo+IC0JCSAqIEVuYWJsZSBBdXRvIHJldHJ5IEZlYXR1cmUgdG8gbWFrZSB0aGUgY29udHJvbGxl
ciBvcGVyYXRpbmcgaW4NCj4gLQkJICogSG9zdCBtb2RlIG9uIHNlZWluZyB0cmFuc2FjdGlvbiBl
cnJvcnMoQ1JDIGVycm9ycyBvciBpbnRlcm5hbA0KPiAtCQkgKiBvdmVycnVuIHNjZW5lcmlvcykg
b24gSU4gdHJhbnNmZXJzIHRvIHJlcGx5IHRvIHRoZSBkZXZpY2UNCj4gLQkJICogd2l0aCBhIG5v
bi10ZXJtaW5hdGluZyByZXRyeSBBQ0sgKGkuZSwgYW4gQUNLIHRyYW5zY2F0aW9uDQo+IC0JCSAq
IHBhY2tldCB3aXRoIFJldHJ5PTEgJiBOdW1wICE9IDApDQo+IC0JCSAqLw0KPiAtCQlyZWcgfD0g
RFdDM19HVUNUTF9IU1RJTkFVVE9SRVRSWTsNCj4gLQ0KPiAtCQlkd2MzX3dyaXRlbChkd2MtPnJl
Z3MsIERXQzNfR1VDVEwsIHJlZyk7DQo+IC0JfQ0KPiAtDQo+ICAJLyoNCj4gIAkgKiBNdXN0IGNv
bmZpZyBib3RoIG51bWJlciBvZiBwYWNrZXRzIGFuZCBtYXggYnVyc3Qgc2V0dGluZ3MgdG8gZW5h
YmxlDQo+ICAJICogUlggYW5kL29yIFRYIHRocmVzaG9sZC4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggOGIx
Mjk1ZTRkY2RkLi5hNjlhYzY3ZDg5ZmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBAIC0yNTYsOSArMjU2
LDYgQEANCj4gICNkZWZpbmUgRFdDM19HQ1RMX0dCTEhJQkVSTkFUSU9ORU4JQklUKDEpDQo+ICAj
ZGVmaW5lIERXQzNfR0NUTF9EU0JMQ0xLR1RORwkJQklUKDApDQo+ICANCj4gLS8qIEdsb2JhbCBV
c2VyIENvbnRyb2wgUmVnaXN0ZXIgKi8NCj4gLSNkZWZpbmUgRFdDM19HVUNUTF9IU1RJTkFVVE9S
RVRSWQlCSVQoMTQpDQo+IC0NCj4gIC8qIEdsb2JhbCBVc2VyIENvbnRyb2wgMSBSZWdpc3RlciAq
Lw0KPiAgI2RlZmluZSBEV0MzX0dVQ1RMMV9ERVZfREVDT1VQTEVfTDFMMl9FVlQJQklUKDMxKQ0K
PiAgI2RlZmluZSBEV0MzX0dVQ1RMMV9UWF9JUEdBUF9MSU5FQ0hFQ0tfRElTCUJJVCgyOCkNCj4g
LS0gDQo+IDIuMjUuMQ0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVu
QHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=
