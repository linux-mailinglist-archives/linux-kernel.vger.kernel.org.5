Return-Path: <linux-kernel+bounces-14558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBE4821EAD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C361F22F6C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4713514267;
	Tue,  2 Jan 2024 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="f/vIuws4";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="f/vIuws4";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="f/vIuws4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2112.outbound.protection.outlook.com [40.107.24.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DE61428C;
	Tue,  2 Jan 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=TzldVkRB/Mb9vwilYdzkzWPgHESK/tBM5kdnUJjdFT2QX5mr4Vb7OOznq0UrR5/96fcseuiO4B5dyDVawgpAqx9g5uXh5bcaGV+XXdKxx3+3ZmLw3NS6OxAzw7xNj6/IZ3QdD7QGcEZB3/4P8s0/MMRG8E3l2HdjwJLDdJYrMELAhLirxhx4fyUNONGq/5Y9mpg95ncfrwuTb+1K3+SLZwCW3XLzI5wwLcaStkhiD2QiO3aeCE7LXZtOf4L0GVFFbHL8FLqOsFdduOT6ubBJYvEJa7tTy6xOV4+Wf4tvbdoFsOCFcAQuJA76TvDRUn7X57a0IlKXAsyDLRmOMPoY1Q==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qG8g2qODrjtXNBEUiXygG98F2G8M+/qXuI6MnhFhN2Y=;
 b=BXHL8UMrssRF5WfC2HcQZLDfy9VFhzBAgPpLavtXWciO8u+isXhG95t3eSJAr+S0CEaKXLzmrxd8SfLZvNff96JIg85IwzhNNlHh3QJaQjEHqsMyoz+bdX/3WoRJz32x0YcMqq8yV92X3MrQW6AVlDIYqQi7ggnBoGiIqktWl2KIYHG7g8P5g8XaJkwQHpTYT3CdXRl3z989PoLh9KeZc5HFXbmBUlW7yGCM18G476IhzGKtyvQbaU3/zAQRvCt1JpttVUG1YvzlOOafOaAXGQASJWNyan4kpGMcKiOCqF8QIYe2SqwIa+bP3gPDjKJHmkFXQHfvLV82Qly4fKbKMw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=pass (sender ip is
 194.38.86.34) smtp.rcpttodomain=davemloft.net smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; dkim=pass (signature
 was verified) header.d=duagon.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,2,smtp.mailfrom=duagon.com] dkim=[1,2,header.d=duagon.com]
 dmarc=[1,2,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG8g2qODrjtXNBEUiXygG98F2G8M+/qXuI6MnhFhN2Y=;
 b=f/vIuws4k29JVklDFb3LcGfcCcNxFLYsfjDExHB++mGDvbI2RHIXbWFZUBsXZaYVMgoKPeoMS2TnjvFQITFybtjmxsDrZBxtBsvNiLSSIf4+e/fpeiKNY6lUnTlgk+uvTgWVBo5eAl3f81WYoXvExXoF7XYA88p46BNIpxZJKk0=
Received: from AS9P194CA0012.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::31)
 by ZR2P278MB1163.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 15:27:36 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:20b:46d:cafe::5e) by AS9P194CA0012.outlook.office365.com
 (2603:10a6:20b:46d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 15:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 15:27:34 +0000
Received: from securemail (localhost [127.0.0.1])
	by securemail.duagon.com (Postfix) with SMTP id 4T4Gtt2S9mzxpD;
	Tue,  2 Jan 2024 16:27:34 +0100 (CET)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securemail.duagon.com (Postfix) with ESMTPS;
	Tue,  2 Jan 2024 16:27:34 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=A+CnCEfvuIgDJ/oCcuoMG5soZP8XAAtyt4gE8zEYruL2lwxKbagzzp5szgrW1gKMBnlJTJfcdQ9AhXSmZV9yZmuiE5PXq74iU+GUChL4+ogpEni/hldxPQesJv7qQMPfLSgxpe+ARN6rPdwi7+9jC8kNaEJpFC2m97w6pR8hIpInruO8prvefQE7WEa3TBGO+19mrSnMhlCwRSMqRN0bFkf9a0PE/3LaDSSGyIs3x0E8aQXwUTRgfuICnfzHwpDYzx1WREp2XWiV2aWh9sNeRPXBRcHaZhb2EwQfQPZUum9VPkeuea+duoNZqB32MO1Y92qpInHbXexrJEimXmn6YQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qG8g2qODrjtXNBEUiXygG98F2G8M+/qXuI6MnhFhN2Y=;
 b=fy7ivN3uYlmj34Zygj6I+rDtY2HFQNCsOp7IpY2P5PZKftr1XrdNJ0dj27Df0+eaf3RhXBoQuQSM4JaVLmajPGZSz/I+K7K20LuaRdzeiT2uSg44pGHYtV604XkSms6Onkz0XCaD8108isvPMbDa1xyQE+r7nw0O1A3fP0fsVxGj2EEtJA5nkddilOfCP2gk8XBxUv4gTdyTPykz/hrwnY8swPKeElnNJlbp8yjL0SRNz1ZJL91vfkGewuNHrFmmS8jZYMo/eMwue+XtRwyckasbo6qW1KF7BnswNxaLXY8RDII7igvfop+srcnisDavCPVdryxq9w3hdQzZX2E55w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.79.222.204) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG8g2qODrjtXNBEUiXygG98F2G8M+/qXuI6MnhFhN2Y=;
 b=f/vIuws4k29JVklDFb3LcGfcCcNxFLYsfjDExHB++mGDvbI2RHIXbWFZUBsXZaYVMgoKPeoMS2TnjvFQITFybtjmxsDrZBxtBsvNiLSSIf4+e/fpeiKNY6lUnTlgk+uvTgWVBo5eAl3f81WYoXvExXoF7XYA88p46BNIpxZJKk0=
