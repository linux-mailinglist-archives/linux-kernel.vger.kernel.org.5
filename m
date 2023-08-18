Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056437802DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356789AbjHRBIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356784AbjHRBIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:08:36 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A8535B7;
        Thu, 17 Aug 2023 18:08:35 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HKUelK004227;
        Thu, 17 Aug 2023 18:08:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=OLzUiWl4Zzzl1oadx0Lt5irFDu5lZzmFoa1oXDcfrZk=;
 b=uRrWgVU2YXhwhWLos1U/58JrwqhpPaQhGfrHPxTRTZh898dQ1PNGBe6QXmbAa1lX07Nc
 DAvA5QlpUMId5oVr3WwpTr4LbeaRmLhxfymJh9Tc4FrlJk4t7OfLPRUwUANGmK3nWPiZ
 GIFbY4mJsssoc+0DVkfgU/CJFG+Ys/kAXc/Y60tkci/zPhcGq9jWwmYgJ8lJp2K4JsE0
 V/yWtxqSmQ/+hk1SMckGZqNcCvj+Us3nLo7qIQ1m8UuJd4WriyCRl3MjDXLoCGscc0M1
 gXjd4jGv0iq9o1qEgewWKEqeBursi3ZslbFMEyuwslg0KSLaLNnpdPFLURm2MK8/L90q 0A== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3se8qdpg4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 18:08:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692320906; bh=OLzUiWl4Zzzl1oadx0Lt5irFDu5lZzmFoa1oXDcfrZk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Iv8JZdWJxC5MEAWIgONZVV+ub24MbpAmBy3JmSmtve+kjoz3g+4b7vxwnBHBlaYfd
         /GI6b0k9HBJTZKC1sZILqtD9RSX8TAH8/W+NydXAz/W9PqeW+8/wKQZ1jsLFO2zWz+
         G6B7mz0cVuwwXtIB033EF0Vk0b0uQmxpxx+Xbi+Rg8X6Tcy8CZvsXOBOw0Z+5+OhHI
         pLsjdmgx4vJCHnOtD2mXwtZy1Hm/jDsn2pXkHIn7mZ46UVIwt8K9So1ZVN3dIsJAHl
         mMPpA4UtAGZ6nZWOaGNpxPTIpAgRPXQF3foZoOEna5TODRnlPduAw9HGUYxDn+3cic
         fUHXlfdunO8/Q==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 247DD4013A;
        Fri, 18 Aug 2023 01:08:25 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0E9E1A008A;
        Fri, 18 Aug 2023 01:08:24 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=RBg2Pm9q;
        dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 605AA40359;
        Fri, 18 Aug 2023 01:08:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D93PNdZ1F4JHZz89qeQbZH/4fU42j+XFbEJRF4bgEOZ9DoTjsy9WCy+xFVMrzk45kr39Vw23/EqAvSIMIGd/P+f56mVz35mBAGD3zWjJDt56nxmnlqXQrQTstxxK5ODagdj/SYDUpTsQ2jgWzvLnSi4hGniFYum6WleGpcsyWHsp8w6ECRaRMQYIoAOjFlHuRJiE/DXC5i04OwnXYZtkGXJN/PP27EmeXTnxTJzLcMsYI374gcAF/cQldX7hcBojGQw7vC2fqCdM1s19jfjmbtNHmYFziIf6jfrp3y6JORbNwsxuMvIqmgUh8Flp0sRYWd9qTiGxbs9+4xXvifB3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLzUiWl4Zzzl1oadx0Lt5irFDu5lZzmFoa1oXDcfrZk=;
 b=Mn39lYTjA/Gipyz4q4RY8mYg/plTf8EU0za3LsTd0mDytYQeCodFXCbPXdALWluZ0XASQjVnRV5XitcrNT+cOfNHo9vGo0Ad8Tu9Ts5mS+G7cKTIoGJ3LdfbTpNmJd5bVcwyZVWK2lS2+Eu6B8G7yI7FJVEJfTp06Wdp7M/luHETobtEW/NhPTk08D1u7c56GcaQ5p9cQLFXMmyTWEHoh9uu1TLKcJ5APPv6YEcATfHhGwBKXWzRxmczeTE7/SbJWRNAKjLjzaiVfCYlKtDJff5FnW+lBdI9gBdBWlWRSc3uEL3gBBcLmxYYLkJWwdX573clfySfO5tkKKeUpUdAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLzUiWl4Zzzl1oadx0Lt5irFDu5lZzmFoa1oXDcfrZk=;
 b=RBg2Pm9qa/az4MQFa/dQua1p9IiBo4lNcxoJwPJKDQFqYKfeT2cEfnqLnOko8+qh80JyR58kXygrJHjutsJRIMYvNA1Gfu//+BmcIt0QkS4M7T5A6g/YbxRI4CUbAqlvT2/OVXfh0ZLZbJJOCvYR9dU7R1SInwGuihVGDouvI+E=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 01:08:19 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b18d:912e:908a:5952]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b18d:912e:908a:5952%4]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 01:08:19 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Thread-Topic: dwc3: unusual handling of setup requests with wLength == 0
