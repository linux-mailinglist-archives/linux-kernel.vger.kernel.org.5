Return-Path: <linux-kernel+bounces-156082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BCA8AFDAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2C3281959
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382276FDC;
	Wed, 24 Apr 2024 01:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ENSx0YZ9";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mAUDE/+j";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ENXNS/ar"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA59610C;
	Wed, 24 Apr 2024 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921467; cv=fail; b=jE5EyovPdFldteHBzYsVosQU6kFvBtpBJJPa8oXChzGUFvNNsLyLfqkpXGFY55JydWGBivVF9hz1aL9XN/g7eEHMZBhukSemeLK9YKMS91zt2q67/MqksVK6RhgXOyUgT2J5uM7nFOzDAf25ceztWGGc2pswMUuI+PjmvFeiCQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921467; c=relaxed/simple;
	bh=2G6b2OT/iAyKjhYD9cIPVxqRdxLhKAXKT+bnj2uRrZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WZsb0lMIyWmMm/5GsNG9dKaaotOEi8qB9VGPhw9EComjooDd87Karu7mPOtaT3fBqDPlua7aaAwIWjwvpCu0cImjmlR2UVowTXs5anl/WyaI4JY6g7ZD2pqSYUGXXSq5xtgjBg7r7TP4DGuFaofLk3GYAhiy5LcMtEXRgtFzTz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ENSx0YZ9; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mAUDE/+j; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ENXNS/ar reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0xLae015980;
	Tue, 23 Apr 2024 18:17:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=2G6b2OT/iAyKjhYD9cIPVxqRdxLhKAXKT+bnj2uRrZE=; b=
	ENSx0YZ94KbLO1fGSNQkzaj3HlHBlIsi2wttCifkoXwZoqyP/tKQaXPxcO0/PZvs
	r2gG+n8dMz1f0U2tpcpaONdJnj1J+EPIJB48jwnHjJE7xKJhrNsQDpAi09CgXJ2h
	KEHM/o2poiVlR+EZuQeAgw3swafpujpdVGeXMnNczdYa56iJfpAdEiTvlyOu+ZhO
	g/Un2ltFlY3mX8TJtEO0JWIoBJhsUCc06KnlQVzhzW5y7nIUWk0PnzhJG8sKTdaP
	o8Dsn1SyQedVlH8ZKRMS8dvrY0ymaq3Mcu7qo4SEgwesFyuNf+d/yVGPb/cZEBwv
	RXeak+UctteT2I2uST6Dmg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3xpf6xae59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713921457; bh=2G6b2OT/iAyKjhYD9cIPVxqRdxLhKAXKT+bnj2uRrZE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=mAUDE/+jHT1y+fquthdE2pabb/l3FSO4xMPXtZRh3Dfv8qPh1A8K2JlsXb94ET7xx
	 0JA2mjQZ6XkTIKHt8BdL0kzUiuIxelhKD6fPZ61zlTzIeMJkp6zHGF8k5cUc4hSiYA
	 Br+dQAuvRWr7oq4z1egmINnNa2L2aPhdhmc5IQ/XE1dN4sr8DoQovZxIXIZ0HGh7Tj
	 gWlP2qjZVOtdcqCCREj/mk6lbJl9ptLCOj0N7RL7WzPHFmuYzSPdRO2JQSfe8c3Ve0
	 /10q1lDZBviHrRMeGEVw2fufIe5Z2e3yPgEm3b1WTUg2x6aaU0NyDfkfmoKr5MAjiM
	 a0jyLml6/fTjw==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C4B434048E;
	Wed, 24 Apr 2024 01:17:36 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 90C91A009E;
	Wed, 24 Apr 2024 01:17:36 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ENXNS/ar;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 582D84035C;
	Wed, 24 Apr 2024 01:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CawNjP8f/CXgruDDhTB8tmNmZQ4+7UyGXXhvQsnm90NLrSw4U8FI16DzQ65YEqK21nfD5wc5uXFzM1XYlIlYMMTIOfBhpGI/g9QvAaOo6OnfzTwBdCFrkifK7024OAXL5A3gVRcWtjppUnsOO8v/2wHrdgH+4W5KBkjpWgzQuw8kcEf4G9WJDZAZIcTaVQfTCs4YMV/QgM40Zv3/NGk+la5mIY1RQoiefvFIml5aXiH2yrZnfsdQVNHbOiU6jTLP6nmJ3PkUg3hHOJcWoZ1z5BJ/zxgsaXxDdK+/6OTuXV+QZUcK44OYAPHbzoA1UB1DL0bw57LD31xGdT2Hf6GJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2G6b2OT/iAyKjhYD9cIPVxqRdxLhKAXKT+bnj2uRrZE=;
 b=mg5Lvd0UgqblmnDzJoIaR4NM8zzU1YI6I7ucR8hNWnxOlp6KrwAiJpfES5Vx9OvFGNJocjO1Tlxex4BqmcrQHPn2/a8UVRLUafrOTbpxuBg21bN1BU8s+4DLB8r0wOnpi71Rt6y+hIQ1T/t3MSlqhsNucaQN7kiTkAZk2jFsXSK56PVcoX8IFvkLQIWkx+O65/8JmSRbzhBKSFfkyEyYk39n8/374uAmhAcv/sV8Wx5c7MS1la0AkTWc1imXehRds2Ad+cyjp4Z9aKrt9vue8eJBmbm4JlE/qttTz2+K6RwxA68kCijNsIHFBmudn7DtahyudZi0DPfV0qyT3fqwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G6b2OT/iAyKjhYD9cIPVxqRdxLhKAXKT+bnj2uRrZE=;
 b=ENXNS/arudHeZdu8EjGlZVn7DVUUC1w4oaLHOmZLo+nhPZJplJbmz2wADFeUyO0ShPCRdcdRr5v7+hkAcZ03iSzGH6NA3qK9AVR4RSAZOu5baA2HZUQ7Dlz7SrU/xec4ddDvG29i6tLiRnqLNeNs+mhwu9BKi1giP7UMbiLKxWE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 01:17:33 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 01:17:33 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>, Johan Hovold <johan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v21 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