Received: from AM0PR02CA0184.eurprd02.prod.outlook.com (2603:10a6:20b:28e::21)
 by ZR0P278MB0041.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:17::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 15:27:32 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:20b:28e:cafe::d2) by AM0PR02CA0184.outlook.office365.com
 (2603:10a6:20b:28e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 15:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 15:27:32 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.41) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 02 Jan 2024 15:27:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeFfjrZ5tfhUgdROGmSwsimadHi4hradZHVovWFdFrdnMVaj47o2w3Q1deIr7zkmcGwRCI3WuYPBSs0E9Dt/PXW64k55k1xqtjvxs5WMZX9G2e5uUlN05U5e666QoKVjy2G0A85YEJoyLWTc8o8GcAgqVaFQQrKo1UuommOmGTPa8ao8SOrvSQE3vYArq+DsPyJGNXoM6rvv/jbJHe1BzclXTKzyHSU3KM6NJ8iWbWY2XqTDQF9EWdL1ZD4W3BBeIIf0uMdA0P5v9x9gkotnKljtlIo83Ku07wU8GmwozwA7LCH8z5VcNNcN5SAZK8PQPE+Xo1tPcjjMw6rQXfbRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qG8g2qODrjtXNBEUiXygG98F2G8M+/qXuI6MnhFhN2Y=;
 b=atqxxnqCEoYOmuHO7CaufpXf/NwohoxM48UifWJKL8/L2xGgtEkOJr5QihnyLhZwmSmiiB18mEs9MeFAYIYPOJa/02CK+xldT57Ka6lxhXHMepgeq8uFYkWcqhMnkOgNIJofWMeEI3fsdm6G4ZQjtNAh2eq7HVMJhTzJBRy/0aBvPkUJ7JJBdADgoH8XJgFibIEuj7Fqb0OissQbFwXUiYUtxfty6aqqJDpRqWx4pi/JrdPRORpwV/yrrjayzFUGVeaUk5IvgY5/EzUyspz/KuF58Zh0Btdov1NUtv7Q+H/If/KMFI0zcrJV1UuyUU7s2CXyo6SSOnMaV/YBonyA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG8g2qODrjtXNBEUiXygG98F2G8M+/qXuI6MnhFhN2Y=;
 b=f/vIuws4k29JVklDFb3LcGfcCcNxFLYsfjDExHB++mGDvbI2RHIXbWFZUBsXZaYVMgoKPeoMS2TnjvFQITFybtjmxsDrZBxtBsvNiLSSIf4+e/fpeiKNY6lUnTlgk+uvTgWVBo5eAl3f81WYoXvExXoF7XYA88p46BNIpxZJKk0=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by ZR0P278MB0025.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:17::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 15:27:27 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1865:51c9:a91e:c02a]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1865:51c9:a91e:c02a%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 15:27:26 +0000
From: =?utf-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?=
	<Jorge.SanjuanGarcia@duagon.com>
