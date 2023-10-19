Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A5D7D00B9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345973AbjJSRgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbjJSRgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:36:02 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B0112A;
        Thu, 19 Oct 2023 10:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ5jhHVwebqR5s8GFDonxYVnlPx6uneC4DdlYEVTznzyanQnV5JXzTkjyjUoJK4VxAWJcoqKoIcK/1DTFWrp4KPPtPj2VYIlXfDU58tnrknU6jI28hoofE8662sRbW0cl+cgNnBgDhuKNk7pAlZ/kqreIkhWrSAzk9ZHlHuPnCDd5Vsb4/9c+SOmkV5AmYkooh/EUOCFu5JktgJhnDEevqCtBlzCx1uV/XoFMoXma1H3Flh2C5EH/OjP4ONjrQMa/svdqXzMQC27wHsUqI0SigQVf9OTAzAE4NGM6EbhVug5VjxTY68E2no9ZtDTzpszQbhZiyZVzqZtgANMs3eR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdJ8sHz/U4+/r3lPX6qob5ToTm9v1KjXj4YC9p+5/uk=;
 b=FrErkoeaNoU086WJVO4j9ytIkz0jftRyxVUaT99uk0o7H3E3qnPhQlMbXuxEsNKZOZf7yBIu42KA3+zX5b63cgKHrIRhcz0Qcmk6luet7YsJ6C0Mc3qC0iksnBJlneXLZ07aiu3l3mSwUNpGcfMSoPlD2mlOpMg3DelKk80L6GSi+iSM/wJnt3k3c4fl5aLSXQyrFFAS/hEc0RkxcISEiUlfN54blTulTYIT9JAyy4QIssEnllNwPQxAoNgyCJfHW6cbBJuz9rlr3T3aXMzNceObRnE5xII0RlpJ0mzlZ2jlQbPI9GbqT/6qvhxQ2vhY4In5PGjxQRSIoGjZW6GwdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdJ8sHz/U4+/r3lPX6qob5ToTm9v1KjXj4YC9p+5/uk=;
 b=XUr3d3JFxOeJbP+5DdxQVGGtIWQWpgccHSJLiO1tQ+D9uOXsjt4oYnqGNx0iFxOV9Pa52IfdZ29Zs+l/yI5GhjDaUlmTFHVxBEAefmCt36n20egraXMuCq+7EiujC9aEQd/Gj+QvqM+oEVKTjJJlzRqvGRPjNWUMjAMfAZIrF5nAwXjx+OFExXloTbbpuRRjn7ITYunP2U3r4nx+TmjHtBPDVSO2n5Lmz8mO1KOmUzlaY37V+WIWDZqXakCdfPSCquBDikrk4iTGdenBAbxaBH16cFYAHe+hccBpn76rCG1gEEV98l8w5jqnlEdg0mZI/s70uFiH/73KhMkwtSVGyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:575::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 17:35:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 17:35:57 +0000
Message-ID: <c9e9207c-1fe9-4cc2-95cd-6cefd8ff1c3a@siemens.com>
Date:   Thu, 19 Oct 2023 19:35:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: vmlinux-gdb unable to parse_and_eval("hrtimer_resolution") on
 mainline
Content-Language: en-US
To:     aftermath digital <aftermath.digital0@gmail.com>,
        kbingham@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CADwTF6=b4wuC4ESVTZsAidDhxMj-A9RU6wOYShJcuhMKQFfVaw@mail.gmail.com>
