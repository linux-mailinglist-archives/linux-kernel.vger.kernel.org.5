Return-Path: <linux-kernel+bounces-63204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 998E4852C4B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 002D3B24325
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAE2225AF;
	Tue, 13 Feb 2024 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Y0tEdmlZ";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OOKs5vNW"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFBD225AD;
	Tue, 13 Feb 2024 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816714; cv=fail; b=Wczr03GL05vErQ1jSCBDFSLMvQtKvuIwR4P3jYj/3Yv5b4nvoCVjoqUE70mBN1KwCOId1+FaRyO0Zr0N89xXa4fPzpou4UZjm6eVXm6XRnL0Y6HloNnKgqgwUngsWyglkgOGTMefh1zbBzoO/+H2PCXgz2s4iW+esgkjVBhVBZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816714; c=relaxed/simple;
	bh=dTBMPCDXKSjMtOY2qJbX0SvpVMYKgEvW031cx5KLoag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LF1vyh5jK+3U70skZ1+rAdTYc0Kk09INSK5smSssuwj6fRwZDHjoTP/6qWTmPQiT6QtHIJ84qdp1EX+eMFp+0x4OgyqUnZDGZRfmMZfnglKFMQ9byH0xJ/aLAWFKcTf1QDlpATZAJBuyjaLgRSzzLP+Igge3PAu47TW4T9CZs2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Y0tEdmlZ; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OOKs5vNW; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707816711; x=1739352711;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dTBMPCDXKSjMtOY2qJbX0SvpVMYKgEvW031cx5KLoag=;
  b=Y0tEdmlZDmjLTUET8muN5QqL8dxb3o0gRtkf5Xt7CzHjD+R5/MhyTef8
   AE3Khuba/X7LCa7QHGxZfj3jMeqfl611uTbrkWyq5FUG1josi3aGOiryR
   WjeNrIliY0MSt40oph63I383gPzFgNmzZO1t0O+nztXhBVZDNsez4TyBU
   RwBZrobbCv+DMGU/XWKal4x4YWiQ97Nt/rSz2T2hbVcm1TW1mk2kFJwIK
   uI/CQ9B6VfZ4tTZqM7hcdkzcrbeEDjfqfROnIWc9lNO6Oa4OS0IhgDo9e
   tkN1Q5TuAxS9wiEGHnBIl4ccR+5IY5B6MoyPWqzbvLb/Vv/ROZqfpvbVh
   A==;
