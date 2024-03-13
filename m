Return-Path: <linux-kernel+bounces-102314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF39487B065
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA4A1C2170F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C4656B6C;
	Wed, 13 Mar 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="pBm/Pqcy"
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922F47A52;
	Wed, 13 Mar 2024 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352267; cv=fail; b=D6xC83r8W4RZ4ZOAX32LYNztETXptlw+QwaAdsMR2o5x7v3egX8kBk+qXnpX5tnVICZI1hiMZloAu40CQP9ZuboGOEcfQ+KpSMYxqLvPA4Vr/UEGfvojZXGFjBUcgC/wsPbQx5zS1mFyAKy2XKVsSOj2fySTPjnNP7b2oJB5DRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352267; c=relaxed/simple;
	bh=ZmtBXCbxSA2HR9TCOs6O5zv2YO9vzQckVX06YVDbUFw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gvoXQyT7hv2abHUAC6kPVs4u5u6lzVV0emdplgtiY1bnuQ+oBmEEV/Ks7aqUO6iQjxxWduQQEnwKQzQ5nh1z/9FIFc+699Xw5RoM97Vt4wyGQUHNVs2QaqZjR7JwOWxs/R1TlTGQzby/fFooPgOIHtQGWxih1+IqCMA4/Pb02tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=pBm/Pqcy; arc=fail smtp.client-ip=18.185.115.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.10.52])
	by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 7285A10235334;
	Wed, 13 Mar 2024 17:51:01 +0000 (UTC)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.192.213])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 06F3E10001747;
	Wed, 13 Mar 2024 17:50:54 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1710352252.968000
X-TM-MAIL-UUID: eed62366-b5fa-494c-aaa6-904b944f62ea
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id EC7BF1000031E;
	Wed, 13 Mar 2024 17:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1U4GWXpBEC2J3+O2TNt4Z5+5ifC4r8zFcC+0QMGaIbgYN1thRF7OE9ur6dBQv/nwEBZcanGi9GoJq7GeFFj9kH7la4A4bK30Y9MbdRG2r25WZxA2oVbwHVWODHfJEqY8PRA6AQkuL8IMcf3tiTjRggImbt7tUKKvUS+U7iTMc4Yz+4KvXN7jh42B8CnCxE4f9FbMa3XsiRI7fuLNGZLB+YQu7lH8jogyBOtzveCRbtMOz8p65TgBU9wBmwNRjDlK85e3VcqADhZMIx+AJIncwCv+xrXyA19r4yzPVnUerXF7oVd4gFffD/HNeD0MllnzvFyMomm3Xty67IAyigTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifdM/0oIYQVfbDthqXCUBrcS22xbKb0sssMaBkslkOc=;
 b=lE2c1HTHEinxNPozX8tSPzO7zF1Z5t91VdpOLF7CZFdiPNcq1agDu5k1Las6zA8cF9ypSse4uGd7phb6/Oq5BzxgobPFX8CIspCCc7BUrvDpi1nFboCswNU1gQ/U+IrwcIR0WsglAN3YuzOeBJEHZUgXmfeZLAzEjvKe67EresVT0X2IaHte3VwAa4gvhGWxy0pLU8eOoGdQW2NaOoKC1ZojIFgsOu0qF8x9W/Fw39KgZ5Tm6rIYZy9sETQaiZQVE0OJsu514/wuT35io4Jo1Yrid6jMyLlZo4rjxOONotkadrilRJPoRi4ZyLX11Pm2jPEE3+h7EOeHW/nB6hGVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <60607bcc-93c5-4a6f-832d-ea4dbd81178e@opensynergy.com>
