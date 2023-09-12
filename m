Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E41179D53C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjILPpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjILPpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:45:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A4010DE;
        Tue, 12 Sep 2023 08:45:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C9nbLK006500;
        Tue, 12 Sep 2023 15:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=Tj/gFuuG4jaZj67ZiEqOoa2wPo0OafneQf6oUwowvZE=;
 b=Bt/ircFPA4LhZWZPbidk27C9GZv7M59axWpUUW6uvTJnPE4LNACx5HfnJwb58lz1uIf9
 tezvBXNQxABJLoZh5q+Qt1br7GkQsiigkqI+48+azzlwsYbxX0kgLYBmZ+ul1CVrtomE
 pZLTO5QZzR17mi1Ei2DiqfqaxnQ4MDqR53PSOFBXqj+gJlWQNdGOZUtwARYYxReMeaLA
 psHll3PXcMD17ty95T6Wy5MqUkwbgo4kO1KaMnYNZKC7vQSk1vOD+NCQ39IdNMqFMXeY
 ivwBLu8fztwdkPLih6Nb+JyEVXSJCUMSpd1FVmtPBlxNubtIaBWndqQe3ECS3ctlWOeU vQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jwqv9bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 15:44:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CEhwHt002750;
        Tue, 12 Sep 2023 15:44:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5c6s54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 15:44:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTGFu+1WUP8pw9SJT9JEzEbzY5FCRGj+gqewoDOnC9q3uv3uFtP7A8AjFte/JNFQ4xB051qO8aU+8G4zD3KeLl2cDTfGRn8+vVAHBjmJSUVpSwuurGZbjTcWQ1iRHkoFFYX/JvmghNqSFHR76xrZDxSXGNKA4ouGo6YN+U3XrWje69IKNNd2fed1HAvc1GvAu6rCuC9W/9YbCA8Mt+GwRr8zxgHTNjeusylKv74aVfYybGeGWWl88NGlRdbW7wlkxZjsO+Vzc2Kc/0zcYA5L7G6Ns7/y0gjrO6Dq/jpUVLRW7r7TBhR3Xb8C0haBhOa7UK9PupVjQ1fE7ooOC65mpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tj/gFuuG4jaZj67ZiEqOoa2wPo0OafneQf6oUwowvZE=;
 b=I4WGuRSXX9S/DW9lIN/IgM53dbTmTdwH0d9qnvpPaFyFJaM8kNDWbUMZ7AFdFlXwl9kN6jlvRs+DYYmNVp98YVo/PZeJHXeiEoXzRsGdjzU1fvhubbP7VVPeQQd+IVbYscbrZdvFM6kAchGJ7xVGilOE2pd/h6IwNUYNo93JHNVgY1YTvYBkknypUrl2tGCg5OJfgui2pKbG/RKiTFOaQW2LHHX7h9edv2NWPd8x9a7OazTgOtZY18thQXJ53JlYdyjUl2DfqmlzCaNOjqgNbJAsQwxeQaxgtJLWRxClAwe99fUy1wHKMFSJSQS/LBHsUokO4OE1nnI6dlvbrI7hiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj/gFuuG4jaZj67ZiEqOoa2wPo0OafneQf6oUwowvZE=;
 b=AMNrgtCOaRHmeaykMGRQGoutc2ri84eUMAHTmsMB+PgwUihqLs21rbN/ZrUD8LmYij79V379Xn84lGB2VFpmyeJ+rIfOqQnNbfSbiHfNLXX70w5Y4ci4hm9fSnlezGPXXgSga9hF5wKoIRQMK3gB0F0pm0B4zkml9BlqL6qL21U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6280.namprd10.prod.outlook.com (2603:10b6:8:bb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Tue, 12 Sep 2023 15:44:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 15:44:27 +0000
Date:   Tue, 12 Sep 2023 11:44:23 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Message-ID: <20230912154423.gcb5rzwzh4jbcaw7@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
References: <20230906172954.oq4vogeuco25zam7@revolver>
 <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver>
 <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
 <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com>
 <f9b0a88c-8a64-439f-a488-85d500c9f2aa@paulmck-laptop>
 <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
 <62936d98-6353-486e-8535-86c9f90bc7f4@paulmck-laptop>
 <20230912135617.dnhyk4h5c555l2yg@revolver>
 <9e85adf9-2e1f-4bed-a58e-9ca629c03579@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9e85adf9-2e1f-4bed-a58e-9ca629c03579@paulmck-laptop>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc38963-bcf8-479f-c58a-08dbb3a724f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5aBf3j4Qd8HRgs3qw0W7bKRxPLXb5t9lOFrCoHoUDpvF8nVFUv8Kf8UgJ5fTHm5NVq8nZbY75OLFA/U2cfb3f/KEdlS1NW2fpZR03KgUi+WjuXkiKIRoS8vgZFQq9TJTqdtKFadYbSsg9wdUm2cCQuQeDrk2XenMdsJBiB3KNdbbywyty3xC1p8h8Iyk9V2pUUZpKRhP4YVmnRzlGZk0F5AdmSydzfHnO4q8qY5AhFJ77CWjbPD9Fb2x5ZGxjewyGleCv4zreA1UX6b5LVe4PJu0ico05PRNGpyhz7n/tStGSFrzzN/HXMQrPhar+EC+AfVZdDXu3OWyqw4lz6eh4Fgyqggb9LliRxupurOd+LU4YI2/TfnQMh1WHxQta7471e0NZvBt6PXkT7Z0Fi1idUJJf4yb/rDIMFT0UFihpZ2wlbBXy6RvmMDrKWwQpJB3Ihqisw0GpRIKzJ0RsmU742gpcTsgUe82pD7VjduAwOwHDDz4n/v7PeW046GtH6PaU2l/5hzDXyIBKCsGzyumM8QXbNl/YX0QN2MEpq7WoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(396003)(366004)(136003)(1800799009)(186009)(451199024)(2906002)(6506007)(6666004)(53546011)(6486002)(966005)(6512007)(9686003)(478600001)(83380400001)(1076003)(26005)(66946007)(6916009)(54906003)(33716001)(66476007)(316002)(66556008)(41300700001)(4326008)(8936002)(8676002)(5660300002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTN0YlZWMnQxUmxxZWJON1RybG9FR3FobUhKQ3huWG42OXFhMmdkNG9CSlNu?=
 =?utf-8?B?WlowQUlDMEhmUVphejZyKzN5THAwTU5CdzdCdE83OGpQWVR1MlBsMU4rQndt?=
 =?utf-8?B?QzVadElZVlhCUHoyaE0wYzR5YVdJQ3Z0SndYV2hGNTR6eTdDZG1ENDRIbldj?=
 =?utf-8?B?a2ZIWmNMQmdBc080UVFYcnM1MzRrL1F3SGRVR0lqN1NqZU52eS9VNVhkbHRV?=
 =?utf-8?B?bWhMNU9HVmhPbThPQmZvNXozMEVRQk5QTVBBMzJIQWloYW1mdTVXN0J0amtY?=
 =?utf-8?B?VVhUN1dSRGkxendaVTNzTDVpSmM1amhHUStIeWNsVjJTbzVUdUNvdTgwN2Mw?=
 =?utf-8?B?SVhGM2hDMXRWUHMwSlpmeEhjWmdmODZBYmtQSE0rWE9ROEdJbllCZ2puYUwz?=
 =?utf-8?B?WWUvT3BoWVhBdEMvcC9WTzd0MHRJZEpwZEU2OVhuY0crdHdKbWYzWWt5ZXFn?=
 =?utf-8?B?NDl4Mlp6M2VUQWlwNjE2cmNGeFBnK2l0MnlVRUlPUEFHRHZVV1VsdTZnQ3la?=
 =?utf-8?B?ZXpiemNOYS9taFhkSjhlUkNQaVVDWXdwNVNmSGtMRm1HT2hWcUlyanBiQm9C?=
 =?utf-8?B?R2srbHBGOXBpWnoyR1BZcGJ4VkhRSWtEWXhwTEpkWnpHcDFLbVRTVk0yaE1F?=
 =?utf-8?B?ekIrejJTSVhId0N1a2puNG4rWjhFcU5XZTVZdHZzNmF0ZzZiZnVKQTNkT3B4?=
 =?utf-8?B?cWk4UDd3UmU3TzVMdDJzNmtoWmdxM0NMU3Vzd09FeFFsU2FERVNQRFBzRHl6?=
 =?utf-8?B?YjhOOUdzY1hYNmk2WjFiWGhHZWMzcUdwUStXejVHUXl4amEvRFRKd2srdktK?=
 =?utf-8?B?Y2VxdnpkRGthd3kxTzcrZzNEeUZTMzlvQmRXOGNRVUVQcm80UzVYTW1LSXRW?=
 =?utf-8?B?YUpXbHlKNUJra0pXYk9wTzJOMVhHeWFMbzRSbUkrbjVNMDdnK0R1SXltelJN?=
 =?utf-8?B?UTRTWnZrR2pxeFN5eTBOMnkvS1FMNjBMWXRBeVlzRkpQL1BkTmhjRGFNK1Ey?=
 =?utf-8?B?NHJiZHlSa3AxTUFUZjZkalpRaWZ2Q1BURk1qejJPTVRMbjBvWlZQTFo4MEtn?=
 =?utf-8?B?U3IwTUgwdzlRV3B1NXBMM1gzdGw1a1M1TythZW9rU29pZXF1UEtxczNFWkpo?=
 =?utf-8?B?UjZEQVNhRWxsaGFXMFZUZTludnh4Z2pic0R0bFFLclNYWDFya2RTUyt2emJ6?=
 =?utf-8?B?akxxMVVTSE9TK2pxUWJRcE5McCt6Wkl2L0M0OWVTSHM5SDBHS0xuNEdrSDdv?=
 =?utf-8?B?eXJ4RDYybFRYUG1uTmFoNTVCTVpjVG9va3ZIT0tlQ2ZRSmVjSThYQmZLbDJ6?=
 =?utf-8?B?MVVBSHlYb1Y2N3J2RHovVHI3QUdwdTZtYWc5bFp4dVR2MnpHVFBPUnlRVmE4?=
 =?utf-8?B?cEVqMFVQb2pieTJZa1oyUDNmeUpJMTc1Z2YrcUlrZnlOeFE1cEVLUlE3Z0Vn?=
 =?utf-8?B?V1dBVDl2Qm5aMm9QaUdzajRtZXUyZUFWMFZVOFBsN1hRdjBiYm5pVHBaL3cr?=
 =?utf-8?B?enNFVWNYUjBFR3pqTVlWZUhIU25VNnNpS25MNkNjV21pY3JDTE4yVWg3ekdX?=
 =?utf-8?B?VWtSVnFINzNjTkpEMFBOd3V3eWJMY2t6OWJDWTh0ZUYxRFQ1eGJhTmZqOG5Y?=
 =?utf-8?B?dis5cFZvanZZTjhmd0dQd0tLM1pwcFBYUVovc1dRb1RLY1ZzUHErZEg5a2RQ?=
 =?utf-8?B?bEVjQ3JpVDhKZnFVWWJEUXJOTnRsQ2VHZ2xkRFdTVGQvckFINUt0Skowa093?=
 =?utf-8?B?bUpGcE43bjYzb0QwZ20xV21lT1BCSHhrUWNsNXRUYzh0d2Z4c2hIbTBJdWg2?=
 =?utf-8?B?NDBQQlBEQjRiT3FQOW5tUjVWLzRNNDFhSnVZclZWVHZBb0w1eERYVWRPdXdy?=
 =?utf-8?B?WUx4SlZwbnpKSHp6d2RIcG4reG9FaFVjZlVCRVFtOU94NXQ0cFZvNVZLaFhz?=
 =?utf-8?B?NTliODBwOVRLVjhWT3A0MlpmRnprSVhhUDRmdkJrSDRLVTFML3pIeTRLSVVi?=
 =?utf-8?B?a21iS0t4Y3BWcUwzWWIxQ1JRckduY2dUM05kSzE4MjlUNXVPSTJIRXp0Y21M?=
 =?utf-8?B?aEcvYTNYeE5xVjFtUmJXMEdLUUVHZVIxZithZ1pzdlI3WVdrTDgrWUNLdDVW?=
 =?utf-8?B?UHBvNy85aWJmU0J6UUpHT09yM3NVWXJ0dHN5RU82Z2JrS3RRZTNPandzREVz?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NWhNb0JVNkZCbXNaZ0haWUttNStENUhrY1ZTbnBxZGdmZHBmZEVick9qSldO?=
 =?utf-8?B?YWZTT1RKZVNNQlNxbEYyYmhZRlpmbE1VR1d0Rk5TU3pSczVqaGZ5S3IrRUR6?=
 =?utf-8?B?WlJMa2c2UFIrZWRBTkZGNXF6UVVhQzdQcDFBekEyaVlmU0tweXhmQnJId00z?=
 =?utf-8?B?Ui9rbDRMYndtYi91ZjdpTW5tM0FOU1lNZ3oyR3czRFpxSEkva3dwQncvOGJa?=
 =?utf-8?B?QitzQUNJSnFZS1c4NTdGbmZUNk5XLzNpU3RhNE0rR2lVRGNWZWR5NmFqN0o3?=
 =?utf-8?B?RmxMUUlrOUs2MlpwVWJxNTVLZDF4VEcrNmlzM1JmdmpSbmN1dGJBZXRTWlB5?=
 =?utf-8?B?ekI5bERkMHQxVFVZbDRSK1BpdHk4S2wwUGxkZzRBbmZmc0JtNXRJaTZiMkZk?=
 =?utf-8?B?am1jWDF4OWZzbjdJSHlFWGtJV1pBbkg5RGZHSFZWaUJZbjNhQm9wVEdtQ0Iz?=
 =?utf-8?B?N0luSEN1ekgxRGNYN3lLVFBDU1EyU3J6RlVYT0ZrQkhqUHJPbnE2UG54eTFj?=
 =?utf-8?B?RzhNbVN2VG5kZE9RUldZakJlS2x2REN6ZzUwSGJXYWNsMW5MbDFVMndDOTA3?=
 =?utf-8?B?bGpMTThwMDYvVmJYSEFSTFZRNG9xZUROMSsyTEx1OFpSTXpsMWEwRWZLN3Rr?=
 =?utf-8?B?T0dORktLUHBuaUs5aENxVXoweVQycENpWU90ek41T0hZM250UmlEVmlsQzRH?=
 =?utf-8?B?am0rTFNESzAwQkN1VzZiQlRNK0VXZFdVTktXMm5mbDZDZW1oTWt3YmVkQm1i?=
 =?utf-8?B?MXFHcEpsTlZkMkdnbnhyMEJFYTg3MndTSnMvTGlSRlRwQnV3ZFZHSTRFVnRK?=
 =?utf-8?B?RWJmSEd1ZEo4RTB6dTg4amxTUW5wa2JIRWZhbjM3c1Rad1ZhMmp2dHJuZ2ZR?=
 =?utf-8?B?VWI3QWpzVUhWbm85ZWszR21ETjJVUFo2Y05yd09COHBFYXdyT0MzVG9TVVMv?=
 =?utf-8?B?Y29kNzRCcTBYYTRZeFJkSGtxS2tqaHhua1NYWE9iQTl6cFNLaGpEQ2xSbVNz?=
 =?utf-8?B?SHRKL1d4clBpY3VOMUxoQUdNNWpickNFdUZDa0preEdERUo2Yms1SmZISHNL?=
 =?utf-8?B?Q0ZTMEZuNjhZeE96REVHZktCcjZBdDlWQ1g4TmVtczBaK1ppUzkxNzYvV2Q1?=
 =?utf-8?B?b2QrRHEybUxPWEtod1RNd3RUY05pUEU4bWRrQXNqSlg0RnZaWmhLNXpVZ3JR?=
 =?utf-8?B?ZEdxYVlOY3FFcEg1Y21TbENDK0xCYkRDRTJFeEFHUlNJQyszQ3grRkZBS3VS?=
 =?utf-8?B?Z0Z2TWlWTW9YNEI3NmFmVEFsSW93cjJ4Yjh1SURRN0o1MCtzZnZxQWJUZWtM?=
 =?utf-8?Q?TOjSGsu2XrX7nSozyFbEeZ+NdJHyMmfLla?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc38963-bcf8-479f-c58a-08dbb3a724f2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 15:44:27.2962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGUYQbj3R45iKQOfl0iLuzJAOrXWF//TuGT54tn4ZJIGVus78nzudlc76lD9zHGxFAN8tQChxbr9SBS2G/7geg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6280
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_14,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120130
X-Proofpoint-ORIG-GUID: EjioiGn-ojNXW1UFpRuBYxlqhFoRC967
X-Proofpoint-GUID: EjioiGn-ojNXW1UFpRuBYxlqhFoRC967
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul E. McKenney <paulmck@kernel.org> [230912 11:07]:
> On Tue, Sep 12, 2023 at 09:56:17AM -0400, Liam R. Howlett wrote:
> > * Paul E. McKenney <paulmck@kernel.org> [230912 06:00]:
> > > On Tue, Sep 12, 2023 at 10:34:44AM +0200, Geert Uytterhoeven wrote:
> > > > Hi Paul,
> > > >=20
> > > > On Tue, Sep 12, 2023 at 10:30=E2=80=AFAM Paul E. McKenney <paulmck@=
kernel.org> wrote:
> > > > > On Tue, Sep 12, 2023 at 10:23:37AM +0200, Geert Uytterhoeven wrot=
e:
> > > > > > On Tue, Sep 12, 2023 at 10:14=E2=80=AFAM Paul E. McKenney <paul=
mck@kernel.org> wrote:
> > > > > > > On Mon, Sep 11, 2023 at 07:54:52PM -0400, Liam R. Howlett wro=
te:
> > > > > > > > * Paul E. McKenney <paulmck@kernel.org> [230906 14:03]:
> > > > > > > > > On Wed, Sep 06, 2023 at 01:29:54PM -0400, Liam R. Howlett=
 wrote:
> > > > > > > > > > * Paul E. McKenney <paulmck@kernel.org> [230906 13:24]:
> > > > > > > > > > > On Wed, Sep 06, 2023 at 11:23:25AM -0400, Liam R. How=
lett wrote:
> > > > > > > > > > > > (Adding Paul & Shanker to Cc list.. please see belo=
w for why)
> > > > > > > > > > > >
> > > > > > > > > > > > Apologies on the late response, I was away and have=
 been struggling to
> > > > > > > > > > > > get a working PPC32 test environment.
> > > > > > > > > > > >
> > > > > > > > > > > > * Geert Uytterhoeven <geert@linux-m68k.org> [230829=
 12:42]:
> > > > > > > > > > > > >     Hi Liam,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> > > > > > > > > > > > > > The current implementation of append may cause =
duplicate data and/or
> > > > > > > > > > > > > > incorrect ranges to be returned to a reader dur=
ing an update.  Although
> > > > > > > > > > > > > > this has not been reported or seen, disable the=
 append write operation
> > > > > > > > > > > > > > while the tree is in rcu mode out of an abundan=
ce of caution.
> > > > > > > > > > > >
> > > > > > > > > > > > ...
> > > > > > > > > > > > > >
> > > > > > > >
> > > > > > > > ...
> > > > > > > >
> > > > > > > > > > > > > RCU-related configs:
> > > > > > > > > > > > >
> > > > > > > > > > > > >     $ grep RCU .config
> > > > > > > > > > > > >     # RCU Subsystem
> > > > > > > > > > > > >     CONFIG_TINY_RCU=3Dy
> > > > > > >
> > > > > > > I must have been asleep last time I looked at this.  I was lo=
oking at
> > > > > > > Tree RCU.  Please accept my apologies for my lapse.  :-/
> > > > > > >
> > > > > > > However, Tiny RCU's call_rcu() also avoids enabling IRQs, so =
I would
> > > > > > > have said the same thing, albeit after looking at a lot less =
RCU code.
> > > > > > >
> > > > > > > TL;DR:
> > > > > > >
> > > > > > > 1.      Try making the __setup_irq() function's call to mutex=
_lock()
> > > > > > >         instead be as follows:
> > > > > > >
> > > > > > >         if (!mutex_trylock(&desc->request_mutex))
> > > > > > >                 mutex_lock(&desc->request_mutex);
> > > > > > >
> > > > > > >         This might fail if __setup_irq() has other dependenci=
es on a
> > > > > > >         fully operational scheduler.
> > > > > > >
> > > > > > > 2.      Move that ppc32 call to __setup_irq() much later, mos=
t definitely
> > > > > > >         after interrupts have been enabled and the scheduler =
is fully
> > > > > > >         operational.  Invoking mutex_lock() before that time =
is not a
> > > > > > >         good idea.  ;-)
> > > > > >
> > > > > > There is no call to __setup_irq() from arch/powerpc/?
> > > > >
> > > > > Glad it is not just me, given that I didn't see a direct call, ei=
ther.  So
> > > > > later in this email, I asked Liam to put a WARN_ON_ONCE(irqs_disa=
bled())
> > > > > just before that mutex_lock() in __setup_irq().
> >=20
> > I had already found that this is the mutex lock that is enabling them.
> > I surrounded the mutex lock to ensure it was not enabled before, but wa=
s
> > after.  Here is the findings:
> >=20
> > kernel/irq/manage.c:1587 __setup_irq:
> > [    0.000000] [c0e65ec0] [c00e9b00] __setup_irq+0x6c4/0x840 (unreliabl=
e)
> > [    0.000000] [c0e65ef0] [c00e9d74] request_threaded_irq+0xf8/0x1f4
> > [    0.000000] [c0e65f20] [c0c27168] pmac_pic_init+0x204/0x5f8
> > [    0.000000] [c0e65f80] [c0c1f544] init_IRQ+0xac/0x12c
> > [    0.000000] [c0e65fa0] [c0c1cad0] start_kernel+0x544/0x6d4
> >=20
> > Note your line number will be slightly different due to my debug.  This
> > is the WARN _after_ the mutex lock.
> >=20
> > > > >
> > > > > Either way, invoking mutex_lock() early in boot before interrupts=
 have
> > > > > been enabled is a bad idea.  ;-)
> > > >=20
> > > > I'll add that WARN_ON_ONCE() too, and will report back later today.=
..
> > >=20
> > > Thank you, looking forward to hearing the outcome!
> > >=20
> > > > > > Note that there are (possibly different) issues seen on ppc32 a=
nd on arm32
> > > > > > (Renesas RZ/A in particular, but not on other Renesas ARM syste=
ms).
> > > > > >
> > > > > > I saw an issue on arm32 with cfeb6ae8bcb96ccf, but not with cfe=
b6ae8bcb96ccf^.
> > > > > > Other people saw an issue on ppc32 with both cfeb6ae8bcb96ccf a=
nd
> > > > > > cfeb6ae8bcb96ccf^.
> > > > >
> > > > > I look forward to hearing what is the issue in both cases.
> > > >=20
> > > > For RZ/A, my problem report is
> > > > https://lore.kernel.org/all/3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@lin=
ux-m68k.org/
> > >=20
> > > Thank you, Geert!
> > >=20
> > > Huh.  Is that patch you reverted causing Maple Tree or related code
> > > to attempt to acquire mutexes in early boot before interrupts have
> > > been enabled?
> > >=20
> > > If that added WARN_ON_ONCE() doesn't trigger early, another approach
> > > would be to put it at the beginning of mutex_lock().  Or for that mat=
ter
> > > at the beginning of might_sleep().
> >=20
> > Yeah, I put many WARN() calls through the code as well as tracking down
> > where TIF_NEED_RESCHED was set; the tiny.c call_rcu().
> >=20
> >=20
> > So my findings summarized:
> >=20
> > 1. My change to the maple tree makes call_rcu() more likely on early bo=
ot.
> > 2. The initial thread setup is always set to idle state
> > 3. call_rcu() tiny sets TIF_NEED_RESCHED since is_idle_task(current)
> > 4. init_IRQ() takes a mutex lock which will enable the interrupts since
> > TIF_NEED_RESCHED is set.
> >=20
> > I don't know which of these things is "wrong".
>=20
> Doing early-boot call_rcu() is OK.
>=20
> The initial thread eventually becomes the idle thread for the boot CPU.
> See rest_init() in init/main.c.
>=20
> I can certainly make Tiny call_rcu() refrain from invoking resched_cpu()
> during boot, as shown in the (untested) patch below.  This might result i=
n
> boot-time hangs, though.