X-CSE-ConnectionGUID: Z6IRMuH+SOqm3vhTUv3IcA==
X-CSE-MsgGUID: PsqyPIrmQbSRSgXHgE8N7w==
X-IronPort-AV: E=Sophos;i="6.06,156,1705388400"; 
   d="scan'208";a="183424113"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 02:31:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 02:31:24 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 02:31:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDCxrE1o4gNEEwXHBRzTrqFSQdzx13X85Lu/QZnInzGtFjeG/nfG7dkpkD5vB5kFqfQa8gQoGyuO4to24eGwVqX8/4GMX/NnMukRitSenuONZMWmhwZyEEv+W7jMOjIFxaSu88W1gMfhwoMspjB5ZCcOss5H//x+c4oLBj2h+aNYXN8plI+QjPGh2r3Ye3XS0aoCshiL8ZqLW5QYIxDwVRrusPGvuhwEop+d4WXt5axt27olyUUsngf51tKfCCBYvMHaPpOlStk9bmRN2ZWiVBzzk/4rDF3cMJ3OXNG/uz9NbmolR3uZZM/qqlg9HaJ3tbyzc+yxvkqwUgUAnlNzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTBMPCDXKSjMtOY2qJbX0SvpVMYKgEvW031cx5KLoag=;
 b=CbTmsHm8rB5d/dkVi5geNoweJGO0pNBvnEMswObzZ+tIXqrfEiPOZRTFPbpOgGiLVYwbA4vfKnNWfQx/e7kkugAj7VDHTdBK1t2KGEWWAIRexucQBCpvuuhcwEFXeOcXt3hoTcGxy8lyzkOs5bVtu99UCxuRvMqnE7+9Y3v+UQ4C/9bXHPzO7zi6BUD9vjuHCYXaRTljG5TiDTCX04o94mv+fxgtz6PuSEfKtaAkbHrR1MBnKR/gCN/CraJqgy37202SiC4lT7nKUyd3Y1KQXrUj/FjxLz0vb14AizgKsUOVd1fcRxDGbr/1u18ec7MlujvKVrEpwAKXq3Q4hCuZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTBMPCDXKSjMtOY2qJbX0SvpVMYKgEvW031cx5KLoag=;
 b=OOKs5vNWuEArWGpuxPTlHURFJrkrs30wYUmXnNbnL9tC/4CKTLEhQVJ69Z+AmFKPQpAosJ13+gKZnmpVW6g+AsZzyCiGPHqEEKjUgIcKLwJzZbKKcvKGdPfJi/z5JHNfRbaXajqoLEIpM8JpKpRpIOzGV2Qp6fBG9eUdESHHwjpvd14VXklnnLmgvp1x+LP8a+SEVv75A0RoYXyCuKix2+1TnsCES7IXSz77+O5QKYmn02psp0Fvqt9yU1wm64kN3w7EEf4UwCvkaA4ujg+f929I4yMWaIoXFGE1aQ5gaZCqz4sVY3FzYsUdIPkpUM0xHVxC1fW8nejblxX9Sil7Kg==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by IA1PR11MB7175.namprd11.prod.outlook.com (2603:10b6:208:419::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 09:31:21 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::2747:2669:cd22:79b0]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::2747:2669:cd22:79b0%5]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 09:31:21 +0000
From: <Rengarajan.S@microchip.com>
To: <jirislaby@kernel.org>, <gregkh@linuxfoundation.org>
CC: <linux-serial@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<Kumaravel.Thiagarajan@microchip.com>, <linux-kernel@vger.kernel.org>,
	<Tharunkumar.Pasumarthi@microchip.com>
Subject: Re: [PATCH v1 tty] 8250: microchip: pci1xxxx: Add Burst mode
 transmission support in uart driver for reading from FIFO
Thread-Topic: [PATCH v1 tty] 8250: microchip: pci1xxxx: Add Burst mode
 transmission support in uart driver for reading from FIFO
Thread-Index: AQHaT3WLRumdtnKnSkmf4pJi4f+h0bD7cs6AgARh+YCAAbSOAIAAHQaAgAA99wCABjxSgA==
Date: Tue, 13 Feb 2024 09:31:21 +0000
Message-ID: <0fdcb9c4fea657b7d29c2b8fe356c544b4b50a35.camel@microchip.com>
References: <20240125100006.153342-1-rengarajan.s@microchip.com>
	 <b8325c3f-bf5b-4c55-8dce-ef395edce251@kernel.org>
	 <e7f29dd64829b597f3881abcf4da653156c1fe59.camel@microchip.com>
	 <fa17f083805e46079bfb4ed89b83d372cfe7e77c.camel@microchip.com>
	 <0c1e8d38-4b00-4738-bd05-7e36ce736681@kernel.org>
	 <2024020916-barrette-okay-60f7@gregkh>
