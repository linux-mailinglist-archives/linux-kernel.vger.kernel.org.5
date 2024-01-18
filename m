Return-Path: <linux-kernel+bounces-29597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E36F83109E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFE11F21DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A453187E;
	Thu, 18 Jan 2024 00:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="uevk+gUf";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TjFGgrb2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="se7e2QmZ"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E09A31;
	Thu, 18 Jan 2024 00:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705538749; cv=fail; b=ntT/mfru32/iRv2053PEvRDG7Zd2Omp5BHS+W8kag1M7wvAE7fYRb6Yza+eRMNpTU45YKlch+24Eh2BLWaZCt0oyb0V9g/J4Mv3KowU7OI8I+KhA4zEZ6hHBoduv9Lp9NL3mLtmScwQ1/g2nBaqqoiVhLKcklCJfi1LNY/Via3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705538749; c=relaxed/simple;
	bh=KO5RQgy0rLhT8mQ4SNq59OvRkBGYMi/gjlA360kRn80=;
	h=Received:DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:X-SNPS-Relay:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=dhHfoMy37I/FFSdXsJl84oUNUXrNN8ZsNeO43hiUXlsBsqkqfLolQD3mIt/5hdvGhbohsk5uddzQl3RkBO+TWK5AI//AsuX7vlDxh35fniShn0ihVrymBm/Y7VoYUsYhzHYOkduntohADvY84EAIiLIE8n4BIb2vg3aoI5m0iBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=uevk+gUf; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TjFGgrb2; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=se7e2QmZ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HJ4Ekm030500;
	Wed, 17 Jan 2024 16:45:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=KO5RQgy0rLhT8mQ4SNq59OvRkBGYMi/gjlA360kRn80=; b=
	uevk+gUfEsFMuKfpBaiN0O4aCvKQZbAwLwWxJgL4CA1Ktw5oNfZ56+/3LEvcrB44
	D5XmjiXO/PFX1P6YhB297WOP6g58NQCwQLcvCrNa9S3hD6P6pomAVKsKdb/7h9tI
	ZVydtefjLoh1YOCG3/E8KAbHgAogDim7LOuNO79oHrmxvAsCXBvzly38CnKeOP7P
	3DSJKcvP/3NAmjWABXkGt2XDcbuTaNzkMAOtTLgTCoqNeQIISo0KsUVZHtIGEzE6
	Na4vq0/pr2rplk0Phvqi8O6hoa1vVDiSo9oldgoQXjsgETuKW+1Us3GxcVGZzU1K
	DziN05xoZBfzCYQA6um6xw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3vktavprc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 16:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1705538733; bh=KO5RQgy0rLhT8mQ4SNq59OvRkBGYMi/gjlA360kRn80=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=TjFGgrb2ErJr3boGB645BGZ5erIF7ZwxiWuer7qpFRDihyxMT6wA1ivVmo5+ieVZ3
	 wzJSLqntqVBviPh08OiJpYWud19KvKy20lcLrVOi48db3+1R7AeiJouAJapNQCql1+
	 kMwo2jzgAuFgcOhA6dJxI60VLr6mfqO8BqERyoObkvkM4DmP68JCaGcPgA/2w8eZ/a
	 N8HPeLE7UTb/4zoYYAPa0Wvc/dN/UMDtVrj2zt+i1JQtXUC9clFPj/Z2uXSimO3ymV
	 gAgh5t2ndbwDtY4p5IGuuuZ5eIjYaNMTuiro/xazTVJNJqjgQ06UFWYNmzyJFhllwV
	 ks3RK3P13jzHA==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3BF4340524;
	Thu, 18 Jan 2024 00:45:33 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E4A1CA0255;
	Thu, 18 Jan 2024 00:45:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=se7e2QmZ;
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4CC4F4041D;
	Thu, 18 Jan 2024 00:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiATnkOh0c02PcLf4mLHPNmEqv2B7r/fNmZKO8QPXgNvfvSdcqLm6miDTqVrxjtM4Mg/zHcHvXXuDhzNWTcwRFtyTKpBfuaWp1KJ5ExsVy4aXjV1szECJnRCZvyfoMyfRX3hiw2vxL2L0aOoUyee6vQQ+N61HVPz+UhoT/GQQ9urperhSIuI1d3yZ+PVCFmKweVG0xeKqax26bN+7tfVEvCieebebNdGdskz63LJQV1OqaPM9Vl994idOFPgAeIR/du3CATMJATzZJxsZ9zk4wWKUm7h9I9mc3BUps9VHwptjZSJuKYzfbRV/fhOYO6bbAY2dP+6JeUHB/GTKp6EqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KO5RQgy0rLhT8mQ4SNq59OvRkBGYMi/gjlA360kRn80=;
 b=FwI2UozFrhmmXYsgtJGBM/XOk4zl6O+d1byegBmmk76cVSf6LEX75x1OfYhQWNW62z6/ieGdWwXSWyXv1lXM3tYk9ylLwPghXdRg3w/OsFunySEOVw40MC4YAxas5N7N8uwsh+S7A9HAqWD1QuZJCKFEBmcDcGnxO6QeZQnuapJb+0P4AZAyQY+brELJBzn3pYf8MqKMd6XLgkPPAwGTHzFiatFzIVfqDCFcKzr6DVBM3c5w8sb/L66p/JYK+tWQrEvUmAH+VUUyA5p6E/PncnOZ3ZQ5js3hcihkg40wCe4ueKcAm69/YEbhLX+/OaN+WXLNHxzrP+XZRlYmwoUpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KO5RQgy0rLhT8mQ4SNq59OvRkBGYMi/gjlA360kRn80=;
 b=se7e2QmZqW+vHbuRuegG1LQgKP/ELWQn/vyGlDQix872BSoeq8MGmRWon1MmMjzK7h4CQaSFBAMXCW2jsDdheLkXeeKzPjeLaG74CAbwS3cuiDc/hEVT0nG7Wf4brb7m9jkXwbK/cKsOLKpjhnPXxNI/BVevxXJERHbHfVOpIog=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 00:45:26 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 00:45:26 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Manan Aurora <maurora@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "manugautam@google.com" <manugautam@google.com>,
        "badhri@google.com" <badhri@google.com>
