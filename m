Return-Path: <linux-kernel+bounces-67859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ED98571F0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5D32810FE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA501468EE;
	Thu, 15 Feb 2024 23:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NQ+CSNvB";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gMnUYjmf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dp/eCA2f"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F7D146011;
	Thu, 15 Feb 2024 23:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040982; cv=fail; b=sNTrd+N4Z+OItXTIFSPBuo+hQ2TlSjOLWeCpaXCfmuNMJEa8eYjYZcjbcDgpVy6VdcHUXLrOzSUUn4ugiJEVLPqswI93qsCB+jg4EwOiQOgVFgoji7g43q5hMM/5Egh0wcA6GA2omBRY/Gf81FgqF4Fdj/6XxImGjZdeLVotJIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040982; c=relaxed/simple;
	bh=hrK8z5rH+3LXzacGl8XK/6B/gPrE6yR38XNh0l203vY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FJLE38KgE/Tc8QK5XIGx+4vH1guO3r0MAxAFwJGuIiQcZUOLuCyKMtPy4u6vhpRqaqjpuUTG+fjn66zUb5BPbOgKX5ih25MA70Y+PFe4yC2yQYsdairzdSBw0ZtgYXPSBLqsg9bPzOHFxCTIycrncnl8Sva9D2LUCasnqvvjVv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NQ+CSNvB; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gMnUYjmf; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=dp/eCA2f reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FNXf5e005107;
	Thu, 15 Feb 2024 15:49:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=hrK8z5rH+3LXzacGl8XK/6B/gPrE6yR38XNh0l203vY=; b=
	NQ+CSNvBtim74IPaNJp8iULeAVTjaK41y42UnyCxa3uKrNG/Arq3dufmLSz055/+
	ADDDBwRjSQYMmJVfB9hV4VTcDC0XWVF3MD49VRdHOeul9JcdH79ONBMsJAZqAxZa
	Yzp7Njjs7SNbF8S7XdbHDMoS8Q5ZfoSbr2WXH1Jo6LklvXrkEeqIYgrnOlcV2/kg
	f8sCX+QIBJgYUchDhLye9sdj6sROVj8/ZxiQUZ76Mf3aBIO4s3QlSk/S1Aknd5GM
	gE78Y89xy4rKiNk4817FPJwRcLnnJADXu5hkXSdNRsLn8ZmirkofFFu1lSkhh1Ep
	pfwPE0v0SqFRm1wK/6IGig==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3w9gq7320y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 15:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708040969; bh=hrK8z5rH+3LXzacGl8XK/6B/gPrE6yR38XNh0l203vY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gMnUYjmfhPlOD4PQDwZgh6atcf21xzmEzTDxAREVU5KfM4cMeD5Lnq9vEReFZW+IF
	 sy1asxab1+Nl/DxLumN+wz5zHnqy5xlVPZxIgzxRQ3ECAHoQq4h7KuC9rSEuGWUmJ4
	 PFMblpo2jEuAmBWzknRsdR0uXY4BHIVlDaBU+pItH+ISUBSLz2ELuDXw1RlpOrWLY+
	 i1PNonfplcvTiz2nRIH3Al/sFvVW5NeLB0x9OI1Nh9wfPjb7gCpjuECJdVQQchaurQ
	 IT1Z6udQ4CAi2Uy6Iz8HNPGOgg/Vz2Yi7tDI/zARpRCQD3jy1z9l+KcrZ3UWyQzsi7
	 sMfnxTUprUl6A==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6FE454035F;
	Thu, 15 Feb 2024 23:49:29 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A08E8A0073;
	Thu, 15 Feb 2024 23:49:28 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=dp/eCA2f;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D07534044C;
	Thu, 15 Feb 2024 23:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3kK+YuMLAh11SPA8aTzANLgvnbW3X+m521QHvsjLiHcPdV+PfbhC3/SEmgY3VPwaDTbTSYc/4Envy7a88HiqhE5GmV5m0Bw+9BR2ddLOTgoelzJoAv+YNUF9rAX1saQ3IdKb30bns916UUbi9qhfKJ6JHiyhgH3OdNLVe9WWcppi+IOkVSx3eXPHmc8e8FJzKWN1KRKrwjILbIQVkeUriplG9P5A1bZmSUCM+Dou9eCEFNZOydY06a24cqD8jEOkSiI4ZLhR1hFd7fcPCPNjhtJF7tjRnDHiE7tMmRoId2DxFZTX+ZriBOUdFfpc47OL2hvuWOCcQoygoYSO9Pb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrK8z5rH+3LXzacGl8XK/6B/gPrE6yR38XNh0l203vY=;
 b=gWh4Wg2Teze3e6jZEVikXkyRljAYdRc0mNDtCcA8YnLhnLZmDF6Uv0P/iLo4W7Qc///BcqdLFXHaBkl+hCLyQkUmXbxCTedVZ2kqkOmN96W68tB0Yig214WQ0nWcV2Vg6crLFqbLqUyZSHYQnlVOzDTvihqxEeQ+u20bAHUwkUe5qARd16/oTM2qEwQ/IlLwNzYz50oIj5dbTmpSX2J7FJMW9B3MnChK3lqTY+n6TfrxQuz29pjSplnMUw3f9JoeUfbWlyzRF486d2KAr4BANYRmmlHtrTeSYT+S9x3eIF/yrT0IoAFRh8iujooVZI7DP955xv51o1BxUIonqDLV8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrK8z5rH+3LXzacGl8XK/6B/gPrE6yR38XNh0l203vY=;
 b=dp/eCA2fSrU6DSdm68aAGr9zc8nDDhz6+PM0Cd1ask2swfd1xCueImlFwrqZZnaBI+aCWcuPl9ytlaEt+lMi6Fgj7j5rn4In5W45OQ9aptAB98vQF7McBD3orPbInNdv2G560AZ6W3LbdYElEJ9pNOHb9inBC/rovdh44DQFktY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.18; Thu, 15 Feb
 2024 23:49:24 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 23:49:24 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v14 8/9] usb: dwc3: qcom: Enable wakeup for applicable
 ports of multiport