In-Reply-To: <2024020916-barrette-okay-60f7@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|IA1PR11MB7175:EE_
x-ms-office365-filtering-correlation-id: bd610ffe-0b38-4b45-74be-08dc2c768a57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oznnadNgBOQO8OThRJuxX37tttkoOEcP9NB3k53Zhsq/On2kS8U2WJW8f0Yub0qkZUUflYBAoN/1jwtwp1rxP3PV1xTfEB27fqoy1cb3swUuRRhXBxDbvkMbpU3ahOLse2agdjzLwZeuWzb6uNiW/pbN2FROcAlIYgdLwddD0mHrv0Qc+FKyicEkW2laA4WC91yjMFFKRLQa9ApaOK4df5w6rezzhuAPkTtznVAjhwQaGE4fw1bRulduQMM7VyiD3glpS8nYo9/7cWC5weOLJWxauvtssDl+PI38z8TXv9dsDZ0DP4W8//gjtx+9PbduSbQyIrkhvmSxQVTQgZQF3hvqP+PHcJesPUdITKBFX1oTdPMslK2SI5eAvo7rauiED4LbRbNih5eWzlGIUGpt1XHh39wv46gzxZVYqisVhwyz2dieDlm0rqssGbcjZ+3VRMqdeLZwWC7T8awd82v5SAxJE8MmSDegF1ZKc2yJ7OofUU7oifh7UpuGA9bUe7H2AG1BLHO4WzaTgfaCvfiujFd6jsUb430ouY6TW4O0P5Oui4R+SzVTL3uslQ5cFyRYKkWdPX1kQ9GL/klf3kwRMk38vxFYLVmvLH9sxc02r1ZoFJUjWEpyFnwOE/wpdtWc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(230273577357003)(186009)(451199024)(64100799003)(1800799012)(110136005)(54906003)(71200400001)(316002)(5660300002)(2906002)(66476007)(66946007)(66556008)(64756008)(66446008)(76116006)(86362001)(6486002)(4326008)(8676002)(8936002)(6512007)(478600001)(38070700009)(26005)(107886003)(41300700001)(36756003)(2616005)(6506007)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cCthT1NIOXhOZzlWQUxlYWRSZmNhTjRkNzk1WUxqWGVXZmhEN2ZzYjNOQjZw?=
 =?utf-8?B?T2t6TytMMXpEaUx6UXAwWmpaTDArUlNXVk94TkFjRmJJc1FlR1FLSGMwT015?=
 =?utf-8?B?amVDQVN4MjVWdTFkdXh5eS91dGpCUWpFVEtsalV0L0lyMldhbVMwcGxQaDVH?=
 =?utf-8?B?RGlKVnozZEt4MmZWb0h3L1ViTlRWamYzS0kvaEpqSE0wMXBJWUR5eHNwR2JW?=
 =?utf-8?B?MjJ4QTQ2RHBkTTA0eGMvU3I0NXRQaStpZjMzc25ybEJ4WXBaQktFZG5mMVQ3?=
 =?utf-8?B?RnNNRGRhZ2tHelV1TVluNzVmK2p6OGFNdUlnOUUvOW92akV4U3k0bHQvNzhL?=
 =?utf-8?B?RW44cDhOVGFMQzllUG5SdjNDWTF1cDlUZHIraUdaRS9nYzVMR2xjaWhFN21E?=
 =?utf-8?B?OHJmbEwzRGpid2NHTm1iaXhIb2lLQ2lJcUloVUcvQm9KWC8wK2VZR043MlVW?=
 =?utf-8?B?RXFZeTRaUHVOUStYdWlUZjBXS0w0TmNQU0kxMHZ0WmpIQnBBS0VzdXA4VlJY?=
 =?utf-8?B?WnE1bGE3YWxaSGFpb25BN1VFcysvTHVtcUVJZE0yU3lSdXorYllDM2trdllp?=
 =?utf-8?B?WjdXVU5qRjhsa0Fkb2s5bU1CWDRPZjI3WTJIREtxSEE4eFVNb3pwTnZ0TDJv?=
 =?utf-8?B?NGlYWUIrM013RDIyOW92bng5N1BpRDU0Rlg4TWtEa3gzRWJOTm5PWWE4N1NG?=
 =?utf-8?B?VzNmQTkvS2xUelhuT1l1OW1lTW42YnJCUisxRk1ySm9iRlBSNTVZYUdySk12?=
 =?utf-8?B?KzlxSVBQclFQV2FTZERzM3hnYU93OHh4VVd2dGZDNS9aNnROeTJiYndMWk4w?=
 =?utf-8?B?WGhudDZRTUlyZWx1WWY4SGl4bHIrU0VuaytDOEtra0VndXFXZkd0WWwyY2JZ?=
 =?utf-8?B?N1Y3Nmg5M0tDcjBnSkthWG8wanZ4N01PRVBhamdid0ZLWloxc2h3YkMxaFV4?=
 =?utf-8?B?VWFVRGN1S1VEUHpXbjE0ckdvOHpiajk4bU81b25tNHlSZVR6QzIzQnk3bXVv?=
 =?utf-8?B?S0o2V3lQZ1lXTlhvMUY1RDFkWWROM0pIVXRTcUFETFIyalN2YmVybUlmZlJi?=
 =?utf-8?B?Z3dQSVJuWHdEZ0tqYjRhNXZ0WmxEQWt0eDJKaGtTQXFnWTdtditSeWdmSUFi?=
 =?utf-8?B?cDdlWWNCSlEzU3ZNai9zMEFNR1hoVDg2RWxHRTlFRmhpR3cyYnFTNkVyRWRv?=
 =?utf-8?B?S3FKLzFYeXkrZlI4WnUvbEtsR2szYUlmbmtxQUI5NGY3Z0ZCRyt2WldpZTBa?=
 =?utf-8?B?MEZldWcxTm1vRktDMFJMQXl2dGVpUFd2aXBFNHZSUjd4ZG1uakx1dUxzd1lW?=
 =?utf-8?B?UGhkWVh5c1d4TGs0QnJZVllVcDRwNEcybXZHOUYrVFk1U2RYdWswcnVmMmdD?=
 =?utf-8?B?cEJxaFRKTDc4dnlnak5NTmJ3SEMrNHVmdzR0T2dKNXdzQ1RhMHNvSlNhVEN3?=
 =?utf-8?B?UGhseENGeDFpU0wzSXF1ZnlOTmwreUJRUURQeXhMb0Jqb3MvSGpMQ0J6YWJL?=
 =?utf-8?B?UllnSHoxU2VPKzAwR21HeFdxTCtLazNJZlNyTEg0T3RIOHNXOTNVSFB1Q0FL?=
 =?utf-8?B?RGx1UTFFSHVsNHM4VDhSNE00enUyK2pGQmdLTWh0b3k0ZkFncHJnSFlWVFYr?=
 =?utf-8?B?Sk9MUW9Dc1dBYjltajd4ZW5RUzJsVU8vTFo3cTRoTDYrVHhFTFY5VTJzZEEx?=
 =?utf-8?B?ZTlMa0dBTm41QnFrSGhWTUY1ZDB2dHdyUHcvYng5WVg5ZEVvRzR6dkhFQU1t?=
 =?utf-8?B?eldCQk9WRVp0MU5CRnVocG5YeHRqa0JxYlVQYVJrVXptUU1ZYXIybWc1QVQv?=
 =?utf-8?B?b2NzUis2UnYxV2xjaTdwVlpiYXRVYXpZNHY2WjByYWRUSERaRktMdzBCOURy?=
 =?utf-8?B?ZTdqMWJUOXduMy9YbVhXdURMZHN2SVlyVjY5Z1dXdHNFM0tQVGdRcXN4NStP?=
 =?utf-8?B?RUwrLzFnTk9UdjdNbGZCYnNTa1BHZWZ2cVEyUVpaaVhKUzgyQmwxL0t3VjlN?=
 =?utf-8?B?RVFNNThuYjFTMXZkdHpuUFZwRjlDOC83TWhuYUtKWDhXa0FsMSt5TFczdFln?=
 =?utf-8?B?dEI2bElZZTJmRlR4aHdZQThucWhvOHR4dXZvWURMT0RrYVJVOE02RVNZOEh6?=
 =?utf-8?B?V2VYbkZCRkFKS25VejNmYXBGSWwvMUNsblpjU09pak5TS1RSeHhTeWhiMnRp?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <721F9CAB459B6848BEDFDA249BE8B237@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd610ffe-0b38-4b45-74be-08dc2c768a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 09:31:21.7994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f32jVfz8GqQmUWYUQYjFA20pOZN+lv1OuGaXdpaGPryV4MpzNo+2Ca0+Z4oQrrgCch7/r4iUdA4JXZWCpm8X9HUry3U9C4SjYiVUKCdOLAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7175

