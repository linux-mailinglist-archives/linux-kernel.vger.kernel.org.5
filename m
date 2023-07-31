Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AFB76A1C4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjGaUPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGaUPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:15:01 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AFA10FB
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 13:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxUNOzIFVq8mSos/dyOe9i+Ur+tON91CkIo+KN01vKZnnVGHOtR2RV7Fji5YBAc/nJKVrx7vfsKvKJjJtP+8lIzc0gYC6lfpbOVqP+lw3t4aqT6b1v0MB5JuRupaPjk9AKl7w1nhERCRvlCRR70DmimISB28U+A8A70b/qGHbhJRO3WN4WfT572SWoBxt1J//NNmsFLtKCvAZ4MOpp3fqbEjyCNaHVCIjDnnBuObxBhr73uXJsQYnYkwM19FO2ZrNYZJvUnxcmz2RfcFUmXFmwxo2XrJtP3JwEeAjP7HTRMIQnGL0wxor3HbQRNo7Wtij6ecnWe+wxP7Kpl7bAhR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9DpEKJQNZoY56HsBGHpymkt9OPPhMFgeeaklOdD6Nk=;
 b=lgnfQPZd6Ul5GKBrWRgTmez4uwZzn4BQQXsc7j8/hz9tY8JzKn0M4YIrA1wHOIXkYjNl+ZlblaUx9gH8UeyhyAYfUAgYBWBQtA8VgQjgNIrGAh/eGkyVg3KmOp9CMtSbKQJLZluQ491MZEWK7eYP2NUYAK8cyiBQTWQAugpYSvIy1J2KD5Ual6JmTeBAUQ1XxbxlJYtbEvBHsUBHneyvBjBNjo4CZo7FuPRfq0l9I3Yg0Hbi2uVkdFqWqLwVhgdd7rFZalv3pOc1HecTPEHoy5Z0NVCwx593N+08bh/GpZXcXC9P69wETe3SEmCRrn1YoriIxfRgXtY+a4MeWZBQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9DpEKJQNZoY56HsBGHpymkt9OPPhMFgeeaklOdD6Nk=;
 b=Jtox9xpZNkleRWIn8cNN8Z+xFWU2nCS/1FLbNmiRoMu54tQBegwd2uVwTAUHho7gReCmw1XQJiL/sfz4oQNpsHvEF61r+fRkTgW9ZG69zQAb/GFnLPOyX8E4jPBdwDQjvN6UcrREoFbLOn3lke3IB3IY3ZKnhYyjiEsaE423d3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8157.namprd12.prod.outlook.com (2603:10b6:a03:4fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 20:14:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 20:14:57 +0000
Message-ID: <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com>
Date:   Mon, 31 Jul 2023 15:14:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     August Wikerfors <git@augustwikerfors.se>,
        Keith Busch <kbusch@kernel.org>, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, nilskruse97@gmail.com,
        David.Chang@amd.com
References: <20230731185103.18436-1-mario.limonciello@amd.com>
 <ZMgHE2wu4T4OfrTR@kbusch-mbp>
 <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
 <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com>
 <20230731201047.GA14034@lst.de>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230731201047.GA14034@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0131.namprd05.prod.outlook.com
 (2603:10b6:803:42::48) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c08401f-2257-40b0-0aec-08db9202cf90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Y1E0+Fac6B9f0E9lYhwyGPokOZVfC+4ENqgw2z4u3JIB+RApt0WWmOb5xtZ5o8c5H0CeslstXYSUjPST8T/VUJ/Y9Q+4X+hXyIy52vM+4uv/Uws/f6oFa8q2amgkmbLP6lIEskrU4dVdMZWul9oh4MORJPkswRrSltbjHVssviOLCiLd3BO6/RvkuciUtv1tVPSgEZGnGkF7zI6FoYQCQj8CWxtT6MMhxrKtzuAPJ8pI5DDf87o2EZuM5pPbQiA8/8uCqm6eUMuDBSGyrWkTqaWXRh3NkgMhn0pfe6ifqrE8eeLEl//qtAS13f8TfFmyyX1am9DlhIEQcEPbkjGg+OAReqylC6ztE/EEHL3XR6nwca+k2UfPVj3TRQyRrkFkKgGCs9uWluKcPALFZWK+5IQPMUNxOmmzWdeu13Pqj7uz0Yhw1PJ5WSvGjaBq5zf3DLY7cTck9Ocq/mYWybjT+RGN/KsE9DbDRdBR5w2YqrqPcC+YI37KlKSaNATMiEvem73LdWE/OpKeABYRzqJYXY0yEkkk90o5+C+GWVzm+DzaltRKiiD6kyH0IxB0jA9dtcl1lqOaWYKbOySu/k3JYPWwffDzj4SexvNrS6/vgnl4/At/FyGzWUZ2ZfveTjI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(8676002)(8936002)(26005)(54906003)(31686004)(41300700001)(316002)(6916009)(966005)(6512007)(4326008)(5660300002)(186003)(6506007)(66476007)(6666004)(66946007)(66556008)(6486002)(478600001)(53546011)(31696002)(86362001)(2616005)(4744005)(36756003)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3lyTDZ3ZnQ0VkRqbHhhWUM2N0hpNmRlWEdZZnJLUzVYUmw2Zno0WkxEMHov?=
 =?utf-8?B?THJ3c2NtT2VJdVB3cXZ1WkNvK2h0L1Yrc2lqblFnRzk4VmRtSEdxWjRzdWhy?=
 =?utf-8?B?RnhSZlRDRVZyZEsySVNweC9HZXFRaDdnOWR2bDhhakpmL1VxT05SZ0l0THd3?=
 =?utf-8?B?YkxGZlFjejFPWUg0MXJmYWpZUDlrN2R2OU9NRG1MNXNWdFY4NlZvTzZSSy9D?=
 =?utf-8?B?RmVhbDZXT0p2dUlZcFhZNlVhNlBUNE4rcGF6WTloVytUdHNmRjk1R3hMSVBY?=
 =?utf-8?B?UEpJM2ZPY05VU1JGOVR3bzg0ZDhQOG1pek5HOS9jQ1B0NXdsaHRvMGplVDJN?=
 =?utf-8?B?WlowZFUra1k1WGhtVXM3TWxvdStDZEpsa1dCYXdwbC9yeUZESTZyRzk2K1BY?=
 =?utf-8?B?b1BNUFM5Qnh2b00vVm1ldXlSeG4wOFFrQ1JNdXZaZ2hPWFUzTGZvczV1U0ll?=
 =?utf-8?B?K0ZUMFljVE5Hdm9oanVwcEY5WlhRczdhdkhKTWV5Mzk1cFdEOVlTKzY5aU1H?=
 =?utf-8?B?eVdmakdNOFdJV1owVGExQzJ6YTJsZ0pSODY1c1VIK3FkNzJ4TjZEQVF6MjNT?=
 =?utf-8?B?MTlxeUs0a3FYS3FyZ3I3NE1kRnVqT2ZGMGZpTGRnZVZjY1Y2MlFwaTdHdTlV?=
 =?utf-8?B?dG5zWmFJc3hOSG53RnlHaDhmc2hQTnFGdm5tR2lyZ1U3WXlOWVpxRkF6d0t0?=
 =?utf-8?B?dGFLYk52SFJOUlJINjJMdzRjanF6eW8vZ3hKZ0M1ZmVvUWJhM1JienBGZnJs?=
 =?utf-8?B?T0wzL3Zrd216NFdQV0JxaXlSbThQVFpFS1lyVEM5Uzd5cUxKenBrZVY5RFRB?=
 =?utf-8?B?QU1pWmtncTl2Wk1CT0czM3owcDVtMERIWlljdDVIZFVnakxvaUpWaFZOeHVM?=
 =?utf-8?B?bENRK3g2am5XNGRUWWI0a29vcCtTUlFjN21oVEhmVEkzNXVQNWJ4QkxaNGNS?=
 =?utf-8?B?bnlLLzRrM2NyQWwyeHhxdG81TUVUTDJUck1KWFpvS0RCckk2cFk2eHg1SWYr?=
 =?utf-8?B?TGZ3SCs1ZUhOenN3d3dITDJ5ZFRoekRhOUx6UjJNVEM2RGhaOEpnTTh6aGF4?=
 =?utf-8?B?TVcwT0duM3ZHZUNVblB5SDhKSEV0VVNKb2NOdEpuSC92TVdXdm5raklQT2gw?=
 =?utf-8?B?LzJMZVhjL1RJRXhwd0VJVFBTRnRveG0wUzdTL2pML3VqMDNRSFlJZi9HcUds?=
 =?utf-8?B?ZHBwY3RKRUFNcVZ0aUg3M05KMVBtbEFjeG1oa1BUSkRjVEpEc1Qrc0Z1SHBx?=
 =?utf-8?B?Y2lzcmNnazA5bEwxNWZ3ZzNCS0szZG5KeUJnejdKV2lHamRObjRYbnZNTG5W?=
 =?utf-8?B?citQTURGRCsxM2txTGdINVgzc1Rsd1IxVVZRVDQybTlwNzYrQVdUVi9ZM1lv?=
 =?utf-8?B?Mk43MEhoVVR5VFJjTTJSdFZ1OWJkWDlDbjduNmMzcExaWmJQZFltV0NuaFZz?=
 =?utf-8?B?b2ZVR1dzSFZtY1JNRWlScXp4YXYrQWszYVpRSnhtZUxuR3dwZFJ1SklleXRT?=
 =?utf-8?B?dFFMdXZpQXA1UDBLMytjNVMwbEl2R1NaVlZlVEc5WkdLQXU4bUNMcTRtTWxU?=
 =?utf-8?B?TUxWZ2RnVWd2OHlXVC9WWEFnTk1OaU5KRVYxeWVzTzVEZUs1Z0laczdYM0ZJ?=
 =?utf-8?B?WHFqa2ttcWNBbXZSOVU1MkNNdmtrYllCTFlEdnNWTWZMTEQ0MjZlaEpCRmU3?=
 =?utf-8?B?ei9UejJzV0ZpMUI1aGZqdlo0dmFSWnRaR25YYVFzS05jVnVQdXNKUGNxKzNo?=
 =?utf-8?B?R2JFQ1lDVldUdmhhL1lqU3hzcWptbVQ5Mlp3WGNtYzJIcEMvQjh5UElOQW1t?=
 =?utf-8?B?a2h1UWRzeUdnSnhhTHB2Q0V1eUJaTCtYU2M1cm8vaTd2eEZ1bk15OGU0eWM4?=
 =?utf-8?B?dzhybHZoMmdpZ0FSTEt4N3duZEpacjVBMjU0MDN1UDhSVmVOUjJVK29iVDBK?=
 =?utf-8?B?YzB5SDM2YTBNZVhUVDA1YmpEcmRFTXpyY1VvbXJpNElmRHF5TVpXbytkQitP?=
 =?utf-8?B?U2JoNTNzZ0hPZjZOczRPYmZQWG05blczaEt5VXkzYm9JVGQ1SUZBQm84R0d2?=
 =?utf-8?B?ODJGOW9jOXI0ZTAra003eDZWaUtvK1JUdHQ2Nkw5RU1ZMUdtUjR6NWpkQzBj?=
 =?utf-8?Q?1KOP1/j4zDrYBRIzWriYSG4Bb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c08401f-2257-40b0-0aec-08db9202cf90
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 20:14:57.4292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyR+M/9R91N7nrLkbaUcMY2HGmHAeThk/Sslsr70WdiGzuLOfILsd50obhPsdT3rHHYCCh74fzRge9eVLW7QOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8157
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/2023 3:10 PM, Christoph Hellwig wrote:
> On Mon, Jul 31, 2023 at 03:09:08PM -0500, Limonciello, Mario wrote:
>> So is it reasonable to just add a check for
>>
>> ctrl->oacs & NVME_CTRL_OACS_NS_MNGT_SUPP
>>
>> In the same error handling path as this patch?
> 
> No.  There are tons of NVMe devices that only support creating and
> deleting namespace out of band, especially in virtualized and cloud
> setups.

Even if it's only the error handling path only that it's checked?

If you don't want more changes or heuristics on the error handling path 
for this case, I think the best solution is probably to pick up

https://lore.kernel.org/all/20221116171727.4083-1-git@augustwikerfors.se/t/

instead then and hopefully we don't end up with more disks like this.