To: "s-vadapalli@ti.com" <s-vadapalli@ti.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH 3/3] net: ethernet: ti: am65-cpsw: Add device tree
 property to set max MTU
Thread-Topic: [PATCH 3/3] net: ethernet: ti: am65-cpsw: Add device tree
 property to set max MTU
Thread-Index: AQHaPVRfDFA6sE4cakC8kOOs98f50bDGU4GAgABSNoA=
Date: Tue, 2 Jan 2024 15:27:26 +0000
Message-ID: <592fff842e9ae2d9178cef052151fca7a0b9a8c7.camel@duagon.com>
References: <20240102081825.14635-1-jorge.sanjuangarcia@duagon.com>
	 <c025f2f9-ca2c-4fdb-adb1-803745fded0c.a613f387-0b3b-49fd-9401-3a0ed0c1f80e.20d242d9-3999-48e2-8a9e-cd0f9ba3351c@emailsignatures365.codetwo.com>
	 <20240102081825.14635-4-jorge.sanjuangarcia@duagon.com>
	 <162e12c7-c7c1-3bf9-48ec-05ee3c30e784@ti.com>
In-Reply-To: <162e12c7-c7c1-3bf9-48ec-05ee3c30e784@ti.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic:
	GV0P278MB0516:EE_|ZR0P278MB0025:EE_|AM4PEPF00027A67:EE_|ZR0P278MB0041:EE_|AMS0EPF00000194:EE_|ZR2P278MB1163:EE_