Subject: Re: [PATCH] usb: dwc3: Support EBC feature of DWC_usb31
Thread-Topic: [PATCH] usb: dwc3: Support EBC feature of DWC_usb31
Thread-Index: 
 AQHaDV+hQYu1qIk1pk2bzrpJF26+HrB0OuyAgAhDWACAAVg3gIBf0uIAgAAGNACAAAdDAIABfasA
Date: Thu, 18 Jan 2024 00:45:26 +0000
Message-ID: <20240118004524.2xwi3dqqcikzcjva@synopsys.com>
References: <20231102073840.1579540-1-maurora@google.com>
 <20231110230837.b5q5dsvsqlxfz5xu@synopsys.com>
 <CAJnM4-wew9b=Ge8QHLRiReNJAqgA0ngOW8WTVk4frta+y+9jYw@mail.gmail.com>
 <20231117015143.nzgqaes256lnz5ht@synopsys.com>
 <20240117011110.6yubmp4ysd2fit2p@synopsys.com>
 <CAJnM4-wqHmvTtkSYbLXfNByPZL4zv-ATwkywK4g7DsAhMtBSZQ@mail.gmail.com>
 <20240117015922.5lnqd7tj35j3nm3e@synopsys.com>
In-Reply-To: <20240117015922.5lnqd7tj35j3nm3e@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW4PR12MB6729:EE_
x-ms-office365-filtering-correlation-id: 14f8c977-55f6-4744-2ea2-08dc17bec31a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 FDtvyC/gKuNkIW9804ixfLTt5TdOWOX4LXa51ztU2wbRMa7Srt8aZTnZsqg6BTkWXnjhKRoGQ5VAP0y0MiVhAqkxesqQrngtjIIOmR85OiIt6Z1bha4NUmysiOhKjjLqz2Mg98vijbb5qwOXwwZPtGM0xpe48HTn9Rrgb///Xv8VaxsE0Fb7XS36/tCLXJUbmhdlcv7rPN56DLr64dvY45GTujsnix01CiaC6FZGK3ncCh/J/JEjRrL5gAVwnUGgi4z5x/gfWASdZG/SE2GU6C0zAq6lpPWzN7U9pYkHVyCOdCLEni155ryiXvsILoOI8UJjifB6cl3JgK/df529TIlgsaSi3+LgHN/+GpDLhYqwDxiud7N6FIAp93R4Uzky2r9eNTHzZ1cfSeawfd+1V+HDuyoOHXgDU9VR7PW2DxEJTrTJ4PZdSVWiU9s3z9tTMx0/5Lzc8Chr2tB0NTQitAHB4+vzDuqtYsh0A8myvilRN8+95WLonT7m/BhVL6Sm4IBTliVkSlZQnkD4ZyERGZmyH4APwqj6vnDvr4PgQd9N3YI08ycIu/ltF60NZDQhrz1sVIjVbfGYxN0QQBSiG2d9BjC1OdWqtTnx6mr8k93puMXMHzQfIKRKkF/48Z3htHPDvb8I/J7eF5OxuHvrgQys/bFr8DrBNunB34ybdf8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(66899024)(83380400001)(86362001)(38070700009)(36756003)(71200400001)(122000001)(8676002)(8936002)(4326008)(1076003)(53546011)(2616005)(38100700002)(26005)(66556008)(6486002)(6512007)(6506007)(66946007)(91956017)(64756008)(6916009)(66476007)(76116006)(54906003)(5660300002)(316002)(66446008)(478600001)(2906002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VjFKYzZqc1gzcWxrK0Y0WkkvTytNazdCZnNHc3NEV2hmZlJHekFXZG9XQW1Y?=
 =?utf-8?B?Y2xzMTk0c3FsT0VTZnN1aHFBeW45Z1kzN1RzTVozSnl1b1crMzdia0dDd0wv?=
 =?utf-8?B?bHBWcmltWmo4WlFTTzlPUklNY29kTFordzdZRlhIUE11SzFHSHJHaHhRSDAr?=
 =?utf-8?B?RDBDQzlsQ2NuYVN0TnRRdVhDQzZ0d3dueFRkam1zM284YVIvUHBaYXpNampO?=
 =?utf-8?B?NlkrS1NlVFlnUVhaaG1tdXcwQzhTYnpaQzZBVTVlRWJsTFpZc0J4ckV0cUtv?=
 =?utf-8?B?TFFLenZXREJUdUhXajJ2Nk91bUhoalBSUURLQ2V6TEUyb1lKNCtsQ3hWNUg4?=
 =?utf-8?B?SkVTSUxSU3puYnB5RWpCVlpQWUUzSnlpTjM0UUUvcU5Qdk1adFJEV3R2QmJV?=
 =?utf-8?B?QitGVy94RnVsV3BuajNFV2J5clJObnZwK3FIR3U1eXVVeE13cHRxYUlMdktU?=
 =?utf-8?B?RlNHU0RtVEs5bUdzT1B1b3ozUzhxTmJSVlc1NkU5YjlBdnRrRFFtaXFHS1lo?=
 =?utf-8?B?SG45QSs5OGd2R1FXMzJHUXZhOVA2MmwrMDFETXB0RXB6U3M2blhtOC85cCsv?=
 =?utf-8?B?NXNKMG5lM1JhcE15djJxQ1pma1JWOGVtVW1UdWhJZlBEQUROYWUrcG9ucEJo?=
 =?utf-8?B?V3I3b2ErNWRTZnRlNkFJdGFMNE40YjJxUWlKQWEwbWQ4YzNWUGhKR1dLcVZU?=
 =?utf-8?B?UEJBWkFCbGdMWVVpNWh1SXdINjFzYU4yMzkxSnJXSTI3V3ZBVmtONzBTZWti?=
 =?utf-8?B?ZmtnQzlNN2ZRay8weHJiU0tXY0JhTzN1VEZNcyszZCtCem1uZVZXU0xqcEk0?=
 =?utf-8?B?aFRRdDZxZldablY3V2V6cXMyNWtyWHRlM1R6NFNkZEtReU9GeXhHekFJcGJQ?=
 =?utf-8?B?TFBrbWdEWHg5VEpJQm9aTUxwbXUxdkpNbUxVY2lzaHpWc2lqLzUycGt5M2wy?=
 =?utf-8?B?ZmRUUXlYWjkwV2x6bUNjUWUwUGN3S1NFWXl5TTk5SC9DS2NtZVR6ZTFGSVlL?=
 =?utf-8?B?cTY2dVFiL3ROZFdGQm5tSmduZUFLRmQ1WDZ5SGQ0TldPUlh2YnpmOXpNSm1K?=
 =?utf-8?B?MGVERmRDS1I4UlAwVitrc0Z5VExxL3JNc2tGTzlXUC9QTW0xdmcxR3lKcnBQ?=
 =?utf-8?B?UGJ6RUFzelhzSVF3SFU4SmppVVhnM2c2bEZsQ05VZUVIanp2aS81M0NrNVYy?=
 =?utf-8?B?TUVGRmdlRE8rMENlUTUwNmZsaFJ1R1pIdDRKd1g3dnZrTTB6M1B2NmRiU2lw?=
 =?utf-8?B?bm5XOWw1eXcrQ3dPd1VvbktCUFkwNS9ZRnZiZDhmUnB3UlFBQ2p6QUh0QUJ4?=
 =?utf-8?B?TitYelMwbG1oL25nSWR1ODFvTjh3ZlVYdWJwUEp3WTNKSmgwTzVlMkczVFls?=
 =?utf-8?B?ZndLOUlZaWxzQ3I0S045T0xoYnl0N1lGVHdxenBSUTRYVS8wSkdLYTNWaHp2?=
 =?utf-8?B?ZVFkTHJJd2dzOU5zbm9ha3daejJsWGRiRGY0K1ptK08rNThUQllFSjBqNEFL?=
 =?utf-8?B?ckJOU0NhZHNyV1ZmTHd2bnFzNTdCZHhVL0I2OWFBL3k2OTJCcUdMSTcwbFFj?=
 =?utf-8?B?Z3B0VzN0R3c3ekpuSy9oam4wd25GckpJVEtsb3dyeHV4d09mSGFhTGZQWnhh?=
 =?utf-8?B?MzMvb3VZN1dQK1dtUFFnR1MvUW5wVSs1L09TNkZwZDkzNHpKT3pNb1daOVE4?=
 =?utf-8?B?ZjhjYTNPTS8zN0lRQ2NMUUZWd25aUnk2YjZ2OXBnekxqTGpSbmRrdmZSNXpa?=
 =?utf-8?B?V2NuVkZ3bDYyUlZIdm9jSUlZalZ0SFFkUHFuU0NhZzBSNFlabDUyT2NDNXpH?=
 =?utf-8?B?ZUlVVWZkZTFndVR3Z0hDMHYwNzZ2aHJBbFdqVENIVmpFK2lnc1pHVXpKQVMv?=
 =?utf-8?B?MXpLeUVnOXBRbm5UWmdhSkZ5bHNKRTBFaWpCSmdqeDlxaENqTFh1V3I2SDNQ?=
 =?utf-8?B?VlJrZ21pdlZuUXY1TWROdmR3akRBR3Y5QUNhNW13bTNTVGRuOFg1Y1RwRFIv?=
 =?utf-8?B?YnBVVHZ6Nm8wb0c2azZyR1pDTzNXT3VBbm1keTRpcVFpUU5zdnJkaDRuQ2JP?=
 =?utf-8?B?K011QStHNDlDR1ZWU0ZoMUt1RlFsTGlEZHp2bGM3UGsvM0g1YjBoTkxNekx0?=
 =?utf-8?Q?ttci8Z1lInKPJtuomqjxM90H1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E60D550C3609F648AB39607FCD2DA5EA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	19u/sVZ2JRouAk/6PPgmay/OaVo+os0RxuEPggSlktOB37qQwoB+qAbh4jcoxAHZ5nIf22yw/kpt5dVtvMjF4ExDXALV4BJVUx4z5FbafsiWc4j1RrSqENoCfsP/xMm/oqPRVK4bHGSgNE1KOS7/DDfmWQFzxQRDwTKHU5GPZ3wl0eYujUhsI8dnnr8ra0Y8YoiUkQwgddHd6TaChtrqDXv+LqHRM5enOLm0irswkcjpAgvjg1ewdygYAep6kh5IuiMP3qAOJYhemMhdL67Pv8DF/qZweYA0qvenHBc8YxKkJEmY5NYU+lPnhDLK57saHbfd6xkJsitYZCdqVrkr7UjlakPJuC1oItf1JY6RkoHy08xTsjYM6qki7jRoo7pQYh5IWwxCLG4aZLD1JL3zPL1iQAskwIFRX4z5aUid1rlwdoUbC4BAuUIUnP7bKgy1np55X7qNWdVAn0KgMSSw3Y1f9rUUO5Agc8ZzbpnTunLaVjKV5i/lA0lkblQ+xSUrvqG62Uzf5Z13c/vd8i8QBw0bNkJWymNLD2K+90ddnlGod+9Gui424Q0M1tvOffnLpo2cmy98V4y70V8WJQRs/LVDIVRBF3mfEjTP0NAbSdfMymfKgy9/9e7siW5nSSYYqaBJFG6tVYuZMDolsqNbOQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f8c977-55f6-4744-2ea2-08dc17bec31a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 00:45:26.3832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYWK6dCgMw966TK/HYkzxdkta6CF5ukCidr4LLD+QRmmvROBPE6ld2DaeH6P3J5ptiXAaM9td8DCKsmGdp9n4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729
