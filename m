Return-Path: <linux-kernel+bounces-22048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0761829869
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A10B263C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6678E46BA6;
	Wed, 10 Jan 2024 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u1B7C+NU"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEF84779D;
	Wed, 10 Jan 2024 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1yQz8C5o70ngS533PKxBMim7nYWY3qJHDwDubzAS0yirbGJ9iUQChJdHEMDSAnBjkcp4qVi4GkSVxdYOMHvuUd5xrGCelUgwXesw77lOLtQOnuRXDQ9DmLpQ400rWm5htLll9dF31j/X5XEnt3KYarw5N2TOhWNPkmVdx7rc8s7qlFeoEQnV45e2PMrajItiUlk7OBIQGK+uIUh3alzqIk4ukE4NM40+l/ubwUeBoRwgUpGGy/Ngpi0PNwOj1zRkSSc97PR5/A7mZNdeJ+/WCU8B061oTGWpRPRTd3xDWMBggvXAq40LXU8I8wgiOJAApi201DI6JSzogr45Ho7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnHbpm8zMw5OXqK2gaBWogCXjikCwWL0RuBOsVuOaNQ=;
 b=l4GU1I/aZsPt0dXmVSqEXLXFgulid+TyidyeRdj02xeoO9MkuDp26PsBHMuySJ5weF6MfPHWZT4jr8JUZv+QUM50y2V1g9I4gPikD87bs8vF+FalEv1NeK5YsZI3yfWaZ0yIBTF+NGjSsnAp+B0uQpm9RFaDy2X9HeFMESxTwF97KOJjzJwZ+YV3t7TRa75XPwUN41Yhm+rTuDo9dQVavyt1+PuY7L81cAzDRC/Djy16uMT5hwFMrO7/BmXNiEBHR8uZTNsIqJZkwRJdq1X8zAsM8g6Ozz9wNLA/Wn0hADu1sjErUVGsCJuEFYLOjjlDP9kAsd2AGv6lkE9xN9PHkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnHbpm8zMw5OXqK2gaBWogCXjikCwWL0RuBOsVuOaNQ=;
 b=u1B7C+NUehyjfxTG6h8rYR+19blxvYkoTIjRdaWSzltcYlJEmbhTP4WzMC56jeV7Gt2/jmAKCxRWsYZLyrVyWGPtItNjmXY8x/WYdjgUT9c+VL4o+RzgvSBK0JhbwSoeOoZkVOFh7wqEx6Cn7wxQHibmruYuyEmaPJ5k718aVIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 11:11:29 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::6205:5d13:e769:5b0d]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::6205:5d13:e769:5b0d%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 11:11:29 +0000