Thread-Topic: [PATCH v14 8/9] usb: dwc3: qcom: Enable wakeup for applicable
 ports of multiport
Thread-Index: AQHaWLwU09uMLZ+kTkGABwzzUt4ourEMIbcA
Date: Thu, 15 Feb 2024 23:49:24 +0000
Message-ID: <20240215234920.iz62rjm2w54plesz@synopsys.com>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-9-quic_kriskura@quicinc.com>
In-Reply-To: <20240206051825.1038685-9-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB5070:EE_
x-ms-office365-filtering-correlation-id: 0483334d-e13c-4ff9-2f3e-08dc2e80bd3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mr+vatuX4E3/jJkCQih/LJDYD0uKPM91D9xuF6CI9xzYMzXF7woia7AGN7wl+FsfR2lXjT4EqEQ6/sczBi4Im9fkJQJpV9JofO8i/BtN24kOMCXyLS5kQUN5HLcO/EhD3yb/vEmblASnm6n9CJp7omZS0ZnPjDhlAs+vAeZynFCbwTuJ7T05Llz7procb9O6nGOke6uIaynXDstoEypGF/wwtuJRWDs1eoJTLdMSNcF/MVwz4KEbvAVHs5YymMsU3tBHqXomXhfU3bKuZgfQTb0aFsRMK0oFkuyvu5bPBkJD7t4gk5zCI649zC2cMD/+Y6AZsU4ukw3DZ1fb+nrV9gXIcAH00zeImtoYhEH2Vs/XTdbaWeyeFt6MBZ9x6uNxmB1zcFYkpgLuxhxcSxpjptXQOJwcNEknaLtCcrrK+/zotIrzST1g+OWg+xI5EhOUnacnYfUCOmVXdNr5wvQKdoShSQU2xwnpUNZDLpfG75wA1lbxPefI3UeTgws/h/m2Q76DY0mB3kBGURjWz9EcqG4mERUuSQCDBGqAlT+jI0q4r0ggvwx8HfOZOlLYTUd2ohuuXoNUPipE681J3rKYYdor4n7vc6I08I91QLskoJEkfimClBwg1TVtJ3sWKJXw
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(8936002)(5660300002)(86362001)(8676002)(2906002)(4326008)(7416002)(2616005)(26005)(83380400001)(66446008)(1076003)(38100700002)(36756003)(122000001)(38070700009)(66946007)(64756008)(316002)(6916009)(6506007)(66476007)(71200400001)(76116006)(66556008)(54906003)(6486002)(6512007)(478600001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Vk1Zb254VUZrRzdvTHA2VkRweXA1d0FzL0oveWQydXdyUWhJQjc0L1ozYnNt?=
 =?utf-8?B?QlFXQ2t6V2llVjNmZFIxTFRFVVg1Qk1vSFlsTnE0NkI0aWsvTTJ4a0RwYmNL?=
 =?utf-8?B?VmVmcUlBelNGamU5Q2FsdE0zVU04UWUvVGlKQ290ZDJNTUlCSTNQUTJlVENV?=
 =?utf-8?B?Nys1OEFHWmIxTnJuT0M4eXVqeGlXcjB1eitWaFdJOVY2Y0FDY3JhSjQzY3JJ?=
 =?utf-8?B?ZWhHb0I0QXcwdndmQ0w5V2JWRHpSc1hJY0VOVzFXM0ljWnNwYS9hWXZ6c3pS?=
 =?utf-8?B?RHVTUVpjV3R1TFdiWHBHWmxDZGFSV0plaWEvTEVacGk0eWNUc1RKWkE1Q1Bz?=
 =?utf-8?B?ZVh6dUtxMlVKck9XQkRiYWtnWVMxYWhNeUZaVi9ZLzJZNS9acWI2YllQWVRh?=
 =?utf-8?B?T250YjFNaHN5bzBrSVI5TzBKMlMyaHJxRTJUVXVLUXliNElDZzU0a1JGeVQ0?=
 =?utf-8?B?cmo0c3g0dURyS3FDbE92UUVzYWphQ2VSMmhOcjI3QUM5UHRubngwUkhvNFhD?=
 =?utf-8?B?eHdZSHRBLzg2cWRKNzM1dGdtakFudU5UcEl3Q1Z0WjFqcWFzYWJwK1RjV3dT?=
 =?utf-8?B?cVprVUNUeWR6K2t4UXF0Q0VINk5DRHVrdWY5dlNMSitGdkZELzdHZWw5QlRh?=
 =?utf-8?B?Z2ZTWXN2OVRYMmRRTDBkSHVFTU5wMjZNYXdGdTl2bWc4VE5ZRzBXTHk0T1VR?=
 =?utf-8?B?SVBuNnhGblZHWm1McnRhYjEwdVpaWjRacWlGMUxKQWVQa09OUDlDcTZjMWMv?=
 =?utf-8?B?WGV3M3k4RjJQUG5TWTRLMEowNWZUNkl1M01ySUNCU0I1R2FXRlYwblI3U1Ny?=
 =?utf-8?B?MHMzZ0dhNVZFNEhlRzBxK1JCTDVTUU1mU1BCdHh2UDFDZ0tnMlBlYlFYVk9O?=
 =?utf-8?B?V3FzclBxaWdNTEoyYVVEVzJLQUk5eU5Kc0JaeEZUZnBoa2hwaUFLOWV2NERB?=
 =?utf-8?B?c2pmTTdIS1RPa2NEQVNlK1hlTDF6UzBIYzB6YXVXUmozRkVwZk1hQ1VocW54?=
 =?utf-8?B?dlN3OG9ERy9TR2RQRVhjVGVsTCtHVTJOUVZ4bVFpL3FDcDYwZnlob1BHNFpZ?=
 =?utf-8?B?OFV1UEcvYXVPSFZjNXpmWmNjQkVWeWhaajBkVFZMbkh3Wlo3ZEVOK2YydlUy?=
 =?utf-8?B?bkdubDg4aUtoaXJFem1odUVZVDRNamV4YzA2aW9GUXZQdjJZNHhreVJNUjNZ?=
 =?utf-8?B?UTF5TEJzTHE5MjIrdVJHZmx4dU5pSWRDdktiSkRidWwvcEdJZzZycnZPVzZO?=
 =?utf-8?B?Q0xOdnVMOG1mV3BjZWJ6eklmOUNEY3AvY01qeG1IcFhFNUdoak1UNnJtdXBu?=
 =?utf-8?B?ajJkOHd5RUlPNlpUUUFwanhvRjVzM2Fka254Vk5IUmd5bGRDcDhNODczcWJY?=
 =?utf-8?B?RkxSNTUxZVRlVnNRc3lheUZyRDRYNnNscXQ3UW5vUmlDNGtIZlYrWko5bW44?=
 =?utf-8?B?R2kxYnBQNWY5SUhENXVHMU1XelIxcFNoRU90L0svWTQ0S1JjUkUwcFRHOS9p?=
 =?utf-8?B?MFhUY01MMTQ5bFZEYSt4MWRSbCtHQzVETlc3OXdCUjgvREN4bHpERGRVZTUr?=
 =?utf-8?B?Ry94ZlZLQ0xYTVRkMTFSQm1oZjRuMU94VFBydHFBZGtZWWxUQ2IwZmR4Sklh?=
 =?utf-8?B?cWJYVk9zRG5qTlRGdFF2MFJEQUVDdjBZMy9mcDVBdExqUlIyRlFaN3hEMjRn?=
 =?utf-8?B?aGgyUmJsRS9nQmI0VXpraGdWNDk2RVZOaTJyTm0vMnFZckcwMkZOTUNZcTl6?=
 =?utf-8?B?MDRCWEc2T0w3dlBUbGRpQzdWcXR6c0JYKzdvMXcybUM1MXNCSXhsY2t5aG9w?=
 =?utf-8?B?NytRVTFJWloxSlVISzcwL3BHQVlQTTNZakptbVJKcXYveU55Y2dwODFJYTZ1?=
 =?utf-8?B?UE4vek9ZQ3AxYkU0aEwzdFBsY2U2U0Ftd1JENkxIa2VOVi9CZGFueDFvUGFp?=
 =?utf-8?B?TEJEMnFGV01WVzJBRUtkc0tmRjQzS3hZckVqRXhwcDRuZE9rb1VvZHA5eHFS?=
 =?utf-8?B?TjhWZzVlbGR3Q0p1azJQUjRYZVcrUzhBY3J5bkd6VlYyRWpidjZhaDdXdUZJ?=
 =?utf-8?B?WUdoNWx4UXFBQWNkSThuTFVDTkpUZEVpaDBrMzl5Zk8rallXMjZEUXlEc1ZY?=
 =?utf-8?B?Q0RFdDlrWGRnTUVjbkxVSkxWTUFqbjFVYkFkWTNERGVWZWVwMXp5OWpENE9X?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2269E738AE31AB488C670DD4E7D99034@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UHOme6NOVEbD97T/82fNK/X5fz2r/k7elUutPEe7JJAR/iJS10EFp9HFdo3cFwI2VPnMcIBRTbFLR8BwAPGC50vDw5lP8yOiD6jGfj2DsXE/v/0m0c5DOOfPFBqnz3iKyo1lc2eI5QiUG0G6WiuG7Nyi70jEPnJI1HYSVboY8+U7Bzmf1i57gKfV2InZ9H1Ss6G/uBjgWVKJUJtDUIQqJJbg5fFiGYeUuicRyEIjk0jc7ilwSDNv5IB8tBE8hHgleE0oBslgKcpi0VU70dMbkwWLjex9J3Kwpj69Mrcy3b4x0QBbnaWpZ2zchS0Ffccq582y8D2MSu1bcPXA4ORC171PfDASI6W+Y+xpuwHDQioRHa/jWq2wPQQYzdzdKVzQURaLynNpzP/ygqvEUlRP0On+d97XsqzzvgtryahH7upPVDKEeCbgAbJiqQ1UlFW+k98WDx03i6RHhUypTx5AeSbr76Ug8xxL8OPIV1k/TkVnnRHAgCHUk5bCIUumZcb9fV2Q73mWLxHLNL1hPugp4IsDSWVF2aD3rdZHp2qCZqVJa9qZlVjtodOjJJRLziz5s+alvRjb8JXh3c38B1VgMGZnDN41rOcLnEWxUfF3Rj0MeDAK/rMALQHM7p7rEc+Odu7R3PQY4b+OX0Vz1klgPA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0483334d-e13c-4ff9-2f3e-08dc2e80bd3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 23:49:24.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81TY+yrQDKqM9eauq0Jxn0uxSANgSOo1K0f/hItf44J0LU7u/Qlc7V1ng2hxwEFnH7Rg09dwUj/GZkfCoY1SLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
X-Proofpoint-GUID: eislx-ZFc8aQKdzHLJjMyPrKcUxC7zGc
X-Proofpoint-ORIG-GUID: eislx-ZFc8aQKdzHLJjMyPrKcUxC7zGc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=950 suspectscore=0
 phishscore=0 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402150186

T24gVHVlLCBGZWIgMDYsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IERXQzMgUWNv
bSB3cmFwcGVyIGN1cnJlbnRseSBzdXBwb3J0cyBvbmx5IHdha2V1cCBjb25maWd1cmF0aW9uDQo+
IGZvciBzaW5nbGUgcG9ydCBjb250cm9sbGVycy4gUmVhZCBzcGVlZCBvZiBlYWNoIHBvcnQgY29u
bmVjdGVkDQo+IHRvIHRoZSBjb250cm9sbGVyIGFuZCBlbmFibGUgd2FrZXVwIGZvciBlYWNoIG9m
IHRoZW0gYWNjb3JkaW5nbHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRp
IDxxdWljX2tyaXNrdXJhQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMv
ZHdjMy1xY29tLmMgfCA3MiArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5jIGIvZHJpdmVycy91c2Iv
ZHdjMy9kd2MzLXFjb20uYw0KPiBpbmRleCBhMjBkNjNhNzkxYmQuLjU3MmRjM2ZkYWUxMiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYw0KPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MzL2R3YzMtcWNvbS5jDQo+IEBAIC03OCw2ICs3OCw3IEBAIHN0cnVjdCBkd2MzX3Fj
b21fcG9ydCB7DQo+ICAJaW50CQkJZHBfaHNfcGh5X2lycTsNCj4gIAlpbnQJCQlkbV9oc19waHlf
aXJxOw0KPiAgCWludAkJCXNzX3BoeV9pcnE7DQo+ICsJZW51bSB1c2JfZGV2aWNlX3NwZWVkCXVz
YjJfc3BlZWQ7DQo+ICB9Ow0KPiAgDQo+ICBzdHJ1Y3QgZHdjM19xY29tIHsNCj4gQEAgLTMzNiw3
ICszMzcsOCBAQCBzdGF0aWMgYm9vbCBkd2MzX3Fjb21faXNfaG9zdChzdHJ1Y3QgZHdjM19xY29t
ICpxY29tKQ0KPiAgCXJldHVybiBkd2MtPnhoY2k7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBlbnVt
IHVzYl9kZXZpY2Vfc3BlZWQgZHdjM19xY29tX3JlYWRfdXNiMl9zcGVlZChzdHJ1Y3QgZHdjM19x
Y29tICpxY29tKQ0KPiArc3RhdGljIGVudW0gdXNiX2RldmljZV9zcGVlZCBkd2MzX3Fjb21fcmVh
ZF91c2IyX3NwZWVkKHN0cnVjdCBkd2MzX3Fjb20gKnFjb20sDQo+ICsJCQkJCQkgICAgICAgaW50
IHBvcnRfaW5kZXgpDQo+ICB7DQo+ICAJc3RydWN0IGR3YzMgKmR3YyA9IHBsYXRmb3JtX2dldF9k
cnZkYXRhKHFjb20tPmR3YzMpOw0KPiAgCXN0cnVjdCB1c2JfZGV2aWNlICp1ZGV2Ow0KPiBAQCAt
MzQ3LDE0ICszNDksOCBAQCBzdGF0aWMgZW51bSB1c2JfZGV2aWNlX3NwZWVkIGR3YzNfcWNvbV9y
ZWFkX3VzYjJfc3BlZWQoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSkNCj4gIAkgKi8NCj4gIAloY2Qg
PSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShkd2MtPnhoY2kpOw0KPiAgDQo+IC0JLyoNCj4gLQkgKiBJ
dCBpcyBwb3NzaWJsZSB0byBxdWVyeSB0aGUgc3BlZWQgb2YgYWxsIGNoaWxkcmVuIG9mDQo+IC0J
ICogVVNCMi4wIHJvb3QgaHViIHZpYSB1c2JfaHViX2Zvcl9lYWNoX2NoaWxkKCkuIERXQzMgY29k
ZQ0KPiAtCSAqIGN1cnJlbnRseSBzdXBwb3J0cyBvbmx5IDEgcG9ydCBwZXIgY29udHJvbGxlci4g
U28NCj4gLQkgKiB0aGlzIGlzIHN1ZmZpY2llbnQuDQo+IC0JICovDQo+ICAjaWZkZWYgQ09ORklH
X1VTQg0KPiAtCXVkZXYgPSB1c2JfaHViX2ZpbmRfY2hpbGQoaGNkLT5zZWxmLnJvb3RfaHViLCAx
KTsNCj4gKwl1ZGV2ID0gdXNiX2h1Yl9maW5kX2NoaWxkKGhjZC0+c2VsZi5yb290X2h1YiwgcG9y
dF9pbmRleCArIDEpOw0KPiAgI2Vsc2UNCj4gIAl1ZGV2ID0gTlVMTDsNCj4gICNlbmRpZg0KPiBA
QCAtMzg3LDIzICszODMsMjkgQEAgc3RhdGljIHZvaWQgZHdjM19xY29tX2Rpc2FibGVfd2FrZXVw
X2lycShpbnQgaXJxKQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBkd2MzX3Fjb21fZGlzYWJsZV9pbnRl
cnJ1cHRzKHN0cnVjdCBkd2MzX3Fjb20gKnFjb20pDQo+ICB7DQo+ICsJaW50IGk7DQo+ICsNCj4g
IAlkd2MzX3Fjb21fZGlzYWJsZV93YWtldXBfaXJxKHFjb20tPnF1c2IyX3BoeV9pcnEpOw0KPiAg
DQo+IC0JaWYgKHFjb20tPnVzYjJfc3BlZWQgPT0gVVNCX1NQRUVEX0xPVykgew0KPiAtCQlkd2Mz
X3Fjb21fZGlzYWJsZV93YWtldXBfaXJxKHFjb20tPnBvcnRfaW5mb1swXS5kbV9oc19waHlfaXJx
KTsNCj4gLQl9IGVsc2UgaWYgKChxY29tLT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9ISUdIKSB8
fA0KPiAtCQkJKHFjb20tPnVzYjJfc3BlZWQgPT0gVVNCX1NQRUVEX0ZVTEwpKSB7DQo+IC0JCWR3
YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+cG9ydF9pbmZvWzBdLmRwX2hzX3BoeV9p
cnEpOw0KPiAtCX0gZWxzZSB7DQo+IC0JCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNv
bS0+cG9ydF9pbmZvWzBdLmRwX2hzX3BoeV9pcnEpOw0KPiAtCQlkd2MzX3Fjb21fZGlzYWJsZV93
YWtldXBfaXJxKHFjb20tPnBvcnRfaW5mb1swXS5kbV9oc19waHlfaXJxKTsNCj4gLQl9DQo+ICsJ
Zm9yIChpID0gMDsgaSA8IHFjb20tPm51bV9wb3J0czsgaSsrKSB7DQo+ICsJCWlmIChxY29tLT5w
b3J0X2luZm9baV0udXNiMl9zcGVlZCA9PSBVU0JfU1BFRURfTE9XKSB7DQo+ICsJCQlkd2MzX3Fj
b21fZGlzYWJsZV93YWtldXBfaXJxKHFjb20tPnBvcnRfaW5mb1tpXS5kbV9oc19waHlfaXJxKTsN
Cj4gKwkJfSBlbHNlIGlmICgocWNvbS0+cG9ydF9pbmZvW2ldLnVzYjJfc3BlZWQgPT0gVVNCX1NQ
RUVEX0hJR0gpIHx8DQo+ICsJCQkJKHFjb20tPnBvcnRfaW5mb1tpXS51c2IyX3NwZWVkID09IFVT
Ql9TUEVFRF9GVUxMKSkgew0KPiArCQkJZHdjM19xY29tX2Rpc2FibGVfd2FrZXVwX2lycShxY29t
LT5wb3J0X2luZm9baV0uZHBfaHNfcGh5X2lycSk7DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQlkd2Mz
X3Fjb21fZGlzYWJsZV93YWtldXBfaXJxKHFjb20tPnBvcnRfaW5mb1tpXS5kcF9oc19waHlfaXJx
KTsNCj4gKwkJCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+cG9ydF9pbmZvW2ld
LmRtX2hzX3BoeV9pcnEpOw0KPiArCQl9DQo+ICANCj4gLQlkd2MzX3Fjb21fZGlzYWJsZV93YWtl
dXBfaXJxKHFjb20tPnBvcnRfaW5mb1swXS5zc19waHlfaXJxKTsNCj4gKwkJZHdjM19xY29tX2Rp
c2FibGVfd2FrZXVwX2lycShxY29tLT5wb3J0X2luZm9baV0uc3NfcGh5X2lycSk7DQo+ICsJfQ0K
PiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBkd2MzX3Fjb21fZW5hYmxlX2ludGVycnVwdHMoc3Ry
dWN0IGR3YzNfcWNvbSAqcWNvbSkNCj4gIHsNCj4gKwlpbnQgaTsNCj4gKw0KPiAgCWR3YzNfcWNv
bV9lbmFibGVfd2FrZXVwX2lycShxY29tLT5xdXNiMl9waHlfaXJxLCAwKTsNCj4gIA0KPiAgCS8q
DQo+IEBAIC00MTQsMjIgKzQxNiwyNCBAQCBzdGF0aWMgdm9pZCBkd2MzX3Fjb21fZW5hYmxlX2lu
dGVycnVwdHMoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSkNCj4gIAkgKiBkaXNjb25uZWN0IGFuZCBy
ZW1vdGUgd2FrZXVwLiBXaGVuIG5vIGRldmljZSBpcyBjb25uZWN0ZWQsIGNvbmZpZ3VyZSBib3Ro
DQo+ICAJICogRFAgYW5kIERNIGxpbmVzIGFzIHJpc2luZyBlZGdlIHRvIGRldGVjdCBIUy9IUy9M
UyBkZXZpY2UgY29ubmVjdCBzY2VuYXJpby4NCj4gIAkgKi8NCj4gKwlmb3IgKGkgPSAwOyBpIDwg
cWNvbS0+bnVtX3BvcnRzOyBpKyspIHsNCj4gKwkJcWNvbS0+cG9ydF9pbmZvW2ldLnVzYjJfc3Bl
ZWQgPSBkd2MzX3Fjb21fcmVhZF91c2IyX3NwZWVkKHFjb20sIGkpOw0KPiArCQlpZiAocWNvbS0+
cG9ydF9pbmZvW2ldLnVzYjJfc3BlZWQgPT0gVVNCX1NQRUVEX0xPVykgew0KPiArCQkJZHdjM19x
Y29tX2VuYWJsZV93YWtldXBfaXJxKHFjb20tPnBvcnRfaW5mb1tpXS5kbV9oc19waHlfaXJxLA0K
PiArCQkJCQkJICAgIElSUV9UWVBFX0VER0VfRkFMTElORyk7DQo+ICsJCX0gZWxzZSBpZiAoKHFj
b20tPnBvcnRfaW5mb1tpXS51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9ISUdIKSB8fA0KPiArCQkJ
CShxY29tLT5wb3J0X2luZm9baV0udXNiMl9zcGVlZCA9PSBVU0JfU1BFRURfRlVMTCkpIHsNCj4g
KwkJCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShxY29tLT5wb3J0X2luZm9baV0uZHBfaHNf
cGh5X2lycSwNCj4gKwkJCQkJCSAgICBJUlFfVFlQRV9FREdFX0ZBTExJTkcpOw0KPiArCQl9IGVs
c2Ugew0KPiArCQkJZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHFjb20tPnBvcnRfaW5mb1tp
XS5kcF9oc19waHlfaXJxLA0KPiArCQkJCQkJICAgIElSUV9UWVBFX0VER0VfUklTSU5HKTsNCj4g
KwkJCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShxY29tLT5wb3J0X2luZm9baV0uZG1faHNf
cGh5X2lycSwNCj4gKwkJCQkJCSAgICBJUlFfVFlQRV9FREdFX1JJU0lORyk7DQo+ICsJCX0NCj4g
IA0KPiAtCWlmIChxY29tLT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9MT1cpIHsNCj4gLQkJZHdj
M19xY29tX2VuYWJsZV93YWtldXBfaXJxKHFjb20tPnBvcnRfaW5mb1swXS5kbV9oc19waHlfaXJx
LA0KPiAtCQkJCQkgICAgSVJRX1RZUEVfRURHRV9GQUxMSU5HKTsNCj4gLQl9IGVsc2UgaWYgKChx
Y29tLT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9ISUdIKSB8fA0KPiAtCQkJKHFjb20tPnVzYjJf
c3BlZWQgPT0gVVNCX1NQRUVEX0ZVTEwpKSB7DQo+IC0JCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVw
X2lycShxY29tLT5wb3J0X2luZm9bMF0uZHBfaHNfcGh5X2lycSwNCj4gLQkJCQkJICAgIElSUV9U
WVBFX0VER0VfRkFMTElORyk7DQo+IC0JfSBlbHNlIHsNCj4gLQkJZHdjM19xY29tX2VuYWJsZV93
YWtldXBfaXJxKHFjb20tPnBvcnRfaW5mb1swXS5kcF9oc19waHlfaXJxLA0KPiAtCQkJCQkgICAg
SVJRX1RZUEVfRURHRV9SSVNJTkcpOw0KPiAtCQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEo
cWNvbS0+cG9ydF9pbmZvWzBdLmRtX2hzX3BoeV9pcnEsDQo+IC0JCQkJCSAgICBJUlFfVFlQRV9F
REdFX1JJU0lORyk7DQo+ICsJCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShxY29tLT5wb3J0
X2luZm9baV0uc3NfcGh5X2lycSwgMCk7DQo+ICAJfQ0KPiAtDQo+IC0JZHdjM19xY29tX2VuYWJs
ZV93YWtldXBfaXJxKHFjb20tPnBvcnRfaW5mb1swXS5zc19waHlfaXJxLCAwKTsNCj4gIH0NCj4g
IA0KPiAgc3RhdGljIGludCBkd2MzX3Fjb21fc3VzcGVuZChzdHJ1Y3QgZHdjM19xY29tICpxY29t
LCBib29sIHdha2V1cCkNCj4gQEAgLTQ1NSwxMCArNDU5LDggQEAgc3RhdGljIGludCBkd2MzX3Fj
b21fc3VzcGVuZChzdHJ1Y3QgZHdjM19xY29tICpxY29tLCBib29sIHdha2V1cCkNCj4gIAkgKiBU
aGUgcm9sZSBpcyBzdGFibGUgZHVyaW5nIHN1c3BlbmQgYXMgcm9sZSBzd2l0Y2hpbmcgaXMgZG9u
ZSBmcm9tIGENCj4gIAkgKiBmcmVlemFibGUgd29ya3F1ZXVlLg0KPiAgCSAqLw0KPiAtCWlmIChk
d2MzX3Fjb21faXNfaG9zdChxY29tKSAmJiB3YWtldXApIHsNCj4gLQkJcWNvbS0+dXNiMl9zcGVl
ZCA9IGR3YzNfcWNvbV9yZWFkX3VzYjJfc3BlZWQocWNvbSk7DQo+ICsJaWYgKGR3YzNfcWNvbV9p
c19ob3N0KHFjb20pICYmIHdha2V1cCkNCj4gIAkJZHdjM19xY29tX2VuYWJsZV9pbnRlcnJ1cHRz
KHFjb20pOw0KPiAtCX0NCj4gIA0KPiAgCXFjb20tPmlzX3N1c3BlbmRlZCA9IHRydWU7DQo+ICAN
Cj4gLS0gDQo+IDIuMzQuMQ0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1
eWVuQHN5bm9wc3lzLmNvbT4NCg0KQlIsDQpUaGluaA==