X-Proofpoint-GUID: S4du8bgEaOR1o8iN_PKHcVYM1mzqAI1o
X-Proofpoint-ORIG-GUID: S4du8bgEaOR1o8iN_PKHcVYM1mzqAI1o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_13,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 malwarescore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401180003

T24gVHVlLCBKYW4gMTYsIDIwMjQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gSGkgTWFuYW4sDQo+
IA0KPiBPbiBXZWQsIEphbiAxNywgMjAyNCwgTWFuYW4gQXVyb3JhIHdyb3RlOg0KPiA+IEhpIFRo
aW5oLA0KPiA+IA0KPiA+IEknbSBmaW5lIHdpdGggcmV2ZXJ0aW5nIHRoZSBjaGFuZ2UgdW50aWwg
aXQgbWF0Y2hlcyB3aGF0IHRoZSBpbnRlbmRlZA0KPiA+IHVzZSBjYXNlIGlzLiBJJ3ZlIGFkZGVk
IHNvbWUgbm90ZXM6DQo+ID4gDQo+ID4gT24gV2VkLCBKYW4gMTcsIDIwMjQgYXQgNjo0MeKAr0FN
IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4gd3JvdGU6DQo+ID4gPg0K
PiA+ID4gSGkgR3JlZy9NYW5hbiwNCj4gPiA+DQo+ID4gPiBPbiBGcmksIE5vdiAxNywgMjAyMywg
VGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gPiBPbiBUaHUsIE5vdiAxNiwgMjAyMywgTWFuYW4g
QXVyb3JhIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFNhdCwgTm92IDExLCAyMDIzIGF0IDQ6MznigK9B
TSBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+IHdyb3RlOg0KPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+IE9uIFRodSwgTm92IDAyLCAyMDIzLCBNYW5hbiBBdXJvcmEgd3Jv
dGU6DQo+ID4gPiA+ID4gPiA+IFN1cHBvcnQgY29uZmlndXJhdGlvbiBhbmQgdXNlIG9mIGJ1bGsg
ZW5kcG9pbnRzIGluIHRoZSBzby1jYWxsZWQgRUJDDQo+ID4gPiA+ID4gPiA+IG1vZGUgZGVzY3Jp
YmVkIGluIHRoZSBEQkNfdXNiMzEgZGF0YWJvb2sgKGFwcGVuZGl4IEUpDQo+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+IEFkZGVkIGEgYml0IGZpZm9fbW9kZSB0byB1c2JfZXAgdG8gaW5kaWNh
dGUgdG8gdGhlIFVEQyBkcml2ZXIgdGhhdCBhDQo+ID4gPiA+ID4gPiA+IHNwZWNpZmljIGVuZHBv
aW50IGlzIHRvIG9wZXJhdGUgaW4gdGhlIEVCQyAob3IgZXF1aXZhbGVudCkgbW9kZSB3aGVuDQo+
ID4gPiA+ID4gPiA+IGVuYWJsZWQNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGlzIHNob3Vs
ZCBiZSB1bmlxdWUgdG8gZHdjMywgYW5kIGl0J3Mgb25seSBmb3IgYnVsay4gSSBkb24ndCB0aGlu
aw0KPiA+ID4gPiA+ID4gdXNiX2VwIG9yIHRoZSB1c2VyIG9mIHVzYl9lcCBzaG91bGQga25vdyB0
aGlzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSW4gb3VyIHVzZSBjYXNlIHdlIGhhdmUgYSBmdW5j
dGlvbiBkcml2ZXIgdGhhdCBjb25maWd1cmVzIGFuIGFsbG9jYXRlZCBidWxrDQo+ID4gPiA+ID4g
ZW5kcG9pbnQgdG8gb3BlcmF0ZSBhcyBhbiBFQkMgRVAuIFNvIHRoZSBmdW5jdGlvbiBkcml2ZXIg
YWxyZWFkeSBkZXBlbmRzIG9uIHRoZQ0KPiA+ID4gPiA+IGZlYXR1cmUuDQo+ID4gPiA+DQo+ID4g
PiA+IFRoaXMgc2hvdWxkIGJlIGFic3RyYWN0ZWQgZnJvbSB0aGUgZnVuY3Rpb24gZHJpdmVyLiBU
aGUgZnVuY3Rpb24gZHJpdmVyDQo+ID4gPiA+IHNob3VsZCBub3QgbmVlZCB0byBrbm93IGFib3V0
IHRoaXMgZmVhdHVyZS4NCj4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGR3YzNfZXAgc2Vl
bXMgbGlrZSB0aGUgY29ycmVjdCBwbGFjZSB0byBwdXQgdGhpcyBmaWVsZCBidXQgYSBmdW5jdGlv
bg0KPiA+ID4gPiA+IGRyaXZlciB0aGF0IGFsbG9jYXRlcw0KPiA+ID4gPiA+IEVQcyBhbmQgY29u
ZmlndXJlcyB0aGVtIGZvciB0aGlzIHVzZSBjYXNlIHdvdWxkIG5lZWQgdG8gaW5jbHVkZSBkd2Mz
IGhlYWRlcnMuDQo+ID4gPiA+ID4gSWYgb3RoZXIgdmVuZG9ycyBvZmZlciBhbiBlcXVpdmFsZW50
IGZlYXR1cmUgdGhpcyBkZXBlbmRlbmN5IHdvdWxkDQo+ID4gPiA+ID4gYmVjb21lIGFuIGlzc3Vl
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gRXhwb3J0aW5nIGEgc3ltYm9sIGZyb20gZHdjMyBpcyBh
biBlYXN5IG9wdGlvbiBidXQgZHdjMyBkb2Vzbid0DQo+ID4gPiA+ID4gY3VycmVudGx5IGV4cG9y
dCBzeW1ib2xzDQo+ID4gPiA+ID4gaGVuY2UgSSB0cmllZCB0byBhdm9pZCB0aGF0DQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+IEFsc28gc2luY2UgRFdDM19ERVBDRkdfRUJDX0hXT19OT1dCIG11c3Qg
YmUgc2V0LCB0aGUgY29udHJvbGxlciBkb2VzIG5vdA0KPiA+ID4gPiA+ID4gd3JpdGUgYmFjayB0
byB0aGUgVFJCLiBEaWQgeW91IGhhbmRsZSBob3cgdGhlIGRyaXZlciB3b3VsZCB1cGRhdGUgdGhl
DQo+ID4gPiA+ID4gPiB1c2IgcmVxdWVzdCBvbiBjb21wbGV0aW9uPyAoZS5nLiBob3cgbXVjaCB3
YXMgdHJhbnNmZXJyZWQpLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSW4gb3VyIHVzZSBjYXNlLCB3
ZSBpbnRlbmQgdG8gaGF2ZSBhIGxpbmsgVFJCIGFuZCBpc3N1ZSBhIHN0YXJ0WGZlcg0KPiA+ID4g
PiA+IGNvbW1hbmQuIENvbXBsZXRpb24NCj4gPiA+ID4gPiBoYW5kbGluZyBhbmQgY29udGludWlu
ZyB0aGUgdHJhbnNmZXIgd2lsbCBiZSBvZmZsb2FkZWQgdG8gZGVkaWNhdGVkDQo+ID4gPiA+ID4g
RklGTyBoYXJkd2FyZS4NCj4gPiA+ID4gPiBCdXQgd2UgY2FuIGRlZmluaXRlbHkgcmV3b3JrIHRo
aXMgdG8gZGlzYWJsZSBuby13cml0ZWJhY2sgbW9kZSBieQ0KPiA+ID4gPiA+IGRlZmF1bHQgYW5k
IGFsbG93IHRoaXMgdG8NCj4gPiA+ID4gPiBiZSBzZXBhcmF0ZWx5IGVuYWJsZWQNCj4gPiA+ID4g
Pg0KPiA+ID4gPg0KPiA+ID4gPiBPay4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBMb29rcyBsaWtl
IHRoaXMgY2hhbmdlIHdhcyBhcHBsaWVkIHRvIEdyZWcncyBicmFuY2guIFVubGVzcyBJJ20gbWlz
c2luZw0KPiA+ID4gc29tZXRoaW5nLCBJIGRvbid0IHRoaW5rIG15IGNvbmNlcm5zIGFyZSBhZGRy
ZXNzZWQgeWV0LiBIZXJlIGFyZSB0aGUNCj4gPiA+IHJlaXRlcmF0aW9uIG9mIHRoZSBjb25jZXJu
czoNCj4gPiA+DQo+ID4gPiAxKSBUaGUgZ2FkZ2V0IGRyaXZlciBzaG91bGQgbm90IG5lZWQgdG8g
a25vdyB0aGUgZHdjMydzIEZJRk8gbW9kZS4gSXQncw0KPiA+ID4gc3BlY2lmaWMgdG8gZHdjMyBj
YXBhYmlsaXR5IGFuZCBzaG91bGQgYmUgaGFuZGxlZCBpbiBkd2MzIGRyaXZlciBvbmx5Lg0KPiA+
ID4gVXN1YWxseSB0aGVzZSBwcm9wZXJ0aWVzIGFyZSBzZWxlY3RlZCBpbiBkZXZpY2UgdHJlZSBi
aW5kaW5ncyBhbmQgbm90DQo+ID4gPiBzcGVjaWZpZWQgdGhyb3VnaCB0aGUgZ2FkZ2V0IGRyaXZl
ciBBUEkuDQo+ID4gDQo+ID4gSSdtIG5vdCBzdXJlIGhvdyB0aGlzIHdpbGwgd29yayB3aGVuIHdl
IGhhdmUgbXVsdGlwbGUgZnVuY3Rpb25zIGFuZCBvbmx5DQo+ID4gc29tZSBvZiB0aGVtIHVzZSBF
QkMuVGhlIG90aGVyIEVQcyBhcmUgd29ya2luZyBhcyB1c3VhbC4NCj4gPiBJbiB0ZXJtcyBvZiBE
VCBiaW5kaW5nIEkgY2FuIHRoaW5rIG9mIGZvcmNpbmcgY2VydGFpbiBFUHMgaW50byBFQkMgbW9k
ZQ0KPiA+IGFuZCB1c2luZyB0aGVtIGZvciBhbnkgZ2FkZ2V0IHRoYXQgbmVlZHMgRUJDIGJ1dCB0
aGF0IHdpbGwgcmVtb3ZlIHRob3NlDQo+ID4gRVBzIGZyb20gY2lyY3VsYXRpb24gZm9yIG90aGVy
IGZ1bmN0aW9ucy4gSXQgd291bGQgYmUgZ3JlYXQgaWYgeW91IGNvdWxkDQo+ID4gc3VnZ2VzdCBh
IGdvb2QgYWx0ZXJuYXRpdmUgd2UgY2FuIHVzZS4NCj4gDQo+IE9rLiBJZiB0aGVyZSBhcmUgb25s
eSBzcGVjaWZpYyBlbmRwb2ludHMgc2hvdWxkIHVzZSB0aGlzIGZlYXR1cmUsIHRoZW4NCj4gd2Ug
d2lsbCBuZWVkIHRvIHVwZGF0ZSB0aGUgZ2FkZ2V0IEFQSSB0byBzdXBwb3J0IHRoYXQgYXMgeW91
IGhhdmUgaGVyZS4NCj4gUGxlYXNlIGRvY3VtZW50IGhvdyB5b3UgaW50ZW5kIHRvIGxldCB0aGUg
Z2FkZ2V0IGRyaXZlciBrbm93IHRoYXQgdGhlIEhXDQo+IGlzIGNhcGFibGUgb2YgZXh0ZXJuYWwg
RklGTyAoaWUuIHVwZGF0ZSB1c2JfZ2FkZ2V0IHN0cnVjdHVyZSksIGFuZCBmb3INCj4gaG93IG1h
bnkgZW5kcG9pbnQuIEFsc28gdXBkYXRlIGFueSBleHBlY3RlZCBiZWhhdmlvciB3aGVuIHVzaW5n
IHRoaXMNCj4gZmVhdHVyZS4NCj4gDQo+ID4gDQo+ID4gPg0KPiA+ID4gMikgVGhpcyBzcGVjaWZp
YyBtb2RlICJFQkMiIGRvZXNuJ3Qgd3JpdGUgYmFjayB0byBUUkJzLiBJdCdzIG5vdCBjbGVhcg0K
PiA+ID4gaG93IHRoaXMgaXMgaGFuZGxlZCB3aGVuIHVwZGF0aW5nIHRoZSByZXF1ZXN0J3Mgc3Rh
dHVzLiBJdCdzIGFsc28gb25seQ0KPiA+ID4gYXBwbGljYWJsZSB0byBidWxrIGVuZHBvaW50LiBJ
ZiBpdCdzIHRvIGJlIGFwcGxpZWQgdG8gdGhlIHVzYiBnYWRnZXQNCj4gPiA+IEFQSSwgaXQncyBu
b3QgZG9jdW1lbnRlZCBmdWxseS4NCj4gPiANCj4gPiBJIHdpbGwgcHVzaCBhIHBhdGNoIHRvIHJl
bW92ZSB0aGUgbm8td3JpdGViYWNrIGJpdCBiYXNlZCBvbiB0aGUgZGVjaXNpb24NCj4gPiBhYm92
ZS4NCj4gPiANCj4gDQo+IFN1cmUuIFdlIGNhbiBrZWVwIHdoYXQncyBhbHJlYWR5IGluIEdyZWcn
cy4gUGxlYXNlIHVwZGF0ZSB0aGUgY2hhbmdlIGFzDQo+IGRpc2N1c3NlZC4NCj4gDQoNCkFjdHVh
bGx5LCBJTUhPIHdlIHNob3VsZCByZXZlcnQgdGhpcyB1bnRpbCB0aGUgaW50ZXJmYWNlIGlzIHdl
bGwgZGVmaW5lZA0KYW5kIGRvY3VtZW50ZWQuIFRoZSByYyByZWxlYXNlcyA+IDEgc2hvdWxkIGJl
IGZvciBmaXhlcyBhbmQgbm90IG5ldw0KY2hhbmdlcyB0byB0aGUgQVBJLg0KDQpUaGFua3MsDQpU
aGluaA==