Message-ID: <f184a2d6-7892-4e43-a0cd-cab638c3d5c2@amd.com>
Date: Wed, 10 Jan 2024 16:41:18 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Shukla, Santosh" <Santosh.Shukla@amd.com>,
 "Narayan, Ananth" <Ananth.Narayan@amd.com>,
 raghavendra.kodsarathimmappa@amd.com, koverstreet@google.com,
 paulmck@kernel.org, boqun.feng@gmail.com, vinicius.gomes@intel.com,
 mjguzik@gmail.com
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [RFC 0/9] Nginx refcount scalability issue with Apparmor enabled and
 potential solutions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::17) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b65378-c3ba-4b51-d919-08dc11cce4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6VyberkCST42xBVcptfNwNFpRtOfhRSeJNMnUotUOOb54dd9gm9O75U/4hhMulr72VDDNX/LHnHLYX+mSXMwN6peLeZl7pT/nQ5nTvbHeT+dSGxGQKctVPuGFKWbMHju60HVzTTScBvQ4KiF4JatkDBQiwwxGxYwCR5ls2ZIe+vn/fD/2DTXCfj63HtGH3C827y329Gwwkcbrvu0p/wMiYUkUvz4RuOleZuZMZaDNsVzQIdmdUVUl3XWpjbIHDhYGfybdvSkHU89T1/CZZUJvDSZFzq6/AwyToCld1h2C10RvcDZcesVIf1S7U993L9041laWQc+HmsExT2/l5G48cvOZBWdZLCVuPJXb0pV2pbNyngQdCnzzRRoF2FYxhzevR1947HeVCXSlocbeQk0rLLL2xJ9Krim8u+UqP2L9f8yTB/PecUcMzQH+rBtVO6juwDEkQWrp/tTl/dljHkQyNgPJRLe/avw0xNC4cgDM1t6A36w4R6Mibyuwel/VKBc1APXinTe0dU30z2/vwZlUWf9Ra3AJeiKHBgqoHcq5HF+Nty+JL8G+9e1Ouw5JQfJUKbKkh/BZ919/fefrwN61GKvyPxzM4bf1Xwd7j73kedjA3di5dxz5LG7J5rAe0Ix3unFMyDEC/Vn/6UFywnRDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(478600001)(38100700002)(6506007)(316002)(54906003)(66476007)(6486002)(31686004)(31696002)(86362001)(2616005)(6666004)(26005)(83380400001)(66556008)(66946007)(6512007)(8936002)(8676002)(5660300002)(7416002)(30864003)(36756003)(4326008)(41300700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFNxNVRFN3NKQTJLRHNpUFN3S3hRamhNSkplTEJzcHFZYzFNZ1NTU3M4aEtF?=
 =?utf-8?B?WXY5STRIQ0xVdnFyOFBRVGVUbStWd0VidTJpcHBOMWJjNURpYzFuYWZMSXpp?=
 =?utf-8?B?dFh1WnA4eTlZUEJ6blVhZHZVQWNoUVVXZDZORkxyRzVmZ1RtZjdvZjJzYmVI?=
 =?utf-8?B?SytVb0phbjlPQzF1eTB5YU5JcEpieEErbUNzRkJCY0pLTkFtQmdYaktrZEJw?=
 =?utf-8?B?VHM4Z05oWGx1UDVxUUtESGVKc01SQStJN0cyS0x0L2hENTdlYkNZbzBrSW9u?=
 =?utf-8?B?SW0xMStWc3dxRm9ZT1paN3JDTTd0ODUyUjJFZ0o2TXpFdWhvV3Y0aEMxNjc4?=
 =?utf-8?B?N295NHl4RzN6Mk5obGNJQm1OY2lQZW5pNG1rN2Mvcm42WnhoM3BNVXIwY3BJ?=
 =?utf-8?B?T203eDcva1JWMmVOalZoSDY3YXdoN0lrK3dMYlcxbGY1VjJlVEsrRUtVN2VJ?=
 =?utf-8?B?WmhTdVhCb1l4eHdvYU0rWU43OUtLYlA5cEpDVkMzbVpxWkcvTDh2SVRXNmJJ?=
 =?utf-8?B?Tlp5YnB6OWcxNGhwTlQ0VnJnVUlHcnFNSDV5bjVQakp0NTI0bWtrKzBPN1Yr?=
 =?utf-8?B?aFNtYU9WN2JYbkdMTEZKYU4rTDRVTXJmYTBZM09ieUJXU0tRbERiejF6RzhE?=
 =?utf-8?B?c1BaNTZmakQ4cmp1ZmI0UjJjODhla1I0TkEzeXN0VnZDb20rNk5IcXF5YjBC?=
 =?utf-8?B?OFliczE2K0RpN0M0Z0N3SUQxaGJ1R2duOTBTVC90MnQ5VGN0aEZZWWUzRVUr?=
 =?utf-8?B?L3RRWGlNNjArTlVaYnk1bXNZSDJ5bC9oREJtN25oVlVqUVdnZW9WYW0ySGd2?=
 =?utf-8?B?ZVVDVVZkRlUxWkpEc2FaRHRKQndRTW9yS2RPd0FhQVBSVTl4dWdVOFpEKzVk?=
 =?utf-8?B?NHoxZGJFRmx1V3YxNkExS3RXOWlBRnZpVlE2L211K1dHMHBnaTVsc3lyZkdV?=
 =?utf-8?B?K3BhbTFiQTloemVsQkZYWm12WVBPTWovKzJJRFRrOWJiclp2QzEvWVpBRVUr?=
 =?utf-8?B?THNtMFRXOXlYaVNEOTFpT0RtbUorUGlPelQ2aXp5dGhyZUVGc01XSTN6SzVv?=
 =?utf-8?B?Qllwbk1EOGdYREVqSmlJKys4QXNXK3NIakl4Y09Hb1FCVGEwa05ETXh0c1pz?=
 =?utf-8?B?b01yU3Fnak9KeEFNaEhHVExHQU0wd2F3VkJ0VTBBOHJvb1RHUDR3c3R0Q2dK?=
 =?utf-8?B?M2JHNXJZd1N3WVYrcXN5RFJjdDJyYXNTNjMwMld3cmVZOHBSN005VXpWMVFl?=
 =?utf-8?B?ZDBoNFJVKzVRLzZjdnY2bk1WbEtmWGJMeEptTVJlSEJGKzBKYksyaFhhQTVF?=
 =?utf-8?B?ektEKytDcks4aUtRTk9wN3ZxSXNHUzN1TlVTSHN2NUJoVjlmR2R1WlI0Nm9x?=
 =?utf-8?B?SEg5dm5Jby9KWWtjZTZsb3dmcS9ZRG8rY24zNUFIU05nRktGYWVEUDZnUXVo?=
 =?utf-8?B?UjU4elBTWko4UzVHK1BDWVlkSGF2b1BRbk5vN0xPVkQxbTFQTGl4N0RCLzQ1?=
 =?utf-8?B?QlliT0c4S0o2YWc3STB2RlFRMHZMVHZ3dUJhUkpoZ3Z5bHZoTkZCMmZhc3Vk?=
 =?utf-8?B?U0pVZE00ekl1MmpYZWlsZmRzcHg5Q0VZR1VwMHBSVnFOTmxLdVd4cWpzRDdG?=
 =?utf-8?B?WHk4d0ZQNmFCT09mUDVQeVd1ZGlvTjlQYktwMnkvN1dzWDRXbUc0SXM3bllp?=
 =?utf-8?B?UVRDcHRLbkZWamt2UEZ0TDZtMGhuNzJ1THl6MFVFdE5vYklmeG1Qdmt1bE9m?=
 =?utf-8?B?dWpiM0FiemNnQ0QwbVNqS1ZlUDc5dWxKV0d5OXdZczIza3h6R1MyaWljUnBT?=
 =?utf-8?B?SExCY2VMRWsxYlZIZ3QwNDY2TzdudzM3TXIvbWd1T0V0a3llaWY3YWNzcWh3?=
 =?utf-8?B?SmRDWHRLM2FCa0xpUC9CTEt2ZkU0YitFSjNJZld3WGUyUmhFbm9qcDBSNDli?=
 =?utf-8?B?YmhPUC80WldWRFk1ZEtNTHVWYUpXajRJMm1iSzNzMU11TW5MNlBjQzM2akFn?=
 =?utf-8?B?VkR0RzFLMUkwUlk3czBIODI4VmVBWUJudCsrNXdBaFFjUHF4Ulg5WlJ2WXk1?=
 =?utf-8?B?OFBvbHhSYmtkV2ZCS1NaNFRIWXZTNHRickVkdS9kZ1lGSVpHK3pDa3dqbE9V?=
 =?utf-8?Q?i5D4EH4MvWDVKCZ7fJBSZVxLz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b65378-c3ba-4b51-d919-08dc11cce4cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:11:29.0895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NK3eyHUU0UoP2lMqrywow7iBwRRIwJQ1R0LQOrIoIQCvfoAlSuWOIEy/G/gA2+rbhDq0+gjgtpdO4vJlTpl0ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286

Problem Statement
=================

Nginx performance testing with Apparmor enabled (with nginx
running in unconfined profile), on kernel versions 6.1 and 6.5
show significant drop in throughput scalability, when Nginx
workers are scaled to higher number of CPUs across various
L3 cache domains.

Below is one sample data on the throughput scalability loss,
based on results on AMD Zen4 system with 96 CPUs with SMT
core count 2; so, overall, 192 CPUs:

Config      Cache Domains     apparmor=off        apparmor=on
                             scaling eff (%)      scaling eff (%)
8C16T          1                  100%             100%
16C32T         2                   95%              94%
24C48T         3                   94%              93%
48C96T         6                   92%              88%
96C192T        12                  85%              68%

If we look at above data, there is a significant drop in
scaling efficiency, when we move to 96 CPUs/192 SMT threads.

Perf tool shows most of the contention coming from below
6.56%     nginx  [kernel.vmlinux]      [k] apparmor_current_getsecid_subj 
6.22%     nginx  [kernel.vmlinux]      [k] apparmor_file_open

The majority of the CPU cycles is found to be due to memory contention
in atomic_fetch_add and atomic_fetch_sub operations from kref_get() and
kref_put() operations on label.

Commit 2516fde1fa00 ("apparmor: Optimize retrieving current task secid"),
from 6.7 alleviates the issue to an extent, but not completely:

Config      Cache Domains     apparmor=on        apparmor=on (patched)
                             scaling eff (%)      scaling eff (%)
8C16T          1                  100%             100%
16C32T         2                   97%              93%
24C48T         3                   94%              92%
48C96T         6                   88%              88%
96C192T        12                  65%              79%

This adverse impact gets more pronounced when we move to >192 CPUs.
The memory contention and impact increases with high frequency label
update operations and labels are marked stale more frequently.


Label Refcount Management
=========================

Apparmor uses label objects (struct aa_label) to manage refcounts for
below set of objects:

- Applicable profiles
- Namespaces (unconfined profile)
- Other non-profile references

These label references are acquired on various apparmor lsm hooks,
on operations such as file open, task kill operations, socket bind,
and other file, socket, misc operations which use current task's cred,
when the label for the current cred, has been marked stale. This is
done to check these operations against the set of allowed operations
for the task performing them.

Use Percpu refcount for ref management?
=======================================

The ref put operations (percpu_ref_put()) in percpu refcount,
in active mode, do not check whether ref count has dropped to
0. The users of the percpu_ref need to explicitly invoke
a percpu_ref_kill() operation, to drop the initial reference,
at shutdown paths. After the percpu_ref_kill() operation, ref
switches to atomic mode and any new percpu_ref_put() operation
checks for the drop to 0 case and invokes the release operation
on that label.

Labels are marked stale is situations like profile removal,
profile updates. For a namespace, the unconfined label reference
is dropped when the namespace is destroyed. These points
are potential shutdown points for labels. However, killing
the percpu ref from these points has few issues:

- The label could still be referenced by tasks, which are
  still holding the reference to the now stale label.
  Killing the label ref while these operations are in progress
  will make all subsequent ref-put operations on the stale label
  to be atomic, which would still result in memory contention.
  Also, any new reference to the stale label, which is acquired
  with the elevated refcount will have atomic op contention.

- The label is marked stale using a non-atomic write operation.
  It is possible that new operations do not observe this flag
  and still reference it for quite some time.

- Explicitly tracking the shutdown points might not be maintainable
  at a per label granularity, as there can be various paths where
  label reference could get dropped, such as, before the label has
  gone live - object initialization error paths. Also, tracking
  the shutdown points for labels which reference other labels -
  subprofiles, merged labels requires careful analysis, and adds
  heavy burden on ensuring the memory contention is not introduced
  by these ref kill points.


Proposed Solution
=================

One potential solution to the refcount scalability problem is to
convert the label refcount to a percpu refcount, and manage
the initial reference from kworker context. The kworker
keeps an extra reference to the label and periodically scans
labels and release them if their refcount drops to 0.

Below is the sequence of operations, which shows the refcount
management with this approach:

1. During label initialization, the percpu ref is initialized in
   atomic mode. This is done to ensure that, for cases where the
   label hasn't gone live (->ns isn't assigned), mostly during
   initialization error paths.

