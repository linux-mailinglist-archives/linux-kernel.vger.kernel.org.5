Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9107E5348
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjKHK0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjKHK0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:26:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C2C19B1;
        Wed,  8 Nov 2023 02:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699439174; x=1730975174;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l1TTxiZ+DDIKIn/pc9hxWk3CYNWiFS9q58Tx2er9QDw=;
  b=cID1Dl3kq3ICl5CRS4sxIVdEzzygk6VTqI0qjEwMyhE4WpX2KblfkrkZ
   usPhCzP+aAD0QK46YSzra99Ep84eOPLghTt0r8ZyY8pTni4Or1B8jOMbj
   OcCIXt+yLygMukvKfGiknjh20wGrUXBgOqmQ+t2NTkaU2hPtSDEiwlsIu
   jf8lL1vSN0ErCss3DE7j568zupdjy153zpPJMNrFmEyPGxKHW+6SmlvXA
   vLOsVh5N/HkOLoDTL0QayhS4oG1C69Jr4xp2jUeSDGIO5ONn3FoJ94ETw
   v2Q85pIp5SiQTI6DfT2I3bHqSABIVsPes8B8OQY5Lr8Z9FyJhZXlITbRI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="386906476"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="386906476"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 02:26:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="828927755"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="828927755"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 02:26:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 02:26:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 02:26:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 02:26:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMaTiUVzd/FmsqhFYRD64/Rzpymy7e8MLijCjr5bvtkMQ0JR3qthKEIvpQ8useUAntu7KsZKmIbyjBrRIvEE0ukZjxCy3KJDDkxcwDFlZ60Lf4fExCs+7LBgjCirWlcA+7t1aC8ZQoiRW0/i9bZJeof7Gc+y15GT6tuDGKYQRP5ZHisu1CVoieQtuPlsBApcncaQJBQoWf747uqi2b9hQsALYjsqeB3N63yXWsyHjZMi5lF8STb7WvshgtzExkfc1XFrjgPBS8fVMiqpSJHS/GbhL+KjVLqT70gQsS+bXEoHQ8FIrOsJBIgSih5flPQ1SeP4UVcj+pH2LEGe87h7mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1F+EBgVSRUnzRgxtvzb6A4rG1O/po8lqF43QYCoeEM=;
 b=OFjKga5lZUiDNjk3eCK2KEcWe3/dbSi+EqbYUyDlaNFK5E1woA9vzayPDRhdNphxaXgGOVqDdmG+KKGB8jxu0dRsBijQoDoU0M9HJgqn8Tju9/jkW3aUrAoIm+pHQUg4dRyS4aHAe9Ai0su1BFT9xds9pZuPGrQ6qr7d2XMvQc13bDHSQhDgkGwB4kw1HTX1kJfRAuG39bSXBulpcM0FG0zDOsCHvkGE2J1d2tLV4uJDpcUTVVkZS6cs7j5XfywtufOceoriB7Jt+7EKLg48gwh4c19z7bafnZ+3lln/99VX7Fop0dH8/YO+pLGe3AGIdEb5ZIBQB/WEToY/MU4P/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SN7PR11MB7993.namprd11.prod.outlook.com (2603:10b6:806:2e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 10:26:11 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::4bff:ef3:3532:d7eb]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::4bff:ef3:3532:d7eb%5]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 10:26:11 +0000
Message-ID: <5a289765-638a-2a8c-b56d-fc323a69fe2b@intel.com>
Date:   Wed, 8 Nov 2023 11:26:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH RESEND] ptp: Fixes a null pointer dereference in ptp_ioctl
Content-Language: en-US
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
To:     Yuran Pereira <yuran.pereira@hotmail.com>,
        <richardcochran@gmail.com>, <netdev@vger.kernel.org>
