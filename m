Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABA27AA7AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjIVEWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjIVEWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:22:02 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E932196
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 21:21:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=am9bMpySOTgB6Wp4C0edmEZqG9ozeMYsc0XC3iSiA2nPBMTeb7+50VCheLnyJ5KmmVdRxkh1l+lYq13Ewa5BDujj7nuPlg0HZBhsP0qoV+cF2tyZTSKNW5xmEnCoa1eQNz85v0OfkGO+jDiucOaRyQ4LhMG4iVGd3Eb7y+ZqvIbweNWoxa3eZJigMECPqMj7Z3MC/EO4u7up9F7pb1B1ljJWO96I/jon9Pp8VnDrpcPBGUoo5nup0Q4jk0ZKzh95AgEuqf1+rlmZBgzf6vhRWEoff/VjiR+o9fuVKC+0/HJsIm6T2fG1bmUfBIDWtHlQjXIInPQqQZR/ef91h40SaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iv2+R80MbG1l8fLL2Z2qpOQpZSeMO27ySCl2IubrK/0=;
 b=fLiZ6AjUljMIwUb5d4ok7bwV3KIbPkaNirZQ5X8z6ScQilvCjkKKecZHNR9UUs4qQGOJW7Cr7lub1FO6t1u3pBb3Ia37d2ZSc6V3YX4sua0DdmAV+aihctDw+hPxuSVnuW6POies018Wig+048WJI0Q8OPNHDW0KfkQ5dyGABN+1bguZYn1AFNel40IfSZ6WH21V/cnNyWqAJ1c2avuFEmBUMPmX2lI7JGYY47F9PjXD+F5ar5iloaSMXUwe4fywqIgld0F6SOy6aX7ndSmkKVUaSBgkmf/FxM0+QFR9nBw8J3V+n/qIZ9dnr2aVFTPnlv6q4pr7+cmT8LrrRdargw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iv2+R80MbG1l8fLL2Z2qpOQpZSeMO27ySCl2IubrK/0=;
 b=EwtqF9NnDlZWL6jSMHd2JAi5Q6SZZ/jA+RbFLJR8m5mHa+UDtQKdDO69z/GOE+1coH/XhefoH4BwFPQfoNxskEBkJHmOiNPcqKjzb2C5YF3yFX4WQvgOV1luVkFn33BlTvkVz/ZoW6kEJBbiQAmOHlXAOu+2abs6babjBxkOWsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 04:21:54 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::16da:8b28:d454:ad5a]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::16da:8b28:d454:ad5a%3]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 04:21:53 +0000
