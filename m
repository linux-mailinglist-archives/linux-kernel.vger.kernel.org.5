Return-Path: <linux-kernel+bounces-63781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43632853451
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE01C286A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E485FEF5;
	Tue, 13 Feb 2024 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W97u2YXj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lTIHg6Kj"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02F35FEE7
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836783; cv=fail; b=kvl9UpxldX3Q8FUfAxcUrr/O1BODC16agfUFsFoFAyRm2UsQ+d2FdrpMECORKwD+zN3mdIx7IeMoLdZmqsGlJ+3wfhleW2VQtsOhbf+BO2f69/sLaR5IP/sHdxD1wsZh8TB2DN/zR8ZFAjrO3WytkNLV9HpLYx+1Z0QhsvE03W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836783; c=relaxed/simple;
	bh=O9q9IKPp2uj+sp8l2YhnWzBM6xi7EiOkDPJQA7xqs9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eTOjBPOntmvomHtSBOHgkWLNfvdSsD0uF4EYp7z3UAdNArQEtNCSTSb+DTRUQd4aq10576Rwu49eRIpWaIbeQiefSvpsQWW4+FQBLJnWwrYTGDkawBA9EjC1zYv2oZD1ksOYeccZezDY+T4eggDcC9nycWxNv7OaGhXZgM5MLgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W97u2YXj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lTIHg6Kj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DETtVF012883;
	Tue, 13 Feb 2024 15:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=4pwwF5QI4X501rO512bcNe5BbPllOCyu/EahqVeem4E=;
 b=W97u2YXj1SAWQf4qOjHDBpqn9VNFytkPmq9h295sioVI7Ld7u6LnzmIeFBPS17oTD2Zf
 UXUplqG4oZM/eFJxN2G0anV0RBs2yvgc0+7xiSa9N/Mxxnr2qKix3gBc4kQX4wjDYeyF
 OA4xod97dYtO6wO5yVw81GcExR7Zn0oHmFCPXcUjv4w31lI1qFfz0PLMr9cp1c5HsijR
 61u/T6ITsZkjske6UxzYs6uxL6BNvhXXISLpVIz1EM9rQYh0KcZl1qIIEx9JZLnpI4Cu
 HXIL9FG/Qciol/5ADF5wmSICGUuGItXOIvVcmmkVQfTd6CaYe7yFkSz0P/5P/K2xbQVv UQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8a84g3w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 15:06:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DDvgY7015037;
	Tue, 13 Feb 2024 15:06:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk7fdxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 15:06:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFqkHBnnE4FEQf2KJJL1WK6oq/OPMCIWUWh4LB7GHp0jHUu6JbQ0D9IIvV4PSwmMh26cDHUk74Ztr61f3fmA5mMBtvNmOIpSuM4VtVg/Jh522ljYoNrGSC45yS7KhhjIVrqyrjZRYoLZ0U5eTxFsU6ymVd6BLC6I3K5HjwwvKIX7q/ljTkAxjZA2kb4w1h883CVUIE8x5yoTYwjgzLwOJxxiLujdhuENXvf5k/rJxP76S82d0WFCSEnpUp7MI1nHyyHHOvpaWBX/qAdrmE/1G30Rmj4ezZvQH6TsLKBWCpvUZ1ru7Z3yjKiyivRtW9HNs7HD3dnDte5LfLW5GiGD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pwwF5QI4X501rO512bcNe5BbPllOCyu/EahqVeem4E=;
 b=FPMwW7tEpvd6krobaWRtap6JPFdzwgoUhCh5DNirk+W5EZh7UwvirPTOIzwHRxhmk4AEmtsak5exUH2mGMQh65rk9urI7NdveCY6rlYi+LXGc0HlRHN1kfGQoYO5kNLaTThZcfCMji2fXFnk4/bGZ9clyIwrOI0mPE/h6nsbIiI/EV1IxVij2+adqoM4+t5NKEk3jo529BsTcfDvkpgiPypAGeM7ilQZp5FpkhNq9ceRC8/1r8HOvvi8Xm/WVGye7xooIY43hLQPkLhPRXfAv4jtsPQ12wO+p8SixFmBD0CKiPW1qqxg+qHFOL1FWTxrBrSzKcdk3ukCxqiDKPILnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pwwF5QI4X501rO512bcNe5BbPllOCyu/EahqVeem4E=;
 b=lTIHg6KjixKaR4L2Mpbxh6rrx9+9w+VlIeBiGafMl0LfKRfgh5gov9oEzyID8SzJ0hLhFAJMeyWpUm5Lt4T+iGK5BjdSZS0nFsb9I8vAbaf1UBGa3BrePtOIb1LFGYDRvf/QafBh5cUONjUkEkkh587kwH7Y/1OvHo7Q7YV5xqM=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MW6PR10MB7614.namprd10.prod.outlook.com (2603:10b6:303:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 15:06:13 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 15:06:13 +0000
Message-ID: <7de12bb2-30ed-4bd1-a9de-2032bcfef686@oracle.com>
Date: Tue, 13 Feb 2024 10:06:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] vdpa: skip suspend/resume ops if not DRIVER_OK
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <1707834358-165470-1-git-send-email-steven.sistare@oracle.com>
 <CAJaqyWeE3hE3Mv29TL8K6CHTncexdOZXgD+BoehRCamiGfeBcA@mail.gmail.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWeE3hE3Mv29TL8K6CHTncexdOZXgD+BoehRCamiGfeBcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0236.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::7) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MW6PR10MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6e2172-2ed3-4d99-35b4-08dc2ca551c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xBoqn+1p63yNHI6lxQD3DBrw0Za5jIx+fMq94wILpgpWoTr7yUOtBR+IEFRetdvWmBbnVq7yJdh2sCteFhvaNH18Cwy+DcIHvkOi2jdYjIXFrpfgqVO7yLf394/09qwmTVldQXyfF8rjIPpnoydKD6ZXQQZ5beTYuRSRTQsi5FtQ9441oIH0dVR1wwj5Wkws5Lg5xH6IbMPW99ZLewunAoRNoPPIUw9YjV31gpr9UBgfGGRPkU1SIXDjpLpkSkFeQW1cFAwUFNKNasROYkhko0TuOMhU1x5rPFoRpSLMqNrJ1q/wO2Vb6Ae2H/s7vyftbJU8+KcLlwoSBFf4YvXR9As6SkNLiDnq6lxOrmI6W3w0ARXsy7lMOdnnUqk4Mx7pQcikroQz7a0Q/xJhbHJBtA+7ILyulumtZBNbTjS1BPS84DK1UTbyinJPqHPgzEa6JJe4vBCYiiJsoLCXeMjPxhaOQFYCAnrEV1+gZoxwPOsM5gWEVEgUNwec35eNeY7odFexMFam4CdFZ16QTx+h1tmFQzBDGDREpnu9U3jojZ6+DvC3gLzYXnWXGoSKKQGv
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(316002)(54906003)(5660300002)(44832011)(41300700001)(15650500001)(2906002)(83380400001)(66574015)(2616005)(31696002)(26005)(38100700002)(86362001)(36756003)(66946007)(6916009)(8676002)(8936002)(66476007)(4326008)(478600001)(66556008)(6666004)(6486002)(53546011)(6506007)(6512007)(31686004)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T0VrcmRuVnZCYktpR3U2YUVOOTA2Z0FBelhDR2M5U0xqaTdtVzAwQkVoWkdS?=
 =?utf-8?B?UXdkZGREc1Ntd09qWGp2eTJ3Y2JrR0lqVzAxRVlNeWIzR3R0OXQ1L2IvR2lX?=
 =?utf-8?B?Umt2NmZhdGxLN1drMWVJOGpDdmFSQVdFMi9qdWt1dS9jamFHajBYL0w1eStJ?=
 =?utf-8?B?RDUvaW1kYmZXUEtodXJVMlROKzA3bkFDSUZBNzY2MFVmajdPY2tpUGd1czZ4?=
 =?utf-8?B?M2RSTThhd2xTbkFSWjNZRkgyakxSckVyUUdwMHFGR2NFZFc2VzEwKytEaElZ?=
 =?utf-8?B?WHp3byszckYvREdoNHBvTGRGSjRPSy9QRkhsNktBRzVxWVcvOWJqbmR0WlpC?=
 =?utf-8?B?dUJXeFhFL0dDSXJyM1FlN0poWkYzeUlNNWVFMU1lVXFXZFdGWVBQQjhzQkdF?=
 =?utf-8?B?eGt4QnVkcmFKTGxkaWhvdy93RWY3a3dBQTc4a0c0WDl5RHgyWHpaYm9xcG5p?=
 =?utf-8?B?OHpmRU5qeGVDeGpZWEZMa0t6aGRCZ01Najl4cDBad0p4bVdXNnNsc01FTWxr?=
 =?utf-8?B?RmozTVBKTE5tNEZqMHR6K1A3bXE1WmN0V0RqT2k5aTNLakJyL2hwTHNicWNk?=
 =?utf-8?B?WTdMOFZxRmJsSXRNY3hRQmlFWjlnMWJqN1VyaCtodkgwNHVKdHdySlYvM3Fw?=
 =?utf-8?B?OTVId2g2ZWplTzFsdWFzNVF5ZjZyN3pDcVBGMXQwOE5FUEIwWFhPOTNxVWx1?=
 =?utf-8?B?b2t3cXRJSGlZMkorOWY1VUovNDhCM1FDaXoxMEVTajNUTWJVemNVQSt0OUZu?=
 =?utf-8?B?Rndsd083c0s4WnFkc1lFNThycWhTUG5hQW5oOW55WHdXNE56ZS9zS0NUTXRi?=
 =?utf-8?B?UE9mZXJaWU9oc2dDenVtRk1mN0xkeFNSd2FKWXlyMjNBWWpXK0NyaytUQUpF?=
 =?utf-8?B?TkIxdWpRVDM5ekhwSEYyQWZvL2dMNkVRSGRmSm5MNEVPb01heStWUGxvM09B?=
 =?utf-8?B?bDdWdFB4cENaYXpteCt1bVpXVXBsU256QnVURlN0dC9FM2YwYjRkcEFSdWVM?=
 =?utf-8?B?WS80WDdlT01MTGhtVzc1MDdoUEMvV3d4VzN4VGdLZGFmZW1JWTcyVjFjUnR1?=
 =?utf-8?B?RUFhL0NSTHBlR2d0NTZ4eE1rcmlMajVDSzVMZUs0MGJZaURCWDI2WE16dFJI?=
 =?utf-8?B?OWRUay9MRmZUajJ4TmE0ekM3c05HSlZTb3VwVThvaFdmOWhCa1QxQTVHdWVi?=
 =?utf-8?B?ZDBYZUxXbEF1YTRZNXRubHFHOE5KaFc0bzRRVnRRMTh2OU0yVXh0Rjc3V2x2?=
 =?utf-8?B?Z0tsV2NvZmZudzQwd2ZXNmYvVVVNM21xMEUrNWRITEFnQ2JBSzA3NncyZTMx?=
 =?utf-8?B?elZzTFl3Q3JiVmtwUVpqV29CRDJJWWFaeGNDMkI2Q1I4YjF4clBxUVREdlZj?=
 =?utf-8?B?NG0zSFBEdWdsT1Jhb2NLVGtmSEZwYkt6NG55aU1yRWhUem1VL3pESzBTRFRX?=
 =?utf-8?B?dmxnZ25ZbjVTcWpISy9vUjNXNmdVK3pQWnVBaGNOWW1tRnlRRllqc0t6anZO?=
 =?utf-8?B?YklHK2RuR2pFL2EwSXV0alc3RmRNZndYOVlVa054Rk5oTUI0UXVlMU51TEl3?=
 =?utf-8?B?VHVVckNHZ1NBVmdMaDJPdW1qbFRzM0M2c0YyeHloMnBoOE9DSDRFcUdZOVd5?=
 =?utf-8?B?RFdsRUdsQWxVeTFFclE1c3pnMjVsc1NlbUFXOGh4dUl2RkRDc0lxbzliSFRm?=
 =?utf-8?B?cGdvdUVFN1QwM09yazgxaGZFRnNtUGFDTFgzYzBuQTA1WnF6eDdiSkw4elZi?=
 =?utf-8?B?U2p5UFNTRlc0SWpoZmtkTEs2dlh4eENUQmU2aWZFWVF5STJZWXA2V3VsSldH?=
 =?utf-8?B?RVRPNW9uVnVFc2gyOE5sVURoUXBSdlowYkVQdWRNOWNscHR4Rm45akNsNUFj?=
 =?utf-8?B?bnFNSTlUa0hoaWFwQW12RDlWZElkVS91dzJKU3BkdXYrTXZMY3g4dW5lcCtN?=
 =?utf-8?B?TjV5Q1hvaUR4V1d0NnlxQStJM0pxRWQ1ZnNwZmk3ZlNPc2JhSnY0cldQSFFo?=
 =?utf-8?B?b3NGKzVWU2V4TlUvcHlYSkU1RURjR3ZPSTRoaVkrcGVRazFQZkNQUG5vRy9I?=
 =?utf-8?B?bisyM1Fqd3dOOWljd1VwOCtLcUtRelRvb2k5eWRGZTc5KytGaW5vek5HMDdn?=
 =?utf-8?B?SC9nV1FUMXBtby9XZ3RyL2t4Yk5yUDdCc0N3TFlQOHFwZWtjQkdvV2hJeDhl?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TV+ZCMB4Rs4FUPLQtiUg9gujvysGHGxcs8hkn84uAWABGd9Y1Q4DoZdWnSF8Z04zQWeSetlQEee3VJsk887yHXLWZ28mDNjBy2GT1rSesggMngmx2F9PN6PYYS4/Gl1u/PzOyaXmDjuKBSikJiFooQYzi2XCzsLbE7RTpWemFzEmabV3P7Pmyemg2S50FI5yCmrTIHQjtS3p41fu81WdJMhnuJ/U9Y8qG8bOA4E2am5cjJrjyDt5bqVpH78nP/ty4RdZg+1gpr0XhxRpD5M+acJAlcbe+ixYGjcjpnI5dlZZ1BFUTE69dWUZCvqCU9IpjvKhE0hKRncAw2mVYudmfcxQbmcIvI5JCOGWVB9C2yw7O/QY47RiH44NoVrw9diC4CFc12VvTQ6GuCGFYYIgKXjazFEDJHks5UX/U7CK9f1I1eUq6PRMdiV423c/fVypNwG9eafzTTmTGWwWYkc6CBA4dq4Zb359U6sXTKlRFMDKC2+9fvMFbUfvlqs6mnox38Z50DFvdCi6TCdtaSGX+x5aZERQq0V1SJwZBuKoko1D6UMZYh6Kh9WUXoGh6hkbQ53A026MyxMhis9RSZ9Oy/crFrjd6zIkseYnABLwYec=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6e2172-2ed3-4d99-35b4-08dc2ca551c2
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 15:06:13.5212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnud/MJSEqEJzKfOylLR1/2qRr78YoeG2aOSCMP/Z7fQP014AwYu1M8iSNBzi3I8BolFX8m96aVe15Unz9cRtKS3Srwci/fR/qYTzAiRis4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_08,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130118
X-Proofpoint-ORIG-GUID: NQ0DENHCnT3nombg7upIl2r9l-RsFMPh
X-Proofpoint-GUID: NQ0DENHCnT3nombg7upIl2r9l-RsFMPh

On 2/13/2024 9:58 AM, Eugenio Perez Martin wrote:
> On Tue, Feb 13, 2024 at 3:26 PM Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> If a vdpa device is not in state DRIVER_OK, then there is no driver state
>> to preserve, so no need to call the suspend and resume driver ops.
>>
>> Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
> 
> Please include a changelog from previous versions for the next series.
> 
> Thanks!

Will do, thanks - steve

>> ---
>>  drivers/vhost/vdpa.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index bc4a51e4638b..aef92a7c57f3 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -595,6 +595,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>>         const struct vdpa_config_ops *ops = vdpa->config;
>>         int ret;
>>
>> +       if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
>> +               return 0;
>> +
>>         if (!ops->suspend)
>>                 return -EOPNOTSUPP;
>>
>> @@ -615,6 +618,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
>>         const struct vdpa_config_ops *ops = vdpa->config;
>>         int ret;
>>
>> +       if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
>> +               return 0;
>> +
>>         if (!ops->resume)
>>                 return -EOPNOTSUPP;
>>
>> --
>> 2.39.3
>>
> 

