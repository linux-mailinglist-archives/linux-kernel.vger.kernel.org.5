Return-Path: <linux-kernel+bounces-34645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85448385A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9734A28A464
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4139217CA;
	Tue, 23 Jan 2024 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CLGGN10x";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bq9rm5aJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kLCm259y"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6995337A;
	Tue, 23 Jan 2024 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705977600; cv=fail; b=gMGvWfYzIbWXGHjGAQ+KwDu61m9k+JFs33zOIT5xr+tIQL2jA32sxPZTiwdSoYhEtB2/sJgDsqRce6r0I+AKLbPpNWfXO/PXNESrXrYnhdDHOQ0i6GasogdpKI2M4BqRWTNXxPcnVx3qrmmyASpwGGYwvUbefrzcaPbhvKEItng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705977600; c=relaxed/simple;
	bh=X+cg3ncVSXPERn1j5Zane0eEEVwGyfMYZCbxKjOzfQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J1wDVuqtegeXHPAL6Yp8rhd2lqEaaSMr1E1goddAynlOEZ+ADGehKpVcpPttLTXxgzjLKnpAb1KdDs5K0uIpoxGZOJcUmwyApS0DLIZvxFm0MYmykj3VLuDT+RcQTj2fys4VDr6xUO4P28YH0T3mCvDWRFw8LuU+EC/298cs/mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=CLGGN10x; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=bq9rm5aJ; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kLCm259y reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N0nRht022749;
	Mon, 22 Jan 2024 18:39:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=X+cg3ncVSXPERn1j5Zane0eEEVwGyfMYZCbxKjOzfQs=; b=
	CLGGN10xu1kvqTHqnlsezZ9FAWaOZATAquM7b4heNgDu3j7ELWEBo3/Cof/6aoZb
	Q6kaSF1iojYiWdYlpfLwpcGckH7Ff574ICOqJ49MZkKNKvn3tQnOOAEFT+VkZIDX
	7AveQQSkdGPEqAV0vfoEGCft4KKAFdKey2pPvJyXqIad5zQt1M6EHLBNjDVWlttL
	brjEQ5tBGs6Qhe+D/cby53AY3P+f56VEUh39x6lUwWCDrVyfCwq53sdfQxpM1dGF
	yUuO0VeeC2dO7KRvU7I9NE3UierkCCo3coZ/OElxbzLdo2GRJwtGVDdT2FS/2cKi
	weWlEa3XTMkCUQudoWyFVA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3vrea7asex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 18:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1705977570; bh=X+cg3ncVSXPERn1j5Zane0eEEVwGyfMYZCbxKjOzfQs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=bq9rm5aJKm8TZW+xuND+njtv/0g9nGbFIr9fZxsdA7HojGV8Xqj/a6D5T9KEI9vFG
	 Zp1Rf+pEe53otA0nbcA/aNityTyFpvXCYR5FWE/A4E9+7TtDjPQYwyjbboqm3g9H8S
	 14sOpWS3TggB6uW6+LQuKwoLeHh/ebSwJIeh8knN0DGsSNyUgFNBx76zRS2jttXRPv
	 bnEr1Pgbi1jS6Ze62z9KJh+rvHaUjbW9RjS9ce2b5YzKQjffn8b8iEASbNvdRSOSFa
	 5jV4mYLsryQqg9+fyhmJfD6ThN0RTS/G3nuCIjWZrXBJ1uYYUcyxieizy+XxoB9suu
	 dAsxnwSr40leQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 31EC640362;
	Tue, 23 Jan 2024 02:39:30 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 90FFFA0064;
	Tue, 23 Jan 2024 02:39:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kLCm259y;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E218340453;
	Tue, 23 Jan 2024 02:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klpx7lBxsjYu3uoAWDZkmtvaOMU78qAnloZxh9sTmGt+tmHfGOY8vLZ0MZKHl1xhHEAfh0oe+dzHuYWG2d2wgIq40zd8XaegqLR2JvNgYb855wsXoEy3ElIyLId33yr7VLpel2BstrC7eGJwvs0j8inTg2IeFDnLVsFZNI2WcUkhefM0fpHr0vmzo0nHdNqrZNUGoir62z9OWGVWxw4bgI0rrC/eB9ZEszPKuGePBPSXRzC6bh1htOQ9V+TLsubTUb6jORKikgN4KUMpAG5UCzPEBymUO/lfogy73omJJuaI4WeKeeBhs1yueTjuube1mKLwatOs5ND3xcO6B/Xrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+cg3ncVSXPERn1j5Zane0eEEVwGyfMYZCbxKjOzfQs=;
 b=KRnrE1msmgjm3ycxdz6+FEPafeqK073kw4r/wd7+UYOo+bzn733Jcj6pIpvGi6FEJ4ope/TujD2IsmNSi0Splr40P2rEWatk9KH5L+57AcBm59lP2GZgDftkdKR0lV8VqSJq1XTs4rajh70ys1wu2rGZsiELb2NNrpT07r1esU1NO1bFIE2lMGgUqPsh9pDP1JfvnHQDBmC3SEg3iJ1weK+x2ivYYHpe6paMONa1E87a85SONu6YK8W94KebQLOyF/ITpc7WlbCUTK9QYp4wo+xaBJ2LWfdqbxnM50wBmtkC/Qep+LYOF+qre/4S9Qmwo+P8N3b+R77wm5buG2LL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+cg3ncVSXPERn1j5Zane0eEEVwGyfMYZCbxKjOzfQs=;
 b=kLCm259ytuHs/RJgRTADCF/Y62AH2ekNk8WT398PzykrCsGS12SMIMhQjJL492JRid8SqNchMG89GhTTSKG2MSUj6cWgsz/2tnxyRQDibObaPEVaCqiDRFJ2TV/sDy/8U4P3/qrWdWxSYthyjqsNcHRn7xfHfOMDwZws/hmEyeE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 02:39:26 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7202.033; Tue, 23 Jan 2024
 02:39:26 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.Li@nxp.com>
