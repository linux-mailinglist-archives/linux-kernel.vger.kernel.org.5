Return-Path: <linux-kernel+bounces-30703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1781832347
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD991F21239
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77646138F;
	Fri, 19 Jan 2024 02:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="rFfl3rtP";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="k7CL1EYi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cNA3Z/y8"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CD910E4;
	Fri, 19 Jan 2024 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705630553; cv=fail; b=I2TlW0XxiUo3nyslY2GXrng1qz1Gtqbe24lz5ADqAjtWoVI/wNqJ1GZnkU4XlQS35eQtu5snG7HHgyjfrEzdUmeKF+xoesTVNe+pLGEXkPjbYCiaHuPcDTO6x9ml6u2ICi0WDMgTJ/QtYRPloTU/dnRL7ne2PsooFYVobUqFDUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705630553; c=relaxed/simple;
	bh=Cgf1BK3sORjHHbjB+Nf33w3Mloir+9rw+2kw+XgX/U4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sP9w5Mez4heGrZs47PfgF+7fb04kCIU+uNu9srJevUVc3LBpntxzlKV4llWuYWOcyPS8T7rgi9ocw6Bo6LMjA9uMn6IEpeD3VGherHXf4oyMY1ZwQoUGHjqhQKbPONfOyvEdPdFvn7WVXfve51BYDoX89B13GsZ/kTAxGIw/kiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=rFfl3rtP; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=k7CL1EYi; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cNA3Z/y8 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J27AKb002303;
	Thu, 18 Jan 2024 18:15:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=Cgf1BK3sORjHHbjB+Nf33w3Mloir+9rw+2kw+XgX/U4=; b=
	rFfl3rtPSjN5vC6Z4memZ3ywUbAxRnjHyvbwaicuCLw/29ylMpwQaBZV47jsiVmH
	O4QoNUECznlNU51KaUdv8L0L8oVY3eGtcVGfSqP3dGPZbxqNf80B0nsE8faImPkp
	6GafQaMTTTCcJErYVhTRd8o/EWCoc0bR1YaPjnKZcfgH+x3XrlUsH5vc66ZkMMV/
	QozIkvjywc3Jqzx1HnyZYXAuQ9OGik0qsS8ygKeqltCP0CanyZZ1VTqK0KTEof1f
	Xr6qZx3FAVh7o5aRY81LCqlulzytYSCcaVVuH1XGGg0uXhJ1S3C8EIQSdAQ0wQIs
	O+4B04g9iRgwGzHN+2xQ3Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3vktdnuccd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 18:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1705630533; bh=Cgf1BK3sORjHHbjB+Nf33w3Mloir+9rw+2kw+XgX/U4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=k7CL1EYixdb5iKA4O9nT+GyNWi7PuaeHQMueQ1jydVpqeeuUMTAxLhAsI7xTnY/Us
	 XBJxaDLBhSiyu2ZYLLuWczXMAjURd4W8hmNWUEabfiWcz1a+J9RWiX3njvCBLv3Lrs
	 rdg3IP+GxIIbu0Kx+63d5n8skjybBaRPGfeasL1LYW7ojcjj6C1Qm9HE+ejdwDmlMf
	 fbiTmSRoUaFykAZuSk2C9LEjzqmKl8D2x6hVnXQNDlZ5K7homSH+hidSK4kTZDmzwf
	 mgwBLPeKRY95xOi5thIW4HYExzK2lQ4i69IQUfBp1MRQ9n2gxNU8ZOTkbs5t4yz2/M
	 P0rPYXBb2tdRw==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5C87B4041D;
	Fri, 19 Jan 2024 02:15:33 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 792E9A0259;
	Fri, 19 Jan 2024 02:15:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=cNA3Z/y8;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9D44B400A2;
	Fri, 19 Jan 2024 02:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MT6ZtLSlmTg3V7Cf5rXeJXkwHcalyAlWxVMVcvMYMO5MRiRrk+gwrf6FsMhmnyAGVuuCY1vL1daj2+7y9VPMh7q+fb6R6QYxrus0X8Jatu8tA6xVuOQNvMD8+ZsojnG08L1pWM5m8h7e7UFa6xVZQw0JfuB7HnxvVgMhE+HEVaME8h4L4K/5gtK/08RNVCk516uK/m18L8QMO1qUBABoZg3dQP4EELtXMClFXClqo6/O0n3DZ3uiptzyHqa7px8USjgqt7QYxYx2xLoSt7Y3y8ycuCxf08rCilXEddctPMN40R3X0gbeddHkOuzvkKi0F8ZrjwszxbYOpbFnV4zRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cgf1BK3sORjHHbjB+Nf33w3Mloir+9rw+2kw+XgX/U4=;
 b=Ef0+EAZ6EfkVbdSrAiUoXHX1VY4dFByvncuSEg8VtsV7wvUa58qj4FEvQvjiR0hxR3wNNex/qspG5Q9hXZ8lL4kNZ5p2OzsMjB71BJcU6HZF90BOjYJAKVlUSE7WlcCnRGGXXq8wZA+bkEGv9Pshm6p+ZOkxcZkMVy+QrkA2Y04GxCsJVa4fzgZai9iTiCmpa9aZUVpYaI11/urrCuae2GjW2f/BIfv5po///O+x7esHMYrrRcQFyy10qxwuXW0VZjLqAN4+6i1SibAI5UGMLDF2HJGAKQzDggsthHRyr+XOxc+fnBp/zDMyYWivIZw5b2Q71YQXwewSNi/NRXRAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cgf1BK3sORjHHbjB+Nf33w3Mloir+9rw+2kw+XgX/U4=;
 b=cNA3Z/y8S3dTOIeZ5Wx2yV7w/5jO3+HzIu6ERy3aHC0v+Lzo9yoBVoJpx/342Nf2ReCD8m6dhrGsIy2dVGfNkj+QkP42Dyp9eCgWFSOsgoF4/9g4Oj9J31YjPCD0tChooV2m83BrX+8jcZstpkK/De0L/HppoA7/SYkVuRbXIdU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 02:15:26 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 02:15:26 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        Kuen-Han Tsai <khtsai@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Mehta, Piyush" <piyush.mehta@amd.com>,
        "Paladugu,  Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>
