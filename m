Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B430D76E005
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjHCGHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjHCGHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:07:01 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195B1E6F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691042819; x=1722578819;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tv8yErTE+eYA/Ub8ZCDDqsIrOeDokPolFGsmK0Vny2Y=;
  b=ezgJA4z0M+zpSaE8czX6eHuSj+EI/4srj4n0Dp+GYDQC00e2XllcpjSk
   tT7IGrbAWcY+02NQbqscjfx5StEwmLb03CkLRxlFGz63IBtv8H2/gNFJF
   4zgnMcLgYb4iulo9TTF7mySgYg2I6c9x34mCTyyH1zbpZOBhTOmV2rt7T
   fZ/pPOJHkeYjBZQuuKRFMtu+s/Jeb6kiWRMUXjAZF8MLqAAMuTVgEzWfi
   6xOsOIaIBXdporrrFKMHJfOpAHyfX3z/ueNbMbEWQzWubzOXDka9RmvJA
   h7qA7CYLaYdxeVTFQS8FprYQgUkS7Fe+JXo9TSa+45V7EtUeH3ZA7IYiS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="372513249"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="372513249"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 23:06:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="732639073"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="732639073"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 02 Aug 2023 23:06:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 23:06:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 23:06:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 23:06:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 23:06:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcKPn4AEGuY4StZHMBec6wK8BIP3OJ2z6ADqdMC7i7SP3bZQKcnOEEDILfxb4s1Y6itFeEEniTcS0G6tZADI9rRp+VSalYKXYeH44/bqXmjBjTlrFi7LI7FuQ17un+Sx8bs2ZG5QRC16C98jwn5kNH5Ii881BYrfFhPuTJ6u6qGe7kJPgkE2tRJ10cTjzrizzjerPD20SYZKf8YX9GJxgeb3fyV8WGQ7YhtCiFb5GrO4kVwqO0Ha2VAsA3K8oB/xdV7jSM1rNIeHXR/zx5w9UWVEUKx6lSBtHcVf/H9GLoVMEXbBZ6iC21PVqkoxdBpqeuUadecRy0vd3/gD+KfIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RA6FNBjMuhxcShdx/1Bafvl9R0NsqYTV1XajU0JY6kk=;
 b=inEawIVOTnFFKon/sngAQISeyovR/Ctrw85F47XPIAc4p7JAAd8vUqJFWtulm66Rac4BJnayR1KUO6MQpmtQ99LhyHge64CSp5LDFb59jV8eClV5jALXcy8JTVi13TfZU1E393QG3Q00jaerzYvfChf3vLx7AcNKt2cCWmXLqI2kZqJVXDE4lP1tVfJme5RcD6hzIaQ3ALhr6aJhVrIL+I3D+L17NgAaIC4UV5EXcTiFD//AQyGttiWDq5DScZEKXiRvkpyOd5VO78vxEv2NUpad4EgXh6Wjm/VIYl61NeR49D0TcabMYt+jgDCjcme5GPslXF95VROtjsNQk0aNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CYXPR11MB8692.namprd11.prod.outlook.com (2603:10b6:930:e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 06:06:55 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::7afe:52f8:2d9e:4934]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::7afe:52f8:2d9e:4934%4]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 06:06:54 +0000
Date:   Thu, 3 Aug 2023 14:06:46 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Memory Management List" <linux-mm@kvack.org>
Subject: Re: Fwd: crash/hang in mm/swapfile.c:718 add_to_avail_list when
 exercising stress-ng