CC:     <eadavis@qq.com>, <davem@davemloft.net>, <reibax@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com>
References: <DB3PR10MB6835D68E7E632532155AE585E8A9A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <70911c92-4272-cff6-857e-c95842b644c8@intel.com>
In-Reply-To: <70911c92-4272-cff6-857e-c95842b644c8@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::8) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SN7PR11MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: ef328df7-752f-457c-572f-08dbe04520b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nj1kmUIA4wO7q5bOYhse3aFGQh3y1w2LoKk8nwJhCZ4oLvB35Sr/OZ4GJEl9g8GEo/7jq3KGM3ZIViy75UTK5Z/CQJRn3Pzs9xTz35V1EF1nk4CSaioM1iilPS1+z7Q7ivyMRtdR7AYibfiWZmhCFciTO0U4eG0ZWn2OeTqQud8gv0tl9WqekHtPHrhPzW+RuzfxoF5G4qUCHy7kXWD9gvlablBR/7426t7E1RnCK2jz/czi+QnVz536xJ1ba6QPdS46bOYqvevF6A1xG8ZHAubdvowtYi8iaDMZPgtCRvw2m7Jh/EbG3Tsa+AdnuuhpaWXK0BLAbEoS45mVplDCC30GQGPa4G3FMkODEOKx9umN6SIcLRND5O8k/R+zoXExP3O72EAfe98linazsw91uzjoNofuqnJ23EbNyeMT1VCdgHrScet2nPWClO3hgLoYUO7r+9ze4PbwpyoLUN3db0CXN161ECQpFNXY3FgqbwA+dZHhaZsiL0HJ/hbsNtx/XfnEbYOwcd8Sc0mBS5Ug8ivFyG8zfYmQ8cC0DgjmcXFY0f7iU0UyIri7mmJlzVRXtX/+3sg4qWXhoaY+8migPM3dt1c26ny7/7SmFAriV3PRSd0Q7rOWmoCsOoYfhigjizNOt76mK+tH11Z/eHLkr8MNX3t9zL/fjDKeoUXO0Y4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(36756003)(83380400001)(38100700002)(45080400002)(82960400001)(478600001)(6506007)(6666004)(5660300002)(966005)(53546011)(6486002)(26005)(66476007)(6512007)(66556008)(2616005)(66946007)(316002)(2906002)(4326008)(8676002)(86362001)(31696002)(41300700001)(8936002)(31686004)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHhiUDljTndZMkYyK1cwd21sZlkvTFNMSWoxbURQR0FKdi90bVJFWEQySFkv?=
 =?utf-8?B?NzYvWmZxSnhkV25Nc2JFaEQ3NlpmVDdEcWdGQ1VQL1lkaWJ6aXcwTHhOVFJ1?=
 =?utf-8?B?VlpCOU1CQWl0eVFtNXZjcUFLdURqWjAvKzBZeDhET1ZDZDRiK3dyU3JieUcv?=
 =?utf-8?B?aWVWOTA1NVpqUC9qdHVKZFZ3NkRzeEZ4clNqV3F0Nk8wVGQwcFN4VmorTDB5?=
 =?utf-8?B?cmRpQXNGNXdFeE14blQrVTJKU1NjQ0pQN0pabkpyV1dra29wWXVGVXhPQ0V2?=
 =?utf-8?B?aXdHd3FWaU5FcU90QjJmMmxMUUptTlpacWVra1lvVmZUTW1KcGsyQkRMWDA5?=
 =?utf-8?B?WUVJcjFVYndpakcwSjZNWXVGcHhqeGk5WFkxSUZSTklYTTlXTkErSm82UmJo?=
 =?utf-8?B?aG1BeUNVVE56bFpHbVpnNDEyVHk5czhCWHBZSExRY3dMV2ZKVnNxQTVRelkv?=
 =?utf-8?B?dVJtWUt5S1d4SjJ3cHhyb0NZc0tkT3dhbmtDZEpqOFl2UmNBeDFGdFV0UFF4?=
 =?utf-8?B?ZXBXSHBERFduSXFEVkRrd1ZtTHByUFk5dG9VQmR5eWpDbkxBVzJGUmhQcklu?=
 =?utf-8?B?RzZWQ1ljb0J3ZWFnMUhMNFBaeVBSbU0wMDJadFdIS3paOTlWRGJ2eEs4QWNm?=
 =?utf-8?B?cGhLUndxUC9IQVM0ZW5oNnNxZFF1SGdUeXhWRG43RzcycGNTNlNHNndDa2ly?=
 =?utf-8?B?UHUvc3ptbjkySlM3RElKMVFkY1Fmd08xcmFlM2dnVU5tVDYreElLcnd6RzQv?=
 =?utf-8?B?REV1UEJNbDQrdXVzeUJwaThpRENrWDc0SGR5QmxNSkM3VG9nUjFKVVpOMldm?=
 =?utf-8?B?cS9GdC83NXMwcUZTdjdHOVdFNnRPdG90aWNIZ09SckdPM0pwYVBhNnlNQ0lD?=
 =?utf-8?B?ZWppeURsQXNFaElRbVBBaDh5U09SRURBZzNrTHlVdlpiOXh2SHZ6akpWWDA4?=
 =?utf-8?B?c0FNTCtKM0x5amE5d3F1OTRFMit1K2t5dC80Y0JqTmVwSnp0dm5VNUlzS1Z4?=
 =?utf-8?B?ZzZIL1AvS2FmeHNiUEIxdDFtdFgydE4xY1Y2NGNNNGtUWFNla0N3blJCUVcy?=
 =?utf-8?B?MGZuQXNubldQZDFuZzR6VFR2YWV1U1JUZ2tkd2U5dDZmbkF6U0FqcVYxcDVO?=
 =?utf-8?B?WTYxdjhhdW1FbDZsWTh3U2RDY21vUGQvcEU0d2tFbXNjYTlITWwvbHlXRUpK?=
 =?utf-8?B?aU91eE13djZnZFdjWncxc3ZRbVJaN0pxa3F2OHg2RU9jZzBRUjhDT3FZYlZM?=
 =?utf-8?B?L2VUTUxFaFI2OGhUYWFwR2FyNzBlL1Jnbk9xeE1rM2l2eUNCb3Fhbnp2QUJs?=
 =?utf-8?B?YXhKR2d6a0RDbDV5TWdrZEt4ZzZYeGRpUXh4Y1hSS0ZyYmEvYzFFbEpnaXYz?=
 =?utf-8?B?bGZxNXNiK0tWa0paNHNxNHNVMGxQUm84Ymc1SERFTjRUb3NCKzB1TTJlMGFu?=
 =?utf-8?B?THhxeDU1Q2pZbnY2ZDFYM2R3MDk3UzZQNDlQSnBJRCtmclQ0QlVFM1lxTS96?=
 =?utf-8?B?c2dFdlM5RUdlVTJmSkRtUVBqaDdHZGhKdmRyekN2Z2J4SGpRWnAzTFFGbEJW?=
 =?utf-8?B?OVVrZEFKTUVWUG85SnRSTzNKVTVzeFpwRmdUR0JHemgwMnIyMkp1cEhtYW9D?=
 =?utf-8?B?VU1KdDg2YkpobzN0Vm1GSkZFSWxWWUpWTStZWUZ3SFk4TlZ1MXM5NTMxOUdr?=
 =?utf-8?B?UWU4WU5zSkt0OFBZak1YZGU0Q1VXazdBekJFZ1RWc05qVzZZYXFJeVJKVmwr?=
 =?utf-8?B?R3pTNVB2Z3lGY0VUU2w0TTBPYTl0ZWZROCtXd01mSWdXWTFGb01aVmovN1p3?=
 =?utf-8?B?MXI5S01kLzhpNmU5THFqanFnVk55ZHhxV0VHc2hVN3NiakkrSkx1bkZpMEc4?=
 =?utf-8?B?YmdEbS9zNDdjOHdhbkRldXpKT2pUVWtxc1FYRkJzRmd4ZUJ0MjZYZmZRK0xv?=
 =?utf-8?B?Tm9uVTdsQ0RmL25kcERDczNlUHBlWmMrbjBIZkgzbzlkZ0NFYmpsSFMxdlRX?=
 =?utf-8?B?R0hwMEtJYlNjaFlqSytvd3hSYVprQjdTbllqR0QwY2JZSEYrMWk0QldrTTNO?=
 =?utf-8?B?SlMvelpscHd1d3B4b1NrcTdpTWhvTHhvdWw0STdNaG9iZjNmeVFqOTV2eVpH?=
 =?utf-8?B?YXkwMkVwSkNXcWpKRmQ5MWJqOWFIdHpQenNuendnYW9BcXpJSGhwYmhZNjJy?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef328df7-752f-457c-572f-08dbe04520b6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 10:26:11.0117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25ky7trHEEuDqHNVCnUasPQikgjVNIYVha507hHN0DPSkiDJd8qniamcR+TDcmetUlDNU8mENF2E+V3vhpLu+wRxfU6UuxYy3l5/PjL2qDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7993
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 11:15, Przemek Kitszel wrote:
> On 11/7/23 21:48, Yuran Pereira wrote:
>> Syzkaller found a null pointer dereference in ptp_ioctl