Subject: Re: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
Thread-Topic: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
Thread-Index: 
 AQHaDVvtK46auOuFqk6xUT0xKW8RPLBm7bwAgAlqnQCADGtvAIABEQcAgAAcwACAVT6ZgIANr9MA
Date: Fri, 19 Jan 2024 02:15:26 +0000
Message-ID: <20240119021520.757vpt3oeig4hws2@synopsys.com>
References: <80a05f4a-eaae-4db1-9604-c5eed9ff594c@ideasonboard.com>
 <20231108114848.794045-1-khtsai@google.com>
 <d040f84a-b55e-4b1d-85c1-b6cec6554198@ideasonboard.com>
 <20231117014538.ro6bo2ho2jgl7l6s@synopsys.com>
 <20231117032832.6k4msq2vlp56asho@synopsys.com>
 <MN0PR12MB59538FF4FF9C753EB9264E21B7692@MN0PR12MB5953.namprd12.prod.outlook.com>
In-Reply-To: 
 <MN0PR12MB59538FF4FF9C753EB9264E21B7692@MN0PR12MB5953.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB7980:EE_
x-ms-office365-filtering-correlation-id: 13bde520-7e2f-4b78-5877-08dc1894800c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Y/ky8ufKXKhdUG6akYIeIWfwiOQ+v+DW3cEP85qQJjHWijjFWhYNTA1ZVWZMMb4JzJgiWulLMAyfRcVCI3rW0r/+RJq9aAr6cQPaXnI/SJNpagh12PrVLC2KzcreBS/1OZL3Mo3lMrCbqpEqViuVE7VvBXVzT4mXtzj9PCdLvVRUYT9JFhbxwqqLwGg3DcnmdbO0EKINcgitiMeJ5pLxOhHe7QpLlV30LmwAEkOWiU16ywtwFBkfgwWlKJjCDGT3xS9q7m6+E3FLaZhcReiBE+VD46yrUm1D0RTAqa4z2iw1uuleYuoc6HFSJ9jlaZBABQvO2ZJOB9m1LIZo6S30qYlv21uuUuaWNWw76vpjJ2Xu9jWKFJkoEiqmLyVDU97XaAOSR5Uhdot+vbwymGvTfW4OUJsgqkPQYvrZCwQwz0COr9zMKJ92zZ+njATBoLqjHZ9hqyNEAZIax2nMiyh6YpcpHwpCqGwCd9wjtxTZXNuo9Khz9F/8SYyTY2Rxhaws15deW6rGXKT21eEclpLo4N3CB2Q7FX9H5lazGJzLj/xFUy6WrHSlQ3atwKDuWF8z4sB4qz84I+B5WXAdWPVIbc/+K5RBLjytg7gXfkQqvWHHqty1HsGJiieFBC3myjGN
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(478600001)(1076003)(6486002)(6506007)(2616005)(6512007)(71200400001)(316002)(76116006)(66476007)(66946007)(66446008)(66556008)(54906003)(83380400001)(64756008)(6916009)(91956017)(41300700001)(5660300002)(38100700002)(4326008)(122000001)(7416002)(8676002)(8936002)(86362001)(38070700009)(2906002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?M0RkMElYTGhIRmxXSGlEdWh1MERLNjBOTFMrSkJzTFRpT0hCVkl4L2JNanJM?=
 =?utf-8?B?Sy8xK2Y2Ui9rL29SVlVkTlZCb1daZHdPT3RjR2hLaFhCUHhIRjdsZHY2c0t6?=
 =?utf-8?B?WWU3UHA1bVlCdlpDWGtUMVVZSm0wMkZRRVlhRzhIUWY5VU9LM082NXZ0TEFM?=
 =?utf-8?B?eDdkc2UrU0xDYzZkcUZKdnBFb0l3eVE0c1l0aGowL0txcm9iR1ZPZy9odWt3?=
 =?utf-8?B?K3NuYU10WmQ5N2RHa2VXRS9MZlA4R25jdmx1bm9oN1MxWStnY0pRdGJpbkwv?=
 =?utf-8?B?RmFTSFVNelhjVm1DZEpDSDNoY1NhanYybzJVcjU5Z1pyZ3RvVnlUSTFDR3F1?=
 =?utf-8?B?QWJrZnBSMy9TRGRDSlVhTU1EU01QZ21PS2JBbWZMdm9tcGxldlJpZDhMK1gv?=
 =?utf-8?B?b3BvVlUyTFhETmVOdjBBZGhZcVdUWmJnbFFsSGIxMGNXL1JOZWEvbGwyTkkz?=
 =?utf-8?B?WnRpT1VzQm1sTElsYUg0cWhSZjhZNkdTMUVPTEsxVWE5VUdybUxGR25JWW43?=
 =?utf-8?B?UTI3bVhBeEZnMjd1d3lQSGFLWlFEWC82QnFVNlNZUSs4bERQbnprYzZjcjN5?=
 =?utf-8?B?VjU5U0w1WVZYWEI2QWhETDczZ1lxei9rSDRRMnJMS1FGbkV0TWU2UFpUTEIw?=
 =?utf-8?B?c1hkMVc2MEUvRWRuTGRGU282RERMNWU2STlUaXRML3RYV0lHT21MSENrNUgw?=
 =?utf-8?B?MkpXd0xSSjRFNEozZHNrOUpIV1BoL3liWjhBbkNPMzZxM2Y0b3pEd2FuQjdF?=
 =?utf-8?B?b3pvU3VVeGdVUTc4RTk4REdPbGNkTEx2RDVXYi93NXNyalVIWjkzZXBod21I?=
 =?utf-8?B?cHhHMENJL1hLUUl3dzZabEJTYkplU21JRUhiaGtKNEI1SmNEeC8ycEQ1T0ZM?=
 =?utf-8?B?aC9NeXhHYitVVjZKOGxBVEREV3pOdHNQT0ZsMy9QdUhveW1Ga1pudG9manB1?=
 =?utf-8?B?OTVRVm51UU1kelVxdGE5M0E1TWMxcis3SmkzZTRSUlBNem5lTGsyMEt1L0lB?=
 =?utf-8?B?ZDc0bjhDSit1eGw2WTV5RHA5SFlEbUY2UFlqc1Zkei84TnRnSDJyK09HOGh4?=
 =?utf-8?B?dUEzcS85clh5SVBrZ2pjSXU0VUZOVU9EVkNCWTVzNitGTkgyWkZ4K21WM0R2?=
 =?utf-8?B?RXA1T0piRUhicFZOOGtERlFFMlNLNjdLQTRwQU1kYzRoS3hPNHhndlc0Uzhv?=
 =?utf-8?B?bDFZM1l5cUNjU3d1dXVwTWZENmg4cmcrQms4VEpvN29DRGwvVHc0NVNlQSsz?=
 =?utf-8?B?YldwVUNjaXlNQ1pycWk3YzdhVVg1SW5VWE5EODF0NEVNT2hBZ2xpL2JVbk5K?=
 =?utf-8?B?cWl2K2xCL3kwWVlzNXk2VHFtcmRJYmR4VEpOUDlHQVBSSkNYei9xSFNPaC9Z?=
 =?utf-8?B?T1JHemJQd25zWnhqNHdvdXYxU3FlME55TThRQUhjdEpXSW83WDVrN2hTUGV1?=
 =?utf-8?B?RmJ4VVhTSDhBb0dZNnpLTWMyMkdIWCtiMVhYYWpsenR1RVJ4SjZ1cGI3ZWNl?=
 =?utf-8?B?RkplUzZEZWMzRWZDUXZTNVVnTW5tUkx2WjNGcFEraWlSVEVqZU5Kb3pLaHJj?=
 =?utf-8?B?TGhJaGJ0NGZ4WnFEWnUybTRsVzRvd1hOdDUrMndTZ29SN0Fwa2pKVXgyZEs3?=
 =?utf-8?B?WjA1Q0g3K3AvcEVNM2lzOXhSc0FWMVBqbkcxOVFMZTNkOEZHbHRoR3dPbCs3?=
 =?utf-8?B?VUd5TjBwRGdNc0tPQnhwZTY3ZkhXYW5oWWFXY2YyakMyWkVWYkY0Z24vTFho?=
 =?utf-8?B?Rk4xK0dRV0N5UTNBSmk2V0JyQzRnYjNBRTNqZkUzYkdjUk1DYitYRGY0NmY4?=
 =?utf-8?B?ZUVGM3pwRFpTcDgzdUJienUxclBjdE0rOEEyN2pBTHQ1NkJZMEJucFZWdDhw?=
 =?utf-8?B?TEVvZTFreStvQnE0U3BNNjZXcXpORzVwcFZSaExoaml6TEt1dWYyTHd2bldv?=
 =?utf-8?B?QjVOaUJHYS94S1hBWUdJaURzVXAzdFBrcFVzQnc0WVNDS0pQNU04Z01uMFNh?=
 =?utf-8?B?YTlRZm5SQU1wRjJyRXU5YlppZ3MxMkRab0pRQ2pFNS9IRGkyb2FxS05RMkU0?=
 =?utf-8?B?eVNja1JYQmRBa0JnaGlMR2t4UnVHbitqWWpGYVQ5d2dRc0tSZ0dxNG1SUmJt?=
 =?utf-8?Q?rFrxPtTiGzENM+k+ZwbKqtui7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E0FF4B55CD09E4E878F3A830522AD3B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	c4e89iOUHRt1WlQRJDlhhbwR0/P1TpsH1rd6P5fYCAVXfxi64e4+Pa3rhs0RDqLRjX30yaJAWG0AT+jAGlqcMmFxJi/i8WWOU3EhfxS3RNjfZ89GZyMFYN7wAEcF6/WpU9Su33jilnV+mffktWWREeYDSqCl3BfpY0dEqNRkHfMOy+zuHJuMVqh1I5y8uhnY9+0Pq0olu8jN6pHKjH52KEFekf5EF+w++S6B/GDUFxZLfaIlUxu2ff3D/Xe8RINyyOJ2La0ci7jFE9f/r0HtN9cmmr7JC60PVjA2bQ2nQ0VlznQAlOksRpPWYDJCwgQro+0eSPaHp8C1ldmhC45EZaBbA2bgWaCVGV0wAp7hTq9+HgQP2DOFpkGMLeeGj0YBQD++/7GXowD6sFHnnb9EanE9SelAfg9UzI1anqaU2veRzMxS8+KM3yFWZFIvb+NR2nCrqFz8Y8FlxJuBSoBAmHx1m2QGi0/VXitQTc73LbtFShKfh6M8iFoBvEtUBjzlWMVmCVInUCgRS0Z0WPa5bc100++rX/bqtg8UJvNgeHEfQOjMAeEXvubHEZt9YZ+WOJdtvDoBxT8TYnN+v0BkTxykIpa5Ukx5y1/wDvfzV9IttjiP+b2g3H2ULaPGpHEKE/VuFk6N1INjkpnDNlP/2w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bde520-7e2f-4b78-5877-08dc1894800c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 02:15:26.2255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ky4lP1syFQvYYTRO619vX3E5QIdUeyL4f7/9VusbmGWlp+/KuKFWNhuxDlZOkKBRckBIqm9VdU7lx99LWg/T6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980
X-Proofpoint-GUID: pPelj5fMX0C2RxG5d5tQTbHlLYwWGqWj
X-Proofpoint-ORIG-GUID: pPelj5fMX0C2RxG5d5tQTbHlLYwWGqWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=744 spamscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401190009

SGksDQoNCk9uIFdlZCwgSmFuIDEwLCAyMDI0LCBQYW5kZXksIFJhZGhleSBTaHlhbSB3cm90ZToN
Cj4gDQo+IFRoYW5rcywgVGhpbmguIEkgY2FtZSBhY3Jvc3MgdGhpcyB0aHJlYWQgYW5kIHdhbnRl
ZCB0byBjaGVjayBpZiB5b3UgDQo+IGhhdmUgc29tZSBmaXggcmVhZHk/DQoNCldvdWxkIHlvdSBt
aW5kIHRlc3QgdGhpcyBjaGFuZ2UgdG8gc2VlIGlmIGl0IGZpeGVzIHRoZSBpc3N1ZToNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jDQppbmRleCA4ZDE4ODFhZGNkODAuLmY0MGM3YjkxMDVjYyAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCisrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMN
CkBAIC0xODA4LDYgKzE4MDgsNyBAQCBzdGF0aWMgaW50IGR3YzNfcHJlcGFyZV90cmJzKHN0cnVj
dCBkd2MzX2VwICpkZXApDQogCXJldHVybiByZXQ7DQogfQ0KIA0KK3N0YXRpYyB2b2lkIGR3YzNf
Z2FkZ2V0X2VwX3NraXBfdHJicyhzdHJ1Y3QgZHdjM19lcCAqZGVwLCBzdHJ1Y3QgZHdjM19yZXF1
ZXN0ICpyZXEpOw0KIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY2FuY2VsbGVk
X3JlcXVlc3RzKHN0cnVjdCBkd2MzX2VwICpkZXApOw0KIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0
X3Jlc3RvcmVfcmVxdWVzdHMoc3RydWN0IGR3YzNfZXAgKmRlcCk7DQogDQpAQCAtMTg3NCw5ICsx
ODc1LDI3IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKHN0cnVjdCBk
d2MzX2VwICpkZXApDQogCQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocmVxLCB0bXAsICZkZXAt
PnN0YXJ0ZWRfbGlzdCwgbGlzdCkNCiAJCQlkd2MzX2dhZGdldF9tb3ZlX2NhbmNlbGxlZF9yZXF1
ZXN0KHJlcSwgRFdDM19SRVFVRVNUX1NUQVRVU19ERVFVRVVFRCk7DQogDQotCQkvKiBJZiBlcCBp
c24ndCBzdGFydGVkLCB0aGVuIHRoZXJlJ3Mgbm8gZW5kIHRyYW5zZmVyIHBlbmRpbmcgKi8NCi0J
CWlmICghKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5HKSkNCi0JCQlk
d2MzX2dhZGdldF9lcF9jbGVhbnVwX2NhbmNlbGxlZF9yZXF1ZXN0cyhkZXApOw0KKwkJaWYgKChk
ZXAtPmZsYWdzICYgRFdDM19FUF9ERUxBWV9TVEFSVCkgfHwNCisJCSAgICAoZGVwLT5mbGFncyAm
IERXQzNfRVBfV0FJVF9UUkFOU0ZFUl9DT01QTEVURSkgfHwNCisJCSAgICAoZGVwLT5mbGFncyAm
IERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRCkpIHsNCisJCQkvKiBJZiBlcCBpc24ndCBzdGFydGVk
LCB0aGVuIHRoZXJlJ3Mgbm8gZW5kIHRyYW5zZmVyIHBlbmRpbmcgKi8NCisJCQlpZiAoIShkZXAt
PmZsYWdzICYgRFdDM19FUF9FTkRfVFJBTlNGRVJfUEVORElORykpDQorCQkJCWR3YzNfZ2FkZ2V0
X2VwX2NsZWFudXBfY2FuY2VsbGVkX3JlcXVlc3RzKGRlcCk7DQorCQl9IGVsc2Ugew0KKwkJCS8q
DQorCQkJICogVG8gYmUgaW4gdGhpcyBjb25kaXRpb24gbWVhbnMgdXNiX2VwX3F1ZXVlKCkgaXNu
J3QNCisJCQkgKiBjb21wbGV0ZWQgeWV0LiBTaW5jZSB0aGUgY29udHJvbGxlciBoYXNuJ3Qgb3du
ZWQgdGhlDQorCQkJICogcmVxdWVzdHMgeWV0LCBkb24ndCBnaXZlIGJhY2sgdGhlIHJlcXVlc3Rz
IG9uIGZhaWxlZA0KKwkJCSAqIHVzYl9lcF9xdWV1ZS4gU2ltcGx5IHJlbW92ZSB0aGVtIGZyb20g
dGhlIGVuZHBvaW50J3MNCisJCQkgKiBsaXN0Lg0KKwkJCSAqLw0KKwkJCXdoaWxlICghbGlzdF9l
bXB0eSgmZGVwLT5jYW5jZWxsZWRfbGlzdCkpIHsNCisJCQkJcmVxID0gbmV4dF9yZXF1ZXN0KCZk
ZXAtPmNhbmNlbGxlZF9saXN0KTsNCisJCQkJZHdjM19nYWRnZXRfZXBfc2tpcF90cmJzKGRlcCwg
cmVxKTsNCisJCQkJZHdjM19nYWRnZXRfZGVsX2FuZF91bm1hcF9yZXF1ZXN0KGRlcCwgcmVxLCAt
RUlOUFJPR1JFU1MpOw0KKwkJCQlyZXEtPnN0YXR1cyA9IERXQzNfUkVRVUVTVF9TVEFUVVNfQ09N
UExFVEVEOw0KKwkJCX0NCisJCX0NCiANCiAJCXJldHVybiByZXQ7DQogCX0NCg0KQlRXLCB3aGF0
IHdhcyB0aGUgZXJyb3IgY29kZSByZXR1cm5lZCBmcm9tIHVzYl9lcF9xdWV1ZSgpPyBJcyBpdA0K
LUVUSU1FRE9VVD8NCg0KVGhhbmtzLA0KVGhpbmg=