2. Labels are switched to percpu mode at various points -
   when a label is added to labelset tree, when a unconfined profile
   has been assigned a namespace.

3. As part of the initial prototype, only the in tree labels
   are managed by the kworker. These labels are added to a lockless
   list. The unconfined labels invoke a percpu_ref_kill() operation
   when the namespace is destroyed.

4. The kworker does a periodic scan of all the labels in the
   llist. It does below sequence of operations:

   a. Enqueue a dummy node to mark the start of scan. This dummy
      node is used as start point of scan and ensures that we
      there is no additional synchronization required with new
      label node additions to the llist. Any new labels will
      be processed in next run of the kworker.

                      SCAN START PTR
                          |
                          v
      +----------+     +------+    +------+    +------+
      |          |     |      |    |      |    |      |
      |   head   ------> dummy|--->|label |--->| label|--->NULL
      |          |     | node |    |      |    |      |
      +----------+     +------+    +------+    +------+


      New label addition:

                            SCAN START PTR
                                 |
                                 v
      +----------+  +------+  +------+    +------+    +------+
      |          |  |      |  |      |    |      |    |      |
      |   head   |--> label|--> dummy|--->|label |--->| label|--->NULL
      |          |  |      |  | node |    |      |    |      |
      +----------+  +------+  +------+    +------+    +------+

    b. Traverse through the llist, starting from dummy->next.
       If the node is a dummy node, mark it free.
       If the node is a label node, do,

       i) Switch the label ref to atomic mode. The ref switch wait
          for the existing percpu_ref_get() and percpu_ref_put()
          operations to complete, by waiting for a RCU grace period.

          Once the switch is complete, from this point onwards, any
          percpu_ref_get(), percpu_ref_put() operations use
          atomic operations.

      ii) Drop the initial reference, which was taken while adding
          the label node to the llist.

     iii) Use a percpu_ref_tryget() increment operation on the
          ref, to see if we dropped the last ref count. if we
          dropped the last count, we remove the node from the llist.

          All of these operations are done inside a RCU critical
          section, to avoid race with the release operations,
          which can potentially trigger, as soon as we drop
          the initial ref count.

      iv) If we didn't drop the last ref, switch back the counter
          to percpu mode.

