Return-Path: <linux-kernel+bounces-29892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4981F8314C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5B61F21A03
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D69E20B1D;
	Thu, 18 Jan 2024 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="WATtEuCM"
Received: from outbound-ip24b.ess.barracuda.com (outbound-ip24b.ess.barracuda.com [209.222.82.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49AC20B10;
	Thu, 18 Jan 2024 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566362; cv=fail; b=Lei+qKhecmpmoSlAEjwigbEQODHBZrqyRGbW9WJZJCEYjXQSTylfuUvmWNhOwa1lzc5k881HeIxUaImooEu63wTmETtgGrBlkVBmQf936Zvmj6HRHjiwuKD8ywNCToztYTM5snOd/xVvW7ax7zTs/Rd+DmcpTxglvSSq15CHisY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566362; c=relaxed/simple;
	bh=PR7JVrPw1gPyTh9A3ApSgM9wc/GGx+39XrWkBwpj3T0=;
	h=Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BESS-ID:
	 X-BESS-VER:X-BESS-Apparent-Source-IP:X-BESS-Parts:
	 X-BESS-Outbound-Spam-Score:X-BESS-Outbound-Spam-Report:
	 X-BESS-Outbound-Spam-Status:X-BESS-BRTS-Status; b=nt0OAeYg3V8sj8X6S7RdevGDgwk60K1noYKwt+Jo2JUiE48iw+hoULGZl05W7XikVeyDBHZ7+trUUMMYSKYjwIuOHyJFDcAzsA4R6/O4qi1WziKE7OwnMdve1aEMQHmr5lfuCej8pFP9sGlkPAR0lxaW0ANI2hAfGzC6lnj0SSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=WATtEuCM; arc=fail smtp.client-ip=209.222.82.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40]) by mx-outbound18-153.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 18 Jan 2024 08:25:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCjkTm3dJ6prGSNFPdFMWLxXxU+DLe5Q6vnsButTUoMnnmHX33Mm5B4Tt58JZqFAdBMPsuJnlkQi+LCnHCF5mCw6RbLG913w2t/yIQhL+Z0R881NCFOhl7WQ3f/lE9+7qlGuvDa3JFaQ3bTFE5SWa3wev2qG0FtPW/GbEZGF9gePRA8hYPvW9pvKNATyywGS/ntP7IgwVY4EXj4mubjeRYSY1Dv5Olxsl3N14HZIWwwBMe7LsD3qF7PCwTLN/jd/YthlvMy/eYna2WCGWKyVg/uzB0z2txT+/3/JFEt8zJ5xUair+Aoa8udEF6JdjhePYqE7OJoFn7QC2nTNKaO+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+grBI/+1iKef6ClC/3H9JXsV4Qz7qNHz9kOzSgEj5G4=;
 b=QFxIb3YpdSPKH7S8W9rTO2oHsbs6Rn+2tB/ACga+KdmzGXNRjI3JQsEx/GDDQRd0KF5HIBHq5o65MbG1UAKocAuROjT8DcBckT1X/fCjbdHn0PTixe6aWaXtTAA9BQyDa6P7BohDT0QW6VUd2VStGWfLVAmvNAe61zGHIn23QATxP1pwTJPSDK1UkMH59ztRjN/6xLRQFU1Y+dIIlof8wK5/Pu0c6fDcfhuOO0nl0mNW1yZS4iJeEPt+bRSyjVdIkYpIDwzRhQ20jUXT0N+ZLtM5QlrKJ1fYuR5n6NttuLsHH2pofEivJZooRdAiRoM5yRqVXb5H/IoGfl+3q1gS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+grBI/+1iKef6ClC/3H9JXsV4Qz7qNHz9kOzSgEj5G4=;
 b=WATtEuCMkk7ZN/kD2cGC39o1T0eZNDuc/+r+iqZUdDon6BeKMdOR8JYJHqjm0J0dwLvUZ6F0kfe+ZKG6KMkyX1fVjqclmFJV9KbFOl+3tB9dKzCg6uD0vxreW+v+QEmJIIfaOz2ToQUpoFOLfUeKH0o1Lk+PQ4YS9tD9Qf0d+EB3pUSMqP1FCFFg9EivtBYHQVzR/vDTsnGOBV/Yt+cPuu6tn3kxLGIuiwX4EtQMdr45izw5NeRtBiTRbRrc8oIYnHOBc9rZj2q9VYUN2enoQlNwpHELJKeM0dlxSO8AH3McFyCniabOR5lPVqwl+txEwcWuoI6HdM9GIBI8FmHuSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19)
 by CH0PR10MB5114.namprd10.prod.outlook.com (2603:10b6:610:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 08:25:42 +0000
Received: from BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::7cf4:e989:1a52:fb39]) by BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::7cf4:e989:1a52:fb39%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 08:25:42 +0000
Message-ID: <fd5550ad-76c0-419b-aa07-a0493a57286e@digi.com>
Date: Thu, 18 Jan 2024 09:25:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] gpio: vf610: add support to DT 'ngpios' property
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, andy@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, linux-imx@nxp.com, stefan@agner.ch,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240117083251.53868-1-hector.palacios@digi.com>
 <20240117083251.53868-2-hector.palacios@digi.com>
 <CAHp75Vci=1nAvxRcbkK2SxGWGbQVbzQMTycMt8tZ5snPRTYXOg@mail.gmail.com>
