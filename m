Return-Path: <linux-kernel+bounces-23506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5277582ADBB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10EF283819
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4999154AA;
	Thu, 11 Jan 2024 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="M+tZzUZn"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2051429F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.10.233])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 5FE7510C621A3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:44:49 +0000 (UTC)
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.203.211])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id CA1CB10000D84;
	Thu, 11 Jan 2024 11:44:41 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1704973480.421000
X-TM-MAIL-UUID: 2567e73f-f9f4-4810-9c22-119366b4b518
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 66F681000031F;
	Thu, 11 Jan 2024 11:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLJSanXq1YW+uvZ7kfyCaGZqJ7vt8kyMqszK6vXXElLKUdW9On73MuBxqpPt6WGe6vq8Hexm7bax8DvvdqXJj3D6ECMSiMof50FHClZaXZD5q+pHDPqrDlm6BWYhbYqiaUzr4Mz6BmIADXu40RTdV7guss8enZfVr6Zu/Ylz58Q4GzQ32xuLh8SuQIPjnc9VoXTYYCKmJipWetVstd5hYCu3Ib31xO1aX6Qx7z7RZmH2rYO/eydL/vWbRJ1/0hpXN71t69Xt0RJBP/04jk5Zh8oAstReiylqaKeYNeNGw9VO0Z5Hky6AevwoMNjihwJI7xsGBjZCZvYxFmyZ0fbVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlJK0niz523lW5AyQetVdf6seFRsysP622RkxCcFLoY=;
 b=n/lr0Ofh7sI798O411lEM/7qSdXb8AOX87/FmpCxJKBxE5DM+4+8Pqmjcy32qgIbFDrIpahVc104QuvFQx9jeFru7GWMEB73evt0eTrNNV2sDyx7HRyEkSkg/4tbv4V9mxU3ubsbYZH9zqwUDrURgQpvwq9I5xngMtnhiva9NvUZNXMzpKj6ICUpAhoNfoUd+Rt60YQ1TaI7RVwJeiD4AIYUIl5UzWra2j6vvQSDE6Jt1Z0A43RxP7Dq3PHqLc6EomKS0AqQ863KFlpvZCgE7yt26F//imzPWixQ60mVRcZv2lc9TEjPRMzVVyw9VksL4iePas+6S6nvA8CQLKo9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <4b863e76-31f1-475d-9056-764439318010@opensynergy.com>
Date: Thu, 11 Jan 2024 12:44:36 +0100
From: Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [RFC PATCH v3 00/11] Add support for Intel PPS Generator
To: "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
 "jstultz@google.com" <jstultz@google.com>,
 "giometti@enneenne.com" <giometti@enneenne.com>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Dong, Eddie" <eddie.dong@intel.com>,
 "Hall, Christopher S" <christopher.s.hall@intel.com>,
 "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
 "joabreu@synopsys.com" <joabreu@synopsys.com>,
 "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
 "perex@perex.cz" <perex@perex.cz>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "N, Pandith" <pandith.n@intel.com>,
 "Sangannavar, Mallikarjunappa" <mallikarjunappa.sangannavar@intel.com>,
 "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
References: <20240103115602.19044-1-lakshmi.sowjanya.d@intel.com>
 <ZZlvqvYQQuse_P4E@smile.fi.intel.com>
 <CY8PR11MB7364D6EDCCBCCDBF9DCB0BE5C46A2@CY8PR11MB7364.namprd11.prod.outlook.com>
