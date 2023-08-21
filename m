Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6687830A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHUTCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjHUTCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:02:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515FB1995;
        Mon, 21 Aug 2023 12:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StveYZ/xG7M00odFlsYOQ2fZqyfc3Qg3joCrnq6qcrtZf0aTngS4Alvtkc/+GqKbaJTIYxtfyvFEniSlluaX/7LIw4tvsdbaEBdAM8UrU4Sf5ens+3XuZolvDA7rMaxdEdjnQBjpD4gb2x3A/CQHuNipffZSC0bkByXNlEwh046/ZEdd3JZrniRLyStCNW9xGjl4LgRRDuq8lMGG/ra34yV9RMiLIRxyvAavMzEpFQQb4TJYiDn7RZkdxwZf8+rXbXKRRXFW9sndJHZxLNeR5ybQPTx9ucvI+XX4d/peNVFzzDEEyKRx6183RnCMt/0yb6ljSAvkgehjoW9KZffz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwy4wdRHNws6NIpJ3vXpRR4j5Z4vsZw87jOamwaKnT8=;
 b=i164/w3yocFn4MBF/7kNr8AHChMJ1aI/5Q3uIUI0aJiylY9+accN1MNDCRb/QYWcJjGHG6pg3A7+MJzoS7eIJwp3rnqqnetqsJmIEAx4X1DD7uZwWWh0yPSv8pDLR2KZAvdiBvbwvyl1yOnyXPBmXGNAUaqh096mqf/qgdWsIN5G5ERrAyt+4Ghgwwxwgc43IR8n487IiU5pzIIBKVqKfwvRNKHSPBo0dT50+xklquS5KGiRFnRxwdEiaz1tlzynW5IM8r3oh1TFijKWp70xEkqMkf4530QiQGImpr8cxtoCENlG3DIwSDtheUyc5yO4vzGCpFr1Cjtpo5ld7Ov3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwy4wdRHNws6NIpJ3vXpRR4j5Z4vsZw87jOamwaKnT8=;
 b=Gkl8BTeyT1P53EgvaqIQQYMKUrglbTv9HTJxFPwOt2wulh23lrfYk61QlfJw0dcgaT0speeFLZItZ9CAtY9tE7t9RNPVFndISEf/ZPPUtjELrHSGg2GuzhKy5023NtVZEwEXB/Jzf7VfgP/d7T0PtaVRVtZK18ZJXtQO+5j0A7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 19:02:00 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 19:02:00 +0000
