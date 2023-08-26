Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A507892F4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 03:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjHZBV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 21:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjHZBVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 21:21:08 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322991FF7;
        Fri, 25 Aug 2023 18:21:03 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PJ2vod008663;
        Fri, 25 Aug 2023 18:20:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=W5tePaYZO/9bqG+OmlZybhP6EZlpERFr5v1kQxBMhtU=;
 b=D0P9wtCY6rHBmqzWSQI3zgdkC/9fywQ0CVRUM4mZKbdUwEs6nOfd1xr+I6AWFjrRcsxJ
 ckiwE4W/K+vv50VCbbkxiIWnKP8iSWY4H72e0NXRU6VS968M7f8QtNmcSiCGsM0XrpK2
 CldERaHLGUUFMNsagitu3qcAaupNwiDotyQu8JxLBjIHl6OBcODmUWjsZXqdHgbTBoHs
 AzAcUyPpXl2c697FA/OuVEK3WzOUFIqcsIakBnprWjLGLq/jr/ZOFk7N0ktfzBZoc5Tn
 lwfWKWCPyAd5FSpdXuT2SjU5BHKqV2D3fqfC863MI/3NuqpkdhC+/kpXf1jCW+Imy5uS HQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3spmrg4nss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 18:20:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1693012841; bh=W5tePaYZO/9bqG+OmlZybhP6EZlpERFr5v1kQxBMhtU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=e7/V+3H2A0LE3U5lFCyZOP9urLEwylLQb/NAshjANQ+FVFh+ctJP9UQRMqz6RQGan
         s29vr0yVLZpiLqB3757aEBhz3ibwMUhNPiBKri9tPP3HrBX5RcyMqyxtfvu9X/Wq75
         wKJo9VWzootcgCBc7mTuQyg7cHhJ/PPXcnTtszfgcKQxmeTPIq8VJJbsXLTNA42cPc
         OBBtI2smXbvbTlduhw2aRSuAJoKCC4r1sbyRVzyRy7H5r816aQA+rbtxQ0Cb/3ai5T
         O50ZZvUEmifAC6bSEZbUdKMGcVrCKYBpDybHeFXPZp5Ho+B7h2kiRBPWreHjT51kmi
         5lYfA/56XWoBw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CFD034024D;
        Sat, 26 Aug 2023 01:20:40 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B1961A0076;
        Sat, 26 Aug 2023 01:20:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nHpibAvG;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5240D40355;
        Sat, 26 Aug 2023 01:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+5fuZgzAGk0NSrw6TYhyi4uS3Zp/rO9ztvPiZ6O4Ne3Tzzm/ApakGlW+cGMadePImDnvIWOmRZPwCeFrFakWl66hZe7G8Fw0sriUgYOz4EDT5kVsOge9k1e0jdX/DTMw+Cr6Um/0anbgQmRfFs9SpOfkq/D09yiO9gjMpzoZArneTmu3gzVt1EGw8DUW+lsRgkEZI5XEyHKThanNxlQCxo7xRS2gpKuDSLHBqwkbhacWJAgTTJh9SYP8GCV5A7205r7/Ke8vo8PGDl9Mo9a23h9HgTGU6mG6awRMWG4CYSrsKhAVSX1mmRxsLLzqGBnja59SeBloZvHvoWvF63cmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5tePaYZO/9bqG+OmlZybhP6EZlpERFr5v1kQxBMhtU=;
 b=oTzazX5Xysdx7vbHPJf1wRQhQ+NA2/6rnVf1u7/w3KuS1qEFoJBVC0wvqzkUSxAH4GHU5bt3awAHx5Uo5XJ+Ykw2aA7AjmSwxcYvd0y4LT5AgQoXkkFvXzWjaW6Mul1wT315dn2HXM1PtBNKMurVHPSu9GMmAuPvqB7QkYyqvtvDqQleMDaodqkdXkSn7Nlzbwy3KUO3fFuhbByN/hrrEGvu9lYpB3zrdVqg73WRkrCu2C/tr/fzEa8ZJzQAA7Gck4xYfHyHLppZGYZ0E3/iCr7j7fjvp4/jfABegTM+649xmJL2mPF9sAD0Cm2QZBDv3lCatUEjf+BVNYd08rEcaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5tePaYZO/9bqG+OmlZybhP6EZlpERFr5v1kQxBMhtU=;
 b=nHpibAvG4ahZPS2eD1Zvyn0ypfkcB99oBM9Z1zaRftT9danqD2LAMls6ORAbsG0rtyHiPVRKOmJ0pYOUO2DjtmNfx5kq0LcmPjAW//qMzdmE+cgo0YrBmDFZcmyZCMv9LiGWg3nEH6apb20LERTbU/sTHTnR8C3k1YDxaoxW6AA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Sat, 26 Aug
 2023 01:20:34 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6699.028; Sat, 26 Aug 2023
 01:20:34 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Thread-Topic: dwc3: unusual handling of setup requests with wLength == 0
Thread-Index: AQHZ0WkxsEX2ZGMtZEmcF1gvP2WuTK/vPhuAgAAY0oCAAAlogIAACMGAgAEOQgCAADc1AIAAELKAgAKA6gCAA+wcgIAA2rMAgAAtNoCAABaOgIAAMuwAgABCyQCAAxO2AA==
Date:   Sat, 26 Aug 2023 01:20:34 +0000
Message-ID: <20230826012024.mboftu3wk7fsrslp@synopsys.com>
References: <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
 <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com>
 <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
 <20230823021429.rlgixqehry4rsqmm@synopsys.com>
 <5d5973b9-d590-4567-b1d6-4b5f8aeca68b@rowland.harvard.edu>
 <20230823175903.bpumanwv5fkpwc44@synopsys.com>
 <08a3759d-4c6b-4034-8516-685e4d96a41e@rowland.harvard.edu>
 <20230823222202.k7y7hxndsbi7h4x7@synopsys.com>
 <9b175f9e-ab70-47a3-a943-bfd05601aa23@rowland.harvard.edu>
