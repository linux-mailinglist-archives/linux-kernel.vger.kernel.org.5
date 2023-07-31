Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8068176A000
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjGaSFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjGaSFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:05:47 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261D6E4E;
        Mon, 31 Jul 2023 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690826746; x=1722362746;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=7qkOKJuif53pcMyrdN2zGNpYw/8E1+uUg9XB1D/W7eM=;
  b=SgsamL46fxnf7V1eednXxow4yCc3ukBSAY2WjW4RcZkysbpXLUPInfLj
   ei0JPA4DNQzWNCExxiOWn1wcwHigiUVlYnaoZsvQr/GC1nosypkHUTV/z
   strHeSAKwLdlbImHp8/a+DhRKnIte5JCVaAZ0CEM0ZSakyXqteVgJIgk1
   C+u/lkamfKwKIZFzAwGGzbI6Sb2xe+OG0m/GbZDdPaKPg5o5C4hcmtUwI
   +SY/TGUfkknCQOZYKBeYRc4zDBVcrBEC+gj+pnXJqBJ6Iv+ZAmEoR7R/j
   r73gu8aoOpJBVc0FtGiQCbZsJdEqNNNl/2bd7/bHyp8xEohzfUsiMhgmu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="348690841"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="348690841"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 11:05:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="902230979"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="902230979"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 31 Jul 2023 11:05:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 11:05:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 11:05:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 11:05:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNk4ZP2t6VEJ8ykxWmPhASuBWx3MUIgWfnFDhUU3wrFoVne+JWt8z18Am77nxnpngUmxuK6Xr634fKp+8Ji7dd1rEhVOZIbiECExUugXlUoea897MlGsKoNp84c2AYngIbRfO3Bdig1xH6Usptk8BqsmXfheJoBCTAu/lmdiRnD4J0/owcyRJFFRjE9mqR6ahrX4H7D9CcraF1jspJ3Hl6IDN76qKHgyfzFEr6b6esqxCEhHjvce10Z+Ey2948TupgWf3PXaESHix6Rmm6/mcQL4sQPVuCfZ1UpUBOvS9zx5CEI/ZX5ItyGN4378IlcEry7JMci0Db67RLaCsaN+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMLOzf0rgMNvevP17SrTRRwe/RjudxJnARR5PXcAUzk=;
 b=QbLaj0VK9iMSki5HFI24u+1ohiFzMIhSJnbCmy8zlgPM9LUPrj8G47EYEZCgka8/cpHLHqvSQr0B1SJU8yH7Zm25aFix2WbwDmFBdJWVgRQpFA8NS3CYOmo8di1wHIIYaPxWU+Ipc1akr9zsNW/440kETsggLe4ZwE5V/tysKRDEEGGoTqWo/caf8AE/DeoQZ0C8ihx+ldrGjWiamADIz7UIsmJGLRZ9PAyHctWLgD+t51qHvl+w9lmb0YP4RKwZQKTyS9psNOO9PF9qySo15UjGjnHMJm+2AfIszJ55RJI1QXK0S1FmnJLkV3BaHeKLYyVRpsjgB+KO0KitrZbcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8154.namprd11.prod.outlook.com (2603:10b6:610:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 18:05:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 18:05:21 +0000
Date:   Mon, 31 Jul 2023 11:05:17 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Peter Gonda <pgonda@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dhowells@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>, <peterz@infradead.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] virt: sevguest: Add TSM key support for SNP_{GET,
 GET_EXT}_REPORT
