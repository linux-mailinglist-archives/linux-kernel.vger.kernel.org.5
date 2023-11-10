Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E657E85E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 23:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjKJW4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 17:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjKJW4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 17:56:21 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A801EA9;
        Fri, 10 Nov 2023 14:56:17 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AALkqvI022979;
        Fri, 10 Nov 2023 14:56:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=9Su5OmN7IXx0g9PRy/MoMPj4VDahCMo9wFcIe74TNco=;
 b=QiACMd0vXxZcI5bJfiYLHuahylAx2xrOwSLZpgfyXQ71SZ84ZzohLhMhMHyc1nU+ILhi
 CyfvPbiYyFz4qffH6D9wY4WMHeLZ6xoO/Q44swrZ+aGXe8i/IDVV+K78Ret4jGBYUFB3
 eii72KSGjZZNXao7rCJ+uprrACEzOmc8DglEECsCGtpUO/YABe7W/JRkj8775FmDOqaO
 E7d4g0ghLkeBRGQ5Iv7h4bYAP7gdhhXJu6/BsrAq18XIG4etZRaVG6+uMxey4LKCLqXW
 vmZmxNXEEJNkPempyMCpO0e69KFryD4r/b33jEqGGM+guXkYUZlQ4XtUBf9PJDiD31Bm vA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3u7w2kancq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 14:56:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1699656973; bh=9Su5OmN7IXx0g9PRy/MoMPj4VDahCMo9wFcIe74TNco=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=R0JpM7pO77YNFp8rw9wYp/imkj4tBahAW0Otl0XCX8hmTchwGLKNCZSSG9gSf/fSl
         A19KKYaOYHhPCpWh/baVkrCO/AfAtTFdjPR7p0Gf63ZwyFyE+/+G5TllnhU8Iq0Bl0
         zMbpLGsnI+JR3yJ9vm2BqtTyYxWu0v8Ww84m3dpXm9Q37J4QPkDiDE1g5J6wYPwf+v
         1sE7vvVxGkTRaaYrcc4264eTTI9sXu3LbZM3ea4tkDLdhu+e32ZkuqM7/N1DS5/XQP
         DiIMSqQcoozj55dlkXR5MkyURf3d5x9oEBahxA6ulDZ/8Z0bUAcfaKrOYvmXByV+4N
         Bmuv7bMXaZ1Og==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A223540087;
        Fri, 10 Nov 2023 22:56:13 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0DC0CA0269;
        Fri, 10 Nov 2023 22:56:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=BQRI+R7h;
        dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9F5E14045F;
        Fri, 10 Nov 2023 22:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhMsIodZJJR4cX/ZdUBojrEhCw90JJnmmj+BteE6FLiaS51kBdUomjZ8LqOxCep0BrxU8fEcKdrTqNnrjCtFA8SkdmU1p3hzM4m/ij1BdtE/OSHlepiNLbdnAho8v+rkpCycyqt6XSy9K25f6J1wDe/0pDbqcD3e5Hw/mt1XTwC64SXzXNlifsnzBcJTxaCstsTK6Pd2A+52HqWJBYK6sTUzh+Eg9hMTmDx0mm4YD0cCEd1hfQ4iqwMDcavJv6PjdvpWtvEyQzQVMRg0toWlbZZqxWrCFamtYZlP0MiwEapiKwm1BjwDptmAXLgAnH8yFuzxzz6bFpr1ZPMzWj5GFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Su5OmN7IXx0g9PRy/MoMPj4VDahCMo9wFcIe74TNco=;
 b=UcNvzLlccuKDZHhN6yW2wfAO4usVGhl5gqVzwOJAngof3WLucaeWWAdP9ZVshRryYpCJcCeggLF6DB2/WsC+32GhUAoM/q8XMKSJiLFFTL6ZD2eCWocFrFcCIs7yjCz2mbyJAKlfUzPokBGeC8/rgQ0Gc2DOtw4NUcAdJXred2Kn3WVPqRwtyef9isBas8B4eA7UhNOXRFr9xLUF6UGjmd0K+dtgcVpc/IIYFjR5ItSUkj8fJTr3DNX6s2goMmFze+vAdfeFw6ujGxobA+AI49dd6owXaShL1Cv60no5RqB0kkkVsHRpkz6jNyWoNCwVbFj8g25RBUXHWP7GqMomYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Su5OmN7IXx0g9PRy/MoMPj4VDahCMo9wFcIe74TNco=;
 b=BQRI+R7h8s6VJ1T2UztPw/2U7OBr+oFq0y+YC+eixcJn1pIbVAd8Beh2VVp9/b8ZIB9rk770Y8HtEla8RI1FU+fqgaLqPcXiP0BecazqB8HjEDgHc9WjnzYSqASgI/BBjku1Ta5xZJ9xr3Qm1gkmwlXAaze7qE+fFBq09ZKc+D8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 22:56:08 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 22:56:08 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Zubin Mithra <zsm@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: set the dma max_seg_size
