Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF627EEACE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 02:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbjKQBp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 20:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjKQBp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 20:45:57 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D31195;
        Thu, 16 Nov 2023 17:45:53 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH108bP004156;
        Thu, 16 Nov 2023 17:45:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=XXjyrK10WKZe3qPP+bENs0IPlNHCHcD01keRw5wz+GA=;
 b=wNBnGmvCTxAwE9pCG3tj1d5rpOhiXohPvqo8PZrNyJ4SPZdDRUxKNrcduHGtX0lNfgDj
 QpvwSPNsnE05ZytiVD4J7CrURV9G8ReufyoL9q/141+BIZSuKP1jn5IvrIEDbEhxITE4
 QL6x2CJApc38bDOnEjG2fV8G8lAHLN2in3Z+S8F/FiComuVBx+3NA+tRfcg+ZTNR+J8C
 EDI0LkrDS0StZNY4w3hdvBx8vHHR4ejm3e9gPy8lJQ2VoC3ktkLxVmS+YqhGniSm1Ji7
 Oc2AJhfgpUVCGSEWOU1u0Jo3SSNq+b4dD+1+v1KSeTcUI5OhzPKcUMJlvor63cmcBH3m SQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ua9gsj07g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 17:45:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1700185545; bh=XXjyrK10WKZe3qPP+bENs0IPlNHCHcD01keRw5wz+GA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=HR7X2D1A06faViliEBSQAxpwwMbXFjhliPSWtnHbnbgcl/LCxFr1eSnGDI7ezkds2
         J6Zv8Nb6A+q5YkDnYjIt5/Ae+kInwftK4f1SgB2oVmngERsaz0wwB1wbk6NsVaUDMi
         NbIX1WOI23p3i52LHMrs0gMtmE4W6uwR3MJ2G7Z502P8lF18QWFUEO9LDMc9vo6ZuN
         M5RhGl419eRbr3Bj3OC5Vr3u+SYzeqDlQqSgH15ieGyKiFPBgAzGRGmozoxTwCzS4D
         m+b9g9VbO2F7Zo8n0yR9SGoGHVQvmQ5gFY7bypam0Mk4rkK1ozIqFvHtSykAjuviGw
         QPCdNrdYxwgeA==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 87A3F40493;
        Fri, 17 Nov 2023 01:45:45 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3076BA025A;
        Fri, 17 Nov 2023 01:45:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=RaLVcZe/;
        dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8D0F7400A2;
        Fri, 17 Nov 2023 01:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQNbnMipK3FnMPpMlXiMEAkpUmL6WhgCIno21hnEqpi0EtUcaCOC/13UFWRbyMb7EffUPYtpqRjQhIgvO0eSSmV5843ZlPBl9Cz4Nw+3RRM+R5QzjF8CNnoQAkqlYNxHyCpgwwusYknG2gyulndHEY5nS9rf9nlU2W4byrArPOnPiX74VW5lYwatE0GswCzjWdUSAOiFGbIceMfLV1g4cixkqcULswhoZFvAy5e/D7auvDfq4ENTonSguHYOjK6TSJ+BiGXjv2cnpSeKCJBAHACtRORZ5O6AiClMQAqgqL4dq/7yVi5kkCBuX1m1c+mk1bPBtHO0/SSUNdhrYXK0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXjyrK10WKZe3qPP+bENs0IPlNHCHcD01keRw5wz+GA=;
 b=Hmn69Rax/vjdyZ2CuVQipUMBhy6FJzjGDHrDzbMowdZD5xvNMsPxPHAA1kLyLZ3NAnWe69RmgCjlexYHkkShwG5YKGkyVGIkL5oaqppiAKzZDDrgbI7V3o4JKL9BKNwrmePLaLHvZtTA3Yk8JON/WkA8h0u0mZKR/vn6rolrQJPav0K/+1XThPueIyQWPBE7ucVGvJt7l7wzJhqghTAo70cZlRgS3I+r47ggmvKNEpBThwsXiz1XcoONVR7N8gmWt6Et5B7VZLKylWm5tOPB2mFU8G5NnZP7OClIZvt6/Blo7wmppRgUDrbH5ASf3MrBoj1WcpSVl3jO8VRxUMjVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXjyrK10WKZe3qPP+bENs0IPlNHCHcD01keRw5wz+GA=;
 b=RaLVcZe/5D29+6fKWytfr8bmjoR9NIDjGM5YkrOKIgAb7Zk89e3TXpcS0B0kcWblqoWz1iItE1WfrVUnE11bXgIpA1XrJnzICqUoaEKsq59SeUws1BwkJiVnIgYrf+BUo5XrOuO80fIUCczXgmx8cyXsOjpqzcq5MW//deaHoXs=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Fri, 17 Nov 2023 01:45:41 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e%5]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 01:45:41 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Dan Scally <dan.scally@ideasonboard.com>