Cc:     stable@vger.kernel.org
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CADwTF6=b4wuC4ESVTZsAidDhxMj-A9RU6wOYShJcuhMKQFfVaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:610:cc::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 62174230-88d6-4ff6-1540-08dbd0c9da3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7pieY9rISlreUr5r/nFG4zFpvDu6+5br/XV1C3zNkahR9V3WH20jwJOSXhqEqGb0Rt91i0SEbnV5g+ZdPRlfcBoEfeTN7z/X+dRrGAGPWfqe/maoWyIlq7yVAfwKWzSb39Opq8c6oO0CA8lOKgnOMa4IHgerJ9UEA4nloCB7ncRXKXZ3LnuBZUKSEVRzuJVnVubs2y/FbqIFXAfEXpYqybuQk8Y4QRZjxkdI0CphOsyBR1l28vFTcDvocOg231NElfLroz0/UEQNK5JngMLDFkbRmdaettaT0xaiZ/Jp8bIKnuK+xW7wDmwyEZhzP2r1uh2/thSVdxy7XtIoNvxK6KJnhhhPMvkUUv7YzS+imZ08U36DwK5mx+1X+dgan4vHQt02OhHFcCsSK5sTSvkt8GkJvO4JmwIJyRxmIlt9TNfB59KIeXu+LIs2h0R0wAHwaO4YHvu2PgiHmGagwIrKhPbLr4m7CxGwi/Lzk5OV+FTXYHEVHFZgtEe7NRbrLzHSQBVnI4BpE7JvhMIl3OyYUsc+mJXJjUfAvj5/Tb+ZjZeLpeubo5B56e9XtIbRilFLU8HcG2ySV9+jwWQrUfBUhyfTbcmSPW95RdLU5VDcE37ew1JBP2OyQyB8oYKz1Y8GJ1V5W8K2Uu09vVt13+2Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6666004)(36756003)(6506007)(53546011)(31686004)(6512007)(6486002)(478600001)(66946007)(110136005)(66476007)(316002)(26005)(83380400001)(2616005)(66556008)(41300700001)(38100700002)(44832011)(5660300002)(82960400001)(4326008)(8676002)(8936002)(2906002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG1tVmpxQXpIN2NjQ1pudnczOUZERWl1REFZYm92WUtzNTBBVEJsa0JJRTJz?=
 =?utf-8?B?ZDd0ckIvWStVT2hxSlovRW1lZXRidDBPMVMxUkpnMFNUdVJDaE5Od0FDNXBy?=
 =?utf-8?B?ekRVWWR6blVUUGtrczhQSGI2akFheEJKU05oRURJMjBRY0pGc3puZUNKUXIy?=
 =?utf-8?B?UVNacTFqTkFNYTJKZVhlWGtjeHZma0VIbUk0SDFPK2k0ems4aFNzR2crTDhh?=
 =?utf-8?B?Z1hLQnJrUE1qRWlFSE1wMStONk9EZXh6WEF0aWRDTW1BMGdDRlFMQzhFM1B0?=
 =?utf-8?B?NGhBNjhTWlUwcUppeHBrTEVKWU1JbUx5MW91ZTlZUmJQUmxyaFpYOHdhb2FJ?=
 =?utf-8?B?L29XK1NzeCtkYkU1TG9DMFVkY2VCbm00a2x0ckNpc3M0dWthbm90N2xkd2Va?=
 =?utf-8?B?TEE3bnJGQmx4Lzk3WHhUejJySU1oekhpamxqREcyajRHNXJYZjVZZi9iaVov?=
 =?utf-8?B?dzFxakwvVkp4dVFZTFpRNEl3eVlwWjdZdzJ3V3FHN1dLSjBpSWcyY21GL0Qy?=
 =?utf-8?B?RytDQm5hUGFKaXU2OTFHR1JUcTA5aWpRbG5ESTN2M3Z2SzV3d09IVEQyM2tk?=
 =?utf-8?B?a0gvMEpOZC9Tengzb3dhalJKQnZZYVNmWUllVGt2Z0VUdDE3TDJFcHhCeDk2?=
 =?utf-8?B?ZkhJMU5yNGFCYmxkdnIxUlY0V0JUYlo1TXFIMk82Qm5hSkVZZVFsdnFQTUp6?=
 =?utf-8?B?RmkyR0hHOFgzT3d2OXBXb3ZGaUVqb3dyUytlQlVUM05iVGJSSThudDZFRGJM?=
 =?utf-8?B?eGllL2xOM0lGTDRyUHV5Uk5qUVd1M3RvQTV4L21jUm9YeWdRSFZLeWxPQ3h2?=
 =?utf-8?B?OFpDaUs3cy9PcGZRdEg3K2RwQ2FwYkU4SmxhMis0eVE5cmFsSnQxa1JBTHIr?=
 =?utf-8?B?Tmh3Tk95aFZiTHhnbm9UNGF5aTJ6eW9rNUs5M3pIbUc3UFg2VjdNS0Y2eEE4?=
 =?utf-8?B?anpsdXZGOFNyY1psdTgvQjlxdmFFK1RRaW5Ib2NEZlAydEIwWmhGY1NlN080?=
 =?utf-8?B?b2VWU29tRjEvc0REanBWL2pjbGZSZHpmaXdqb0RvQ1hZUVhWdDZFUFVxSXAz?=
 =?utf-8?B?YTVaNWU1amtscTd5L2xBVXhTeGdKWUFYQUdKMmhlUnJvdDNCMjFjdnkxQ092?=
 =?utf-8?B?Rjc3aXVTamgrTzFGZXZuR1ErTG5xMElpeThRYVMrdGFVbmV6TE02aW5wQmhF?=
 =?utf-8?B?aU9pYVYrYTJ1ZTRZdXhNSmF4ajFENGdOZkpZbmFwNzVJaEVNRm9lQ1lJcnox?=
 =?utf-8?B?M1Fka21VbmRtMDV1VHk3Rml4aXJrdVpSNVFEc2lhbDdKWnNLdGNLT3RJWGk4?=
 =?utf-8?B?NlNmc2g2TWtjZW1qTUV0VVF5VTd6cTFtTW5uRi9rM043RjkrbmI2ZGdpWXBY?=
 =?utf-8?B?aU9IdEtKN1FsSUt6aGxPQ0l5Q2tMMjllTFdIczVOWUw5cElnUktlZHZlK3Rh?=
 =?utf-8?B?N2p5MnE4bFpaSUhQWk1OYTlxWC9pWG5Na3Y3SHpWbFJ3YUZWOTN0bFFIRnNu?=
 =?utf-8?B?RTJpUmN3Tnh6TUxBWUlna1dUbEpyaFMzVEg0Ym1uMUg3ZHNsR1hyQVUyTTRM?=
 =?utf-8?B?bkpYbEZTL3Y4VTd0MHZLTXR3c0Zuamc5UlZCUVRPVnh4a0ROc2pXQldiS3ly?=
 =?utf-8?B?UWp2bzJxak9xT0hGWlZkR1JTMkdDS3NvL3lJSVcrMDVZMUFLeEhJQy9Sckcw?=
 =?utf-8?B?bE9hYlBndXZKUUlYMjNPV25xWndQMTIxc29Wb25kOStnU0tEYTFHVWRVNXJa?=
 =?utf-8?B?TVhLNWphT2g1KzBKeW1valU0NmVyR0RsQ2dXd0M0dko3b0VOVkFwTzdlVUsz?=
 =?utf-8?B?cFdPekRlS0Y2Wk93N3dFb2JQSTBrOU5PWVJUMDRNMWxXTGMvWUpybHlDUUZa?=
 =?utf-8?B?QU1MQjlQRU0xQzdxZDJXbWlOdlhibCtxYU9MUEg0bHh4c1dRQ24xOXBGQUYv?=
 =?utf-8?B?ZUhHSzExOEpEWFJBdEljVTdzQkpCUG1vRGdDSy9pV0JZNEpEYXQwOWRGYlhM?=
 =?utf-8?B?WEdEa1lEN01IL3dpVWtTZktrcVF5QjJDcXl3UEppb3dwNVdWRHMzS3h0eE42?=
 =?utf-8?B?YVBDYnI5cHhWYWdxa3hERlU1dGRML3RvV1p2OGNJSFgxT0NDUm1oM3ZUNU1Y?=
 =?utf-8?B?S3pxdFQ3NG1WRFFCWUdjSG5BMEtzZGFsM3pncHJ3VkJEWTREYlFxbmhQbUtT?=
 =?utf-8?B?dGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62174230-88d6-4ff6-1540-08dbd0c9da3b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 17:35:57.3319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMlxFWr+M2uTCRs2GTxXsvVJilAMWgU9wfxFy63uwoWKc8VIjZNmTqkGX7Nh7X22ulQVZKmW1ESN+bZFXsoajA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6038
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.23 21:57, aftermath digital wrote:
> Hi,
> 
> I've tested the below on both linux-6.5.7 and mainline linux-6.6-rc6,
> both of which seem to have the same issue.
> 
> GDB 13.2 isn't able to load vmlinux-gdb.py as it throws the following:
> 
> Traceback (most recent call last):
>   File "/home/user/debug_kernel/linux-6.6-rc6/vmlinux-gdb.py", line
> 25, in <module>
>     import linux.constants
>   File "/home/user/debug_kernel/linux-6.6-rc6/scripts/gdb/linux/constants.py",
> line 11, in <module>
>     LX_hrtimer_resolution = gdb.parse_and_eval("hrtimer_resolution")
> gdb.error: 'hrtimer_resolution' has unknown type; cast it to its declared type
> 
> I've built-linux like so:
> 
> make defconfig
> scripts/config --disable SYSTEM_TRUSTED_KEYS
> scripts/config --disable SYSTEM_REVOCATION_KEYS
> scripts/config --set-str SYSTEM_TRUSTED_KEYS ""
> scripts/config -e CONFIG_DEBUG_INFO -e CONFIG_GDB_SCRIPTS -e
> CONFIG_FRAME_POINTER

I happen to run into this myself recently while upgrading a .config:
CONFIG_DEBUG_INFO is now selected by DEBUG_INFO_DWARF*. I've then turned
on DEBUG_INFO_DWARF5, and things worked again.

> make -j$(nproc)
> make scripts_gdb
> 
> $ gcc --version
> gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
> $ gdb --version
> GNU gdb (GDB) 13.2
> 
> This is my first time submitting a bug to the LK mailing list, please
> let me know if this format is not correct or if you need more
> information.
> 

Format is fine, just general linux-kernel@vger... reaches a broader
audience and is more appropriate for such a question.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

