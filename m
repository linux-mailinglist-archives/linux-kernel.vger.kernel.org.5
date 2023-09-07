Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA8797F6F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjIGX4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjIGX4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:56:12 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CE11BC8;
        Thu,  7 Sep 2023 16:56:08 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387Msf0w025949;
        Thu, 7 Sep 2023 16:55:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=x+hYQTLcx3azPhW3yWRCF9nI/EVivJbFzYEnsjLWJx8=;
 b=MaWpzXDOk6Dz7MlW5JkWRmdjYeAC4LtRPmhcPfm9OTEb/++I6IzrD5oXNUnWhQZuYTm0
 YozrsBoV53iLTCGUqHXvALexZPy1hqEXHsQKhC6Bos7p1++zOOgYrA4d6frpKWwIx2hw
 qNutFdPpnOu+TXd5kBqubsFjOfYTskKnqVAOyAopoRb+Zeo4L+myFE5S9tkn6ZFQvHUH
 deQLkB4Me71faZkDYFupi1x3Dp7rSIUPfZ2EW5bbORPJypfzRJloXmTngl2RHgrtcO9A
 a9w5lf4EbBzgkUGB5/dh6XljeijNArQk2Ew38WjIfO2NQp3E7M1KB7YcxWbQSopvNOR0 GA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3sv42n1mud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 16:55:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1694130937; bh=x+hYQTLcx3azPhW3yWRCF9nI/EVivJbFzYEnsjLWJx8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Ushw5WtxEhLwkukidGFlvi4VuEJdXgQ/p5D1L/iZkR3F/4ddbEYRuyxrMGrYPX1Sq
         H70+Gk15F2n/HLKBwpDhhuyqr+lMqtd9PAP0/zfOu11SfEew5QtQtzWjBG3FBQwjiq
         Pe0RoXKZhF+ojctf824JIH7j8aqyytMA9cC/4puvqFwzr+xMslNps6I19g21HWk9Ds
         gs4cpjVH1k27yO+fP9E7m1r8HRqW0AntPIYD0BjZ2LSPAS9MFM10bmSKwX+TiFhFEY
         66jPJr+01rJQWz1xDZEvOGqrspyIbABM2Lnj+WZyWYB4GRl3nnEDO9V53bTEXiUf/A
         SoIpFnGuCSlkw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A2AC240127;
        Thu,  7 Sep 2023 23:55:36 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 900AEA0068;
        Thu,  7 Sep 2023 23:55:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=omHJThef;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7A7B740356;
        Thu,  7 Sep 2023 23:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4FcMxRy0vCJDXNGM2LrXLXqfemLzFNPxdeu+YKuhImxH+ZaEDblu6/gCPgB9RafrxKF6KJEbhCJupuKWk8PsNovi110GkNXGVfhoFq5tZIWX8u7RcrGANmjUURRBOtQTWqExIvLgGlAVXXpqN8KTG3xOibmC0hI1U733NzyLa+g4nTUM9pLGy2rT+C5Nm8mXFlz68goB3wFrn1A5DSD3DiQ3x1gx0twj418djtLCI4pA+UcvyWbTFWBMKQMOn0e8G/MFvn7/e2FCadSeRp8QIpjT36LCCDudSyrrlTy5HVDk89A++if4MFj1RJ26tKeDTEwdAIgCdgkmsptFfKj/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+hYQTLcx3azPhW3yWRCF9nI/EVivJbFzYEnsjLWJx8=;
 b=jRPPwFNTnyEgRaGNs+c2T3GweFHW2GbT5gVB8AcFYEsWB3BpYNKgPfTr1sCRrdt8mh0XM7TtAgrgDx+KWT3hqNkw1UV9kNRQbL+aMaKP5IQbQFVG/g1RMszOSq/4fak/4Id1VBv4iU0x0tfFWapBeTA3lPBeUC+bb5UYTHakBVDz8hkvORoDxaC4Fsqi5rWkTAbzP692oVUm5pDJi5HdJUeic+N+VfCb3CHSZ9AuWp0ZtxMCc3iFl/zb8Sbh5eQg3M7bcw1IwRRaLrunZb4e08O3YgbKb/gmcCRlutlctsi4FtDR6Hq1JpUtEq1gGYpmjToFQKzz9tcUf6JFRGhPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+hYQTLcx3azPhW3yWRCF9nI/EVivJbFzYEnsjLWJx8=;
 b=omHJThef4HjD+lJn9bsIu9uBDrhOTRjvwnKk0HgSWf1/RUOL/AIjiYVpfEBr6mU3u3DKHoYpgT8dOOyx3wFWpGIEhydF3TX9dFGXyvQz5P8IhaBQgiaHEmYsAR50+bAV5tBVJkPlkiYxNqSLdwsi1S1oMztV+5kKCco260NfuDA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 23:55:24 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 23:55:23 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Kenta Sato <tosainu.maple@gmail.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux Stable <stable@vger.kernel.org>