Thread-Topic: [PATCH v21 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
Thread-Index: AQHakt479mMN9g42NUGXloampKbK/LF2pJ4A
Date: Wed, 24 Apr 2024 01:17:33 +0000
Message-ID: <20240424011730.owrvfquha23wbt5g@synopsys.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
 <20240420044901.884098-8-quic_kriskura@quicinc.com>
In-Reply-To: <20240420044901.884098-8-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY8PR12MB7682:EE_
x-ms-office365-filtering-correlation-id: 27ac438e-7976-4b30-edc5-08dc63fc51eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WXFHbmt0aHdpVjl0YTNMOHR5ckNRSkxkeHgraSsxS2NFSEZ2cDZ5OE93UU9v?=
 =?utf-8?B?ZFlyanBMMlk2akhuOENyK0JJb3NuSE81Qklud3k5U2lTaXA4MllQZjA5ajN3?=
 =?utf-8?B?NTZtek9meks3YmYwVDJ3MmdmRGU5eWExbXVpNjE3cW16Uy9UUXQ0ZFU3R1Js?=
 =?utf-8?B?T0poZGZsc0hjOUdQWmxKak1PREZuVDFjMDZ2MXcrc1dBbGxuN2o1TTJvMXkw?=
 =?utf-8?B?eGdUSTNrQnp4S21iSFdmQmFPUnl2ckgxajFjcHZEa05FdnNDUlAza3JnZlhQ?=
 =?utf-8?B?QkRTd0Y1RE5ha2N3Q0YzajMwMUhuSW0yTGIzbnhGQ1UxaHZHZWc1KzNMT2E2?=
 =?utf-8?B?akJJUU9HL0c1bWhMdWxueFkvQVNPN0xFUGsvVTk2L1UrN0VFcnpyQ0V1Z2VO?=
 =?utf-8?B?em44bmd5V0ZwMm0xZEdRN3grTllKQVhGRHZLN1JMbnN6QmRDK1g1dmRTaWN1?=
 =?utf-8?B?TTBRSU5UWWpIQ25vc3Y2UmpEVWZQNU1TSDM5cm03OGlKUjJZLzRxNHpwUHFV?=
 =?utf-8?B?ajN5Nm9JVDZkbEowM2pCYjRSS0Jlc0t5UTgrbGRQdXloajRXWFVURW4wQ0w4?=
 =?utf-8?B?WnJmYTJWZWhZYkFhQWR5S2ZnUlJDY1JEZ3pmYzF3SWdZQ1NGYmRpTmtlT1Vo?=
 =?utf-8?B?SU5HT1gzWXE4UjJSRGE0c2VHWitWZXF0MzBMSVFuNE9aSnZOQTR3VVZyN1ZT?=
 =?utf-8?B?TUJVMTZ2NGNhQ2VlYUZaQ0cvc2JGZzQ2UzdEQ05MNlRvcHBMdVlSTWh3YVlj?=
 =?utf-8?B?MXVVRkFFRTNRNEtEaHpQUHBOUzBpRzJFck1MRFpFRm8yWlQxaGh2M3IzRkph?=
 =?utf-8?B?cytPZWhkT3NLbGczbVRHcm1QTFoyUnFZazV1MUNncXFGK1pvTXBubjF6WmE0?=
 =?utf-8?B?eGNveFI3Tm50WWR1bmx5OVl1ZU5rZ2FWVmdSYUREUjczTGZZVjZPRW1obHFY?=
 =?utf-8?B?cUlKa2t2K0ZNTUw5VThyYnZCdVhuODFzc0ZqOXRSL2ZPa3B6Y2tiTnJ4QWRO?=
 =?utf-8?B?Sk9sREw1MGZnNUJuMElFdmRmZTRQSHNva1VET05UZFZLQWI1b2RRK2xDdm9w?=
 =?utf-8?B?ZFd0K1hra1NWMmJ5MkdVWFNvQlR6K0w1WmNMd2NVeGZqZGFGdksxTmpNRk9B?=
 =?utf-8?B?RkcwZUNGSm9DVWs3cFRqQStraUFUUHQ3eGs3V1Q3VUVzcmlWWG5VQkhJVEVG?=
 =?utf-8?B?QlFhTWJwT3IyQjQ4YXJvVDA0TU9SdmtzT0NLNEtGUzY2SUhPb29lUFl1N2VD?=
 =?utf-8?B?WklvTkJ0Y2UxS28reE9QY2pScmd0TnJQbmcxMlcrNUovemxSRmdEcEVjelND?=
 =?utf-8?B?WXoxaFB5dGUwK00veEhmTysxL0dBYmRONUIvYVJWZmpBby9ldGhSRVJESW55?=
 =?utf-8?B?d2sxZUdkVGdxVVFQV1hvM013enVQTEd0SjBxWEc4VmxpSHdEcHl6Y1VDU3Rt?=
 =?utf-8?B?WkJFZ25Tb3VaSmJ3VC9tcTRuTFlFZlpJYkc3aHhvRlZlK09mcVExTTNKeDFw?=
 =?utf-8?B?K2JVN0NLY2hTajZYYVRZZmlTZG9ZVldxN1QzdDJlM28vRjBCZy9vamhmSDlh?=
 =?utf-8?B?OHVlREo5UEt3cGNRaE8xQ3RhQ2VrSm5xTjJBT1M3WXNsZ0dhODJ0cGV4STA5?=
 =?utf-8?B?Z3F5bGZ6aUNwcWMxRnNvQzM2bGxUM3krcXZIUlBNMG5PbGVEeGZJTy96ZVZL?=
 =?utf-8?B?SmJvUWRIdHNFa1BTZVV3Mlk5TXdmWmM0bHdFVnB3U0FTYk1nQjdLdjZ4L3pq?=
 =?utf-8?B?VlRvTkZ6emhmWXV6MWx1OVZDREpEc3hMRGh2R0tWOUFUcmtiTThTUmlaN1c3?=
 =?utf-8?B?M1FWVEFsK3NXUDFxSzBmdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OTlRUGxqZlRoRFJZUW5hS0prdzFjdld1VzVITWNIWFlFeCtYdmdkWVErWEth?=
 =?utf-8?B?WnE1bUcyQWdObnZvbFQxOXJRQit1OFIySDJhWjYySW9lMDd4T2tEVEJPNzd5?=
 =?utf-8?B?YkpGZHlobGZlMEpSNm5VYzFaYjQvbVRMVXlrejBoZEdNQ0FwV3diM0hnMDJo?=
 =?utf-8?B?SE5tS2JGTW04RGNLSzlDdzZ6a0k4bXNlejVuNDh1REdvVUlnbzJxWVdqOWZN?=
 =?utf-8?B?cWQ2L1JTZVV3Rk9IMXFxYUs3ZDB2QWs0cDNxUE02T2hLVStwYk5yZ0Urczhp?=
 =?utf-8?B?WFcxT0l0SEJrcU1mWlRxMnJIZ0lFenlrZkVhVVlObnJSbThKMy92dkM5Wkk2?=
 =?utf-8?B?N1FmU2JZNHQ5YlNZaFloOUI1bUtxeWU2cWJhcnlWVUVJd1BFMHpZbGlKQ24y?=
 =?utf-8?B?MCtxdSs4cXJtZzZ6OHJWUlVIRmZqMlNQNmFXM3lYQVZVUkFEY3k5SUl4eFVY?=
 =?utf-8?B?RU81d1ArYlZsN0YrM0ZYbEJ5UkdlR2F2enpWakpCa01QZC9SQmNNekQ2LzBI?=
 =?utf-8?B?c3I2S0NTVERqNStqR0F0SGJsRHVQa2JuUjc5Mll4ak1NZnAzMFF3MnVIakpw?=
 =?utf-8?B?SXdiR01vWjZnQ2pmVlc2UmpHSzBrUGovdTdBOHJtRDVrOENlOHV1TVNxV2NE?=
 =?utf-8?B?em1jcHVQRk9CN2QvRnZCKzZpOEU1czNIWXhzQ1BnVkFPUVVYbkZWU0hndkhF?=
 =?utf-8?B?ZlZVMGt5NEZhTjgzWVlBeUwrZHIzTlkwUEpINUxqTStpWnFtWlR6ZzZqTUVp?=
 =?utf-8?B?V29HL2xWY3h4UWRHU3FjUHExellzdVZyMEdWenF3QzF1amRvTG5EVm5VMy9l?=
 =?utf-8?B?WmgwMXVBUE52aWhRc3VCWDg1YTQzUXZ0d2RqSC9aWlFzVkJRUGs2aEtMYjJC?=
 =?utf-8?B?WG1ReGJDZTY2ZzA4QWZXV1dJclRrMHFHT3IvWnZjTTgzWUlTeWxxMTM3OURa?=
 =?utf-8?B?ZzlFVnVuRC9QWHQ2VmpQamNYWDNpMW9SN2ZWWWI3KzkxVHAvMWs0OHNLNVZi?=
 =?utf-8?B?Mk5xK3ZOa3JmM0JWTmxYc1NkdU0vRWNKc29OcFRqWGx1T3UzdlQ3Q0dQSFdG?=
 =?utf-8?B?Sm9Uc1RjbXFBK3FrTzdoa0ttVUFoNlp5dFJhZjhQNXk0WjUyaGpMV3B1Wktp?=
 =?utf-8?B?dE96NDI2RWxjeldscm9yQnc3UWVhT1ZiRUhKbXI4NGJXMHBDRlJPVUlFSTly?=
 =?utf-8?B?aENkU214cFI0QTFLNzBjeEdLWGJydzdLZDFVRytEaDhWblFKYXdRUXpZSU5s?=
 =?utf-8?B?QVJWR2RGdmdkelgvZ3BNdkk3dnppWkVicm9yWDREWW9PREZGcjV1a2FNcXdu?=
 =?utf-8?B?azU2S3ZiblNWNGJBT201cUZkTWE1eDhpSDZQWHFHcXd4VC9tWk9FQU1KMW0y?=
 =?utf-8?B?cHpFd3p3VnlwUlM0dTJ3MmUwd1ZWUEdITmdCcU5pRGtZM1cyY0ZXVFJkeExk?=
 =?utf-8?B?ZXFEMnZveWpxSElITVY0Y0VpV1dDU2NqNU1pK0daTzBZWFRtc0twOCs5Q3ZW?=
 =?utf-8?B?V2xmNEdMZ1E4S2NRWDF5YklwQUhXMWZhN3V5b01lMFhLU0JDVkxHdFExbFUw?=
 =?utf-8?B?bm5VOHBCV0JOd0xsaDdZWmJaNnFZdlRicjlVdkI0dlFPc2dKNDdHcTRBT21G?=
 =?utf-8?B?dnBpSEkydHdVUGhaY3dPbmV0cGo0ZUVIZDh2K0YwMnFya25TcGR0S2J2LzRp?=
 =?utf-8?B?Um51RzNPYUVqbGtEWmRvUC9NbmVwK0l4S2F0MWRvSGNYblZDbVNTZlBiMVZI?=
 =?utf-8?B?MmUrOTVYUEE0Q3djQXU4YlViT3BYTWwvNHg3YXpZemV1RkJ5YjJ4N3BEMi9k?=
 =?utf-8?B?NUl5WW5JQTA4MitIYnF1UHkxWHJyRWlNYjlWa3BDSkVMTUxiVEhONlphUWFP?=
 =?utf-8?B?dUJaSENoSjBXbUorSUZyQXdXRXhEVnFWbldZVUJ3NlJJaW9lN1c1MHZYYjdJ?=
 =?utf-8?B?dS8zNVFEbkNpZ2lxRjFnWkQwZFB5MThtY3h5K0ZnSDI1cjlQVjR3eStkbUk3?=
 =?utf-8?B?bFlxaVN3eUdwSXhXZGZQSS85emNTK2dlU1hWWjN5ZFEvcWJaaHhMTmVzTHQ4?=
 =?utf-8?B?UU5LakdONit4bzlaOE9GaDZnaWdnU0wvNHBXMVFqS0J1VHN4VTlzQ0xBUW5i?=
 =?utf-8?B?a3QwMjJvTWtWK3J5SnkrS3QzU1h3bCt1WmhkZTZidU5zbGZsRjhPTWplcU5Q?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAF60A34C204E8439885465618ED0EA3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CuGD7BGQJwtocsLUDCSvVIA1dnbmi+hFoiBRShjkayG8rNSS+mpw/xwJdmRgQsQa/EM+25qCm28H7/NCFza4+JclqrFX35x7dHGUE2PYrvATrQYmnAMHFPidriXC1zb+S9pqc9CBME0Aq7BJRqeuILalbYxFjdMmzmPFRVj+KehpeHBR7N3cOwhd33wYvQlV5d0gH3ugk4Uh+oW/4lrDYmhXdSi/1zOT28iSog00MRhzpp/wPMEL++ZJrH1eXylOASE2lQZ4Yr++0WU/YKxVoXTBKfadDlU7PD0YDTXMEmtEu4TSVkKH/KDDdXTFDVy+ZuJX8G0OOVP6EMb+ebBvNQj4F0zRFSTH+jHfke/Br5yTklDaZC5cWYpKJA3AVvTNT2XCWuOUI7fyfs1JTM6FNOTZ8NFOt0jWrxHE3oi+07796nqaWss7vpzEKYjGaJ1QIpXIG7DYEaQ3J5zGAPUR31r+F2oktUDV+ibS4NsNvW54sMtXTihjvHV5I/4iFiZKPZHQ+QNIKVQkt6HdU4OhUDTTmfG8ESdz8cLv8iyfFE21eRelPhNu87+Uaq/r+XTHIUUIl+xcxCI2jPH4X8R4ZMcgTaWFcK8X78D+1T2dA/vvkdsmXpZ4F/d9509KwUCJPkDrJa789nYaCXVajwU9gw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ac438e-7976-4b30-edc5-08dc63fc51eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 01:17:33.7070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iy9tVvQocF+Al9rR7uh4ureEeELWjOgH1mCEoma3PjDx7WI0uRDtlBQxWsrL+zV+1ZV+RhgUCX0HNybzHwuVzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
X-Proofpoint-GUID: ylZmaPC1sN5OWcByTsm34ySYjQhgvqAo
X-Proofpoint-ORIG-GUID: ylZmaPC1sN5OWcByTsm34ySYjQhgvqAo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_20,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240005

T24gU2F0LCBBcHIgMjAsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IE9uIG11bHRp
cG9ydCBzdXBwb3J0ZWQgY29udHJvbGxlcnMsIGVhY2ggcG9ydCBoYXMgaXRzIG93biBEUC9ETSBh
bmQNCj4gU3VwZXJTcGVlZCAoaWYgc3VwZXIgc3BlZWQgY2FwYWJsZSkgaW50ZXJydXB0cy4gQXMg
cGVyIHRoZSBiaW5kaW5ncywNCj4gdGhlaXIgaW50ZXJydXB0IG5hbWVzIGRpZmZlciBmcm9tIHNp
bmdsZS1wb3J0IG9uZXMgYnkgaGF2aW5nIGEgIl94Ig0KPiBhZGRlZCBhcyBzdWZmaXggKHggYmVp
bmcgdGhlIHBvcnQgbnVtYmVyKS4gSWRlbnRpZnkgZnJvbSB0aGUgaW50ZXJydXB0DQo+IG5hbWVz
IHdoZXRoZXIgdGhlIGNvbnRyb2xsZXIgaXMgYSBtdWx0aXBvcnQgY29udHJvbGxlciBvciBub3Qu
DQo+IFJlZmFjdG9yIGR3YzNfcWNvbV9zZXR1cF9pcnEoKSBjYWxsIHRvIHBhcnNlIG11bHRpcG9y
dGludGVycnVwdHMgYWxvbmcNCj4gd2l0aCBub24tbXVsdGlwb3J0IG9uZXMgYWNjb3JkaW5nbHku
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2tyaXNrdXJhQHF1
aWNpbmMuY29tPg0KPiBSZXZpZXdlZC1ieTogQmpvcm4gQW5kZXJzc29uIDxxdWljX2Jqb3JhbmRl
QHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMgfCAx
NDAgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxMDYgaW5zZXJ0aW9ucygrKSwgMzQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29t
LmMNCj4gaW5kZXggY2FlNWRhYjhmY2ZjLi41ZGRiNjk0ZGQ4ZTcgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2Mz
LXFjb20uYw0KPiBAQCAtNTIsNiArNTIsMTYgQEANCj4gICNkZWZpbmUgQVBQU19VU0JfQVZHX0JX
IDANCj4gICNkZWZpbmUgQVBQU19VU0JfUEVBS19CVyBNQnBzX3RvX2ljYyg0MCkNCj4gIA0KPiAr
LyogUXVhbGNvbW0gU29DcyB3aXRoIG11bHRpcG9ydCBzdXBwb3J0IGhhcyB1cCB0byA0IHBvcnRz
ICovDQo+ICsjZGVmaW5lIERXQzNfUUNPTV9NQVhfUE9SVFMJNA0KPiArDQo+ICtzdHJ1Y3QgZHdj
M19xY29tX3BvcnQgew0KPiArCWludAkJCXF1c2IyX3BoeV9pcnE7DQo+ICsJaW50CQkJZHBfaHNf
cGh5X2lycTsNCj4gKwlpbnQJCQlkbV9oc19waHlfaXJxOw0KPiArCWludAkJCXNzX3BoeV9pcnE7
DQo+ICt9Ow0KPiArDQo+ICBzdHJ1Y3QgZHdjM19xY29tIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlCQkq
ZGV2Ow0KPiAgCXZvaWQgX19pb21lbQkJKnFzY3JhdGNoX2Jhc2U7DQo+IEBAIC01OSwxMSArNjks
OCBAQCBzdHJ1Y3QgZHdjM19xY29tIHsNCj4gIAlzdHJ1Y3QgY2xrCQkqKmNsa3M7DQo+ICAJaW50
CQkJbnVtX2Nsb2NrczsNCj4gIAlzdHJ1Y3QgcmVzZXRfY29udHJvbAkqcmVzZXRzOw0KPiAtDQo+
IC0JaW50CQkJcXVzYjJfcGh5X2lycTsNCj4gLQlpbnQJCQlkcF9oc19waHlfaXJxOw0KPiAtCWlu
dAkJCWRtX2hzX3BoeV9pcnE7DQo+IC0JaW50CQkJc3NfcGh5X2lycTsNCj4gKwlzdHJ1Y3QgZHdj
M19xY29tX3BvcnQJcG9ydHNbRFdDM19RQ09NX01BWF9QT1JUU107DQo+ICsJdTgJCQludW1fcG9y
dHM7DQo+ICAJZW51bSB1c2JfZGV2aWNlX3NwZWVkCXVzYjJfc3BlZWQ7DQo+ICANCj4gIAlzdHJ1
Y3QgZXh0Y29uX2RldgkqZWRldjsNCj4gQEAgLTM1NCwyNCArMzYxLDI0IEBAIHN0YXRpYyB2b2lk
IGR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEoaW50IGlycSkNCj4gIA0KPiAgc3RhdGljIHZv
aWQgZHdjM19xY29tX2Rpc2FibGVfaW50ZXJydXB0cyhzdHJ1Y3QgZHdjM19xY29tICpxY29tKQ0K
PiAgew0KPiAtCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+cXVzYjJfcGh5X2ly
cSk7DQo+ICsJZHdjM19xY29tX2Rpc2FibGVfd2FrZXVwX2lycShxY29tLT5wb3J0c1swXS5xdXNi
Ml9waHlfaXJxKTsNCj4gIA0KPiAgCWlmIChxY29tLT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9M
T1cpIHsNCj4gLQkJZHdjM19xY29tX2Rpc2FibGVfd2FrZXVwX2lycShxY29tLT5kbV9oc19waHlf
aXJxKTsNCj4gKwkJZHdjM19xY29tX2Rpc2FibGVfd2FrZXVwX2lycShxY29tLT5wb3J0c1swXS5k
bV9oc19waHlfaXJxKTsNCj4gIAl9IGVsc2UgaWYgKChxY29tLT51c2IyX3NwZWVkID09IFVTQl9T
UEVFRF9ISUdIKSB8fA0KPiAgCQkJKHFjb20tPnVzYjJfc3BlZWQgPT0gVVNCX1NQRUVEX0ZVTEwp
KSB7DQo+IC0JCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+ZHBfaHNfcGh5X2ly
cSk7DQo+ICsJCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+cG9ydHNbMF0uZHBf
aHNfcGh5X2lycSk7DQo+ICAJfSBlbHNlIHsNCj4gLQkJZHdjM19xY29tX2Rpc2FibGVfd2FrZXVw
X2lycShxY29tLT5kcF9oc19waHlfaXJxKTsNCj4gLQkJZHdjM19xY29tX2Rpc2FibGVfd2FrZXVw
X2lycShxY29tLT5kbV9oc19waHlfaXJxKTsNCj4gKwkJZHdjM19xY29tX2Rpc2FibGVfd2FrZXVw
X2lycShxY29tLT5wb3J0c1swXS5kcF9oc19waHlfaXJxKTsNCj4gKwkJZHdjM19xY29tX2Rpc2Fi
bGVfd2FrZXVwX2lycShxY29tLT5wb3J0c1swXS5kbV9oc19waHlfaXJxKTsNCj4gIAl9DQo+ICAN
Cj4gLQlkd2MzX3Fjb21fZGlzYWJsZV93YWtldXBfaXJxKHFjb20tPnNzX3BoeV9pcnEpOw0KPiAr
CWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+cG9ydHNbMF0uc3NfcGh5X2lycSk7
DQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIGR3YzNfcWNvbV9lbmFibGVfaW50ZXJydXB0cyhz
dHJ1Y3QgZHdjM19xY29tICpxY29tKQ0KPiAgew0KPiAtCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVw
X2lycShxY29tLT5xdXNiMl9waHlfaXJxLCAwKTsNCj4gKwlkd2MzX3Fjb21fZW5hYmxlX3dha2V1
cF9pcnEocWNvbS0+cG9ydHNbMF0ucXVzYjJfcGh5X2lycSwgMCk7DQo+ICANCj4gIAkvKg0KPiAg
CSAqIENvbmZpZ3VyZSBEUC9ETSBsaW5lIGludGVycnVwdHMgYmFzZWQgb24gdGhlIFVTQjIgZGV2
aWNlIGF0dGFjaGVkIHRvDQo+IEBAIC0zODMsMjAgKzM5MCwyMCBAQCBzdGF0aWMgdm9pZCBkd2Mz
X3Fjb21fZW5hYmxlX2ludGVycnVwdHMoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSkNCj4gIAkgKi8N
Cj4gIA0KPiAgCWlmIChxY29tLT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9MT1cpIHsNCj4gLQkJ
ZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHFjb20tPmRtX2hzX3BoeV9pcnEsDQo+IC0JCQkJ
CQlJUlFfVFlQRV9FREdFX0ZBTExJTkcpOw0KPiArCQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9p
cnEocWNvbS0+cG9ydHNbMF0uZG1faHNfcGh5X2lycSwNCj4gKwkJCQkJICAgIElSUV9UWVBFX0VE
R0VfRkFMTElORyk7DQo+ICAJfSBlbHNlIGlmICgocWNvbS0+dXNiMl9zcGVlZCA9PSBVU0JfU1BF
RURfSElHSCkgfHwNCj4gIAkJCShxY29tLT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9GVUxMKSkg
ew0KPiAtCQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocWNvbS0+ZHBfaHNfcGh5X2lycSwN
Cj4gLQkJCQkJCUlSUV9UWVBFX0VER0VfRkFMTElORyk7DQo+ICsJCWR3YzNfcWNvbV9lbmFibGVf
d2FrZXVwX2lycShxY29tLT5wb3J0c1swXS5kcF9oc19waHlfaXJxLA0KPiArCQkJCQkgICAgSVJR
X1RZUEVfRURHRV9GQUxMSU5HKTsNCj4gIAl9IGVsc2Ugew0KPiAtCQlkd2MzX3Fjb21fZW5hYmxl
X3dha2V1cF9pcnEocWNvbS0+ZHBfaHNfcGh5X2lycSwNCj4gLQkJCQkJCUlSUV9UWVBFX0VER0Vf
UklTSU5HKTsNCj4gLQkJZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHFjb20tPmRtX2hzX3Bo
eV9pcnEsDQo+IC0JCQkJCQlJUlFfVFlQRV9FREdFX1JJU0lORyk7DQo+ICsJCWR3YzNfcWNvbV9l
bmFibGVfd2FrZXVwX2lycShxY29tLT5wb3J0c1swXS5kcF9oc19waHlfaXJxLA0KPiArCQkJCQkg
ICAgSVJRX1RZUEVfRURHRV9SSVNJTkcpOw0KPiArCQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9p
cnEocWNvbS0+cG9ydHNbMF0uZG1faHNfcGh5X2lycSwNCj4gKwkJCQkJICAgIElSUV9UWVBFX0VE
R0VfUklTSU5HKTsNCj4gIAl9DQo+ICANCj4gLQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEo
cWNvbS0+c3NfcGh5X2lycSwgMCk7DQo+ICsJZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHFj
b20tPnBvcnRzWzBdLnNzX3BoeV9pcnEsIDApOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgaW50IGR3
YzNfcWNvbV9zdXNwZW5kKHN0cnVjdCBkd2MzX3Fjb20gKnFjb20sIGJvb2wgd2FrZXVwKQ0KPiBA
QCAtNTE3LDQyICs1MjQsMTA3IEBAIHN0YXRpYyBpbnQgZHdjM19xY29tX3JlcXVlc3RfaXJxKHN0
cnVjdCBkd2MzX3Fjb20gKnFjb20sIGludCBpcnEsDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4g
IA0KPiAtc3RhdGljIGludCBkd2MzX3Fjb21fc2V0dXBfaXJxKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQo+ICtzdGF0aWMgaW50IGR3YzNfcWNvbV9zZXR1cF9wb3J0X2lycShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2LCBpbnQgcG9ydF9pbmRleCwgYm9vbCBpc19tdWx0aXBvcnQp
DQo+ICB7DQo+ICAJc3RydWN0IGR3YzNfcWNvbSAqcWNvbSA9IHBsYXRmb3JtX2dldF9kcnZkYXRh
KHBkZXYpOw0KPiArCWNvbnN0IGNoYXIgKmlycV9uYW1lOw0KPiAgCWludCBpcnE7DQo+ICAJaW50
IHJldDsNCj4gIA0KPiAtCWlycSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lX29wdGlvbmFsKHBk
ZXYsICJxdXNiMl9waHkiKTsNCj4gKwlpZiAoaXNfbXVsdGlwb3J0KQ0KPiArCQlpcnFfbmFtZSA9
IGRldm1fa2FzcHJpbnRmKCZwZGV2LT5kZXYsIEdGUF9LRVJORUwsICJkcF9oc19waHlfJWQiLCBw
b3J0X2luZGV4ICsgMSk7DQo+ICsJZWxzZQ0KPiArCQlpcnFfbmFtZSA9IGRldm1fa2FzcHJpbnRm
KCZwZGV2LT5kZXYsIEdGUF9LRVJORUwsICJkcF9oc19waHlfaXJxIik7DQo+ICsJaWYgKCFpcnFf
bmFtZSkNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKwlpcnEgPSBwbGF0Zm9ybV9nZXRf
aXJxX2J5bmFtZV9vcHRpb25hbChwZGV2LCBpcnFfbmFtZSk7DQo+ICAJaWYgKGlycSA+IDApIHsN
Cj4gLQkJcmV0ID0gZHdjM19xY29tX3JlcXVlc3RfaXJxKHFjb20sIGlycSwgInF1c2IyX3BoeSIp
Ow0KPiArCQlyZXQgPSBkd2MzX3Fjb21fcmVxdWVzdF9pcnEocWNvbSwgaXJxLCBpcnFfbmFtZSk7
DQo+ICAJCWlmIChyZXQpDQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiAtCQlxY29tLT5xdXNiMl9waHlf
aXJxID0gaXJxOw0KPiArCQlxY29tLT5wb3J0c1twb3J0X2luZGV4XS5kcF9oc19waHlfaXJxID0g
aXJxOw0KPiAgCX0NCj4gIA0KPiAtCWlycSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lX29wdGlv
bmFsKHBkZXYsICJkcF9oc19waHlfaXJxIik7DQo+ICsJaWYgKGlzX211bHRpcG9ydCkNCj4gKwkJ
aXJxX25hbWUgPSBkZXZtX2thc3ByaW50ZigmcGRldi0+ZGV2LCBHRlBfS0VSTkVMLCAiZG1faHNf
cGh5XyVkIiwgcG9ydF9pbmRleCArIDEpOw0KPiArCWVsc2UNCj4gKwkJaXJxX25hbWUgPSBkZXZt
X2thc3ByaW50ZigmcGRldi0+ZGV2LCBHRlBfS0VSTkVMLCAiZG1faHNfcGh5X2lycSIpOw0KPiAr
CWlmICghaXJxX25hbWUpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJaXJxID0gcGxh
dGZvcm1fZ2V0X2lycV9ieW5hbWVfb3B0aW9uYWwocGRldiwgaXJxX25hbWUpOw0KPiAgCWlmIChp
cnEgPiAwKSB7DQo+IC0JCXJldCA9IGR3YzNfcWNvbV9yZXF1ZXN0X2lycShxY29tLCBpcnEsICJk
cF9oc19waHlfaXJxIik7DQo+ICsJCXJldCA9IGR3YzNfcWNvbV9yZXF1ZXN0X2lycShxY29tLCBp
cnEsIGlycV9uYW1lKTsNCj4gIAkJaWYgKHJldCkNCj4gIAkJCXJldHVybiByZXQ7DQo+IC0JCXFj
b20tPmRwX2hzX3BoeV9pcnEgPSBpcnE7DQo+ICsJCXFjb20tPnBvcnRzW3BvcnRfaW5kZXhdLmRt
X2hzX3BoeV9pcnEgPSBpcnE7DQo+ICAJfQ0KPiAgDQo+IC0JaXJxID0gcGxhdGZvcm1fZ2V0X2ly
cV9ieW5hbWVfb3B0aW9uYWwocGRldiwgImRtX2hzX3BoeV9pcnEiKTsNCj4gKwlpZiAoaXNfbXVs
dGlwb3J0KQ0KPiArCQlpcnFfbmFtZSA9IGRldm1fa2FzcHJpbnRmKCZwZGV2LT5kZXYsIEdGUF9L
RVJORUwsICJzc19waHlfJWQiLCBwb3J0X2luZGV4ICsgMSk7DQo+ICsJZWxzZQ0KPiArCQlpcnFf
bmFtZSA9IGRldm1fa2FzcHJpbnRmKCZwZGV2LT5kZXYsIEdGUF9LRVJORUwsICJzc19waHlfaXJx
Iik7DQo+ICsJaWYgKCFpcnFfbmFtZSkNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKwlp
cnEgPSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbChwZGV2LCBpcnFfbmFtZSk7DQo+
ICAJaWYgKGlycSA+IDApIHsNCj4gLQkJcmV0ID0gZHdjM19xY29tX3JlcXVlc3RfaXJxKHFjb20s
IGlycSwgImRtX2hzX3BoeV9pcnEiKTsNCj4gKwkJcmV0ID0gZHdjM19xY29tX3JlcXVlc3RfaXJx
KHFjb20sIGlycSwgaXJxX25hbWUpOw0KPiAgCQlpZiAocmV0KQ0KPiAgCQkJcmV0dXJuIHJldDsN
Cj4gLQkJcWNvbS0+ZG1faHNfcGh5X2lycSA9IGlycTsNCj4gKwkJcWNvbS0+cG9ydHNbcG9ydF9p
bmRleF0uc3NfcGh5X2lycSA9IGlycTsNCj4gIAl9DQo+ICANCj4gLQlpcnEgPSBwbGF0Zm9ybV9n
ZXRfaXJxX2J5bmFtZV9vcHRpb25hbChwZGV2LCAic3NfcGh5X2lycSIpOw0KPiArCWlmIChpc19t
dWx0aXBvcnQpDQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICsJaXJxID0gcGxhdGZvcm1fZ2V0X2ly
cV9ieW5hbWVfb3B0aW9uYWwocGRldiwgInF1c2IyX3BoeSIpOw0KPiAgCWlmIChpcnEgPiAwKSB7
DQo+IC0JCXJldCA9IGR3YzNfcWNvbV9yZXF1ZXN0X2lycShxY29tLCBpcnEsICJzc19waHlfaXJx
Iik7DQo+ICsJCXJldCA9IGR3YzNfcWNvbV9yZXF1ZXN0X2lycShxY29tLCBpcnEsICJxdXNiMl9w
aHkiKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCXJldHVybiByZXQ7DQo+ICsJCXFjb20tPnBvcnRz
W3BvcnRfaW5kZXhdLnF1c2IyX3BoeV9pcnEgPSBpcnE7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJu
IDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgZHdjM19xY29tX2ZpbmRfbnVtX3BvcnRzKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICt7DQo+ICsJY2hhciBpcnFfbmFtZVsxNF07
DQo+ICsJaW50IHBvcnRfbnVtOw0KPiArCWludCBpcnE7DQo+ICsNCj4gKwlpcnEgPSBwbGF0Zm9y
bV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbChwZGV2LCAiZHBfaHNfcGh5XzEiKTsNCj4gKwlpZiAo
aXJxIDw9IDApDQo+ICsJCXJldHVybiAxOw0KPiArDQo+ICsJZm9yIChwb3J0X251bSA9IDI7IHBv
cnRfbnVtIDw9IERXQzNfUUNPTV9NQVhfUE9SVFM7IHBvcnRfbnVtKyspIHsNCj4gKwkJc3ByaW50
ZihpcnFfbmFtZSwgImRwX2hzX3BoeV8lZCIsIHBvcnRfbnVtKTsNCj4gKw0KPiArCQlpcnEgPSBw
bGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbChwZGV2LCBpcnFfbmFtZSk7DQo+ICsJCWlm
IChpcnEgPD0gMCkNCj4gKwkJCXJldHVybiBwb3J0X251bSAtIDE7DQo+ICsJfQ0KPiArDQo+ICsJ
cmV0dXJuIERXQzNfUUNPTV9NQVhfUE9SVFM7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgZHdj
M19xY29tX3NldHVwX2lycShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiArew0KPiAr
CXN0cnVjdCBkd2MzX3Fjb20gKnFjb20gPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4g
Kwlib29sIGlzX211bHRpcG9ydDsNCj4gKwlpbnQgcmV0Ow0KPiArCWludCBpOw0KPiArDQo+ICsJ
cWNvbS0+bnVtX3BvcnRzID0gZHdjM19xY29tX2ZpbmRfbnVtX3BvcnRzKHBkZXYpOw0KPiArCWlz
X211bHRpcG9ydCA9IChxY29tLT5udW1fcG9ydHMgPiAxKTsNCj4gKw0KPiArCWZvciAoaSA9IDA7
IGkgPCBxY29tLT5udW1fcG9ydHM7IGkrKykgew0KPiArCQlyZXQgPSBkd2MzX3Fjb21fc2V0dXBf
cG9ydF9pcnEocGRldiwgaSwgaXNfbXVsdGlwb3J0KTsNCj4gIAkJaWYgKHJldCkNCj4gIAkJCXJl
dHVybiByZXQ7DQo+IC0JCXFjb20tPnNzX3BoeV9pcnEgPSBpcnE7DQo+ICAJfQ0KPiAgDQo+ICAJ
cmV0dXJuIDA7DQo+IC0tIA0KPiAyLjM0LjENCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4g
PFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

