Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5394B805BE4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442493AbjLEPuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346860AbjLEPuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:50:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B63C3;
        Tue,  5 Dec 2023 07:50:18 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5Etm8X019678;
        Tue, 5 Dec 2023 15:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ybfhQX5ecit5lCSdpJs/qMVMu11yYYrEVQTRFzUMe2s=;
 b=am3j9LeB2kCbiCZXBRP3M82xzquhErDirSYrh3xJ93WecKvQRpDxKnxamVacNv/PeByB
 NWSNGNx6k1a3LhylehbgdkubsMVx2cCcpO+0zWYy0hwRdqTNPQvjKWPe2ioGZZVed0GZ
 3aynisFlWq+qc+KxjUKwIgm6rOOknpBWJ4HDlsGQA7derWNoz26ObNlOb9OU+wgOukmC
 zRxCaYaiuwTy8/K5RilwRFHi6SK8vCQMl9RA/7PkpMtpfrNxzf5LxRJ+/EYy61/hbJ9o
 8OZcxViea+cuqGjKk9j/iQpGaLe+LuG2Kvxv01Zadh1ZTF1vkzUeyY0coeaob+QGU6A5 mQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ut076s1nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 15:49:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5Eidws018454;
        Tue, 5 Dec 2023 15:49:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu17mxw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 15:49:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eP1n7EOEKrXReZoGOEiT7s05oLUjVTBLmpfE/0h2T0TeaUjnjmjUWyDhk7WnH4ODkDTPFHGmzuFRS3akEQPGS+hwiu+P9TpG5owbdY5ikOeYkmTMKCTbA85EqmiImjVYCEQZPlCeQjz5kpKTnubOYOujmiTepm1RBa0jqbFOUi6M7RsY74NCMRSE71XNPZ+vWsBd9W5Zbhj8UI0byAT3YescYveKnv+pQLwMMgtEWu2G2UN7vbb5odOZ453u0jZSgZV8JSL+SVnYjPKchq6MXcdhauNTysx1WkV3v7Z6xJAVgh9SvrQ6bew+/WyQ5tCjrCmn1kKEK2GxUarSwftLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybfhQX5ecit5lCSdpJs/qMVMu11yYYrEVQTRFzUMe2s=;
 b=PfY/gLWNk4GyiAnGSsKSAQIAt+rXzbDbOkLuNOtPFOi5KwOkdI5GrOvWTeA14Z22K5hRM7trVrW85bVVG5RpxhrW+iFni+MbIoz0KQe1OoDCMiGskl4n3JT18A1Z9xv6UKCOn9Ei0AY8fhKhFhTEyiAoSM0NlID4oDlNE/SFBs1Zunt4l86I8gTuHkSrcCNBv5DDyKfkzrAFFuk8LyvVlkwgZqxON7Ot20i9Yj9AkXyt5KT5/h/+o2fVlDDSYext22S67PWosg4wQ8y4insjBF/ulgp0Fbc5xs0Q2ORjJjuT7wsWWvYvLzRHcLfNdakd3/osaqCa84mqVc9kYQIByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybfhQX5ecit5lCSdpJs/qMVMu11yYYrEVQTRFzUMe2s=;
 b=L9xlwAAzcn6nDY6Y0Fb3TSUEMHRyWHPuuuiJI8AQy/GOdWQaMJqUsM34KsybO7gdY480Z1orp1OIKawQf5aIdqBeCpXheW+wEjbr4VwogaA9kjSh3DuWMsjgZFd8XV/HcKD/J1gE8raoQ+zQUmvouCWyd8qFZ0W6o9k82tqjj2A=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS7PR10MB7322.namprd10.prod.outlook.com (2603:10b6:8:e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 15:49:33 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 15:49:33 +0000
Message-ID: <708927bc-4790-4182-9b84-9945ee6dfc17@oracle.com>
Date:   Tue, 5 Dec 2023 21:19:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231205031535.163661217@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:404:42::23) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS7PR10MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 8071c86c-f81e-4a4e-3aad-08dbf5a9c636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hs30P79sqtFE9E54wGv1DwUWTD3aCiatmmSPMt8NugP2R2Nb7eUDT3OdOMtbbi7QPVPYlUBpWhFW2xDYx8DrJIFysmXL9PjOUclFUxuj87hfecWCnEdbRs1i6GtYhIF7jKqmxZOoe8/SDmvy7VXloB6O6RjWUjVY7RdwwnNxxoMKiG0gnb7chikijU+MKYBwDkFIq4kZznSs1tbRdPQpwu9VIMP8a9JjC696QX5sO+E9AWkNpqEOrcnLPJjJEM6jGSmS4onCMQAWkimqUs3aiPJLYWHV0kuVG5JQmjo7caNhbJIzF8/jpUK3DMOTdQqmKM7Xjzphz3iY1TOMSvwWb7Vl5nvmAxydTokS8z7VuqL3LFNGWaTuWuXsEXeTqk/LD8pSasRButURreDI+Y9JFX1OzNoIpzJyosqvUheUY8CjqINCsX0CZiQjVD7elZfDe5pvTGH8k1Tz9vqjCUFiRl9zWmx9bhjxEWKEqKBQMccV8rS217CwMgId4JLZ/p8o4QeEULBdpy8Beu/1xmjdfFiPHY7w7TuI7IhWp/Jd4AYNxACfmrne/UfJIPaMEEtOs07x/Ps2QrIorKAik5FFdVHg91RHFDd2ldT/WR54kWVWKwiDJGpxGdLUGOiU0QmUgEZguM4HrJmEmGBOFd+wPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(66946007)(54906003)(66556008)(86362001)(31696002)(8936002)(8676002)(4326008)(66476007)(6486002)(966005)(478600001)(36756003)(41300700001)(7416002)(4744005)(5660300002)(2906002)(38100700002)(2616005)(6506007)(26005)(107886003)(6666004)(6512007)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzUvamdHQWJqbDNtZTU1eUVwNitTc0NDbXlTclJncGFRVzVGdU1lNEdKYjBF?=
 =?utf-8?B?VG9oL3Q4NFc4WlBXT1BHME5OV2lWeGJxTE1Bd3RMS09pNjZxS1JzU0VvWnZF?=
 =?utf-8?B?SXY0TmxLYXZPelBTL2dFM2M3MmU1S0xwZ1BUd1RXZWg2amh0L0FRUmZaTHBK?=
 =?utf-8?B?eUdLUkk0ZFFHME15bWlTL25ZcElPSWkzNFRPQVBMbTlXT3BuOVJLY3QvajNr?=
 =?utf-8?B?VTlkZC9NWndsZ3dFUnp3Q3V1RWVtaTZnbmpHSjRMRmYxRU5LSEc2MGl1T2Zu?=
 =?utf-8?B?K25mMCtnZmFvY3ByejFjclhrZTI2M0svYjdQelN2WklGK0NoVzBVYjN5ancw?=
 =?utf-8?B?aC8rSzBaeFRnQVM4dGN4UTdSMTdOQ3FUSk5rSFhJWXpKRmVkNDE0L3J6L3ZY?=
 =?utf-8?B?N3hrYXZzNnJUbW5sNlh1YzljR1dMLzJmajFvOUhTY1RFWEI5WmNCRitCZ1Rk?=
 =?utf-8?B?M3VTNjZ1TWUvYjB0Ty9qTzNxNUFhSHNCYU8zSEpDNHhTNjhSNUxqZUtJRHVO?=
 =?utf-8?B?U2thTDBMazdiM2ZkVFFCL3JRU1Boczhndng1d0dYQ2FNc2d6dU5nck43S2FE?=
 =?utf-8?B?QzlxYjFQUERpVEl6NkJYeHVOU0lERWRNUWRCRGRTTzBLKzlVbUZUdDl3QXE3?=
 =?utf-8?B?YysvenNUeHByZWpOSDRpWjN6OS9uNTFmazdxV3NoMzJoZTdUeVlSZ3hVTW1w?=
 =?utf-8?B?TlM3NGlRYVRYZjFmRmRLS0I0ZC83Rldiek1JNWFYUDBaNEJzU3lPWjMvWWxs?=
 =?utf-8?B?d1dRZHpXc2thUUMvTDJrTFZkdzVmUGZCU1BPYTZlczg1UUtYblo3SDNyY0JP?=
 =?utf-8?B?UDBNUVlGYjNiUGR0Zyt4OWFMOEpDYlppWkFqNFJ2MXBoNXpvVnR6SEtXc2gv?=
 =?utf-8?B?Wi9MREVKRkhDZXVEKzduY1lKclJOMnY0dDlmQUlsNnl5eHRxUW5kNDFTdWox?=
 =?utf-8?B?aythdldENFNISVRXZ0xmaHBOYUVPMGxpMS9SR1VzL3YvRjI2eHdhVWN3NFZK?=
 =?utf-8?B?em83S1Z3Q1lUaDNMOTUySWx0VWY0SWpNOHFUNE9zNFN0bkdYRFZ2Y2dZV0VC?=
 =?utf-8?B?Tk5DMVorLzNRenk4RDcwekoxVkc2b09ybWlOM0RrSHoxdE1KcWRkdHVzdmwx?=
 =?utf-8?B?SG53MjBYaHltL295MEpGYmZ2dFpCc1N3dHBsMjBXb1J2U04yVXFCVU9TcWxs?=
 =?utf-8?B?bVZGY3NMSGtNQmx2bDZRbVUzUk1lVHQrWkw2eUhuYWlSYjBBSWl4ZmZKTllZ?=
 =?utf-8?B?MDZPK2Rzb2hsZXdrUFVGR0pkb3lBZlFLcWFHblFQMkx5cDhLclo5b2JUTWxQ?=
 =?utf-8?B?Vm85QWwyU1VBbHNBYVJ2WkFEMkk2U3ZyZ2NFcmhUNXlVTFZHY0FjbFNPK2lD?=
 =?utf-8?B?UFNUQmZUUVl4TEdpRHY2NTY4enZXMnA3TGhTbkwrVXltWUlXUlBIQ29OalpZ?=
 =?utf-8?B?Q2doTmt0VUQzcmlxdkpqNmVHbVhKRExwa3dXWlBjcmoxS1NRV3crazNiS1dI?=
 =?utf-8?B?Mm44bDY5OWZoaGxHYmZUZHRRRmdUamljSEVVRm1wT2lEWWZBTHg2ZWJaSGlk?=
 =?utf-8?B?ZHE4b0phYy9nNzZ2aEVKdm9KRUI3eGpVRTg2cnp3bS9YS2gzeFJHUlJDVjlL?=
 =?utf-8?B?eWpkTFh5V2JPTWN1VkJCYnVpMnpjNE5qQjRPem9ydzdjVHRjV0FWT2p4R1Yy?=
 =?utf-8?B?N2JwOGxBaTZiRE00UmVMVGlTZndZV2F0NjkrKzFsaWVoMVdRNXNTbHR6NnFU?=
 =?utf-8?B?bEg0aDJmRXozSUVmSE5EVDQwc0ZLWHRTZ2ZmM1JBNW9xWWFlcE9FL2Z5dVpL?=
 =?utf-8?B?QXBVa0M3RVV4a0RNWlp5bnZnc3Z2TlFwZURheVRaT1NLbkIzUm02VnBmdENm?=
 =?utf-8?B?NHJnRjBpYTFRV3NURmhvOWk3VDV0bTlwSHVLR0p6akFNV1RLUU1NWVhxNUx0?=
 =?utf-8?B?c2tTTGQ1ZW1hejYrcmw1YTRLaU4ra25YS3JIaG5LSVpWZy9keGlwWUhleTdQ?=
 =?utf-8?B?YXZXRzRjNitKd3dYVFJjaUtabU1WbjdoanYxeFRoVmlzSWZXUzVRY3dmc0FI?=
 =?utf-8?B?c05PTk5WNHVvSzNhMHkvcjNRWWttQ0IrKzNJeFV2blM5bTZkWXkvblNDS2JI?=
 =?utf-8?B?VHlQZFAxcm9oSWthVXp3bU1DcU5zWmE2emkrR0hMMEJPUHlyenFKZnlpbTcz?=
 =?utf-8?Q?Ue9rnMn3vCQ2/il/Gqkm3Fk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VTVmSUNhVmJTck5FbGlXZ0drSm9sRklyQmV2Z3ZPVE45RmpFNzZMRVBCVGZn?=
 =?utf-8?B?VS94MDlDb1JkZG5DRzRYSExoQk1iWElPa0FoSkE1T3hwU09hL2VvMGlyZnps?=
 =?utf-8?B?M3V6akRPSG5MWS91OXVyWkx6N0hpNWJ2aDdQVm83Sk8rVklINlZqRjBFbG56?=
 =?utf-8?B?elNFVVR2cUFvQ0tlSG1PZkNOK0JPQ1lGYU5hU1I2TG9PZnJodjZZdnlLdm4v?=
 =?utf-8?B?Ty9Eb3djWldRY0JKZHlwNnZiWVE4UUZ1MFZuZzY1NkNza2FMaE5BcGhldWxE?=
 =?utf-8?B?bUdnbXhsZGJ0ZDJOM2d4N0tmOWUxRUtFQVRpblpnVUxrYjdIdzd4RG9pNWpJ?=
 =?utf-8?B?cUlLWW4yRHZIQjF2blM3TklyQmhBS0h4SWRXRlZNbmhZSzFnanlCZjRKRDgz?=
 =?utf-8?B?RmNVRy8rOXQ1WEUrK2wrVkxoeG8vRnpZcWVMMkhXNGxNT2pwbG1CNERDU2lN?=
 =?utf-8?B?d3d1R2owMFhQVkQzMnB0N2xOMUJGYTN6V0w3ei82dUx1MHJjZDBtR01SNFBO?=
 =?utf-8?B?SVI2Wk1aSDZ5WkNLQXBuQ1B0U21QZmUva1B5bGlDR2VKQ2svQzRheGV6d1hX?=
 =?utf-8?B?V2Z4R1NWTnBQT3U4T0lsKzg4d2kvZHdMLzgrRUdRWis1OC9TNi95MTdRRFN3?=
 =?utf-8?B?aFVDNys2bmhsdmhicVdvTGFxRE9acG51d2gvZTQ3czAvZjhVQlE4V1RKOFpD?=
 =?utf-8?B?VVQ4SlB1MTZXeFVVZzByckYyQXZYRzlpOHdkZERrWXhvTTZRRFg4ak9YQWlD?=
 =?utf-8?B?ME9qRUpsdEtjUHNzN2VYTWZoMnlidTJZWXd5N3JTc1FJeEZKMVJjbmVTekxn?=
 =?utf-8?B?WDZwWkRMTllxcjJmU0tiSm1VdnNlV3FLNkpBMkJjM2h4UDZNcVBiMGJ3Uysv?=
 =?utf-8?B?RUVYZlU4cFBERlEyREg2akVlaHRLUnN1N21WYjBiZGVnZUdkTWxGbXhXNEIz?=
 =?utf-8?B?dW5YejJNZ29mYjZuSGhLNXN6dlhPOTlzbGl2M21tbTdtZ2JBb1hWYXR6cTI5?=
 =?utf-8?B?dERBUWRrUTZKaHRVTlJURmpPbEpBL2xnbUg3ODI0Mk5hUlJzRmJwVW5QZFFS?=
 =?utf-8?B?YzE1d0VrYlgzSTZ5UlhGRUU1MFRUcE5xckZrYXZZbnhOd0YvdzcwN2IxRi9u?=
 =?utf-8?B?Vm5SSXhzZ1JHeGRSVmVtUkdreHFDMHVna1p5UWVVZ1ZwNFVlek5vM3lxVXJK?=
 =?utf-8?B?Z3gvVUgxMU9CSlR4Z1dMb0kydTl5bVpiM1JqdVJYK0QzRnNqV0dUVkVBaDZD?=
 =?utf-8?B?a0ZnQzhMV2IyNGtZNHVQQ1JPNk5GamoxUXpMZm5LYlZuOU5NL2JxUU45NkVM?=
 =?utf-8?B?QXJRMGIxM0htRXAxL0xjVUNETGVIVDdRM0Y1TmZBaFdRNzdEeUlZWVNWaWdY?=
 =?utf-8?B?QTNxaFEzK2U4OGxOR09Pd0RHRm81OUY5QkUvT1NReHZpWnIzWnc3eVZjempq?=
 =?utf-8?B?QUVRYzFaUVVhZkNmckZUTElTSk1hRUFpbHJHNnlwTVk4ZnJCWEdSb0pJWHdu?=
 =?utf-8?B?M3NnQURKWUV6YU9JU0pGbnA0Yk1mck03OWVPak9zNjhTZ0ZiVUF1TDNMeHh1?=
 =?utf-8?Q?y6PshdHXn2S3Ujms4IATpxHC5QeULDGpqjE62RdHDQvgfD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8071c86c-f81e-4a4e-3aad-08dbf5a9c636
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 15:49:33.0637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6Lk76PFK5mzctNVIDqgH4LZ9cdK1zrME6o7bqj3+NOxNVphFuil9MNzNIXDbxq48z/cGv6j+VfKhn0QFhwlfl7bwcDo87VuxBGneA9pw7b1QQwprFfOb1mOgshwNY4H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_11,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050124
X-Proofpoint-ORIG-GUID: WXxafry6IEjs1sAuWEbMdoGR8AiiE4yk
X-Proofpoint-GUID: WXxafry6IEjs1sAuWEbMdoGR8AiiE4yk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
On 05/12/23 8:44 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.5 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 

Built and boot tested on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