Content-Language: en-US
From: Hector Palacios <hector.palacios@digi.com>
Organization: Digi
In-Reply-To: <CAHp75Vci=1nAvxRcbkK2SxGWGbQVbzQMTycMt8tZ5snPRTYXOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To BY5PR10MB4370.namprd10.prod.outlook.com
 (2603:10b6:a03:20b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4370:EE_|CH0PR10MB5114:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8d580b-ca47-4470-b905-08dc17ff0f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KdJx56PVy/xfLqbRWtBA3W1DyvuJfNk5lo8MTGcCnwKFYsQntCub/XyhDJtO2+d5cYGNprsh316QHwQH9yx/MxUzV1HBNe8wUTTvOooVZlDXu80MdOjSCh8jmz+i2k4e/lLYw20DHFVFAx10liybsuq6fh2A7RjQY3nTM1qkq1f44wFh/1e786WCmKwRrOKS0sC3nZrY2Qqt/AMHi9THfPwH95q8NpIMlVVpb5OL1tst31adBbpv0HTShaxG7vvWxChZSvgdg1XzzhNp+uXkGXjl7oa4LUqu/tRblG+KxyeaAkfhLfYC21SnBZuwdLafLxuG3U7oDPRIOE6u+1knhajXgpp/RjvBisPpgR7TOn8x3m1nRctmqw+kGybf+xOl7KcUUyH9T4xjRXUmyt5jct97nejRDSU7OvuiMfp/XLBK3tUjvszb9tsCpND8EOKPKc3bCeKYQhY+zlegZmSNFoTwwShjkJW0p0WyCHXFIR8EyPdJUwAjU39uIhRTtSiDDJTK077vuqMMqtbmDiZHrtnqOTNOZVFrwkd+hrU/2RkFeL2aS9BIWrLqGWoT33pU90kkZ/CnzuY9e1ntyz7bEiIjY6K/mv3wYQIL1ZsygIIjj1wbJy7CpRmiAI40mC81d2lpWUuStB5DL41mce08Qw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4370.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(396003)(366004)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(86362001)(31696002)(6486002)(36756003)(316002)(66556008)(66946007)(66476007)(6916009)(478600001)(53546011)(6512007)(36916002)(6506007)(6666004)(44832011)(2906002)(8936002)(4744005)(5660300002)(7416002)(31686004)(4326008)(8676002)(41300700001)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGEzekxRdWJpMnhYNHZIcmplRE9ML1ZTVVMvaHNDNVJoeTVONFpZaUszdlJt?=
 =?utf-8?B?UVZoSEVWWi8xNmJyWm9nU2REZCtRSjZ6VWcxcFVIWDh6aFUrNGVGT05BWi8r?=
 =?utf-8?B?LzF2ZkR5M1VmUGNsdFBJZTZUam45ZGFKTWxnN3NPSC9XUmZHMUhpcUY0Z3hF?=
 =?utf-8?B?VnoxOTIxYVpIYkFIWE92MkplWDUvZUhXcXRGMXd1M0tGU3NVWWtuT05UNkV2?=
 =?utf-8?B?Sjl1T0FMRmYwai9GQ1Rrc1czVEE5cnhHVDB6a1JpTWpTU3p6dmU4RFVCV1ZE?=
 =?utf-8?B?TlFYUVlHVTFvRjZEUHU2bVczdlRFNDFXKzVKbVhna0dJMWV1eHRSeDBGaXVY?=
 =?utf-8?B?RDV2V2h1UjM0QThnaEVYOFJET3piZHYxREJjVzF6NmdMYm1VSnh0V29uWGpw?=
 =?utf-8?B?SG1pSUNiS004RmZQMzE4OEJ4WHJJNVhpUGNBM0YreGYwSmRYUWg2RlVWMEU0?=
 =?utf-8?B?dnFPZ1AvbTVka1h6dVU3Q1lkSUtFOFV3S0llanF6YkZUbTJRUUlsQXpwTkFE?=
 =?utf-8?B?elgvc0N2azVSeSszVXVHbEFNNkx0MjEzTVFUUnlnUFFGdy92T2d1VFYyZ3Zs?=
 =?utf-8?B?c1Z6VXRCaExTSmRsKzEzWlFQeEdLNlVpK24wa1lPdkJlMmU2MEQrczlldUln?=
 =?utf-8?B?N09kb3VUQ1o2bnFiT2hqL0ZjNm9DRFdMWk44eityaWZEamJpQ3FEMUQvSi9l?=
 =?utf-8?B?RE9Kbk8wQmZxaDhLQlN6VThjU2l4QVNGWmNmNUNudDFjbGsvSzA4akZnMjJU?=
 =?utf-8?B?S2tGTmdjQllzSGFndUNRQURiQ1VEd2xEMmVFLzRtT2cyUHNXcTZOVTRPK3dJ?=
 =?utf-8?B?S2RkU0duaTRSRmEvZnNKQnpqZTRYZlZWc0xmS0d5dExDWkVaaHJaYzQ0dmpX?=
 =?utf-8?B?ZmdoNXR1cU4wcHNBTVUzUzE0WjdUVHVML1pOUUJBYmdQZG1lcTRQTWxGRnlI?=
 =?utf-8?B?MUNRN1RIYnBWcHJxVHpvb3VOalFpUkdiR1dIcllLVHljeWZQMGlaR2NIVlFP?=
 =?utf-8?B?RXk4djJjVy85OGZQVmZJRkUzSXV4eEl3MnRkeEdreGVGS0wwaWF2VDRPWnZY?=
 =?utf-8?B?WHozcDYvSGRkTzVWQktXbG1pMjZ3QlJ3LzdjV1cxYkoybUJOclZlMTJUdzdO?=
 =?utf-8?B?SEtpRUtLRkdHekFiRGloVjMxTW9BNG9kSnhCVVFmVzZFb296TU1WTXhPR2Q0?=
 =?utf-8?B?YzZmd3Rvd1dVR1lQWGJ1TVkzallEdXJpQm9iYXZSZTZDM21URmUvQUZYSjI1?=
 =?utf-8?B?RDZCbHA3cDZ6dzFadHhseXhvSzlLSHN1blZRQ1A4VG84RjhmeG1hWjBBUUdm?=
 =?utf-8?B?Si9TMkhKVVdOZm1ObjB2NFBVSVMxQWNzS2RYY0l4MVExWmc4bTJ5SjVQcUhz?=
 =?utf-8?B?YVRJa3l0MngyZXdqKzZzajdWSHRHbGJpaWZ3bzIwa05HZmJOR1FnSmt6RDQy?=
 =?utf-8?B?ZlVMZktYZ1Q5TXlKT1Fna1JvL00wRFpSVDlWQXZSdSt5L3cvRk5FeHF3S0Mx?=
 =?utf-8?B?QXo1ZTZ5QmJVNGVoTnNGMmNNMzVqN0UxYXI3YlRGQnRDbm1UdjNxaCtGaFNT?=
 =?utf-8?B?NTZHTmt5YUUyTU9vRHlJclBDNUtQZTltTHl1dHRad21Yc1NFd0pSYjRPQkdk?=
 =?utf-8?B?TWxJcXlaTzRLNEtxZG40OHE4YXFSbk5XNkdaaVVQSTZwMEhwZzl5WjFKdHpW?=
 =?utf-8?B?WjM5ajlTMXpRNUc5aDBJWEhwc3FINGdHWkVXRmhmbDEwbVFzbEcwdmFWU2l2?=
 =?utf-8?B?WjROTGVyZ0FQTi9KUmtkdWdYaTVJSlh1TlVveEEvWThSSDlzUjVwbzE4MXdX?=
 =?utf-8?B?bkN3VzE3VFpWS2NPREVwZDNzZHdaTE1YTHN4bTQ0VlZCZXNuU1g4U2Zlc2py?=
 =?utf-8?B?UHJJQ09KejhxajZjRGljUmgrRmVhK0gvajBTUnF5WDZrYnErdlBCd1lFblVn?=
 =?utf-8?B?blA0VXJ6ZWZCY09CdkR0NnNjanVLNlBQYitjaW8zdkhmYVQ0TGVVOXBIZW93?=
 =?utf-8?B?RHA0d3BNeXh1dFFrbms5QjN2cEtUek9BV0FPOFB3UGtVS2JaYmNrYWo2Y0pN?=
 =?utf-8?B?cFR1VEpGcjZzQlB4WWFJS0JRVWd6bU1wamxoZjQ0czFjcWsydGxnZTdUQS9N?=
 =?utf-8?Q?O2A9g3P1YxYaenpLj9IBUr4WI?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8d580b-ca47-4470-b905-08dc17ff0f1f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4370.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 08:25:42.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KP6A0rl6kgfOVDC9c0AiLEqHNbUtj/SGRrP2ZYdTPyKKaJsW3Iu71KARzgYe0e1M/fo7eHIy/dpoP9sd3H/wlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5114
X-BESS-ID: 1705566345-104761-12525-14975-1
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 104.47.73.40
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVubGlkBGBlAsLSUx1TjFIC3J1C
	QlJcnA0tDC2DjFONXSMsUsxSwxLUmpNhYABhSVLkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253595 [from 
	cloudscan14-208.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Hello Andy,

On 1/17/24 21:51, Andy Shevchenko wrote:
>> Some SoCs, such as i.MX93, don't have all 32 pins available
>> per port. Allow optional generic 'ngpios' property to be
>> specified from the device tree and default to
>> VF610_GPIO_PER_PORT (32) if the property does not exist.
> 
> ...
> 
>> +       ret = device_property_read_u32(dev, "ngpios", &ngpios);
>> +       if (ret || ngpios > VF610_GPIO_PER_PORT)
>> +               gc->ngpio = VF610_GPIO_PER_PORT;
>> +       else
>> +               gc->ngpio = (u16)ngpios;
> 
> This property is being read by the GPIOLIB core. Why do you need to repeat this?

My apologies; I had not seen this.
I'll use gpiochip_get_ngpios() on the next iteration.

Thank you!
-- 
Héctor Palacios