Message-ID: <5a3f1772-15a8-4525-a323-801458247416@amd.com>
Date:   Fri, 22 Sep 2023 14:21:46 +1000
User-Agent: Mozilla Thunderbird
To:     Ard Biesheuvel <ardb@google.com>
Content-Language: en-US
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
From:   Alexey Kardashevskiy <aik@amd.com>
Subject: efi/unaccepted: Use ACPI reclaim memory for unaccepted memory table
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0116.namprd07.prod.outlook.com
 (2603:10b6:5:330::13) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a73abc-827d-4e5b-5e3a-08dbbb23731e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOZD1f1DQwpnERT64x7p6QmURH1q04gOFMRxVp/h4EaJI0LZeR/7mNxQx+F+xsgijFUqhs16ye+TNec8HipdLsL83GMwwkORXrlL3gQ2F6bv8iAkha5CpIn5NVmRgh+SmMoWmtVPNJ5C7cFCgfql1t8npc+g+xSLxCiwTGg32lc9BifJYZ7sldwNiK6vWJCW8q2r1XIj3weLD54Gzz8cwXqUTSZ3y9q57m6kGoqFEwN+c0R5kx5YmYVD173uqZfPCe1Htp624PnSVufAmYhuwyzmfz52YymgeiwfLXZx4K2ouIXODfI6sDp8DcwDZ8sGjUS5TyMcQTSIMzmRxMhFZWG+nFeuKBGtp/W+N4cgZkR3vmxHQTe83STg2Ck6o46gvrsGBTsvVABwp73Vxv4ZCHGimHoKmEVd4iB7B2wXgr2ZF2EhirwePRsLVIfW8vmnGlGC5Xl2VOrPaviYg1Sny03QEeahZO/CpohkHHTDWvPW0zM4XMxOv3aL35zRFAzrULCegocJK801d70MQRhkDUHmL74XD6xUY8Z8JT4ccOtd2sgJmLHDFAuAQLSHlXPn60SHBnfDKMGU72Fx/OjXfX+zsPnQRU0E46UKOzeNmGEvdP16QSqX20wW7BalaLZuPJY0eYMKsWqSDWVQy1m5Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199024)(1800799009)(186009)(8676002)(8936002)(478600001)(31686004)(66946007)(66556008)(66476007)(6512007)(6666004)(6506007)(6486002)(316002)(6916009)(31696002)(5660300002)(2616005)(36756003)(4326008)(38100700002)(2906002)(4744005)(26005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3lzVXlPQTc4QmlpbVJEY1NSU3RjNy9KdHdjT2N0NExPNjd4NnBKL0U4bGR1?=
 =?utf-8?B?UXdXanlCM1RJVmVxazlzUmNlODFxb3VZNDZSU3F2WWF2dE0zcm1aWENPdDUy?=
 =?utf-8?B?aXJ3N2YzN0YycldUMFRWUm9VNVNNelc4Y0l3MDViNFkrUVBJcXpKZjQweWRw?=
 =?utf-8?B?SU9naFhraXpyTU1QQWVRR2xacW80bVdsdXlaeTN1T0wyd2V1NVFKWWdwNkx0?=
 =?utf-8?B?cm9tdThRUkM3S0EyUDVKdEtqZnlNcFBweG1YVlJFQjc4Um5OS2FOUkhQNVdR?=
 =?utf-8?B?aEtaMVNrYkpaSFI4Q1lwR0U1RUd4UmhKVGo1QkhlQnFoNkdjV0Y3ZU1jTVhi?=
 =?utf-8?B?aDRLOTYxZ09pNG92eGN6ZjRMNXVkVVo2eXQzbXJIZnNhZXg0ZnAvUm9CdGRE?=
 =?utf-8?B?dGJiS3BEb2ZRb3p2RHBjS0tWQ09vSlBKOE9qaFhvSGhHbmErQytGNTBoYTRZ?=
 =?utf-8?B?dkw0Y1Mza0UwYWg5Uk0vZzR3Z1J5bnY4VSt1bWgydlJjZExQaHU0bzR2cCtw?=
 =?utf-8?B?ak1UQUtSc01yWGVwWndkV1BEaWFmL0FURlY0dGVqSEFZU1ZFRlhITHJnR2ZE?=
 =?utf-8?B?UklQSmc2a2V6cmtpa01PL3c3OTdaVUlpclZwWlY2REw5TDkzRy9VSHM1blpN?=
 =?utf-8?B?Y1FIUktwRlJ1alhFT2JVZDQza3RNU1NWanhHVzVRblAwS1Q3OEszSWZkM1hz?=
 =?utf-8?B?V3BpWEhYN3dRT0x4OElBV1JjMlJ0d2hScGFnRGRqSjIzdlpiWDVXOWpybG9n?=
 =?utf-8?B?N1pRazlVOFM3K3JodGtXSEtkNEpNMzcxeDlGYmxRZWVWL1dLT1A1cFNuUXV1?=
 =?utf-8?B?RzJnSzd0ZHBTcEI2QmhJdUsxU1ZBL0xSNGNVcWxPM0RVb0VBUkQ3RDEza1pY?=
 =?utf-8?B?SmdXVDR5NmE0QXNJZ2p2UWtGbHlXRmI1L216QnpjM20zV1ArYnhOMlEycEFY?=
 =?utf-8?B?MW1OZStQOTAzRFRpMXEwWTlselpVUE1PbDVZS0pSQTNCM3l5YzluTHJxTXVJ?=
 =?utf-8?B?YWp2N0I4djFoMmQ2N0diVzhnU3BwckYwRnhsVmp3TGRNdkh5c29jeExjWmJR?=
 =?utf-8?B?Y2F6b3BuK2cvb0VJdEdYUkZNVkh2SGlROHhLQitNekJQcFBFYUhDUWxxVFl2?=
 =?utf-8?B?MXdEWjNERWxWYkt5bmh1TXhmQ2FnQU1jZTR4Zkt3MVdXUTUvQ3dVWDVBdkxj?=
 =?utf-8?B?bjNiZk50MUcwWW9rckxtRHIrS0xFcmpiT3NiaE01S3VEcDgvM08zV0NtVmJS?=
 =?utf-8?B?ODV3VklKc1JqY1hqSlJZNFFYSUt0dCtFMGtjRmlGc2x4OEtROEZVSVdZdTBw?=
 =?utf-8?B?SVlrZ2ZzT2lkMEFRY01CR1RHeWpFOFM3Sk5OVEJha2tLOXlwaDlnVDhONTlM?=
 =?utf-8?B?MGQ1VG1IcDR2MHFhdnpiUGZWdFU1azJSYlV5R2pnWDRoSVhHVDZzSi8xUWky?=
 =?utf-8?B?c1ozU0VhYytVTzJJRjFZclVWckpFb3k2ZXhvVXdZVzZteGtqSGxQSTEvTk9Y?=
 =?utf-8?B?NVZBTytIcnVKYTM2d1QyQWxaVU1MMkZDYnVGVS94TTNkL1V1V01KN05iNXRR?=
 =?utf-8?B?WDE1cGVWOGRJRTc2S0s3c1NacHpOYTdDMWRHWXU5Y2JNOERBTEk3NDFTRFJi?=
 =?utf-8?B?NnRqL2hZYldpbi9WaFdDOTBNMVVIK2c5cWcwUU9rUUlqZm1HNXdkdC82Ymlx?=
 =?utf-8?B?YmRhTkZ2bjlDTW5mYU1xTzNlVXY2eTdBd2NVVVdkK0ZOOWVuVERxWXFWTXdP?=
 =?utf-8?B?UzVlQTNpVFoydURza1Y4NVg3TlFPdWdKRXpTeUVydTRQZU00UEgvMWpxQSt1?=
 =?utf-8?B?eGkzSWJlZlpwdTVSTGJTOERGRUt0QnFyN1k5WjFSUnYvNDBuaUQwMWs0cDNW?=
 =?utf-8?B?OFI0UC9xSnZwNVd5TU1sd3B6bzRKSEl0ekIrNlpMS21QcC9Oajcvbko0ZXds?=
 =?utf-8?B?M2l5WXUxWjNXSlRnWUZLT0hhdHh4c2pKQXA1QzBlY3dndnl6azFWdmhzVDI5?=
 =?utf-8?B?VEV5am9oVG1TVlFmQk8xUzNERVpkcGF0N25hRlBQSEJ4TzBlWDZ3TTJOWEla?=
 =?utf-8?B?c3ppQnhTdTZuOUNqOTNyNThkc0d1eTF4Q0EybVRpeFdsaXR2ZjFudys0Z0VN?=
 =?utf-8?Q?hiUHxlnqE9xJeba32e10sgFrX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a73abc-827d-4e5b-5e3a-08dbbb23731e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 04:21:53.4349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xadPvwWZ26f56f2SCQIztO1MX8DB3RFfGYT8++3IpuvPv4JSXCa/RbnraDL90tgRlqNaOaLFd8YPKcpmtES1/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

e7761d827e99919c3 broke SNP guests on AMD systems, does not boot and 
QEMU exits.

===
commit e7761d827e99919c32400056a884e481ef008ec4 (refs/bisect/bad)
Author:     Ard Biesheuvel <ardb@kernel.org>
AuthorDate: Wed Aug 16 21:05:57 2023 +0200

     efi/unaccepted: Use ACPI reclaim memory for unaccepted memory table
===

Is there a fix for that?

Also, out of curiosity - where was the patch originally posted? I could 
not find it anywhere on nntp.lore.kernel.org to reply to it. Thanks,

-- 
Alexey


