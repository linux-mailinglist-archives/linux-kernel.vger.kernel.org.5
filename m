Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B7E785E69
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbjHWRS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjHWRS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:18:26 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27DDE67;
        Wed, 23 Aug 2023 10:18:23 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NGjcRe016872;
        Wed, 23 Aug 2023 10:18:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=14hW7OHCM+HPoM96GtVfL0wqksdfLmYsHw65PguAPVo=;
 b=Q4/IAWrXoAn+9KM4c4QMS0yze+5jGPIJmfEqWsWJSgp1Uf1BJf8lPaywoDtROq/F1f81
 9rfYFB91TjJCTmEjYILupRQc8XeS7jWFIa2ijf9rMtGVTgI0OHCUmY0opDkxHPDJP3T9
 cFgeVFGVjUHZTiz/2L7ZvDgFJAjebCGH7iGPJpxy2O4Fg+8sNhfhUZWcw/xzqP4gkxmJ
 DXcCbT9y3blXGrCi4Jro8r2UT0cieqLZcaOY6a2pzh8KVVDYguAetCrEQbX5d/KytLBp
 Z8MFs73jqAEb7U25d83oNih51ZorhohWvGXAgeyyaOVvo0W39HHIczi+fbppT6af73j7 jQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3sn21qdw24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 10:18:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692811092; bh=14hW7OHCM+HPoM96GtVfL0wqksdfLmYsHw65PguAPVo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=YB4eqtBkJ8kIGanYYEWXtAY19z+wH7UzMYYTSGR/itXTDv6woFD0TW/mezQhrM9LY
         E2GbdlJUwH+pBVqPr1FmkQ5cXlDavc7ezoB4dHQ6eRoMPt599tr0g+iIeiPuN/ApIz
         uKUjJUqQuXQ5NxBKvXmIC8QKIkiK3a0jK8CGVH7fnEFe5RIikla9YbAojKMgbL2jbS
         sEueZBYsudN81dqTmNd+tSxu9p0wXw9MALqbxCAG8L1L+4b83EytXV30cqBoxkhmvo
         MgcV9De5TaQKBKGT5t/p2qtSZ8TVS1FxltB/K4c4o10ybNTrxKOBJjw+nZFP8Ybma5
         1YJbFXz+B5G0Q==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DC3D9401CF;
        Wed, 23 Aug 2023 17:18:11 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 86A0EA005C;
        Wed, 23 Aug 2023 17:18:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=BpAhLddN;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2B6A940356;
        Wed, 23 Aug 2023 17:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeXABOzD0YtNxvgEch2SfEUxMoSxxH8ECBTjuznzciYNocCh+CIcigk1fHMcl0k21hOUn72QEJkAi99ED7S88FCwZSxyQShzl7+FXV3qTyNF84J029Juz5y6h/a1D6PD/N/OX+O69ZgqXCX9EdZelLuF5CL8Qq2BmaLvz7BbIFncLooOt8VUPf+2dvS2KO3pYKFSDiEHuErgo7I/wze7pKmPtaDAA2/3HFMqUmuhMaf271IxDLods0q9Kth655/xReAh+3Fv8I+5KNmzlEonWireyhM2q1ehCXgmUCUVDfqGZN12dG3EFAMqLEiInGuRtn/79MSLjYim/uCwIlaIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14hW7OHCM+HPoM96GtVfL0wqksdfLmYsHw65PguAPVo=;
 b=UNxe196zPzng2WJ7sS0jWYiZrWn8mwnsX/nnA/q2BNZj3qC3vsIXuXNhtjbx3tK/gTFCKvcoI5FERm/R6lIemsLmSqxCDckLJYZrv1I+dttkKcT59FAkIvGxSEEv1o42i8+Lwj8tuFhsgha8OpPRquEbwoQ7PtM0NryoHClZE1xIKhxihF8ARpCHp0f7vYpL+k+jgE/xyRcSobbzT8v9m+O3/VhNTfPVRWTHd+oDthYJdff16fMKqnIokcDDMEHCXq/bq3g9H+Ty6w60HPMYwhjVeDxQb0VJKAQl6UG3OwdkfWgc+BAgPJU73Q6im4T0zZ3VPXEh/hYi9f/iQMbOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14hW7OHCM+HPoM96GtVfL0wqksdfLmYsHw65PguAPVo=;
 b=BpAhLddNsSRAjVTJtP4AwPQiPn5BbDTChpGgy13OAN8onnaARSLcsnYHcVMtZ5AogfvZBgGqDoHJY/p+SB8Vuk+R76Prd8ZnFLM6wRSS46qCMoXZem7iNAatlZhMiGyOOIYVrMh2zRT7+J6nAkbRhonLo/WLTECtfT2raNs4AHo=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 17:18:03 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 17:18:03 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Andrey Konovalov <andreyknvl@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Thread-Topic: dwc3: unusual handling of setup requests with wLength == 0