Message-ID: <20230803060646.GA87850@ziqianlu-dell>
References: <43765f2d-f486-8b00-7fb9-9eaea5045bfe@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <43765f2d-f486-8b00-7fb9-9eaea5045bfe@gmail.com>
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CYXPR11MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b664d19-c2e6-41a2-ad83-08db93e7d61b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZ47IgdxhdWmv6NFwtf69G4+oIUzvFBaUmUwF0KZX/Bv6mHEt2rlLZCjFi0e3kxc+QS5QLgGA2YNU1Qj7T2L7yJ5pX2/yT4N2BOsm+eptd1amOFEYWt/R66uf9aYJP1AMbeYKc2RAqC1ozxe6uS5y91UE9ff1cwlt/wtNPVlkAvHPZY7nQhsIjVIqNDYexcFzhfbvzRn7FwZLxL0HstgOerU9cyaAlehs+F4PBLnG4lXjo4Imn935yxR4QaSfzhUchm0I2EJGrhBFaGcVjocpbsnQeBKN7IAfJjKpMWmYoDzSWDrttRoh688OtCQeCnKFBIpm7z6f3IvNzV3GgM63bsUpBCSr7H+D9F0c/267fnKiqgMSjSJ+p+Jnbw6FJkIutANHSimApUB6byp3dbHtfboodniBPdFZhNCXy+KoQs9EjXW1lDZSnzYMZUpoQ9qqLJCyVgJlYdVWpvBKVJMisfdo2YHdFxXBg0ouNmsLtYzW9cFG/XnVdAygcr/nCeNusvIhkZ1FTB4zs9XZ5671/FV/Rqg/nRemjZfQ8qEyqtSuXbqYbw/Ebs0Luqts89EqFU4KKf0ucKa965dzWLFJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(1076003)(6506007)(83380400001)(26005)(186003)(316002)(2906002)(66946007)(4326008)(6916009)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(966005)(6512007)(9686003)(478600001)(54906003)(38100700002)(82960400001)(33716001)(33656002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JKdb0H1pHTfWFvf7sjFanAZpb4imR/8RDQw4gyocWywRDbTQSxgZErVGPjsw?=
 =?us-ascii?Q?1NCn2vCEQ8Qxw4KYXCuwuHpKtY/66pxWBNKkLERCddj2j54yxMClvItRl7HO?=
 =?us-ascii?Q?DlCmgE1r/+K3gDhanx/QREqEED59SQpsFOCS4zirHXb3stcUna3Mn/H3mQpF?=
 =?us-ascii?Q?1N+KW2m+VIURM6z8toHbnRbcFONSeecbm4IO1fQme1JkAw8Ktx5MQfurAPHn?=
 =?us-ascii?Q?ibK9FLXGj5wWzKcrUdI7SeD27KNe7ksM0KmjZrdmC1SHItAtCRqYoZjpAf6I?=
 =?us-ascii?Q?WVG/SmkBxZ91oFLidKsOdDP2gNzGmk601KVcyyHYTPiFM5F9jhQIL8VhVKTV?=
 =?us-ascii?Q?C/cGaU/FOEWXNhWfqjLZyedYkUEFZ4a3s3bj95wmJdosixgVz8vtGlK8xNcb?=
 =?us-ascii?Q?pYE6btsxVjjECUmIN4UMSRssej+JB2MVJTr5+KYKjVcGdD1AH9M9O5oGx4h4?=
 =?us-ascii?Q?wr9Hu7hFNJwAy9cXdplg+vaRUe8Wi6ArqVX0np0cuSqx+0WKelkrk+leqIzv?=
 =?us-ascii?Q?28yvfbJLeQNl0XFbB1b9hDSMD8J+Sf3Di4gWIpCfLPNwuAHolacV9ITgvjPg?=
 =?us-ascii?Q?Mp5awTT02gsscAn5/taA3P6dJCFmmZEXSXN8+9XOMBZ3jDoNyicwPGqgYZC9?=
 =?us-ascii?Q?bEQBEHA8W656LpjnNKyfRu5uBL3rMlQpvDeIAlwWF49dCH8EhbSakKBnTUwB?=
 =?us-ascii?Q?wsYD9UF3t95hq8gDbhn2x/KhqlmtNgJKpfSkNbOu1VtFX74uGfOwUiFxJS/u?=
 =?us-ascii?Q?/gpjv3DG2YzwjycE8S0dC8AAHO2iDe1nk09rcXEU156A+LGJ1MHkm0KbjMDF?=
 =?us-ascii?Q?CoFGGjKvTH9C4aiUiNV1aC/+1T5rhKYqM0t8DgMJcFSCjl5O1E6Gx9Wuvfyb?=
 =?us-ascii?Q?RkCahuF2u98QOlAdtmyBVVpPJsNG0D4g8ZGZU/d4nuUg/QH4kYC1tLjXz3uk?=
 =?us-ascii?Q?GyE6vq8ypO0VycoWW1QLf9TO0oa/ymblxHLckB9kAWpSRA2C8fLmUhfH4H1a?=
 =?us-ascii?Q?PrePx4NUvgkxCclc5De9zcNauiar9xYutdE/oKoPpViQNPAKOf8RO2zW/J3g?=
 =?us-ascii?Q?4v98x6tPUsKoJtCocWW6SVHtZRrIWKZbA5qBmBfAGexGBe6MlIguYNjRtGDM?=
 =?us-ascii?Q?0F6nRfOv4GFk4l6bflmkqo/itCRUu2bqkF76UVOj/YpF9Gj+uZYD5zZpp8uh?=
 =?us-ascii?Q?Fk0GizUKMEkKkjwjP3MQ8ll3htIyjIz/UI8FCpwkd+q5TQ66V5pW/KKnkuyu?=
 =?us-ascii?Q?KxlnJ6zSKb6FfAxgF3ZWNh6LutKRAq9cCUf25ZX8G+9/3o1GAzXH8uXQ3vPb?=
 =?us-ascii?Q?SgRUSaImgRsS/3Nd+AFk9WlVd/zRN4MbqQm5HtnigCTg83XHRx5Wkm2rScK6?=
 =?us-ascii?Q?iR1XSwwebpsq/rNcJHW0Dd+TgBBbJ4mxy1/n7hAulXe5WIjtvvPTthee/1mV?=
 =?us-ascii?Q?f9OvVY9Spe79OpLCKOlkQaMFPIj5s5cBJlcBajmo8FGV4Y5VTBEayj6/Y7Ju?=
 =?us-ascii?Q?sHaDnk3GNzIg6Ln1qiwl5GqxzJn8jn+8y4jJKqSPpLcTAWmOvXBh29WN/KcY?=
 =?us-ascii?Q?Aj/5idkp9kBWbWSzuPJG9OgMf3cksIvbIpj+p7DR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b664d19-c2e6-41a2-ad83-08db93e7d61b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 06:06:54.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZR++nldJqHsR/Fp1DBqwU9QuprM6iOTW6OAO6epRecHM5BaAzBl9gJaho3kYnGlrIOL/XQlOLvDwKJyFWmzpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8692
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 07:54:38PM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a bug report on Bugzilla [1]. Quoting from it:
>
> > How to reproduce:
> > 
> > Had 24 CPU Alderlake 16GB debian12 system running with default kernel (from makecondig) on 6.5-rc4, exercised with no swap to start with.
> > 
> > using stress-ng tip commit 0f2ef02e9bc5abb3419c44be056d5fa3c97e0137
> > (see https://github.com/ColinIanKing/stress-ng )
> > 
> > build and run stress-ng for say 60 minutes:
> > 
> > ./stress-ng --cpu-online 50 --brk 50 --swap 50 --vmstat 1 -t 60m
> > 
> > Will hang in mm/swapfile.c:718 add_to_avail_list+0x93/0xa0
> > 
> > See attached file for an image of the console on the hang (I'm trying to get the full stack dump).
> 
> See Bugzilla for the full thread and attached console image.
> 
> FWIW, I have to forward this bug report to the mailing lists because
> Thorsten noted that many developers don't take a look on Bugzilla
> (see the BZ thread).

Thanks.

I can reproduce this issue using below cmdline:
$ sudo ./stress-ng --brk 50 --swap 5 --vmstat 1 -t 60m

I'll investigate what is happening.

> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217738
> 
> -- 
> An old man doll... just what I always wanted! - Clara