Thread-Index: AQHZ0WkxsEX2ZGMtZEmcF1gvP2WuTK/vPhuA
Date:   Fri, 18 Aug 2023 01:08:19 +0000
Message-ID: <20230818010815.4kcue67idma5yguf@synopsys.com>
References: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
In-Reply-To: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS0PR12MB6581:EE_
x-ms-office365-filtering-correlation-id: ea4b5455-2236-423e-6b23-08db9f879c62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5YGl+BhYUaWc170VZEt7weV0p52eBIsuGFfbOwt7RG0nce8Yu3GmCaOmJ5G7yTZIBAmbgvhpubHTb2tD60cQ4a9CRwKYqHpPsxCSIxeWnNZF754BW+fY8KE+gnWPHQRvH31p02DLzmcNxNQS1+ubf7tFl68Lk+sly8AwvpNOE4JDR+/2qy9naBeDbSxn4zRs8Hc0uPBNrhI/t1DbtHZC9iWoPgigvD63xM1UcK7U9RlGGhKzceapSwxIa94v1Dx/+gC1NlPzNAXuLAi1GEnSMe3jScUI2t/Pp67bX+P3mKEZuLGYrqcexsgaSgoopGMPBwvmaBc3+MRpCYnxaLDIijInwEoBHuax91iUplaRkof6R0dvNpUD9Y6rfrbdZ6dw29wvfLKNavx3aMhyVYc4zPexScwR/wo1Bs3twNQHPZwzcNf4SxuraPcOF/418pM7jyq904DJAf5IHTq1zlbX3BMAOPcbnHhDCOSBN251FPadQ3TRCZScbydgWGfyR6+hnX/P+Q8W+0iRG7W1V+8dyuBwDGpd375oLci8n2wMEamY4Ub9jyuj3KOHvOWEzcKWUsqpx4gP4by8JiLiDGjQ28GjU+AX0X35WcLEwvf8E0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(186009)(1800799009)(451199024)(66899024)(2906002)(83380400001)(66946007)(66476007)(76116006)(6486002)(6506007)(66446008)(66556008)(6916009)(26005)(54906003)(64756008)(316002)(71200400001)(966005)(478600001)(5660300002)(91956017)(2616005)(6512007)(8936002)(41300700001)(8676002)(4326008)(1076003)(86362001)(36756003)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1R4aXl2SlpTdEIyS1paOFEzODBvd0h5T29KN0c3eUhFZzg0NmhGZ2VMbDdp?=
 =?utf-8?B?dktRQ0NzOUtvaEVWUmlHOW1zaFkrVkh6YjQzbVRXRytHT29kcHh2eFk0dTRG?=
 =?utf-8?B?TWI3a3M0VFAvZjVJbG5RZ216ZzAvU3Y1aDdHQzgvRW1XNlFNK3prWHROMmlO?=
 =?utf-8?B?eWhORlZpa3NRWUFQYmJGcDVGNlAzNXo3NFZXTkNSZ3VKUURaU1BpQk5rQXIy?=
 =?utf-8?B?NldWZHRKdjNqUHVtbmErd1gvMnlnRFZENGIwWVBxK0t3bVptK2I5WTU5bUlo?=
 =?utf-8?B?TWJNdnF4M2VLYUlOdi9kekxBODBvVGE4bEYrODNYLzh5WStsT3RzM1NjNUdV?=
 =?utf-8?B?MDFLdVZYM1R2a0tnQm8rWGtjSDhnS0pBMFJGVG8vSW5JNEJaa3lpNUxGMGd2?=
 =?utf-8?B?RkZGR3ovK2w1cWJPdUtxNWZWQ2tQQXJqbDRiK2MwYmU2clJzMkV6ZVp2UXZR?=
 =?utf-8?B?ZHgrdkQ1Nlk0WlkyY0VkakMzUWUrdXFxY3p2emw1Z2tCYkp5Y2RKMVdjd3hu?=
 =?utf-8?B?K3ladEtuaTZXa0hGdSthRjduUUtSdU42VEc1TExlUTJFT1l4eHRWSlpCd2Jy?=
 =?utf-8?B?V1NqZXJmL0E1OU9HdVhSQ3RTUm5aTkhITXNRejh1bWNXL05OYU0wdlNpTFhL?=
 =?utf-8?B?REVtOGVaMHBwcHBrV3RVdUVuMXh3T2dOWGhxV2dLUUxGNGVhTDJrdGRMaUxk?=
 =?utf-8?B?ZmZyTFJCUXlZVWhPUWVpNGVvVVF2eEN2S3FJSXNKanJjRVVVbXZRWHNydFpk?=
 =?utf-8?B?L2JSZFluQnlFMnIxdFBCNGRzak1RejJtZmowMDY3YVNWekRnMDdMS0dwSGVo?=
 =?utf-8?B?TkNybU9QSE8xdENXeEpjdnZ1YzJ5bjFEVnpuNWR0cjdZOE5JRUxrZnJmb0Zn?=
 =?utf-8?B?cUVIYklJazVFN1c4c1JIaWlJTFc3NGNNRzlmTi92RStPTlZGK0dLb29zNHBs?=
 =?utf-8?B?dllUdW1YRDh3TXpYRFdqZnlBd3N3RjFRTURyQ2Q4U1FmeG5EUndadGJabFp4?=
 =?utf-8?B?dnlqWVQ2NDNveTZuMk1xS3RrckJ6TnF5bngrYmovSklXWEVESGs1RmJjanh6?=
 =?utf-8?B?bldaNU5JendjK2c0R2FRU2RRUHlrUHgxajFWR0pxTFZwTTBuVXBnUm9jSHg0?=
 =?utf-8?B?MHc2NThkWi9nY01TUHN1bzUxNnRkTVpyZ21BNjM3bnlKMzBFMG42bU85S0xn?=
 =?utf-8?B?b2IrMHdpam1hVXBVTkFvbUhFUStFeUo5ZXNpc0h1RkdtQTNlODdmWklBNTVC?=
 =?utf-8?B?VWFlUnlDRUpZTGZ3aVNPTThyWExaaE9zYzM0bjNXL1lRakhXRWFNWFQ3RG51?=
 =?utf-8?B?RE5aSnc2ZzlOblE5RzdRNytHUitQUktSUHRzNURjTDFvV3VUdXVXSzVaRkUy?=
 =?utf-8?B?T1JmQkVLSlU0L0lTdmVXZlpMYU9ITythalRWanFMR0dSWVJjNjRzbGU2Vkx2?=
 =?utf-8?B?bFRUakJGSmNFRENUM1k2ZUh0V0N1TE1WVjByeGNNanA1N2tFbGtWNnNFZ0Jm?=
 =?utf-8?B?Z0xTVFJLNEp1QUMrYUU5V2REMHIvTncrZHM0ZndMRmpPeDltWVVGa0NSRk1r?=
 =?utf-8?B?RU5US3JkSnZhU3ZQenh4UkM5aWhmcDNLbTVrSnk3c3pVQmEwbFhZZCtjNmw0?=
 =?utf-8?B?RUdUaUVEMFZrZ2k2VzBzazBCcnY3YUlFRnNJUVJ1WTJzU3FCS212WXlPVkxt?=
 =?utf-8?B?dEpiS2dxVG9kek9JYmZvYzUxeDVvSlBjWlJCRWZZRFNFejZ2UkZVS3A4ejBD?=
 =?utf-8?B?V3lvZThSQ0t0UUFlZ2xpZjFiUThKR2FVSUxNZXA3UlJRRjB2bm1wWmZENFZD?=
 =?utf-8?B?TFZnOVQwS1B0TGcxYnoyNlh4N0o1U1lvV3NkL2xJck84S0RHSWpwRzZCamZx?=
 =?utf-8?B?NEw2aDJ0dnRSY3VqTDlFOWVPMjM5N3ZTQ0FNRm84aVlPWWtxa2dJT3NJbEwz?=
 =?utf-8?B?ZGhHSzltbCtzNHA3eFZ2cmgrTnlwYTAxT0w5bWdnMFlsY3VYcm0xWkpSSllE?=
 =?utf-8?B?eHY0RlVodXBibDZoRkpxVEhaUUNHMG1JKzNUTmNZaXR4RW5DYU83dlFLY1RC?=
 =?utf-8?B?NVVaYnZDOWsxTVZYYXlzWm1BTW9IM3NpMUZIR2FlTjd2elY5TVRzS0p1ZXlC?=
 =?utf-8?Q?IcSH6uBacgZCwX9ueF77YQgAm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2A741EF9D3240449235679AE3970B47@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SEV4VC9Qd0pPV1JybG1LZlBkRHptall1NXF5MXl6dnA3c29RZTdXTXdITXpW?=
 =?utf-8?B?QTNNZ3UrZDZ2cVVRQVBRWllDbzhoSGthcStNN1YzNGJqblBEa0xZNkQyazlO?=
 =?utf-8?B?K0NlSEJlNVQ5OUQzcStKQ1MwN1hRNVp3Z09WWkNaYmtQZTBHbGRuckNPdTFw?=
 =?utf-8?B?OG1jc1JCK1dWMXFnalg1b2d6c0E2ZWNUcnlZVzF0cUFEdU9pdThaZzFadzg2?=
 =?utf-8?B?OEFDYitFWEw1KzNwRUM0dzdpaVFIUytBT1NNbDk3MUpaVnRsRXZndkdQVitL?=
 =?utf-8?B?ME41alBMYXJ5ZGs0bFhGWTNUQ0sxUExSVXVWVjBLQ3NkUkxBSXIydnJBSW0x?=
 =?utf-8?B?TDF5VGYwM3JZRUJaR01qdis5dDU0aUVPbVBmR08vRnc1TkhWRlgyOXhtSVcy?=
 =?utf-8?B?UnJPTHB3aHVEQmRFdXJNQnkvcmJGbkppNlhjZytkWHZ6QnRnQWkxakUzTXBz?=
 =?utf-8?B?blVGSWRmSlJnOUlWUWZmTTJRdUp4d2xkajduVDRsbWRNcEtWMHZ3U1NMOC92?=
 =?utf-8?B?T3ZxODI4anBkeE5Rd1FpdElkWXpGanBxUXZyRzg2dWdNSEllNCt2VUk5R1dU?=
 =?utf-8?B?K2x4dkgzVkhuZU1QNVJLYTNxOU9nL2RlVmdSU3MwaFZ1UEI4a1Z5U25EbEhK?=
 =?utf-8?B?a0RHMXdpZFdKcE01T1V1eDhtaVFlTndpanpCeTE4UVU2R1BwWkc4UlRJUUlr?=
 =?utf-8?B?eXF3RGM4dFBicnE5RzZ5RTJTS0NvWFQ5NlZTT0VhaUEvVGtqWGhsL2VkTGJD?=
 =?utf-8?B?M0tPUGVid0pzWFBOV1ZCd3V2NG1rZU1rYW0wZHJLREhpMXZoQk54V1VITVVY?=
 =?utf-8?B?NVFGV3FlSS83bHpDRzFqeTJPL2JNMkt2UGJDZmZ3OVp1aWx2RmJSQVZoazdI?=
 =?utf-8?B?SE5GQS9MR3NsVHBCaG1qZEZjK1lBUk5wc2RyZjNyb0JhMWZLOEFEV3hQajU1?=
 =?utf-8?B?cGI2NHZSOXJWSUR4Rk9LcFEwaEg3dlo3L3VVL0Q1MGwyS0NNZTNCTVdOS3lM?=
 =?utf-8?B?dXdjZEsxODVzQnk4NUZqQjhGNEkrODdxb1Q4aEFUZm1RYk40eUFyOWQ5VWJw?=
 =?utf-8?B?VUtFZmlQNlhUbE1jNFhzTXVkQ091WUZEaFFrcG9jSUdOZzk0RnpGWGVOWUg1?=
 =?utf-8?B?cERSa2lOR0NWem51N09Wa1pNYzdKMnhDUkJ1YjlJcEJhN2pmMjNJZ2lkYUoy?=
 =?utf-8?B?b3g5Zkt2VGcwaGh2QlhWVTlwYmlhSWsrRzd4Nkx0WFlpdTFiZytnNnB4SExt?=
 =?utf-8?B?ZnF3cnQ5R3c3MTNRZHFkVk1sNE8wbHdWeEEvb1R2VTc5OVZXQT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4b5455-2236-423e-6b23-08db9f879c62
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 01:08:19.5712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yseotf+ny6U3RMtX63pnukeCvoHfjt81updEiZgqFtnaudjm/A0mXoP0gBx38E1wE9c624kXg1MeTTl7c7K4OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581
X-Proofpoint-ORIG-GUID: vU8whjN9eCBQPOcuAxVpL50F85UsIRld
X-Proofpoint-GUID: vU8whjN9eCBQPOcuAxVpL50F85UsIRld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_01,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308180008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIEZyaSwgQXVnIDE4LCAyMDIzLCBBbmRyZXkgS29ub3ZhbG92IHdyb3RlOg0KPiBI
aSBBbGFuIGFuZCBUaGluaCwNCj4gDQo+IEkgaGF2ZSBiZWVuIHRlc3RpbmcgUmF3IEdhZGdldCB3
aXRoIHRoZSBkd2MzIFVEQyBkcml2ZXIgYW5kIHN0dW1ibGVkDQo+IHVwb24gYW4gaXNzdWUgcmVs
YXRlZCB0byBob3cgZHdjMyBoYW5kbGVzIHNldHVwIHJlcXVlc3RzIHdpdGggd0xlbmd0aA0KPiA9
PSAwLg0KPiANCj4gV2hlbiBydW5uaW5nIGEgc2ltcGxlIFJhdyBHYWRnZXQtYmFzZWQga2V5Ym9h
cmQgZW11bGF0b3IgWzFdLA0KPiBldmVyeXRoaW5nIHdvcmtzIGFzIGV4cGVjdGVkIHVudGlsIHRo
ZSBwb2ludCB3aGVuIHRoZSBob3N0IHNlbmRzIGENCj4gU0VUX0NPTkZJR1VSQVRJT04gcmVxdWVz
dCwgd2hpY2ggaGFzIHdMZW5ndGggPT0gMC4NCj4gDQo+IEZvciBzZXR1cCByZXF1ZXN0cyB3aXRo
IHdMZW5ndGggIT0gMCwganVzdCBsaWtlIHRoZSBvdGhlciBVREMgZHJpdmVycw0KPiBJIHRlc3Rl
ZCwgZHdjMyBjYWxscyB0aGUgZ2FkZ2V0IGRyaXZlcidzIC0+c2V0dXAoKSBjYWxsYmFjayBhbmQg
dGhlbg0KPiB3YWl0cyB1bnRpbCB0aGUgZ2FkZ2V0IGRyaXZlciBxdWV1ZXMgYW4gVVJCIHRvIEVQ
MCBhcyBhIHJlc3BvbnNlLg0KDQpGb3IgdGhlIGxhY2sgb2YgYmV0dGVyIHRlcm0sIGNhbiB3ZSB1
c2UgInJlcXVlc3QiIG9yICJ1c2JfcmVxdWVzdCINCmluc3RlYWQgb2YgVVJCIGZvciBnYWRnZXQg
c2lkZSwgSSBnZXQgY29uZnVzZWQgd2l0aCB0aGUgaG9zdCBzaWRlDQp3aGVuZXZlciB3ZSBtZW50
aW9uIFVSQi4NCg0KPiANCj4gSG93ZXZlciwgZm9yIGEgc2V0dXAgcmVxdWVzdCB3aXRoIHdMZW5n
dGggPT0gMCwgZHdjMyBkb2VzIG5vdCB3YWl0DQo+IHVudGlsIHRoZSBnYWRnZXQgZHJpdmVyIHF1
ZXVlcyBhbiBVUkIgdG8gYWNrIHRoZSB0cmFuc2Zlci4gSXQgYXBwZWFycw0KPiB0aGF0IGR3YzMg
anVzdCBhY2tzIHRoZSByZXF1ZXN0IGludGVybmFsbHkgYW5kIHRoZW4gcHJvY2VlZHMgd2l0aA0K
PiBjYWxsaW5nIHRoZSAtPnNldHVwKCkgY2FsbGJhY2sgZm9yIHRoZSBuZXh0IHJlcXVlc3QgcmVj
ZWl2ZWQgZnJvbSB0aGUNCg0KSXQgZGVwZW5kcyBvbiB0aGUgYlJlcXVlc3QuIEl0IHNob3VsZCBu
b3QgcHJvY2VlZCB0byAtPnNldHVwKCkgdW5sZXNzDQp0aGUgZ2FkZ2V0IGRyaXZlciBhbHJlYWR5
IHNldHVwcyB0aGUgcmVxdWVzdCBmb3IgaXQuDQoNCj4gaG9zdC4gVGhpcyBjb25mdXNlcyBSYXcg
R2FkZ2V0LCBhcyBpdCBkb2VzIG5vdCBleHBlY3QgdG8gZ2V0IGEgbmV3DQo+IC0+c2V0dXAoKSBj
YWxsIGJlZm9yZSBpdCBleHBsaWNpdGx5IGFja3MgdGhlIHByZXZpb3VzIG9uZSBieSBxdWV1aW5n
DQo+IGFuIFVSQi4gQXMgYSByZXN1bHQsIHRoZSBlbXVsYXRpb24gZmFpbHMuDQoNCklmIHRoZSBo
b3N0IGludGVudCBpcyB0byBzZW5kIGEgMy1zdGFnZSBjb250cm9sIHJlcXVlc3Qgd2l0aCBhIDAt
bGVuZ3RoDQpkYXRhIHBhY2tldCwgdGhlIGdhZGdldCBkcml2ZXIgbmVlZHMgdG8gcmV0dXJuIFVT
Ql9HQURHRVRfREVMQVlFRF9TVEFUVVMNCnRvIHByZXBhcmUgYSAwLWxlbmd0aCByZXF1ZXN0LiBG
b3IgU0VUX0NPTkZJR1VSQVRJT04sIHdlIGRvbid0IGV4cGVjdA0KYSBkYXRhIHBoYXNlLCB3aHkg
c2hvdWxkIHRoZSBnYWRnZXQgZHJpdmVyIHF1ZXVlIGEgMC1sZW5ndGggZGF0YT8NCg0KPiANCj4g
SSBzdXNwZWN0IHRoaXMgaXNzdWUgaGFzIG5vdCBiZWVuIG9ic2VydmVkIHdpdGggb3RoZXIgZ2Fk
Z2V0IGRyaXZlcnMsDQo+IGFzIHRoZXkgcXVldWUgYW4gVVJCIGltbWVkaWF0ZWx5IGFmdGVyIHJl
Y2VpdmluZyBhIC0+c2V0dXAoKSBjYWxsOg0KPiBkd2MzIGFwcGVhcnMgdG8gc29tZWhvdyBjb3Jy
ZWN0bHkgaGFuZGxlIHRoaXMgaW50ZXJuYWxseSBldmVuIHRob3VnaA0KPiBpdCBhY2tzIHRoZSB0
cmFuc2ZlciBieSBpdHNlbGYuIEJ1dCB0aGUgdGltaW5ncyB3aXRoIFJhdyBHYWRnZXQgYXJlDQo+
IGRpZmZlcmVudCwgYXMgaXQgcmVxdWlyZXMgdXNlcnNwYWNlIHRvIGFjayB0aGUgdHJhbnNmZXIu
IFNvbWV0aW1lcw0KPiB0aG91Z2gsIHRoZSBSYXcgR2FkZ2V0LWJhc2VkIGVtdWxhdG9yIGFsc28g
bWFuYWdlcyB0byBxdWV1ZSBhbiBVUkINCj4gYmVmb3JlIHRoZSBuZXh0IHJlcXVlc3QgaXMgcmVj
ZWl2ZWQgZnJvbSB0aGUgaG9zdCBhbmQgdGhlIGVudW1lcmF0aW9uDQo+IGNvbnRpbnVlcyBwcm9w
ZXJseSAodW50aWwgdGhlIG5leHQgcmVxdWVzdCB3aXRoIHdMZW5ndGggPT0gMCkuDQo+IA0KPiBX
aGF0IGRvIHlvdSB0aGluayB3b3VsZCBiZSB0aGUgYmVzdCBhcHByb2FjaCB0byBkZWFsIHdpdGgg
dGhpcz8NCg0KVGhlIGNvbW11bmljYXRpb24gc2hvdWxkIGJlIGNsZWFybHkgZGVmaW5lZC4gVGhh
dCBpcywgdGhlIGR3YzMgbmVlZHMgdG8NCmtub3cgaWYgdGhpcyBpcyBhIDMtc3RhZ2Ugb3IgMi1z
dGFnZSBjb250cm9sIHRyYW5zZmVyLiBJdCBrbm93cyBhYm91dA0KdGhlIHN0YW5kYXJkIHJlcXVl
c3RzLCBidXQgbm90IHRoZSB2ZW5kb3Ivbm9uLXN0YW5kYXJkIG9uZXMuIElmIHRoZSByYXcNCmdh
ZGdldCBkZWZpbmVkIHNvbWUgdW5rbm93biBPVVQgcmVxdWVzdCwgaXQgbmVlZHMgdG8gdGVsbCBk
d2MzIHdoZXRoZXINCml0IHNob3VsZCBleHBlY3QgdGhlIGRhdGEgc3RhZ2Ugb3Igbm90Lg0KDQpC
UiwNClRoaW5oDQoNCj4gDQo+IENhbiB0aGlzIGJlIGNvbnNpZGVyZWQgYSBidWcgaW4gZHdjMyB0
aGF0IHNob3VsZCBiZSBmaXhlZD8gVGhlcmUncyBhDQo+IHNlZW1pbmdseSByZWxhdGVkIGNvbW1l
bnQgaW4gZHdjMyBjb2RlIFsyXSwgYnV0IEknbSBub3QgZmFtaWxpYXINCj4gZW5vdWdoIHdpdGgg
aXRzIGludGVybmFscyB0byB1bmRlcnN0YW5kIHdoZXRoZXIgdGhpcyBpcyB3aGF0IGxlYWRzIHRv
DQo+IHRoZSBpc3N1ZSBJJ20gc2VlaW5nLg0KPiANCj4gT3Igc2hvdWxkIEkgYWRhcHQgUmF3IEdh
ZGdldCB0byBoYW5kbGUgdGhpcyB1bnVzdWFsIGR3YzMgYmVoYXZpb3I/DQo+IFRoaXMgbWlnaHQg
YmUgdHJpY2t5IHRvIGRvLCBhcyBJIGNhbm5vdCBjaGFuZ2UgdGhlIGV4aXN0aW5nIHVzZXJzcGFj
ZQ0KPiBBUEkuDQo+IA0KPiBPbiBhIHNpZGUgbm90ZSwgYXMgYW4gZXhwZXJpbWVudCwgSSB0cmll
ZCByZXR1cm5pbmcNCj4gVVNCX0dBREdFVF9ERUxBWUVEX1NUQVRVUyBmcm9tIHRoZSBSYXcgR2Fk
Z2V0J3MgLT5zZXR1cCgpIGNhbGxiYWNrIGlmDQo+IHRoZSBVREMgZHJpdmVyIGNhbGxzIGl0IHRv
byBlYXJseTogc29tZSBVREMgZHJpdmVycywgaW5jbHVkaW5nIGR3YzMsDQo+IGFwcGVhciB0byBj
b250YWluIGEgc3BlY2lhbCBoYW5kbGluZyBmb3IgdGhpcyByZXR1cm4gdmFsdWUuIEhvd2V2ZXIs
DQo+IHRoYXQgZGlkbid0IHdvcmsgb3V0LiBQZXJoYXBzLCBJIG1pc3VuZGVyc3RhbmQgdGhlIG1l
YW5pbmcgb2YgdGhpcw0KPiB2YWx1ZS4NCj4gDQo+IFRoYW5rIHlvdSENCj4gDQo+IFsxXSBodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRodWIuY29tL3hhaXJ5L3Jhdy1nYWRn
ZXQvYmxvYi9tYXN0ZXIvZXhhbXBsZXMva2V5Ym9hcmQuY19fOyEhQTRGMlI5R19wZyFmc2tzTjkt
ZW9vV1M3VXVpOE1mQ2NCa2ZmOGF3RzJvdndsNlVhUHVKNF92NTBOeTVzLVdRNFl1UWh0MUFDUmw2
ZURZWjRvLWdrVmxGNmw4MkM4VVQ1OGU3JCANCj4gWzJdIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni41LXJjNi9zb3VyY2UvZHJp
dmVycy91c2IvZHdjMy9lcDAuYypMMTQ1X187SXchIUE0RjJSOUdfcGchZnNrc045LWVvb1dTN1V1
aThNZkNjQmtmZjhhd0cyb3Z3bDZVYVB1SjRfdjUwTnk1cy1XUTRZdVFodDFBQ1JsNmVEWVo0by1n
a1ZsRjZsODJDNlEzd1pmVyQg