Thread-Index: AQHZ0WkxsEX2ZGMtZEmcF1gvP2WuTK/vPhuAgAAY0oCAAAlogIAACMGAgAEOQgCAADc1AIAAELKAgAKA6gCAAbHAgIAAFDOAgAIqmoCAAN7kAIAAGRiA
Date:   Wed, 23 Aug 2023 17:18:02 +0000
Message-ID: <20230823171757.vegbktpkk23eg34z@synopsys.com>
References: <20230818031045.wovf5tj2un7nwf72@synopsys.com>
 <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
 <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com>
 <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
 <CA+fCnZcmb78DMaffb3cq2JeCNxcGBeyt8hxeJq3SaTTkbZ3ewA@mail.gmail.com>
 <3f52eb94-1d8c-4233-86ac-bbc78d4efce7@rowland.harvard.edu>
 <CA+fCnZcJ0JHHY04By+PjYvofpefKtp1br63gJNsEL=J7n1_vCA@mail.gmail.com>
 <bdf69b9d-fe82-48e2-9638-d84d00d4ef1d@rowland.harvard.edu>
In-Reply-To: <bdf69b9d-fe82-48e2-9638-d84d00d4ef1d@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB5818:EE_
x-ms-office365-filtering-correlation-id: 56fb7406-5ebe-4e17-9a39-08dba3fce86a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4IGEE3oXegpqKH4pwVVEaEru+H19AqoqnI961QYUlpZkKOCfrUjbYZnolLMKoOaA1YT7ZDoYtQe0Vxzli8k4qATto3woGPQUObn5tmJ12gHl+CCbyKuVoUjacSo4zTf5MgFUzpt+PO+9bCosIdzJBwklkdVDPxp/Vh999UjXwGDFbkqXMLzitRwSjYZ0kjm8z5MCPhdviQO1LfBWHzFtpONZl2iP7BhZUWBPZ3vKEDlaQ/BMUeFzLOEkpkILm3jBli3sWvCy+OUwA02gJXjY/JrJd5ac4k6cZHcAvpe9YL5X4SbWikC2g6QnCdPZxYTn+WueZ5f7r4lWWjdq3htAje7+CkrHalFl4iJyKbUFbMLcKCMKOQm8GKslruirxFkB087nJzJWatBVlpPeErPJV64OvciHcRoaGjORZ3b3qTQm0BPYWnjav2bWsONSZhQAimR7Xzsf8dz5w7m8GdZXyz+FASJfNVapgwjblWeOnM2WwmCLmBL+1dyPdELSzFpk76FE7h5UMQu1zlGo9OJf3bozQJ5SSxhOFEpHSYGB3BoLKWUTM7riD7pTD443Up6ax1LF2eitEFPrhAlEjdVT7SGSP70U7Ghl5w3+yTGpSYqVw7DrwLz7sWiT7jWwA0JU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(2906002)(38070700005)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(66556008)(316002)(6512007)(66946007)(64756008)(6916009)(54906003)(76116006)(66446008)(66476007)(91956017)(478600001)(122000001)(71200400001)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDRJbDhjTDAvbWwwT3htTEsxd3pLUWVPcTVpZTJLNkV5NU5WTGgraWg3Zm1m?=
 =?utf-8?B?S2pYRlUrQlJ5aisyRFhqSmtLQUl5NktZdTRGN3dKMWVEREg0b2lRZGdPOU0x?=
 =?utf-8?B?ODdFYTdibUd2RWJNUjF6MktkWDZUUG0vWVU0R3F6VEF0ZjNxWE1BT08rd3dB?=
 =?utf-8?B?U3dFWHBCV28yQjI5WG10M1drdEdKaWRlSTZVdWVDVHFpM1JQZTlzbkxmR0Nv?=
 =?utf-8?B?VFQzcEgya3JickJkaDZiN2V3RVhIa0ZxZ3ovMkhRU05GVDNnZHkwYVNBL2xr?=
 =?utf-8?B?VHlNYXJSR0pzOXN5MFpXVXMwVzU4Rk1aZTFnYktRUkFwc0NBL1hZeVJQN3c5?=
 =?utf-8?B?WjQ0RTh6WWhYQ2dmWE9sNzNjcTdDdytPKy8rbjlwNFZuQTEzSHR5dytEVFZl?=
 =?utf-8?B?SWJOelNWSHM3c3dxVkxBeTkvU1k4ZzBBSnYyNk1MYi9XQWNrdi9jOWlXVEU2?=
 =?utf-8?B?b3dkblBIZkNNR043cEdKNkRDNjR3dEtoUG5BcHZTQk1GVFNVU2NNR1lTc3k5?=
 =?utf-8?B?MGVnUDVHTThqRENsM3ZlTW9aUktqaWJsdFFyZUc0dFRkbXdaTnIzYWJ6cFp3?=
 =?utf-8?B?QWhlMWFxQUNnZ296M2szd2xtYU01empYYUxqNUNYRTZPVC9GeG9MRXdUUVZk?=
 =?utf-8?B?U2M5a0lhU2xLK0dqQVJ1WFp5dnRONnhMWXZpeFFVaFVVL0ZESTdFeXdiMEp2?=
 =?utf-8?B?VSt3REkxR1o1YzRxK2xyTXA5cnY2VTFsVUN5YVdJRUJURzRuMXVTaGQ1U1o4?=
 =?utf-8?B?c3BjeWd1aTU2UGRCb2RHMks5VGdlR0lTVFc2UjEyLzhVeXJTbTcyNEV3bnYz?=
 =?utf-8?B?MW50VWloSGhCSnMwVHpxNk55T2dMbWZNOFlvNWVkSzlDMDBpak51ZlNMNUVD?=
 =?utf-8?B?WTd3THJnRHNZdkpXZjRTM1RtWThaSkFVaW1UbjR0dmFuek9KSlNYd3M2VW9W?=
 =?utf-8?B?V3p2Y2Zhb1BYWU9ORHJ1RG5FT3N6M3VmaDBJQ2xPZVQ5d1VjdGtuTlRXMVRo?=
 =?utf-8?B?OWhJRExRRU9QY0hpaUIyaGRmbmNKZ0hhRVdydWVMcllVUjdjbGdUdUpDSWls?=
 =?utf-8?B?N2N2THk4TXRSRXNzSGwyakNrZ0tMUWU0eUhBTVZpc0dpZjRkY0pFRjJMdzlx?=
 =?utf-8?B?dGpNUWRyQXI4WHUyOWVUVnVYS25zNENQS3NDV3BPdzIzTWZHU3FpU3ZCb0tB?=
 =?utf-8?B?dXJzV3RwczBtZDY3aW0rcTF2Y1VnZFBmU0hUWkdwQ3JIS2dpQ3NCUFVtMkd4?=
 =?utf-8?B?ZTVDcTRlTTBveUx6clhTV0M0TDNWNlkyWGpFbkNMZWx1U25EYzhRTnI1Q1BI?=
 =?utf-8?B?SmxrLzdEZGlQV3dpSXNvbldzQUF4anB1NkcwVlcxSUFBeDFacmpYR25mRGtV?=
 =?utf-8?B?NXJ0UTc0dlBFV2Rzamo0YzZUUTZIUDBLZEJrU3FaREYzVnoxaVdBZGMwNUhu?=
 =?utf-8?B?VkkyVHk1UzZtSWZCQ25ySDVWaE9lRVNpTHNCOHJuSTMvUWEwQWdkWGdmNjN4?=
 =?utf-8?B?LzVTWXUxSzRrc1hTSTlYTHNHRHc1cDl3cXVVVVAzNlYvSE8rN25PTHdsMlZu?=
 =?utf-8?B?UlVKRXRjc1I5Um8xeG9wRHlndnBub1hFL0ZqNjVudnhyWkpQN2phN0xmd1l2?=
 =?utf-8?B?UVZnUVZBaUxjM3NDaXZIZ0VNcWE1czZmT3lQLzlYS280d29sd2kzQnhmdFd3?=
 =?utf-8?B?eE9wTE8zR0REKzlXb3Jpb09RZ3c3Yy9rS01LV3Z5OEE4Y2pXZUdmcWdidWgr?=
 =?utf-8?B?amNuMm05VUJ0SSs2KzAvOFhqMC9kUnVWdWJSbVl3MVJValJVYVArM2ZpQlAz?=
 =?utf-8?B?N2p1NnVxWDVmc0QrVXY1OCtvL2pNUnNiV0R1VlQxZmxFVWVORTNwZzcyME9l?=
 =?utf-8?B?cVlGSVM1UTRHNCtqQi9FL1hBMG8xTkk2RitBVW9leFp4S1RBQXR4VFBHM2Z1?=
 =?utf-8?B?NS9uS29hQittbEE3NkZ4Njc0ZGVmK3FaR0tJT05DUTdaL2RYVDFVTHRIUmd1?=
 =?utf-8?B?Ykk3L3hkclFiTUlaOWZ1OVJ1K1pKZ0VEK0ZVd203ajdCL0JmelkzcHdRbnJp?=
 =?utf-8?B?YUNzWjBLSmc5b3dXS0YrQitEMVBjOTFkc0FHMkRvaDhzeDhSSGhZR3dXL2hh?=
 =?utf-8?B?Z0UyS1FjUWxJZzZrWjJQTDFtVXdTMXVhRm1jUDRlZEdKZ0dSSGNtYlN3Nmpj?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60ADB0783C39DB40BF5FFE777CB346AD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bVUzd3RmaWtyM3Y1YUZrSGwxbzlSUGNsQlhVOER5cngvTkd1V1E0YzdOMzVH?=
 =?utf-8?B?a1o3UFVYNE1UTUpUR0FLMy9hdHpsUHpyOGRsWTl6MkRBeXZOOU1tUTVnSWdW?=
 =?utf-8?B?NjZPT0tNTXZDajg4UEhIVWtKL0IyMFg2QlJEWm5FK0d4ODYyaG1EYU9pQXdO?=
 =?utf-8?B?Z29XR20xbDlFSmp3bXowQnhtYmxPL21EQjUvRU04WnZzUmtmT2oxYXc4dG1J?=
 =?utf-8?B?b0F4T1NtSS9scXlXc3d2WlZ3Tk9tRjkvVThjK0Q5aDdnK0I2d3paSisxR1JJ?=
 =?utf-8?B?TnJRZW5KeWZCaDV1Rk9kZC84MzE3QnhkMjRMQ1hSb2dIbjNwczF2ZmFkQ3dV?=
 =?utf-8?B?bGxyTmJSYWhCWTZLcEZJcVVvYVlkMmdpbDBDUmlNNWl0ajM3bEl4UXJiVWli?=
 =?utf-8?B?OSt5eE1Tam9jbVEzK2hiYXhVZU55dXc1RzVGMUNxSzhJR1hHK28yQzVub0Rq?=
 =?utf-8?B?VHRjU3NraTBGanlRWTJuTVVibHpBYmtpWmV4YUd5SUdZK1pPREo2Y1VJT05X?=
 =?utf-8?B?UFVNYVhpeVFoKyt5UHhtWHFzUXl3R1gySGdpZ250L2xMMCtuYmd3anh6L3NU?=
 =?utf-8?B?UERJWnlmSVY3L2xTeDZDalN3QjV1RHgxZnlTdXgxazZIQ0p5TitadldYVFpP?=
 =?utf-8?B?b1hVTDhqVERJREh5OXFCVTF0U0JHM2VaREV1UkdCOFVuWmdQdEM4UmY5U0Ro?=
 =?utf-8?B?Y2RsN3lFVDRMTTBWc3FGZWZKNnI5ZldwK2VsaHJzS2gxMTNFM1BPSlVDdEhh?=
 =?utf-8?B?UUxwQlNlVWlVdVp0VnlQUHJmL3ZVUUd3M0ladWdpZHZraVYxNTRvVndrZ3Zz?=
 =?utf-8?B?Mnd6YjFmVzAxR0xUZXJiU1N5SEE5bEVNeWJnTDcvb091YSt0M1FZYlZDVExZ?=
 =?utf-8?B?K3hXV010V3VMMXdLT3h5NHdWbFRCV0U4c3JRR1ZadHhCcVhndXRVZDV0b2Qz?=
 =?utf-8?B?TGVaQjB2dHI3bHBzRGdsUDdzYlVvWDd4UE42TjMyakVXcGNhZnl5UVhmQ2Qz?=
 =?utf-8?B?Zm9GMGFrOU1Cak5pWmtvaDYrcHVhQ3RJWCt5VmpodmdjRW1oTjlCNlVSYklv?=
 =?utf-8?B?NG5ONTRoSE10a3ZuZmpCZHJHdUwrUk1DQzM5aEgzSlNyd0g1WHZLTVZkTXlW?=
 =?utf-8?B?SEFvL1BvVWgzK0FNVWYzS1BXUDBZMURkczN6MTAxd2hwenQycjNweXo4TnJl?=
 =?utf-8?B?VElmQk15bzNlUE1MZWQ2NW9jV215Nmp3UEZ2cmN0RW1CTmlpZndPZEV1ZDY2?=
 =?utf-8?B?eUNueFR4OGtLMXBtQ3hBYVlNbEpkWDZXejRZZ2c4bVpoMnYvUUJsdjFxbitw?=
 =?utf-8?Q?1+zqp6rt4qUanhd+Az/Et7W7isKwx4csM9?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fb7406-5ebe-4e17-9a39-08dba3fce86a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 17:18:02.9066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 12QILzTA8ptfWv8xIOJonbCbaqwqepjFY7c4U9/ag6OXMxZPrkARIGUOQXmU2vpod5lKb957+xT2Ddy6UyZvKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818