Date: Wed, 13 Mar 2024 18:50:48 +0100
Subject: Re: [RFC PATCH v3 0/7] Add virtio_rtc module and related changes
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, virtio-dev@lists.oasis-open.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Cc: "Christopher S. Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "Ridoux, Julien" <ridouxj@amazon.com>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
 <0e21e3e2be26acd70b5575b9932b3a911c9fe721.camel@infradead.org>
 <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com>
 <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org>
 <f6940954-334a-458b-af32-f03d8efbe607@opensynergy.com>
 <57704b2658e643fce30468dffd8c1477607f59fb.camel@infradead.org>
 <d796d9a5-8eda-4528-a6d8-1c4eba24aa1e@opensynergy.com>
 <47bf0757de3268c420d2cd3bbffaf5897b67b661.camel@infradead.org>
From: Peter Hilber <peter.hilber@opensynergy.com>
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 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
In-Reply-To: <47bf0757de3268c420d2cd3bbffaf5897b67b661.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::6) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|FR5P281MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 986d1bb2-03d4-41cb-eb43-08dc43861f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n2HcWXxn7fx9rU4UI+o0FW84oQZ8sDWaY/U+EfzJu2I0z9+P51/6+TPI8Fl4GixHV2YA4WVtghCYxLdhcIVj4K+FKpBoAOjH8jHFsfTdhyNMSt2cbGHk3bdOHRf9JWNrN8oS1q6w4c9Cuo6OgIEdM+1CC6jciuqQB78P27txVTxUc4m52FGMQbWR/eU1g7644eCwbkIOF9LAhc09Z/mWuyOUIpJ/zkS2OYkjlFkMq0Zm60W/Y6TJYzAOPH23Yk+TjMG6T5xdh1mLjTPSOXo0lk7AhrKkN/Do4h+W/wLFwZDfqA98gm83QDzvJYLFEpEj0o9hVv7e0KMeGHIna9Pa8S0EjKOdDY4uV/KIC+2zTOsc31OZ4N4lkVNiTGUgNFWTvK/brzs1QIdMX3f9yLAJFFQ2CNye3EEGrNnoI+GnSOmf08KBrf3+Wi5CLiLHhR+7Q2AWN2RJn8svsZyOE5EAQIg99a74CFDE3IYSCwoe3yy3ySPUmhFDEiFDKEctYwpqkS4S8H+5mWwhPPD6mMfldcDZ9o+NFLKhKvprQ1d7hgvsgow1vdMFWE7SGSYL6+hRTr5dD+lFLpwfidCIT4fI/Rq8XIi6Cm/M5Ntq5yvnFRM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejlSQ2ZnalF0aDB4cmNjREdmY3NwcUpKL2hxRHVHczcrSFF4UkhZdWxLL2M1?=
 =?utf-8?B?QmpMbnlEOXlsNEZIb0E5cFZkU0JuTFZreFBWV2FqTTNiNDJyTFAxQTBTYnNr?=
 =?utf-8?B?ZlJOcU1WSisvUnpCUmZJSDE0MHdKc3NEMzdwY3VEUjJ2WXZjQzgvb2YreWRq?=
 =?utf-8?B?L04ybWhjNit0dEVXd1ZBMHlBK2h2bXNPcVRaWDdpUkVnVGJ6LzVVYlBWVitB?=
 =?utf-8?B?amJEOU8rUFJZRTEwWmh4REtOYkcwMXlGcnAvYUR6TEt6VG5tZFFlN1U2WVdM?=
 =?utf-8?B?QnkxaVVqc0J1VTJWQ0xCTFk3eTFOVDBSRVNwMUVwZlZXbDRJcnRPT3BPZUdP?=
 =?utf-8?B?RzVJc0xzanQzWU85WlZjTy9kamR3c0dOTVg0VUdWTmtKcWg0M0JwUFJkQjhw?=
 =?utf-8?B?RVNhSTMrYkU0RUdmMEtCZkQyRlZhbFI0dmNQRXFpVmVKQmhwUk1yc0doZEVL?=
 =?utf-8?B?TzFaMitqekVTY3VwNUNQLzVHeFZuUDdJeDE4K2V6WnZvT2dpWjN0cVduZkRD?=
 =?utf-8?B?ZEJPZ0Y2WW0yNHJZS1BWWUN4MmQ1RFJjZ0NKbS9ncFc1TGN1REIrQVkzMldE?=
 =?utf-8?B?M0FjUFdjaFhMWjByWFZBcFpxdGxDYzlDZTc3OFBPZ1NzZzFFZGpYS0JCdE82?=
 =?utf-8?B?M0ZzOHo3Q1Jyb0VzcnI0Z085ZEpHUnhjYnQxT2hKbjVpaFl0a1YzV3hFMC8x?=
 =?utf-8?B?TFoyRHVZbXhRd0ZUTWtmYTdwMG9NWGJ4Q1R2K2twQTJlVlVwNG5xS0tiT0tD?=
 =?utf-8?B?QVJ0b21xNTZ6QTFFQkNDdWtiOEh1Y3grSmFSUEhuOU1wTW5kOFpLOWJWeWtp?=
 =?utf-8?B?N0NEWmVwMHlkU0tjOEd1djVJM2JaTWNtb3FFM1VyVkJYbFZoaGZmQ2VnOWp5?=
 =?utf-8?B?cGdpb1dsaVVxem5oeWptS2NZRlJFUXU1bU9CWjBuWldaM2hkUkZISXdBYXFP?=
 =?utf-8?B?WnQ1SUdKYWJ0VDBqVVJSVUMreTRlS285UkRYQnl0dXFSUERvVVIweldEajhy?=
 =?utf-8?B?OGZtU2FNRHhwbzVxalNnUWJmN3VNa2tVbHdaeW05ZFhGM1I3QU55ZW5DQ3A3?=
 =?utf-8?B?eXlsWUYya05GNDFxT0QzNlBNV3dSZmYwcGdFNWFSNDV3cnljcUltc2tKZ045?=
 =?utf-8?B?T0NVTnE0bEJOOFJGandQRkZ6cW4zRHVvUGNXQXF6cEM1ZjVlQ3J4ZUhFWDJS?=
 =?utf-8?B?WlhJaGFtSVZGcURrZ2JRY1BsMXFYcUY5cDNHMVNRNzhhY1JvMXEyTm01WitV?=
 =?utf-8?B?VHc0elI2bU1mOFFnT3FPRWFYVlp1SFJhL1pnTWw3KzJjbktHTHdBcnJOMXdZ?=
 =?utf-8?B?RzN5L1B0OW1zczhsWWRpWmJ4dVhrVjVSY2hmVmFDK01HdnhaQm1YNzhKTXJL?=
 =?utf-8?B?S3lyUVdWUDg4dUl4OFpaWWVVMm1WUkl6bTBUaC80MlluZWNkejBCd2xCdnZx?=
 =?utf-8?B?T0s5WFBCVnJkMit0cURFc0YxUmZUMVZDWCt0VTk5RFBwdkI3VTk4Vmp3N1I5?=
 =?utf-8?B?U3Facnd6ODgrU241L1NjTlgwUm01OFRWQ0QvWG9GRUNIMXk0YWVmeU95MEtl?=
 =?utf-8?B?RThPbGtqRGRPdXN4TTdXUVQ1UFhSUFgwR1Q0WnlNeTV6aytsU0R1U08vV2lY?=
 =?utf-8?B?TGFSK2tBemdtNmFvemYxZXBYMnFQS0dQNWcySUx5eHRjNUJ6eUhEcW9HYUhl?=
 =?utf-8?B?RkRUVVduTmdKWWpneC8ydjV3ZmtzbWhQcFM0TFM2YW9QR2FjWk8rb0VvdUFX?=
 =?utf-8?B?UGxGZGxVSlNhV2RFNjc1Yzk0NXh5YUVwOFBMNm9HYUJwUXpQS3lHZW1sMzFP?=
 =?utf-8?B?Zlp5NFQ2SWtvZGkyWllCRUxmQTVnS25MYkdMQW1kd0tkNmFoQ3UwVjNUWi9i?=
 =?utf-8?B?WTZXbHI0cjhHaUE5ZFpqNGE3NGluZVd2RlFHcWdyOFd2OUNMZktJaVdkVW1D?=
 =?utf-8?B?WFNPbnNLL1hBSFNVWTZvMHdtYmptR05hcEFlck5tclBDQUhkRElUM2ZqTEVy?=
 =?utf-8?B?Y3V5TzhMZzVUZE8rRmxJbTlBdktXa1IxTGtjUVR1S3dMZUdxaG5UbENKSDg5?=
 =?utf-8?B?WklsK2VXalhNaXVOSmRVU0YwcFhkQlVvbWwrb05tUGJUQ1dpdWdtczl5eERh?=
 =?utf-8?B?RkRzT3pVaFFYMmllZVBuaFVmT2JGYzFmSE1HWUU0UUZwcFk3anRFbjl1akpH?=
 =?utf-8?Q?808cJAhwz+G8bnVfNQvEHo0xiBnBLQVavKimwhguVEQb?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986d1bb2-03d4-41cb-eb43-08dc43861f8f
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 17:50:51.5206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmKeOnrrb2C9Tlxxav8MX4jKclBNYURJcwdGO67ioRxavs3OCLHVSASSCK6zdDltnH5YZFW+PZd1WycCuNdRiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB4033
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28250.001
X-TMASE-Result: 10--36.231900-4.000000
X-TMASE-MatchedRID: jFqw+1pFnMz5ETspAEX/ngw4DIWv1jSVpolXqDXvwwrQXKc7SWQXhV5O
	0ZcKtJ+3ZwtVhsMoo+es13uOHE2/TJ+6mDgGLOel6x+Q+uPsJqqJnltxZVUTwMhgx7IMKlK+A57
	5Fgb9o5XCGBTHaIx6t1MoTp7f0vYrSdh0GhWtPnkQ9JMcGBx+/lIzqo1F8yQSZ/Fsy/Dmu1OLOr
	/4qeMXbkMOBMsSXDvuDLK81XvTJQNrDuWoylbl+ro2KXQsvVZSH4dNxokwGCrPxctgaqKz4SFFg
	1hSC6gbHjM937hQG5syrPZ1IMi52Om0aBkKFibTXAeS+w5YgSWTR6juYHRwGYvXantxmoFYjIMg
	84C3nGPdUhbreRF2wMmWCN8o9r3PFiY4JxbOOO+gbRFHRBZMHlt0YEdszvuKOoV8iQCgGXwPmg0
	2aADwvwosa9tvll+RGtu2AyLNVwfXYXKnv16lizqPTEE7CIv/VxlZxoe7dBaF5sLHIpSs1+7AmV
	tWDTd41K/luJYJ4Wc3bl+lYKOWM6BigdDViTQPsX4aFYAMIYOVmuhG06IIbSGQvSAIyHoOzcBB0
	bEuwyoFzfm6JG46yVnsY8qqXwUliRz4gknBIqBY1D+2ejl29Bnz+kO152KHtP+boK6EYrH0j0Hw
	Tz6xs8g564WfrYNxUsPcexNest7SYCEMZZUxHYO2sppVKEGOROuHdMXD18V711la2x2QybD8lcJ
	8FcxM9wErSH35F0aLXecWa0NBz49PSu81svLw0RneM2u5ms+Q5+XNR1q3on8vya8oLBt91H4sQE
	OG1IAf51Geh2ygkcnIJXNwrshOojFeM1oohOlCPQBD3xA/3aryV/2jRq/XEgg3cwDHl/1O85Jco
	T0w/W9dYCMo3/8LM/fFuVUUdhuiWLhmiI4dP+k/y0w7JiZo