Content-Language: en-US
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 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
In-Reply-To: <CY8PR11MB7364D6EDCCBCCDBF9DCB0BE5C46A2@CY8PR11MB7364.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::10) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|BEVP281MB3657:EE_
X-MS-Office365-Filtering-Correlation-Id: 04dfdbc4-4bfb-4fcf-8465-08dc129ab107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ttxC90x9zQeOjVsHizT1JrhiBGl9dYspaLT53I7HHewmGgwz7xGpX7JVTmn9/xqu+ITBpauZGPeBUnrCv8CZMOTWRmfzX068I1+fI7rCAf0fSdb4vOJRUkeWMo5iiZq+30k0yokpDbd2Z92ZbWS+SYkTjCjspoeHKWBip+WS8YkQwIP8YJI7xYz93ESsXbjUwcdKdSMUnBxrCBnwkwmsBhiZ9JfEaEpiOIEBNoiV5jbM6YKHj9+6J4Int9V7vBs83g0YziqrOIjzTxFIgCG2EdA8YNOUTDCwdlVnlPRodeicuMkpoJn+fs44MvpidenxRVi6LAfGB0Wv0UtOu7JYP24dFhmXBrB8KFXZWWa5DnrVHTPdFdX+Y7cZo5HpRx2U8MHkhVd40piSqYn5f+SsAhyJm7fcKQ3PpR9Zs+2DRZWjm8gKSKi2xO6v1IBpKSpyGLLZB7QbMBi0NuZc53nX1L+Fb8HdQczSA3lzoYGbfBmZsoZ/lNVJrG+LdS5COCHl8Dd6A57oxHH36RKJKUIk8XZ0/kLOcMzlo4p9sCUyfbT0145w+Cp5XmezcPMQuz4zYxZPcLAGwQTWwN/z/YoJiHm7gTUA2+MoLzdZIoOj+AI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(346002)(366004)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(83380400001)(478600001)(966005)(8936002)(8676002)(44832011)(4326008)(66476007)(66556008)(66946007)(316002)(42186006)(36756003)(86362001)(54906003)(110136005)(26005)(2616005)(38100700002)(53546011)(31696002)(31686004)(5660300002)(7416002)(2906002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFdDRWN0WkEyMGdrQ0N4VDduUjVYekVXWnNremxpbXU3YW9ybnlpenI5KzNO?=
 =?utf-8?B?REVqRnQxcVorQWZSbFRxeUVyV1NQL1E2OGVMcC9GTllBcG01ZERTeDFkSzlr?=
 =?utf-8?B?N01CVHR6d3EvRjQzcDQxeWtqUG9Qamc4TU9qSlgxY0EyKzg3blMrakN4akZo?=
 =?utf-8?B?MXBaL2xrc3lSanlYcW5oTUw0SnVxQXh0T3VwQWhQOEhodFhxSUpCby9QZkdX?=
 =?utf-8?B?eUtpSzFRYjZEeEtGR1pSRElwcVhSRnlvVDgxVFZGV0QwcTBIdmp6OEVCU2N0?=
 =?utf-8?B?YVNaM1lkdXRlSGg0SzFpdGMzcmllN0NNcmRVMkZteXpQTXdiYk5VTHdDZXYy?=
 =?utf-8?B?STBoUm96S2djSWdRbDhJTlFmNHphUFM3aUpOdldZd082OEF1MDlJUjBkckZi?=
 =?utf-8?B?cVNKNk56TFRSMGc2Mnh4QytBMStMRWJkUDNMNXVWTmRIRjVFNkxoK2JiVzBW?=
 =?utf-8?B?RU1NdGV0cWZ5bFRHRkdydkxUZ1JCZ25UczlIN2pwbjV2bHZRWkdmdktvZWEx?=
 =?utf-8?B?ZjJXRWlGMVV6TmV2bHo2SXlISUExdncxU1lpWXZnVGlORXczazhWay95aURK?=
 =?utf-8?B?UTZHSFFVZFhVSUx4MFBaNWVJVElLS1J3RGZRdkZIeTU4c0Z4Q3NQeUx6NXpw?=
 =?utf-8?B?MnY4Y3hBbm0rTGZCT1RKcU15ZGt3QVZvMjl0TmpNM1p4RzhHN2NkZ3I3VmFw?=
 =?utf-8?B?aHg1L1UyTnk2YXphdjA1V2pZY0dJQkdpZTdrM0QzSUoxditueEttZ3ArR1V4?=
 =?utf-8?B?dG5iN21VQW11YTc0VzVxZXAwdFU4YmNoZE1saUVad2l3dlRnM1ZxY21HSXo1?=
 =?utf-8?B?ejNrK1BPWmpJTUJ2NktKUlRpWlkzVXJqVkpwWnI4R3J4WmJtUmVsY1d6WHF3?=
 =?utf-8?B?bFZ5QUlmSThMZDRPZUhNcGMxbG40U21RRlFZbm02YWREN3lOSWh5V2Q4dVVK?=
 =?utf-8?B?cU01QW1PekVldmozVkx1ODVHOWNjRU5kdFZCRjNkRFUzeVRjeExNR3RCdTh4?=
 =?utf-8?B?alNmanFuMkpvS3RpMXIvamlhNDQydGZtMkRXSC80b1VzbWNQVzdMM2k4N2g0?=
 =?utf-8?B?MXF6NXFBVStvZUd0b3R0dVhXODUvQ0JZTFovL1ZNZXpLbFkyK0VpUllCLzgv?=
 =?utf-8?B?R01yd080K05KTVNBUzcvb2JSUlZVSGlNV2d4eS8wN0tQQzJWWHdLd08za2VY?=
 =?utf-8?B?NElsZmRGdklFeVVPanNjQ1U0ckVRTS9SRm9mTEtNUS9BMkExaGJqOExsTHho?=
 =?utf-8?B?Z0xXeFBFUjdvc21QclFSZkpWdW5iWENMQmplVmVOMVFVZTRnTlBHKzhBeW1S?=
 =?utf-8?B?TjFXV2N1c2hFd2xtdmpLZkhSQVNhdkt6YVNaaTlhd1JBbDN1SnV5Q0pOcGF5?=
 =?utf-8?B?dFEzY1JSc1g5YlJ0V3ZuUWtHeVNNaUJEWStzUE5yWGhQWUhpSXRtR2Y2cU8y?=
 =?utf-8?B?RzE2dGV2Q3A4YW1pTktOZE5ycGpRdzJUR3JPbUZsSE51ckJYR1YzSG4yaldC?=
 =?utf-8?B?WmJFSkNQZkYwaHpRWHVseXh4TFhENCtNOTgzTjB6cmtKeng3SjBQYUZqazhF?=
 =?utf-8?B?N251T0pRaUxCRlpQTlluVTBzTEFHay8zcTREM2JncDNvMXJwSVZpRlVyVlZ1?=
 =?utf-8?B?ME9EN0J4WTVSbVd5azQ2TjRFMFRPNkZCUVBUUlNsQVpkNjczQjViQmZrVmJT?=
 =?utf-8?B?SzUzMU5CUEY5WmhTWWVYQkxJVytBcmJhenhSTWdzLy92emJSM09tZVJQRG9w?=
 =?utf-8?B?RFNzem5McHdIQXg1bkFMbEpaVmJLdEJDNFJCWWhIOXdCbGVkZWVQUVhmVEhV?=
 =?utf-8?B?Y3JLcmhMd1pDVGFQMlNVdDNRbTk5WDlJdEYrenpWVmR0VStPSmtPV3hmRENG?=
 =?utf-8?B?TERHVGVaajdLbEsxMi81RERmTlo2Wi9Da3NIOE1yaTV6ckNETzFheWNFcHRv?=
 =?utf-8?B?VGxoRjBiTCtEcndNVDhNd3VjUENjdHdFM09wOUl2LytQTzVtM25RL3AycS9L?=
 =?utf-8?B?TWZlWERTckRPSXl1THAzYnk3SW5rZFJQWnJpT01KamxGakkrUjRwSmhWcytO?=
 =?utf-8?B?ZUR4UHlUZHA2RUcwVzYwTXB0ajBXZU9hdHJlTGtxWjBkZ2hrT0tMa2F5Q3ZG?=
 =?utf-8?Q?JOKDqfIPuviM+IDAIfnWrV++m?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dfdbc4-4bfb-4fcf-8465-08dc129ab107
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 11:44:38.5463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXb0vXMdAHhrcvfyq2P318CxipMORUsu+GXnYg5r7nRixCE48zDAISCwGcv72I3UTfFI2eu2Sl3MSJ+zjckWeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEVP281MB3657
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28112.006
X-TMASE-Result: 10--25.826000-4.000000
X-TMASE-MatchedRID: UuaOI1zLN1j5ETspAEX/ngw4DIWv1jSVpolXqDXvwwqZs9QmGT9XcN2i
	oI/MuJyoe3qllbVoTcZHIl8sSqoAmIb7sNElOtOGNt1u5IC9WguB1fO2o4QGcEEwlAH/Plee3nf
	Qbxqtt9PVIfmlvz8dLAisYX46CfK1dcaBsQNmVY5bLHSUK6sTGj2mQ0s3MlemOEwvJg+UGW+NUU
	vJRzqryH6W5Fs9kdeVoaaMpBykL+nRueOV2LpTkjvQG0xdFpDCwi2wjrD5qdriQNujOS3w9Tw+m
	U5jMmC802KBr1q9iAUTok6l8fT8/iqtMzuyUegXlEJO70qtU7ZyfGzN/EfYKSbHySXVad36r54J
	Ix46I6SuVcUZFgzFcBAOLNGeu33djhOS8CxcKzSiWLhmiI4dPyDilljGyWFtDjSolFn3I1sD/dH
	yT/Xh7Q==
X-TMASE-XGENCLOUD: 0995fa0a-015b-4817-9c90-6b7d853e1377-0-0-200-0
X-TM-Deliver-Signature: AE5B9A0143C6E2F75F4DB4CF57114281
X-TM-Addin-Auth: jUY6B21Bi+jBxzAhJiSYMfDLf+LiN3Xn3EjWVJv7x/9OzwjJ5LNnXn5BWeY
	TazQvZE0L6FW4HmfRrLBvYU5m89+F36/hzaXogpdy980XxXh6q0OaE6YScgtRO+JEnHHz7BXdix
	LgeceCRUR7r7N6N5AfLEgQm6FSyeEnfxAN8e7OixqPnXE7vosheag596LHFI3SSpLQMh+DPXVjz
	JQRSsrIZrG9VzfR9D3Dc8GRDDuShivTJFy6y638m4oW9MVHT1dmqjC1Eia4Vw0fAzfyFiV5YsPf
	Dcm/rGGzi4sQuEM=.WamcgbNrPC5DGCwSiYZSi0W28+qJcGfvwl6JMiWY6KjwMLyPVeF5yu3ohH
	2U2EWyz3+Z7h8Ii+izabDhA5kcTaEor5Yk9D1htv5sJNHY0Dk8Hu37ZL0ErQpj2Q1F5DEBgebp3
	MkofUcnPrVJIBCSsPwIhPfXumTBacQ0O3DYWNcDPDspEeSVM/ysbn5yGfEJgLrK2j9yAOFaeQs8
	fKAmJl8YnBfRKFxfTdCtljZw8MhOPwgcXvw2BZGT4WDd844oC5fohKbcxAP/wmM7cCMY8wuC8Go
	EeNXS6ENKW2RTMXAWDiRZgJYT/ps/+9oqkHQLI8neq8EhH12tgkIhUp2M1Q==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1704973481;
	bh=7bFzMJalSZSQKxH19bZgMTwWoxc45HrxuYqapnc0BoQ=; l=2018;
	h=Date:From:To;
	b=M+tZzUZn3dGjimkz5q3m51RI1yv9fhdzi9oYOzbEaA8hwSK2Zh/mK0azGlolaLPJ7
	 0rbDFb315lhqLYHeaqPe55vqKLquVuM6txivvHjvYo9+k35nX9IAcqJ0Iy7UBZ/aK6
	 nWR45hJKgtPCoQxQHWcXu6BBZTKoiYaMveKw8rycguuzqDYxmSNKNp7ePlcfUEJ+TQ
	 nTkhiOj1GCKH4Ek1cL35/LUq9z9ioduKM9cQlC2ZgjDFLzVb2Kzmdwzd6bzpI9VRzc
	 lCW3lfdc4/O+zbJ6/29KLEEA5VPKDYCO93ri3kgtVkU7nD+aSO1Do5j6s5p3sTohsj
	 gpbdbwb3rgbbg==

On 09.01.24 07:31, D, Lakshmi Sowjanya wrote:
> 
> 
>> -----Original Message-----
>> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Sent: Saturday, January 6, 2024 8:50 PM
>> To: D, Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>
>> Cc: tglx@linutronix.de; jstultz@google.com; giometti@enneenne.com;
>> corbet@lwn.net; linux-kernel@vger.kernel.org; x86@kernel.org;
>> netdev@vger.kernel.org; linux-doc@vger.kernel.org; intel-wired-
>> lan@lists.osuosl.org; Dong, Eddie <eddie.dong@intel.com>; Hall, Christopher S
>> <christopher.s.hall@intel.com>; Brandeburg, Jesse
>> <jesse.brandeburg@intel.com>; davem@davemloft.net;
>> alexandre.torgue@foss.st.com; joabreu@synopsys.com;
>> mcoquelin.stm32@gmail.com; perex@perex.cz; linux-sound@vger.kernel.org;
>> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; N, Pandith
>> <pandith.n@intel.com>; Sangannavar, Mallikarjunappa
>> <mallikarjunappa.sangannavar@intel.com>; T R, Thejesh Reddy
>> <thejesh.reddy.t.r@intel.com>
>> Subject: Re: [RFC PATCH v3 00/11] Add support for Intel PPS Generator
>>
[...]
>> At some point you should announce v1 of the series. RFC is usually being
>> neglected by many (busy) maintainers.
> 
> This patch series is dependent on https://lore.kernel.org/netdev/20231215220612.173603-2-peter.hilber@opensynergy.com/T/ which is RFC.

So I understand my dependency series being RFC prevents the PPS series from
dropping the RFC tag (correct me if I am wrong).

I plan to send out a non-RFC version of the dependency series next. So far
I think there will only be polishing changes. Due to testing being some
effort, I wanted to test and send it together with some other series.

But if this is blocking the PPS series, I think I could send out a non-RFC
version of the dependency series earlier (by the end of January?). Please
let me know what would align with the PPS series timeline.

Regards,

Peter

> 
> Regards,
> Sowjanya
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
>