X-Proofpoint-ORIG-GUID: fK0yBStHzYczYiWD1Cv3NWGeJqihOz6e
X-Proofpoint-GUID: fK0yBStHzYczYiWD1Cv3NWGeJqihOz6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_12,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBdWcgMjMsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIFdlZCwgQXVnIDIz
LCAyMDIzIGF0IDA0OjMwOjIzQU0gKzAyMDAsIEFuZHJleSBLb25vdmFsb3Ygd3JvdGU6DQo+ID4g
SSBzdGFydGVkIGxvb2tpbmcgaW50byByZXdvcmtpbmcgdGhlIFVEQyBkcml2ZXJzIHRvIGRyb3Ag
dGhlIHNwZWNpYWwNCj4gPiBjYXNlIGZvciBVU0JfR0FER0VUX0RFTEFZRURfU1RBVFVTLCBidXQg
dGhpcyBzZWVtcyBtb3JlIGNvbXBsaWNhdGVkLg0KPiA+IA0KPiA+IEZpcnN0LCBJIG5vdGljZWQg
dGhhdCBzb21lIG9mIHRoZSBVREMgZHJpdmVycyBvbmx5IGV4cGVjdCB0byBoYW5kbGUgYQ0KPiA+
IGRlbGF5ZWQgU3RhdHVzIHN0YWdlIGZvciBTRVRfQ09ORklHVVJBVElPTiByZXF1ZXN0cy4gKFdo
aWNoIGlzDQoNCkp1c3Qgd2FudCB0byBjbGFyaWZ5IHRoYXQgZHdjMyB3b3VsZCBleHBlY3QgYSBk
ZWxheWVkIHN0YXR1cyBmb3IgYW55DQpyZXF1ZXN0IHJldHVybmVkIHdpdGggVVNCX0dBREdFVF9E
RUxBWUVEX1NUQVRVUy4gVGhlIGlzc3VlIGlzIHRoYXQgZHdjMw0KYXNzdW1lcyB0aGUgX2ZpcnN0
XyBkZWxheWVkIHJlcXVlc3Qgd291bGQgYmUgU0VUX0NPTkZJR1VSQVRJT04uIEFueQ0Kc3Vic2Vx
dWVuY2UgY29udHJvbCByZXF1ZXN0IHdpdGggZGVsYXllZCByZXF1ZXN0LCBpdCBhc3N1bWVzIHRo
ZSBkZXZpY2UNCmlzIGFscmVhZHkgaW4gY29uZmlndXJlZCBzdGF0ZS4NCg0KPiANCj4gVGhhdCBl
eHBlY3RhdGlvbiBpcyB3cm9uZzsgZ2FkZ2V0IGRyaXZlcnMgY2FuIGFsc28gd2FudCB0byBkZWxh
eSB0aGUgDQo+IFN0YXR1cyBzdGFnZSBmb3IgYSBTRVRfSU5URVJGQUNFIHJlcXVlc3QuICBBbmQg
aW4gdGhlb3J5IHRoZXkgbWlnaHQgd2FudCANCj4gdG8gZGVsYXkgYW55IGNvbnRyb2wtT1VUIHRy
YW5zZmVyLg0KDQpBZ3JlZS4gVGhhbmtzIEFuZHJleSBhbmQgQWxhbiBmb3IgbG9va2luZyBpbnRv
IGR3YzMuDQoNClJlZ2FyZGluZyBTRVRfSU5URVJGQUNFLCBpdCBzaG91bGQgYmUgZmluZSBiZWNh
dXNlIGl0IHNob3VsZCBiZSBkb25lDQp3aGlsZSBpdCdzIGFscmVhZHkgaW4gY29uZmlndXJlZCBz
dGF0ZSwgd2hpY2ggaXMgYWZ0ZXINClNFVF9DT05GSUdVUkFUSU9OLiBCdXQgaXQncyB0cnVlIHRo
YXQgZHdjMyBuZWVkcyB0byBmaXggdGhpcyBhc3N1bXB0aW9uDQpoZXJlLg0KDQo+IA0KPiA+IHJl
YXNvbmFibGUsIGFzIHRoZXkgd2VyZSBkZXZlbG9wZWQgYXNzdW1pbmcgdGhhdCBvbmx5IHRoZSBj
b21wb3NpdGUNCj4gPiBmcmFtZXdvcmsgbWlnaHQgcmVxdWVzdCB0byBkZWxheSB0aGUgU3RhdHVz
IHN0YWdlLikgSW4gcGFydGljdWxhciwNCj4gPiBkd2MzLCBjZG5zMiwgYW5kIGNkbnMzIHNldCB0
aGUgZ2FkZ2V0IHN0YXRlIHRvIFVTQl9TVEFURV9DT05GSUdVUkVEDQo+ID4gd2hlbiBoYW5kbGlu
ZyBhIGRlbGF5ZWQgU3RhdHVzIHN0YWdlOg0KPiA+IA0KPiA+IGR3YzMvZXAwLmM6MTM2OiB1c2Jf
Z2FkZ2V0X3NldF9zdGF0ZShkd2MtPmdhZGdldCwgVVNCX1NUQVRFX0NPTkZJR1VSRUQpOw0KPiA+
IGNkbnMzL2NkbnMzLWVwMC5jOjczOTogdXNiX2dhZGdldF9zZXRfc3RhdGUoJnByaXZfZGV2LT5n
YWRnZXQsDQo+ID4gVVNCX1NUQVRFX0NPTkZJR1VSRUQpOw0KPiA+IGdhZGdldC91ZGMvY2RuczIv
Y2RuczItZXAwLmM6NTcyOiB1c2JfZ2FkZ2V0X3NldF9zdGF0ZSgmcGRldi0+Z2FkZ2V0LA0KPiA+
IFVTQl9TVEFURV9DT05GSUdVUkVEKTsNCj4gDQo+IFRoaXMgaXMgYWxzbyB3cm9uZy4gIFNFVF9D
T05GSUdVUkFUSU9OIGNhbiB0ZWxsIGEgZ2FkZ2V0IHRvIGluc3RhbGwgDQo+IGNvbmZpZyAwLCBp
biB3aGljaCBjYXNlIHRoZSBzdGF0ZSBzaG91bGQgYmUgY2hhbmdlZCB0byANCj4gVVNCX1NUQVRF
X0FERFJFU1MuDQoNCkFkZGVkIG9uIG15IFRPRE8gbGlzdC4NCg0KPiANCj4gRm9yIHRoYXQgbWF0
dGVyLCBhIGdhZGdldCBjYW4gdW5kZXJnbyBtYW55IHN0YXRlIGNoYW5nZXMgb3RoZXIgdGhhbiB0
aGUgDQo+IGNoYW5nZSBpbnRvIHRoZSBDT05GSUdVUkVEIHN0YXRlLiAgSXQgZG9lc24ndCBsb29r
IGxpa2UgbWFueSBvZiB0aGUgVURDIA0KPiBkcml2ZXJzIGFyZSBjYXJlZnVsIGFib3V0IHJlcG9y
dGluZyB0aGVtLg0KPiANCj4gPiBTbyBJIGJlbGlldmUgYW4gYWRkaXRpb25hbCBjaGVjayBmb3Ig
d2hldGhlciB0aGUgcmVxdWVzdCB3YXMgaW5kZWVkDQo+ID4gU0VUX0NPTkZJR1VSQVRJT04gaXMg
cmVxdWlyZWQuIChjZG5zMiBhbmQgY2RuczMgYWxzbyBkbyBvdGhlciB0aGluZ3MNCj4gPiBiZXNp
ZGVzIHNldHRpbmcgdGhlIHN0YXRlIHRvIFVTQl9TVEFURV9DT05GSUdVUkVELCBidXQgaXQgc2hv
dWxkIGJlDQo+ID4gcG9zc2libGUgdG8gaGlkZSB0aGF0IHVuZGVyIHRoZSBzYW1lIGNoZWNrLikN
Cj4gPiANCj4gPiBJIGFsc28gbG9va2VkIGludG8gaG93IG90aGVyIFVEQyBkcml2ZXJzIGNoYW5n
ZSB0aGUgZ2FkZ2V0IHN0YXRlIHRvDQo+ID4gVVNCX1NUQVRFX0NPTkZJR1VSRUQ6DQo+ID4gDQo+
ID4gMS4gaXNwMTc2MCwgbXR1MywgYW5kIGJkYyBpbW1lZGlhdGVseSBzZXQgVVNCX1NUQVRFX0NP
TkZJR1VSRUQgb25jZQ0KPiA+IHRoZXkgcmVjZWl2ZSBhIFNFVF9DT05GSUdVUkFUSU9OIHJlcXVl
c3QsIGJlZm9yZSBjYWxsaW5nIC0+c2V0dXAoKSBmb3INCj4gPiB0aGUgZ2FkZ2V0IGRyaXZlcjsN
Cj4gPiAyLiBnciBhbmQgbXZfdTNkIGRvIHRoYXQgYWZ0ZXIgdGhlIC0+c2V0dXAoKSBjYWxsOw0K
PiA+IDMuIHRlZ3JhIGRvZXMgaXQgYWZ0ZXIgdGhlIGZpcnN0IG5vbi1jb250cm9sIGVuZHBvaW50
IGlzIGVuYWJsZWQ7DQo+ID4gNC4gZHdjMywgY2RuczIsIGFuZCBjZG5zMyBhcHBlYXIgdG8gbm90
IHNldCBVU0JfU1RBVEVfQ09ORklHVVJFRCBpZg0KPiA+IHRoZSBTdGF0dXMgc3RhZ2UgaXMgbm90
IGRlbGF5ZWQ7DQo+ID4gNS4gZHdjMiwgY2Ruc3AsIGFuZCBhbGwgb3RoZXIgVURDcyBkb24ndCBz
ZXQgVVNCX1NUQVRFX0NPTkZJR1VSRUQgYXQgYWxsLg0KPiA+IA0KPiA+IEknbSBndWVzc2luZyB0
aGUgVURDcyBpbiAjNCBhbmQgIzUgZXhwZWN0IHRoZSBnYWRnZXQgZHJpdmVyIHRvIHNldA0KPiA+
IFVTQl9TVEFURV9DT05GSUdVUkVELg0KPiA+IA0KPiA+IEkgc2VlIHRoYXQgdGhlIGNvbXBvc2l0
ZSBmcmFtZXdvcmsgc2V0cyB0aGUgZ2FkZ2V0IHN0YXRlIHRvDQo+ID4gVVNCX1NUQVRFX0NPTkZJ
R1VSRUQgZXZlbiBpZiBzb21lIG9mIHRoZSBmdW5jdGlvbnMgcmVxdWVzdCBhIGRlbGF5ZWQNCj4g
PiBTdGF0dXMgc3RhZ2UgdmlhIFVTQl9HQURHRVRfREVMQVlFRF9TVEFUVVMuIEFuZCBHYWRnZXRG
UyBhbHNvIHNldHMgdGhlDQo+ID4gc3RhdGUgdG8gVVNCX1NUQVRFX0NPTkZJR1VSRUQgYmVmb3Jl
IGRlbGVnYXRpbmcgdGhlIFNFVF9DT05GSUdVUkFUSU9ODQo+ID4gcmVxdWVzdCB0byB1c2Vyc3Bh
Y2UuIEhvd2V2ZXIsIFJhdyBHYWRnZXQgZXhwZWN0cyB0aGUgdXNlcnNwYWNlIHRvDQo+ID4gaXNz
dWUgYW4gaW9jdGwgdGhhdCBzZXRzIFVTQl9TVEFURV9DT05GSUdVUkVEIGJlZm9yZSBjb21wbGV0
aW5nIHRoZQ0KPiA+IGRlbGF5ZWQgU0VUX0NPTkZJR1VSQVRJT04gcmVxdWVzdC4NCj4gPiANCj4g
PiBTbyBJIGFtIHdvbmRlcmluZzogd2hlbiBpcyBwcm9wZXIgdGltZSB0byBzZXQgVVNCX1NUQVRF
X0NPTkZJR1VSRUQ/DQo+ID4gQW5kIHNob3VsZCB0aGlzIGJlIGhhbmRsZWQgYnkgdGhlIFVEQyBk
cml2ZXIgb3IgdGhlIGdhZGdldCBkcml2ZXI/DQo+IA0KPiBUaGUgcHJvcGVyIHRpbWUgaXNuJ3Qg
cmVhbGx5IHdlbGwgZGVmaW5lZC4gIEFzIGZhciBhcyB0aGUgZ2FkZ2V0IGRyaXZlciANCj4gaXMg
Y29uY2VybmVkLCBpdCdzIHdoZW4gdGhlIGNvbmZpZ3VyYXRpb24gY2hhbmdlIGlzIGNvbXBsZXRl
ZCAod2hlbiBpdCANCj4gdGVsbHMgdGhlIGNvbXBvc2l0ZSBmcmFtZXdvcmsgdG8gc3RvcCBkZWxh
eWluZyB0aGUgc3RhdHVzIHN0YWdlKS4gIEJ1dCANCj4gYXMgZmFyIGFzIHRoZSBob3N0IGlzIGNv
bmNlcm5lZCwgaXQncyB3aGVuIHRoZSBTdGF0dXMgc3RhZ2UgY29tcGxldGVzIA0KPiBzdWNjZXNz
ZnVsbHkuDQo+IA0KPiBJZiB0aGUgU3RhdHVzIHN0YWdlIG9mIHRoZSBjb250cm9sIHRyYW5zZmVy
IGdldHMgY29ycnVwdGVkLCBpdCdzIA0KPiBwb3NzaWJsZSB0byBlbmQgdXAgaW4gYSBzaXR1YXRp
b24gd2hlcmUgdGhlIGdhZGdldCBiZWxpZXZlcyBpdCBpcyANCj4gY29uZmlndXJlZCBhbmQgdGhl
IGhvc3QgYmVsaWV2ZXMgaXQgaXNuJ3QuICBMdWNraWx5IHRoaXMgZG9lc24ndCANCj4gaGFwcGVu
IHZlcnkgb2Z0ZW4sIGFuZCBpZiBpdCBkb2VzIHRoZW4gdGhlIGhvc3Qgc2hvdWxkIHJlaXNzdWUg
dGhlIA0KPiB0cmFuc2Zlci4NCj4gDQo+IEFsbCB0aGUgb3RoZXIgc3RhdGUgY2hhbmdlcyBhcmUg
KG9yIHNob3VsZCBiZSkgaGFuZGxlZCBieSB0aGUgVURDIA0KPiBkcml2ZXJzLiAgSSBndWVzcyB0
aGV5IGNhbiBoYW5kbGUgdGhlIGNoYW5nZXMgdG8vZnJvbSB0aGUgQ09ORklHVVJFRCANCj4gc3Rh
dGUgYXMgd2VsbCwgYWx0aG91Z2ggdGhleSB3aWxsIGhhdmUgdG8gYmUgbW9yZSBjYXJlZnVsIGFi
b3V0IGl0IHRoYW4gDQo+IHRoZXkgYXJlIG5vdy4NCj4gDQoNClRoZSBkd2MzIHRyaWVzIHRvIGhh
bmRsZSB0aGVzZSBzdGF0ZSBjaGFuZ2VzLiBIb3dldmVyLCBhcyBwb2ludGVkIG91dCwNCml0IG5l
ZWRzIHRvIGJlIGF1ZGl0ZWQuIFdlIGdvdCBhIGxpdHRsZSBvdmVyIHJlbGlhbnQgb24gVVNCIENW
IHRlc3RzIHRvDQphdWRpdCB0aGVzZSBzdGF0ZSBjaGFuZ2VzIGZvciB1cy4NCg0KVGhhbmtzLA0K
VGhpbmg=
