Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AE77EE5FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbjKPRdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjKPRdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:33:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C138181;
        Thu, 16 Nov 2023 09:33:16 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGHMwkm030164;
        Thu, 16 Nov 2023 17:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9IsFC/Y2kJgY/H4U5alYfe1LXKBQFNPZA+vHBLb8ckg=;
 b=GZKM6e+mNGeofH8EyzPoyyYY1CsaO/zl3SuQsG5xKwrfAcuE8ysMp1+F7YI8PECEE/E2
 kuzbjPb4m949I5cw8wa2G1rOEb70l7IbhPgu1MIVxKLn/i/t+7j+U01EeCposDz3bbMJ
 YrV9ubt9mtW+UA2BSFbNXkmkS5u3fMe0Kr+h+0G2b8nTYKiTDmanKxatFfDrr+rcs112
 n+qkdF4OuVW2i4e+W5NaQYBHfKjURDzXY03JpCRNDefhkqE5I1XK9bAMKMP5hPjr3mrq
 j4PUINIMymlzoJVAS36X4dGTuv4XzZ+EhUm6HoyTs2el72ye2YLqcYnYOLt9PoSpLzYK EQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2mduuhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 17:30:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGGRTL6036971;
        Thu, 16 Nov 2023 17:30:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ub5k7836r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 17:30:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKnUFfS6v27VaurqqghFmdEq+8i1Tpo0C+kKWzb02+UjJW+o7eVhhGiG4nPstsjCbRfVmaCxcVbVlfAEG5uRLWNkib7AhvLgjC7zs6iKQvKAsdp12R6zq1b/T14qvUr5kHRxGp+WnSliRLoUzaqSpd3WoJnSdB3iRCBVB9/bjwif1YvGA5zFngpH2gl72euc9n0400Ev8B7iWbnnTVp0QXeBpzCQArPEkXHl4Us/Fk3F67GWlRQquusT5dyc6SBLcpTnvD/F+k1Y5r480CLX0/aGBgrhdcGUasX8uIyKdupOa+29e5ws5A9ml7f0oWMIB20AhlLeNMDGAsVBaWft+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IsFC/Y2kJgY/H4U5alYfe1LXKBQFNPZA+vHBLb8ckg=;
 b=WE69lrWiNasySFagbBCwJpWYYWSOLnvtT4z6PeF8Ml8TD+VO10qegdpAQZm6GX+XyRjJq1Rrr35nPmqDU83ug73I2Dl1LkfwT3PD3PGkvur81cFL9U9R+X4RQ1KM2qhJA/0sjQKttSjoFVfvPVLiEcVwAmz1pBDBA61J/wWY0WxQBpRx9ov0ajFHcT5RPqhpohKIWQSFKrxE36/0dkkrANvVXA1mCQrBNMhVlCSpnIIPIOu+ztc63vYkGkMvq++5noG99zG3rAdSngSejNOButZ0N1PjpKpvNGLSyI9jog9oxqlBQ8Ge8oFgE6ofjOc1tBJ89vh4RcpJXcFsEzDJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IsFC/Y2kJgY/H4U5alYfe1LXKBQFNPZA+vHBLb8ckg=;
 b=HgomCi8o5eELj2wtUF2hhkb1dkMYliRX4ROx63iMj0aLdNhMp3V5IVE03tupa9jQAOrx5ymaNuH6SLMHlQJTSAD8k+2I8P3NSyWOuYS6oYCiexNAdxrrqh9KAebRSZghndSmpFFuoICF1grZOqNnAZEbSmSy6YcsYHBbyjHKbPA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7704.namprd10.prod.outlook.com (2603:10b6:610:1a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 17:30:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 17:30:45 +0000
Message-ID: <e3d03635-3b4c-44d0-8e16-a9d3a1b4cc92@oracle.com>
Date:   Thu, 16 Nov 2023 17:30:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] scsi: fnic: Add support for multiqueue (MQ) in
 fnic_main.c
