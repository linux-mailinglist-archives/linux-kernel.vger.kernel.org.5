Return-Path: <linux-kernel+bounces-48738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433E184607C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55D728D7CA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB26784FB8;
	Thu,  1 Feb 2024 18:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="FpTt98YJ"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92A682C88
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813880; cv=fail; b=imcS6+H36cmUf3f2O8dOiGxgg0SqrUPr09Ju8nNeMMKNT0XmHk0b2jsVrG1qWQX94pmBi+TPxUzlaR3/evVoUX4NBtZmvdxn2qH6+w8/l0hD02U0E0He79DHv3D58mURQbzSTT3XhJophiYPD5Ddgz0kyWxM5jSGQmvXcrffa0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813880; c=relaxed/simple;
	bh=NvZCVdlBjooETymEjP5dwWcbxl1lFmbHfAodrQ+uXtM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mo4iKNNg49xYzd9ONvndxGqZmMIYU/VttfFKbr5/xk5oJy/fP1ZLp9dT2YLq5m5ntX7895UmjHzU6k5k1ElkBrVxO/iB+V3idjxbS6rVuKsGf5Oyox62RPCCT1LCX/xBpSb00c0iGehEEK/Iem4asRCkgk3wGPP9YGuIYOTX0+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=FpTt98YJ; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.19.160])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 7E74A10D147BF;
	Thu,  1 Feb 2024 18:57:56 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.193.99])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 047EC10000D1A;
	Thu,  1 Feb 2024 18:57:49 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1706813868.322000
X-TM-MAIL-UUID: 421b226b-1217-4c65-b062-cf62a88bdf10
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 4EBB110000318;
	Thu,  1 Feb 2024 18:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPp/OBSKVSYk5q7rDw89D0HPW88NTGzqJqSoDBpYa8B/HGdIPiAoODz/NT8ki/NgA2hCkLDN2Sn6PJuI9cB3BDq2nTDhAGgFe+vF8jehtwrPO1klFShDKh8GXCIucNm7fvp2OxsoWk3PXTMsaOOGiGUWJywBjdz6as5KV6LmGjt4L4SFeCK7Zk/VQ61WfiL/+/OIs/f6A8oUAz2J/7FedwTSPlNq4mLRo1kSv6tgfW0CddxX5WMjMJsLTtUst1m1jrb6daojjUirfhpViwMtfUPCPTbr3hHnYGhX1K5s3gJWxhV4s0WIViVOiX6l1CtgtTYyF3YEcy9n6czTowMXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TreiSjs2OMzERptZ9oCUgtUY8csOB85O62YcB/aYjVI=;
 b=iWxH52mTrU/hQeWmvUVKeE1jGPIFmf2QGhGKHDo4KLNP2dCZavSR1ZEtplBQYj6J+1Wk41J9uU9fbv5/aqftO9FAGnY3PJFPyAbXPNqcTW43dSkkn9TZGkfsxED/E8VSbdoZJw3eX/7aJAs5Cg69IlWepDB0StlCb73apRQxyiF9x0wKDc68vnuVRVL5REdDaHkIRk91zrEUPXXVpawf8LY7bWu75TFfhWrC2WNTixPcIvybbjvXb6mZbLGheU96oUidYn9i4IkfMsjqYfIdH9eqoH67rHWVUq6NY204Dcwxku0xYzL1C/wcQnrmjIZpnI+yCcIZwhCsGyDDRUcSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
