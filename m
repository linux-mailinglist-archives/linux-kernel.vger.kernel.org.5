Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8A17E199B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 06:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjKFFT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 00:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFFTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 00:19:54 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ADEFA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 21:19:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ic6sdnf/pEspxWYlbBVTiZycFMot/o0Yd6cwilnHMEOZfLQJp/McJy+lSAiz2vFHMLJrZTi3m/DiF/SU4F+3TbtLMHHntm0TayXaXHRbefpPxKPmaMcKWyzLzgRkEMBWcsTSyKyMIWBxGBrlG/6kRf2QxFqGZLdmNI6gAQvOb5WlVxaKP9xlyq8crWwJtOMWJBZoNnecpO6cwnEYo/GEBjMYJ+nOuwKe68m7arcmrJiX0KoLRQvwJ5rI8WhS9tWrJie7F+bLRmOM2oVzbedWuJVTYJrK4tume8M/+HrWB7tbldy987EAAELI610rHv0pSoBcS78Gz2znuJ0T5WcZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdFjAYveFc2LlGrADKMzb/qC20clBeXjZREca/WNuvA=;
 b=DHB9lc7GWWjL9zvTriihwaAdv2HAr4NCHBufVadx5O+II/5ZkYM4qoLT/OvtMbBk1/lZDtGhsxnXMdRbNq0F0dOLcoWYWjTRJ3xs4dtbFrcSeUat/viR2w8+EglCjPJR6U4LXWbdzXRs/NxQtSkQsh113EklpVkOK/nq3icGrPc8qyRWbaLQSYgiHCmqDGMaGzhz6ZiSgQfaiwegS88chSnmrQIt9puWd3BEK5hP48P9hyfYdGaMz+ElY+cx5U18g1ww/186BiSlnMHJGfMN7Hy2Angj0FtYGtWeWQoP5ndc1enarUlRpO1UHoCOBaNQ4uEULFLKEY/nZZ0p5hQrWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdFjAYveFc2LlGrADKMzb/qC20clBeXjZREca/WNuvA=;
 b=hJGCoG9/xAqgEBiWIsu7zxZdKfqpwOS/j+Itm6ZgY89QYk2lRR7ueVH17u781uTuY125ku3bQK5/AX4dHVLIPqBCJ+EsqZPEGQ8tPYYxcOjuKtfFkJKbotYz+P0cnJUnw+hWlxf09Oi2uUNkSE9ek27KjruRyL87SHDnwyM4+V8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 05:19:45 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 05:19:45 +0000