CC:     Kuen-Han Tsai <khtsai@google.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "piyush.mehta@amd.com" <piyush.mehta@amd.com>,
        "radhey.shyam.pandey@amd.com" <radhey.shyam.pandey@amd.com>,
        "siva.durga.prasad.paladugu@amd.com" 
        <siva.durga.prasad.paladugu@amd.com>
Subject: Re: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
Thread-Topic: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
Thread-Index: AQHaDVvtK46auOuFqk6xUT0xKW8RPLBm7bwAgAlqnQCADGtvAIABEQcA
Date:   Fri, 17 Nov 2023 01:45:40 +0000
Message-ID: <20231117014538.ro6bo2ho2jgl7l6s@synopsys.com>
References: <80a05f4a-eaae-4db1-9604-c5eed9ff594c@ideasonboard.com>
 <20231108114848.794045-1-khtsai@google.com>
 <d040f84a-b55e-4b1d-85c1-b6cec6554198@ideasonboard.com>
In-Reply-To: <d040f84a-b55e-4b1d-85c1-b6cec6554198@ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM8PR12MB5413:EE_
x-ms-office365-filtering-correlation-id: cfd18ace-09d1-4c47-89c4-08dbe70ee7f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oNXjHen/5hpZnPSyYMGqhc7WJLZcNRmls2bGu/houMsm61Q9/A+a1kszdVdJYGrApuq1vZp9EOaZyy0ZcVfhByE5xbnmxl6CQPCAwgxDl9lxzisceb5snM/ckHzBpy6kKIMGK8upmqQT2xosESY3ISNdDdB/QT04IRvPssX9se0CjiJgxfbQGSfU+6tNhDiPmRbZnYpZSVmJ0SCtuGIKeZcXCf3GY1gUhIFfI7Gr9HTt9WFIC7Q/j+3etjt/wkEBrO4LQPwEyUSfWgCybIbHHblDH+vEuWXa190HTbmrw+DpdNJizcnJOr1sZHrJmRIc/bmA/TqNTF7eADKSFWb8i7fIbs1PxAEpzEBsDj1zP5f56mb5NUjnzh1K7XVfJoRctZnO0025Yn8Y9d3vixVkSzY0+kd9UbrYkDa03wK3EwaWodPBJ1MC1wDTvPWDl1/ribxXs4+T5MvS6/Jdb6UPAYtONbP+EP/70MRnERS2ipaR0MnSf76SRu/Vwpe/ssUmCefdivgZuuCRfqLWQvBkNu11A1AECIAFNR2hEYkmmpih+hKJVculiX7bgy6K2gxS9PTd5B1tSj7YdzazVSl6czFv7LA/ZCLTVDcIOz73/FlrnVbLHCMSn31oZ2ciCfZ0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(4326008)(8936002)(8676002)(66446008)(66946007)(66556008)(64756008)(86362001)(6916009)(54906003)(122000001)(316002)(66476007)(38100700002)(41300700001)(36756003)(5660300002)(83380400001)(6486002)(7416002)(76116006)(26005)(38070700009)(1076003)(2906002)(478600001)(71200400001)(6506007)(53546011)(6512007)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFRvenpLM3FWN2ExRU8yVnlZQkEzKzRzY2xUSTdrZGFoNHc3Y0NDSmtPaU5V?=
 =?utf-8?B?blBPa2ZYcENaeGpXdUhPZHNjTGxUMnJWVHdlR1huM29UZkFZTkVYUitJOVhy?=
 =?utf-8?B?dTJBcnN6Y1JVbmNnTUtjc3QwYUZZVC9ZZWN2RERHUDBZandkUWRsVnBTOTF2?=
 =?utf-8?B?d2l3OXhPQmhQdEtTQlRUTm5wQVJEYXFiQkpCSThyWEl4SEQ5T29RMnZVYjRB?=
 =?utf-8?B?YTZCbnhTcTVDS2JUV1kzT1Z3YWU1ZklPVyt1aXFrR2MyVTVQNFFHUDFEdzhO?=
 =?utf-8?B?RUVIT2I3NHdmV0l4WGZWOTZCelNlZjRMUlBsRC9xMFR3ejU5dFlaMC8zZXp4?=
 =?utf-8?B?Ri9jc1dzWUdRS2NnQS84aXFhd084TmhNaXhDRHYvVlJvZ1hFVlovQTNZYXBm?=
 =?utf-8?B?cjZnNzI1WjNhY1lwU0N6d3FwM2p1aXNPY2dLK29iNDNaOFZTV1B0UGw5bmZI?=
 =?utf-8?B?UkF3eVlRVHVUak5tb3VqcTZ5amZzc0ZtSU0wb1ViUU1XVHRLQWd5OEZUNzdL?=
 =?utf-8?B?U0cvdU43cU5oL2phU242V3V2dmt2OVcrV2Jsa1BwUjFqQWtVK3Q0N3Q3TTJH?=
 =?utf-8?B?YnE2emJTcTc0cnlNQXc4TE5la1FyaFh6cjdYbTZYZjkwZzRqR2VWa2dBZWc1?=
 =?utf-8?B?MmVOM2pHeUxsRUVlOVBPRWdCS2oxaUxGbnVsTjBJYW1CM1p5MFhRU3h2UE1v?=
 =?utf-8?B?ckZwSjlwT1FVdUlRVVI0eHpFbFNOem9zTXVrcEpHKzdNcUFycDMrNDVmdWlD?=
 =?utf-8?B?bUpCbUFTYXZDeHFiKzYzZzdoTjkycy80MDZCUW96bXpRQVhYanZxQ3FWMmts?=
 =?utf-8?B?YnByY3d3YkR5bzhsWFFKZkhiQWFJTkN2YVBQTythMm5ZdnU5Q1REc3g3V25q?=
 =?utf-8?B?V2dZdmlnbWkwVC9idTJuUnVXc01OckhTTmJIekEvTHZ3ZEM2UE5CQ1lUNnlY?=
 =?utf-8?B?N3A2ck1TNXhhMnI4N1FsK2xjb2pjbWNsOWpHeEh4YVB5T2QvNlVMZzJndmxZ?=
 =?utf-8?B?Mm4zdjl2aERPNXQ0M2NldndWRVVFblkwY3hXNlFVVDBjMnVoVlV0Mk4vdThP?=
 =?utf-8?B?NkxKNTZOalo4dU4zZCt1UzVpUFFyK0ZzaHgyeHhFbkc1QWNYZ2d2VEVhOTVq?=
 =?utf-8?B?bUlYWXdsSCtTZmNMcG9Id1ovZzZERExWT1NVeWE4b0VDQjMwYVRBdUFoemJN?=
 =?utf-8?B?QnhlWXlyM2UyRTRKVFRuTWJpSlRWdEh1bW9TbGVLMEZFNjZLczVhSXRDWkFR?=
 =?utf-8?B?YUxQNms2THVUTEJyejkwNlllbWlEYUJrVmJYVEU1V3gyOXF4OTZKaEVyVlor?=
 =?utf-8?B?NkRxRFJxL09Yak9vWGpjM1N0amlUUlJGaVpNT1RzWHIzMzYxaGV0T1hWRVpL?=
 =?utf-8?B?ZVZURGFjdm5TS1JlQ09kcUx1M0pBU0pUWG5tUFY1ZUJmK2h1NU1yRTB5Tkh5?=
 =?utf-8?B?Y0tHTE9oOHRQeHZYNldTWXpuT2FwTDNBZkJzL2lUNXZiYlJYUHdISVpjaWV3?=
 =?utf-8?B?R3dxelR0b1k0NlpONHBZTXpFSjNrVXBKWEtlemJyZFBnR3haSGFnZDRBaVJH?=
 =?utf-8?B?M3FlZG91VzVFanhKem5qdDRqVVhWaWZrK1hKY1ZoSVhVS2xrajZVRUJoWW5i?=
 =?utf-8?B?L011LytCL09RUkZDUFpQdEd2Y3dCaTRSV1NwN0s3dEdVeVZhZXcwa2tUYlN2?=
 =?utf-8?B?R0RGc3RrR0RxRU42VW9kNTkxM1JNbXhMdVQzSy9qdHhPRGdpenFGaEJvZjNM?=
 =?utf-8?B?bTk0OWxyaEdpc1U5R3FHQ1pHSEFDN0dzNVFsbmw3U2tUYWF1RWZFaDRqWUpZ?=
 =?utf-8?B?YnN0ZzV5M3hoMTJVUk5aMDVHQWNTdjlvajVHYThmdlNkbjM1UzdlcFhLUGUw?=
 =?utf-8?B?azYxcERXVUJ2alV5NlE2VW9jUVlVVFh2a1l4R2oxWGxQTE9ONnFobmVTeGNG?=
 =?utf-8?B?NFFGc0NtRGRUWXFlY2dWSnVYUEJ3d0k5WndvQkVXdXpQZUMvQmU5K1FJRFo4?=
 =?utf-8?B?ZE8yNEZnZnNZRitvbEVHYVBLaitPNTJmeWgrMmhYRGJhQ2l2a1BEL2ozaXNY?=
 =?utf-8?B?b1pPNUoyT0hsU3hmbmxDWlRYZ09MQ2N6dTc3Q0w1UVRaajR2TENHeUxSRDJw?=
 =?utf-8?Q?pxhQF46+jgKJPW0QsdtGxa7FS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66C54F50AB602B4FB671C3A147F87627@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WTNHaXZ1MHFLZ2ZUR3E3UnhSY2tiRVJNc2NneWVxbE9OQndnUzVwWDMrd0VW?=
 =?utf-8?B?ZHNUL2M3Z1ZYWFZIU0FkTFhYSUplTjUybHV6cWthRTdHN1ZUcDE4Q0RlNkpj?=
 =?utf-8?B?N2x6akRjaDBnY1o3OVRWSnZFa29iWXZ4Nm8xNXJXcjhwd3ArTC81TlREU3Jr?=
 =?utf-8?B?V2dqUkVPRXNLelQzUVBYYjlJd0hUY2Rvd2hBb1grOFBTam1nc2F0QVFPS0pZ?=
 =?utf-8?B?TDBEWDdzdWtSQUE3SzZobFA5aGlvRHVjUFNQNk1VWUdqZHpkSVp6Y25HSjJN?=
 =?utf-8?B?U0xuVEhhUTI1aDNsQSs5T1cyR09JcEsyQlVFM2EvK3lXdENvYXVaNEo0TUJa?=
 =?utf-8?B?T1F0M3V1eUxWNE5hSDBjRkFUNWZueHdFWjFGb2VFT1BucVhnQnV2V1RYS2pZ?=
 =?utf-8?B?NTNkOTQzbTRla1VuOC9xYzNVYjBNcTBjYVk1U1FQS3BUZUZXTzZaNk1vbWN5?=
 =?utf-8?B?RHpORStkQkZTUnpVajdGd1hZMlhGN2xOempuMzNHNE00c1E5VHhETzBaaThz?=
 =?utf-8?B?VDA5UGJPWjNEekpOYzZoOEZoUmJxRkhBdUVJdHdjMWZzb050N0FCMzdGYndG?=
 =?utf-8?B?OUljVGhDNHBiOGxIUTRrbXVuT2t6ckZ4S2hOYzFnYmdOYWxPK0JVZDd2TzRF?=
 =?utf-8?B?YnpQM3M3T2JNcHU1SDE4VzQvdFZTcDRzQkRPRDZ0YVVFaW41K2d0Uk1nSlVu?=
 =?utf-8?B?eFp1MmY1MU1OMi9PUWRhR055VjUzN2l4ZkEvYlVtT05QeGdnL3krUHFLVTgr?=
 =?utf-8?B?YXZjeWYxeG1ZeXNQY0JrS25wVHdqT3Vkem16MW1MUzZhNnBDSWpwVFd0UTk2?=
 =?utf-8?B?RDZ0d0hKWCtZV294QWxLTW1rYVcxdGVldTdxTm0xeHc0ME9XSE9PQzU5azNO?=
 =?utf-8?B?TmxiVml6emQ4bkdwdEZVYk5IMzNkS3hjSnMrRHV1a2dOZk8xeW9nTFMrOHhn?=
 =?utf-8?B?anMwd3lzejhWL0pCM04wUm9CYTUvZDRNMHN2MVBneFhzZXJXelhhSm0zd2R2?=
 =?utf-8?B?bk83VFdsU2MvcW52NmUydUswb01jU2lHUHN3MFZxVEx6RDFMb09ZQlZIcFBx?=
 =?utf-8?B?QmxFSEhCWFFhbWxzS0tSMS9kLzkyekNEYTQraEQwY25PS211cU5acGc0NGNB?=
 =?utf-8?B?MWtLU0cvaWJhaTBoN1d2TkxUeDRLbFloYXJtUVJjZGFGaDBLNUloWVpMM0Nn?=
 =?utf-8?B?d2NPdUtOK1JSNy9zVE4vQksxVmNiWW5PMGtIMUx5enF6eEF2UlFrYWtHTHBu?=
 =?utf-8?B?OHFGdEhzSWd3bDluem4rUUtKTUN0VUY4WVU5M25GRVMwbTgzQT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd18ace-09d1-4c47-89c4-08dbe70ee7f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 01:45:40.9806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GfSH4Fqr6XqayEvhVAdQGxzN1IFupE7sV64yqbkqYvuP9pFPJePDPS2/BqLRQosqZvfvbyKfc9WoN0ffpDWCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