X-MS-Office365-Filtering-Correlation-Id: daaaaf1a-1710-4104-df4c-08dc0ba75866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 Zx8JVHdeO7GwAfu+ThElmqS67pTrYkB100CFZz65pwCuicvijB+YLz5mCpmuZe6hQEJJ7nTvShkyICmhbIu0c3S9O5kWHcDEQUr6lChIhaFzD61EHO2hRAaBgKI3ljlOV8PlxuOMeOqxj7pZX+omjqj6HWKQvfsUMFqQ1UVXt5TU7fZjtWsuFB5OXdrR7+UwqVINxD12fHLCCq91bjCELbgzOYC9eQZJozXuPZO9joRLLjyFT9j0vKG8pXbLRrNMTYCG9XBWMwZGtcRMORd3beKEGwEtolfhPYd+6qscoIhhuBN9PZq1SkXeagyB+D3DIlUYa8SeCQEMGuTDnIOUerubJ8+YngfwtoQ2iDLKu7HaeIPL0cdXEVTE/BytCn0WG/fHqp/6ktuLPuRZ5CJuoBtUouW5vueFpv+al1L5y/b8QmbwJmjbYnOvN87+DqgM9vdYO9tfmkBUljag2zqY6/FE/ju5yg/OAz+z0ZZ+I/pM++Rd4Qsc/ULyTZ+T1paXSRjiyXf6gqJAaudCsGHlvj/wVTWoMRwPhst/b1UhGPMBJjP6P9hwXsqfebCbnFg1EzT+MmYKxWbwIjcL8qNTvuOXBOsHLgTrQU841ZBpxuK/3AfUBQNWq/WZgkAhhNxJkrjTbQrgwWTjxbUERcXDUw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(366004)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(1800799012)(1590799021)(186009)(64100799003)(122000001)(38100700002)(85202003)(38070700009)(85182001)(1580799018)(36756003)(86362001)(6512007)(53546011)(478600001)(83380400001)(966005)(71200400001)(4326008)(91956017)(66946007)(66556008)(66446008)(64756008)(66476007)(76116006)(6486002)(26005)(6916009)(316002)(2616005)(54906003)(8936002)(8676002)(6506007)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <F06343E4DB486F41B8EEC4D02C83C1CD@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0025
X-CodeTwo-MessageID: 6c7eb5dc-74f8-404d-94e3-2b96edc6bd63.20240102152728@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 811110f1-5af2-4297-b854-08dc0ba75341
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 EVMUcvQq/2R6dHrTfACPv2MO1NiavugGqVSZspqbqWBsgHa3daquiDuuxNIHbWxgPos1hLCYs7kXTfxXqozidO9cQHGx8jAIkMPc519/QOAA3XEX2chhW64XQU1gYsMmmlbjbLRNpn8ZTrtpmIa+5aO8e1rDLZ8gnWIzzi1ORu/wZ6xEP0sGnyFr61gR9bTgZA5wCGr7ygoia6OhgkwG/S9S8g4YqqEJw+2fliwb3oeYnKZuVpDFkc7o6hvHnxBdiTyTFrL25z/BXi610FSSsdac6QyuFsjE15cajqEdZ6wUOCUyZfKzafgyIHWvKxcr6CZVdVNmD2eB1b3YoHLTnJynyBJf/LpcYoeZx3UkhPUzinZDhIWWwsO9e6c7iwpcaoaJzLdkdQJqFNJhn5UxIxeMWrD0p1aD6EPuGUpyusXU4eLHHB73fJMd2raqrbnz00cc87+0QUeekG8N/6vOQsgU6C5JcCmjvrIYduOI6EWl3ii6X/w45g1Zuz25KmdWAX4l5uA/PZ7WMyMOuaAEW+oFdTPhRDZpa9snCparSw5UUIkAuyXhiRt7xqDAFNdipVsaT1IMubvkMs01esGEzBKT1awE3Xj+KQEVZ2aG+ks0uEWljDVPED6t8mwEV2h3NZEDtO9VEr3bL/YEae9FAMl3mqBLfwyW5xw/1ENGmu+0ICBUaQm71JnRPHylv+Gg5IFHeZSwgXuQ1s+Y42qOwAgC6O9iKVe/MXBpNpkjtR8yfpaPbjHhn7QlBVRLLFAx
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(136003)(39840400004)(346002)(396003)(376002)(230922051799003)(82310400011)(1800799012)(451199024)(1590799021)(64100799003)(186009)(46966006)(36840700001)(1580799018)(47076005)(83380400001)(2616005)(26005)(7636003)(7596003)(356005)(41300700001)(8936002)(8676002)(316002)(54906003)(5660300002)(4326008)(2906002)(6862004)(36860700001)(966005)(478600001)(6506007)(70586007)(70206006)(6512007)(53546011)(6486002)(336012)(86362001)(36756003)(85182001)(85202003)(40480700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0041
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	18796514-41f1-43de-d9d8-08dc0ba756a8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dEXNcvnSE3GqHCyx1MIoKmGO5PCo6vASNNOR0n1GHfWY4dbhTihCE3PX8nNWRZJ1U391c4X/NFu/2s+UKB9nK32cKHfZ0Gl/85ENcBAEtBuqkZ8fzTP3IYsEgvbCDQdusRQFo0n3YW7t8gGJ1AzZvQaSKtoMO533DuoDtIUyN2IBFFayR2b4qC7Xqom1Eq4fPmhxyvaELnPfxUeOrmigu7UR1cowQ8wChHQUua603sHccvBkUrk5R73dJQ4DpLKD6oKpovz+5YyHRcuesKGqYQw5tSQW0P5ePG+ClZXYz4MhnQT1v+PSQPwEQ9tqQllDcr3lPzg+8lU5THYUyxAIcwv+4ObvCy61RTx6ZbFPTY4f37QKvcwc+in2DZK2TtIBCbpSVGuFz1X08Bd4hwNC26DnL0gbWlicJ6BVVz+KiIPvFvARKTqsyKvqFMlWd5uzrM+s4eIPQXbI5sM/9OCZ5xa6T6J5QuURtv5A1f6CKel/HFr7zszC7mQGr3tF//XeaFq1LxFPaLdJ4W/EXTTWs/AEJO2MUctMPiCwFSzCuo0HijIf0L/MDVJqDq2v7TakEmKkXFvU9MAoAiMgyUABpjPICdT999mL0EA6K0qr+xm7PO/LSUZnxsIHXqDtFtE8T/L0WFMQ4wgJHzXAdryqjTIyHTpfr7hwgzHze2s5GQ+MSPp38XIalVIwtmOsHDQ3oJ9WED0YoEEc2tovXw4d57D9vj3mAWepvPoX1mPeABafwNrylRORr3MIfC8AwD3pzDbcmznryFhYoUEFkHL2Yw==
X-Forefront-Antispam-Report:
	CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(396003)(39850400004)(376002)(136003)(346002)(230922051799003)(186009)(1590799021)(64100799003)(82310400011)(1800799012)(451199024)(36840700001)(46966006)(85182001)(36756003)(85202003)(40480700001)(1580799018)(53546011)(6512007)(70206006)(6486002)(6506007)(70586007)(86362001)(336012)(82740400003)(81166007)(83380400001)(2616005)(47076005)(26005)(6862004)(5660300002)(2906002)(4326008)(478600001)(966005)(36860700001)(41300700001)(54906003)(316002)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 15:27:34.8161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daaaaf1a-1710-4104-df4c-08dc0ba75866
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1163

T24gVHVlLCAyMDI0LTAxLTAyIGF0IDE2OjAzICswNTMwLCBTaWRkaGFydGggVmFkYXBhbGxpIHdy
b3RlOg0KPiBbTm8gc3VlbGUgcmVjaWJpciBjb3JyZW8gZWxlY3Ryw7NuaWNvIGRlIHMtdmFkYXBh
bGxpQHRpLmNvbS4gRGVzY3VicmENCj4gcG9yIHF1w6kgZXN0byBlcyBpbXBvcnRhbnRlIGVuDQo+
IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbsKgXQ0KPiANCj4g
SGVsbG8sDQoNCkhlbGxvLA0KDQpGaXJzdCBvZiBhbGwgdGhhbmtzIGZvciB0aGUgcXVpY2sgcmV2
aWV3LiBTb21lIGNvbW1lbnRzIGJlbGxvdzoNCg0KPiANCj4gT24gMDItMDEtMjAyNCAxMzo0OSwg
U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2Ugd3JvdGU6DQo+ID4gVGhlIHN3aXRjaCBzdXBwb3J0cyBl
dGhlcm5ldCBmcmFtZSBzaXplcyBiZXR3ZWVuIDY0IGFuZCAyMDI0IGJ5dGVzDQo+ID4gKGluY2x1
ZGluZyBWTEFOKSBhcyBzdGF0ZWQgaW4gdGhlIHRlY2huaWNhbCByZWZlcmVuY2UgbWFudWFsLg0K
PiANCj4gQ291bGQgeW91IHBsZWFzZSBzaGFyZSB0aGUgc291cmNlIGZvciB0aGUgIjIwMjQgYnl0
ZXMiIG1lbnRpb25lZA0KPiBhYm92ZT8NCj4gSW4gSjcyMDAgU29DJ3MgVFJNLCBJIHNlZSBzdXBw
b3J0IGZvciB1cCB0byA5NjA0IGJ5dGVzIChpbmNsdWRpbmcNCj4gVkxBTikNCj4gaW4gdGhlICJD
UFNXX1BOX1JYX01BWExFTl9SRUdfayIgcmVnaXN0ZXIgZGVzY3JpcHRpb24gZm9yIENQU1c1Rw0K
PiBpbnN0YW5jZSBvZiBDUFNXLg0KPiANCg0KVGhlIDIwMjQgYnl0ZXMgYXMgbWF4IHZhbHVlIEkg
Z290IGl0IGZyb20gdGhlIEFNNjQ0MiBUUkYgd2hpY2ggaXMgdGhlDQpTb0MgSSBoYXZlIGJlZW4g
d29ya2luZyBvbi4gQXQgbGVhc3QgZm9yIHBvcnQgMCwgdGhlIHJlZ2lzdGVyDQpDUFNXX1AwX1JY
X01BWExFTl9SRUcgaXMgZG9jdW1lbnRlZCBhczogIlRoZSBtYXhpbXVtIHZhbHVlIGlzDQo5NjA0
IChpbmNsdWRpbmcgVkxBTikgd2hlbiBmaWZvX2Jsa19zaXplID0gNC4gV2hlbiBmaWZvX2Jsa19z
aXplID0gMQ0KdGhlIG1heGltdW0gdmFsdWUgaXMgMjAyNCAoaW5jbHVkaW5nIFZMQU4pIi4gSXQg
aXMgbm90IGNsZWFyIHRvIG1lIGhvdw0KdGhlIGZpZm9fYmxrX3NpemUgc2hvdWxkIHdvcmsgZnJv
bSB0aGUgcmVmZXJlbmNlIG1hbnVhbCBzbyBJIGtlcHQgaXQNCnNhZmUgdG8gdGhvc2UgMjAyNCBi
eXRlcy4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHNvbWV0aGluZyBlbHNlIHNob3VsZA0KYmUgY29u
c2lkZXJlZC4NCg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBhIG5ldyBkZXZpY2V0cmVlIHBy
b3BlcnR5IHNvIHRoZSBzd2l0Y2ggcG9ydHMgY2FuDQo+ID4gYmUgY29uZmlndXJlZCB3aXRoIGFu
IE1UVSBoaWdoZXIgdGhhbiB0aGUgc3RhbmRhciAxNTAwIGJ5dGVzLA0KPiA+IG1ha2luZw0KPiAN
Cj4gbml0cGljazogc3RhbmRhci9zdGFuZGFyZC4NCg0KT29wcy4NCg0KPiANCj4gPiB0aGUgbWF4
IGZyYW1lIGxlbmd0aCBjb25maWd1cmVkIG9uIHRoZSByZWdpc3RlcnMgYW5kIHRoZSBtYXhfbXR1
DQo+ID4gYWR2ZXJ0aXNlZCBvbiB0aGUgbmV0d29yayBkZXZpY2UgY29uc2lzdGVudC4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKb3JnZSBTYW5qdWFuIEdhcmNpYQ0KPiA+IDxqb3JnZS5zYW5q
dWFuZ2FyY2lhQGR1YWdvbi5jb20+DQo+ID4gLS0tDQo+IA0KPiBGb3IgcGF0Y2hlcyB3aGljaCBh
ZGQgbmV3IGZlYXR1cmVzLCBwbGVhc2UgdXNlIHRoZSBzdWJqZWN0IHByZWZpeA0KPiBbUEFUQ0gg
bmV0LW5leHRdLg0KPiANCj4gPiDCoCBkcml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNwc3ct
bnVzcy5jIHwgMTggKysrKysrKysrKysrKystLS0tDQo+ID4gwqAgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvdGkvYW02NS1jcHN3LW51c3MuaCB8wqAgMSArDQo+ID4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAx
NSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNwc3ctbnVzcy5jDQo+ID4gYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC90aS9hbTY1LWNwc3ctbnVzcy5jDQo+ID4gaW5kZXggYTkyMDE0NmQ3YTYwLi42
YTVjOGI2ZTAzZjQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkvYW02
NS1jcHN3LW51c3MuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bz
dy1udXNzLmMNCj4gPiBAQCAtNTYsNyArNTYsNyBAQA0KPiA+IMKgICNkZWZpbmUgQU02NV9DUFNX
X01BWF9QT1JUU8KgwqDCoMKgIDgNCj4gPiANCj4gPiDCoCAjZGVmaW5lIEFNNjVfQ1BTV19NSU5f
UEFDS0VUX1NJWkXCoMKgwqDCoMKgwqAgVkxBTl9FVEhfWkxFTg0KPiA+IC0jZGVmaW5lIEFNNjVf
Q1BTV19NQVhfUEFDS0VUX1NJWkXCoMKgwqDCoMKgIChWTEFOX0VUSF9GUkFNRV9MRU4gKw0KPiA+
IEVUSF9GQ1NfTEVOKQ0KPiA+ICsjZGVmaW5lIEFNNjVfQ1BTV19NQVhfUEFDS0VUX1NJWkXCoMKg
wqDCoMKgIDIwMjQNCj4gPiANCj4gPiDCoCAjZGVmaW5lIEFNNjVfQ1BTV19SRUdfQ1RMwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDAwNA0KPiA+IMKgICNkZWZpbmUgQU02NV9DUFNXX1JF
R19TVEFUX1BPUlRfRU7CoMKgwqDCoMKgIDB4MDE0DQo+ID4gQEAgLTIxOTgsOCArMjE5OCw3IEBA
IGFtNjVfY3Bzd19udXNzX2luaXRfcG9ydF9uZGV2KHN0cnVjdA0KPiA+IGFtNjVfY3Bzd19jb21t
b24NCj4gPiAqY29tbW9uLCB1MzIgcG9ydF9pZHgpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGV0
aF9od19hZGRyX3NldChwb3J0LT5uZGV2LCBwb3J0LT5zbGF2ZS5tYWNfYWRkcik7DQo+ID4gDQo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgIHBvcnQtPm5kZXYtPm1pbl9tdHUgPSBBTTY1X0NQU1dfTUlO
X1BBQ0tFVF9TSVpFOw0KPiA+IC3CoMKgwqDCoMKgwqAgcG9ydC0+bmRldi0+bWF4X210dSA9IGNv
bW1vbi0+cnhfcGFja2V0X21heCAtDQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChWTEFOX0VUSF9ITEVOICsgRVRIX0ZDU19MRU4p
Ow0KPiA+ICvCoMKgwqDCoMKgwqAgcG9ydC0+bmRldi0+bWF4X210dSA9IGNvbW1vbi0+bWF4X210
dTsNCj4gDQo+IFRoaXMgc2VlbXMgdG8gYmUgbW9kaWZ5aW5nIHdoYXQgd2FzIGFkZGVkIGluIGp1
c3QgdGhlIHByZXZpb3VzIHBhdGNoLg0KPiBJc24ndCBpdCBiZXR0ZXIgdG8gbWVyZ2UgdGhlc2Ug
Y2hhbmdlcyBpbnRvIGEgc2luZ2xlIHBhdGNoPw0KDQpZZWFoLiBJIHdhcyBub3Qgc3VyZSBhYm91
dCB3aGV0aGVyIGl0IHdvdWxkIGJlIGJlc3QgdG8gc3BsaXQgdGhlIG5ldw0Kc3RydWN0IG1lbWJl
ciBhbmQgdGhlIGRldmljZSB0cmVlIHBhcnNpbmcgaW50byB0d28gcGF0Y2hlcy4gSSdsbCBtZXJn
ZQ0KcGF0Y2hlcyAyLzMgYW5kIDMvMyBvZiB0aGlzIHNlcmllcyBhcyBvbmUgcGF0Y2ggd2l0aCB0
aGUgdXBkYXRlcy4NCg0KPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgcG9ydC0+bmRldi0+aHdf
ZmVhdHVyZXMgPSBORVRJRl9GX1NHIHwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5FVElGX0ZfUlhDU1VN
IHwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5FVElGX0ZfSFdfQ1NVTSB8DQo+ID4gQEAgLTI5MjcsOCAr
MjkyNiwxOSBAQCBzdGF0aWMgaW50IGFtNjVfY3Bzd19udXNzX3Byb2JlKHN0cnVjdA0KPiA+IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGNvbW1vbi0+
cG9ydF9udW0gPCAxIHx8IGNvbW1vbi0+cG9ydF9udW0gPg0KPiA+IEFNNjVfQ1BTV19NQVhfUE9S
VFMpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0VO
VDsNCj4gPiANCj4gPiArwqDCoMKgwqDCoMKgIGNvbW1vbi0+bWF4X210dSA9IFZMQU5fRVRIX0RB
VEFfTEVOOw0KPiA+ICvCoMKgwqDCoMKgwqAgb2ZfcHJvcGVydHlfcmVhZF91MzIoZGV2LT5vZl9u
b2RlLCAibWF4LWZyYW1lLXNpemUiLA0KPiA+ICZjb21tb24tPm1heF9tdHUpOw0KPiANCj4gVGhl
IGRldmljZS10cmVlIHByb3BlcnR5ICJtYXgtZnJhbWUtc2l6ZSIgaXMgYSBwb3J0LXNwZWNpZmlj
DQo+IHByb3BlcnR5Lg0KPiBUaGVyZWZvcmUsIGl0IGlzIHdyb25nIHRvIGV4cGVjdCB0aGUgcHJv
cGVydHkgdG8gYmUgcHJlc2VudCBhdCB0aGUNCj4gQ1BTVw0KPiBub2RlIGxldmVsIGluc3RlYWQg
b2YgYmVpbmcgcHJlc2VudCB3aXRoaW4gZWFjaCBwb3J0IGluIHRoZQ0KPiAiZXRoZXJuZXQtcG9y
dHMiIG5vZGUuIFRoaXMgc2VjdGlvbiBzaG91bGQgYmUgbW92ZWQgaW50byB0aGUNCj4gZnVuY3Rp
b246DQo+IGFtNjVfY3Bzd19udXNzX2luaXRfc2xhdmVfcG9ydHMoKQ0KPiB3aGljaCBwYXJzZXMg
dGhlIGRldmljZS10cmVlIG5vZGVzIGZvciBlYWNoIHBvcnQuIFRoZSAibWF4LWZyYW1lLQ0KPiBz
aXplIg0KPiBwcm9wZXJ0eSBjYW4gYmUgc3RvcmVkIHRoZXJlIG9uIGEgcGVyLXBvcnQgYmFzaXMg
d2l0aGluIGEgbmV3bHkgYWRkZWQNCj4gbWVtYmVyIGluICJzdHJ1Y3QgYW02NV9jcHN3X3BvcnQi
IGFzIG1lbnRpb25lZCBpbiBteSBwcmV2aW91cyBtYWlsDQo+IGZvcg0KPiBwYXRjaCAyLzMuDQo+
IA0KDQpUaGF0IG1ha2VzIHNlbnNlLiBJIGFncmVlIHRoaXMgc2hvdWxkIGJlIGEgcGVyIHNsYXZl
IHBvcnQgcHJvcGVydHkuDQpJJ2xsIHN0YXJ0IHB1dHRpbmcgdG9nZXRoZXIgYSB2ZXJzaW9uIDIg
ZG9pbmcgaXQgdGhhdCB3YXkuIEkgbmVlZCB0bw0KdGhpbmsgYWJvdXQgd2hhdCB3ZSBzaG91bGQg
ZG8gd2l0aCBwb3J0IDAncyBtYXggZnJhbWUgc2l6ZS4NCg0KPiA+ICsNCj4gPiArwqDCoMKgwqDC
oMKgIGNvbW1vbi0+cnhfcGFja2V0X21heCA9IGNvbW1vbi0+bWF4X210dSArIFZMQU5fRVRIX0hM
RU4gKw0KPiA+IEVUSF9GQ1NfTEVOOw0KPiA+ICvCoMKgwqDCoMKgwqAgaWYgKGNvbW1vbi0+cnhf
cGFja2V0X21heCA+IEFNNjVfQ1BTV19NQVhfUEFDS0VUX1NJWkUpIHsNCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjb21tb24tPnJ4X3BhY2tldF9tYXggPSBBTTY1X0NQU1dfTUFY
X1BBQ0tFVF9TSVpFOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbW1vbi0+
bWF4X210dSA9IEFNNjVfQ1BTV19NQVhfUEFDS0VUX1NJWkUgLQ0KPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChWTEFO
X0VUSF9ITEVOICsgRVRIX0ZDU19MRU4pOw0KPiA+ICvCoMKgwqDCoMKgwqAgfQ0KPiA+ICsNCj4g
PiArwqDCoMKgwqDCoMKgIGRldl9pbmZvKGNvbW1vbi0+ZGV2LCAiTWF4IFJYIHBhY2tldCBzaXpl
IHNldCB0byAlZFxuIiwNCj4gPiBjb21tb24tPnJ4X3BhY2tldF9tYXgpOw0KPiA+ICsNCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqAgY29tbW9uLT5yeF9mbG93X2lkX2Jhc2UgPSAtMTsNCj4gPiAtwqDC
oMKgwqDCoMKgIGNvbW1vbi0+cnhfcGFja2V0X21heCA9IEFNNjVfQ1BTV19NQVhfUEFDS0VUX1NJ
WkU7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGluaXRfY29tcGxldGlvbigmY29tbW9uLT50ZG93
bl9jb21wbGV0ZSk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGNvbW1vbi0+dHhfY2hfbnVtID0g
QU02NV9DUFNXX0RFRkFVTFRfVFhfQ0hOUzsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgY29tbW9u
LT5wZl9wMF9yeF9wdHlwZV9ycm9iaW4gPSBmYWxzZTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvdGkvYW02NS1jcHN3LW51c3MuaA0KPiA+IGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvdGkvYW02NS1jcHN3LW51c3MuaA0KPiA+IGluZGV4IDE0MTE2MDIyM2Q3My4uM2JiMGZm
OTRhNDZhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bz
dy1udXNzLmgNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNwc3ctbnVz
cy5oDQo+ID4gQEAgLTEzMCw2ICsxMzAsNyBAQCBzdHJ1Y3QgYW02NV9jcHN3X2NvbW1vbiB7DQo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgIHUzMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdHhfY2hfcmF0ZV9tc2s7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIHUzMsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcnhfZmxvd19pZF9iYXNlOw0KPiA+
IA0KPiA+ICvCoMKgwqDCoMKgwqAgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBtYXhfbXR1Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBpbnTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJ4X3BhY2tldF9tYXg7DQo+ID4gDQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbTY1X2Nwc3dfdHhfY2huIHR4X2NobnNbQU02NV9DUFNX
X01BWF9UWF9RVUVVRVNdOw0KPiANCj4gLi4uDQo+IA0KPiAtLQ0KPiBSZWdhcmRzLA0KPiBTaWRk
aGFydGguDQoNClJlZ2FyZHMsDQpKb3JnZQ0KDQo=