Message-ID: <75dfee2a-4b2f-49dd-a1c7-1cc3a9d8dad3@amd.com>
Date:   Sun, 5 Nov 2023 21:19:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/vdpa/pds/debugfs.c:269:49: warning: '%02d' directive
 output may be truncated writing between 2 and 11 bytes into a region of size
 6
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
References: <202311040109.RfgJoE7L-lkp@intel.com>
 <20231105075350-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From:   "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20231105075350-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR22CA0023.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::21) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BL3PR12MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: b42d1d15-3283-4582-abce-08dbde87fcdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywzEW0FsmI0w2flhTf0qOuU8eZlR4kPeo9lM8VzeQPNuvoZglBRdZ0R1XXtSje09o6SJVy5+wGxunRW+q/65YyXKGS4Q/34m0hs/9QO+ybwu5h04AvQKBhlVVvdX0m8Jn704ibUerX3wWc/JQGZ8HFwefd7lZdxkaGbjtPiY4zdFGwpHs4SskiE8n7Acsk6+w7UKOIsnyCTjN+iMyhef9qGk8jAWNW58gI5NdLdZHqqpuPssLwOJm31Kd9a/PIksGjY0CR9djV1BD5VEuub75w9wn574faPRuuwUrptjF+4Gyx7Hin+z+FkVp8IUh+Pj3LxNHMuWIhGv9wFm4Fxqcl2OXCrLg2XDHeY91DF8nnWpHGSUWiwh84oO5fyj03v28OxQKuQvnSI8ifZjBMQxoMSpHVdQXhj1zgx67X7HzjwkzaVG+EBNlZxLy7PnMY1sjALEtTWkdbit977APGeMGElw6dEpCDW4IN+O58SZbgVGSsa78rIFIq5z/P2JXdJu7yWdnwxGB1SyhBb31bSNIJFIl9dR3d5kSfWQcYHwMyW5/5veJy6bFvZ6XYWIVfTA6DDF0eH4zakRw/P71Qe3tyFzH2bA9dH7IOQkGU41DFXd2vXzCJsiMD5Euy9/qgbzxg+iiOa1kOthu/1ryOAiS8i1zd6zCmRAFwBdb9ROtz4EK3E9+xUU4hA5EfPyKDKIJj7+RgD+HcHonUHko14u9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799009)(186009)(64100799003)(451199024)(2906002)(41300700001)(478600001)(316002)(66476007)(66556008)(38100700002)(8936002)(110136005)(66946007)(4326008)(36756003)(8676002)(966005)(6486002)(31686004)(5660300002)(31696002)(86362001)(83380400001)(53546011)(6666004)(2616005)(6506007)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlZCZ3B4d0taVW1KQ0xSQy9DVEVGd3dNOEttLzh1enROWGZvRExYNnZmSG1D?=
 =?utf-8?B?ckROMTl0WEJKSGx3YlZ1SHN4RXhnMTBGZWtIY0t3TVZRcVpNNjlRUHNxTnZM?=
 =?utf-8?B?R2U0VTRqY2VRRUY1MXhnVjJydTYxamp6N0JDdzB0MFFkSEVaeVhRYWRVMnBP?=
 =?utf-8?B?eEhGczNlR25NSk9MZW93OGZ3NEpPbTF0dEU0N3ZGQnhrU3ZCNXNtcEF6MThQ?=
 =?utf-8?B?bHpLUk9XeE54djV0RW1GZ2t0TVBGYjVWcVB6VCtGUlBwN1RiNGo5UWpOSTQv?=
 =?utf-8?B?bm1aa3FGMWtaTzg3a0tvRnlheE5sQ0Zvd1M4WmlXL3M4dzUxMUMxbzBIdWpZ?=
 =?utf-8?B?WkdOWFhqWU1BN1VOL2lta1lWTXg4QmZTeGkzSG9Bd1lqd0pXQkZRZ01zVDNS?=
 =?utf-8?B?dHN4ZkF0YkRPbW1nc1BBVFVhcWF6cWpYR1IwbHExT1c3MmppSlV6NlgrZUhy?=
 =?utf-8?B?VUFPS09zcFM4ckFmN1Q5NXZXUEdTcVlKZkk3ekRzRjkyOGRoZnRHVGU4ZlJD?=
 =?utf-8?B?WFBmT2o2UG4wWTNwWHh0UzNKdU8vZGV0ZlNlSnEyVWFhMXIzMGZ1bVlqNDhX?=
 =?utf-8?B?TVNoMHVsWXdBR29wYlJvSWxpNUtjT3BreWJFTHRsOWtjYzRzYjR1VTRpUjZo?=
 =?utf-8?B?VmtHWUN2N3hiTXRtS2UwT0RhU2FDL1BoNmFXbENqSmlVbUNnRmkrNDVITDh1?=
 =?utf-8?B?a1MwaWFiRlp2QlF3YVV1eXF1N1VKUG1aaFh2YjZONmc2TngrSFVCQ0daNTVN?=
 =?utf-8?B?K2wwdUpzOGpCckZzVjNCRmhrZkZxWnpRMkpZY2hGbXdTMVloOTV6TWNMalRS?=
 =?utf-8?B?QW5DaVQ1QzRXbUhJdFRLQUtYbGtnVG40NlhLMnlhdjF2M3VMUVg3b0dUR0tG?=
 =?utf-8?B?NnpOcmdvMWc0YnlzZm9XKzBKMUNPL0NzMUhKOFAwKzlzbFVRZlVvSzFXRWpH?=
 =?utf-8?B?VEZQblpYOEZSQ0xLMGY0cVd2YzBzSHMrakhsckdTcEVCVEJwZjdpdHR0MC81?=
 =?utf-8?B?WFVkZlBZdWFRSnBIMFdzZkRIZGVOOVErbjNSTnYxVk5UYWM3R0krV1BPSHIz?=
 =?utf-8?B?VEFrL09PMU4zTTVablRPa0JTNWFGL1NXZDFQb1gzTStuMGphdGdsMzNwd3A1?=
 =?utf-8?B?M0lNQ0U2R0hpN2VVM3J0cnZxaEVpRFRSM2lFWUxXZU84OENWRHFrbEE0RjVK?=
 =?utf-8?B?THJoUEJWa1Y1TGxVYkh5dElqMzQrRUpjVzNlQy9ocnBwdVBGZ2lJMnpSQmRo?=
 =?utf-8?B?R1E0aDN6TmlwK0k1N0ZxWmc5WVFaQy9QZWlhY3ZOSjhiQ0JEUHNkS2VVRlZT?=
 =?utf-8?B?akd2YkR3NHd6YnFoeThscTgvRzNuQWQ5STJDZDMyQ2JqK0wxcnU1MlFpc1Yx?=
 =?utf-8?B?dHJGaGp3SEFlSnZsTnBFdDIyQk9IemR2eGNFR1QwOFEySVZnNU9DRVpMMUdX?=
 =?utf-8?B?K21Zc1BpVmtwNGpKKzNVc2w5U0ptYUdkOTBHRUZESTFZOGY2dnhEYWpwelFS?=
 =?utf-8?B?eFpLUTRnT0RXQzVXVmh3QXgwTUFzOTZXN1hhNytNTjVDazNzblF6U21GYnZn?=
 =?utf-8?B?bkVVU1dJb3YvRS9WbkR0Q2pkdktvRHk4U01IcUpKM1F0Q1FvWHpDclVnSnU4?=
 =?utf-8?B?MElHTXpldUJLcUF2RUhBUXRDbFczRUdSU1pNZk5Hd0JKbzNvZlVCTWxNb1dY?=
 =?utf-8?B?aytESzB1YkVWbFRHVDVsMG41U09ZU0dZcGNvWlN3TWZhY1RoUFd2ZEtNbkF2?=
 =?utf-8?B?dytZMURNRGxoSUZaN3RkUXdkdUd0RlVDL0NlNCtzOXMzaURaa2EyQ2tJSTd6?=
 =?utf-8?B?dmVmMFA5eEhBTlhLSnh1V0pGVmRpSjhMbVg2dXE0QndnMFFBM0VyNVpXWStm?=
 =?utf-8?B?eWJXcmw1eUhlWVRWcnNzQ1dJdlBzOGF0VG51SGpCSkZiYjAzYnFEZEFpVG4r?=
 =?utf-8?B?RDU2NjVUSEd2R0FiUXc1Ni9WbHQvT1lkbHJmbDJpbTNRb0NPM1E3ZVhwT24v?=
 =?utf-8?B?bUtiQXJBbTlqdHJZK1BjSVVuYkxRSTZuWTRnaU9SMk9VRUxYN1ZETkN1KzRL?=
 =?utf-8?B?bWRNc3AvRVkxeTFnbmw5YldiNFMwdHhzRWVZTFlUeU9pMlVxWmhxRTl6dnp6?=
 =?utf-8?Q?Evxy5904YJDrcH9IZNdDuxR6+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42d1d15-3283-4582-abce-08dbde87fcdf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 05:19:44.9234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kv20L/+uS4wt7HX81yaz205Sm24zi2x3l5gOoFV3tYlq09qaLYFSxXD45XPlYLe+niGS4BRIc/BeywzVDrqY4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/2023 4:57 AM, Michael S. Tsirkin wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Sat, Nov 04, 2023 at 01:36:05AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   8f6f76a6a29f36d2f3e4510d0bde5046672f6924