X-Proofpoint-GUID: 9rrYPVBKqJdD5kXI5ON6Ycykt8oZjrQw
X-Proofpoint-ORIG-GUID: 9rrYPVBKqJdD5kXI5ON6Ycykt8oZjrQw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 mlxlogscore=535 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311170011
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFRodSwgTm92IDE2LCAyMDIzLCBEYW4gU2NhbGx5IHdyb3RlOg0KPiBDQyBUaGlu
aCAtIHNvcnJ5IHRvIGJvdGhlciB5b3UsIGp1c3Qgd2FudCB0byBtYWtlIHN1cmUgd2UgZml4IHRo
aXMgaW4gdGhlIHJpZ2h0IHBsYWNlLg0KPiANCj4gT24gMDgvMTEvMjAyMyAxMTo0OCwgS3Vlbi1I
YW4gVHNhaSB3cm90ZToNCj4gPiBPbiAwMi8xMS8yMDIzIDA3OjExLCBQaXl1c2ggTWVodGEgd3Jv
dGU6DQo+ID4gPiBUaGVyZSBjb3VsZCBiZSBjaGFuY2VzIHdoZXJlIHRoZSB1c2JfZXBfcXVldWUo
KSBjb3VsZCBmYWlsIGFuZCB0cmlnZ2VyDQo+ID4gPiBjb21wbGV0ZSgpIGhhbmRsZXIgd2l0aCBl
cnJvciBzdGF0dXMuIEluIHRoaXMgY2FzZSwgaWYgdXNiX2VwX3F1ZXVlKCkNCj4gPiA+IGlzIGNh
bGxlZCB3aXRoIGxvY2sgaGVsZCBhbmQgdGhlIHRyaWdnZXJlZCBjb21wbGV0ZSgpIGhhbmRsZXIg
aXMgd2FpdGluZw0KPiA+ID4gZm9yIHRoZSBzYW1lIGxvY2sgdG8gYmUgY2xlYXJlZCBjb3VsZCBy
ZXN1bHQgaW4gYSBkZWFkbG9jayBzaXR1YXRpb24gYW5kDQo+ID4gPiBjb3VsZCByZXN1bHQgaW4g
c3lzdGVtIGhhbmcuIFRvIGF2aW9kIHRoaXMgc2NlbmVyaW8sIGNhbGwgdXNiX2VwX3F1ZXVlKCkN
Cj4gPiA+IHdpdGggbG9jayByZW1vdmVkLiBUaGlzIHBhdGNoIGRvZXMgdGhlIHNhbWUuDQo+ID4g
SSB3b3VsZCBsaWtlIHRvIHByb3ZpZGUgbW9yZSBiYWNrZ3JvdW5kIGluZm9ybWF0aW9uIG9uIHRo
aXMgcHJvYmxlbS4NCj4gPiANCj4gPiBXZSBtZXQgYSBkZWFkbG9jayBpc3N1ZSBvbiBBbmRyb2lk
IGRldmljZXMgYW5kIHRoZSBmb2xsb3dpbmdzIGFyZSBzdGFjayB0cmFjZXMuDQo+ID4gDQo+ID4g
WzM1ODQ1Ljk3ODQzNV1bVDE4MDIxXSBDb3JlIC0gRGVidWdnaW5nIEluZm9ybWF0aW9uIGZvciBI
YXJkbG9ja3VwIGNvcmUoOCkgLSBsb2NrZWQgQ1BVcyBtYXNrICgweDEwMCkNCj4gPiBbMzU4NDUu
OTc4NDQyXVtUMTgwMjFdIENhbGwgdHJhY2U6DQo+ID4gWypdW1QxODAyMV0gIHF1ZXVlZF9zcGlu
X2xvY2tfc2xvd3BhdGgrMHg4NC8weDM4OA0KPiA+IFszNTg0NS45Nzg0NTFdW1QxODAyMV0gIHV2
Y192aWRlb19jb21wbGV0ZSsweDE4MC8weDI0Yw0KPiA+IFszNTg0NS45Nzg0NThdW1QxODAyMV0g
IHVzYl9nYWRnZXRfZ2l2ZWJhY2tfcmVxdWVzdCsweDM4LzB4MTRjDQo+ID4gWzM1ODQ1Ljk3ODQ2
NF1bVDE4MDIxXSAgZHdjM19nYWRnZXRfZ2l2ZWJhY2srMHhlNC8weDIxOA0KPiA+IFszNTg0NS45
Nzg0NjldW1QxODAyMV0gIGR3YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY2FuY2VsbGVkX3JlcXVlc3Rz
KzB4YzgvMHgxMDgNCj4gPiBbMzU4NDUuOTc4NDc0XVtUMTgwMjFdICBfX2R3YzNfZ2FkZ2V0X2tp
Y2tfdHJhbnNmZXIrMHgzNGMvMHgzNjgNCj4gPiBbMzU4NDUuOTc4NDc5XVtUMTgwMjFdICBfX2R3
YzNfZ2FkZ2V0X3N0YXJ0X2lzb2MrMHgxM2MvMHgzYjgNCj4gPiBbMzU4NDUuOTc4NDgzXVtUMTgw
MjFdICBkd2MzX2dhZGdldF9lcF9xdWV1ZSsweDE1MC8weDJmMA0KPiA+IFszNTg0NS45Nzg0ODhd
W1QxODAyMV0gIHVzYl9lcF9xdWV1ZSsweDU4LzB4MTZjDQo+ID4gWzM1ODQ1Ljk3ODQ5M11bVDE4
MDIxXSAgdXZjZ192aWRlb19wdW1wKzB4MjJjLzB4NTE4DQo+IA0KPiANCj4gSSBub3RlIGluIHRo
ZSBrZXJuZWxkb2MgY29tbWVudCBmb3IgdXNiX2VwX3F1ZXVlKCkgdGhhdCBjYWxsaW5nIC5jb21w
bGV0ZSgpDQo+IGZyb20gd2l0aGluIGl0c2VsZiBpcyBzcGVjaWZpY2FsbHkgZGlzYWxsb3dlZCBb
MV06DQo+IA0KPiDCoMKgwqAgTm90ZSB0aGF0IEByZXEncyAtPmNvbXBsZXRlKCkgY2FsbGJhY2sg
bXVzdCBuZXZlciBiZSBjYWxsZWQgZnJvbQ0KPiANCj4gwqDCoMKgIHdpdGhpbiB1c2JfZXBfcXVl
dWUoKSBhcyB0aGF0IGNhbiBjcmVhdGUgZGVhZGxvY2sgc2l0dWF0aW9ucy4NCj4gDQo+IA0KPiBB
bmQgaXQgbG9va3MgbGlrZSB0aGF0J3Mgd2hhdCdzIGhhcHBlbmluZyBoZXJlIC0gaXMgdGhpcyBz
b21ldGhpbmcgdGhhdA0KPiBuZWVkcyBhZGRyZXNzaW5nIGluIHRoZSBkd2MzIGRyaXZlcj8NCj4g
DQoNCkxvb2tzIGxpa2UgaXQuIFRoZSBpc3N1ZSBpcyBpbiBkd2MzLiBJdCBzaG91bGQgb25seSBh
ZmZlY3QgaXNvYyByZXF1ZXN0DQpxdWV1aW5nLg0KDQpDYW4gd2UgdHJ5IHdpdGggdGhpcyBwYXRj
aDoNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jDQppbmRleCA4NThmZTRjMjk5YjcuLjM3ZTA4ZWVkNDlkOSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCisrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMNCkBAIC0xNjg0LDEyICsxNjg0LDE1IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdl
dF9raWNrX3RyYW5zZmVyKHN0cnVjdCBkd2MzX2VwICpkZXApDQogCQkJZHdjM19nYWRnZXRfbW92
ZV9jYW5jZWxsZWRfcmVxdWVzdChyZXEsIERXQzNfUkVRVUVTVF9TVEFUVVNfREVRVUVVRUQpOw0K
IA0KIAkJLyogSWYgZXAgaXNuJ3Qgc3RhcnRlZCwgdGhlbiB0aGVyZSdzIG5vIGVuZCB0cmFuc2Zl
ciBwZW5kaW5nICovDQotCQlpZiAoIShkZXAtPmZsYWdzICYgRFdDM19FUF9FTkRfVFJBTlNGRVJf
UEVORElORykpDQorCQlpZiAoIShkZXAtPmZsYWdzICYgRFdDM19FUF9QRU5ESU5HX1JFUVVFU1Qp
ICYmDQorCQkgICAgIShkZXAtPmZsYWdzICYgRFdDM19FUF9FTkRfVFJBTlNGRVJfUEVORElORykp
DQogCQkJZHdjM19nYWRnZXRfZXBfY2xlYW51cF9jYW5jZWxsZWRfcmVxdWVzdHMoZGVwKTsNCiAN
CiAJCXJldHVybiByZXQ7DQogCX0NCiANCisJZGVwLT5mbGFncyAmPSB+RFdDM19FUF9QRU5ESU5H
X1JFUVVFU1Q7DQorDQogCWlmIChkZXAtPnN0cmVhbV9jYXBhYmxlICYmIHJlcS0+cmVxdWVzdC5p
c19sYXN0ICYmDQogCSAgICAhRFdDM19NU1RfQ0FQQUJMRSgmZGVwLT5kd2MtPmh3cGFyYW1zKSkN
CiAJCWRlcC0+ZmxhZ3MgfD0gRFdDM19FUF9XQUlUX1RSQU5TRkVSX0NPTVBMRVRFOw0KDQotLS0N
Cg0KVGhhbmtzLA0KVGhpbmg=
