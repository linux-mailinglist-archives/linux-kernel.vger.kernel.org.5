Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD21B764F19
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjG0JPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjG0JOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:14:38 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CBB4C30;
        Thu, 27 Jul 2023 02:06:00 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R6jl30027907;
        Thu, 27 Jul 2023 05:05:47 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s36afn89n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 05:05:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5Lc0SeU1Qp1Bhg/uaJIqu85QJicBRpX+UeQf+LrPNhnbWN739SwdCgWxPxEzifPn4564oTCfP8hbeVKqGQpzVpPmYGVe+ge7o5poEHIx5wT0ycSEWYxULVsJgep93RB/Lzf6yeseZO5qreWBg9Qw6fGu3PDBntoQFpUx0XOEr57zk6SIPxOt1agL6k34GTY8XSmHofozWl4fV7mYIJzwt6rflFgPeW8/wdP/c/aSah4J/0qjV/zkqK/dFtXgytIiGnVqwhXmlCNDprXktcL8VlPPqqL8cLT6pb/LXc3hPzj3/elHF5t09obl/jghuULBF2/wQ8KaooOYHNtQm3v3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0JKyA221Vvp5rXYWG3O+mOR+TPJjammCXDYH4BqWYM=;
 b=awx5kL5WxfbxJU3ZUV4//yFR9p4ZVJLk6XmtHiD3qYwooI+/B5Zrr2eXaUAM+vdvckVneJA25j53Z6iHLMTPtTbWsgi4z6Yx45ywH69A4psxYRlyjzGXCQ/HaIBAccTemKSvKmEXDJMLe0csOW1TgLHr/bs7Gy0XWpIAlCer7Isji4Cpd+wFiwKhhqK1juo9pdR68Z5LvLZIBL8Ij0oxIABPvErvyeduuOxKRLzNsI5fhZgycnNIeDC/vojOXRsTbdZB9rPQupDA/5rYhkIVOnNz9pFoPmDJQJEWTeyV6HSfHSgpw4EN55KAnamu6kZY5f1xKpBrLtsvu0dBrI7sDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0JKyA221Vvp5rXYWG3O+mOR+TPJjammCXDYH4BqWYM=;
 b=8QLkGg1/h31qkLAp7JWOMYxkR9tuO2W1519xeQKSgIQjzE//tquOWVDd47Top6GnLg6fEo+cIt8qYITkEHnvqcgDB1+NWHMHgEiBs/JQnPwh6KHd+R0xupUrgVzB1BF3rzoNePYhfryX7Gj0kSCLMsZox4Y6HPH45h3oeF+a/nc=
Received: from BN7PR03MB4545.namprd03.prod.outlook.com (2603:10b6:408:e::31)
 by PH0PR03MB6689.namprd03.prod.outlook.com (2603:10b6:510:110::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 09:05:44 +0000
Received: from BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::9854:9bc0:ae2f:da]) by BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::9854:9bc0:ae2f:da%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 09:05:44 +0000
From:   "Balas, Eliza" <Eliza.Balas@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] Documentation: bindings: adi,axi-tdd.yaml: Add new
 TDD engine driver
Thread-Topic: [PATCH 1/2] Documentation: bindings: adi,axi-tdd.yaml: Add new
 TDD engine driver
Thread-Index: AQHZv5Bya5rUnb4ApEuNY3pox2mZkK/MYK6AgADm2UA=
Date:   Thu, 27 Jul 2023 09:05:43 +0000
Message-ID: <BN7PR03MB4545E574AB9886290115E5C89701A@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20230726071103.12172-1-eliza.balas@analog.com>
 <61fce1da-c8dd-f911-e4bb-b2198612e7c6@linaro.org>