Message-ID: <fbc0b21d-33e6-4c32-bc34-3fbfe5e99b1f@amd.com>
Date:   Mon, 21 Aug 2023 15:01:57 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Avadhut Naik <avadnaik@amd.com>,
        "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Avadhut Naik <avadhut.naik@amd.com>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: PHAT: Add Platform Health Assessment Table support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230810234856.2580143-1-avadhut.naik@amd.com>
 <a0ab4d07-fb73-418b-b88d-c3ad6aa4cf49@intel.com>
 <655c916e-356c-03e3-6c67-aa40886dd5e2@amd.com>
 <CAJZ5v0j0R1GK=0z+LJd_PSh4zDv9Ydw2YA7HWm1R5wjCUsbbYQ@mail.gmail.com>
 <1c579c96-5010-4e5b-aa27-afb4f4f6746a@amd.com>
 <CAJZ5v0iPRCJLH5bkKyhjUq_tmjmR6R73fhUm3JnKptcm1cn9fQ@mail.gmail.com>
 <6bc15195-aa26-4e29-b625-74fca84f7a6f@amd.com>
 <CAJZ5v0jEcD_1+jHfAk9eN0YYJFbDZN2rZ97KHyH2-w6EqRN9+g@mail.gmail.com>
 <43b65307-bc3f-4014-9bf8-a96c6ed15d9b@amd.com>
 <CAJZ5v0g+uVZwoOr-2W19Ux9u-D=WiY=-dtcQZwYU0Ov_GE5d=w@mail.gmail.com>
 <CAJZ5v0g_DyQAnSuigBc-f0UNmW0mo=0yMadES+0NhphJs_k+cw@mail.gmail.com>
 <9d491dfe-13d8-4072-a90b-5f68107fcf95@amd.com>
 <CAJZ5v0jxKwtHM3vhtw44TW5=J916XvXSeP3DyNLcJDo+eTSRHw@mail.gmail.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <CAJZ5v0jxKwtHM3vhtw44TW5=J916XvXSeP3DyNLcJDo+eTSRHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0416.namprd03.prod.outlook.com
 (2603:10b6:408:111::31) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 0158cfbe-df32-44b5-a425-08dba279194a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: REcYGFaCaQZF6zIRP04mDUcFUxp+gg02kLD+97cOuX/b8q1WwYlS4HNjPAAnEFVzfTjkQDf8HZJSWdHjVYTpvHGfb4/V5OR0JfI9MLQQhMWS3RRBX7lf8c3CRd3w4QBVLydBJXh201FQW3UOqlxg8vFXzvGCyKb04io8Nx4xMzU5pvVz+TVZwV9Yj6pqx1LAKOcIwILNSvaTAu6AtoPJ8PSpKjD2QbK2DKDbdiQkuNj62cwYEWDoF4b8MTE2lYcAYo5U1fKUQFz2/H+ZWushMus4bhciZTM4hACKo6omBF9dypzw3CKbX8AY+gcoCjVaD/h8tUUtlcHmkHdef862r8Ocb8n4Rq+Bvd/Ua0CfrnPuKTxLyKJn38qT/4PasEq0QSNmG+97RlfHAYCpfKT0BPvx+Bp1qzJux28zmQCp/5UIAucmkMGtS8TXXGJyHhE70xJZ9h72ovnYDzgDGErJwCNLJZhZ1cI+YR7//BJL2EXZCRD7N3iQEKnW/cWO+P8K6iPq8dUOTrCvz8USpOsdyTRKQa/yeo//TKHbx0a3lJmYZH9TXFZLv9a6+oYTL/+TUAA0McZ/ui3pvVO3XGLkfpis9e7eY5UldDomMOZr1C9jbSTc7oorSovTOu6hF1uBqcwhwRY5vUTTIlluzhnwzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(2906002)(83380400001)(53546011)(6506007)(38100700002)(6486002)(5660300002)(44832011)(26005)(31696002)(86362001)(31686004)(8676002)(8936002)(2616005)(4326008)(6512007)(316002)(66476007)(6916009)(54906003)(66556008)(66946007)(478600001)(6666004)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUZOeFpVSFYzaTFHZ2wvV0ZDNS81U0dzaVpmc1E0ZGxDdmpIWU5ITUtvK1hH?=
 =?utf-8?B?UjcrazcyMlZaS01TRFB2VnU2cFY2YjBEckt5WnRiNXhLVUV4RS9ZMG4xT2xZ?=
 =?utf-8?B?R0pRNGUrUFIxc21WazVOamgvUUs5a2U2SDV1NTNwTGgyeVRkV3dCYk1FUk84?=
 =?utf-8?B?cy85N3lqR0lCQ0UvTE9nOHBMUWNnVmMyZ1VFN3BwUFZTS2FkdjNxVDR4ZFdt?=
 =?utf-8?B?MlpSN2VRK0dXcHQ1QjczNlhOZUxKNzR4dWdSWlpmNGFRbjhxS05Ka3JnQ1RB?=
 =?utf-8?B?cU1RVlhXckFYT0V2QklZWlg4ZUFkQVFBNllZbGFzTkZPVVVHdzFlL05rM0ND?=
 =?utf-8?B?eDRVWjZ6bnZWSGFEWmZkV202Si9hd21zUUpjbnNWcDhYeGJ3UlNXR25ib3N5?=
 =?utf-8?B?UWdONjkrYnUzYzJiWU1DV3MvMFJnU1paNGlScXBpS0dKRThCT24rVzdBQmJv?=
 =?utf-8?B?T1FHSlhkYTQvbUxIalFNN2ZUTzl3THIvZlZESXpxdnQrckJHY2VDTkE5b2M4?=
 =?utf-8?B?N1VKd0Jkcng5bHJTN2FkMkJtOXk5K1Zoa2JJUExkcXdrNFg3endLR3V0WEli?=
 =?utf-8?B?ZDFPdGl1UDJwSjk5NDhObS95ZlpiaTF5SFNBbHZ5bkwyNG56NUEwRXA5MkVM?=
 =?utf-8?B?UXdkaTBxWDBsdm1mbUcwdTNmdXZnNlpoU1E2T05GWVdVVGJ6VkRyd013YWRZ?=
 =?utf-8?B?b3VGYTIraUFVcU9PdUQvYmNOYUxPYStTc0FkNDNrMUlnamV2KzNCekljdzQ4?=
 =?utf-8?B?WVBVS3g5Z29RdTM5M21vR0c1YThxelZJVDNYc3hFbWVaMTYzNThEVERqTFBT?=
 =?utf-8?B?ZTZ5eVZuenZPY1lVd2tTemVVallobHorME5JZTdpTW1WK0dzMGs1YStJdEhG?=
 =?utf-8?B?YW82UE5ET0QzNjgvdStMZS9ZYXNFWHZ0Tjl2STBkS0dUOGZWV3BVMUNEN1Jp?=
 =?utf-8?B?ODU0MS9QSFNaM1hIcTFoR0NNcGo2aG5DVVBxMnBSa3VSTGRidjZJUzVqZWR0?=
 =?utf-8?B?ekV2SDZsdVI0OEN0R3JpRitkYnVuaDdGUHVjWTg3L0gxSnFOVVlQWmcxc1JD?=
 =?utf-8?B?R1ZhTTg2SEgrSW5zQXpzNThoN2daT0h6UER5RTZHQmtQN3lnaVFBV2JxVFlt?=
 =?utf-8?B?WGJMWXVkV0gzNXNhM3I4anh0YURjTlliVWVNSUxrY2tkckZyc1dMZWJOaFZ4?=
 =?utf-8?B?d09kWWxwUlNhejEyT00wQ3daNlBjdHNib3RCSkEzMXN0R09hOFU3VTNHTFgx?=
 =?utf-8?B?Y1M0S3ZZMERiMjY1NmJBNEhVTXUrSlR4WUNZVk1DaGdYYUQveG5IK2w2citE?=
 =?utf-8?B?ejgwT0RXRUYxS204QnBWVVZ4TzdZNVA3SkZyYmRhSEZYWFNTT293U0tYT0J1?=
 =?utf-8?B?eld5bERLZkFkd3FEVjBnOFpsRkVuT245SXlmaWhpVmxSb1FXNGYwSVJ0MEFq?=
 =?utf-8?B?ZGpxTExzaXI2QkZKQU8vOXhGVUJpbHYrbnFHVnNYQ29rLzA5TWdxZHI4cFAx?=
 =?utf-8?B?VmNmWGRZeDJTZVJraERmRkxUQnRrb3RGMTR0am5DdFlYemI3c2tUSEVDYjl2?=
 =?utf-8?B?VU9EamVVaHNNbzJLZDBaRUJ6citMcHh4SjRMK0tTUlVCYUxKYzB0ckxnZnJQ?=
 =?utf-8?B?bmo4alkwb0JtUVdXK3k5MFZ1VjVUT3FpRlF0cmhpSFVHdTRXMjZnYlFBOGdZ?=
 =?utf-8?B?Wkh0eS8wdDFCYzZTMU5CRFVMN0c4Zm5mdEpXd3BiMVhsR0tUQ2J2ZzQ5N1Rr?=
 =?utf-8?B?ZWpIU25IZXNDVjRtS3ZqbVFpVm9ma1RMOVlJeHYwVWxEU0drakJaSll2cWg2?=
 =?utf-8?B?aFBOajR2ekxtdUJOUjNucnlBb2Q0K1JUV1kwTjJUN0lFYW1IWmVKbXRvM3Bi?=
 =?utf-8?B?VytyRzAvbUVlakxjSmdlZTB6WS80dFpwWnE0RFAwVWRJbkFMdGFYTWsyTjFa?=
 =?utf-8?B?WUdueS8zN2x3QXBqcFQrUFFJMXE0bDZsUUhGM3JZQnlEdkZiV0tXTG9Vcnk1?=
 =?utf-8?B?YUZPbGpuS3BUWUZQSW9HZ2VFOTRFdnVmNi9BNk1vVTYwRHhQYlUvK1FlUHZ3?=
 =?utf-8?B?M1k1Njh1aVVwTzFtaWZ6MFVaMjNmbXRlR1QzZDdLSldxSEI1dXp5ZFcyWGRa?=
 =?utf-8?Q?eoTCvghBQnzB0ZkAyPTr5P9lA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0158cfbe-df32-44b5-a425-08dba279194a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 19:02:00.4647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9rLMuNdk+zFZrcVixvT0hn0sU7UTFNW4LO8PkbWp7RKAcnSjMUX7cs0gsmbhNQYZgMCQDTuY7tXzodMfqsh1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23 2:49 PM, Rafael J. Wysocki wrote:
> On Mon, Aug 21, 2023 at 8:44 PM Yazen Ghannam <yazen.ghannam@amd.com> wrote:
>>
>> On 8/21/23 2:01 PM, Rafael J. Wysocki wrote:
>>> On Mon, Aug 21, 2023 at 7:52 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>
>>>> On Mon, Aug 21, 2023 at 7:35 PM Limonciello, Mario
>>>> <mario.limonciello@amd.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 8/21/2023 12:29 PM, Rafael J. Wysocki wrote:
>>>>>> On Mon, Aug 21, 2023 at 7:17 PM Limonciello, Mario
>>>>>> <mario.limonciello@amd.com> wrote:
>>>>>>>
>>>>>>> On 8/21/2023 12:12 PM, Rafael J. Wysocki wrote:
>>>>>>> <snip>
>>>>>>>>> I was just talking to some colleagues about PHAT recently as well.
>>>>>>>>>
>>>>>>>>> The use case that jumps out is "system randomly rebooted while I was
>>>>>>>>> doing XYZ".  You don't know what happened, but you keep using your
>>>>>>>>> system.  Then it happens again.
>>>>>>>>>
>>>>>>>>> If the reason for the random reboot is captured to dmesg you can cross
>>>>>>>>> reference your journal from the next boot after any random reboot and
>>>>>>>>> get the reason for it.  If a user reports this to a Gitlab issue tracker
>>>>>>>>> or Bugzilla it can be helpful in establishing a pattern.
>>>>>>>>>
>>>>>>>>>>> The below location may be appropriate in that case:
>>>>>>>>>>> /sys/firmware/acpi/
>>>>>>>>>>
>>>>>>>>>> Yes, it may. >
>>>>>>>>>>> We already have FPDT and BGRT being exported from there.
>>>>>>>>>>
>>>>>>>>>> In fact, all of the ACPI tables can be retrieved verbatim from
>>>>>>>>>> /sys/firmware/acpi/tables/ already, so why exactly do you want the
>>>>>>>>>> kernel to parse PHAT in particular?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> It's not to say that /sys/firmware/acpi/PHAT isn't useful, but having
>>>>>>>>> something internal to the kernel "automatically" parsing it and saving
>>>>>>>>> information to a place like the kernel log that is already captured by
>>>>>>>>> existing userspace tools I think is "more" useful.
>>>>>>>>
>>>>>>>> What existing user space tools do you mean?  Is there anything already
>>>>>>>> making use of the kernel's PHAT output?
>>>>>>>>
>>>>>>>
>>>>>>> I was meaning things like systemd already capture the kernel long
>>>>>>> ringbuffer.  If you save stuff like this into the kernel log, it's going
>>>>>>> to be indexed and easier to grep for boots that had it.
>>>>>>>
>>>>>>>> And why can't user space simply parse PHAT by itself?
>>>>>>>>   > There are multiple ACPI tables that could be dumped into the kernel
>>>>>>>> log, but they aren't.  Guess why.
>>>>>>>
>>>>>>> Right; there's not reason it can't be done by userspace directly.
>>>>>>>
>>>>>>> Another way to approach this problem could be to modify tools that
>>>>>>> excavate records from a reboot to also get PHAT.  For example
>>>>>>> systemd-pstore will get any kernel panics from the previous boot from
>>>>>>> the EFI pstore and put them into /var/lib/systemd/pstore.
>>>>>>>
>>>>>>> No reason that couldn't be done automatically for PHAT too.
>>>>>>
>>>>>> I'm not sure about the connection between the PHAT dump in the kernel
>>>>>> log and pstore.
>>>>>>
>>>>>> The PHAT dump would be from the time before the failure, so it is
>>>>>> unclear to me how useful it can be for diagnosing it.  However, after
>>>>>> a reboot one should be able to retrieve PHAT data from the table
>>>>>> directly and that may include some information regarding the failure.
>>>>>
>>>>> Right so the thought is that at bootup you get the last entry from PHAT
>>>>> and save that into the log.
>>>>>
>>>>> Let's say you have 3 boots:
>>>>> X - Triggered a random reboot
>>>>> Y - Cleanly shut down
>>>>> Z - Boot after a clean shut down
>>>>>
>>>>> So on boot Y you would have in your logs the reason that boot X rebooted.
>>>>
>>>> Yes, and the same can be retrieved from the PHAT directly from user
>>>> space at that time, can't it?
>>>>
>>>>> On boot Z you would see something about how boot Y's reason.
>>>>>
>>>>>>
>>>>>> With pstore, the assumption is that there will be some information
>>>>>> relevant for diagnosing the failure in the kernel buffer, but I'm not
>>>>>> sure how the PHAT dump from before the failure can help here?
>>>>>
>>>>> Alone it's not useful.
>>>>> I had figured if you can put it together with other data it's useful.
>>>>> For example if you had some thermal data in the logs showing which
>>>>> component overheated or if you looked at pstore and found a NULL pointer
>>>>> dereference.
>>>>
>>>> IIUC, the current PHAT content can be useful.  The PHAT content from
>>>> boot X (before the failure) which is what will be there in pstore
>>>> after the random reboot, is of limited value AFAICS.
>>>
>>> To be more precise, I don't see why the kernel needs to be made a
>>> man-in-the-middle between the firmware which is the source of the
>>> information and user space that consumes it.
>>
>> I think that's a fair point.
>>
>> Is there a preferred set of tools that can be updated?
> 
> I think you need to talk to distro people about this.
> 
>> If not, would it make sense to develop a set of common kernel tools for
>> this?
> 
> Yes, it would, but please see above in the first place.
> 
>> In my experience, it seems many folks use tools from their vendors or
>> custom tools.
> 
> This observation matches my own experience.

For the sake of discussion, and from a kernel developer's point of view,
should the tools be part of a separate project? Or should the tools be
part of the kernel tree like perf, etc.? Assuming that this needs to
start from scratch and not extending an existing project.

Thanks,
Yazen