CC: "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pku.leo@gmail.com" <pku.leo@gmail.com>,
        "ran.wang_1@nxp.com" <ran.wang_1@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sergei.shtylyov@cogentembedded.com" <sergei.shtylyov@cogentembedded.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v2 3/3] usb: dwc3: Add workaround for host mode VBUS
 glitch when boot
Thread-Topic: [PATCH v2 3/3] usb: dwc3: Add workaround for host mode VBUS
 glitch when boot
Thread-Index: AQHaTLiwtJheclVTLUilLJoFgAlb5LDmsUUA
Date: Tue, 23 Jan 2024 02:39:26 +0000
Message-ID: <20240123023916.jpakvznngiciwfwq@synopsys.com>
References: <20240121222428.3396428-1-Frank.Li@nxp.com>
 <20240121222428.3396428-4-Frank.Li@nxp.com>
In-Reply-To: <20240121222428.3396428-4-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BL0PR12MB4913:EE_
x-ms-office365-filtering-correlation-id: 2b9d8fde-3a20-4677-44e1-08dc1bbc83f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8/JhMNpJ+ZF9+pk41qMZVJB8w2Sitcbnf16/WkaKmMXlveOWOmNDrbrOM4Gsa3nrMw6DVSoxsK68J3dAwBgi//L0trR+weQtj4ZNncvJ1sp+C220FDvLijr+suogXRcHvZZp7nMx/AcLf+DMGIJPNcfnfhmlsxdpr7s7ROvg4uVLP5kmoq55SIura2mlaRXzykCJvECtezmsXuzhQSmp8syJe5ejePbg5jSu9z/dYoqPAgbIC904LbailWp2kKvk8rQ/ves4rY/qyc47QQwqYadXYAdY8385gZ2o4ld/Zr5oV4G/fKPl8/4nyoaRkPeEz3Br4qzgqK0eZI0FKA0A3X64mnJa4MkxPnSBbOj9BK1B7aUO1WoPJeD+0gqUL8Lr+WOa1rrN1SFFsKT9aHmAygX2uiTeRLXJVUBj1Bkn0jOQT1Jhusn681GPuQutI/+/ghj/TFssjylRXmaA6GmRn9cokw1UC7sI46dT6vIH7v5JJmadw22svcRBKyM1dJo1GKvLX1ypARI/oRYlWB9jFJmhfk+2xG9UdDh3IzFrxAX9Y9Xg/O80YuiSj8PfezWNOLBC+/a1VrruGtXNrPc6Kz3F/Fl7lVdXtRN+/r6fOTWOXHhXk4jn1r0l5u1xXIyF
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(346002)(366004)(136003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(122000001)(38100700002)(7416002)(3716004)(2906002)(41300700001)(36756003)(86362001)(478600001)(66946007)(6916009)(316002)(91956017)(54906003)(76116006)(66476007)(66446008)(66556008)(64756008)(71200400001)(6506007)(6486002)(2616005)(8676002)(8936002)(4326008)(5660300002)(1076003)(83380400001)(26005)(6512007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K3Q1aEJWUXM4WmVqVVlKVnQ2YTJJOHUvbFBZUVRJWmRyem5PWC9UMzVZZlJj?=
 =?utf-8?B?NzFqQlB5Yjc4aitmVGNEOU5qdk85Zm9vVDJ4SUdFZVpOcDlnTGpOSE9aRjVI?=
 =?utf-8?B?TFl2YStheXUrNW1iRGMvUGxXYmc2Q3pMQzUwTGFwZWNIT2RySXFHYk5xRFZN?=
 =?utf-8?B?UmxSbUg1eU5hZEI2bFlxb0ZLT2VEZzNHQ3VxVHlPRGMyOFgwWjVNc25ja3ZG?=
 =?utf-8?B?RE9yUGdLWCtndU9VVmFmSWhDUGdWZkhKbmFvNk5Da09WQnZXU3IzVk8wZWIz?=
 =?utf-8?B?OHc4VCtDOGJOb1lyV0Y4a0FjU3lEOWh0RE03bFlyNWZMd25leEdKNi9xKzN2?=
 =?utf-8?B?eXczZFlKZGpzK1lRZWVJcTZBclh4SytVbWU2S1FBVndza2ZkMWRwaGU5ZmQ1?=
 =?utf-8?B?TVQ3cnljTVlqTmZkUVROU0ZDbkw5KzkvQUVSQXg3cXRvWFRJRk9MUjRZZGJl?=
 =?utf-8?B?QVhacTNuenhGT1pwL3BiUG56Y0t3cHE1QlZMUlBocWZPb1lzVjRZelFNS2M3?=
 =?utf-8?B?Y24yRW5OcVNlM2NBZ0lHRk9na3ZlQ1d4bHI1dHZKRFd4SFdGTkc5K2k3aTVL?=
 =?utf-8?B?MDJtUGlvNXRPWDBuR09nSnEyM0JSR1Z2T2I3MFFWc01tNVpaNTRjb1JlSkh6?=
 =?utf-8?B?M1hEdnNEbkR0cjBydHNDSit1M1Z4RDlUK1lzOTh3R3J5QmowbXJTUmY4akhJ?=
 =?utf-8?B?c3hnakM5U2tSVzVVbnhFR2EvN0JraDRyR3E0OHBPRzQwVHZwWmF1aFFiN0l3?=
 =?utf-8?B?dzFuZTVOVVEwMzF6UXJqWGxRVEhHbzdCM09JT0pMUTUzTlR3a3ZOemphWVlR?=
 =?utf-8?B?dHV4M1YyTWcvZmJ4cVFuWWlhVU5KV25QZGo0Q2Q3N2lUWUVwTzNIbTZNeGFW?=
 =?utf-8?B?RkxqMmpyRjM0b05USUVrd2VnSDhmMVpWMWdueG45aTU0Sjd0Q2hIblMxZWor?=
 =?utf-8?B?MTlDQmhEVS9uQWJ1a0MxdWo3UzYxblpIR3dYaDdDT2NRUnRBTmM3NG5GM1lt?=
 =?utf-8?B?U1BVTVA4Yk85Y21XRmQvOUZnS2RxUkpUU1NBRjlIK1ZhV095VFJxK0VURG84?=
 =?utf-8?B?aU1WWVVYbDIxWGpxR0xNUmJSYThjU1NwWUUzOXlWUE1JaldLZE5uOUlsM0M5?=
 =?utf-8?B?SG9xdm1ZdUp4UUt0dmV1MC9ZUWxZNGZWbEVJelZxaWFjQTdhekV5WUxmdDVv?=
 =?utf-8?B?TXhQOWFwdzJndVdHNStpMm9HVkh1aFpVVnRPa01jUFdObXJFMzZIUTJGcWpW?=
 =?utf-8?B?bFRoVzZZRVlXeDVuc1Q5Zm5BWDZFZjhIZ1ZoNHd5blY0MHJ6VGdOT1NBdWpu?=
 =?utf-8?B?Z21uRll5ZHZqRGRiZFBHMDVveXZkMHhNRVpTOFd1NkNkQU1PVzhNL205Q09T?=
 =?utf-8?B?UGJoZ1FrOFJBTk5TalFvY3hBQWx2Qi9uM0N1NXhSWjk2elVsOGNuTHRFdG4x?=
 =?utf-8?B?aDF3dmlKVWJkNEk0UWZzSFB6OWk1cDEyQ1BlR3NWZm4wQTFadW1uZ0RCdzNH?=
 =?utf-8?B?WFpLZkR5eEtpdExnRE91SjFjYitGTWV5K2RneTRqZm0rRnZsL2VwYVJxa1No?=
 =?utf-8?B?MHlKQ2xXYXRRTXRsRUx2cW05SzUzVXMzRkZXR1JSY0sxQXNib3J5cEZ2Mndn?=
 =?utf-8?B?N1dXYWxETHAyMmM3TFVpMUlYWUJ6RWkzK3B5aUR1blZKMkR6RklMVERVcmdF?=
 =?utf-8?B?cFk5aWdFNzdlaWRFeFYvMEZiTlZIczkyRXhNZE9jV2JXUGwvTVlrUmc1eUhn?=
 =?utf-8?B?aFY5QWsvR1pidHl1ZXkrcUQ2RVlXSHpYQ3FUeFVleklLZVQraGZkaWkxYmtW?=
 =?utf-8?B?L0hNNVBwOVNvVmVmZnE0NExYNkIzck14YjdhaWdBMTdCWCttTkp3ODEyZWZt?=
 =?utf-8?B?c1h2WDFldDMva3pGM1BNSmtIWUxIc2s0UTk0SVU3eWZ1SnRLVWpuVzZXT1Bn?=
 =?utf-8?B?WjhTUmVEbmk0SktMdTlWVU1UaGhxbFc0cHlaZFNnQm1hQWpKc3doeGdaQzEy?=
 =?utf-8?B?OXJQUDZxa3gyK09wU2F0Ynl0NnRCd3Y0d2xLa0JIcWJIazdITHdycm1USHV3?=
 =?utf-8?B?M211bFpmVWJjcHFGNklVL3hCMWIySnRxVEVHMnU4S25oNzUvbEQ4UytDUVpt?=
 =?utf-8?B?RnJHeFBObGZqVUo5LzFYeTRvb0E0R2ZxbE5kbmFubTR1Uzd5N3gwV0lnREFm?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B28A4868120B16448463D324BD35BB54@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jTpV32hzFgj8TSprobg9cUVlXrnegOoKpN/AgH8lAaZJ37frcUR2B6dT5iZwGmqArV4Iel13puE0egS+Img9Vqh6bK+xqAfyYVwh8MI1Z//++sYRJCg4lV1h5P2LEWFNfAXxrzwG3rKkdm1FvSlcTNRmeRN7n6FaRsCuNZplmlFJMf6w7xvQlLEEg24vLwUaUY/61lG3iiq4YKZhdQ6lVN4nyGPJ9no84WUgtHnVeHhJZw8zCV405sQn/y7p/657g2J/ZSlLDoocMiAU6wgw02daMryupYAI48ow9hdcVjMwZaRnmX2WQgD0zryR3STFuo4Ii87Xl0MaCh2SK1La5tNKsUzoxukdwe6uxfmN6un09jstZsA8g2PyleKcW4HX0E7AKQ7B0ktTa1ev5efqZ69KwWMDkQP9iyfnuwfUQ5ga+fwR0zPelwm2XYEps0baHz7T3zwjxx79cVcfNH3v7CivRcjl4AZ9acMizL/NpQgoi9UBW+rFSqAzndRvq2aNjsBaR4ScZe33kqaEDhrC32gQmE0/ZqSiTDoI2OZXRLk6OJy0kFPNTUWS6ZHrCLzacgOPvKA62QusuLzUInuUmuGLW/1sJYpYo8xgxryaC/4vcNHMHNqcPQIQshveKbAwO3yOS1DoQfeloyXkg9FaRw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9d8fde-3a20-4677-44e1-08dc1bbc83f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 02:39:26.1289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 33vGCuSx4ZbmZw2StqMIlls0oiQ+XGIJqd/IZ2FIo5fJP32Yt6F8jSzWQ6hHCZmT8RqjaM8BvDHYiytjhcxQfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
X-Proofpoint-ORIG-GUID: 1rHeX2AaZCa0B8OoD5kgYV2Ek2rckdH6
X-Proofpoint-GUID: 1rHeX2AaZCa0B8OoD5kgYV2Ek2rckdH6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 impostorscore=0 clxscore=1011 mlxscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401230017

T24gU3VuLCBKYW4gMjEsIDIwMjQsIEZyYW5rIExpIHdyb3RlOg0KPiBGcm9tOiBSYW4gV2FuZyA8
cmFuLndhbmdfMUBueHAuY29tPg0KPiANCj4gV2hlbiBEV0MzIGlzIHNldCB0byBob3N0IG1vZGUg
YnkgcHJvZ3JhbW1pbmcgcmVnaXN0ZXIgRFdDM19HQ1RMLCBWQlVTDQo+IChvciBpdHMgY29udHJv
bCBzaWduYWwpIHdpbGwgYmUgdHVybmVkIG9uIGltbWVkaWF0ZWx5IG9uIHJlbGF0ZWQgUm9vdCBI
dWINCj4gcG9ydHMuIFRoZW4sIHRoZSBWQlVTIGlzIHR1cm5lZCBvZmYgZm9yIGEgbGl0dGxlIHdo
aWxlKDE1dXMpIHdoZW4gZG8geGhjaQ0KPiByZXNldCAoY29uZHVjdGVkIGJ5IHhoY2kgZHJpdmVy
KSBhbmQgYmFjayB0byBub3JtYWwgZmluYWxseSwgd2UgY2FuDQo+IG9ic2VydmUgYSBuZWdhdGl2
ZSBnbGl0Y2ggb2YgcmVsYXRlZCBzaWduYWwgaGFwcGVuLg0KPiANCj4gVGhpcyBWQlVTIGdsaXRj
aCBtaWdodCBjYXVzZSBzb21lIFVTQiBkZXZpY2VzIGVudW1lcmF0aW9uIGZhaWwgaWYga2VybmVs
DQo+IGJvb3Qgd2l0aCB0aGVtIGNvbm5lY3RlZC4gU3VjaCBhcyBMUzEwMTJBRldSWS9MUzEwNDNB
UkRCL0xYMjE2MEFRRFMNCj4gL0xTMTA4OEFSREIgd2l0aCBLaW5nc3RvbiAxNkdCIFVTQjIuMC9L
aW5nc3RvbiBVU0IzLjAvSmV0Rmxhc2ggVHJhbnNjZW5kDQo+IDRHQiBVU0IyLjAgZHJpdmVzLiBU
aGUgZmFpbCBjYXNlcyBpbmNsdWRlIGVudW1lcmF0ZWQgYXMgZnVsbC1zcGVlZCBkZXZpY2UNCj4g
b3IgcmVwb3J0IHdyb25nIGRldmljZSBkZXNjcmlwdG9yLCBldGMuDQo+IA0KPiBPbmUgU1cgd29y
a2Fyb3VuZCB3aGljaCBjYW4gZml4IHRoaXMgaXMgYnkgcHJvZ3JhbWluZyBhbGwgeGhjaSBQT1JU
U0NbUFBdDQo+IHRvIDAgdG8gdHVybiBvZmYgVkJVUyBpbW1lZGlhdGVseSBhZnRlciBzZXR0aW5n
IGhvc3QgbW9kZSBpbiBEV0MzIGRyaXZlcg0KPiAocGVyIHNpZ25hbCBtZWFzdXJlbWVudCByZXN1
bHQsIGl0IHdpbGwgYmUgdG9vIGxhdGUgdG8gZG8gaXQgaW4NCj4geGhjaS1wbGF0LmMgb3IgeGhj
aS5jKS4gVGhlbiwgYWZ0ZXIgeGhjaSByZXNldCBjb21wbGV0ZSBpbiB4aGNpIGRyaXZlciwNCj4g
UE9SVFNDW1BQXXMnIHZhbHVlIHdpbGwgYmFjayB0byAxIGF1dG9tYXRpY2FsbHkgYW5kIFZCVVMg
b24gYXQgdGhhdCB0aW1lLA0KPiBubyBnbGl0Y2ggaGFwcGVuIGFuZCBub3JtYWwgZW51bWVyYXRp
b24gcHJvY2VzcyBoYXMgbm8gaW1wYWN0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFuIFdhbmcg
PHJhbi53YW5nXzFAbnhwLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFBldGVyIENoZW4gPHBldGVyLmNo
ZW5AbnhwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAgMyArKysNCj4gIGRyaXZlcnMv
dXNiL2R3YzMvY29yZS5oIHwgIDIgKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvaG9zdC5jIHwgNDgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDMgZmlsZXMgY2hh
bmdlZCwgNTMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXggM2U1NTgzOGMwMDAx
NC4uM2I2OGU4ZTQ1YjhiOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMN
Cj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTE2MjYsNiArMTYyNiw5IEBA
IHN0YXRpYyB2b2lkIGR3YzNfZ2V0X3Byb3BlcnRpZXMoc3RydWN0IGR3YzMgKmR3YykNCj4gIAlk
d2MtPmRpc19zcGxpdF9xdWlyayA9IGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LA0KPiAg
CQkJCSJzbnBzLGRpcy1zcGxpdC1xdWlyayIpOw0KPiAgDQo+ICsJZHdjLT5ob3N0X3ZidXNfZ2xp
dGNoZXNfcXVpcmsgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGRldiwNCj4gKwkJCQkic25w
cyxob3N0LXZidXMtZ2xpdGNoZXMtcXVpcmsiKTsNCj4gKw0KPiAgCWR3Yy0+bHBtX255ZXRfdGhy
ZXNob2xkID0gbHBtX255ZXRfdGhyZXNob2xkOw0KPiAgCWR3Yy0+dHhfZGVfZW1waGFzaXMgPSB0
eF9kZV9lbXBoYXNpczsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCBlM2VlYTk2NWU1N2JmLi5kZjU0
NGVjNzMwZDIyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBAQCAtMTEzMiw2ICsxMTMyLDcgQEAgc3RydWN0
IGR3YzNfc2NyYXRjaHBhZF9hcnJheSB7DQo+ICAgKgkyCS0gTm8gZGUtZW1waGFzaXMNCj4gICAq
CTMJLSBSZXNlcnZlZA0KPiAgICogQGRpc19tZXRhc3RhYmlsaXR5X3F1aXJrOiBzZXQgdG8gZGlz
YWJsZSBtZXRhc3RhYmlsaXR5IHF1aXJrLg0KPiArICogQGhvc3RfdmJ1c19nbGl0Y2hlc19xdWly
azogc2V0IHRvIGF2b2lkIHZidXMgZ2xpdGNoIGR1cmluZyB4aGNpIHJlc2V0Lg0KPiAgICogQGRp
c19zcGxpdF9xdWlyazogc2V0IHRvIGRpc2FibGUgc3BsaXQgYm91bmRhcnkuDQo+ICAgKiBAd2Fr
ZXVwX2NvbmZpZ3VyZWQ6IHNldCBpZiB0aGUgZGV2aWNlIGlzIGNvbmZpZ3VyZWQgZm9yIHJlbW90
ZSB3YWtldXAuDQo+ICAgKiBAc3VzcGVuZGVkOiBzZXQgdG8gdHJhY2sgc3VzcGVuZCBldmVudCBk
dWUgdG8gVTMvTDIuDQo+IEBAIC0xMzUzLDYgKzEzNTQsNyBAQCBzdHJ1Y3QgZHdjMyB7DQo+ICAJ
dW5zaWduZWQJCXR4X2RlX2VtcGhhc2lzOjI7DQo+ICANCj4gIAl1bnNpZ25lZAkJZGlzX21ldGFz
dGFiaWxpdHlfcXVpcms6MTsNCj4gKwl1bnNpZ25lZAkJaG9zdF92YnVzX2dsaXRjaGVzX3F1aXJr
OjE7DQo+ICANCj4gIAl1bnNpZ25lZAkJZGlzX3NwbGl0X3F1aXJrOjE7DQo+ICAJdW5zaWduZWQJ
CWFzeW5jX2NhbGxiYWNrczoxOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9ob3N0
LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2hvc3QuYw0KPiBpbmRleCA2MWY1N2ZlNWJiNzgzLi5lZTFm
ZmUxNTAwNTYwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2hvc3QuYw0KPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MzL2hvc3QuYw0KPiBAQCAtMTEsNiArMTEsOSBAQA0KPiAgI2luY2x1
ZGUgPGxpbnV4L29mLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+
ICANCj4gKyNpbmNsdWRlICIuLi9ob3N0L3hoY2ktcG9ydC5oIg0KPiArI2luY2x1ZGUgIi4uL2hv
c3QveGhjaS1leHQtY2Fwcy5oIg0KPiArI2luY2x1ZGUgIi4uL2hvc3QveGhjaS1jYXBzLmgiDQo+
ICAjaW5jbHVkZSAiY29yZS5oIg0KPiAgDQo+ICBzdGF0aWMgdm9pZCBkd2MzX2hvc3RfZmlsbF94
aGNpX2lycV9yZXMoc3RydWN0IGR3YzMgKmR3YywNCj4gQEAgLTI4LDYgKzMxLDQ0IEBAIHN0YXRp
YyB2b2lkIGR3YzNfaG9zdF9maWxsX3hoY2lfaXJxX3JlcyhzdHJ1Y3QgZHdjMyAqZHdjLA0KPiAg
CQlkd2MtPnhoY2lfcmVzb3VyY2VzWzFdLm5hbWUgPSBuYW1lOw0KPiAgfQ0KPiAgDQo+ICsjZGVm
aW5lIFhIQ0lfSENTUEFSQU1TMQkJMHg0DQo+ICsjZGVmaW5lIFhIQ0lfUE9SVFNDX0JBU0UJMHg0
MDANCj4gKw0KPiArLyoNCj4gKyAqIGR3YzNfcG93ZXJfb2ZmX2FsbF9yb290aHViX3BvcnRzIC0g
UG93ZXIgb2ZmIGFsbCBSb290IGh1YiBwb3J0cw0KPiArICogQGR3YzM6IFBvaW50ZXIgdG8gb3Vy
IGNvbnRyb2xsZXIgY29udGV4dCBzdHJ1Y3R1cmUNCj4gKyAqLw0KPiArc3RhdGljIHZvaWQgZHdj
M19wb3dlcl9vZmZfYWxsX3Jvb3RodWJfcG9ydHMoc3RydWN0IGR3YzMgKmR3YykNCj4gK3sNCj4g
KwlpbnQgaSwgcG9ydF9udW07DQo+ICsJdTMyIHJlZywgb3BfcmVnc19iYXNlLCBvZmZzZXQ7DQoN
Ck1pbm9yIG5pdDogcGxlYXNlIGhlbHAga2VlcCB0aGUgc2FtZSBzdHlsZSBvZiBkZWNsYXJpbmcg
dmFyaWFibGVzIGluDQpzZXBhcmF0ZSBsaW5lcyBhbmQgcmV2ZXJzZWQgY2hyaXN0bWFzIHRyZWUu
DQoNCj4gKwl2b2lkIF9faW9tZW0gKnhoY2lfcmVnczsNCj4gKw0KPiArCS8qIHhoY2kgcmVncyBp
cyBub3QgbWFwcGVkIHlldCwgZG8gaXQgdGVtcGVyYXJ5IGhlcmUgKi8NCj4gKwlpZiAoZHdjLT54
aGNpX3Jlc291cmNlc1swXS5zdGFydCkgew0KPiArCQl4aGNpX3JlZ3MgPSBpb3JlbWFwKGR3Yy0+
eGhjaV9yZXNvdXJjZXNbMF0uc3RhcnQsIERXQzNfWEhDSV9SRUdTX0VORCk7DQo+ICsJCWlmIChJ
U19FUlIoeGhjaV9yZWdzKSkgew0KPiArCQkJZGV2X2Vycihkd2MtPmRldiwgIkZhaWxlZCB0byBp
b3JlbWFwIHhoY2lfcmVnc1xuIik7DQo+ICsJCQlyZXR1cm47DQo+ICsJCX0NCj4gKw0KPiArCQlv
cF9yZWdzX2Jhc2UgPSBIQ19MRU5HVEgocmVhZGwoeGhjaV9yZWdzKSk7DQo+ICsJCXJlZyA9IHJl
YWRsKHhoY2lfcmVncyArIFhIQ0lfSENTUEFSQU1TMSk7DQo+ICsJCXBvcnRfbnVtID0gSENTX01B
WF9QT1JUUyhyZWcpOw0KPiArDQo+ICsJCWZvciAoaSA9IDE7IGkgPD0gcG9ydF9udW07IGkrKykg
ew0KPiArCQkJb2Zmc2V0ID0gb3BfcmVnc19iYXNlICsgWEhDSV9QT1JUU0NfQkFTRSArIDB4MTAg
KiAoaSAtIDEpOw0KPiArCQkJcmVnID0gcmVhZGwoeGhjaV9yZWdzICsgb2Zmc2V0KTsNCj4gKwkJ
CXJlZyAmPSB+UE9SVF9QT1dFUjsNCj4gKwkJCXdyaXRlbChyZWcsIHhoY2lfcmVncyArIG9mZnNl
dCk7DQo+ICsJCX0NCj4gKw0KPiArCQlpb3VubWFwKHhoY2lfcmVncyk7DQo+ICsJfSBlbHNlIHsN
Cj4gKwkJZGV2X2Vycihkd2MtPmRldiwgInhoY2kgYmFzZSByZWcgaW52YWxpZFxuIik7DQo+ICsJ
fQ0KPiArfQ0KPiArDQoNCk1pbm9yIG5pdDogcGxlYXNlIG1vdmUgdGhpcyBodW5rIG9uIHRvcCBp
bmNsdWRpbmcgdGhlIG5ldyBkZWZpbmUgbWFjcm9zDQppbnN0ZWFkIG9mIHBsYWNpbmcgaW4gdGhl
IG1pZGRsZSBvZiBpcnEgcmVsYXRlZCBmdW5jdGlvbnMuDQoNCj4gIHN0YXRpYyBpbnQgZHdjM19o
b3N0X2dldF9pcnEoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gIAlzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlCSpkd2MzX3BkZXYgPSB0b19wbGF0Zm9ybV9kZXZpY2UoZHdjLT5kZXYpOw0KPiBAQCAt
NjYsNiArMTA3LDEzIEBAIGludCBkd2MzX2hvc3RfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAg
CWludAkJCXJldCwgaXJxOw0KPiAgCWludAkJCXByb3BfaWR4ID0gMDsNCj4gIA0KPiArCS8qDQo+
ICsJICogV2UgaGF2ZSB0byBwb3dlciBvZmYgYWxsIFJvb3QgaHViIHBvcnRzIGltbWVkaWF0ZWx5
IGFmdGVyIERXQzMgc2V0DQo+ICsJICogdG8gaG9zdCBtb2RlIHRvIGF2b2lkIFZCVVMgZ2xpdGNo
IGhhcHBlbiB3aGVuIHhoY2kgZ2V0IHJlc2V0IGxhdGVyLg0KDQpSZXdvcmQgIldlIGhhdmUgdG8g
Li4uIiB0byAiU29tZSBwbGF0Zm9ybXMgbmVlZCB0byAuLi4gIg0KDQo+ICsJICovDQo+ICsJaWYg
KGR3Yy0+aG9zdF92YnVzX2dsaXRjaGVzX3F1aXJrKQ0KPiArCQlkd2MzX3Bvd2VyX29mZl9hbGxf
cm9vdGh1Yl9wb3J0cyhkd2MpOw0KPiArDQo+ICAJaXJxID0gZHdjM19ob3N0X2dldF9pcnEoZHdj
KTsNCj4gIAlpZiAoaXJxIDwgMCkNCj4gIAkJcmV0dXJuIGlycTsNCj4gLS0gDQo+IDIuMzQuMQ0K
PiANCg0KVGhlIHJlc3QgbG9va3MgZmluZSB0byBtZS4NCg0KVGhhbmtzLA0KVGhpbmg=