SGkgR3JlZywNCg0KU2luY2UsIE1vc3Qgb2YgdGhlIGNvbW1lbnRzIHdlcmUgYWxpZ25tZW50IHJl
bGF0ZWQgYW5kIG5vDQpmdW5jdGlvbmFsaXRpZXMgd2VyZSBhZmZlY3RlZCwgdGhlIGN1cnJlbnQg
cGF0Y2ggY2FuIGJlIG1lcmdlZCBpbiB0aGUNCm5leHQgd2luZG93LiBXaWxsIHNoYXJlIGFub3Ro
ZXIgcGF0Y2ggd2l0aCB0aGUgc3VnZ2VzdGVkIGluY3JlbWVudGFsDQpjaGFuZ2VzIHNob3J0bHku
IFRoYW5rcyEhDQoNCk9uIEZyaSwgMjAyNC0wMi0wOSBhdCAxMDoyMCArMDAwMCwgR3JlZyBLSCB3
cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBG
cmksIEZlYiAwOSwgMjAyNCBhdCAwNzozODo0OUFNICswMTAwLCBKaXJpIFNsYWJ5IHdyb3RlOg0K
PiA+IE9uIDA5LiAwMi4gMjQsIDU6NTIsIFJlbmdhcmFqYW4uU0BtaWNyb2NoaXAuY29twqB3cm90
ZToNCj4gPiA+IEhpIEppcmkgU2xhYnksDQo+ID4gPiANCj4gPiA+IFRoZSBwYXRjaCBoYXMgYmVl
biBhY2NlcHRlZCBhbmQgYWRkZWQgaW4gdGhlIHR0eS1naXQgdHJlZSBhbmQNCj4gPiA+IHdpbGwg
YmUNCj4gPiA+IG1lcmdlZCBkdXJpbmcgdGhlIG5leHQgbWVyZ2VkIHdpbmRvdy4gU2hvdWxkIHRo
ZSBjaGFuZ2VzIGJlIGdpdmVuDQo+ID4gPiBhcyBhDQo+ID4gPiBzZXBlcmF0ZSBpbmNyZW1lbnRh
bCBwYXRjaCBvciBzaG91bGQgd2UgcmUtc3VibWl0IHRoaXMgcGF0Y2gNCj4gPiA+IGFnYWluLg0K
PiA+IA0KPiA+IEhpLA0KPiA+IA0KPiA+IGFzIHlvdSB3cml0ZSwgeW91IGNhbm5vdCBjaGFuZ2Ug
dGhlIHBhdGNoIGFzIGl0IGlzIGFscmVhZHkgcXVldWVkLg0KPiA+IFBMZWFzZQ0KPiA+IHN1Ym1p
dCBjaGFuZ2VzIG9uIHRvcC4NCj4gDQo+IE9yLCBpZiB0aGUgb3JpZ2luYWwgaXMgc28gYmFkLCB3
ZSBjYW4gcmV2ZXJ0IHRoZW0gbm93IGFuZCB3YWl0IGZvcg0KPiBuZXcNCj4gb25lcyBsYXRlciwg
anVzdCBsZXQgbWUga25vdy4NCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQoNCg==