Message-ID: <64c7f7ddd777c_51ad029436@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <169057267580.180586.15710177655506555147.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6r=r_utT6sd_LD-2rO-GpH4zd1D04p04P8WF51BKX-JMg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMkAt6r=r_utT6sd_LD-2rO-GpH4zd1D04p04P8WF51BKX-JMg@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:303:dc::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: 8935d872-2908-4965-7146-08db91f0b4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0M32COV9Yhk4Kf2q9BjFeUcnc+6Bvu0LvpaH2yEQMrLgipv4cngYXgQDH7z2MwdgJoCMhAtiezaKtvjSOwBcWjdcKWZroTDS11qo4BBLMKpqiGGs0wa9Ss+deNbRI+hCL3aGiYJAomgwxnjdNRVnVL7eARTVGEVmr9HY/xJNyXqubX54gZW0yZwt0GRBTqKYr/xvkkPDYEZDDfAbFBRYSm5FGcfQjqL3Lp7Ri1unnkqHHc5EsfuqkFJoJ94mwjH89/ypke54168RbCY3kQ1DCV/mbvOI2GnUewXfoACddFQn6SLl+89xiRxZXMeJFDEHXOKy9ZyjBKz173lBg3QWAG6a28bKolbrVXSLcT7UOPqXvVYlG/r/InQvhl2dLqy34iOc9Osh+DQHXTqXpq6tnLjLh8om0sKTeUolz2b6YtoK5bCH4ZF92DKfPZO+cHuv7gVveqmr1cpq3f66Sb4tcEbmfEUV5HoVpgLCHovJTeFKXOSDP/8WwoTAinyyUC0N4LyjzY98iIN1PAf00cWs15rJMWU4tGw/KUbDPtBTOXHvG/9MiE0YpsV51QBGAjj+S60jC73POpWVPOdZ7tyOlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(53546011)(26005)(110136005)(6506007)(6486002)(6512007)(6666004)(966005)(9686003)(54906003)(478600001)(86362001)(82960400001)(38100700002)(83380400001)(186003)(66556008)(66476007)(41300700001)(7416002)(8676002)(8936002)(316002)(5660300002)(2906002)(4326008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVNteUpOaCsrOXUreWd5dFNRRDkxQUVFRGVKSnMwRmZ2R1V4SjFVaURHVFN3?=
 =?utf-8?B?RFJ0amVPN0IwKzBxYzIwbjd4R3RTZTlvMmxCZXp0RDdaY3RueXBFNHEycUlP?=
 =?utf-8?B?VGxCK20wRUluMDNmSU5YYmdRblZNTW1Zb2JoSTBFVUV5WWRubUVveGNESDgv?=
 =?utf-8?B?MzVoSmdnb0czM1MySTFlNS9KczZmaHVXci8rbEhrVVFJMlZDbXdCM3ZVUnVG?=
 =?utf-8?B?d25UY1R1NVg1cnFKcHMvVDNzQUhYUmFwM2hSVkYrVmN3TjRQcWxEOGU1ZE5t?=
 =?utf-8?B?RlBmbUh4T2k3dXh5Mjhlbzc3VldTQjlNdm16NTZUU0ZpWmpSZ0NnWS80TXYz?=
 =?utf-8?B?RzArMFMwN3lScVE5OW1RQzJhUENES0FBakp6eVYrazVhTU1kT0tsRHI4ZC9C?=
 =?utf-8?B?TURZRmUzbjkyazhmZW81a2Y5dGxtdHRJWGl2aTVHcUxzaWpzSFV0amZ0MGtS?=
 =?utf-8?B?YVpQUUxmQ2FHZnMrZGVSS3ZxRS85UWtUaml0WUQxeG9XcEJ2dlBmMzRGUkpi?=
 =?utf-8?B?N2t3TCtlR2dCbGEyMDVnYnN4SXo4Y3VjZFIwYXVDWFoyVmViZUdjajNxK1R0?=
 =?utf-8?B?MUJORElVNVVHeUlYamNBUXhzVzZDUnV3YzNydkRra2pUT0xWOHIrYk9Oc24y?=
 =?utf-8?B?aFhGZk9CRUcvSzhJQzIyLzE0YzVrb1NOenB1WTRrVThaNDZ3d2x2NG1qME9p?=
 =?utf-8?B?alZTRTg3NEJhcjVneWFqeXhBRTBBNUVQV0Nhd05QclRvcnB2UEZ2NzkydmpL?=
 =?utf-8?B?amQvTElKOFhPN1EwWEtpZ3JSbjJYVGRLVnZPZ0oxazA0bFB1aGRPaXJPSGgv?=
 =?utf-8?B?bXdxMWV5dUZkUm1nQnJNMVMvRTlMNnp2a1JNOWMrcU5Ka0ZxandvT2RSMmRt?=
 =?utf-8?B?Sm5DMXg4RmpmUCtnNERLaTFrLzR3UmRtRFFCZUY5elkybXNUb3VaZk15NmJS?=
 =?utf-8?B?anl5cGJhMjJFaTc4emdZOE1xcU5nUmg0NlNNbm1WZDhNck1QcHNFSGxKZW80?=
 =?utf-8?B?TlBJQXdjZG40MncyMEN4N3RYa3Fkdmxqd2ZiRGhnaisyZ2J6ZXVxQzRScWQ0?=
 =?utf-8?B?YXdwTGxlaU5INGcwTVJtUnY3cG43TUR3am9PVEZORGt2YUNHWDBZZkJJbCtt?=
 =?utf-8?B?S2QxZldPRUVxc21rZU5hd2FXNy95bmwyKzd2Sy8vc3hTdHV2bVUzM0V4SXV1?=
 =?utf-8?B?bmdoNEpoTW8vVWd1ZXdEZnBnbnZJc0xnUVNiSmZqTCtWdXl1ZFZQMTF3aDNK?=
 =?utf-8?B?ZTBFTEFvOWhOdnFOTTFnY0JodUZXeTRoOThWTFFYSDFpWDdmUGNvUG9xcWZu?=
 =?utf-8?B?YzR0Y1hqQzQ1SlFXTHlOZlhXWWlSTmhYRlZrQk9jZGZIc0FuQitEYk9MVXI2?=
 =?utf-8?B?K2s5UXVyRGttK2FFRWE3K0R6N0RNRXFWTi9tKzU5L3k4WDJLMkxrOUl0RDQ4?=
 =?utf-8?B?Yzl4cVgydTg1N0hYeC9uYVN6M0FsL1VrSGJSOVM4dlhWbTJlUnBpMVV1R2t1?=
 =?utf-8?B?blEreTVrU05YL2pQZnp5bnpkQTV4MktKYXpQanNPb0xkVGJDa3BUajRZNjVa?=
 =?utf-8?B?UXZ2dVU1UytNVkVoUlR2eTlvS3BBVlJvYnBhNHNTekVNUnQrd1ExZzltL2Vx?=
 =?utf-8?B?V0dxN0xQTGwyNSt6UkpXOUVxRC9PbC9yeDBJVjVjbHRvek5ZWmRZejM3ZGxJ?=
 =?utf-8?B?cVBHU1NTbWZ0QXoxNVdsQWU0L0JLajJEc21Gb3M1ZVc0T2lHUnlyRnNRR0pB?=
 =?utf-8?B?S216bVhJR0Nya0pkOWpsb2pDUnY4azByY0p6YklUL0swMVkwVkx4MUlVaDh6?=
 =?utf-8?B?NHJ6TTF5Z0pHL0xhUnp0aE9UY1djZ1hsTVBUcWlLZHVVZ0lWcTdTWURtdlRF?=
 =?utf-8?B?UVUxWkZVMkdqd2pWdjNOVzBteExTck5nZEs1Q0VkNGpEWnBueFJMOWl1Rkg2?=
 =?utf-8?B?MGRvQ1RBaHpUeFJFbkZWcXZ6WCtXT05oSmpBdm15UDFMNFovNkg5aUswRVZC?=
 =?utf-8?B?bHlPWDYvaFlVbVBDck9BcVQ5ZncxdFBHZmhjK0RBdXdCdnZsaXFJSE80Tlh0?=
 =?utf-8?B?YXVkVVhQOVVWdi9OL282cmlhcGg3UjN1QXpSdGdNY3ZscTlidzludFoyZFRJ?=
 =?utf-8?B?Wi9uV2ZhTDU2VTZEbnY3dkRjTW5LaFoxSzlqdGJ0NEJxTHRQSE11bCtkTndr?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8935d872-2908-4965-7146-08db91f0b4c6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:05:21.5470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hs/04jA58oEgij+4BbFt/2zP2Goo8eX46kSgURPBXFxGXORWDlQ+73BYjUkMdLMVe2iMvQyXFqmsFyWyroplj+1ME3NkDu2d7r8jOOlHan4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8154
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Gonda wrote:
> On Fri, Jul 28, 2023 at 1:31 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > The sevguest driver was a first mover in the confidential computing
> > space. As a first mover that afforded some leeway to build the driver
> > without concern for common infrastructure.
> >
> > Now that sevguest is no longer a singleton [1] the common operation of
> > building and transmitting attestation report blobs can / should be made
> > common. In this model the so called "TSM-provider" implementations can
> > share a common envelope ABI even if the contents of that envelope remain
> > vendor-specific. When / if the industry agrees on an attestation record
> > format, that definition can also fit in the same ABI. In the meantime
> > the kernel's maintenance burden is reduced and collaboration on the
> > commons is increased.
> >
> > Convert sevguest to use TSM keys to retrieve the blobs that the
> > SNP_{GET,GET_EXT}_REPORT ioctls produce. The flow for retrieving the
> > SNP_GET_REPORT blob via the keyctl utility would be:
> >
> >     dd if=/dev/urandom of=pubkey bs=1 count=64
> >     keyctl add tsm tsm_test "auth $(xxd -p -c 0 < pubkey) privlevel=2" @u
> >     keyctl print $key_id | awk '{ print $3 }' | xxd -p -c 0 -r | hexdump -C
> >
> > ...while the SNP_GET_EXT_REPORT flow adds the "format=extended" option
> > to the request flow:
> >
> >     keyctl add tsm tsm_test "auth $(xxd -p -c 0 < pubkey) privlevel=2 format=extended" @u
> >
> > The output format from 'keyctl print' is:
> >
> >     <pubkey blob> <auth blob desc[:format]> <auth blob>
> >
> > ...where the blobs are hex encoded and the descriptor string is either
> > "sev" or "sev:extended" in this case.
> >
> > Note, the Keys subsystem frontend for the functionality that
> > SNP_GET_DERIVED_KEY represents is saved for follow-on work that likely
> > needs to become a new trusted-keys type. The old ioctls can be lazily
> > deprecated, the main motivation of this effort is to stop the
> > proliferation of new ioctls, and to increase cross-vendor colloboration.
> 
> collaboration

got it.

> 
> >
> > Note, only compile-tested.
> >
> > Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Dionna Glaze <dionnaglaze@google.com>
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/virt/coco/sev-guest/Kconfig     |    2 +
> >  drivers/virt/coco/sev-guest/sev-guest.c |   87 +++++++++++++++++++++++++++++++
> >  2 files changed, 89 insertions(+)
> >
> > diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
> > index da2d7ca531f0..bce43d4639ce 100644
> > --- a/drivers/virt/coco/sev-guest/Kconfig
> > +++ b/drivers/virt/coco/sev-guest/Kconfig
> > @@ -2,9 +2,11 @@ config SEV_GUEST
> >         tristate "AMD SEV Guest driver"
> >         default m
> >         depends on AMD_MEM_ENCRYPT
> > +       depends on KEYS
> >         select CRYPTO
> >         select CRYPTO_AEAD2
> >         select CRYPTO_GCM
> > +       select TSM_KEYS
> >         help
> >           SEV-SNP firmware provides the guest a mechanism to communicate with
> >           the PSP without risk from a malicious hypervisor who wishes to read,
> > diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> > index f48c4764a7a2..2bdca268272d 100644
> > --- a/drivers/virt/coco/sev-guest/sev-guest.c
> > +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/psp-sev.h>
> >  #include <uapi/linux/sev-guest.h>
> >  #include <uapi/linux/psp-sev.h>
> > +#include <keys/tsm.h>
> >
> >  #include <asm/svm.h>
> >  #include <asm/sev.h>
> > @@ -769,6 +770,84 @@ static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno
> >         return key;
> >  }
> >
> > +static int sev_auth_new(struct tsm_key_payload *t, void *provider_data)
> > +{
> > +       struct snp_guest_dev *snp_dev = provider_data;
> > +       const int report_size = SZ_16K;
> > +       const int ext_size =
> > +               PAGE_ALIGN_DOWN(TSM_DATA_MAX - report_size - sizeof(*t));
> > +       int ret;
> > +
> > +       if (t->pubkey_len != 64)
> > +               return -EINVAL;
> 
> Magic number?
> 
> We only support asymmetric keys with public keys exactly equal to 64
> bytes? Is that only p256? SNP uses p384 can we atleast allow that
> curve too? But why not let userspace what key type they want to use?

The kernel has no control here. See Table 20 MSG_REPORT_REQ Message
Structure (https://www.amd.com/system/files/TechDocs/56860.pdf)

...only 64-byte payloads are accepted. I assume one could specify less
than 64-bytes and zero-fill the rest, but that's a contract between the
requester and the attester.

> 
> > +
> > +       if (t->auth_blob_format[0] &&
> > +           strcmp(t->auth_blob_format, "extended") != 0)
> > +               return -EINVAL;
> > +
> > +       if (t->auth_blob_format[0]) {
> > +               u8 *buf __free(kvfree) =
> > +                       kvzalloc(report_size + ext_size, GFP_KERNEL);
> > +
> > +               struct snp_ext_report_req req = {
> > +                       .data = { .vmpl = t->privlevel },
> > +                       .certs_address = (__u64)buf + report_size,
> > +                       .certs_len = ext_size,
> > +               };
> > +               memcpy(&req.data.user_data, t->pubkey, 64);
> 
> Again without any freshness from the remote party, of what use is this
> attestation report?

This interface is just marshaling the same data that could be retrieved
via SNP_GET_REPORT ioctl on the sevguest chardev today. So I would point
you back to vendor documentation for how this report is used. See "VM
Launch and Attestation" here:

https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf

I am just here to stanch the proliferation of new chardevs and new
ioctls for this TSM-common operation. This effort was started when TDX
patches showed up to take a 64-byte input payload and wrap it in a
attestation report with its own chardev and ioctls.

> 
> > +
> > +               struct snp_guest_request_ioctl input = {
> > +                       .msg_version = 1,
> > +                       .req_data = (__u64) &req,
> > +                       .resp_data = (__u64) buf,
> > +               };
> > +
> > +               ret = get_ext_report(snp_dev, &input, SNP_KARG);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               no_free_ptr(buf);
> > +               t->auth_blob = buf;
> > +               t->auth_blob_len = report_size + ext_size;
> > +               t->auth_blob_desc = "sev";
> > +       } else {
> > +               u8 *buf __free(kvfree) = kvzalloc(report_size, GFP_KERNEL);
> > +
> > +               struct snp_report_req req = {
> > +                       .vmpl = t->privlevel,
> > +               };
> > +               memcpy(&req.user_data, t->pubkey, 64);
> > +
> > +               struct snp_guest_request_ioctl input = {
> > +                       .msg_version = 1,
> > +                       .req_data = (__u64) &req,
> > +                       .resp_data = (__u64) buf,
> > +               };
> > +
> > +               ret = get_report(snp_dev, &input, SNP_KARG);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               no_free_ptr(buf);
> > +               t->auth_blob = buf;
> > +               t->auth_blob_len = report_size;
> > +               t->auth_blob_desc = "sev";
> > +       }
> 
> Can we reduce the code duplication between the branches here?

I'll take a look.