X-TMASE-XGENCLOUD: 430dd9bf-1681-4885-bfaf-322ef8bec8b2-0-0-200-0
X-TM-Deliver-Signature: 4F7F338E99FF07BA4B398EDE53F5D6B1
X-TM-Addin-Auth: 9MwyxFgWo4JG53yoC2lPFuwIspZcsMzf2kPMdqRALTTuhyL5ggEAT0H+GSJ
	lSKpTu6SyZlTpcAZMNLeh8BJia3mQcNCChMB8RMggLQh2VuRVGzihEcVJeTLUZRW04O+zFaevzv
	cAe9k3cG+tVBxHsOII2JSqZSfUgvSHvCqwtA5pw8ARkLYv4W8V8cU+od7Ss5ZNtJ1azuiz+F5/L
	YBgh8D8ikr8+xaK+M38rnvvCWcPzFztvIPDyW9TXRJKfsx6OoNMm/THeYAQiG8TKPyThOwl/+7Q
	42+cegLB1b+KQIA=.L3XLOOqvH4eDo74Dd5JLvYgIKucO3s9g2O5BaoAQCEKQWN7ciQQuKU10r8
	vhBIvKULRzgfd7OVgqwTRq8JSdNPvVACwDTyvryRoUvrA0rbPkXi9qGPmFLlqb3dI7vVOgjP+7d
	g39BrWeZLIkdFpQAcQObFeXmH6AvVwF5I0/r2AuTXL4QC2rNNACH4FHWToOg7KzCE/r3fxlLKHW
	fHBqizDnfPC1USNgBiKnFKCp0glR42pIxvsmcuhPKhwGvc8XYlEYoQ5PIKeF99/P/61ot4cHvru
	hFj9qtfP2r1Pl0TGTmv6I73D+KfV9x8f0CmSWchozO0Ln0WS/LJWNzHdDqQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1710352253;
	bh=ZmtBXCbxSA2HR9TCOs6O5zv2YO9vzQckVX06YVDbUFw=; l=9364;
	h=Date:To:From;
	b=pBm/PqcyvWpPXKrqOCgTpLXz0HEuGsiqsYlRQ7eDAGetT22RngDIhOp3myPBUgBPK
	 jECicVya+CGueWzUFs9go4Nk7knC8aafTrSh1aS9eLdLyamFMhP5V5TSQbYDvBfTur
	 BHb4NQqNB64qlSPMovyHgf9qhuPl5XCwY9ABCK5snHGtp3/bEFpsuCVfqGxiyGzke3
	 hvmBsnxGqZGJF2gOn6PPXOe1Bi4aWUY+3h3gs74rxCfczZj66aGfp+JIj4ptGJRFLX
	 qPNup9x9b6o3ylYThaf/8mavIS6NEChmDJ+TFpUIAT+yOXofBNO+5HNXwx8fEu7Flc
	 3pyWJuoXjjGmg==

