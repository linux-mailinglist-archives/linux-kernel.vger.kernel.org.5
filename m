Return-Path: <linux-kernel+bounces-52689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E551849B72
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4031F2195D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596A61CAA4;
	Mon,  5 Feb 2024 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=analog.com header.i=@analog.com header.b="P0jfeNNH"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A247420DCB;
	Mon,  5 Feb 2024 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138654; cv=fail; b=eKjUhbwTuQvaGy3mYoZMU3wO7+9FV+p+tEDKAXgjspmmDcVl70tAZ0vh5gNnoJe2NLwDRK8AQWsYrZui4M2QE2IKnKaIZ5sWpVAmCOX0cdCgP8tlWxTtbZJPdQhuZRLHjL8+x8UoyEqinm224CSMYavPSwqo69d47uOHy4eGLO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138654; c=relaxed/simple;
	bh=kg//VybSfPmP5WtikwnBxEcYSL52Ol8YlnC3pu1OEUU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LiJQGQeljPpyAbxILfE0SVkLenl1g7pSMagAoJ88dCitaBP1/k4Ty+fdIuyalHjezEmoJtisLNz4i5/1geCknhVFWVM3kRyU+K86PusUWG4r7Js+YTBslWqxoQgGPymjhjP6mLHvoDLrr2mzZnfz7eX3bsX+hY4PofeFYRz0TJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=P0jfeNNH; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4157xoXv026238;
	Mon, 5 Feb 2024 08:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=DKIM;
	 bh=kg//VybSfPmP5WtikwnBxEcYSL52Ol8YlnC3pu1OEUU=; b=P0jfeNNHWkdU
	9/uKLlsZwKIXIhZl/VsMjKhv6Bm88nSFtyjdcNZ6o3EKz5EZY51FCJ8ZlANANug5
	DLCxZ1MOk9onceEJsWfm2YmPKm8BpzjCdHK0y9vU/GfonGq6HxJiJkYDmvKPflFv
	YoSEv5E9rWf6PA7UFYcgoQ2T9ehhraopRqf2QmwG0w/LwSwWs6OO5L3Wsb1tPgdT
	zjrVQtwVwV8xSZobZOke71kZtlfiyk2jywP/4vdXFhWpYadJ7jsmew/RDWwqiV88
	7a3yvut08mHjvpQG29Uat/01x//y6qrUhTJNhtp/r67KE5B6DQPVIonXiliyv8Td
	P4UA6dNNGg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3w2usc8wr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 08:10:35 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7EagWaChb/OopXfcar7PkLLbNhfbUowVXnJ6jNvAcENBHUq5DQlw/GoMO/xRpY8rG9/eIpxM7yh+GacfuB31QNul4ldUMkBtmSlaX5tQRpXdICie+YBNW38Mm83WG1v8GmqQXRhuJQ94/8gmQ6ZDirfB+0rCtaEuozzGnv5WyL3BGRZqlYRQUNMv92ACjG/K58UcG0z3PC5ohJcR1fagTkQKZhJdRxxuDSwYerzaOKH/bVCIABkhrAbB5iZpAM1WqbKtbQIWPodgBYQ/k4vTZk+KPhLaCTSlkA4wsUlwah7nNtZosKyq9nXyphup2yeX/X4pPQrLKEnKfT4NObi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg//VybSfPmP5WtikwnBxEcYSL52Ol8YlnC3pu1OEUU=;
 b=hakvwyc65Pc76SnqwWUAFIjdyBEwr+tQd/qPMBvlxHKTLSA539bQc92HQebwAUzmLPzNj86cpguitu5dsCPIfPqXA2b2lF3pqR1OdiFGi6EmbVcDLXqxzDYBil7JeVsczlPmo4wegcFQYtKfuZGyvcIWogM/TV38zZsA81+vXLZTVZYUVNsBHOw3O6A15C9OPQDfhMlun2MxLJZ0Wso4PLEtb7npP4I2kkG9zkKYXE+/hRMc5v/PNKFWntvFED5VvpMgijMGEyZCqM7Bd0ZW3z096nXfMjJGDDsx/x1DCT4RiDZtqr2vAgUydUyqRzk+nkERa1floYFizm8iyEuqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by SJ0PR03MB5630.namprd03.prod.outlook.com (2603:10b6:a03:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 13:10:34 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::1238:63d5:647e:4838]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::1238:63d5:647e:4838%3]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 13:10:33 +0000
From: "Sa, Nuno" <Nuno.Sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring
	<robh+dt@kernel.org>, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus
	<heikki.krogerus@linux.intel.com>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] of: dynamic: flush devlinks workqueue before
 destroying the changeset
Thread-Topic: [PATCH v2 2/2] of: dynamic: flush devlinks workqueue before
 destroying the changeset
