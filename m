Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307987AF9FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjI0FV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjI0FUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:20:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66036768A;
        Tue, 26 Sep 2023 22:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRSCD8nm8ms8v9guQIz4EKUf2CNKDAVNK6yHIOXe2ZpzjCxzs6p08Vva3jSOK+WGxsPUFgaovDGMOstWitBGD65SHvUea2Mn1Z9POrFxORRxLycSazTgom0NKnYsefj0hZoHa1YgE5nZ745lHt7zQrql+RlYqikxUxf2rqid5u7Vmm5r9j/nagl+CjxZAMaZ6aPoh/9HZ3FX3eBTo8HZDsJKZYMixchNXIOGrWpUwwd/Nyd1WVDVUZfjWOHtRp/jGAtVSoK/t1zzovdLWNwQgZbpEMz6OHcT7wv93H9m18r3/mfeN+8czTS4vWfySQqF1wdUG38S9FcLQEg0knqjDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I61t4ACHnjvrkyGqLWzahRBqRbGWJX46Z5goXEQXgSY=;
 b=NDtCw2cO7iKXiKj6wQkiLPKq3xxQ9yJbt6An8lvBWS3FA+rfM7e+57A2f+9Lx4nM3OgEOyKyfbFaWA2C6Tdj8D/nnYlF5q5s44Q5NPGANWbAcXSfX2PH8VaEVzX4GK5no9xk9MPOUQuylDVvBb3vizTfaUBUg5ztQPCyzATP+m+FwrC4TlDO5nZc2Ep+F9gTVSpC7ITD5gA5tz8UFqQZ5j6CHLalEQjsrai43vwZ1gvTyhnOCCJdZ6Tv4jRJwpGN4kq8bWi4FBByIq0ISoTi5DTjP7RBH329P0ZGjBycxv+gczW4cj15iKoVCvxLuvV7MUFL4b9c/7yG6xB/OFu4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I61t4ACHnjvrkyGqLWzahRBqRbGWJX46Z5goXEQXgSY=;
 b=f02dV4yqSNzwh97zA/GvrknSzFiGBOzq9slswl5+jmyqNhJUaL/jmMPjO5t7Lvoi3HiX+3pTQHNNusRCPkwWJO/sZyGbjd2hbZR2f7v+VNGmu3757KP0wq2rd281M5sMFfyO7OH/Hw0i7WAoLMQwIzuPzD9cLme9jlkYmYpqKvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by SJ0PR12MB6784.namprd12.prod.outlook.com (2603:10b6:a03:44f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 05:16:33 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::a368:be51:abac:5ca3]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::a368:be51:abac:5ca3%4]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 05:16:32 +0000
Date:   Wed, 27 Sep 2023 10:46:17 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/power turbostat: Increase the limit for fd opened
Message-ID: <ZRO6ofa9sHbKJBCv@BLR-5CG13462PL.amd.com>
References: <20230922092823.478042-1-wyes.karny@amd.com>
 <004501d9ed96$16af12f0$440d38d0$@telus.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004501d9ed96$16af12f0$440d38d0$@telus.net>