Thread-Topic: [PATCH v2] usb: dwc3: set the dma max_seg_size
Thread-Index: AQHaCMi0LFnRXVHWjk+Pu6ZWajGyOLBkkKeAgA7YboCAANc/gA==
Date:   Fri, 10 Nov 2023 22:56:08 +0000
Message-ID: <20231110225507.cl6w6vkyb4dvj3uh@synopsys.com>
References: <20231026-dwc3-v2-1-1d4fd5c3e067@chromium.org>
 <20231031232227.xkk4ju3hxifj3vee@synopsys.com>
 <CANiDSCvEyjHFT3KQbsbURjUadpQYEfQ=M8esdcHnpWe9VsK=2w@mail.gmail.com>
In-Reply-To: <CANiDSCvEyjHFT3KQbsbURjUadpQYEfQ=M8esdcHnpWe9VsK=2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH2PR12MB4037:EE_
x-ms-office365-filtering-correlation-id: 779050bd-c5ca-4fa5-bd7e-08dbe2403a52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /FOpEesi3ewRwk2g5loZGKt4QrCWyxX3JZ5u2gAMBAtlZwzAifZa2SmydWJavDM9dJbZzjA/5c4aGAW2UFFvtZmKNleKrX8Nuose15G+FdBLUwG50+vKKP3vgh0Y+mGbVYR0LhwRiLDrwNy8IbyH3/D8jMshsYvxiRg9KGf7JMY1ojmwrVMoZrrC8sqpeoxiJaOVyq5Tlude5yv7boL1kRmwn2Ixn60oEtqh0ibEnWOs67lHE9lxfUspD3GAxts7SGRFRpvyfEDOz611nEj+BETQWTc7fnrZJM1tt/toqq01zPcx0gcRjvbVPxl0NBzyILX094xwr+5etwZDMWGdaO/rXUuQBRinRpd3L/yP4QrSfCYOakwKr+PsbjSs0MfIgCfmfJKpbFXj5HXjxTWCXZIHFHzArVghuKNkjzbAW1jVassGLgxzFB9JiMTgQDexXqinGzO/gmFkODap9XP/GHHX3GSlQgKeEMcrQQTOZy6lFrGnSpcuHTMR5Wp/69qG777HjdLKjY7L2m1bnZXcswuykkFFyISY4sFZbEjmyWwomPFKRQsBHWAx4S5HJFxU4itXIOpwUFzXfVZB7bFRyZqvzbXYxDYkwIMkLUE0FwcNAo4JN+iuVaUecCxLFo+8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6506007)(2616005)(478600001)(6512007)(6486002)(71200400001)(66946007)(36756003)(558084003)(38100700002)(86362001)(83380400001)(122000001)(54906003)(66446008)(64756008)(66476007)(2906002)(26005)(41300700001)(1076003)(66556008)(76116006)(38070700009)(316002)(5660300002)(4326008)(8936002)(8676002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUNiUytiTytwL3FVNTZQek9MNFpWZ3phMDVMaVNPQ1JqRlgzSXpseXM1cHl2?=
 =?utf-8?B?R1Q3UGJ2TXRuTXRqRTVVQ1h6N2VtWWg2TGdzUXBFT0k0eHgrNEpKcDdOcm9t?=
 =?utf-8?B?dEhBK0Vra05XR3FENWd0bGVoT09uajZMQk9uNS8zUFhnYjdjeW12aHdOWE13?=
 =?utf-8?B?TGRDWVF2ZXp5ZklHSi91a0J5V2xvUFRBdkxvTTgvay9pbTV5ZnhKdE41eGxW?=
 =?utf-8?B?S0locVRxb0N5WTFaejMxVVpTTVlXOExrM3kvL3luUHF6eDROak1KZkkwTHFF?=
 =?utf-8?B?d2FuUjM2Y1NvOXhQSWNqVHlGZXdjRVFVZWpLZ0JYc2dlQk16Z1o5OVdvVC85?=
 =?utf-8?B?TTJzbEFtOEVFdTJLZXBpNzB6djFUYjhaZExMVHRkVU9lZWZuT0hzMkFabEhI?=
 =?utf-8?B?MmhHN3kzMTJvNjVhODBCdk0wQWpBejBMTXp3N0ZqTGRXUm1TaU1HZkNjaDMv?=
 =?utf-8?B?bnAyaXhJNTdyZXluQThUN2w3YVZNblU3dStSbnk2S0pYMFMzOVB3dTlhcVBO?=
 =?utf-8?B?M2V1dWJCMDhYeWdwSGErQ0RKN3B4dHViQWNlV3JBYVphUnNLcm9YZUhRREZY?=
 =?utf-8?B?NGpzVFo2bkI2NERCZnFwNmtSR3E0NXFiN1F5M0thNWlZaWhTM25raDdtTE9Q?=
 =?utf-8?B?dkpnZDUraG1McXVqZE9uTGUrUml2ZFBBUzIvSG1JSFBoazN1Y0RnU1RLZ051?=
 =?utf-8?B?NDZ3MlFFSGpvSnA3S21Yb3o1NDlONm42YXEzdzRJYjBMN0lKZWVPTnI5SFVX?=
 =?utf-8?B?OXNSQW5UdGlJN042SVZudG5ZSVQxbHEwUTNYMWtrQzhVazVQbW44ZWFsSXl2?=
 =?utf-8?B?UkVaWEFabldaVDdTUHUxeE1NaEE1T3lpdCtJcTE0RzRZNjcrMTFWcmtXUWR6?=
 =?utf-8?B?ZzhMeC9FUzNLbmtYMFVNeUJobk1saWMwV0V0eGt1MHhHRU41UVdWWFM3V0Y0?=
 =?utf-8?B?bUl4azJ3WW03K2tCNHdBWEFRRk96Uy81LzV5SXU2RTlONElseE55L0QvbjZy?=
 =?utf-8?B?TmxBMnN4ZlpnbEJZbkExd3AwZWpDY21ETGFlZHhneEI0SWhHSGhxYnF4ajVK?=
 =?utf-8?B?eHNIblVOMTlKOHJDdVAxbGNsSVJ5NlVDWG1UeWRjQ1pQQm5McE5raXdmMWpU?=
 =?utf-8?B?emZGRnRXV2RJYks3QzMyeE44emE0TXQ5RFJBMEtUQmk5L0M1Kzl0N1ZObmVa?=
 =?utf-8?B?TmUrR2NYQlZPVnBiMVRlS1BFc093dmE3NEtyVXlTRDA0ZFd0T2Jtc2xENFdo?=
 =?utf-8?B?cUM5ZWNBbm1qQUIwdHRPWGJLUGgxeXMyWFhXTEx1TGZrZXBYeFVGb2NMNjhX?=
 =?utf-8?B?eHAyWVkwd2YrR0s3Zm9TZlBwblN3R1lQaGZzZms0eEdvQklBalRzOVFkQmtP?=
 =?utf-8?B?NUZhSXZFQ3NFeEcxY1JabURZTjg0eWQxYy9qZTVzbzBGeFhhaHRIOFBJK1B3?=
 =?utf-8?B?c2lXY2pWY2JYcGxvbmdoMGVZcFBLSnF2a2s4VTJETCt2eGdSdXhxK0xRMGVD?=
 =?utf-8?B?Wkp2RlhvMnJnZlQ1QzJVYzlDK3BVcEg0Rnl4RWpyRDBVYk8ra1J4ZnZZS1BT?=
 =?utf-8?B?MGxzKzVzUTIrS0ZaY3RwUkdIclNWRWJRVVBxOWwyODlHM0JJVTMzRzVDanVy?=
 =?utf-8?B?dGlJNit6TXI4T3RjUGV0aHlLRFVjdmNJK3JYU0kyV0c2bFZpYXoxQnAxUjIx?=
 =?utf-8?B?c0llSDdGamw2b1ByRUxsOTVWNU5JclhuZE5EclJpSCtWMnNTd2dBTEIrUTl2?=
 =?utf-8?B?Qm5BdjJTWVFUdnlNOGhCT3U0eHdVOGZjZ2pHZWZteTZOcmg4WU5SR2NGRy92?=
 =?utf-8?B?UG1HWk5uMXpFdnZwNnY3elZ1ZXF2anJ0amxtOGd4dHFPcnJHQXQ4amdkM2I3?=
 =?utf-8?B?RitoNWhEK1krbDhDcVlIT3VRNHdrRHRhbXNoeTlqRFFPUHY3TkFrdkNVb3VL?=
 =?utf-8?B?Snl2cVpEYXMwL2hBY1FIZFVvSW1oREVlSHNteVdRL0FhOXlCWG80VHNVZFFy?=
 =?utf-8?B?cTVpMDBYYmhNb2RISkpLNHBHTW03R2VjVHgzZkZ5NzAwbXVsSkVpVzdNaXkw?=
 =?utf-8?B?RUQxd1VUVmp2TkRuK0F2Tkk3T2ZneUgyODhVcnNLK3VDcEtWekNtOEYwNTUz?=
 =?utf-8?B?QjJjRHB0Z2c1SzM2ejhrZytVSk5WaXhZK0xSWnJHR0xudEdLN1FOZHZOdmZ2?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D785790ABD399D48AE5C93AACECC349D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n9dpVD3eh1WKV6AIbBwfYUdymulf6lMKG5Xa64nz0cr4GcrkFrRbjZI3WHbgG1NkoTQgMGvbwVObaAUo5R5FmBnssOpwJYuTX/cXm3Kaln4N9gpKojBXF+z6DMiop5w2t4HexbBuxC0mKullLalbDdfHnjqgj1cn8f5wZ+ZhV/C9b48IxyU9Tn1n2042xkKthz9/Xm7mKDg87JeoDJXGDQpXuCb3BJcj/3qYDCTsZgQSv+1nimCLzHmgOzAw59YZAmCuZdf88gnR0yrmasnWBbqPHsQUcYBMhwJMdj3J007zYcfHOh6m8m833s1R/iEV+1ixndzKf/qJvGYmsbq+4kYcW5hf34NyZ+e1LhT2Mio7LUVBcMZyBTM8KPc8L8bWjcitM/QGrcS1IjiLQEWmcy/oscNGN21sbNcIvQZtCqDXUqVLPj1d8aU61IzpYq9pbsorcLFZaQzChILGVhd4y9zy+BDeuvhEazv98FdWr4UbyXX9PI5bdHCrcRE/VhWkX9R8CiXa+vW9goalSJeSSOCCt+i1bnugzd7YqskNUzRQVAMytNIkFjwZvfWtJRP+i0xXCH1W4jTqcusNPHB+ZM8DB/Ay8sV+jG1OX8i+aCgx9Dwu4pETMqMmL9yCT9lNsRXdvi9iU48UayF/7OP1MU0udEhBPpdV9bFovRT061T6VNC4+6j9AM+Q1cMtePEpM4U0xvU6p4SxivcoGImQUqX7jNo8XveCX9q3cUnFJeuuYY5IBVAaSUSucLsmULx4XYxRYt1axK3BKWIPI28wXKd3qkk0q7Y7Nlb73mKqUUd3Jwt59fW39Dhepq1KN1R7kQ3O/WbDS1y//8BGEGsYbjz/6B1PPevUX1MEIjy3kU8ONhdXoCGGpSkLMN2frqHvj2rfCHqkKgT2Ju5JXuSaGA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779050bd-c5ca-4fa5-bd7e-08dbe2403a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 22:56:08.7068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IDQcR+vaSjTANVVEtIyR1GtgWunTM62+SCpakMK8qUZxb0GUbWWuu1OCuO/fD+n+WdQXR8QDJzAgtSTKRt7r3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
X-Proofpoint-GUID: KeZI_K0erYOn2sUGYQLBk_FDRunK_fYu
X-Proofpoint-ORIG-GUID: KeZI_K0erYOn2sUGYQLBk_FDRunK_fYu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_21,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 mlxlogscore=283 lowpriorityscore=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBOb3YgMTAsIDIwMjMsIFJpY2FyZG8gUmliYWxkYSB3cm90ZToNCj4gPiBQcm9iYWJs
eSBiZXR0ZXIgdG8gaGF2ZSB0aGUgQ2xvc2VzOiB0YWcgd2l0aCB0aGUgbGluayB0byB0aGUgcmVw
b3J0ZWQNCj4gPiBpc3N1ZS4gUmVnYXJkbGVzcywNCj4gDQo+IEl0IHdhcyByZXBvcnRlZCBpbnRl
cm5hbGx5LCBzbyBJIGhhdmUgbm8gbGluayB0byBzaGFyZS4NCj4gDQoNCkkgc2VlLg0KDQpUaGFu
a3MsDQpUaGluaA==