Thread-Index: AQHaWC/za6qNUilHpEGYd1mFVIhg5LD7t9JA
Date: Mon, 5 Feb 2024 13:10:33 +0000
Message-ID: 
 <SJ0PR03MB677807F5ABCD412E94EA1BBF99472@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20240205-fix-device-links-overlays-v2-0-5344f8c79d57@analog.com>
 <20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com>
 <ZcDWQ52BGix3ocUC@smile.fi.intel.com>
In-Reply-To: <ZcDWQ52BGix3ocUC@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZjAyNzI5YzUtYzQyNy0xMWVlLWI3ODgtYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XGYwMjcyOWM2LWM0MjctMTFlZS1iNzg4LWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMzU3MCIgdD0iMTMzNTE2MTIyMz?=
 =?iso-8859-1?Q?E4MTk2NTk4IiBoPSI2a2E3czdEMlRZamFlbGlIa2hidDlrbnRZcUk9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUIyVDVDeU5GamFBV0VRMUhnT0tUU1VZUkRVZUE0cE5KUURBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQWxHVEdWZ0FBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|SJ0PR03MB5630:EE_
x-ms-office365-filtering-correlation-id: dc54c6ab-80e3-439e-cbf1-08dc264bd63f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 z3qc7fIPvXN0yVzoR87QUVroY0s5G3INwBYwbrrPEekMn4elyQEW5ee8xwOIKgVUn+1auX3P0EXQIJGUOeOKU79F0m00y3L4Sx4ZiM8SzBHI8QJhJ1lwGILW2SEjD2WL9QZK7wKVDAAFXISuIxk2hDCN+ULQlj5Q9SN4wclZc91nFhgOk+0KaQKa0A4ZWNthSS64tQHXd+SDroSVvprxjdCVvTVTVIUyZxyQ+tdXvaGuahHs+z5gIMsu7kDougHV1hQJPkkB0kkIOiIfHRnwO+/QG36Gg52BZlyY6yY211J8/WdGfaxUklHwJWlEshhXX5EPLl+69PsLkGwyjoNR/3cIsc/1mO7VeXOivRHXE2VzqOnmKmKBzu9U2AeKwwJhqm6kuKDKUksxNh/2T5iNtwWT23O842L5dNZnjqi+wHz2/xt7mJeueMp3x314OYEbZJFElDjIZCM+oz7+F5/wmUYy2mfu7+zjH0V964jlo9etJczMEYmKqR7SrKuKsmt7yACxp7p6kj4Op2SHoGgnzDiOCuyhtr9F9MhYsABlgILCiueXiTLoxcdvhFiC4XHWZVbaX1h4oqRgOA8RQtiM1A1ZMAy94k8yaFQ+WGbwwQxUm5OatCM277qkMrmyjptP
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(230273577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(26005)(86362001)(41300700001)(7416002)(5660300002)(2906002)(478600001)(38070700009)(64756008)(66476007)(316002)(6916009)(54906003)(66556008)(66946007)(76116006)(66446008)(8936002)(8676002)(4326008)(52536014)(9686003)(71200400001)(6506007)(7696005)(53546011)(33656002)(38100700002)(55016003)(122000001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?shJeO29wWuVDcHCXBFhvlFcV1MuBjZH8QzIOLqQeHOtLl+3bOq59v4ZYTP?=
 =?iso-8859-1?Q?U/ZYDaK5BPkao5HizXeROL4bmcUbYyrxveFP/yRqn+2kFyZoWkS6A+T+Md?=
 =?iso-8859-1?Q?n0Nddm+bFK2PSy44WN9ZsN2AKNwMh+4YOGELILnZuRL8mwRuKmC//4Pfjg?=
 =?iso-8859-1?Q?ld095w6TICIgM+f0+e/3tP5i0UQRqiQZw0YST/LIp+tc9iyRmEhs1sFEOU?=
 =?iso-8859-1?Q?/5IHs9bVCoNLe6Abc4uEtx2kSV33n+i+/09mCUQCjXBR3K15B8WQI1NVca?=
 =?iso-8859-1?Q?RhysF1p7DDMh3wuoc32dll88XHfbXxMl8hH/P4FJZ6dJ0GJO65pe2yOOZG?=
 =?iso-8859-1?Q?7wGVDXFCNvJ7YANgHNNs9dECGiUgekufK/UEt4Pbf5l1+uMrzzrQBua7Ot?=
 =?iso-8859-1?Q?maVg40QRO6nc2pZvwn8AVbPW6cOg3mTQdnysohWbXlYcT1qvLYqB9nyXIx?=
 =?iso-8859-1?Q?h+pzpEH6lg95UZze1aineArKcmIdeQXeLv+HvLES+IVeXVurbhQXm4SOqS?=
 =?iso-8859-1?Q?BMswtt9DB0sokZ6S84ZQVjUgcvmbEroJguJifS53+5W+tXeE07OPN4+Nnl?=
 =?iso-8859-1?Q?AZ+e3Qz9zwtCzdqXDl9NsuUfH6G5zs5L9wxyV0CRVRJyH1F7+SvH8/t+8B?=
 =?iso-8859-1?Q?2van1AhkfnP/+bK9USfPuxw6+sknH8F2jnZWVCMXzDEa6iQuvfLj6sM6BW?=
 =?iso-8859-1?Q?oNy0zO3aoSaawBttrQT+61ToDTLZvpc0K7hxXUFdV5R0XwISl1OQALwlpp?=
 =?iso-8859-1?Q?KzWLKCwFsVhhRbBHcVF2IxGyI2wjro8/t3m/QFdjmsotNrWTaOUC+9fhzU?=
 =?iso-8859-1?Q?rVuq4DuXqUJ3z6Z4rLyKwK6UbVrLTJrQQKA6w6EAYF7qDZvaDs7AXfAI89?=
 =?iso-8859-1?Q?agV7NQA7RP3/q5mBs5dDp8n4734ap9Ihsy5DuPl6EAtj5aCpBDQuDJtyXx?=
 =?iso-8859-1?Q?ZmovupHtfo1qz2Pft+Bm7pGCVR6jqUX75qfdCki8vjtM4xNGx44pSnm+OZ?=
 =?iso-8859-1?Q?K3MZ6ptBH9tjEisws4gh5BmMK4Q/E38Ej7yWwV7xF1DRA00A1TyMXCP/JF?=
 =?iso-8859-1?Q?FMWjyRkH8UmiFwHMkKPkRtUSPHAc/+bMcyNr+q0WO4b4JaXRqY30neN6U/?=
 =?iso-8859-1?Q?scHjv2mf0aiRaUnxiDYuCzg7ut0SMhz7tzb8BFiEBzy3R+WFarSh3ESoj9?=
 =?iso-8859-1?Q?L2dEwPQeqQBfRgY4IL/iIOT23O1xUlK3cXdijDDo1WjsfTNh97/cnUdA/5?=
 =?iso-8859-1?Q?52HUWgqx6vdVbMgZmY8jaIQIe4THGcejSteaUReKC8nPGihRllahXZ213U?=
 =?iso-8859-1?Q?P3oZjBZaSkyLVbNb7NxG93dttem7joMcaMNLakJSQ5jKQ57aRL7Dy0IHnB?=
 =?iso-8859-1?Q?EQcmUHK1aL8H4iiHmFGtf9+WnSv+U0jPTBCffsAxv7wHleKznP57/U3O1o?=
 =?iso-8859-1?Q?zG4o3sgf6VQLN1tvWLNmP6BXxpjme5V0GfnAscJF0a1TaNIxvWTrWNXNcc?=
 =?iso-8859-1?Q?hUOd5IUY8oKk/zVLjZf5KU7QFszNKdQngFEhJYAHL8Qs2uDwi2b6JA8rwF?=
 =?iso-8859-1?Q?Ip6sGKvk3OP+EOniirGlbw+8TtUhEQ/LJagQRvTReIF2ty5/WwlsescUGB?=
 =?iso-8859-1?Q?+cqLivsB9PI9k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc54c6ab-80e3-439e-cbf1-08dc264bd63f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 13:10:33.8318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNhJyulKyDmdpGTeXBbCmOGNA/Xu3n8QPEyylIPUbBIpj0NfuSxYRhstd8BToCSlNGHUh9B0ifN5OnF7ffl2wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5630
X-Proofpoint-GUID: 5bedthlHUmf7refX-5s4NIZhwVA7RVIf
X-Proofpoint-ORIG-GUID: 5bedthlHUmf7refX-5s4NIZhwVA7RVIf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=593
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050099



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Monday, February 5, 2024 1:36 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rafael J. Wysocki
> <rafael@kernel.org>; Frank Rowand <frowand.list@gmail.com>; Rob Herring
> <robh+dt@kernel.org>; Daniel Scally <djrscally@gmail.com>; Heikki Krogeru=
s
> <heikki.krogerus@linux.intel.com>; Sakari Ailus <sakari.ailus@linux.intel=
com>;
> Len Brown <lenb@kernel.org>; linux-acpi@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] of: dynamic: flush devlinks workqueue before
> destroying the changeset
>=20
> [External]
>=20
> On Mon, Feb 05, 2024 at 01:09:33PM +0100, Nuno Sa via B4 Relay wrote:
> > From: Nuno Sa <nuno.sa@analog.com>
> >
> > Device links will drop their supplier + consumer refcounts
> > asynchronously. That means that the refcount of the of_node attached to
> > these devices will also be dropped asynchronously and so we cannot
> > guarantee the DT overlay assumption that the of_node refcount must be 1=
 in
> > __of_changeset_entry_destroy().
> >
> > Given the above, call the new fwnode_links_flush_queue() helper to flus=
h
> > the devlink workqueue so we can be sure that all links are dropped befo=
re
> > doing the proper checks.
>=20
> Have you seen my comments against v1?

Hmm, not really. lei is not fetching any email (even this one - that's why =
I'm using my work email + awesome
email client to reply).
And looking directly in lore... I'm also not seeing any reply from you. May=
be there's an issue.

- Nuno S=E1


