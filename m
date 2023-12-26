Return-Path: <linux-kernel+bounces-11399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3199A81E5A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 08:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA431F2271A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 07:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4274C624;
	Tue, 26 Dec 2023 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="M+ALBXwn";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ykidjt/3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Yv90i0Jh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16264C60C;
	Tue, 26 Dec 2023 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BQ4WBu2007336;
	Mon, 25 Dec 2023 23:26:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=45CdZnaRzVewOmIoVAu5mbhMKUqw16RXw2/utIyQWIw=; b=
	M+ALBXwncKWszVNTJqrtXbS0L9OLeSTjy/6binEtOChdDhCd73DEdDSdHdTuTfxx
	4r0zrPMq565nth5HfMU8Dv8aYTYnfVUrMDhXx3Y0luxvtKa0mj53RALT8EI7rFRr
	klIco6+G9YFQJdlPmC1mwXYpf2mMRMgaJ1JQCSq83+AusgDlRz3en9SQLQh5ZqJA
	tWMJT7aSWz14GrOIdwoOfhqXC/04ZMT3yaJc/6dl99VTAh3gREu3D0/Uh/u7RVl/
	oE1MawUwmIj6+freYHkhr+bOYm3FEjtqhdggcb2DcTBpQG8oDixd4Q8+jHrI76zf
	18QdM1kiavtTDhjJHUV7Jw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3v5y2fyfgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 23:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1703575588; bh=45CdZnaRzVewOmIoVAu5mbhMKUqw16RXw2/utIyQWIw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Ykidjt/37vxoS/kLY3uMZLv/qqidZn6CfVDl8acrT4K4AgAXPhskSVUYyZ6x+JpQj
	 gLt06fC9fcw+zW2HpNwdsxHZ/26j/Mt6TaturRM/Mx/PRWlT/zBRKuocGJufWZkIKw
	 bqOdY9u0ovWOqetqEqiLAvXGdq2a7QG2tEpQammYY6uLhRDb541DU/81r7WfXt3zgh
	 e1Ae4UwK7QW/KDFzF7N1Ee754udYA90iZGlrEnuk+rxumVjaQQn9ElqMRHDeAYaQAN
	 XXR8SDTXRqQv+D7l9P542ZYq3qUFGL7P6ssZ9rA9VebntdCgt1GIUHnfgy/xn1I2R8
	 I5vU4lrjfPpmw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E0146401CE;
	Tue, 26 Dec 2023 07:26:27 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 2B531A007F;
	Tue, 26 Dec 2023 07:26:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Yv90i0Jh;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 674A24035B;
	Tue, 26 Dec 2023 07:26:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0hZLgrdvrKrB7yiCUk2ogFXNE2ye8SMy+K8UvkJr5UIZnhZ94iXUj7ZewZodNTosmdVYkNRF1kM6N9iBOWw7L7xJDJb/hPwSl7ayKkYZmlSVLUMeIMZ0mjG5PgD/KF3bMrsyUDpg+/enYHee2UjMMnRYRQNE839ZB+34NAS3gUwB6fkBe8l9yh36gpjREjFu+9x33X3DOB1dtnUvBlfUW9y/XhrWsYhi6F6UYBdnsGt2msOUNW4Y+DpDA6Z6MarSGIkbdqOleF32qeOHd1RGcA9Ul0d43XeuITDWXiA0Jz/FHhJuJkXUNw2s8sEaML0N9z6tbdr5gPnrYD09/1tIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45CdZnaRzVewOmIoVAu5mbhMKUqw16RXw2/utIyQWIw=;
 b=T9aoyofPT3syCEdjyKTEiOVt77YwftVGnAOkk+ccfKesslB9dYdahyIAVU3A0mEz/0s7aiK8L+WNYxEfcOE/3nQmU9tEMKKDZitk6wwIn5ZxM6CRjHf/Lgkymd0oZv0CcTm3wnF81Of5bw+ah38e0lkTTDT1N6qWNzW5frUgJxtI39+07WBRLLskbrwBYxb8ujfnuhjifDeCQx3Zy0k5ZEpR74o/AoDyetjEyZQYmpFrdAM4DONLTrMXAYtxPFwcUPS75APl7BgS2lrHHYp+1EWqnJ+0UhWjk4i0wSaJSFKW36jbyp0p3imT2CWHUcUkuNBr12sQ/9XBCqYJkQePXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45CdZnaRzVewOmIoVAu5mbhMKUqw16RXw2/utIyQWIw=;
 b=Yv90i0JhcGceDKrHge6VpD5KxMPbOROjPjXlXJyJek77M9eE/U7J3avom/t5052VAPhGF++y++Bjm6pLXgoGWsWVkP2fWLlCTLeUU7OY1T/xXZXNZSLNskMBWZdDiSYMzWLlw4gnqrXonAJawNYNX64MDfiaG6ydRmz1bYaZlHU=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 07:26:22 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::94f2:3161:83a2:4680]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::94f2:3161:83a2:4680%3]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 07:26:22 +0000