Using this approach, to move the atomic refcount manipulation out of the
contended paths, there is a significant scalability improvement seen on
nginx test, and scalability efficiency is close to apparmor-off case.

Config      Cache Domains     apparmor=on (percpuref)
                               scaling eff (%)
8C16T          1                  100%
16C32T         2                   96%
24C48T         3                   94%
48C96T         6                   93%
96C192T        12                  90%

Limitations
===========

1. Switching to percpu refcount increases memory size overhead, as
   percpu memory is allocated for all labels.

2. Deferring labels reclaim could potentially result in memory
   pressure, when there are high frequency of label update operations.

3. Percpu refcount uses call_rcu_hurry() to complete switch operations.
   These can impact energy efficiency, due to back to back hurry
   callbacks. Using deferrable workqueue partly mitigates this.
   However, deferring kworker can delay reclaims.

4. Back to back label switches can delay other percpu users, as
   there is a single global switch spinlock used by percpu refcount
   lib.

5. Long running kworker can delay other use cases like system suspend.
   This is mitigated using freezable workqueue and litming node
   scans to a max count.

6. There is a window where label operates is atomic mode, when its
   counter is being checked for zero. This can potentially result
   in high memory contention, during this window which spans RCU
   grace period (plus callback execution). For example, when
   scanning label corresponding to unconfined profile, all
   applications which use unconfined profile would be using
   atomic ref increment and decrement operations.

   There are a few apparoaches which were tried to mitigate this issue:

   a. At a lower time interval, check if scanned label's counter
      has changed since the start of label scan. If there is a change
      in count, terminate the switch to atomic mode. Below shows the
      apparoch using rcuwait.

      static void aa_label_switch_atomic_confirm(struct percpu_ref *label_ref)
      {
         WRITE_ONCE(aa_atomic_switch_complete, true);
         rcuwait_wake_up(&aa_reclaim_rcuwait);
      }

      rcuwait_init(&aa_reclaim_rcuwait);
      percpu_ref_switch_to_atomic(&label->count, aa_label_switch_atomic_confirm);

      atomic_count = percpu_ref_count_read(&label->count);
      do {
        rcuwait_wait_event_timeout(&aa_reclaim_rcuwait,
                           (switch_complete = READ_ONCE(aa_atomic_switch_complete)),
                           TASK_IDLE,
                           msecs_to_jiffies(5));
        if (percpu_ref_count_read(&label->count) != atomic_count)
                break;
       } while (!READ_ONCE(switch_complete));

       However, this approach does not work, as percpu refcount lib does not
       allow termination of an ongoing switch operation. Also, the counter
       can return to the original value with set of get() and put() operations
       before we check the current value.

   b. Approaches to notify the reclaim kworker from ref get and put operations
      can potentially disturb cache line state between the various CPU
      contexts, which are referncing the label, and can potentially impact
      scalability again.

   c. Swith the label to an immortal percpu ref, while the scan operates
      on the current counter. 

      Below is the sequence of operations to do this:

      1. Ensure that both immortal ref and label ref are in percpu mode.
         Reinit the immortal ref in percpu mode.

         Swap percpu and atomic counters of label refcount and immortal ref
	                          percpu-ref
      	                  +-------------------+                
      +-------+           |  percpu-ctr-addr1 |                
      | label | --------->|-------------------|    +----------------+ 
      +-------+           |   data            |--->| Atomic counter1| 
                          +-------------------+    +----------------+ 
      +-------+           +-------------------+                
      |ImmLbl |---------->|  percpu-ctr-addr2 |    +----------------+
      +-------+           |-------------------|--->| Atomic counter2|
                          |    data           |    +----------------+
                          +-------------------+                

          label ->percpu-ctr-addr  = percpu-ctr-addr2
          ImmLbl ->percpu-ctr-addr = percpu-ctr-addr1
          label ->data->count      = Atomic counter2
          ImmLbl ->data->count     = Atomic counter1
  
  
      2. Check the counters collected in immortal label, by switch it
         to atomic mode.

      3. If the count is 0, do,
         a. Switch immortal counter to percpu again, giving it an
            initial count of 1.
         b. Swap the label and immortal counters again. The immortal
            ref now has the counter values from new percpu ref get
            and get operations on the label ref, from the point
            when we did the initial swap operation.
         c. Transfer the percpu counts in immortal ref to atomic
            counter of label percpu refcount.
         d. Kill immortal ref, for reinit on next iteration.
         e. Switch label percpu ref to atomic mode.
         f. If the counter is 1, drop the initial ref.

       4. If the count is not 0, re-swap the counters.
          a. Switch immortal counter to percpu again, giving it an
             initial count of 1.
          b. Swap the label and immortal counters again. The immortal
             ref now has the counter values from new percpu ref get
             and get operations on the label ref, from the point
             when we did the initial swap operation.
          c. Transfer the percpu counts in immortal ref to atomic
             counter of label percpu refcount.
          d. Kill immortal ref, for reinit on next iteration.


          Using this approach, we ensure that, label ref users do not switch
          to atomic mode, while there are active references on the label.
          However, this approach requires multiple percpu ref mode switches
          and adds high overhead and complexity to the scanning code.