In-Reply-To: <9b175f9e-ab70-47a3-a943-bfd05601aa23@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB7413:EE_
x-ms-office365-filtering-correlation-id: 0c3f0c97-7b2f-4ad3-8de7-08dba5d2a59d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KD2gAddo1hlg/Td5t/29x0NHtiOz8YddYauPot+iSZue3ngzkMY1hdMEm0aslJKHgsbq5AysX8f1JFBbRPG6ppgDf2a9uGK4R/lB4vRMrnaIFE+WPniv0A7ky+mTY6x8er73T1Utw/1ayAlOZIoEBmxZKMgX6+dCClmXX1jC1vVraaFAnvOnIs7bdRnP9LnQNHz+LNE2d0AvgGlDn7Csgc9LYK5Z4o4wrw8C1sLJAKCy+SwQktzDt647j6yNpbnGiUroohDwfJGP1ZQLKLbN4yCdYXrtYDLZB4gXBxCN78looboJOVTbT1LJRrIhg+9og4vs/PkdROJRCbFO2SP3p46O62oUW7z9xg9zQt5VnuExRH9ufIoih6oFO1t5hH7KfPUe2GDwjPep8n5XdYmqcuZ0/3WMFFMmEAWfupDnTjNYyq/D5lpo7nWdLjludB7AxULcTjejEHhDexGcqIJqHGk5VHxYhL0LurqN/hZ17J9rOLVe1lVN0dxhcnM/YO1eLKF3xqN/em8MrX8O9uYxE5TVjbsoNHYCyFd2hnoYXWorZH/F3WnnkPwrCs52FQ/ei/wdQKBMUPFdi/24N8YroQrNKY/G+x2adMpKAOOBtIiTstFlp7g54ptPYJvcCq1D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199024)(1800799009)(186009)(66946007)(54906003)(64756008)(66446008)(76116006)(66476007)(6916009)(316002)(122000001)(66556008)(478600001)(91956017)(26005)(71200400001)(38070700005)(38100700002)(41300700001)(86362001)(6486002)(6512007)(2906002)(6506007)(8676002)(8936002)(4326008)(1076003)(2616005)(5660300002)(83380400001)(36756003)(30864003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjU0WDl1UEp0cnNrcjNDOFk1QUZ6bFZLOStHMFM1b0Y3Q1FRRk1yZVhGaUdZ?=
 =?utf-8?B?dURKUWh6UWNTbmwwL29vSStzTnZDUm0ya2FDaUIyQ29POUZ0TnFRL2tOUXNp?=
 =?utf-8?B?eHJJa0s2WWJIMmkwRkpQMlRjU2ZlSG5ud053NHVRSFFwTElaSnhGdytNK3pk?=
 =?utf-8?B?RzdkQnRYaXN3cFpOaGV0UkN1K0xjVDBac1lwWE9TVi9xaUJ1UVNBcHl3eXFs?=
 =?utf-8?B?azhHTXdyYUdndzhhWkZqMmNRYlBNNzZQT1NjTVZHbHRLZHpldS9SN3FUb0M4?=
 =?utf-8?B?K0ovTURiaDBJZDJVTGtyaFhwRWxkYktOZjh1ZXQwOUF1UjN3UWVqeGNZM0NS?=
 =?utf-8?B?OVRhYWFWenR5bG1sVTNrUTdmMkJpOVdLdDZFa045UHZ5dzNOUTJoeUVaa1I2?=
 =?utf-8?B?SFMwU1plZ1k5REVhZFNoR3krZ0JTWktPVXMwV1J6b1dZWEd5WTRjWmxlWCti?=
 =?utf-8?B?MlZaQUlZd29DejlaVWM2M3Q5ZDhESzBPejdVeWNwZnpjK0VxV0VOZGdGY0hJ?=
 =?utf-8?B?cmY2elR5SVRMR0JEa3lpMGtJUjFXa1RvbTE2c3F4ZjVLbllGUWluMnMrVHBu?=
 =?utf-8?B?SW5qbzcwdUZUY1JhWWR2T2QwWTZoNjFvTTc5clhJUHVpbHRGdVFucGNKWWlT?=
 =?utf-8?B?ckpyN0FuckNDeFk5ODNJbVZ3cFZPb2QzR1VpNTVZY3RhQWRBMHRkaUpGUWsr?=
 =?utf-8?B?aS84VXhOVG5kd2pvaEdwQjdLQUlKNnhWNDNrdDVKbXpxU1V1SldDTE51ejdH?=
 =?utf-8?B?SEJMWXZ3aGovQ0cxcE1jRjVaZE52WkFNNW5ab2RsaGh1YW9KQ2dJdXpaV2hC?=
 =?utf-8?B?dXI5d1FaK2JZVFVNYWgvdEZsR1Q0dTRWTE52d055d2xpN05yS0c4Z1dkRFBH?=
 =?utf-8?B?M0g2ZmFBUTMvZmI4d0VEMFg1VjVmeDJ0WThQd0VrMGZkNHFNQVFtSTl6ek5F?=
 =?utf-8?B?Sk9SNmt0eFpTd0JGN3lJc3ZYOUcwTkMxR2VKQWV0N0lvRjdtMVdzbmloM2t0?=
 =?utf-8?B?VDRyUGxRbGM4ZjhscnhzMnhPWm5yZGJ3TGVONUJrRXY3d3RwNFZSZ3BZdm1q?=
 =?utf-8?B?aXNsRFZ6WjdFQW1OaDY5T0Ird25IV0s1a1JreUZqRXk2dmhxcUQ1VVhFRVdS?=
 =?utf-8?B?VXZLUTkveCtyZUVPWFcycDRzeDgrbm1DK3dod1pOc01yNXZSbENiaktvZ3o2?=
 =?utf-8?B?TVd1N1k3QloyRjA3SlAzQnJsSUZmUFIyTitZSzdLUkZYdTJ4MlVaYVUvWDYr?=
 =?utf-8?B?Vmd0Tmd5N2F1UTBzQWZHZTM1Zk9tMUxWbm9UbVlWbmdwc1VZVFljWTIyUWI1?=
 =?utf-8?B?M3A0VlVmMUM1S2w0cXFjZkdVTGVzdnZSMmV6TFJ2dW1TYkJHOERVUEtQa1l3?=
 =?utf-8?B?ZTBwc3R0MCt1NVkxSVRQK2h2ZUdVT1NIOCsxbXpQcThpclFETWFGMjhnSHRI?=
 =?utf-8?B?KzhUOUIrT21SVmtQSkhveFFaVi9jcEVBTW1aMmd5WGJHMTZWV0Z6a3BBK2Vn?=
 =?utf-8?B?MWw5VDFGdjRqbFUyZFlQYi9NdTBVYXlnOGxYazlkQ0hReHU1dlRxUnVZY2N1?=
 =?utf-8?B?U3lUZzJ2akZRektadVpLUGFzWHJzUHBETUx1Tkk0SDNJT053OVJ5cVdDRTM3?=
 =?utf-8?B?ajZSYUt0SzAyQmU2SkJVRHFRdGhVVkxkMldLV3NEU0tTQm1VcURRWWVMT1lS?=
 =?utf-8?B?M2NTQ2lUdGsrcm5rZ2IyZ1J4VHJ1Sk1BQ1dzVUhSYWhJdkdvV0UvT1VUazZU?=
 =?utf-8?B?VlJCNHdJdTY5ZEcrd0tXVUlJYmYwVTVtOXdpM0FwdmRDanlhN092dlRiM2NG?=
 =?utf-8?B?WHkvbFhUNVFkMUVUV0ZiY2VadE9NY1lEaVR5N2ZBSmRaTjExNTZYRmpTOXNo?=
 =?utf-8?B?T2VHaTZqd05rc2g2RWRZbTBoUkw3U1RDdU5CLzNxY1p5T1REcUVHQ3cwUzNi?=
 =?utf-8?B?Rm90a1hhUlhDdkZqNWl0VkgvNjFjM05sWEdNMXhnZWxUMVd3S1RmVjkvRkNi?=
 =?utf-8?B?TWJJTlpsOXprZEpaQmJWUHYrTFdTMk5lSEhVcnlQM3RoeGhody9QREM3aFpV?=
 =?utf-8?B?Yy9QNmNVS2JJQ1lBVmIvWDhmUkttYUh0QkhDYkFFTkIzemx4NzlROHlVaEJM?=
 =?utf-8?B?c3VUdXA5MlVzUTlmc21DQXgxUURUNEpkNUV1cFRtR01wNVptR3BwQ2wrb2xQ?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FB528091C1C88409657211F20CA5330@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RTMzMmh0cG1XcktzYWRicEx1WDZvNkd1ZG5IaVFkNlV0c1FndEJVem40MVlB?=
 =?utf-8?B?dUUrSEk4eWFDaG9Dall3V3JqMkIyOVpqQXVpd1ZNR2ZzN1lpeEZIVTM4MW5u?=
 =?utf-8?B?VUpZdzMyaVk3MjdYdmV2eVg4Qlk2NWVBUzN1YnVqOXY0MGVFV0wvQ1Rxb0Ra?=
 =?utf-8?B?Z0dhRkF0dm5QMFY4Skszc2MvRGI4aFdLTFd1SWNUV24zVDFlK01ZQ1lwN3da?=
 =?utf-8?B?QTZDVkRWWDVORzh6cW5UUFFBZy9SNTc3akhlVlE1SlRJckxneVZiSCtQQW5q?=
 =?utf-8?B?YnB4L3pNYjRxQTdmdWJOVTA3eXdWOUlZK3NMVXd3ZENMMXNxQkJac1dweTQ3?=
 =?utf-8?B?a09kRFNmdDJKKzF6RlU5a2JvODRQK1Zaa3orMzBvRTJRZmIvL3A4a3JWWnYw?=
 =?utf-8?B?ZGVLSDRMRnRsN00rcmR2cWVyWTlEcWhSOVZNaEdCMFEyN2cweTR4WkJjSDFL?=
 =?utf-8?B?ZnlsTk52ZGxpN2w3cmRIWmpMcXR2N2l4ZU4wQnpnNWQ2ZjB6TllXTDJQVXg2?=
 =?utf-8?B?aitiQ0VBYmJ6S3RlR0dYdGxYVzROR0hBUzFJWHBRWDlMRVRvMkdReWt6U21x?=
 =?utf-8?B?R1hlQzhhdTV2R3ZteE9yZXJpNFZUczA5YSt6NU83SkdUVU1XTzNHMkVodmNT?=
 =?utf-8?B?cXpLb2FJc3BHeUVMMVgxeUZKMkFrSklINC9CbDZnam9jY3UrRmNpWWRYM3Ft?=
 =?utf-8?B?NUQyVU5DZGpTTkx3a1NTUnlyN1AvYlQ4KzNpNEo4aHdhanhqZjhQWXJNa0NY?=
 =?utf-8?B?MUEvdXp3WUhBSzNZb3VYbFFTV0pBR0ZmT2s5RmVzTVV4c1BlSmdTSXIxekpl?=
 =?utf-8?B?V1hQdGRnQktteElyNHhLYytzUGtuRTRyL2RCOHBZemlYdjhEMXhaQXhSa3Vt?=
 =?utf-8?B?NFJXUWdlaUhCdGMxNDBpR1V6WjJ4ay9EQm1JN0Q4N3p6Ny9Ham9Hak1OS0xk?=
 =?utf-8?B?NkZPc2NRa3UrUStXeUtGT1g2WWJQL01pR0FBeTcySHhvVWxOOVRQMGw2djRR?=
 =?utf-8?B?dk4zNHRJQVRORU9TSWdSY2xvTG9FU25OVng3MTcrRmpnK2NiN3BpelpVZ1Vz?=
 =?utf-8?B?RWdXL3lDQ3VTaUREQ0NWYkg1VllXRzgrNUlhYkhLSWZTQmszVGpUQ1k1alkv?=
 =?utf-8?B?SWdrbVM5S2lWa1lIWmovd0N1RWxrdkdMbWpCWUZoMnMwd09oaHNmeVpuVU1C?=
 =?utf-8?B?MFN2bFVhYUo1Qmt0aGpkY09PK2VTT01DNmUyWUoxWHJ4b0ozLzI1bW9iZFhO?=
 =?utf-8?B?OElPSEZ5OEx0V1VpbGJDbkRDaXVhMm1JR1lHTkN2YlVhckYvQT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3f0c97-7b2f-4ad3-8de7-08dba5d2a59d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2023 01:20:34.3081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9r723GmGsLwfJlQuQcxnSwVbyT1jIC9syFeFNRSuwS6EPVb53FGLXiV2UJI3U7YWP3REnXMaBI7iHq1y1FHEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413
X-Proofpoint-ORIG-GUID: 8S0C_k-vmWkrahe_6AgkIBMJm6Kni_7A
X-Proofpoint-GUID: 8S0C_k-vmWkrahe_6AgkIBMJm6Kni_7A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_19,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308260010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgZm9yIHRoZSBkZWxheSByZXNwb25zZS4NCg0KT24gV2VkLCBBdWcgMjMsIDIwMjMsIEFs
YW4gU3Rlcm4gd3JvdGU6DQo+IE9uIFdlZCwgQXVnIDIzLCAyMDIzIGF0IDEwOjIyOjA3UE0gKzAw
MDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBXZWQsIEF1ZyAyMywgMjAyMywgQWxhbiBT
dGVybiB3cm90ZToNCj4gPiA+IE9uIFdlZCwgQXVnIDIzLCAyMDIzIGF0IDA1OjU5OjA3UE0gKzAw
MDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4gT24gV2VkLCBBdWcgMjMsIDIwMjMsIEFs
YW4gU3Rlcm4gd3JvdGU6DQo+ID4gPiA+ID4gU1RBTEwgaXMgbm90IGEgdmFsaWQgc3RhdHVzIGZv
ciB1c2JfcmVxdWVzdHMgb24gdGhlIGdhZGdldCBzaWRlOyBpdCANCj4gPiA+ID4gPiBhcHBsaWVz
IG9ubHkgb24gdGhlIGhvc3Qgc2lkZSAodGhlIGhvc3QgZG9lc24ndCBoYWx0IGl0cyBlbmRwb2lu
dHMpLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIGhvc3QgY2FuIHNlbmQgYSBDTEVBUl9GRUFUVVJF
KGhhbHRfZXApLiBUaGlzIHdpbGwgcmVzZXQgdGhlIGRhdGENCj4gPiA+ID4gc2VxdWVuY2Ugb2Yg
dGhlIGVuZHBvaW50LiBJbiB4aGNpIHNwZWMgKHNlY3Rpb24gNC42LjgpLCBpdCBzdWdnZXN0cyB0
bw0KPiA+ID4gPiBzZW5kIHRoaXMgd2hlbiB0aGUgZW5kcG9pbnQgaXMgcmVzZXQuIFRoZSBlbmRw
b2ludCBpcyByZXNldCB0eXBpY2FsbHkNCj4gPiA+ID4gd2hlbiB0aGVyZSdzIGEgdHJhbnNhY3Rp
b24gZXJyb3IuDQo+ID4gPiANCj4gPiA+IEl0J3MgaW1wb3J0YW50IHRvIGJlIGNhcmVmdWwgYWJv
dXQgdGhlIGRpc3RpbmN0aW9uIGJldHdlZW4gYW4gYWN0dWFsIA0KPiA+ID4gZW5kcG9pbnQgaW4g
dGhlIGdhZGdldCBhbmQgdGhlIGxvZ2ljYWwgcmVwcmVzZW50YXRpb24gb2YgYW4gZW5kcG9pbnQg
DQo+ID4gPiBpbnNpZGUgYSBob3N0IGNvbnRyb2xsZXIuICBUaGUgaG9zdCBjYW5ub3QgcmVzZXQg
dGhlIGZpcnN0OyBpdCBjYW4gb25seSANCj4gPiA+IHJlc2V0IHRoZSBzZWNvbmQuDQo+ID4gPiAN
Cj4gPiA+IFNvIHllcywgdGhlIHVzYl9jbGVhcl9oYWx0KCkgcm91dGluZSBvbiB0aGUgaG9zdCBk
b2VzIGEgDQo+ID4gPiBDTEVBUl9GRUFUVVJFKEhBTFQpIGNvbnRyb2wgdHJhbnNmZXIgYW5kIHRo
ZW4gY2FsbHMgDQo+ID4gPiB1c2JfcmVzZXRfZW5kcG9pbnQoKSwgd2hpY2ggY2FsbHMgdXNiX2hj
ZF9yZXNldF9lbmRwb2ludCgpLg0KPiA+ID4gDQo+ID4gPiA+IFRoZSBwcm9ibGVtIGhlcmUgaXMg
dGhhdCB0eXBpY2FsIHByb3RvY29sIHNwZWMgbGlrZSBNU0MvVVZDIGRvbid0DQo+ID4gPiA+IHNw
ZWNpZnkgaG93IHRvIGhhbmRsZSBDTEVBUl9GRUFUVVJFKGhhbHRfZXApLg0KPiA+ID4gDQo+ID4g
PiBNU0MgZG9lcyBzcGVjaWZ5IHRoaXMuICBJIGRvbid0IGtub3cgYWJvdXQgVVZDLg0KPiA+IA0K
PiA+IE5vLCBmcm9tIHdoYXQgSSBsYXN0IHJlY2FsbGVkLCBpdCBkb2Vzbid0IGNsZWFybHkgZGVm
aW5lIHdoYXQgc2hvdWxkDQo+ID4gaGFwcGVuIGhlcmUuIEl0IGp1c3QgaW5kaWNhdGVzIENsZWFy
RmVhdHVyZShoYWx0X2VwKSBmb3IgcmVzZXQgcmVjb3ZlcnkuDQo+ID4gSG93ZXZlciwgdGhlICJy
ZXNldCByZWNvdmVyeSIgY2FuIGJlIGltcGxlbWVudGF0aW9uIHNwZWNpZmljIGZvciBob3cgdGhl
DQo+ID4gaG9zdCBjYW4gc3luY2hyb25pemUgd2l0aCB0aGUgZGV2aWNlLg0KPiANCj4gUmVhZCB0
aGUgQk9UIHNwZWMuICBJIHF1b3RlIHNvbWUgb2YgdGhlIHJlbGV2YW50IHBhcnRzIGJlbG93Lg0K
PiANCj4gPiA+ID4gRm9yIFdpbmRvd3MgTVNDIGRyaXZlciwgd2hlbiB0aGUgaG9zdCByZWNvdmVy
cyBmcm9tIHRoZSB0cmFuc2FjdGlvbg0KPiA+ID4gPiBlcnJvciwgaXQgc2VuZHMgQ0xFQVJfRkVB
VFVSRShoYWx0X2VwKSBhbmQgZXhwZWN0cyB0aGUgdHJhbnNmZXIgdG8gYmUNCj4gPiA+ID4gY2Fu
Y2VsbGVkLiBUbyBzeW5jaHJvbml6ZSB3aXRoIHRoZSBob3N0LCB0aGUgZ2FkZ2V0IGRyaXZlciBu
ZWVkcyB0bw0KPiA+ID4gPiBjYW5jZWwgdGhlIHJlcXVlc3QuIER3YzMgbmVlZHMgdG8gbm90aWZ5
IHRoZSBnYWRnZXQgZHJpdmVyIG9mIHRoaXMuDQo+ID4gPiANCj4gPiA+IE5vLCB0aGF0J3Mgbm90
IHdoYXQgaGFwcGVucyBpbiB0aGUgTWFzcyBTdG9yYWdlIENsYXNzLg0KPiA+ID4gDQo+ID4gPiBG
b3IgdGhlIEJ1bGstT25seSBUcmFuc3BvcnQgdmVyc2lvbiBvZiBNU0MsIHdoZW4gYSBXaW5kb3dz
IG9yIExpbnV4IGhvc3QgDQo+ID4gPiBkZXRlY3RzIGEgdHJhbnNhY3Rpb24gZXJyb3IsIGl0IHBl
cmZvcm1zIGEgVVNCIHBvcnQgcmVzZXQuICBUaGlzIGNsZWFycyANCj4gPiANCj4gPiBObywgdGhh
dCdzIGltcGxlbWVudGF0aW9uIHNwZWNpZmljIGZvciByZXNldCByZWNvdmVyeS4gVHlwaWNhbGx5
IGZvcg0KPiANCj4gSSBoYXZlbid0IHRlc3RlZCByZWNlbnQgdmVyc2lvbnMgb2YgV2luZG93cy4g
IE9sZGVyIHZlcnNpb25zIGRpZCBiZWhhdmUgDQo+IHRoaXMgd2F5LiAgSSBzdGlsbCBoYXZlIHRo
ZSBsb2dzIHRvIHByb3ZlIGl0Lg0KPiANCj4gPiBXaW5kb3dzLCBmb3IgdGhlIGZpcnN0IHJlY292
ZXJ5LCBpdCBzZW5kcyBhIENsZWFyRmVhdHVyZShoYWx0X2VwKSBhbmQNCj4gPiBzZW5kcyBhIG5l
dyBNU0MgY29tbWFuZC4NCj4gDQo+IFRoYXQncyBhIHZpb2xhdGlvbiBvZiB0aGUgQk9UIHNwZWMu
ICBBcmUgeW91IHN1cmUgV2luZG93cyByZWFsbHkgZG9lcyANCj4gdGhpcz8NCg0KVGhpcyB3YXMg
YWN0dWFsbHkgZnJvbSBVQVNQLCBub3QgQk9ULiBTb3JyeSBmb3Igbm90IGJlaW5nIGNsZWFyLg0K
DQo+IA0KPiA+ICBJZiB0aGUgdHJhbnNmZXIgZG9lc24ndCBjb21wbGV0ZSB3aXRoaW4gYQ0KPiA+
IHNwZWNpZmljIHRpbWUsIHRoZXJlIHdpbGwgYmUgYSB0aW1lb3V0IGFuZCBhIHBvcnQgcmVzZXQs
IHdoaWNoIGlzDQo+ID4gYW5vdGhlciBsZXZlbCBvZiByZWNvdmVyeS4NCj4gPiANCj4gPiA+IGFs
bCB0aGUgc3RhdGUgb24gdGhlIGdhZGdldC4gIFRoZSBnYWRnZXQgZ2V0cyByZS1lbnVtZXJhdGVk
LCBhbmQgdGhlIA0KPiA+ID4gaG9zdCBwcm9jZWVkcyB0byByZS1pc3N1ZSB0aGUgTVNDIGNvbW1h
bmQuICBUaGUgZ2FkZ2V0IGRyaXZlciBkb2Vzbid0IA0KPiA+ID4gbmVlZCBhbnkgc3BlY2lhbCBu
b3RpZmljYXRpb25zOyBvdXRzdGFuZGluZyByZXF1ZXN0cyBnZXQgY2FuY2VsbGVkIGFzIGEgDQo+
ID4gPiBub3JtYWwgcGFydCBvZiB0aGUgcmVzZXQgaGFuZGxpbmcuDQo+ID4gPiANCj4gPiA+IChJ
biBmYWN0LCB0aGlzIGlzIG5vdCB3aGF0IHRoZSBCT1Qgc3BlYyBzYXlzIHRvIGRvLiAgSXQgc2F5
cyB0aGF0IHdoZW4gDQo+ID4gPiB0aGUgaG9zdCBkZXRlY3RzIGEgdHJhbnNhY3Rpb24gZXJyb3Is
IGl0IHNob3VsZCBhIEJ1bGstT25seSBNYXNzIFN0b3JhZ2UgDQo+ID4gPiBSZXNldCAtLSB0aGlz
IGlzIGEgc3BlY2lhbCBjbGFzcy1zcGVjaWZpYyBjb250cm9sIHRyYW5zZmVyLiAgSW4gDQo+ID4g
PiByZXNwb25zZSwgdGhlIGdhZGdldCBkcml2ZXIgaXMgc3VwcG9zZWQgdG8gcmVzZXQgaXRzIGlu
dGVybmFsIHN0YXRlIGFuZCANCj4gPiA+IGNhbmNlbCBhbGwgb2YgaXRzIG91dHN0YW5kaW5nIHJl
cXVlc3RzLiAgVGhlbiB0aGUgaG9zdCBpc3N1ZXMgDQo+ID4gPiBDTEVBUl9GRUFUVVJFKEhBTFQp
IHRvIGJvdGggdGhlIGJ1bGstSU4gYW5kIGJ1bGstT1VUIGVuZHBvaW50cyBhbmQgDQo+ID4gPiBw
cm9jZWVkcyB0byBpc3N1ZSBpdHMgbmV4dCBNU0MgY29tbWFuZC4gIEEgbG90IG9mIE1TQyBkZXZp
Y2VzIGRvbid0IA0KPiA+ID4gaGFuZGxlIHRoaXMgcHJvcGVybHksIHByb2JhYmx5IGJlY2F1c2Ug
V2luZG93cyBkaWRuJ3QgdXNlIHRoaXMgDQo+ID4gPiBhcHByb2FjaC4pDQo+ID4gDQo+ID4gQXQg
dGhlIG1vbWVudCwgdGhlIGdhZGdldCBkcml2ZXIgZG9lc24ndCBoYW5kbGUgQ0xFQVJfRkVBVFVS
RShoYWx0X2VwKSwNCj4gPiB0aGUgVURDIGRyaXZlciBkb2VzLg0KPiANCj4gQ29ycmVjdC4gIE15
IHBvaW50IGlzIHRoYXQgaXQgd29ya3MgdGhpcyB3YXkgYmVjYXVzZSB0aGUgZ2FkZ2V0IGRyaXZl
ciANCj4gZG9lc24ndCBfbmVlZF8gdG8gaGFuZGxlIENsZWFyLUhhbHQuDQo+IA0KPiA+ICAgSSBk
b24ndCByZWNhbGwgdGhpcyBiZWluZyBoYW5kbGVkIGluIHRoZSBjb21wb3NpdGUNCj4gPiBmcmFt
ZXdvcmsgb3IgaW4gdGhlIGZfbWFzc19zdG9yYWdlIGZ1bmN0aW9uIGRyaXZlci4gVW5sZXNzIHdl
IGNoYW5nZQ0KPiA+IHRoaXMsIHRoZSBVREMgZHJpdmVyIG5lZWRzIHRvIG5vdGlmeSB0aGUgZ2Fk
Z2V0IGRyaXZlciBzb21laG93Lg0KPiANCj4gTm8sIGZfbWFzc19zdG9yYWdlIGRvZXMgbm90IG5l
ZWQgdG8gYmUgbm90aWZpZWQgYWJvdXQgQ2xlYXItSGFsdHMuICBBcyANCj4geW91IHNheSwgaXQg
aXNuJ3QgZ2V0dGluZyBub3RpZmllZCBub3csIGFuZCB5ZXQgaXQgc29tZWhvdyBzdGlsbCBtYW5h
Z2VzIA0KPiB0byB3b3JrIHdpdGggZXZlcnkgdHlwZSBvZiBob3N0IEknbSBhd2FyZSBvZi4NCj4g
DQo+ID4gPiBJbiB0aGUgVUFTIHZlcnNpb24gb2YgTVNDLCB0aGUgZW5kcG9pbnRzIG5ldmVyIGhh
bHQuICBJZiB0aGVyZSdzIGEgDQo+ID4gPiB0cmFuc2FjdGlvbiBlcnJvciwgdGhlIGhvc3Qgc2lt
cGx5IHJlLWlzc3VlcyB0aGUgdHJhbnNhY3Rpb24uICBJZiB0aGF0IA0KPiA+IA0KPiA+IFRoZXJl
IGFyZSBtdWx0aXBsZSBsZXZlbHMgb2YgcmVjb3ZlcnkuIERpZmZlcmVudCBkcml2ZXIgaGFuZGxl
cyBpdA0KPiA+IGRpZmZlcmVudGx5LiBGb3IgeEhDSSwgSW5pdGlhbGx5IHRoZXJlJ3MgcmV0cnkg
YXQgdGhlIHBhY2tldCBsZXZlbA0KPiA+ICh0eXBpY2FsbHkgc2V0IHRvIHJldHJ5IDMgdGltZXMg
aW4gYSByb3cpLiBJZiBpdCBmYWlscywgaG9zdCBjb250cm9sbGVyDQo+ID4gZHJpdmVyIHdpbGwg
Z2V0IGEgdHJhbnNhY3Rpb24gZXJyb3IgZXZlbnQuDQo+IA0KPiBUaGF0IDMtc3RyaWtlcy1hbmQt
eW91J3JlLW91dCB0aGluZyBpcyB0aGUgbm9ybWFsIFVTQiBsb3ctbGV2ZWwgcmV0cnkgDQo+IG1l
Y2hhbmlzbS4gIFdlJ3JlIHRhbGtpbmcgYWJvdXQgd2hhdCBoYXBwZW5zIHdoZW4gaXQgZmFpbHMg
YW5kIHRoZSBIQ0QgDQo+IHJlcG9ydHMgYSB0cmFuc2FjdGlvbiBlcnJvciBzdWNoIGFzIC1FUFJP
VE8uDQo+IA0KPiA+IEluIExpbnV4IHhIQ0ksIHRoZSByZWNvdmVyeSBmb3IgdHJhbnNhY3Rpb24g
ZXJyb3Igd2UgcGVyZm9ybSBzb2Z0LXJlc2V0DQo+ID4gKHhoY2kgcmVzZXQgZXAgY29tbWFuZCB3
aXRoIFRTUD0xKS4gSWYgaXQgc3RpbGwgZmFpbHMsIHdlIHJlc2V0IHRoZQ0KPiA+IGVuZHBvaW50
IChUU1A9MCkgYW5kIHJldHVybiB0aGUgcmVxdWVzdCB3aXRoIC1FUFJPVE8gdG8gdGhlIGNsYXNz
DQo+ID4gZHJpdmVyLiBIb3dldmVyLCB3ZSBkb24ndCBzZW5kIENsZWFyRmVhdHVyZShoYWx0X2Vw
KS4gSSBkb24ndCByZWNhbGwNCj4gPiBMaW51eCBNU0MgZHJpdmVyIGhhbmRsZSAtRVBST1RPIGFu
ZCBkbyBhIHBvcnQgcmVzZXQuIEhvd2V2ZXIgaXQgZG9lcyBkbw0KPiA+IGEgcG9ydCByZXNldCBk
dWUgdG8gdHJhbnNmZXIgdGltZW91dC4NCj4gDQo+IEluIHVzYi1zdG9yYWdlLCBhIC1FUFJPVE8g
ZXJyb3Igc3RhdHVzIGNhdXNlcyBpbnRlcnByZXRfdXJiX3Jlc3VsdCgpIHRvIA0KPiByZXR1cm4g
VVNCX1NUT1JfWEZFUl9FUlJPUi4gIFRoaXMgY2F1c2VzIHVzYl9zdG9yX2ludm9rZV90cmFuc3Bv
cnQoKSB0byANCj4gZ290byBIYW5kbGVfRXJyb3JzOiwgd2hpY2ggY2FsbHMgdXNiX3N0b3JfcG9y
dF9yZXNldCgpLg0KPiANCj4gSW4gdWFzLCBhIC1FUFJPVE8gZXJyb3Igd2lsbCBjYXVzZSBhbiBl
cnJvciBzdGF0dXMgdG8gYmUgcmV0dXJuZWQgdG8gdGhlIA0KPiBTQ1NJIGxheWVyLCB3aGljaCB3
aWxsIGludm9rZSB0aGUgU0NTSSBlcnJvciBoYW5kbGVyLiAgQWZ0ZXIgZW5vdWdoIA0KPiBmYWls
dXJlcyBpdCB3aWxsIGNhbGwgdGhlIHVhcyBkZXZpY2UtcmVzZXQgaGFuZGxlciwgYW5kIA0KPiB1
YXNfZWhfZGV2aWNlX3Jlc2V0X2hhbmRsZXIoKSBjYWxscyB1c2JfcmVzZXRfZGV2aWNlKCkuDQoN
CkZyb20gbXkgdGVzdGluZyB3aXRoIFVBU1AsIGlmIEkgcmVjYWxsIGNvcnJlY3RseSwgdGhlcmUn
cyBhIDMwIHNlY29uZA0KdGltZW91dCBiZWZvcmUgdGhlIHJlc2V0IGhhbmRsZXIga2lja3MgaW4u
DQoNCj4gDQo+ID4gSW4gV2luZG93cywgaXQgZG9lc24ndCBkbyBzb2Z0LXJlc2V0LCBidXQgaXQg
ZG9lcyByZXNldCBlbmRwb2ludCAoVFNQPTApDQo+ID4gYW5kIHNlbmQgQ0xFQVJfRkVBVFVSRSho
YWx0X2VwKSB3aXRob3V0IHBvcnQgcmVzZXQgaW5pdGlhbGx5LiBJdCB0aGVuDQo+ID4gY2FuIHNl
bmQgdGhlIGEgbmV3IE1TQyBjb21tYW5kIGV4cGVjdGluZyB0aGUgZGV2aWNlIHRvIGJlIGluIHN5
bmMgYmFzZWQNCj4gPiBvbiB0aGUgQ0xFQVJfRkVBVFVSRShoYWx0X2VwKSByZXF1ZXN0Lg0KPiAN
Cj4gVGhhdCBpcyBub3QgaG93IHRoZSBCdWxrLU9ubHkgVHJhbnNwb3J0IHByb3RvY29sIHJlc3lu
Y2hyb25pemVzIGFmdGVyIGEgDQo+IHByb3RvY29sIGVycm9yLiAgVGhlIEJPVCBzcGVjIG1lbnRp
b25zIGluIHNldmVyYWwgcGxhY2VzIHZhcmlhdGlvbnMgb2Y6DQo+IA0KPiAJSWYgdGhlIGhvc3Qg
ZGV0ZWN0cyBhIFNUQUxMIG9mIHRoZSBCdWxrLU91dCBlbmRwb2ludCBkdXJpbmcgDQo+IAljb21t
YW5kIHRyYW5zcG9ydCwgdGhlIGhvc3Qgc2hhbGwgcmVzcG9uZCB3aXRoIGEgUmVzZXQgUmVjb3Zl
cnkNCj4gCShzZWUgNS4zLjQgLSBSZXNldCBSZWNvdmVyeSkuDQo+IA0KPiBJdCBkb2Vzbid0IHNh
eSBzcGVjaWZpY2FsbHkgd2hhdCB0byBkbyBpbiBjYXNlIG9mIG90aGVyIGxvd2VyLWxldmVsIA0K
PiBwcm90b2NvbCBlcnJvcnMsIGJ1dCB3ZSBoYXZlIHRvIGFzc3VtZSB0aGF0IHRoZSBpbnRlbnRp
b24gaXMgZm9yIHRoZSANCj4gaG9zdCB0byBmb2xsb3cgdGhlIFJlc2V0IFJlY292ZXJ5IHByb2Nl
ZHVyZSwgYmVjYXVzZSB0aGF0J3Mgd2hhdCB0aGUgDQo+IGRldmljZSB3aWxsIGV4cGVjdCB0byBz
ZWUuICBUaGUgc3BlYyBnb2VzIG9uIHRvIHNheToNCj4gDQo+IAk1LjMuNAlSZXNldCBSZWNvdmVy
eQ0KPiANCj4gCUZvciBSZXNldCBSZWNvdmVyeSB0aGUgaG9zdCBzaGFsbCBpc3N1ZSBpbiB0aGUg
Zm9sbG93aW5nIG9yZGVyOg0KPiAJCShhKSBhIEJ1bGstT25seSBNYXNzIFN0b3JhZ2UgUmVzZXQN
Cj4gCQkoYikgYSBDbGVhciBGZWF0dXJlIEhBTFQgdG8gdGhlIEJ1bGstSW4gZW5kcG9pbnQNCj4g
CQkoYykgYSBDbGVhciBGZWF0dXJlIEhBTFQgdG8gdGhlIEJ1bGstT3V0IGVuZHBvaW50DQo+IA0K
PiBJdCBtb3N0IGRlZmluaXRlbHkgZG9lcyBfbm90XyBzYXkgdGhhdCB0aGUgaG9zdCBzaG91bGQg
ZG8gYSBDbGVhci1IYWx0IA0KPiB3aXRob3V0IHRoZSBCdWxrLU9ubHkgTWFzcyBTdG9yYWdlIFJl
c2V0LiAgQnkgcmVhZGluZyB0aGUgc3BlYyBjYXJlZnVsbHkgDQo+IHlvdSBjYW4gc2VlIHRoYXQg
c3VjaCBhY3Rpb24gd291bGQgbGVhdmUgdGhlIGhvc3Qgb3V0IG9mIHN5bmMgd2l0aCB0aGUgDQo+
IGRldmljZS4NCg0KQWdhaW4sIHNvcnJ5IGZvciBub3QgYmVpbmcgY2xlYXIgaGVyZS4gVGhlIHRl
c3RzIHdlIGRpZCB3YXMgYWdhaW5zdA0KVUFTUC4NCg0KRnJvbSB0aGUgeEhDSSBzcGVjLCBpdCBz
dWdnZXN0cyB0byBpc3N1ZSBhIENMRUFSX0ZFQVRVUkUoaGFsdF9lcCkgYWZ0ZXINCnRoZSBlbmRw
b2ludCByZXNldCAoZS5nLiBmcm9tIHRyYW5zYWN0aW9uIGVycm9yKS4gV2hldGhlciB0aGlzIGFj
dGlvbg0Kc2hvdWxkIGJlIHRha2VuIGZyb20gdGhlIGNsYXNzIGRyaXZlciBvciBmcm9tIHRoZSB4
SENJIGRyaXZlciwgaXQncyBub3QNCmNsZWFyLiBIb3dldmVyLCBhcyB5b3Ugc2FpZCwgd2l0aG91
dCBCdWxrLU9ubHkgTWFzcyBTdG9yYWdlIFJlc2V0DQpyZXF1ZXN0LCB0aGUgaG9zdCBhbmQgZGV2
aWNlIHdpbGwgYmUgb3V0IG9mIHN5bmMuIFRoZSByZXNwb25zZSBhY3Rpb24NCnRha2VuIGZyb20g
eEhDSSBpcyBpbmRlcGVuZGVudCBmcm9tIE1TQyBwcm90b2NvbC4gU28gaXQgd291bGQgbWFrZSBz
ZW5zZQ0KZm9yIHRoZSBVREMgZHJpdmVyIHRvIHRyZWF0IENMRUFSX0ZFQVRVUkUoaGFsdF9lcCkg
YXMgc3VjaCBhbmQgbm90DQpleHBlY3QgYSBCdWxrLU9ubHkgTWFzcyBTdG9yYWdlIFJlc2V0IG9y
IHRoZSBlcXVpdmFsZW50Lg0KDQo+IA0KPiA+ICBJZiB0aGUgcmVjb3ZlcnkgZmFpbHMgYW5kIHRo
ZQ0KPiA+IHRyYW5zZmVyL2NvbW1hbmQgdGltZWQgb3V0LCBpdCB3aWxsIHRoZW4gZG8gYSBwb3J0
IHJlc2V0IHRvIHJlY292ZXIuDQo+ID4gDQo+ID4gPiBmYWlscyB0b28sIGVycm9yIHJlY292ZXJ5
IGlzIHN0YXJ0ZWQgYnkgdGhlIFNDU0kgbGF5ZXI7IGl0IGludm9sdmVzIGEgDQo+ID4gPiBVU0Ig
cG9ydCByZXNldC4NCj4gPiA+IA0KPiA+ID4gQnV0IGFzIHlvdSBjYW4gc2VlLCBpbiBlYWNoIGNh
c2UgdGhlIFVEQyBkcml2ZXIgZG9lc24ndCBoYXZlIHRvIGNhbmNlbCANCj4gPiA+IGFueXRoaW5n
IGluIHBhcnRpY3VsYXIgd2hlbiBpdCBnZXRzIGEgQ2xlYXItSGFsdC4NCj4gPiA+IA0KPiA+ID4g
PiBGb3Igb3RoZXIgY2xhc3MgZHJpdmVyLCBpdCBtYXkgZXhwZWN0IHRoZSB0cmFuc2ZlciB0byBy
ZXN1bWUgYWZ0ZXIgZGF0YQ0KPiA+ID4gPiBzZXF1ZW5jZSByZXNldC4NCj4gPiA+IA0KPiA+ID4g
SW5kZWVkLiAgSW4gd2hpY2ggY2FzZSwgdGhlIFVEQyBkcml2ZXIgc2hvdWxkbid0IGNhbmNlbCBh
bnl0aGluZy4NCj4gPiA+IA0KPiA+ID4gPiBBcyBhIHJlc3VsdCwgZm9yIGFuIGVuZHBvaW50IHRo
YXQncyBTVEFMTCAob3Igbm90KSwgYW5kIGlmIHRoZSBob3N0DQo+ID4gPiA+IHNlbmRzIENMRUFS
X0ZFQVRVUkUoaGFsdF9lcCksIHRoZSBkd2MzIHJldHVybnMgdGhlIHJlcXVlc3Qgd2l0aCBzb21l
DQo+ID4gPiA+IHN0YXR1cyBjb2RlIGFuZCBsZXQgdGhlIGdhZGdldCBkcml2ZXIgaGFuZGxlIGl0
LiBJZiB0aGUgZ2FkZ2V0IGRyaXZlcg0KPiA+ID4gPiB3YW50cyB0byBjYW5jZWwgdGhlIHRyYW5z
ZmVyLCBpdCBjYW4gZHJvcCB0aGUgdHJhbnNmZXIuIElmIHRoZSBnYWRnZXQNCj4gPiA+ID4gZHJp
dmVyIHdhbnRzIHRvIHJlc3VtZSwgaXQgY2FuIHJlcXVldWUgdGhlIHNhbWUgcmVxdWVzdHMgd2l0
aCB0aGUgc2F2ZWQNCj4gPiA+ID4gc3RhdHVzIHRvIHJlc3VtZSB3aGVyZSBpdCBsZWZ0IG9mZi4N
Cj4gPiA+IA0KPiA+ID4gVGhlIFVEQyBkcml2ZXIgc2hvdWxkIG5vdCBkZXF1ZXVlIGEgcmVxdWVz
dCBtZXJlbHkgYmVjYXVzZSB0aGUgZW5kcG9pbnQgDQo+ID4gPiBpcyBoYWx0ZWQuICBUaGUgZ2Fk
Z2V0IGRyaXZlciBjYW4gdGFrZSBjYXJlIG9mIGV2ZXJ5dGhpbmcgbmVjZXNzYXJ5LiAgDQo+ID4g
PiBBZnRlciBhbGwsIGl0IGtub3dzIHdoZW4gYW4gZW5kcG9pbnQgZ2V0cyBoYWx0ZWQsIGJlY2F1
c2UgdGhlIGdhZGdldCANCj4gPiANCj4gPiBObywgY3VycmVudGx5IGl0IGRvZXNuJ3Qga25vdy4g
VGhhdCdzIHRoZSBwcm9ibGVtLiBUaGUgZHdjMyBkcml2ZXINCj4gPiBoYW5kbGVzIHRoZSBDTEVB
Ul9GRUFUVVJFKGhhbHRfZXApLCBub3QgdGhlIGdhZGdldCBkcml2ZXIuDQo+IA0KPiBZb3UgbWlz
dW5kZXJzdG9vZCB3aGF0IEkgd3JvdGUuICBJIHNhaWQgdGhhdCB0aGUgZ2FkZ2V0IGRyaXZlciBr
bm93cyANCj4gd2hlbiBhbiBlbmRwb2ludCdzIGhhbHQgZmVhdHVyZSBnZXRzIF9zZXRfOyBJIGRp
ZG4ndCBzYXkgdGhhdCBpdCBrbm93cyANCj4gd2hlbiB0aGUgaGFsdCBmZWF0dXJlIGdldHMgX2Ns
ZWFyZWRfLg0KPiANCj4gKFRoZXJlIGlzIG9uZSBleGNlcHRpb246IFRoZSBnYWRnZXQgZHJpdmVy
IHdvbid0IGtub3cgaWYgdGhlIGhvc3Qgc2VuZHMgDQo+IGEgU0VUX0ZFQVRVUkUoaGFsdF9lcCku
ICBIb3N0cyBkb24ndCBub3JtYWxseSBkbyB0aGlzIGFuZCBJIGRvbid0IHRoaW5rIA0KPiB3ZSBu
ZWVkIHRvIHdvcnJ5IGFib3V0IGl0LikNCj4gDQo+ID4gPiBkcml2ZXIgaXMgd2hhdCBjYWxscyB1
c2JfZXBfc2V0X2hhbHQoKSBvciB1c2JfZXBfc2V0X3dlZGdlKCkgaW4gdGhlIA0KPiA+ID4gZmly
c3QgcGxhY2UuDQo+ID4gPiANCj4gPiA+IEFzIGZvciBoYW5kbGluZyBDTEVBUl9GRUFUVVJFKEhB
TFQpLCBhbGwgdGhlIFVEQyBkcml2ZXIgbmVlZHMgdG8gZG8gaXMgDQo+ID4gPiBjbGVhciB0aGUg
SEFMVCBmZWF0dXJlIGZvciB0aGUgZW5kcG9pbnQuICAoQWx0aG91Z2ggaWYgdGhlIGVuZHBvaW50
IGlzIA0KPiA+ID4gd2VkZ2VkLCB0aGUgSEFMVCBmZWF0dXJlIHNob3VsZCBub3QgYmUgY2xlYXJl
ZC4pICBJdCBkb2Vzbid0IG5lZWQgdG8gDQo+ID4gPiBjYW5jZWwgYW55IG91dHN0YW5kaW5nIHJl
cXVlc3RzIG9yIGluZm9ybSB0aGUgZ2FkZ2V0IGRyaXZlciBpbiBhbnkgd2F5Lg0KPiA+IA0KPiA+
IFRoZSBVREMgZHJpdmVyIG5lZWRzIHRvIG5vdGlmeSB0aGUgZ2FkZ2V0IGRyaXZlciBzb21laG93
LCBjYW5jZWxsaW5nIHRoZQ0KPiA+IHJlcXVlc3QgYW5kIGdpdmUgaXQgYmFjayBpcyBjdXJyZW50
bHkgdGhlIHdheSBkd2MzIGhhbmRsaW5nIGl0Lg0KPiANCj4gQW5kIEknbSBzYXlpbmcgdGhhdCB0
aGUgVURDIGRyaXZlciBkb2VzIF9ub3RfIG5lZWQgdG8gbm90aWZ5IHRoZSBnYWRnZXQgDQo+IGRy
aXZlci4NCj4gDQo+IFRoZSBNU0MgZ2FkZ2V0IGRyaXZlciB3b3JrcyBqdXN0IGZpbmUgd2l0aG91
dCBhbnkgc3VjaCBub3RpZmljYXRpb24uICANCj4gQ2FuIHlvdSBuYW1lIGFueSBnYWRnZXQgZHJp
dmVyIHRoYXQgX2RvZXNfIG5lZWQgYSBub3RpZmljYXRpb24/DQo+IA0KDQpXZSB3ZXJlIHRlc3Rp
bmcgYWdhaW5zdCBVQVNQLiBUaGUgcmVhc29uIEkgYWRkZWQgdGhpcyB3YXMgdG8gbWltaWMgdGhl
DQpiZWhhdmlvciBvZiBjb21tb24gdmVuZG9yIFVBU1AgZGV2aWNlcyB3aGVuIGl0IHJlY292ZXJz
IGZyb20gdHJhbnNhY3Rpb24NCmVycm9ycyBpbiBXaW5kb3dzLg0KDQpXaGVuIHRoZSBkYXRhIHNl
cXVlbmNlIG9mIGEgdHJhbnNmZXIgaXMgcmVzZXQsIHRoZSBob3N0IG5lZWRzIHRvIHNlbmQNCkNM
RUFSX0ZFQVRVUkUoaGFsdF9lcCkuIEl0IHNob3VsZCBiZSBhIGNvbW1vbiBiZWhhdmlvci4gU2lu
Y2UgaXQgaXMNCmNvbW1vbiBhbmQgcGFydCBvZiB0aGUgeEhDSSBzcGVjLCBkbyB3ZSBleHBlY3Qg
dGhlIHhIQ0kgdG8gc2VuZCB0aGlzIG9yDQpkbyB3ZSBleHBlY3QgdGhlIGNsYXNzIHByb3RvY29s
IHRvIGRvY3VtZW50IGFuZCBoYW5kbGUgdGhpcz8gQXQgdGhlDQptb21lbnQsIEkgZXhwZWN0IGl0
IHRvIGJlIHRoZSBmb3JtZXIgYW5kIGV4cGVjdCB0aGUgVURDIGRyaXZlciB0byB0cmVhdA0KaXQg
YXMgYSBjb21tb24gc3luY2hyb25pemF0aW9uIHRoYXQgcGVyaGFwcyB0aGUgb25seSBzeW5jaHJv
bml6YXRpb24NCm1lY2hhbmlzbSB0aGUgdXBwZXIgcHJvdG9jb2wgZGVwZW5kcyBvbi4NCg0KVGhh
bmtzLA0KVGhpbmg=