On 13.03.24 13:45, David Woodhouse wrote:
> On Wed, 2024-03-13 at 10:45 +0100, Peter Hilber wrote:
>> On 12.03.24 18:15, David Woodhouse wrote:
>>> On Mon, 2024-03-11 at 19:24 +0100, Peter Hilber wrote:
>>>> On 08.03.24 13:33, David Woodhouse wrote:
>>>>> On Fri, 2024-03-08 at 11:32 +0100, Peter Hilber wrote:
>>>>>> On 07.03.24 15:02, David Woodhouse wrote:
>>>>>>> Hm, should we allow UTC? If you tell me the time in UTC, then
>>>>>>> (sometimes) I still don't actually know what the time is, because some
>>>>>>> UTC seconds occur twice. UTC only makes sense if you provide the TAI
>>>>>>> offset, surely? Should the virtio_rtc specification make it mandatory
>>>>>>> to provide such?
>>>>>>>
>>>>>>> Otherwise you're just designing it to allow crappy hypervisors to
>>>>>>> expose incomplete information.
>>>>>>>
>>>>>>
>>>>>> Hi David,
>>>>>>
>>>>>> (adding virtio-comment@lists.oasis-open.org for spec discussion),
>>>>>>
>>>>>> thank you for your insightful comments. I think I take a broadly similar
>>>>>> view. The reason why the current spec and driver is like this is that I
>>>>>> took a pragmatic approach at first and only included features which work
>>>>>> out-of-the-box for the current Linux ecosystem.
>>>>>>
>>>>>> The current virtio_rtc features work similar to ptp_kvm, and therefore
>>>>>> can work out-of-the-box with time sync daemons such as chrony.
>>>>>>
>>>>>> As of RFC spec v3, UTC clock only is allowed. If mandating a TAI clock
>>>>>> as well, I am afraid that
>>>>>>
>>>>>> - in some (embedded) scenarios, the TAI clock may not be available
>>>>>>
>>>>>> - crappy hypervisors will pass off the UTC clock as the TAI clock.
>>>>>>
>>>>>> For the same reasons, I am also not sure about adding a *mandatory* TAI
>>>>>> offset to each readout. I don't know user-space software which would
>>>>>> leverage this already (at least not through the PTP clock interface).
>>>>>> And why would such software not go straight for the TAI clock instead?
>>>>>>
>>>>>> How about adding a requirement to the spec that the virtio-rtc device
>>>>>> SHOULD expose the TAI clock whenever it is available - would this
>>>>>> address your concerns?
>>>>>
>>>>> I think that would be too easy for implementors to miss, or decide not
>>>>> to obey. Or to get *wrong*, by exposing a TAI clock but actually
>>>>> putting UTC in it.
>>>>>
>>>>> I think I prefer to mandate the tai_offset field with the UTC clock.
>>>>> Crappy implementations will just set it to zero, but at least that
>>>>> gives a clear signal to the guests that it's *their* problem to
>>>>> resolve.
>>>>
>>>> To me there are some open questions regarding how this would work. Is there
>>>> a use case for this with the v3 clock reading methods, or would it be
>>>> enough to address this with the Virtio timekeeper?
>>>>
>>>> Looking at clock_adjtime(2), the tai_offset could be exposed, but probably
>>>> best alongside some additional information about leap seconds. I am not
>>>> aware about any user-space user. In addition, leap second smearing should
>>>> also be addressed.
>>>>
>>>
>>> Is there even a standard yet for leap-smearing? Will it be linear over
>>> 1000 seconds like UTC-SLS? Or semi-raised-cosine over 24 hours, which I
>>> think is what Google does? Meta does something different again, don't
>>> they?
>>>
>>> Exposing UTC as the only clock reference is bad enough; when leap
>>> seconds happen there's a whole second during which you don't *know*
>>> which second it is. It seems odd to me, for a precision clock to be
>>> deliberately ambiguous about what the time is!
>>
>> Just to be clear, the device can perfectly expose only a TAI reference
>> clock (or both UTC and TAI), the spec is just completely open about this,
>> as it tries to work for diverse use cases.
> 
> As long as the guest *knows* what it's getting, sure.
> 
>>>
>>> But if the virtio-rtc clock is defined as UTC and then expose something
>>> *different* in it, that's even worse. You potentially end up providing
>>> inaccurate time for a whole *day* leading up to the leap second.
>>>
>>> I think you're right that leap second smearing should be addressed. At
>>> the very least, by making it clear that the virtio-rtc clock which
>>> advertises UTC shall be used *only* for UTC, never UTC-SLS or any other
>>> yet-to-be-defined variant.
>>>
>>
>> Agreed.
>>
>>> Please make it explicit that any hypervisor which wants to advertise a
>>> smeared clock shall define a new type which specifies the precise
>>> smearing algorithm and cannot be conflated with the one you're defining
>>> here.
>>>
>>
>> I will add a requirement that the UTC clock can never have smeared/smoothed
>> leap seconds.
> 
> Thanks.
> 
>> I think that not every vendor would bother to first add a definition of a
>> smearing algorithm. Also, I think in some cases knowing the precise
>> smearing algorithm might not be important (when having the same time as the
>> hypervisor is enough and accuracy w.r.t. actual time is less important).
>>
>> So maybe I should add a VIRTIO_RTC_CLOCK_UTC_SMEARED clock type, which for
>> now could catch every UTC-like clock which smears/smoothes leap seconds,
>> where the vendor cannot be bothered to add the smearing algorithm to spec
>> and implementations.
> 
> Please $DEITY no.
> 
> Surely the whole point of this effort is to provide guests with precise
> and *unambiguous* knowledge of what the time is? 