Extended/Future Work
====================

1. Look for ways to fix the limitations, as described in the "Limitations"
   section.

2. Generalize the approach to percpu rcuref, which is used for contexts
   where release path uses RCU grace period for release operations. Patch
   7 creates an initial prototype for this.

3. Explore hazard pointers for scalable refcounting of labels.

Highly appreciate any feedback/suggestions on the design approach.

The patches of this patchset introduce following changes:

1.      Documentation of Apparmor Refcount management.

2.      Switch labels to percpu refcount in atomic mode.

        Use percpu refcount for apparmor labels. Initial patch to init
        the percpu ref in atomic mode, to evaluate the potential
        impact of percpuref on top of kref based implementation.

3.      Switch unconfined namespaces refcount to percpu mode.

        Switch unconfined ns labels to percpu mode, and kill the
        initial refcount from namespace destroy path.

4.      Add infrastructure to reclaim percpu labels.

        Add a label reclaim infrastructure for labels which are
        in percpu mode, for managing their inital refcount.

5.      Switch intree labels to percpu mode.

        Use label reclaim infrastruture to manage intree labels.

6.      Initial prototype for optimizing ref switch.

        Prototype for reducing the time window when a label
        scan switches the label ref to atomic mode.

7.      percpu-rcuref: Add basic infrastructure.

        Prototype for Percpu refcounts for objects, which protect
        their object reclaims using RCU grace period.