X-SNPS-Relay: synopsys.com
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: William Wu <william.wu@rock-chips.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frank.wang@rock-chips.com" <frank.wang@rock-chips.com>,
        "jianwei.zheng@rock-chips.com" <jianwei.zheng@rock-chips.com>,
        "yangbin@rock-chips.com" <yangbin@rock-chips.com>
Subject: Re: [PATCH] usb: dwc2: Disable clock gating feature on Rockchip SoCs
Thread-Topic: [PATCH] usb: dwc2: Disable clock gating feature on Rockchip SoCs
Thread-Index: AQHaN8wPS45RpNkoxEKe/3ZB4dOtH7C7Kg2A
Date: Tue, 26 Dec 2023 07:26:22 +0000
Message-ID: <7e6ccec1-2e4d-97c0-8a85-e38bad11f056@synopsys.com>
References: <1703575199-23638-1-git-send-email-william.wu@rock-chips.com>
In-Reply-To: <1703575199-23638-1-git-send-email-william.wu@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3399:EE_|SJ2PR12MB8873:EE_
x-ms-office365-filtering-correlation-id: f1d0bfc9-0683-491c-4842-08dc05e3f613
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mAl5bZ8kvXLvOghJz8IKY1sL9pT7hH9kRt4w0aKxY06EIVAJBs+3KYwVBsm/rjBPcZwKxLzEJtjT9PQAMgGk5o5oBNFKwpF2zPCDXAqJDGB821wEGr1NCmRQP49hM6wqxo27qEcWA38pXMbEG/HwTIpEmqTAaObLJOUIqFSyFwFHXNiq0+hxRiz2jqNMvgpTnBlAhYEu32vrdzxo6ga8dDklKbVFjiNHEkS1kHOJLfFOufetuuBfqJPcU33//K4vQVlWyhJb4/zROcnYrN+sia3fn0FolWBAJQZo9Hx9Z9+m0J+FMFMjaUBMl3GzB9NkkXyqHLxuN0Liuvtfyl3F+5JJa4h7/lRzhIUK3DO3Jx4fPpYZE9kIb5Ql2UySFgl803ytCOkEV6egv1gP8NqfSERhB+Z/dX/Uc4KrO+Y7aljYOXE1LavnAQ2Am7nIUovt4kw8C+mUsMCEp5BFMOoeh0zPmdz44Eu09ddSx9PpENHghJabcUovYMvFSZ9DkEHkmSRe4Xis4U80U2VCsyLLWHgqto1qM32PtqrGFH3CmJEkDDHpXWEbMr3jssL2Yar7EGyXs47ApVbFGO2TVuAenKN4Y4D4gznC3MYuZw4UDoliDWcF4EcgfWKPfTtsEr2AFKSUFoWwPit45071R7stSdaI1MzlNV5OH6zUsmEoKd04+tykOuLz8FdR5Ad409Sm
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(54906003)(110136005)(91956017)(76116006)(66946007)(66476007)(64756008)(66446008)(66556008)(6512007)(6506007)(53546011)(6486002)(478600001)(38070700009)(71200400001)(83380400001)(36756003)(2616005)(26005)(122000001)(31696002)(86362001)(38100700002)(2906002)(5660300002)(31686004)(4744005)(41300700001)(8936002)(8676002)(316002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MXhzK1MvTUh2aUdjVHVERklaM3pobFZUblBkY3dTazZ0eXdVbkJ3YVlJb01J?=
 =?utf-8?B?RWdTWEhXbmNEdU1QMmRJSW9tcDlqZytmU0xtM1F3Q3psaVMwTCtrRHBpaE9v?=
 =?utf-8?B?cElSamxENWM1dER4NVROMzJPVU1TYmdLWUo1cDFLYXFCR1JXQ0laUjUyVVls?=
 =?utf-8?B?MHJkSjhsbFVzSDZXMkNlNGVlVTJZVlZrMHQwSEJWQzByNlNTZk1yMEhwVzVo?=
 =?utf-8?B?OXRuMGVGUzJsNDh2VnRRcXU2RFZscTEyMUNlcTlYUWhuZW85cmp4djMxRWly?=
 =?utf-8?B?Qyt0dDVtMWVlOVl2MlVDUnp3VGN2MVBuZEFZTmdpMUdWYXNZSmtPSld1R0ZR?=
 =?utf-8?B?VzBzaE1sYWVyOFc4Z0x6aEJaSko3ZlhnclU0TlVzbEQ1UlVVdkJlcEZvQjBW?=
 =?utf-8?B?Nm5WSmFXdHNDNzUvTW1aSjZROFhtRllPeUpFRlZKQzlwVFBxSWljWkhEVThw?=
 =?utf-8?B?NHkyN2UvR0RqTUtHdWM5R0d4bnUySTJUMnJmY0p5b09sRWszUVcyREpFYWdm?=
 =?utf-8?B?WE1VYzRYd0dHYzRpWG5BTE03RTJuNGNZOWxEUDNDOVRycXpXLzNpeGpsVmFM?=
 =?utf-8?B?MTE2bU5NZTJIWTdCeWNCcFQwR2s5dk9yN2hqRnlpY0sxWXZueXBBVHM3MFli?=
 =?utf-8?B?ams0Z0lGWE1UMElaS0NsQXhodkkveTAyaXdTbzB5VXF0QjFMc3VDK3hlNDZt?=
 =?utf-8?B?MHlILzJQUzd4UGJCaWdmUWRFbjJPTDhBTEtDZHNReEN5QlBjMmdoTjFhMzBs?=
 =?utf-8?B?WUJDbm45U2Q3MlAvMld0aUllM0xLd2VUWlJRUUZMR1RrMmxLM3I3dC9Temxs?=
 =?utf-8?B?SFdUZEpjRmt6RzlwNnR6TDdYc1JYRUd1ekNCUTNTYmZwUkRoQklnNUhmT1JH?=
 =?utf-8?B?SUh1dDMxRUNIeGdENE9VaUdqV3NiTU9rRjNDTXhoSlhIOEoyWFdiY1N4ekZ1?=
 =?utf-8?B?MDFBbFNZWGp4WVZLdHdWZ1ZnR29tMHBncW9SbEVoM1FNZ0FUZHhaNm5id0Z5?=
 =?utf-8?B?bWlWRktXQTY1Y0N6NGdqNXBONVhVTzFkOFQzcFlpV0lPL216ZEZJV1ZsSXdP?=
 =?utf-8?B?QTVjQ3hWVW0yeXFPdmdqNk1Zdjl1UXFRSFRhb3pnWHk5N3BKWmZDaTVXeUkx?=
 =?utf-8?B?UytOQ3A4d3JGVzZ2aVl3d3k5a3Ftc2J0OHVzdTF5OEV5UUFzajY1d1RJbk42?=
 =?utf-8?B?WUE0a0xXS1d3ZFhPY3NISkIyZmJHSWczcnAyRTZ1LzlSb1UreFpRaVhKOEZQ?=
 =?utf-8?B?dVh0NUtDNVp2dUh0SkxVOXYyM1IxbHc5Y29lYkh4cHpOOG4ya0ZKNUhtU1RV?=
 =?utf-8?B?THQrNCs5bTFGK2FPZGZqdGU1ZEtWS2FMUnkxbytYRllCbDU3blhWMzVNMzhu?=
 =?utf-8?B?Qlp6YnRXc05YVVRnWi8zd2l1KzlCQVExVmMvRTlxckZBc0oxT1hFSEdxNFNV?=
 =?utf-8?B?eUl1MWlqb21jWEJQQnppOE5BdHNBVHZsbHRSL2FrMFdXbm11dGtEOGN4dnFW?=
 =?utf-8?B?a05rVHVZbXJNNVpmTzFEZ1ljaGJkdWs1TWJBUzBSQnZkMDZjWkVMMXl0bzdz?=
 =?utf-8?B?YkZBcjlSMkhBTDJiS3RkcEpiU0hiazdtamFMQ05ZdXlZcFdsc2tlNlFNbGhv?=
 =?utf-8?B?WHNCVWRKaEszS094RkMwUmt5cEJjMUxGa3hYeXYyTEJPVGFFR1FBeVRUcHRI?=
 =?utf-8?B?QVRzQUNXUWluRVpkWEJHb0FoUG1ESDliOHQ2eTRyeC92K2ZSdVZBYnlJdnhq?=
 =?utf-8?B?MVRjSEZrTFJBcDFvR1hXYStGUW02UjFqZWpROGZUQ1JPb3QvWDdBdjRPMHdv?=
 =?utf-8?B?ZlVBWWoydnNYQUJvNUM4Ry9ENXdLcjdvV2lrcnZsMVU1UWcvVUY3K3hIVzR4?=
 =?utf-8?B?WkJPNFJwWEU0TnpOWjhUZUtGTWJYcW1wU1E2RmJoQzBtSFFocjE5N2puMjZ0?=
 =?utf-8?B?cDZsdTd5ZzFpRmJNQWIwdCtVR1BwSkRZYlJEb2luOUNjekZjRWFhQzFRaVhT?=
 =?utf-8?B?NUhJV1hNcVI0NGlzUDgvZ3lBSWlDNncxT0pVYUlRL0x1U0lXVm4xK0N4S3Ay?=
 =?utf-8?B?cjhKY09jK0RyK0R5YUxHMEtTT2tNVzVNVW44UGxiOTZKWFBqd1NkeGhsUUQ2?=
 =?utf-8?Q?TEJGV1d8/Qxr2vu0D/4RCbNZh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7FA50EBE664114994B5A23AF3195A27@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Pfb27TvzlLPmZd+/c6aCNpiTwBiKzZ4GV0ZKeBtWdOeV9RAiDWrNHFyCTG74yzDSFhcudFiWSWKUHjgvi6aYhASganagTKRUG+ziSkahJvAXkv94G9rZW7qjrCQ000q4Cm1l/TPo+s5at9ZM2HUIHc7RC+kheK9OVite9RPnOQMl/Txt5Qyb86yQS+2y77S/ZtR08aehxNyfH1T8KyA0Yl99cUEGMSRwcet7n3dyYqrd1CT4ZRwy3ChGNssPU7qFjhIJEw5CubNf25SLniJmZjEjr+UaAMjnAVSjHLnOxK19ImNoGLFj8w0h5rMArZMoj4Lp7GQklmA/XoXP7s73pRhU4wGPC4fIrhRib+c5tMUs/OuTkJ70EwpIMME02c3YnAvQTL8IxbfqfEL+9k6vf+8SX0R5dbcZ/mFvHCUydlkpBH21u6vO5e2LRnCnB3CfPcFBeEHBHPS6foQp0Pi90oT59iwUlE5EKmgLUPZ+w5kyxTIJYQ76pTwlJAOedUR4wk5kKx+BvZj8V6qAXv9M9okp7eXeH0WodB2X0a3EPrsA4LBxrHP6LUrwZ+CoxobqvQ43Sub1wFoC8It72CbIhh7ppVinGO1MAFrkPcpDykoPMuTzsalfMWl96hOsGLL19NduDvrjuRPvjvwwvwrVcg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d0bfc9-0683-491c-4842-08dc05e3f613
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2023 07:26:22.3749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2igVL6zGUVTl+cFNDaKdulnyykTOTo3OwcXTNGA5KuZ27iLv/nsC+Y/H9HwsSDSkwW44bYXFXsbxZiI1Tvv3ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873
X-Proofpoint-GUID: LbMCNoPB28qwoCc8q8X-Jq8NRvJkWCG3
X-Proofpoint-ORIG-GUID: LbMCNoPB28qwoCc8q8X-Jq8NRvJkWCG3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 bulkscore=0
 mlxlogscore=789 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312260053

SGksDQoNCk9uIDEyLzI2LzIzIDExOjE5LCBXaWxsaWFtIFd1IHdyb3RlOg0KPiBUaGUgRFdDMiBJ
UCBvbiB0aGUgUm9ja2NoaXAgU29DcyBkb2Vzbid0IHN1cHBvcnQgY2xvY2sgZ2F0aW5nLg0KPiBX
aGVuIGEgY2xvY2sgZ2F0aW5nIGlzIGVuYWJsZWQsIHN5c3RlbSBoYW5ncy4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFdpbGxpYW0gV3UgPHdpbGxpYW0ud3VAcm9jay1jaGlwcy5jb20+DQoNCkFja2Vk
LWJ5OiBNaW5hcyBIYXJ1dHl1bnlhbiA8aG1pbmFzQHN5bm9wc3lzLmNvbT4NCg0KPiAtLS0NCj4g
ICBkcml2ZXJzL3VzYi9kd2MyL3BhcmFtcy5jIHwgMSArDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9wYXJhbXMu
YyBiL2RyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMNCj4gaW5kZXggZmIwMzE2Mi4uZWI2NzdjMyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9wYXJhbXMuYw0KPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MyL3BhcmFtcy5jDQo+IEBAIC0xMzAsNiArMTMwLDcgQEAgc3RhdGljIHZvaWQgZHdj
Ml9zZXRfcmtfcGFyYW1zKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykNCj4gICAJcC0+bHBtX2Ns
b2NrX2dhdGluZyA9IGZhbHNlOw0KPiAgIAlwLT5iZXNsID0gZmFsc2U7DQo+ICAgCXAtPmhpcmRf
dGhyZXNob2xkX2VuID0gZmFsc2U7DQo+ICsJcC0+bm9fY2xvY2tfZ2F0aW5nID0gdHJ1ZTsNCj4g
ICB9DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgZHdjMl9zZXRfbHRxX3BhcmFtcyhzdHJ1Y3QgZHdj
Ml9oc290ZyAqaHNvdGcp

