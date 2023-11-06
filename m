Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA127E2E04
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjKFUPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjKFUOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:14:54 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DFC10E0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:14:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Su5XVP/vrcfxLZ3sJHgF9CXtQCCKM4dawXTeuXMlEfhCfNa8Vz5sAL44Yeng6+u80nxiQ/pQr1BatzFzrXZEjC7N2j97OeN8oA4HKazSJzdJrILsO6T+olX6fwBJklMIxPEfh0NPzFSvsD6HsuxRC/u0UffdbiJrhwUd4vTiw6e+SQz5AnH5QNBMIQBYVqyuqylNcy3D2DSRjyVMh0f+KIjwrCa3aXPelGY9T1y4XEgnv+0w0/J2x9pOHaboswLUGV66ivn4ltOTBPLImnJcg3/IqmMdwT+MP/Otw8mqNvGWqPDGG0RwY+tnTYRds9A6g3mzKq3nydqHwt1EJMBR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGOkS1VxZDUH82HJzxWuRDjKQkdLoboiLm3OwCOS/vU=;
 b=E7oCLbBmm8N0d/FZefZh4f9Mq88+j13npz1vtPmnYlGJvmYBmv9qPg5pTpzk6iyct3eyWdhGMEqRu1YSRtPgq7OE0pDn5o7nIA0t2FCwmy475u5nJ667S8fZxw2mpD7esXhGvg4JZjiBxcIltvbvucIv1b76kA5CcBhvbsfABCWTdBweqSvV19H0a28KybDwy3v2LRJowFkjLQ77zbMYFsJIjXAoW/usxAQCykn4jVOBtbcZqBA1LVVJaq0kbPNW51map9hA2dUySQu/vYL/l5GeCA0ETtk5ZGvbxAhZ0dWumtE7uz25eqvDgApW9a87m9cmKgl7CRRGSg4UXb8/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGOkS1VxZDUH82HJzxWuRDjKQkdLoboiLm3OwCOS/vU=;
 b=OBkepZqAt8qy7PzLGG4ojM1NQENDgFD4Phx/IZevMtPD0wLviHojvsssNKFN6Lq34Mv56h+gaimwW/WZ4Snp2rB+l/2KHVr26VK5/KsKwbYrH9pEvq8s6EGCw1RpOwdFYgtDSpAvUucOoo0YpqulC2LBfABFWeBZ55jcnXRJ3IE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4583.namprd12.prod.outlook.com (2603:10b6:208:26e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 20:14:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 20:14:41 +0000
Message-ID: <f878b188-3fe4-420c-9bcb-b431ac6088dd@amd.com>
Date:   Mon, 6 Nov 2023 14:14:39 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux kernel regressions list <regressions@lists.linux.dev>,
        o-takashi@sakamocchi.jp
Cc:     a.mark.broadworth@gmail.com, matthias.schrumpf@freenet.de,
        LKML <linux-kernel@vger.kernel.org>, aros@gmx.com,
        bagasdotme@gmail.com
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: Regression from dcadfd7f7c74ef9ee415e072a19bdf6c085159eb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0157.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4583:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac917a5-3b5c-4540-1787-08dbdf0502c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4cGAFp9t+fOCBtRJAKl3XQpBsjjwIkgGLrX/uwGcbentaaKdaeIkv1e13Auk8RZ+yMs3eY9jidP9ta3c7DriYGn621c9PQVslUGXCZNZ8xKX9GfFvrhzYF/O729m0BEdnvlxeB3Uc3MrkZ4/wcyIe7T6mJV0ndDqtxdnuxgp+JmtyZ1TbqZeWJ2gv/LwacJLzISZ6FaSPjxT4RxLoK/A/GfyvAvyGaEZStCZU5yMGoNXuXt8DtqrosKN9tngrU3XR7DJzSfLh5jiA22i8QC4e1lr/YFeq3Xs3wd6lDoBCGAoc2UwRUT/RfASzIweOD/BgwAhmTJGcZw+JOdr8J5EmolWFvRz0ycZmcnbzhbzgzuFo1JV16BA4Zrf99WbJ+L+dvPN0tXh8kQcgJffPBk8wnOj8+cqSwB59QA+tDFPGhxTJ61ak9w1o4zFu+pApt8/TAWRv3rfn9AsDuOI/vGm5bjlEZDbzlJLaZKVtAh10cEZxR2TfflXt7iemNpGvNjoJ1bWX/wLANBDFNDAcc20kd6lQCQHT68xS2Q1n5hwqduUFNHLWUiaRpiwgnUe59GOmB6VGrjJoIPottyl2CADZ6MaATD09LAB3mfTUrDpkCpTNrY+XkbSwNBrpCQPQsd2QzXBlxpueQUU0oUKuof0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(36756003)(316002)(4326008)(7116003)(8936002)(8676002)(4744005)(83380400001)(26005)(66476007)(66946007)(66556008)(5660300002)(44832011)(41300700001)(478600001)(966005)(6486002)(6512007)(6506007)(2616005)(31686004)(2906002)(86362001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjRNUHVNWUlFMUk3b1dnTGdyYVF4eW15NEVkTk45OXA3anRQYTFVcVB5RHZR?=
 =?utf-8?B?TXRTTWN6ajkzRlNSWG1GL1RDMCtMQ3R4a2ttRnFzVEZTTURmTEgzamFoTXdu?=
 =?utf-8?B?SEFXQkMxT3Evd3RZQmJaTjdnSVh2REJ6V0RGM2ZkK0hWYTBXSkx4ZmdFWUE2?=
 =?utf-8?B?Y0VoOGhtdTJic05DWXM1VXliaFRXN0FkcXFGS3gyRVprdzZYSUJWR0hKRitL?=
 =?utf-8?B?am9OMVVsTmZSSGtja1d3MGZJSnNXQnVjS3FKVTFNaFQ3SmJQWTd0dnEvcHFz?=
 =?utf-8?B?MjJZSjB5cTlQVjNVWU1CZEJPU1ovUEdoMHBUSHUxaTVaUXROYXU2ZUwzN0p1?=
 =?utf-8?B?YXhzaWFjUmJseGlNMDRoSXdhZHAzZktmdm44WnVaQTZUdEUzMU5EMXJRVTVR?=
 =?utf-8?B?N3FwRmZtTVhvaHVlc1JiWjhkVkk1SGNDelozUkptUmJOaE1lYmZzZmdNK2py?=
 =?utf-8?B?Q25aRGdrOEZlbWdCcU1LN0JEc2JLMENmQ09GTFF4bm5VbFJBMDk5VkovVUYy?=
 =?utf-8?B?L3JTbXc3WE9FZjM5WFRpd29XS1laOCtidDBsMkxFalpaeDBXcGpTTlJxa3BF?=
 =?utf-8?B?UW9EQ0U5SmwrTm9saDBTTG9HelpiQ3ZvUFhodmZBZ1pBS3VIdlVMaUJqOS9x?=
 =?utf-8?B?Z2ZhNDlSQ29hSGFQcFhKRkZ2aFgxckVkUXN3UVZuU3JQRVllamp2Z1NYdVJ2?=
 =?utf-8?B?SkJ2bjdJUUxZdytlUkd1RkhTMVBpTlljOFM2NW9NRWpFaHRFN0NFQlZHWGZ3?=
 =?utf-8?B?Tnc1YXJ6RjNCUFlNZVcveFJaMkhlYjNmVTVibnA2TlZBRTlzdWFlNWc4YmtK?=
 =?utf-8?B?YWRKR3Y2RW01SVluZUs1cjkyK1VFVTByOGU2Z1FCNkJoeFJFdzdlVTJtaFhG?=
 =?utf-8?B?Tyt3cXRnSkx1T3ZWajM1ZDVGQVpqR2FxMHMyVWlCbGJxSUQzWk02QXJjTGNE?=
 =?utf-8?B?R29lYlJnSGRNUDBZZzFqTml0U1hqL2wvbGYzYURnZWJrYkNmcHNoVDU5czdD?=
 =?utf-8?B?ZWhiMXZMYnBacEwyd0ZuM2xDempyVDF2WDlVUW1VLzVtRUJsM0YyZEttTjg1?=
 =?utf-8?B?THJtSVAyL0hXZ3MrOW4xZVg1aWhVaXhnMjBXaGlZNVNKRVEvNHc0UUxFZURR?=
 =?utf-8?B?REpxdzFxMCt0Mzk4cC9RTDRUMldQbUZBRWUyZmxZcXJOalpNVGtTRjN1R2NP?=
 =?utf-8?B?dnhFMjdzM0w3LytpZXFleTBEdSs5MG5wbEFIbjM3Mzl6b3dKbXZiZkxzTE1s?=
 =?utf-8?B?ZWRUUmxuWW82czYyOXpYWjc5Wm4vZWIrcEYzTnVjYlZQbjNTNmhlQUMrQWtj?=
 =?utf-8?B?TlptL2NRTE5zNU45M0srbXh3bXkvQkNDOG9Ob0lLL2l2dFpHTGdHTmJSc3By?=
 =?utf-8?B?ek9veW9KUWZtQ3J4Wm5NaDNQTWJBTkNVYlZLWVkwcGRteXA3YVhJb29nWm1W?=
 =?utf-8?B?YXFZMlpzdTAvTnhEbnhVZjBXcitkWkdzbitueDFDRUVVR2RQOThnK0x5Z1k4?=
 =?utf-8?B?YzBHVzRLMHlOY2NaYkZYOUJ5NUdiRkdlNUhKSFNvZ3EyNXJPZ2hkVHdoa3dO?=
 =?utf-8?B?OEFiU1ZvZlhpSVhjQ2xqSUxJaDdhTk9mc05ZancycklEcUhvUndJS1IwOGw5?=
 =?utf-8?B?R2hiQmZaQWpWdXM1OUNMUUJKUCtGMnVMMzErNCthUnZCVFQ2cm1hYWtUSVB1?=
 =?utf-8?B?T2pneXNKNXovSWJHT0s5dWFtbmU2QlVYYlhGTXY2Ry9iVXNaYmFKR092bVhV?=
 =?utf-8?B?Y0tDR2dudmk5Uml5WTUzQW9GcURac1R1QWtCYXNMRDNUNGsrRjc1R3EyVmhx?=
 =?utf-8?B?VmRrTnpScUxHM2M2TzF1S21uMXlURHllZmI4eHhJMHE3ZDZFcVA4K3JIc1dH?=
 =?utf-8?B?RlB2Z25GQkx5K2JpSFJRY2xRck5EbnpKS3VEaXQ4RW54SjFUQ3FGd3FhWW15?=
 =?utf-8?B?K3IreS9oemxxV0lvOGgzRUJmNllXQUIwOGdFb21HcE0zd3l4VGhJdzBQVWg5?=
 =?utf-8?B?NmlmVVVWZ3UrS01XNDZiNUx3cVNUQmNTSFdPZkpyNTRLU3lRQVpHbHRybjdT?=
 =?utf-8?B?SWxJUGE5WU5BRm5XeDVRY3NHeEltd0pJem1qL2VtUFdnUS9laCtVYktsbjYv?=
 =?utf-8?Q?IOBxPhWTn/dwKaDz5VSgAA6jr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac917a5-3b5c-4540-1787-08dbdf0502c4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 20:14:41.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rV/bEvhnC3Oq2/0wy/px9w25mDzt41edXgBTCFubnz+O3dU33g+DiJqK+I3Cv+9CVo4EDzqqUzVkNYotlVvzoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4583
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently came across a kernel bugzilla that bisected a boot problem 
[1] introduced in kernel 6.5 to this change.

commit dcadfd7f7c74ef9ee415e072a19bdf6c085159eb (HEAD -> dcadfd7f7c7)
Author: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date:   Tue May 30 08:12:40 2023 +0900

     firewire: core: use union for callback of transaction completion

Removing the firewire card from the system fixes it for both reporters 
(CC'ed)

As the author of this issue can you please take a look at it?

Thanks,

[1] https://bugzilla.kernel.org/show_bug.cgi?id=217993