Date: Thu, 1 Feb 2024 19:57:45 +0100
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, virtualization@lists.linux.dev
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::7) To BEZP281MB2279.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:56::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2279:EE_|BEZP281MB2343:EE_
X-MS-Office365-Filtering-Correlation-Id: 4896b714-0591-443f-9137-08dc2357ae0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mxw5tNZakE0cWvyRt5aspxzHg7gWlvjtiizuzqzTzZE3NzMe5A3wDihFrnOJGjfsnlkQU3a674y1RXCYJSk8ox0vGC/oHQ4AU11FYMC5ONqcoWQppZxCiFsii+FZQx9J1a/5TcONO6IOdT64x4cXFJbrhnMYqiwe3EcvGrGhK2ymSXbEU4Fcv2BFCw2wWWv8kFWvHThl+aBVscdb06+tWj+ej4lkGqyqPxxsV7Gd3BCcWQHmuglyDKDZjbSqOnLFMlmKeqQskdosUevT3BhARJlNN0IJwnUHdh3ZZqwXuxW9hKntk75ghZDy8wHfSlhlBLxPp5dbNo8QPKnrN6v28BtmDikYfdpCpskiFdA5qczsBBA+r52tVFt/6bqvATF7BSGv2ZoxMBSfi22Gma+1h5xD8YMxLYUhtiDU8nD3jg9IVtoMnjiGDre7V2tmwOain0IsiZ2dkQnC/Dz6OXMyr+tcoEX8rBh3vX7quXdp5VmYVkVXXmGyhBp031Q3PLDrIeJmdU8fYeKvptE4OsEB9De8e1xkwouyKfzKRz+7jEbon8V/jxqfy8oPuVvlKOAz62bvFDSfh7iTrDFWfTyrIq59Qvq0HZsmb27JXYXUGW8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2279.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(396003)(376002)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(36756003)(41300700001)(921011)(66946007)(38100700002)(42186006)(86362001)(66556008)(66476007)(316002)(110136005)(31696002)(2616005)(26005)(53546011)(478600001)(83380400001)(5660300002)(44832011)(8676002)(31686004)(7416002)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFVRRExZcWVBUDZMT3VjTDBRSFE4WklNak1pQU41YzA1NnJ4QStFVStKZzVG?=
 =?utf-8?B?bjBMZGNaZExvQkZUTE5hOEJyNWlReWtkSHNqdUt4RC9UTmJ5UjB0cS9WWTgz?=
 =?utf-8?B?WGx1MWVqOUhOS1dmNFBYYWo5dGY5dlFSUWZLckdKN2svMXowYTNZeGViN1hN?=
 =?utf-8?B?bFJMYTRYYkFlcnp6MWVWRStQK0ptTGVPZ2RteWtWZHVCSkRJT3pGN1hRYThZ?=
 =?utf-8?B?L0grNm0vNHVBL2lOQmp1WFVYQThKVmtiT2U3MkNHMGVtVTRodGtlRHRxa3Jr?=
 =?utf-8?B?T1Y5ZDRKTUFhUWlSSmlmWkxnSUZobzU4SG0xY25pc09MYlNXbGkyOTFQZzl5?=
 =?utf-8?B?cTY1VXU3NDVqUitqTjdNL0R4eU5RSkZ3Tld0a1EwbmJwZURwZHVzcXpDcE9O?=
 =?utf-8?B?QThDNWxmNlZtTzR4Mlk3QnRydDFWWGdzUHhzMnVneXBrVXlWUFl2UEhuTXVR?=
 =?utf-8?B?NHVTbG8vRU4vN1ZzNmU1NFhSNjNXWFcrcExScGZLR0JIVHhWS1JkWDlOM3lC?=
 =?utf-8?B?TmgzRlR0cmJ3NGFHM0hKeFVITVVvbW12ZnUzMkZCYkYxcHl2YS92bDVoNFBR?=
 =?utf-8?B?dlZNYnhBb3ZNQ3VYMVZ6SWRDS1VGTlRDUUczYVpXN1ZoVW44SnZOSzR3M1RM?=
 =?utf-8?B?TTZjeVFjM1ZkTEJ6amY5aDNPdERESWJEWXhUOHZQNG04TU53bHJrNHlja3lE?=
 =?utf-8?B?YzA1UGhxU2xWWTF6cTJBUlR0YkF1WGYvdjlhd2pURFh4V3pXeUNXbUdPM1Z3?=
 =?utf-8?B?SC81dkY3TnlMK1Yxb3BNWUMzNnlyWk9ZSmVacms0ZWxMRTlSU0M5MzFqbzZT?=
 =?utf-8?B?Sis0anBCSm1pR2U2VlpZWFllZlBMbEF2THc1aTRKNUdydUwwZGRIMmhkaGZm?=
 =?utf-8?B?RjRGRUtpb3FVVHpKQ0xMUDdvN2VOeXRvNDVSOVJHV2l4STZLdmRWTjgyNlpG?=
 =?utf-8?B?cUVtUlZNWWk2bDZtWGxQN2o1OVNNN1V3TVdhL2xCalM1U1FibmlseDNYRzhK?=
 =?utf-8?B?RFptUG5XQlFzdTcrY09BOCtuaTRZN3NKQ05mVWNKR3c0TytEQmw3SmtiK1R3?=
 =?utf-8?B?Q0llZzNNalZTQjdpRFF0V05LeGtKZHFSSVZUeXhETHBGM1A5STZYV0FQdC82?=
 =?utf-8?B?cENhMW1GaWM1M0J2a2FhcFBmRE14YlJYZ2JkRWFDNDZrMDRSWG9nVUZjRi9y?=
 =?utf-8?B?cVRGWGc1N1FhSU1yaFVxNHBUL3RXU0pTOVRMUmVVMjBRMTFPZEY0MDM2ajU5?=
 =?utf-8?B?aTFzZ0FHUEpDMTM2WmVYRkNNTVJ2dUE0Mzd0RENpWFlsZ0hOVkFFc3lwUmlS?=
 =?utf-8?B?Q1lhR3h2VlFyZVVxZU1SSEpYWDBGWDVBaDF6THlSdUs0UXV0UE9LdFE5WFJZ?=
 =?utf-8?B?SzZuMnRGSXJqREY1Lzc4bDdQM3B1YWdBZFp6UWZCaE5zVXpyZ2ZiVWFmS0da?=
 =?utf-8?B?K2paSXd3NDY4OEkwTzJPUVpKZmxxMG5GQ05hQis2R3RJUFRXM0pmSnhpTmgv?=
 =?utf-8?B?YW5kMnMxQjdvMTRIdWZlRlVoRDRSS04wK2FQc2VUc3U2MGFUSDF2M1RrMVU5?=
 =?utf-8?B?TVdtNG9ySjRkRVkzTDV5UGlvYmZ6eWJOQWlkVHBKSzVWc29hanl1RUcxNTdL?=
 =?utf-8?B?ckk5RlBOQi9PUGhHbjhqWWhFVnVxR3BrMkJ1RjRxY21hcWhUSTFrYzhVbDU0?=
 =?utf-8?B?VlNKTTY4dlp4dGhtQm4wd0w2cXdtbEN5WXJrZVUwbGV0ODVGL3FZQU5xUVlK?=
 =?utf-8?B?b0g3OTJGNkhIbHNwSUNzOUJRU25IYlJ5WEtpTG5RUnppczhGUm1xUHh4dGhE?=
 =?utf-8?B?STRpV05jN2VOZkFYVVF4YXZzRWdnd2s1LzVxcXRlVndybWdzTTBPNzJvVjBO?=
 =?utf-8?B?bWNKSlZBbFR0djFYOVFnamZ2cnd1OUdmSi9zMWUxbm81RzZEMjlwa240SGl3?=
 =?utf-8?B?Z1hLUHBiWDlnT3YrcnVXRW5BRHFtdlVqZGpTckFYbG9yem9oU0tVWDZvQnRm?=
 =?utf-8?B?OHYrc0I1TWp1UHhUbnErLzA5UFZaOHhITmhzalRCOXQ1cnJvcWRpZ2IzM3Z2?=
 =?utf-8?B?MWh5NmZxbmtsSjVaaExKWnhGQXFPUGgxdkp2Zm1CM2FpcmJ3c1htVGRDVUVT?=
 =?utf-8?Q?ihFXTX7gWGp2hPbbteawBCfDI?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4896b714-0591-443f-9137-08dc2357ae0e
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2279.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 18:57:47.0024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2p1N4jtRwYjRZKdoihYc83eyXqeQJn91xZMF5Vz/1IfthCwaFUqdU+pSoNehWj3fRF2BrXzqnZ3cUImHVM7Vpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2343
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28158.001
X-TMASE-Result: 10--20.387600-4.000000
X-TMASE-MatchedRID: UuaOI1zLN1j7aDO4CTTXAUu+LBodhvWx3B1hSgpgA3NLbD6MAjV/HXkS
	2NLbu9vrHe/Upp/4ecR55GhBiSRnqdLnVLHHb0BJJ96EZQbLI1wnfL6KqKSjb7AFnlFVORaFHzZ
	m1Hzj3+G2Jx4NJM8XQj0PPrfB1Bh4PNrwgyWv0FiFhGp9GNPDremlj3mhNSlqjuOgrRhTc4Aovn
	Wk0W+Kc5wF9/WUecaz/goanha5wsKVUfMM1YjB30kXVQaP16N5AJ4bT6ig74ci1tnHAtK8I+TWQ
	MB+YaBlLqQeOQ4Yktfi8HzKNwucr8imVA71DJInuva7QpapAo3j08NQZZ6WgbDKT8rFLjFMW/1Y
	AH/fjRTfXDU2ciEUMsKjGRQnQ81hjWDfMO3Wy/k0UkwbRDtAu1xQCEUiIhCicYO7LzLWqS4D/dH
	yT/Xh7Q==