8.      Switch labels to percpu rcurefcount in unmanaged mode.

        Use percpu rcuref for labels. Start with unmanaged/atomic
        mode.

9.      Switch unconfined and in tree labels to managed ref mode.

        Use percpu mode with manager worker for unconfined and intree
        labels.


------------------------------------------------------------------------

 b/Documentation/admin-guide/LSM/ApparmorRefcount.rst |  351 ++++++++++++++++++++++++++++++++++++++++++++++++++
 b/Documentation/admin-guide/LSM/index.rst            |    1
 b/Documentation/admin-guide/kernel-parameters.txt    |    8 +
 b/include/linux/percpu-rcurefcount.h                 |  115 ++++++++++++++++
 b/include/linux/percpu-refcount.h                    |    2
 b/lib/Makefile                                       |    2
 b/lib/percpu-rcurefcount.c                           |  336 +++++++++++++++++++++++++++++++++++++++++++++++
 b/lib/percpu-refcount.c                              |   93 +++++++++++++
 b/security/apparmor/include/label.h                  |   16 +-
 b/security/apparmor/include/policy.h                 |    8 -
 b/security/apparmor/include/policy_ns.h              |   24 +++
 b/security/apparmor/label.c                          |   11 +
 b/security/apparmor/lsm.c                            |  145 ++++++++++++++++++++
 b/security/apparmor/policy_ns.c                      |    6
 include/linux/percpu-refcount.h                      |    2
 lib/percpu-refcount.c                                |   93 -------------
 security/apparmor/include/label.h                    |   17 +-
 security/apparmor/include/policy.h                   |   56 +++----
 security/apparmor/include/policy_ns.h                |   24 ---
 security/apparmor/label.c                            |   11 -
 security/apparmor/lsm.c                              |  325 ++++++++++++----------------------------------
 security/apparmor/policy_ns.c                        |    8 -
 22 files changed, 1237 insertions(+), 417 deletions(-)

base-commit: ab27740f7665

