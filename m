Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D017F29C1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjKUKFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjKUKFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:05:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC1010F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:05:40 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALA3uWW029398;
        Tue, 21 Nov 2023 10:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7A/X1PP2feibU7DMd9Z83axwxysbmmAy1OIKsDlcw2M=;
 b=CyM0KvuwkfuBKeonAkMlFoDgUR+tVw9Hqr11JVCQANNryE467Zd+EW65Ld4ms3ghFNx2
 RliO9gauKXTGOWpI6J9x+oONyFti1ZN5RjIDzcTFFhg48fQGnrZP85mFtOEnkRkZ/uaf
 OptuJf1qZ0aTTcXCySOMqp1h/R9fETPVECz0ooiy6nfTvcUJ3HS+qWH/ZGmV0rkqTjJ6
 j87+jEFo1e8NvXSnNb5i2dh8KbhEp3TkXHD1bnTahN5wA5WrhtlfmAx+ZeQn4sWRsdEh
 15Nm+gpCdofvFhgBle/CLYtuj23FA8mi140J8yL3Dwqrq7AsXaWwbgUG+n5Spdd30LyK vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uenadmpef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 10:05:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL9kwRx037450;
        Tue, 21 Nov 2023 10:05:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq6qn9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 10:05:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G26ux34OzCsIPJJnd9Ue7jmnd56VjdSVbCIsmVEm60W9tqmN2GqC5zKM3i9Uxuat9I3KdPpIJJT/4OTsJuWELwgYNT3DCMSuIfjAHe5KfPYvqbMX39Xf9UErW8KCCDgO58+tDMhwPWsIdF20NnphH6GNFjSU+0F8gTdiqvf752By1GwmCxtO8fMWcHubmguTeTSgiA3gLsHTZnUTuaYGepfIfdgcIr3VfX8fZNGQ6XS3qmV3AizfYbD4ldZZ5FQiAypIPlFzjgZMYsHzoMsv4KGiYfNe5pJ3kZV95fzgiBbMq3HdrbIXuj3l1KkOeEQeyfdPwmxcB92vsNho7WpK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7A/X1PP2feibU7DMd9Z83axwxysbmmAy1OIKsDlcw2M=;
 b=YjsQe2nN3KN5KxNfE3qcz0LA+8DP2sb7UMSwPrcnOnYOiEDSJBmMRNHwTyIe+tUB/YeyAriUz6XfPjy15ezD6nFWRS6Q7SsSmL9SJmzIGcIM6fNbzEmHQisGPzaDsQL1KAa4OmhT+Z0e49muOWGiaHgkuB1MmrCOhd3hYL5+3/HWmQtLU6CejjgJvuX1c3FaLelXF/Sbu1ylYit57HCcNidS9LfvajRva78W8feeJeuH9DtneD2S2iQ5oHGFOe7B0UCHeul8aJGiVuL9LKoFGeVR46ZzW5G/JgylcM1hkw77Enb1YToojAbwZGlp/aA+ybjXn49p2X6jNTc4VIw1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A/X1PP2feibU7DMd9Z83axwxysbmmAy1OIKsDlcw2M=;
 b=rBN0zKewhrA0PDRu1xh6X60n4C05GIoYoq39TpHAW+/AXM/DV9DZ2PfYeGxmmVKn8MBYNc6IFqYyVNkXkuUXpk/g6hKq2lr3afeqoAFeuOEQwiGsAEd8rv7+DjRvAs9PJRwb/ZDm7h7kbjDghEawKq0EnXarIX0LQRqk5qZJNnk=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DS7PR10MB5976.namprd10.prod.outlook.com (2603:10b6:8:9c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.26; Tue, 21 Nov 2023 10:05:12 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 10:05:12 +0000
Message-ID: <0e1bf1ff-a214-4b73-9a8c-95f997a170b5@oracle.com>
Date:   Tue, 21 Nov 2023 10:05:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Set variable amd_dirty_ops to static
Content-Language: en-US
To:     Kunwu Chan <chentao@kylinos.cn>, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com
Cc:     kunwu.chan@hotmail.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231120095342.1102999-1-chentao@kylinos.cn>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20231120095342.1102999-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0034.eurprd03.prod.outlook.com
 (2603:10a6:208:14::47) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DS7PR10MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc0f46e-9aa7-4737-0c8b-08dbea7959e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajh82K14o2XxmBYmaQbiF0iWKXs/+nE6wMe4VxSGs/fYIp7ZmB2mDmKw4Y7zARautOyOa4/pde2TZjDbqYqX8s+QbnekQNltW9VCgasVPUDcbu/Xv8mL0EJYzJnfFmDMR+TyxsdDkT4rQymEQjVkeiplUohn03S0ylnAT5vzad5PNv/swuB6pb1yRPY0klXeOvf77Z7/QDmq6nk9vhRCDMj8lT3b/he1F+Ts1t3PFUt7Oq0YBwwZXEdM98PcBxsE1FgDbbue30AOVYjkYk9bF2BEXen3vhhnRVOZZ4zqaQiatc1xd0aWG7HFM/7pHFcrun0X/PNC9/LpYXd45GYkFL8Yn34A6CDgJhsHqMVA7/pjr0jQU2bYTn8/ZOkyZTPcv49hGY+cZZWHtAmEyz49cBvPiEjdE+/Z5QcTgRp4E5Nfu0obfDJHm577A9vo2Z5DwWCD4F9JPhFa0UF9LAs2tMflbDDY1Cd5DVjEI1DHULds9b9Z9aDiVP3IPO6zMPIocDm8ICqFvL2zlgvMoferVQNGO9QgPz6F2O2dcRNOTxTjBaXHEFV9t6YgM0z1UVW5P/3e/8In451NQFv842ZqXbuGNNa4/N8fLpJ08UfeITw0HGY/w34OOoc5ZvsafN42YJlwhvJ2Fx/0sD9Hl8YXGoJEibNpR9noGchrdzl8Y3SG4H+7K0DKWA8Rz9NEZ7HzhnYoQLK77RlxYNW3X7iTqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(31686004)(2906002)(8676002)(4326008)(8936002)(41300700001)(66476007)(316002)(66556008)(66946007)(86362001)(26005)(6486002)(478600001)(6512007)(36756003)(53546011)(6506007)(2616005)(83380400001)(31696002)(38100700002)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkZmZXdFZEIxa0VXaTBaT1I2RTdOZlMwZTBHYlduNUc5L0NUc1lNblJBajNm?=
 =?utf-8?B?OFlpTVMzMzNzUGtaaWxHeHc2NFRTd0VIb0hiWllaTGNkVWJaZ3hSUy80c04w?=
 =?utf-8?B?alA2eWVaWHh0WktQV09Yd0szZHE1bzBKUjFkbGdweCt5MUViQ0d5N1c0N3pj?=
 =?utf-8?B?WEZGZE8vMW9nNUk3WDUrZ2s1M0pqUm5xNDVuQW9hZkhkczlrWll5U1VIRCtE?=
 =?utf-8?B?UzVqcXlOcTl1V2tLeTNhVHNrTGF3Ynd3cElRUVlFYmtGTnIvbzJaclpYcFBk?=
 =?utf-8?B?eE03bDZmMzJ0bXJ5S3FvSGk3YmkzSkQrUEFwRDBFM29oanlVNVg5aytqUkNa?=
 =?utf-8?B?ZUpnZHZQNWN5bGNkYUVWKzdrOWVTa0lzRExIOVBUK1FIc0liOGtuZ2xIa3dM?=
 =?utf-8?B?VlUwTXZWRlVWd0lxREZvaUN6cXUyR2xaaXhQNi9mNGMwTkJmRlhUZzdmMmFi?=
 =?utf-8?B?akp3SXR0WHgzS0xBdHJ0WVdlYlRlYVB1QjRIUXZkQ0ZraVhNbjdJYkVVR25i?=
 =?utf-8?B?ZWFFKzZ2dFJoeER3NXRZRitxVXpnTUtYTExJcUlSK1dvSjRlV05qQkZ0M3Ji?=
 =?utf-8?B?bjFKVmRKenFZc3YzMzFWVjh1NElQMHpPVTMwNFMzUkR5T2lyVmc2ZjZCRnBM?=
 =?utf-8?B?bXBjTmhMRXBVQU5Fd1JMVkRKUkpzcnNGZ1QzRSthalZUUXNlWmdabHAxbW1W?=
 =?utf-8?B?MnV0emtuOFI1c0lGSStvMlFsN1NDSEZ5TllRQWVYRDROZVVLbDB4Z3c5cWRU?=
 =?utf-8?B?NUhJT0pDSEFMNjhjN01XbzdLMTlqdE45NTRqUXNlMnEraWJPeUFDeHU0dThJ?=
 =?utf-8?B?MUNHKzlKTk9SSlFobDNVYTMxOGZaQS91aXBVa3lEaVBVWE9WZ0RoN3E5bVZV?=
 =?utf-8?B?VklKUXdJTkUzTFFIUHZzaHZSREFpc0FYUHhJc3ZIaFlSV0UrL2VpTjV5YmNK?=
 =?utf-8?B?ZDhrWDhtV1IvdndVRXBCcDNIY0Rzcnd0Z3BzTVhQR3ZBQlV6b0lEcFUzUTRy?=
 =?utf-8?B?UWg1TUxueXJsS2xoZmo4UERhREJFUnRsUHltS2FXZTJEMXpsUkt3RUxaZ05h?=
 =?utf-8?B?SXJscGRidUVja2VSQTdYaUlCY3lDVTZHWGw4VWRCZDZzOEEyRzluTG84NEFn?=
 =?utf-8?B?cWgxRTdLMzNZYkJJRndISXVMeCtJRDBrL3FBaWZLSjZSQXNqR1lyWmZFeFUz?=
 =?utf-8?B?bUZPMzh5MTdkMWRFeXExd2dLZmVGaGRhb3FRSXNVUGg3aTNpckNtQVhiVW1m?=
 =?utf-8?B?RWtLRm4yQkNrLytiVi8veWlUbEFqYytvRDRiU05CVTl3aS8vUFVKc29xeW9F?=
 =?utf-8?B?ZlNGOTQ5eVY1TnVjdCtxTVR3azJjRkpyT1VHZTdUQzVjMU9iN0dUV3dtNEdC?=
 =?utf-8?B?V3Y1S292NkJuaTZ6QzdjeDZkbXdJeUd3L0R5R1pJc1dGdjJ6NENyUEFzU0g4?=
 =?utf-8?B?VHFpNXE3NWpaenNUd2dwSGZ2bFZNNUloeGJxUDBRMyt4aldXbmZ2YUhYUkZy?=
 =?utf-8?B?VU16WHoyREVpVDlWUi9pMmtqdmpVdTJQWStHelRvQVR0T2J6SkdyVW9RbVhG?=
 =?utf-8?B?QVdkMDVZajNMOEhVVi9iWU5iQUE1UDVBdXgwRDVwQXdXOHBLS1JBb1JMVU9z?=
 =?utf-8?B?cTkrQkJ4bXZVK1J3N0M4YXplN2Rrc1NkaldjL3A1UGd1WTE1VEhVQXZxYVZa?=
 =?utf-8?B?YSt2OHZtcG9Wc3l5NjVPVlhGSUxKRVhFRHpKV2tNeW9lQXhvL3dkNzlMZWM5?=
 =?utf-8?B?OURxbmZzVmpKejllUXJ6R0ZrYXRReU5UenpackxHbzljcVNlaFRrM0t5cWYr?=
 =?utf-8?B?ZDZ0QldWNC9BS2hPMkJQdEtXeXJnc2lKQStGMC9kWFJaUlV1azBMUkd6NGw4?=
 =?utf-8?B?WUNMczMwUHd3Ujh2VVMvb3hkUTMwU0VqREJveGRDNDB5ampvcjJPNlZJRjRa?=
 =?utf-8?B?bFAzcHV1Y0c3WmFubFl4YzAxcTJFR01DOVVESnVmOExoTGUwOTJxeThKQXZT?=
 =?utf-8?B?L0VtWWVQUlFOTHJScDh4Uzdmdy9XMzBJWXpYcW1ieHAwVWtVVzFBdXVLajNN?=
 =?utf-8?B?MkZwYU50SW5uSFpYRnpKTElRWnV1RkYza21samdDaFB3c25aZjJmc2hCQ2VQ?=
 =?utf-8?B?Z3h0UFJqd05Dd01YcHl6Mnk1Y200ejA4OVlKWkhRUnFnS1VzVWJaRmdPZS9q?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L25GejFKR2ZhL0ExcUVLNUdteTBSa0VnL01mTlVQVVBqZUcwZW14czRHRm9K?=
 =?utf-8?B?N2tPUHFYMDh0ZWQwZ0xWUzd2QXhFdlZsdkZCWWRWejdlWTZGWFV5SjF3ekZh?=
 =?utf-8?B?dVB5Skp5OHVhd0lobE5XSFIwT2xqclZsbERpVXY3cXZxSWhKcEZvMHhjZjdV?=
 =?utf-8?B?WHVSMUFqNVlqWHlobHQvanpUQklWVlZaR1ZOT3RuM3RPUWIwQk1NQ0diQ2N5?=
 =?utf-8?B?NXVRRkpneWZPWHR1Z2daUlpBdDRwcVoyek1VU1loSGNTQmVnbUM2czUwZXBN?=
 =?utf-8?B?d1IyQnNhc2p0c2d6a1BUWVdGWENZVUhZa3k4RnViaUViZXdPR2IrQS9WdHh3?=
 =?utf-8?B?anlLK0hUUUxvTUMxbkZEc0JYYVFTQmxjZWJHY0owU0dVL2dXc1Z5cmViNk5G?=
 =?utf-8?B?bFdVSkROYmd4ajByUFZpRXpKZGFMTGFSeVk0bS9GcmtlKzJ6aUlaV09yQVJZ?=
 =?utf-8?B?WGtPRXFLNnhMK3JvWEIyVnBNV09HV0kxOER2cmVsU0dXOU1hbnV3YmhSc1V0?=
 =?utf-8?B?SnpOQjRGdXlTY2RaR3NMOEZIRmFpTXBQL2N6OGM0WHVCb0h2ZXNnQVJkZGt3?=
 =?utf-8?B?SmRXZlo2MElmM1hsR050ZEFQNVk3VGpGNWFnckI5OVlDUWduVmlLeVJXWmd3?=
 =?utf-8?B?dy91YmpXaHpmMVRNMUNvb1ZsOFlPVFcxVFhFQlUvUDQ1T1FZdUgwenEwVmcy?=
 =?utf-8?B?amRXbmphTzY0YWZLZkpLREJ2alRsVkN5YlM3M2dzRlJQcEpPNjNTSkZUVVZ6?=
 =?utf-8?B?cnpuSy9NVFBKNkNjaEloOXIrSGhjSlVDMDBoa242T0d3SExSNU1TSi83bUYw?=
 =?utf-8?B?VzhmSTBXS2QzRmtqd0JZY1pHT240dWgyckNnRnEvL0ZPL1FCSnA4NEp2NGRj?=
 =?utf-8?B?c2tBcHYza3dKR2dCRkNLSU0xcmFWNEgwYmpEbmMzWmxYMXdpcitGUEZEUVB4?=
 =?utf-8?B?UXc1MzVRT3JvUDFIWG9GQjlFYnNjbm5HSlNXQ3BNeTdFZTBZYVJqc3I4Sy9Y?=
 =?utf-8?B?ZjNRMFhNVis0SW1aelhxbTJXNmdFS0VYUmN5eHFaZEdBalNaZ0RKeGdYNkVp?=
 =?utf-8?B?RDQ1bWtnL1ArRC9KNFp5Wkc3TnZONzlKaE8wd1NWTjRicUNpZmxsN0lqNjZ2?=
 =?utf-8?B?K29SeGtEZjVFdGtranhJc1lKWG5GNlF3ZjdhbFpPZzkvd29BYVQ1OE9nL29t?=
 =?utf-8?B?SFhObGFQckVTNDhRektqVFU5a0xPREdXa09YNlUzbWNhMU1iK1dVM1hkY2lq?=
 =?utf-8?B?MmFWSGhWeTF0U0Z4bkpXc1Nia3B0Qm9JcFV2SW9HandLWHprQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc0f46e-9aa7-4737-0c8b-08dbea7959e8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 10:05:12.5202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GhJMnm83aou1eLZSJLbqiTM6XK2jlLpwPMyu4zjgECWs7vDntxKx0P7Cw3/EdONqGQ3coxsM2b6kZvQ0iGCvZy31xURXfXQSgiw+cTR0zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210078
X-Proofpoint-GUID: 6vGTq87OgyQKcGcvwaEGQA9TdrafwxPy
X-Proofpoint-ORIG-GUID: 6vGTq87OgyQKcGcvwaEGQA9TdrafwxPy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2023 09:53, Kunwu Chan wrote:
> Fix the followng warning:
> drivers/iommu/amd/iommu.c:67:30: warning: symbol
>  'amd_dirty_ops' was not declared. Should it be static?
> 
> This variable is only used in its defining file, so it should be static.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  drivers/iommu/amd/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index fcc987f5d4ed..9f7064360828 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -64,7 +64,7 @@ LIST_HEAD(hpet_map);
>  LIST_HEAD(acpihid_map);
>  
>  const struct iommu_ops amd_iommu_ops;
> -const struct iommu_dirty_ops amd_dirty_ops;
> +static const struct iommu_dirty_ops amd_dirty_ops;
>  
>  int amd_iommu_max_glx_val = -1;
>  
> @@ -2635,7 +2635,7 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
>  	return true;
>  }
>  
> -const struct iommu_dirty_ops amd_dirty_ops = {
> +static const struct iommu_dirty_ops amd_dirty_ops = {
>  	.set_dirty_tracking = amd_iommu_set_dirty_tracking,
>  	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
>  };