If we set the current thread as !idle, then we don't need to add
overhead to every call_rcu(), and you've already tracked down where I
need to change the flags back to idle.  Patch below.

>=20
> The thought of doing mutex_lock() before interrupts are enabled on the
> boot CPU strikes me as very wrong.  Others might argue that the fact
> that __might_resched() explicitly avoids complaining when system_state
> is equal to SYSTEM_BOOTING constitutes evidence that such calls are OK.
> (Which might be why enabling debug suppressed the problem.)  Except that
> if you actually try sleeping at that time, nothing good can possibly
> happen.

Does lockdep check for SYSTEM_BOOTING as well?  That could be another
reason?

>=20
> So my question is why is it useful to setup interrupts that early, given
> that interrupts cannot possibly happen until the boot CPU enables them?

I don't know for sure, but there are 'preallocated IRQs' which end up
grouped 0-15, then I see another one added at 55 after the mpic console
output.  I suspect it's so that they can be added as they are discovered
during early boot?

The below is not fully tested, but qemu stops throwing the warning on
boot and it doesn't add instructions to call_rcu().

------------------------------------------------------------------------
diff --git a/init/main.c b/init/main.c
index dbe1fe76be34..fd4739918a94 100644
--- a/init/main.c
+++ b/init/main.c
@@ -696,7 +696,7 @@ noinline void __ref __noreturn rest_init(void)
 	 */
 	rcu_read_lock();
 	tsk =3D find_task_by_pid_ns(pid, &init_pid_ns);
-	tsk->flags |=3D PF_NO_SETAFFINITY;
+	tsk->flags |=3D PF_NO_SETAFFINITY & PF_IDLE;
 	set_cpus_allowed_ptr(tsk, cpumask_of(smp_processor_id()));
 	rcu_read_unlock();
=20
@@ -943,6 +943,7 @@ void start_kernel(void)
 	 * time - but meanwhile we still have a functioning scheduler.
 	 */
 	sched_init();
+	current->flags &=3D ~PF_IDLE;
=20
 	if (WARN(!irqs_disabled(),
 		 "Interrupts were enabled *very* early, fixing it\n"))

> ------------------------------------------------------------------------
>=20
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index fec804b79080..f00fb0855e4b 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -192,7 +192,7 @@ void call_rcu(struct rcu_head *head, rcu_callback_t f=
unc)
>  	rcu_ctrlblk.curtail =3D &head->next;
>  	local_irq_restore(flags);
> =20
> -	if (unlikely(is_idle_task(current))) {
> +	if (unlikely(is_idle_task(current)) && system_state > SYSTEM_BOOTING) {
>  		/* force scheduling for rcu_qs() */
>  		resched_cpu(0);
>  	}