In-Reply-To: <61fce1da-c8dd-f911-e4bb-b2198612e7c6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWldKaGJHRnpYR0Z3Y0dSaGRHRmNjbTloYldsdVoxd3dPV1E0TkRsaU5p?=
 =?utf-8?B?MHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dVek5XSmNiWE5uYzF4?=
 =?utf-8?B?dGMyY3RZekkwTVRrd1lUVXRNbU0xWXkweE1XVmxMVGhrT1RRdE56UXdOR1l4?=
 =?utf-8?B?TlRjd05XWTNYR0Z0WlMxMFpYTjBYR015TkRFNU1HRTJMVEpqTldNdE1URmxa?=
 =?utf-8?B?UzA0WkRrMExUYzBNRFJtTVRVM01EVm1OMkp2WkhrdWRIaDBJaUJ6ZWowaU1U?=
 =?utf-8?B?RXhOemdpSUhROUlqRXpNek0wT1RJeU16UXhORFUwTWpRMU1pSWdhRDBpUlV0?=
 =?utf-8?B?d2VFUTVjMU51TDFJeVR6aDNRMFZpZGxFeFpraHhPQ3RKUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlJXOURRVUZDTUhOTVMwVmhZMFJhUVZwUVZ6aEhOMlI1WjA1M2F6?=
 =?utf-8?B?bGlkMkowTTB0Qk0wRkVRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUkdGQlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkJRa0ZCUVVGMlpHaHJlR2RCUVVGQlFVRkJRVUZCUVVGQlFVRktO?=
 =?utf-8?B?RUZCUVVKb1FVZFJRV0ZSUW1aQlNFMUJXbEZDYWtGSVZVRmpaMEpzUVVZNFFX?=
 =?utf-8?B?TkJRbmxCUnpoQllXZENiRUZIVFVGa1FVSjZRVVk0UVZwblFtaEJSM2RCWTNk?=
 =?utf-8?B?Q2JFRkdPRUZhWjBKMlFVaE5RV0ZSUWpCQlIydEJaR2RDYkVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?blFVRkJRVUZCYm1kQlFVRkhSVUZhUVVKd1FVWTRRV04zUW14QlIwMUJaRkZD?=
 =?utf-8?B?ZVVGSFZVRllkMEozUVVoSlFXSjNRbkZCUjFWQldYZENNRUZJVFVGWWQwSXdR?=
 =?utf-8?B?VWRyUVZwUlFubEJSRVZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkRRVUZCUVVGQlEyVkJRVUZCV1ZGQ2EwRkhhMEZZZDBKNlFV?=
 =?utf-8?B?ZFZRVmwzUWpGQlNFbEJXbEZDWmtGSVFVRmpaMEoyUVVkdlFWcFJRbXBCU0ZG?=
 =?utf-8?B?QlkzZENaa0ZJVVVGaFVVSnNRVWhKUVUxblFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUpCUVVGQlFVRkJRVUZCU1VGQlFVRkJRVUU5UFNJdlBqd3ZiV1Yw?=
 =?utf-8?Q?YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR03MB4545:EE_|PH0PR03MB6689:EE_