From:   John Garry <john.g.garry@oracle.com>
To:     "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
Cc:     "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20231114223810.634200-1-kartilak@cisco.com>
 <09b84161-748b-c1c2-e4e8-96df5d2b01e5@oracle.com>
 <SJ0PR11MB5896F9B7FA37D78B91BB1D42C3B1A@SJ0PR11MB5896.namprd11.prod.outlook.com>
 <b0552a30-c94b-4877-890f-d3f5bbdeaebd@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <b0552a30-c94b-4877-890f-d3f5bbdeaebd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ad2320-7070-40cf-c08d-08dbe6c9c428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4Ysk0soASnuuQtKeCEOTaPb3rVXi81zxCtQ3A4/KjH9O+ysrlQHYb4yocDFU6dH4c/PhOrUdON7rKAGEPFgTaly/pt3ji/xJ/L9YQUXs8iY615PbIp50rIKxB/VkiSyyEKFuCopE+F0srUJWdXRhXm3jtsYixHDFNYFRHrabHr2oFOM6uMwWZwPtOPj+Ib2hj2Szj/NK5SOJMIyEzu2ikHZgUVDVi3ro1UWDalAkvRuPCHhLLZUAa1xq6u5IwIPU7WhWPX1wfntAED+fNbw9zLfDJzoT4ZbJeXlJDwR53RE0eMlNTOY1aAQPeUmI90WPlo1r244XfCn1pDUXBZIjInIA5xoEJdUPjFpW1m9fDIETS+eAzIBiwYpWg3aDKZY9Ma+esN6wF8jU2FbMQHQY7ijdamCiV51Yf4stnDi1gvNXsh+H/dLPr9OkCoRlo2Lo4iRRaOupDMU9+CpdRHyznc0Rm473OY8EOSKCTB4pjs6RKT6bRTvFT9fFFMKEW31D4lV35jfBmr/HxfftfFEcQnCVZhit6R4utjT+FDMjmW5G9zqV6XT31kiaunnlZNJotpvRqtu2kAAanvhvwq1n5dtHnN6G7uRn3jDy/+HwdwGdeNsXcyoLtAzBzJspFpr7LPbHzK6mTzXmzZPmd3rEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38100700002)(31686004)(83380400001)(26005)(2616005)(36916002)(53546011)(6666004)(6506007)(478600001)(6486002)(6512007)(54906003)(316002)(110136005)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(31696002)(86362001)(7416002)(5660300002)(2906002)(4744005)(41300700001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXd0OGRwUlpiWVFlK3NvUUpaNmdrVzRjMkNsd3l5b2c5b3U3SkNGbWc2eFJJ?=
 =?utf-8?B?dHl3QnJEZmZ0ZnM2dXdIVHE1K2NoVUZFYTBHN1FFUXAvc1E0WUpqRTBYNHNr?=
 =?utf-8?B?WDBRbWxyb2VSTGJ1RHlKTEJzKzEvS0RlVDVvbXdoZFhsdkFVbW1rcUMxL1RY?=
 =?utf-8?B?RUQyNklkQ1IrME9ZbXBITEluMHV3cVJhdHNRemxzbGFFSUlxV05CeXUraWpV?=
 =?utf-8?B?WU1Cc3ZDcHl3RXFPdXdYWUlUR1VCY09GaFYzTjJ3azAzK3JnZVhpK1hJVGhi?=
 =?utf-8?B?ZDhkV2o0TnAzeDZLWWVXQmNTWFBuVmk0dUNERGYzdkFUUk5BSktRQTQyZkNy?=
 =?utf-8?B?c2xGZngwVFBUdEpoZ29wUFpuOTBHYjhoWTRIVGxWVHhDUDltSHJxOGNOdFU2?=
 =?utf-8?B?cGRKWGdIQUVGS2psbTZmL3JFR3ZrTWpJSDY0dWJWZmp6L1d4Y2hyOG1XNjRP?=
 =?utf-8?B?bDc5ejcxeGdDYzJRc3hBNHN4ZHd5WG5KQWxYRWJhcUk1OWVoOEdLQW9WZFVF?=
 =?utf-8?B?amdiVEFOQ0tCOUkzSzBhNmhKNGMwSDhidXVWY3Y5ZDkxU0VJOW9VYXZvNkNB?=
 =?utf-8?B?Y2kzbGloaDZxWXRRaUZZMjZyMFNsaHczTXl6cFpxZHVSTUJmY2lqeTZ0R1RF?=
 =?utf-8?B?a0R3Z2pVSUdNdGtpVk5BeEV3Nm5lTmlqbjg4VHc5VWd0U2NwOU9JWWZMVE4z?=
 =?utf-8?B?eFVOKy9hbnN6ZXordkQzeDBwWXJ4Yzk2c2RFaDhyOXlGV0ZscnU4T3AvaVZv?=
 =?utf-8?B?MjU2NmdUc1JhSERkay9KUTV4UE1EZ2E1YjV6WXhzL1o0T3ByS0NueEx3OHRo?=
 =?utf-8?B?eDVrVm9GV0d3RU5pR2tiVFNKR3NlOExLSHFKdE92YXk3UDBUT1NJdGZHd0pF?=
 =?utf-8?B?ZjEyZDhzUEtrMStIYmVXekxwMW1LSWJRbHJGMy9rY3JFM3kvREhXbEdMZzVC?=
 =?utf-8?B?MUpOZjMrS2RtVEQ2a1hRQXlXMFozV0hUZHMyaTdnS1ZHeVM3QXM0TDFoKzlP?=
 =?utf-8?B?KzY2bDRnNkhYQ1R4emUrdmJIYjcxdWF3TUtSc2hDbldyd2ZXTU94eVZaZXh5?=
 =?utf-8?B?UHFVRzNrdVNiVGVxREFWbkpDcWhHOGxrY2JSNnA3MmtpNmxobWdQcXVQbXZS?=
 =?utf-8?B?dkNlMUNjTm8xWXRQR2VZSGY3Z1N6SkRHeGkwRmF6OE5zKzJXOEtIQmZtTVNE?=
 =?utf-8?B?WXNtSGJKTmI0eEw0ekIwZStrOU5JRXl6M0QvRG5uUm9RNWhIdFJLK09Xc3dv?=
 =?utf-8?B?Qngzdk01U1JWSVNGZkxWYWgwa2Y3UEcxR3RDUVhOQU1yVzJocHJRSzB5RGwv?=
 =?utf-8?B?QTh0Nnh4cDFyaHNPL1NES2RvTmR1K2tuTFRuMHY0TzBCSzdqSFFGK2dzdVZK?=
 =?utf-8?B?ZVBJVjZEQ21LRFJnaWV0N3I2ekQ0Y04wcjhqcDVYRmt1NHhYUmtXdWtQRWpY?=
 =?utf-8?B?VWdoV0kvanJVRjJId1RDTkdBWEJIZFZVN3I4NWhXc1MxSFppRjcrNkpJY2NH?=
 =?utf-8?B?eHVwSFVZOXI0aHlwcnJocTN6SUZmdGVzcTVPOS9LYzRKa2hhV3djNDhYZ2g3?=
 =?utf-8?B?c2ZtdVNlY0RySmQ1SFRhUVdjemJPWjJTdVhrblo4Q3JWd0x2S2JxclFzaTJq?=
 =?utf-8?B?V0dVcFdOQTBjQ0dHM0I4NU4vR1FSV2lnaXJVd0NVTGpMMDVGUDgyVWVXN0hP?=
 =?utf-8?B?ZlVPdGZOVSt4TXFoRjMyYzkyYzlCMCtCVnpndEJsdkxpR2xVdVpndmMrVHVR?=
 =?utf-8?B?WU5CVk56N2sxT3RkU1poQXRQVzBOSHhLY0E4ZVZheWtRcFljSGtDaTV6L2Rx?=
 =?utf-8?B?V1d1QWpUS2w2djh6S3VkakNuQjdBU08rNUJrK2QzNWtaQXZyNkFsVzZlNDgx?=
 =?utf-8?B?ZS9YdDRibUl2L3cvbXNlOHpYaDExZytPenpaTHdtVG5xUGpjVWFuOUhBRHRh?=
 =?utf-8?B?TU5qbUtUWGdLd29DajZhT2RQam1NZUI3N0dsSUM0V2xuWnZTMXJhc3doVVdj?=
 =?utf-8?B?OS9NdTZjWHJwYkN6OHY0b05FK1lic2dUaUhmT2NHS0lEWGNsWU1iUFZxRitL?=
 =?utf-8?B?RmJoWlhmWFRxNVQxazN2ME91Ym9jdVBlSkduN3NPeTUxZk05QmlBamtLdHd0?=
 =?utf-8?Q?+4GmyZivnxCiDPCFfMf9UJBDW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vVDWtts4oThF7hghiYMfpwRIE268iJxyHNWaKOl8qNui+Pg5sNLDQCHNj3tgWK+FTXIkaIKTvWBsj0kmt1nF210tDsmwiMqyVaOtAG1UA7RXyr+Bk1PLbHOtOxwwWhkrUWXTamRBUqZKqZ559sO+YLq5SUOOQMg1bGK/1NDUtQR7SUtZbnogTaa46OS3iPCytlXhzQMb9tX0izOwUOe4Sj/EKNumBY01xjX9laNbzxHPhRlW5vWevelcyclPaAmGcmKK1/mPWrY6QD+zftgYpfWfnA3Gt3PGPExFjEcalVBZv4pRt7oSr00FKRbq5hyQi6M6qt2t3l/qiUc5Lef2sUxMquqynyx/xfO28UhcPUy5NgR1leOalGicb3xZkMV7XgqMVaGsGECt6rFYm+y1fpLLVp92tsdZ9/lpvZ/Yyf1Wmam9Q7sQcfgqvrU9HrqjvmkGu8V7JYG/awDRyWUa5vrrGJ2V1QmBMqsgH0E9gblclY73ajtZXy0P7cY0/Bzv6C7ITiViEm3CBv+ZOAlfUOUPOZAGMUeuyEZToSJkFmZEhuvAsPA8ru6LG+ST29lYreyqwEiX1HJJXTlM16zHqv6VzEHC6Q15zaON4yiPCkik8n+EIemCTliJymWeoErGEN/JCncFHEVou5O78VDnMuGgtwnFc0zjsPjCeJ5r9t6UO26vhjbArHcjy7RHrDe0+GjBAJGgLjk4Aj9sicxewywXzX/U2ooVVcZNTYeunn/ljwK44w/rH1SVH/8v9Yb2D3ZkoSptqw+Q9eCax/Dj8QBRlUAcGJu7LL/VfJf//ENnWYqOD0dicavY1pQvKW6EYJQeX98MsKtIyPGHhPqbj+jmLNXWiiaWE9J2axzcPM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ad2320-7070-40cf-c08d-08dbe6c9c428
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 17:30:45.9072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDm/nV0bbX7SFscvdbZwz4bOvDuobWl2AR8u+j3tzX8Ll/QybZAK6l0dNoKKNwJhM7+PydeekUxEGlmpoag+Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_18,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160137
X-Proofpoint-GUID: a_YidjSxG2LXbhoXyPaCye1JhCIPnyic
X-Proofpoint-ORIG-GUID: a_YidjSxG2LXbhoXyPaCye1JhCIPnyic
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 16:32, John Garry wrote:
> 
> If you check blk_mq_update_queue_map(), for set->ops->map_queues unset 
> we call blk_mq_map_queues() - I am just wondering what does the 
> equivalent to blk_mq_map_queues() for you in these other modes.
> 
> I am concerned that it is not proper that we have a set->ops->map_queues 
> method, but it does nothing in some scenarios.

I think we get away with this as mq_map[for all CPUs] is 0, which points 
to the only HW queue.

Thanks,
John