Ugh, I just noticed that this is a fixed version of previous attempt,
for those please always bump version and include changelog, please
also comply with:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

if only to don't fool random reviewers
(I somewhat assumed that you have just rebased some old patch,
PATCH RESEND was misleading here)

>> originating from the lack of a null check for tsevq.
>>
>> ```
>> general protection fault, probably for non-canonical
>>     address 0xdffffc000000020b: 0000 [#1] PREEMPT SMP KASAN
>> KASAN: probably user-memory-access in range
>>     [0x0000000000001058-0x000000000000105f]
>> CPU: 0 PID: 5053 Comm: syz-executor353 Not tainted
>>     6.6.0-syzkaller-10396-g4652b8e4f3ff #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>>     BIOS Google 10/09/2023
>> RIP: 0010:ptp_ioctl+0xcb7/0x1d10 drivers/ptp/ptp_chardev.c:476
>> ...
>> Call Trace:
>>   <TASK>
>>   posix_clock_ioctl+0xf8/0x160 kernel/time/posix-clock.c:86
>>   vfs_ioctl fs/ioctl.c:51 [inline]
>>   __do_sys_ioctl fs/ioctl.c:871 [inline]
>>   __se_sys_ioctl fs/ioctl.c:857 [inline]
>>   __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>>   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>>   do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
>>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
>> ```
>>
>> This patch fixes the issue by adding a check for tsevq and
>> ensuring ptp_ioctl returns with an error if tsevq is null.
>>
>> Reported-by: syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=8a78ecea7ac1a2ea26e5
>> Fixes: c5a445b1e934 ("ptp: support event queue reader channel masks")
>> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
>> ---
>>   drivers/ptp/ptp_chardev.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
>> index 282cd7d24077..5b36c34629a0 100644
>> --- a/drivers/ptp/ptp_chardev.c
>> +++ b/drivers/ptp/ptp_chardev.c
>> @@ -173,6 +173,8 @@ long ptp_ioctl(struct posix_clock_context 
>> *pccontext, unsigned int cmd,
>>       int enable, err = 0;
>>       tsevq = pccontext->private_clkdata;
>> +    if (!tsevq)
>> +        return -EINVAL;
>>       switch (cmd) {
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 

Still applies, code is fine, thanks!