X-ClientProxiedBy: PN3PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::13) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|SJ0PR12MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 3526c2e3-0fcf-49c4-16fe-08dbbf18e963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3OQbx4LOIkUuY46b6aLWd6GmpJnvJ7MjMhwlOGxtPx4DzaPBVEgN/2j6FZFJ1mL4HDY8/c2hbKTZrMhmXcotvp56/nib/Bn+hMEnMWdqJzgZ2LOPLMxJBAy3yujqLcdmOt5qJyyNvbb5/gBSzfBkEDz6y2M6qVwjYBSd9CEee+ZwDw7upYFSaqwjEodg1wS2gN9CtgvHlwbsekOwfWG4HynVVpqdT3tNHVbuMm7imbH7Epxbc1CyB5/87vsedMfWfA7FYhTFoByj3lA/usKNN5xGFMXE4kqr2b45EpKOQyu7G4MnR1fULB4IS0V5OKWiLvEi7q5z6rUd8IGReXqgFdXtKueDVlTkLvX172dEEEamHRFJHf7Sd+l+MeoIZC20ZTLjFZ6JuvVncLmvUkYokaBSAMOQ9nfethRDMzArpc06PQ6SdZElOVUibU004P4q2p5rnsE+AtsXvLmOxMtS2AqNVD6Sp24EkYXLHLiePGXbsaQwv/bl+zQ98arUoOxMEWT0Ei9j7m8qhefAEtokie0J+TuECFT8HGOgfSttck3yQANsgIgYAtD8AQPhRAvA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(230922051799003)(186009)(1800799009)(451199024)(478600001)(86362001)(40140700001)(44832011)(2906002)(5660300002)(83380400001)(6512007)(53546011)(6506007)(6486002)(41300700001)(8936002)(26005)(4326008)(8676002)(66946007)(316002)(6916009)(66556008)(66476007)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sSHpXgqSjgZnXZbXh2MgIZpqFgbqPAR/rM82LUXg7VHl/Creyk/AK1lfP6DS?=
 =?us-ascii?Q?//RwOJGP4oKWWVSCZpHREvL8pZYb59bmWqVJVPkARhMCoo08ha/GIAVCpl6C?=
 =?us-ascii?Q?PVNzJcdsNic6/ApEo5i6P7oQrVkjXBrSIbTj4El8FMxTou+Wtt1vAcHb7Vh6?=
 =?us-ascii?Q?fA4B/jX2jECOqO6nA6S9QuB87nH9CrFdjdxdlEQ6NCCWZ3pfp1VLJSj4Xn85?=
 =?us-ascii?Q?xjhd9aRmFZpGfIrQj+6hU+7eZle3jNz0BcDAKTRH3kn8CNw65hN6yodmOrXj?=
 =?us-ascii?Q?MgpmdzzZ/q2myxKN2EEs16Fj5TZiKpe3Yb43OZBfD/j23npHRrZCo1UAM9m0?=
 =?us-ascii?Q?y96Q48z8QInvpIVgPAyv2oySOZwfZCrFIk1pLd+7I8Ckr99wJ28UEm2sQkYl?=
 =?us-ascii?Q?favTIJWKmL1TxHeKi2KFHSOSnhY3h9hDGR9HhbE9EfEkOW2rYQcAyrarDy4d?=
 =?us-ascii?Q?sts6lpuRsoG2FlAGWfWBzEjhpIsecQ8fZpgtcPHipk/BTF9e2sYc7jSdYaUG?=
 =?us-ascii?Q?ZHwXqDbkazFlFTRjV26dJTUP7331RfgRSQ04jYWaVZfQg8kU++JfBsSdFSN9?=
 =?us-ascii?Q?uOr+uf+tRGN9BjjfAExIng54OMFHUWhlhmSwHJpbnjPfdPKe7BsjBw9q9jyo?=
 =?us-ascii?Q?ZxFIzoC4IzCyWgR2R7Ihode15/QbIlZlfhvwoyIXxWz6ca5T/I7l8HJx0NLM?=
 =?us-ascii?Q?S2ULzJVhNoTjcwxDJ3uXCLQRTzpJ79JGldATcf58f2R+n4IrLT6sVKKbLio7?=
 =?us-ascii?Q?oiNWAjp3dl7n6m/dX5oFiIusTLU4e5yXng9OsVyuH7+gxl/mEjBKicWYFs0M?=
 =?us-ascii?Q?II8nlTa3uVqm11/1JIg/O5D++Jvu3ijjOkxikk69ZIq7yfsAMzjOp8dUlzHe?=
 =?us-ascii?Q?7hDmM4HofXqILbCHVOgFHYU9tsqzLLfOu+Wq3VVsb8Az7/RtZqAIICXgGipK?=
 =?us-ascii?Q?rxYG8s24xuA0xtQqi8m3nKv6q1PgYFLecAioGhiogsi+lNwaeodhcv//rQL2?=
 =?us-ascii?Q?FRMz31VWDpM2PKaAm86SHDqfExZnXTzZHi9nizRcKM0sWT1dD9IkpQebeECM?=
 =?us-ascii?Q?lTDyopInsCFhza66M14kMTIruQt521j993Bf2eCQ+6iPq7L9udWLktel137e?=
 =?us-ascii?Q?0q1ApnnYwtTa47X/VrHkDofQATXrMIQMM2524DYH808JQpNAx1uD5uobwk1b?=
 =?us-ascii?Q?68GnG/dTAXM5KBA1E2Khi18eV9QNmoSGegojMMthrTPS9xXFAjDXYxAT96qV?=
 =?us-ascii?Q?M8Og99QTCEil5HeNPAiFJasK2IiDImxAQ0YvndxPkmsGXALgm0KsHnBSl9IH?=
 =?us-ascii?Q?q52WukVVbD0AWmGPe0puis6IxjtotBXT6XyGUsQAVTrIhwxqo2Xu1e18YE1Y?=
 =?us-ascii?Q?YTKjhtBD9kXPQ5RNKvOqrzg9uUwb1l8FWlnhPCcmEoKRS9SpB8O9YkLr0hUR?=
 =?us-ascii?Q?beYbryN3UkKHsQBl6Xv+dp+lbYNKneCXdzmeO6tTsL9AO10ESgBtIIOWVD5C?=
 =?us-ascii?Q?6NczDrJhjg4V6t0eeV/ZhFFOwtyXZzIIXccGxLRMhaAsHRh4YJTstQ1Eb85C?=
 =?us-ascii?Q?ddBDxPnOIhoEUAvAwkCW8U777GLrnU2ReEnhI2Qr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3526c2e3-0fcf-49c4-16fe-08dbbf18e963
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 05:16:32.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWPDRcocp34XKSX/Kr+NW0hj9z0ljT92tpepuWd97khb+Hmps1O2DYaAvPNwOqVaBQMZWMb+i+TMpR0nq34y9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6784
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Thanks for taking a look at the patch.