x-ms-office365-filtering-correlation-id: 0d5dc0c7-442a-401a-d0f1-08db8e80a867
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xbOvlgxAQrDHAmw6q3yOyiGpIkjEydpzmfdGQkJwJQoOIi1tNuhevJOTboiCvy2EHrx5N0e61Dy61UOQ8gMQ/kZtpYKsaq6w8l4SSYSp1nl0AAlAdA0smq0HuoWklQLUDtqkL5NYmJPuH1nGAiqKQdSm7eBI8JRh+1C5i4x5vP/6J/fWY/A70lxx7vKzSYucyC9fX7AklpPSUTt7WOM08Nh+WUkTSqLS9yYPFyAmyjhGcqmUwYx75ODqMHON7BT06pIZ8/VBfi17AHbx9x1T3K4yLVYNtaHeWhq+Q729GnK9iYrnPDBH7VdJElBwPsMtsWo8v6fwL0FumMFlMt3XyvULiQYCMrAx7SB1+NhIGYCXeKcwdwd46+ZQRntcrVPMqcSYZ9d13tLhuTy3cQr1jhvsRdhF0MoKxwhf6PQJW93aNb9467668XGJhXQDgBF2q0+zYD3ZSmHv5oVACh48hdaTiuRcv07rixMxPVVv61PTed9bMlak09hp21YdcFl0LgMfjI4YwshKPU2ZY36RbOxPKg8BDGDxfMOjoa1A3qsCeLMSKZcwFoce5wf+HClbkD3ANFld4Yo7ol2HLXoSZIv5i496KlbPmXXvnVTGFw/PYlsNgbDeggi0B3UMl8z5j7ZZpBU6h+2hY4C1ut6PdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4545.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(54906003)(7696005)(966005)(9686003)(478600001)(83380400001)(33656002)(86362001)(55016003)(38070700005)(66446008)(2906002)(66556008)(71200400001)(53546011)(66476007)(6506007)(26005)(186003)(66946007)(64756008)(122000001)(38100700002)(76116006)(4326008)(6916009)(316002)(52536014)(41300700001)(8936002)(5660300002)(8676002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVVleStCTG9QR2hoYlAwNWxUanE4NkpXR1J1MkpCRjdvUHpWYUhPRTRsUjVz?=
 =?utf-8?B?S3EzUmRWVzFRaU04ekN6cjdRaEZ5U1BjUEpiOW1SR2xIcFlxZW5SOWZROHJH?=
 =?utf-8?B?TitqYlA0L2ZmejlhVHVJQjR3c0JuWkhWcWYyKzZyTUZmeVJVUnpjWU9uZ1A2?=
 =?utf-8?B?M1ZrVXJpSnJxa2xJaFByK3Z3Qnpqd2Q1WmhDZWtsWDhlN0FDMVVZbTNCRWxQ?=
 =?utf-8?B?NzBZR2w1cmU3N0ZEZ1lHLzNxVW5LZFljMkc3WGcxdkRhOUZHTXJWS3UwSnFY?=
 =?utf-8?B?VC9Nd0pwS3lzTzVrYkNYcnB3cUdOMlZYYUpaY3QxcEN0NHFzd1d3Z0pFZkNK?=
 =?utf-8?B?TzJJLzBTWFIzWk1LMUplQzA2cDg3a2oxenZ1TmswRjJPVGdCWHVSbDJHQjli?=
 =?utf-8?B?eUlCQ1RKVW5pMkZYK1NzSEJ4YzBkLyt1UTdyQXhOUUFxejN1UTh5Yy9GVDQ5?=
 =?utf-8?B?QmNoV1FZd0luQ3c3djNFSndIWXhrcW1GbjYzZk5QUDIzVGVCVlNGcTBXZHdJ?=
 =?utf-8?B?VGovOEV2ZzgxbkI3V25vMG5OZEtwNGQrZU1MZmptWmpSWm1VRlY4R0V1MDVV?=
 =?utf-8?B?Sm05UHNMRyt2aFFPdTlML0xPZWRUb1BFKzdMdFM0dmpTU3M3V0tKY1ZYUWdJ?=
 =?utf-8?B?Mm93c0xLL2plbWpkaGtMYitJNTlOeURBSnU2K3VCRUVsRElrbHU1YVE4MHlv?=
 =?utf-8?B?OGt0VUVjNDFNOVdmSGtIeWpiaDd2c21YbEJpSmNBcVNlcm1TaDBCbFFueGgy?=
 =?utf-8?B?Z2NxNjkwZGw3ckl2YzBUTFpYejVLRDkyZklDcWhaSlFZdkhXc0l4ZHFweG9y?=
 =?utf-8?B?dzVONURxODVrNnRTUG92MlBNYTE2NEF2ai9KQk1UOWJhRmlJYjJaZkd0Y1Va?=
 =?utf-8?B?bldkalg0TC9waW1peDk1QVBDWEtOMXFGRzB6bnQwdm92eUIwWENqaEV0WUtW?=
 =?utf-8?B?Y1VRcm9uNDYvY2szNFpJTWZTQmc4YkpsR2FNWGRlNVRPNXBITUNtNXVXamli?=
 =?utf-8?B?V1VKajNDWmtsU0tMOUpWZE1zeEd5NWNUYjVlVkMvck9UekNsdmtlSGtzWlJR?=
 =?utf-8?B?U0tLajRlQWlqYlJvS2huZGVTR2xCellmRUYyNjNLamZ6eDQ5aGRoRDlZRGdY?=
 =?utf-8?B?QU1lRHYyYlY0RytmdUJMaTdkY3JEejBtM20rTDlYQmIvM2lwSzNGOXp1aWFN?=
 =?utf-8?B?cVlSWjNqTTFCZXpxbFNFQlMzVmhvMXpQTnJMcWdUY2pHMFBkWUtxMTRnTEQy?=
 =?utf-8?B?NjJKcVRmY2E0M2xJckpmVVRLNlhGWHJVOGFMbjZpUE1lVVdnQVNoT3ZGODIy?=
 =?utf-8?B?eFNvd3l1UFNjZ01HRmNKZkx4NlNRRkxWT05kZnRCZUoxa3FCT2xjN3Bnampj?=
 =?utf-8?B?Wmp5Qy8rcmlhZ3ZiUE93TWx3N09Pa3d1UGprdS9WczJuaEUrcG5vNEd4ODhh?=
 =?utf-8?B?dHp3UjJuVVpWb0FkRE1vSFJ4U1o4Q1RZdEplbG9WYTVLT2tXbzJudnczcDZ5?=
 =?utf-8?B?cVNHZTUra2pUVEgwdXpUbHBXM2l1RXBuRWZPTXdVMm9RemNXbmI2VHQvajgw?=
 =?utf-8?B?UzFlZjVRYVpEd0JRV1hRUm9YbHpRNEpSN0NzM0NLVnlEMWNvMGhKc1liN0xr?=
 =?utf-8?B?ajVXVGJrQnIwTVZQWHhWVVlkVTBaUW54R1J0S3Mvc2pPcjltUDkyNGhYWjZR?=
 =?utf-8?B?d2lDZFJIMjZGSnZMdHQ0ekNNN3FsLzZtdElsWTBXUi9lWmJmTVFXQjhFeVlU?=
 =?utf-8?B?QmNxNWRCT2ZBVDU2eG1OeW13d1R4Rk9odnFtMnlMRDFvZDlwRWZZa0NRR3U5?=
 =?utf-8?B?Qlp6aXprTkpTQlFSd0hhdzNCMWJBa0JqZ3gxSjNvRFRiVDhBcmMyOS9rVFVF?=
 =?utf-8?B?Z01RcFhCb0MwOFN5OXh1UG56ODh0WWxkb0R1MXBZKzFPay9XMkx1ekNXUFRx?=
 =?utf-8?B?bno3SC94L0ljN1BmTWZIdjNPakZrR2NlRDdQNm9qMklmT2hDaGhVbkhOdlQ3?=
 =?utf-8?B?STMvRmxVOFRtMEw2SGpxZWNZMlB3SS9HWS9QQ3k3WFd5WDlwWTdKTzhtYXZt?=
 =?utf-8?B?c3U2RFdGMHh4WTFmUXI2djBJYm5KMS9qeDhLdEFRU0RHQnVNY1BRK2diMCth?=
 =?utf-8?Q?0IF2iS+5PDXByPeeP5XW1IqKd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4545.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5dc0c7-442a-401a-d0f1-08db8e80a867
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 09:05:43.4876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SR2OxAA271bnjSrbu1f1OGDPeUapbCSHJ4A0Jf/yyDBmKXeNUEVvUQuxBz1+XCfpZZ8oHq4e2QmwCNsGSZY2yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6689
X-Proofpoint-GUID: PYupHWnNEjq8Bd4ysJJb6fISAttcR-zl
X-Proofpoint-ORIG-GUID: PYupHWnNEjq8Bd4ysJJb6fISAttcR-zl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 spamscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270080
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBK
dWx5IDI2LCAyMDIzIDIxOjM1DQo+IFRvOiBCYWxhcywgRWxpemEgPEVsaXphLkJhbGFzQGFuYWxv
Zy5jb20+DQo+IENjOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9v
bGV5DQo+IDxjb25vcitkdEBrZXJuZWwub3JnPjsgRGVyZWsgS2llcm5hbiA8ZGVyZWsua2llcm5h
bkBhbWQuY29tPjsgRHJhZ2FuIEN2ZXRpYyA8ZHJhZ2FuLmN2ZXRpY0BhbWQuY29tPjsgQXJuZCBC
ZXJnbWFubg0KPiA8YXJuZEBhcm5kYi5kZT47IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gRG9jdW1lbnRh
dGlvbjogYmluZGluZ3M6IGFkaSxheGktdGRkLnlhbWw6IEFkZCBuZXcgVEREIGVuZ2luZSBkcml2
ZXINCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIDI2LzA3LzIwMjMgMDk6MTEsIEVsaXphIEJh
bGFzIHdyb3RlOg0KPiA+IEFkZCBkZXZpY2UgdHJlZSBkb2N1bWVudGF0aW9uIGZvciB0aGUgQVhJ
IFRERCBDb3JlLg0KPiA+IFRoZSBnZW5lcmljIFRERCBjb250cm9sbGVyIGlzIGluIGVzc2VuY2Ug
YSB3YXZlZm9ybSBnZW5lcmF0b3IgY2FwYWJsZQ0KPiA+IG9mIGFkZHJlc3NpbmcgUkYgYXBwbGlj
YXRpb25zIHdoaWNoIHJlcXVpcmUgVGltZSBEaXZpc2lvbiBEdXBsZXhpbmcsDQo+ID4gYXMgd2Vs
bCBhcyBjb250cm9sbGluZyBvdGhlciBtb2R1bGVzIG9mIGdlbmVyYWwgYXBwbGljYXRpb25zIHRo
cm91Z2gNCj4gPiBpdHMgZGVkaWNhdGVkIDMyIGNoYW5uZWwgb3V0cHV0cy4NCj4gPg0KPiA+IFRo
ZSByZWFzb24gb2YgY3JlYXRpbmcgdGhlIGdlbmVyaWMgVEREIGNvbnRyb2xsZXIgd2FzIHRvIHJl
ZHVjZSB0aGUNCj4gPiBuYW1pbmcgY29uZnVzaW9uIGFyb3VuZCB0aGUgZXhpc3RpbmcgcmVwdXJw
b3NlZCBUREQgY29yZSBidWlsdCBmb3INCj4gPiBBRDkzNjEsIGFzIHdlbGwgYXMgZXhwYW5kaW5n
IGl0cyBudW1iZXIgb2Ygb3V0cHV0IGNoYW5uZWxzIGZvciBzeXN0ZW1zDQo+ID4gd2hpY2ggcmVx
dWlyZSBtb3JlIHRoYW4gc2l4IGNvbnRyb2xsaW5nIHNpZ25hbHMuDQo+IA0KPiBQbGVhc2UgdXNl
IHN1YmplY3QgcHJlZml4ZXMgbWF0Y2hpbmcgdGhlIHN1YnN5c3RlbS4gWW91IGNhbiBnZXQgdGhl
bSBmb3IgZXhhbXBsZSB3aXRoIGBnaXQgbG9nIC0tb25lbGluZSAtLSBESVJFQ1RPUllfT1JfRklM
RWAgb24NCj4gdGhlIGRpcmVjdG9yeSB5b3VyIHBhdGNoIGlzIHRvdWNoaW5nLg0KPiANCj4gU3Vi
amVjdDogZHJvcCBkcml2ZXIuIEJpbmRpbmdzIGFyZSBmb3IgaGFyZHdhcmUsIG5vdCBkcml2ZXJz
Li4uIHVubGVzcyBkcml2ZXIgaXMgaGVyZSBhIGhhcmR3YXJlIHRlcm0/DQoNCkl0IGlzIG5vdCBh
IGhhcmR3YXJlIHRlcm0gaW4gdGhpcyBjYXNlLCBJIHdpbGwgbWFrZSB0aGUgY2hhbmdlcy4NCg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRWxpemEgQmFsYXMgPGVsaXphLmJhbGFzQGFuYWxvZy5j
b20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21pc2MvYWRpLGF4aS10
ZGQueWFtbCB8IDUxICsrKysrKysrKysrKysrKysrKysNCj4gPiAgTUFJTlRBSU5FUlMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDcgKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgNTggaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWlzYy9hZGksYXhpLXRkZC55YW1sDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21pc2MvYWRp
LGF4aS10ZGQueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21p
c2MvYWRpLGF4aS10ZGQueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXgg
MDAwMDAwMDAwMDAwLi4xODk0YzFjMzRkNGYNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21pc2MvYWRpLGF4aS10ZGQueWFtbA0K
PiANCj4gV2h5IGlzIHRoaXMgaW4gbWlzYz8gTm8gc3VpdGFibGUgZGlyZWN0b3J5Pw0KDQpJIGNo
b3NlIG1pc2MgYmVjYXVzZSBJIGRvbid0IGtub3cgd2hlcmUgaXQgc2hvdWxkIGZpdCwgSSBkaWQg
bm90IGZpbmQgYSBzdWl0YWJsZQ0Kc3Vic3lzdGVtIHRvIGluY2x1ZGUgdGhpcyBkcml2ZXIgYmVj
YXVzZSB0aGlzIGlzIGEgZHJpdmVyIGZvciBhbiBGUEdBIElQIGNvcmUuDQpEbyB5b3UgaGF2ZSBh
biBpZGVhIHdoZXJlIEkgc2hvdWxkIHB1dCBpdD8NCg0KPiA+IEBAIC0wLDAgKzEsNTEgQEANCj4g
PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1
c2UpICMgQ29weXJpZ2h0DQo+ID4gKzIwMjMgQW5hbG9nIERldmljZXMgSW5jLg0KPiA+ICslWUFN
TCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDoNCj4gPiAraHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21pc2MvYWRpLGF4DQo+ID4gK2ktdGRk
LnlhbWwqX187SXchIUEzTmk4Q1MweTJZIS1hRWdwdDktdlhyZTFvTDNBcFBseWQ2ZnpNQ1ZjSW5h
RWlHNTlxSg0KPiA+ICtkSkpLYi1zcW4yVkdFZVFoZjU1MWdYSDVLcHVqbEJPR0RmeVR6YUMteUVx
SEdKZk9mYzBkcS13JA0KPiA+ICskc2NoZW1hOg0KPiA+ICtodHRwczovL3VybGRlZmVuc2UuY29t
L3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnkNCj4gPiArYW1s
Kl9fO0l3ISFBM05pOENTMHkyWSEtYUVncHQ5LXZYcmUxb0wzQXBQbHlkNmZ6TUNWY0luYUVpRzU5
cUpkSkpLYi1zDQo+ID4gK3FuMlZHRWVRaGY1NTFnWEg1S3B1amxCT0dEZnlUemFDLXlFcUhHSmZN
aXkyWUJVZyQNCj4gPiArDQo+ID4gK3RpdGxlOiBBbmFsb2cgRGV2aWNlcyBBWEkgVEREIENvcmUN
Cj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gRWxpemEgQmFsYXMgPGVsaXphLmJh
bGFzQGFuYWxvZy5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjogfA0KPiA+ICsgIEJpbmRp
bmdzIGZvciB0aGUgbmV3IGdlbmVyaWMgVEREIENPUkUsIHdoaWNoIGlzIHBhcnQgb2YgdGhlIEFu
YWxvZyBEZXZpY2VzIGhkbCByZWZlcmVuY2UgZGVzaWducy4NCj4gDQo+IERyb3AgYm9pbGVyIHBs
YXRlLCBzbyAiQmluZGluZ3MgZm9yIHRoZSBuZXcgZ2VuZXJpYyIuIEluc3RlYWQsIGRlc2NyaWJl
IHRoZSBoYXJkd2FyZS4NCj4gDQo+ID4gKyAgRm9yIG1vcmUgaW5mb3JtYXRpb24gc2VlIHRoZSB3
aWtpOg0KPiA+ICsgaHR0cHM6Ly93aWtpLmFuYWxvZy5jb20vcmVzb3VyY2VzL2ZwZ2EvZG9jcy9h
eGlfdGRkDQo+IA0KPiBOb3QgZW5vdWdoLiBEZXNjcmliZSBpdCBtb3JlLiBIZXJlLg0KPiANCj4g
QWxzbywgd3JhcCBhY2NvcmRpbmcgdG8gTGludXggc3R5bGUsIHNvIGF0IDgwLg0KPiANCj4gPiAr
DQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGVudW06DQo+
ID4gKyAgICAgIC0gYWRpLGF4aS10ZGQtMi4wMC5hDQo+IA0KPiBWZXJzaW9uZWQgYmxvY2tzLi4u
IGh0dHBzOi8vd2lraS5hbmFsb2cuY29tL3Jlc291cmNlcy9mcGdhL2RvY3MvYXhpX3RkZA0KPiBz
YXlzIG5vdGhpbmcgYWJvdXQgMi4wMC5hDQo+IA0KPiANCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+
ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAgaXRlbXM6
DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFN5c3RlbSBjbG9jaw0KPiA+ICsgICAgICAtIGRl
c2NyaXB0aW9uOiBUREQgQ29yZSBjbG9jaw0KPiA+ICsNCj4gPiArICBjbG9jay1uYW1lczoNCj4g
PiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0OiBzX2F4aV9hY2xrDQo+ID4gKyAgICAg
IC0gY29uc3Q6IGludGZfY2xrDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBh
dGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gY2xvY2tzDQo+ID4gKyAgLSBjbG9jay1uYW1l
cw0KPiA+ICsNCj4gPiArdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiAr
ZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICB0ZGQ6IHRkZEA4NGEwMDAwMCB7DQo+IA0K
PiBEcm9wIGxhYmVsLCBub3QgdXNlZC4NCj4gDQo+ID4gKyAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAiYWRpLGF4aS10ZGQtMi4wMC5hIjsNCj4gDQo+IFVzZSA0IHNwYWNlcyBmb3IgZXhhbXBsZSBp
bmRlbnRhdGlvbi4NCj4gDQo+ID4gKyAgICAgICAgICAgIHJlZyA9IDwweDg0YTAwMDAwIDB4MTAw
MDA+Ow0KPiA+ICsgICAgICAgICAgICBjbG9ja3MgPSA8Jnp5bnFtcF9jbGtfUEwwX1JFRj4sIDwm
enlucW1wX2Nsa19QTDFfUkVGPjsNCj4gPiArICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAic19h
eGlfYWNsayIsICJpbnRmX2NsayI7DQo+ID4gKyAgICB9Ow0KPiA+ICsuLi4NCj4gPiBkaWZmIC0t
Z2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUyBpbmRleA0KPiA+IGFlZTM0MDYzMGVjYS4u
MjgwZTY2Y2NkZDU2IDEwMDY0NA0KPiA+IC0tLSBhL01BSU5UQUlORVJTDQo+ID4gKysrIGIvTUFJ
TlRBSU5FUlMNCj4gPiBAQCAtMTM2MCw2ICsxMzYwLDEzIEBAIEY6CURvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9od21vbi9hZGksbWF4MzE3NjAueWFtbA0KPiA+ICBGOglEb2N1bWVu
dGF0aW9uL2h3bW9uL21heDMxNzYwLnJzdA0KPiA+ICBGOglkcml2ZXJzL2h3bW9uL21heDMxNzYw
LmMNCj4gPg0KPiA+ICtBTkFMT0cgREVWSUNFUyBJTkMgR0VORVJJQyBUREQgRU5HSU5FIERSSVZF
Ug0KPiANCj4gSSBhbSBwcmV0dHkgc3VyZSBHIGlzIGJlZm9yZSBNLiBJdCdzIGRpZmZpY3VsdCwg
SSBrbm93Lg0KPiANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21t
aXQvP2lkPWMxOTJhYzczNTc2ODNmNzhjMmU2ZA0KPiA2ZTc1YWRmY2MyOWRlYjhjNGFlX187ISFB
M05pOENTMHkyWSEtYUVncHQ5LXZYcmUxb0wzQXBQbHlkNmZ6TUNWY0luYUVpRzU5cUpkSkpLYi1z
cW4yVkdFZVFoZjU1MWdYSDVLcHVqbEJPR0RmeVR6YUMtDQo+IHlFcUhHSmZQdEtKdXN6QSQNCj4g
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpUaGFuayB5b3UsDQpFbGl6YQ0K