>> commit: 9a8864d2a8dc5c49acd66284fd382871d99b5db8 pds_vdpa: pds_vdps.rst and Kconfig
>> date:   4 months ago
>> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311040109.RfgJoE7L-lkp@intel.com/config)
>> compiler: alpha-linux-gcc (GCC) 13.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040109.RfgJoE7L-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202311040109.RfgJoE7L-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>     drivers/vdpa/pds/debugfs.c: In function 'pds_vdpa_debugfs_add_vdpadev':
>>>> drivers/vdpa/pds/debugfs.c:269:49: warning: '%02d' directive output may be truncated writing between 2 and 11 bytes into a region of size 6 [-Wformat-truncation=]
>>       269 |                 snprintf(name, sizeof(name), "vq%02d", i);
>>           |                                                 ^~~~
>>     drivers/vdpa/pds/debugfs.c:269:46: note: directive argument in the range [-2147483641, 254]
>>       269 |                 snprintf(name, sizeof(name), "vq%02d", i);
>>           |                                              ^~~~~~~~
>>     drivers/vdpa/pds/debugfs.c:269:17: note: 'snprintf' output between 5 and 14 bytes into a destination of size 8
>>       269 |                 snprintf(name, sizeof(name), "vq%02d", i);
>>           |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>>
>> vim +269 drivers/vdpa/pds/debugfs.c
> 
>> 151cc834f3ddafe Shannon Nelson 2023-05-19  259
>> 151cc834f3ddafe Shannon Nelson 2023-05-19  260  void pds_vdpa_debugfs_add_vdpadev(struct pds_vdpa_aux *vdpa_aux)
>> 151cc834f3ddafe Shannon Nelson 2023-05-19  261  {
>> 151cc834f3ddafe Shannon Nelson 2023-05-19  262        int i;
>> 151cc834f3ddafe Shannon Nelson 2023-05-19  263
>> 151cc834f3ddafe Shannon Nelson 2023-05-19  264        debugfs_create_file("config", 0400, vdpa_aux->dentry, vdpa_aux->pdsv, &config_fops);
>> 151cc834f3ddafe Shannon Nelson 2023-05-19  265
>> 151cc834f3ddafe Shannon Nelson 2023-05-19  266        for (i = 0; i < vdpa_aux->pdsv->num_vqs; i++) {
>> 151cc834f3ddafe Shannon Nelson 2023-05-19  267                char name[8];
>> 151cc834f3ddafe Shannon Nelson 2023-05-19  268
>> 151cc834f3ddafe Shannon Nelson 2023-05-19 @269                snprintf(name, sizeof(name), "vq%02d", i);
>> 151cc834f3ddafe Shannon Nelson 2023-05-19  270                debugfs_create_file(name, 0400, vdpa_aux->dentry,
>> 151cc834f3ddafe Shannon Nelson 2023-05-19  271                                    &vdpa_aux->pdsv->vqs[i], &vq_fops);
>> 151cc834f3ddafe Shannon Nelson 2023-05-19  272        }
>> 151cc834f3ddafe Shannon Nelson 2023-05-19  273  }
>> 151cc834f3ddafe Shannon Nelson 2023-05-19  274
> 
> 
> So gcc can't figure out that i is positive in this loop :(
> 
> Let's make it unsigned I guess? Should calm it down.
> 
> Shannon could you send a patch please?

Yes, I've been a little snowed under the last couple of weeks, but will 
try to get to this and a couple other similar complaints in the next 
week or so.

sln


> 
>>
>> :::::: The code at line 269 was first introduced by commit
>> :::::: 151cc834f3ddafec869269fe48036460d920d08a pds_vdpa: add support for vdpa and vdpamgmt interfaces
>>
>> :::::: TO: Shannon Nelson <shannon.nelson@amd.com>
>> :::::: CC: Michael S. Tsirkin <mst@redhat.com>
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
> 