X-TMASE-XGENCLOUD: 6a90687c-9de7-4693-b320-4061278f29e6-0-0-200-0
X-TM-Deliver-Signature: EB7D5A088DDC6AE0F39EE35575067D4B
X-TM-Addin-Auth: PhzsgAzHGC0aLkhDNMKp7S9baJwBQqI2AXgWIqhHN5vMhjIJ89CJSi7axkl
	hMfZkidWRo+Kch2P/UjXzC7CARNhRqZbKVz64DPCNUPqASvL63Hj5D5IJmTo39GwiHVHS/maEL9
	RZNJ26NKFIGGrGrNg0ANrq9T8p3lFJMhDhwvMVdC2zwfx8DyP6sKyJZkK5+3wqeWCLI2ks5hlh8
	Ww9a+3kw41muMUMpL3diRF7MBKmqIUzv0MSSZgj4hEUyycdxZ93lXkdCYZMWnmMioL280w0dTkQ
	IzvhKOwEk9Fqrk0=.Roo4zbJplWNWZ09rQRHFs0UmDpwD4iIqY+1C+ZXrw2ozIT2XcpkTM8rDu9
	DFDMmc6BX6kWfnz7i6mlpZCzKCwXBJyqFRLWGsW703NxzC6IU20iy3TNAuFejoXiI0UXu/+ctyV
	9650UdwfahYsP0gPmGjy/YuEIGbqdKhEdF1OXqNf2+kYtdifHK3Y6f8HSoGGWvImJKNpZYGeEj6
	k7WVHmtSllxefODMbLeY3JqnfpJR/MkbTqJB6/u7aSK7r6DFGP+4LFhDUKBENmX3bVmdLWQjsh3
	AQPMJS5SpiEhMs3aF50TVE+d3r4RguvZ/vptTDzTgCZcB82EhuUhpe29VVQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1706813868;
	bh=NvZCVdlBjooETymEjP5dwWcbxl1lFmbHfAodrQ+uXtM=; l=3745;
	h=Date:To:From;
	b=FpTt98YJa9vWjxpqzvqfILqW4TwH958qOn+/1hkusgvua7U8mFuAt4FsWZ6zL3tQ/
	 9LyLvlFT4pt80c+dk6UJJ0sk8hkMLT8XLyXQWSHhO60+noS4oBVjUYx/lOnz7Opr3C
	 boX1fyYC7EhYFXdH2FFsN1sPA3KMiyDQEYSQx7OF7LC02yRgo98F6FdmQUuEeMa/gV
	 zl8/Xy4DuqimHns41tbNm/K5KBhb9RDRJ77X11X8fHuA6tdlGDeoPxa6bqRPvmf3dQ
	 RTm3yoUHB7xIRzaEUL3d4jyYeM5RLDYYPctJUyPVM7boxke/Ya+pXHcX6zHbs6dpeF
	 B7BmKmQkH4Qjw==