Subject: Re: usb: dwc3: some USB devices not working after 6.4.8
Thread-Topic: usb: dwc3: some USB devices not working after 6.4.8
Thread-Index: AQHZ3sHpFemvEWcgE0y6nzvaTFcKdLANBmOAgAKi6YCAAGatAA==
Date:   Thu, 7 Sep 2023 23:55:23 +0000
Message-ID: <20230907235514.hqxd4gti3kentiw2@synopsys.com>
References: <CAF1eZtsBzGb_UxOqZpNiEsk8Uk7DkqPh5AnYRRNc_kkr-tFasQ@mail.gmail.com>
 <ZPUciRLUcjDywMVS@debian.me> <20230906013209.jlcxluxemyg3va6l@synopsys.com>
 <CAF1eZttzvPt+j6S0YKnCXH+k9fWYDc-2Z4DLdgCgZrf3tcXZPw@mail.gmail.com>
In-Reply-To: <CAF1eZttzvPt+j6S0YKnCXH+k9fWYDc-2Z4DLdgCgZrf3tcXZPw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH8PR12MB6818:EE_
x-ms-office365-filtering-correlation-id: e0d8d905-ab96-476b-92a2-08dbaffde6ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AQyZpRBZ0kqs8y5DR/0gKJpvQ+IgxEaAwgWjS2kwECgxDgOxzGiiwR+NzF9sv49KxFWngO2jQd5QXmfIK2g5qM0Zi2Nwqpx+cR9eBj2zSAdUeWe6LJIbQ+g4NQ4GTiYFdYPNiLBt2pAoctYiCSJAyq50qm+izZL5Z7eNEziTXgw+GmRQgMTvJO9vdLNCK/ympiCj7eRnioDbufi6f3KYpGC2MALXAgPmwmuK6DgveYRpHVVjITqJX8MZugZx4DsrBKlq1ns3hElbBm73BPzTjgAjeo9aS3CVAU8D57QujZTtHX2UZFHkxWHEC1I9YFWBsA9jjHXcf2OsGtyVqOuIbct9jeCjILmUquCUTHNda9JeJdmN85+/nQyrqtuZOGj7WekshaN45SuLIdUEIZV3qgHHvU6m5ZyP+kOJvJ744iy6HYx1mo20vGRnCzWK0dX96KWBGd9df1xeWKAMUZr8wykN/KBUy++EOVqwJQM7s6sfN3kulfAYf6YFamptVF4Zthmxf/R+CIkU+EdkXuvc6bvIKnR7TxAZO83zYoZmF0lic0WjSchnooNPhzmZ5SZCkWAC5QBnyPAcuf6qU5cZDFY2pCD4pr8vLn3osj4/xlCFKkcN1BVcEDwo4+9Y6sgK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(186009)(1800799009)(451199024)(2906002)(86362001)(2616005)(1076003)(53546011)(26005)(478600001)(36756003)(6506007)(6486002)(71200400001)(38070700005)(38100700002)(83380400001)(122000001)(6512007)(41300700001)(8936002)(8676002)(4744005)(5660300002)(64756008)(66556008)(6916009)(76116006)(66446008)(316002)(54906003)(66946007)(66476007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWtYN3h4TXBNWm0yaGlKRVkzdnlqdlJrVnhpbmJ2d1VWRW1rMjRORmlNOG5u?=
 =?utf-8?B?OEwrUlpDMnU3YW5iOGNuQVluWGZ5UFZLZ2R3bWRNOUFBUDFCMlJyZUNseXkv?=
 =?utf-8?B?cS9pcWY3ZnptM2MzZVZkNmJYMjRNU1lPR0RDN2F3dnRlOUxCWjVTTUNLQWxt?=
 =?utf-8?B?Q093Ynl6NXo2QUlNZzFlRXF6VGtnS3lYbGxHVEZQbFFkMDlydlhweWRYRE0w?=
 =?utf-8?B?Q2RvMWlaNm05aDhsVHJuZHpwbnl5d3dPMjF0eDEwQXNxSFVhei8xVnh6Si9R?=
 =?utf-8?B?Vnh4NVdmQjVNWUVkZ2JPRktyMG5NTFJZdUs1WnoyV0N3L2tDc05LbHZkeTZK?=
 =?utf-8?B?QkhjU2xDZWVLeXhjZEJMUUF6RFRZMUdpT1dKQjQvN2NHNWlhMUVLa3UxVGNj?=
 =?utf-8?B?OUszcEM0VTNKWEMwM1V6VkpvZ2xTUG8wOGk3K2k4OWxLVUE2clFsaGpWT3Zq?=
 =?utf-8?B?b3NUZktFNHdyOUJTcnFEUjNScUJqTHJ1L3FHbi85WTNwa05NNFZPTXVhR3hG?=
 =?utf-8?B?MDhqZmE1eU1SVmxtR3I5c21iczhiNTd3Z3dFRHUrRzJsaXZZVS95eDhxODFh?=
 =?utf-8?B?YU5sdkh5WllIakMxdXBMdzdlZ05GSncxWUhieWV2N2JuR1hOcC9kTUxhQkY1?=
 =?utf-8?B?ZVp3ZHlxcEd0YnNVZExpU256QmFlUUpZV1ZxcHNEVGdJWHZ6RmhQeWp5L2VZ?=
 =?utf-8?B?WTVLL3pqT2lJa0hiY2ttOFltVVNybmw5UTVUVFdKejdYanRBM2M5a25FaTQr?=
 =?utf-8?B?cUtSK2pDQWQ5a2kvVHpSdEpiWjFLYXMzMjlJSThLVDQzL2VmeUxtVjZVUUp2?=
 =?utf-8?B?Z0dHanI2SHFPYUNNRXY5ZUQ5aEJqTEhCYldKRS9FaU5ZWjhTcjFvL0tvaDhU?=
 =?utf-8?B?QzBLYkZ6VzBhL0NlK3hmalhKZVQzSGJSY2pVWTJJN0g1ZWp2U2N0UTcvVDBz?=
 =?utf-8?B?VkUwRzlDU0psRXI4WkhQNFQxRFFrWUdDSGFVUC9XUVF3ZWtQcEZJOC8vMEFF?=
 =?utf-8?B?dklsRWMyODFtT25ZM0M0b0FpNFh1MDRiM2xaWnl6ZlZ2MUd0ZkhPL2JYNWJj?=
 =?utf-8?B?YzlMM0EyL1BVbmo4UVFsVGFzazkwYm9Belk1MVl3TGpUdnJRMnQxRDRaZUY5?=
 =?utf-8?B?bi9sWXBRQi9LckcxclpXMzJjZldua2kvajFiNWc3WGlhckNYckNBOHpCbzhz?=
 =?utf-8?B?UnFJMFRnN0xpN25mY2lnNnlhZnFoVlBKdE9nTGdVQVVobTNFN0xYYVpNUUJX?=
 =?utf-8?B?NDRwMjdVMXhIcGJCdXdSVVdtazVvRlF0cVVjV1huYjBEcFVxMWQwbFlOTUds?=
 =?utf-8?B?MEZGbTF1QWFpNWhwbXRGdEQvSkM5dW5qUWRnNTA5KzhNQmdMaHZpbFVLYmFR?=
 =?utf-8?B?bGNqU0FQL0J4cFhxUCtGN0JLOW9EUm9GU1NTVjVveCtpdUEyWWMzQkg4aXFD?=
 =?utf-8?B?em10bDZ3cEFUR01WVTNFdGVQZDhuL2hlM252enlmcXRnK09CL3J3bVgxSlNR?=
 =?utf-8?B?dndURVNRaDdOQ0NzMWpKazdhZEhraytPUjdlQzdzNXpKSm9oMWRLT0ZxZDZT?=
 =?utf-8?B?c1hoRVdNRWJOdTZ1N3lPRjBzc2lxQW04aS9pVTVoZVBiYSt6dlNtb1lzd1pk?=
 =?utf-8?B?VmVKMWJ3OUxFMUtpbFkvdWIyWUc0NGlDVVlsTHNKZDNqOHZhVzk2YzJQY1pB?=
 =?utf-8?B?ZTh1QWhGZHJxMDJmMER5dTg5K2JBa1poK0x3bnkwSnkwN3ozdHlYNmY0enA1?=
 =?utf-8?B?ZTJMOExGcmlXTUR2QUJaWC9FcmY2QzB1dkdZNmkzdktvelBKOGU3V3lCNHVk?=
 =?utf-8?B?bzNTM25YSFdrVlJxTzlDQ1R0R2pFWXk0Vk1BQ0NMbFhVQ251ZGJoYi9ORGpY?=
 =?utf-8?B?WVN1dERPMjl5RTZNQUNQbTVacTJJRFJTSWlldnkwQ1BpU3lwdjNlQ2JVT1hx?=
 =?utf-8?B?NGx3d21XZlpzelRkR0RXV2c2bUJ1czY1dllLdG95NVhPSXViMG5aWEJ1d0lP?=
 =?utf-8?B?TE9sTEJQSU9MSkpZMldyKzhQdkd5U1F0TWZsOUpZdUkycFowZ2p5T0VoUW42?=
 =?utf-8?B?ejlMRlhSMGEwaWVnaEQzcTRqdzNPeUVzUWxOcnJwSTNnU0x0UUVTV0Nld2Y2?=
 =?utf-8?Q?1x2Tnx6Z4hqb1/m2fPRQ6eDJG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7E9BB1E9459C84D9340A2B10EF22ED3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NmxBRmsydUVwR3dwUmNWbFFvUXlJWmhFS2dQOG1JVSt1UkFoOGt4RHd6Zkdj?=
 =?utf-8?B?T3p3RTBRUHB6MUg1VWp2MkpIQnJ4a3ZYSUFWZzNkZG1XcjJ4UzJ6QkNsZ09w?=
 =?utf-8?B?aXM1eFl4UlRXbEdUaEZ3VzEyZ0Y1UlIvdENQY25kYkZsUkNya00wTVNkRTBu?=
 =?utf-8?B?ZHp2SVBUb01LbEZWUlgvbW1rcFMrMXNiZVY3cHpZZ1NWRjRrdVVZZmp3aXAr?=
 =?utf-8?B?THZTaysxTWVVTlo1QStDQ2dmWDdmMmlGSUhaUTlNcXJ0bmJod09sbXFQMnpo?=
 =?utf-8?B?SzlyMExwQnQ3UUZzSjN2dGdZcHNxNkpvM2haSGRKOERiaEFKdnl0Q0s1M3RX?=
 =?utf-8?B?MVJSRWErQ0NidzU3UE0yK1k0N3VaeVRieGZnOVZOTURkcnRLVVFkdTRqSXlp?=
 =?utf-8?B?aFlxTFpJMzJBTXY0RU1YVWNzejNJK201Q1dPaGQ5cW1GOE1KTWRKY2VicnZn?=
 =?utf-8?B?anA1OGdKblJzcCtuSHoxUXBhdnQ4MW9SWU5YQ0JZTEVXcFk1Y3dlbzdzNWR2?=
 =?utf-8?B?V2RrSkk2bjZMQW9ZVUt4QWpIVTBKMHV5VFgxK2xOcTBWQ0l5UnJJckF5VURX?=
 =?utf-8?B?eHdMa2dLRk8reXhWQ1hWaDZ2dXlwN0o5V2dDb3l4eDgzRld1TnF3RXZQTGNt?=
 =?utf-8?B?N1J1UXVXRWUzcVpBZjZKUmhjQS9kaXpQNVZ5Vk92MnlvVE9xWUtHVDh2aUo3?=
 =?utf-8?B?WWRmOThEemRHdi9nS2tTZG1kMXBuQ1Y2S2dWOVR1RG44NHh2dnFEK0VMSEJ2?=
 =?utf-8?B?dEpCRHU3cFhuNFYrRkpIbHdLaEJRVTFBajJlcWtvbFJicDBiVjdYRFdIT0sz?=
 =?utf-8?B?ZnVJNDhycTUxbzcyOXYzd1VwVGVOY2ZjbzZjVU1sTnZDdHZ5bW9Sa0kzSWkw?=
 =?utf-8?B?RmRKcmdBbDlxM1RreDVWTGx4YWROQnVjUjErYXJvM2VCdmFYeGZWY25aMFBs?=
 =?utf-8?B?WVNzNUd4VlBlcFlqS1M3YWZ4UUlVS2lJTVZlZVNxU0FtTjJLM2VoWTlzTjZn?=
 =?utf-8?B?S2QrNmhBek5ENVBSbm55UHhsVEk3b0dPbnpMWkVkYVFPS0ozaWJJTUNmR2h0?=
 =?utf-8?B?SG9JdnFjdjhBQ2NLU3g0b2IxNHNwVkp5OWRaOWVsTS9OdzhaT2Jkb0tvRzJ4?=
 =?utf-8?B?OU10TFNhQ28ycnAvY0VKcEZyRUMzNVFmNG5FRk85bWF0VFMrUnh4ditsRDNk?=
 =?utf-8?B?UnJrVlpoOCsvZ2hzWktCcE0vZkNrY294SWU3ZGpGRGRwWTNhdHNPSTg0dkln?=
 =?utf-8?B?SWpDOHU5WkdtcHJ1azR5T2IwM0dMV0IvSWswNzBlVnRTRUp6UT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d8d905-ab96-476b-92a2-08dbaffde6ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 23:55:23.4479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GhY0qC+2EZHkSbxm2NOft/XAtUmHPt9hkh1aKZ970v5YWqjOADjTzbPSXvu5OumKoVnep3ufBB7YEOYg/yagyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818
X-Proofpoint-ORIG-GUID: DsimcCnSElKc4MTpnEcOijUvaNA-dXjo
X-Proofpoint-GUID: DsimcCnSElKc4MTpnEcOijUvaNA-dXjo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_14,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=1
 mlxlogscore=209 clxscore=1015 priorityscore=1501 spamscore=1 mlxscore=1
 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309070211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBTZXAgMDgsIDIwMjMsIEtlbnRhIFNhdG8gd3JvdGU6DQo+IE9uIFdlZCwgU2VwIDYs
IDIwMjMgYXQgMTA6MzLigK9BTSBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5j
b20+IHdyb3RlOg0KPiBIaSBUaGluaCwNCj4gDQo+IEkgdGVzdGVkIHlvdXIgcGF0Y2ggd2l0aCA2
LjUuMS4gSXQgc2VlbXMgdG8gc29sdmUgdGhlIGlzc3VlIGFuZCB0aGUNCj4ga2VybmVsIHdvcmtl
ZCB0aGUgc2FtZSBhcyA2LjQuNy4NCj4gDQo+IEkgYXR0YWNoZWQgdGhyZWUgbG9nIChkbWVzZykg
ZmlsZXM6DQo+IC0gd2l0aHBhdGNoLmxvZyAtLS0gNi41LjEgKyBwYXRjaA0KPiAgIFRoZSBrZXJu
ZWwgY291bGQgZGV0ZWN0IGJvdGggVVNCIGRldmljZXMuIE5vICItRVRJTUVET1VUOiBmYWlsZWQg
dG8NCj4gaW5pdGlhbGl6ZSBjb3JlIiBtZXNzYWdlLg0KPiAtIG5vcGF0Y2gubG9nIC0tLSA2LjUu
MSB3aXRob3V0IGFueSBwYXRjaGVzIChjYXNlIDEpDQo+ICAgVGhlIGtlcm5lbCBjb3VsZCBkZXRl
Y3QgIE5FVEdFQVIgQTYyMTAgYnV0IG5vdCBCVUZGQUxPIFVTQiBGbGFzaCBEaXNrLg0KPiAgIFRo
YXQgd2FzIGhhcHBlbmluZyBsZXNzIG9mdGVuIChhYm91dCAxIHRpbWUgcGVyIDUgYm9vdHMpLg0K
PiAtIG5vcGF0Y2gtc3VjYy5sb2cgLS0tIDYuNS4xIHdpdGhvdXQgYW55IHBhdGNoZXMgKGNhc2Ug
MikNCj4gICBUaGUga2VybmVsIGNvdWxkIGRldGVjdCBib3RoIFVTQiBkZXZpY2VzIGV2ZW4gaWYg
aXQgc2hvd2VkDQo+ICItRVRJTUVET1VUOiBmYWlsZWQgdG8gaW5pdGlhbGl6ZSBjb3JlIi4NCj4g
DQo+IFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgbmVlZCBhbnl0aGluZyBlbHNlLg0KPiANCj4g
VGhhbmsgeW91Lg0KPiBLZW50YQ0KPiANCg0KVGhhbmtzIGZvciB0aGUgcmVwb3J0IGFuZCB0aGUg
dGVzdCENCg0KSSdsbCBwcmVwYXJlIGEgcHJvcGVyIHBhdGNoIHdoZW4gdjYuNiByYy0xIGlzIHJl
bGVhc2VkLiBJIG5lZWQgdG8NCmNsZWFudXAgYW5kIHJlZHVjZSBzb21lIG9mIHRoZSBkZWxheXMg
aW4gdGhpcyBleHBlcmltZW50Lg0KDQpCUiwNClRoaW5o