On 22 Sep 13:48, Doug Smythies wrote:
> On 2023.09.22 02:28 Wyes Karny wrote:
> 
> > When running turbostat, a system with 512 cpus reaches the limit for
> 
> Suggest" ... reaches the default limit for..."
> 
> > maximum number of file descriptors that can be opened. To solve this
> > problem, the limit is raised to 2^15, which is a large enough number.
> >
> > Below data is collected from AMD server systems while running turbostat:
> >
> > |-----------+-------------------------------|
> > | # of cpus | # of opened fds for turbostat |
> > |-----------+-------------------------------|
> > | 128       | 260                           |
> > |-----------+-------------------------------|
> > | 192       | 388                           |
> > |-----------+-------------------------------|
> > | 512       | 1028                          |
> > |-----------+-------------------------------|
> 
> The number of open files is a function of what is being "show"ed or "hide"en.
> They can also increase beyond the above 2 X (# of CPUs) + 4 number
> via the --add directive. 
> >
> > So, the new max limit would be sufficient up to 2^14 cpus.
> 
> Well, not quiet, but the point is valid.
> 
> Normally, I would assume that a server with a large number of
> CPUs would have set a much higher limit of the number of open
> files than the default. I use 131,072 and so this patch reduces the
> maximum.

I think below will fix the problem.

+#define MAX_NOFILE 0x8000
+
+void set_rlimit(void)
+{
+       struct rlimit limit;
+
+       if(getrlimit(RLIMIT_NOFILE, &limit) < 0) {
+               err(1, "Failed to get rlimit");
+       }
+
+       if (limit.rlim_max < MAX_NOFILE)
+               limit.rlim_max = MAX_NOFILE;
+       if (limit.rlim_cur < MAX_NOFILE)
+               limit.rlim_cur = MAX_NOFILE;
+
+       if (setrlimit(RLIMIT_NOFILE, &limit) < 0) {
+               err(1, "Failed to set rlimit");
+       }
+       return;
+}


Is this looks okay to you?

Thanks,
Wyes
> 
> Unpatched:
> root@s19:~# cat /proc/47043/limits | grep "Max open files"
> Max open files            131072               131072               files
> 
> Patched:
> root@s19:~# cat /proc/47032/limits | grep "Max open files"
> Max open files            32768                32768                files
> 
> Anyway:
> 
> Reviewed-by: Doug Smythies <dsmythies@telus.net>
> Tested-by: Doug Smythies <dsmythies@telus.net>
> 
> >
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > ---
> >  tools/power/x86/turbostat/turbostat.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> > index 9a10512e3407..23f1fe58289a 100644
> > --- a/tools/power/x86/turbostat/turbostat.c
> > +++ b/tools/power/x86/turbostat/turbostat.c
> > @@ -6717,6 +6717,18 @@ void cmdline(int argc, char **argv)
> >       }
> >  }
> >
> > +void set_rlimit(void)
> > +{
> > +     struct rlimit limit;
> > +
> > +     limit.rlim_cur = 0x8000;
> > +     limit.rlim_max = 0x8000;
> > +
> > +     if (setrlimit(RLIMIT_NOFILE, &limit) < 0) {
> > +             err(1, "Failed to set rlimit");
> > +     }
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >       outf = stderr;
> > @@ -6729,6 +6741,9 @@ int main(int argc, char **argv)
> >
> >       probe_sysfs();
> >
> > +     if (!getuid())
> > +             set_rlimit();
> > +
> >       turbostat_init();
> >
> >       msr_sum_record();
> > --
> > 2.34.1
> >
> 