Hello,

I thought there would be some more comments coming and I could address 
everything in one chunk. Not the case, besides your comments silence.

On 08.01.24 20:34, Christophe JAILLET wrote:
>
> Hi,
> a few nits below, should there be a v6.
>

I'm sure there will be but not so soon. Probably after acceptance of the 
virtio CAN specification or after change requests to the specification 
are received and the driver has to be adapted to an updated draft.


>
>> +static int virtio_can_alloc_tx_idx(struct virtio_can_priv *priv)
>> +{
>> +    int tx_idx;
>> +
>> +    tx_idx = ida_alloc_range(&priv->tx_putidx_ida, 0,
>> +                 priv->can.echo_skb_max - 1, GFP_KERNEL);
>> +    if (tx_idx >= 0)
>> +        atomic_add(1, &priv->tx_inflight);
>
> atomic_inc() ?


Yes, will be done, already in my local code base.


>
>> +
>> +    return tx_idx;
>> +}
>> +
>> +static void virtio_can_free_tx_idx(struct virtio_can_priv *priv,
>> +                   unsigned int idx)
>> +{
>> +    ida_free(&priv->tx_putidx_ida, idx);
>> +    atomic_sub(1, &priv->tx_inflight);
>
> atomic_dec() ?


See above.


>
>> +}
>
> ...
>
>> +static int virtio_can_probe(struct virtio_device *vdev)
>> +{
>> +    struct virtio_can_priv *priv;
>> +    struct net_device *dev;
>> +    int err;
>> +
>> +    dev = alloc_candev(sizeof(struct virtio_can_priv),
>> +               VIRTIO_CAN_ECHO_SKB_MAX);
>> +    if (!dev)
>> +        return -ENOMEM;
>> +
>> +    priv = netdev_priv(dev);
>> +
>> +    ida_init(&priv->tx_putidx_ida);
>> +
>> +    netif_napi_add(dev, &priv->napi, virtio_can_rx_poll);
>> +    netif_napi_add(dev, &priv->napi_tx, virtio_can_tx_poll);
>> +
>> +    SET_NETDEV_DEV(dev, &vdev->dev);
>> +
>> +    priv->dev = dev;
>> +    priv->vdev = vdev;
>> +    vdev->priv = priv;
>> +
>> +    priv->can.do_set_mode = virtio_can_set_mode;
>> +    /* Set Virtio CAN supported operations */
>> +    priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
>> +    if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD)) {
>> +        err = can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD);
>> +        if (err != 0)
>> +            goto on_failure;
>> +    }
>> +
>> +    /* Initialize virtqueues */
>> +    err = virtio_can_find_vqs(priv);
>> +    if (err != 0)
>> +        goto on_failure;
>> +
>> +    INIT_LIST_HEAD(&priv->tx_list);
>> +
>> +    spin_lock_init(&priv->tx_lock);
>> +    mutex_init(&priv->ctrl_lock);
>> +
>> +    init_completion(&priv->ctrl_done);
>> +
>> +    virtio_can_populate_vqs(vdev);
>> +
>> +    register_virtio_can_dev(dev);
>
> Check for error?


     err = register_virtio_can_dev(dev);
     if (err) {
         virtio_can_del_vq(vdev);
         dev_err(&vdev->dev, "Couldn't register candev (err=%d)\n", err);
         goto on_failure;
     }


>
> CJ
>
>> +
>> +    napi_enable(&priv->napi);
>> +    napi_enable(&priv->napi_tx);
>> +
>> +    /* Request device going live */
>> +    virtio_device_ready(vdev); /* Optionally done by 
>> virtio_dev_probe() */


The virtio_device_ready() will also be removed. The caller will make the 
device live anyway after return. There are no operations between the 
virtio_device_ready() and the return 0 which make it necessary to have 
the device live early before the return.


>> +
>> +    return 0;
>> +
>> +on_failure:
>> +    virtio_can_free_candev(dev);
>> +    return err;
>> +}
>
> ...
>