I would say, a fundamental point of this effort is to enable such
implementations, and to detect if a device is promising to support this.

Where we might differ is as to whether the Virtio clock *for every
implementation* has to be *continuously* accurate w.r.t. a time standard,
or whether *for some implementations* it could be enough that all guests in
the local system have the same, precise local notion of time, which might
be off from the actual time standard.

Also, cf. ptp_kvm, which AFAIU doesn't address leap seconds at all...

With your described use case the UTC_SMEARED clock should of course not be
used. The UTC_SMEARED clock would get a distinct name through udev, like
/dev/ptp_virtio_utc_smeared, so the incompatibility could at least be
detected.

> 
> Using UTC is bad enough, because for a UTC timestamp in the middle of a
> leap second the guest can't know know *which* occurrence of that leap
> second it is, so it might be wrong by a second. To resolve that
> ambiguity needs a leap indicator and/or tai_offset field.

I agree that virtio-rtc should communicate this. The question is, what
exactly, and for which clock read request?

As for PTP clocks:

- It doesn't fit into the ioctl PTP_SYS_OFFSET_PRECISE2.

- The clock_adjtime(2) tai_offset and return value could be set (if
  upstream will accept this). Would this help? As discussed, user space
  would need to interpret this (and currently no dynamic POSIX clock sets
  this).

> 
> But if you allow and encourage the use of smeared time without even a
> specification of *how* it's smeared... that's even worse. You have an
> unknown inaccuracy of up to a second for whole periods of time around a
> leap second. That's surely the *antithesis* of what we're trying to do
> here? Without an actual definition of the smearing, how is a guest
> actually supposed to know what time it is?

As discussed above, I think in some use cases it is enough for the guest to
have a precise notion of time shared with the other guests.

> 
> (I suppose you could add a tai_offset_nanoseconds field? I don't know
> that I want to *encourage* that thought process...)
> 
>> As for UTC-SLS, this *could* also be added, although [1] says
>>
>>         It is inappropriate to use Internet-Drafts as reference material or
>>         to cite them other than as "work in progress."
>>
>> [1] https://datatracker.ietf.org/doc/html/draft-kuhn-leapsecond-00
>>
>>>>> One other thing to note is I think we're being very naïve about the TSC
>>>>> on x86 hosts. Theoretically, the TSC for every vCPU might run at a
>>>>> different frequency, and even if they run at the same frequency they
>>>>> might be offset from each other. I'm happy to be naïve but I think we
>>>>> should be *explicitly* so, and just say for example that it's defined
>>>>> against vCPU0 so if other vCPUs are different then all bets are off.
>>>>
>>>> ATM Virtio has no notion of vCPUs, or vCPU topology. So I wonder if you
>>>> have an opinion on how to represent this in a platform-independent way.
>>>
>>> Well, it doesn't have a notion of TSCs either; you include that by
>>> implicit reference don't you?
>>
>> I think I can add a SHOULD requirement which vaguely refers to vCPU 0, or
>> boot vCPU. But the Virtio device is not necessarily hosted by a hypervisor,
>> so the device might not even know which vCPUs there are. E.g. there is even
>> interest to make virtio-rtc work as part of the virtio-net device (which
>> might be implemented in hardware).
> 
> Sure, but those implementations aren't going to offer the TSC pairing
> at all, are they?
> 

They could offer an Intel ART pairing (some physical PTP NICs are already
doing this, look for the convert_art_to_tsc() users).

Thanks for the comments,

Peter

