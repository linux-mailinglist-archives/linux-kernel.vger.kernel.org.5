Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947A67F0CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjKTHTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjKTHTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:19:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79CDA2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700464768; x=1732000768;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=uz1afMksVAPt31Y81NA1PMJq0K6x+BWmGg55QUmFa0k=;
  b=B0xubswvsrgHKyiuz6ZP7JbXOHVchdqyt87qs/UmCy+Ofit511EcR2Dv
   ja9jYyvQ9lHuujYtCjRBHg0znesEoOJKc8YrIANxPsxcFverRxqSqlenN
   F6lHmysP016zFWNDh6jDg2ywmr0INsiYAIEcx/Ly0P7nXsJuePOtb83az
   /s41bl+Zs3iSbi5jkVuwA0HxtGa4VdObhu7xIUcmmq/GV2Q/MbUSs7T+z
   BxK3lPFllV6+PyApTUbdA4I/jG06Xgz1kwjh1JjpX4+gKRWoV0IcZkzLh
   Fy9CQZDXpu+6IGOIMYkYwajhre80SlO/G8MZSMxv/hd5JbeCF8LFj5p4y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="390426375"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="390426375"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 23:19:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="795380822"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="795380822"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2023 23:19:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 23:19:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 19 Nov 2023 23:19:23 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 19 Nov 2023 23:19:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mp8IFCi1cqRZO0b4ESXMfr2EfNIFWyfLHvdWWfmXRQUZXer0oh8AMPICOPT2HfawLbnqNJseK+CWa7rDX2p+0tXbt6/7UbvyK1vTDgXIJOWZRTZe/uCPFfD3+ONeNmGM2aTeRS1yNRxKZtqLKTpzGpdvlozFlZXYnRefFKabdsCfAVuNis1zXV9jCaGmhNm2/ovvrXlQ2nHsxR40JVYtmA2Ll8HG9XBPXJHvwa7SM8CVkyAsHZu/MPo0Hfr19xzMWbpmH9AftD8gcGGjlAj+mkOB7oSuKbdgpe/nUWQ13PkuOwhVnUXf7oNCqHM187mIXy1YegJI/DDuyVK+bpiHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9nyyCGwgkG+doGQ7LMAl7yrWIKmqZ/V3NtGmqOTSdM=;
 b=XBl7YaC8BypIGHm21+QNBygtO+7/f8VpCP+qZS5ua1pkBgX7Ki6vCUCxwXgDhuCzbPwenbFuO+MvtOcUnpsOrqO7PwtdmM7PSAT7+xMZXOZDIg1Rb1nmQR9cFR0fFVx4HtdeCDtUMTlMcjckcs3hx1GZ9ERi2xNZArhNoHJpRKrdYaaDdu1dA3wZYBdeJZ48YEu6Rk80hPKrfDa6nk4Y6/Q7CjvNKUEkSfAdO1DSA7zDEvGVIk8oyfKnDB86T7dJos6gY6XVUTiuZny7s2791/29144/RK5PBXZC1jmFPdk46waEICe5V+EqMzNgkXs73JTFSlbJtJo4B6zz10mH+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CY5PR11MB6260.namprd11.prod.outlook.com (2603:10b6:930:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 07:19:16 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 07:19:16 +0000
Date:   Mon, 20 Nov 2023 15:14:37 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>
CC:     kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: arch/arm/kernel/hibernate.c:29:40: warning: array subscript -1
 is outside array bounds of 'const void[2147483647]'
Message-ID: <ZVsHXZCZOKiPGOgD@yujie-X299>
References: <202310182007.8ziiRe0j-lkp@intel.com>
 <CACRpkdaB390mn2s3vrVAhaY9Portxdzc8bVkM5F3DtVy-k-r2Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaB390mn2s3vrVAhaY9Portxdzc8bVkM5F3DtVy-k-r2Q@mail.gmail.com>
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CY5PR11MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e1afe5-2db9-4133-d8ee-08dbe999012d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZrtq1VeVfJknOz+dQYky15QJGBzjoew8o499Wm5HErp0qsd+nyxj729+s9kFKVzbh5tHxC3kG0UwrC7livMSZUR/oXc2rVf6J28y/8yZDjBHNX08wWZcB0ky+ljVd/ag1uPVkm86/WvkBYBlpiCiuvVI4K6ER4tNp1PsDSQy+PvBFk/+qID1F0Vs1+YKdsT5e6HduYfTz1mBbr0nS5tHC7epmxgdfBKolc+HLfydymD1RiIW3qPSQWecPb2l18I3NiorAju0mavoxVVN6EzyUPtEbK5nvq5ZhId+mwVREY0UIh/N3shN/tJaJO4Up/Pw+6e3gb+PwZXdmvbMK9gJDzkHgLJlHdIptmVoU/6G9sqpE3L5iMnQ6krQy6MK+bSrsOtXoISp4i0AB17oIqac9zIF2xHt3QHVtic4Tcxg7H3UlvHYSj+ipLi0TnxHGZVvB3MwEkcKffcs4k0El0ZlcJh0yht++vgHdMEYnGuLec5GdiJov8YrVMusgcCQ9AGEU997MPw5HHDm97JxIrAwkbX8nj0BD3EKSE8XESjkdJtjL9qEoLhgJYStoVCdVN8QezyVCpgLgfXtykPYudZa4SXX9neoB4ZoTTT29UnZEqV0rXNwTiqoit5F6XEW2Ms957TpUBEkdIREJH7lDsoiwXAl4Vs/ClxPyRgWWog7oA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(396003)(376002)(136003)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(66556008)(66476007)(66946007)(110136005)(316002)(6506007)(53546011)(6512007)(9686003)(6666004)(26005)(478600001)(6486002)(966005)(38100700002)(33716001)(82960400001)(83380400001)(86362001)(5660300002)(44832011)(2906002)(41300700001)(8676002)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHc0dk83ZDhRRVBLZWtXb0lJaHB1ZnN3Zk9lRlNrS1MzSTlRWVRuRHlCdmxk?=
 =?utf-8?B?NDQyQjYwYmZ5d0xnOXNvT2t4MkFLamhDTi8rRWlET0kzVVJyY3JYRGZTVjhC?=
 =?utf-8?B?Vmx6L05WRmxhdXVsd2lVNEpnYUhWY0xPTXZEKzM3TnBrTlhQQTcxb2xyVXVh?=
 =?utf-8?B?UlhPVlRzdkJSRFhiMVlGTWRzcVA2dUYraVRJcHVvOUtrOW94WnNlaWViVGlY?=
 =?utf-8?B?bGg5Vm9kVnA2OVVITlNtK0JCNFFBOUJFY0VVZHc3N2tiZU12aXJkSnU3QXM4?=
 =?utf-8?B?V0xLK3VlYVpvSC84OVE4R0JQOUxXYUVGZWRrNm9ER2o4blJFaW90QkJtWjQr?=
 =?utf-8?B?eW1xTGpscmxCRHRaemF6TFJPaWZQUDVUdnAzVmZuS1F5Qnp0QjM3SWZWdHdV?=
 =?utf-8?B?TktEMWJBZFFJelhVY05oUytubzErclVkOXhacGxxZStLQWFTalcwMU90NExy?=
 =?utf-8?B?enRmcExHZjlYWmx2SVpJNmdQTDlTaERDalhMcEFqU1Z5UHllckxsdXlNWHdQ?=
 =?utf-8?B?UE9tWVNnb21vS0lmREFwK0xaQ0lMa0xpcGloUjM5S2VOQ0ZsMjc2YWNWc21T?=
 =?utf-8?B?QUVnalBpeGFLYjY1N0ZPaEs4d1J0ZzhpTjR0VmZZZFBRMDhseWxlQWtOTk4r?=
 =?utf-8?B?ZmppTmh4VGJTaHArMk5jOS9QeDMwZkFMQ2h0VmptSnpUd3hDdjRFZFFyUWZZ?=
 =?utf-8?B?eFJNOFRqNkNaeWhza1VsODZuMmZEaEZ2TFBxdVVwMDBHVis2ZkNSL0NuZjN2?=
 =?utf-8?B?cVZadnBSdFBFUGVNZVJhT3JrZUNOTWpJam9DLy9DQVRxTE5GMEVJbE94YWhM?=
 =?utf-8?B?VmFzb01CWVY0emh2TGFOQXBxa2tLUE9HYWxtQThONm1wNVBvTGhaWWZLSmVv?=
 =?utf-8?B?S1Z6bWdzQVRqVHJHTmZGYzl6ZmxkV3hlZzI0eFBxNnhVOEdTcjlibm1ycFpm?=
 =?utf-8?B?WW1FUStCazNXYVRubEFOSGsxNjdHSU14YUxCUGY5UkI2TCtYemFna2xiUlo2?=
 =?utf-8?B?bVdNNVlmOExXVXh5Z2FZOGJkbk9xd3JNODF6d2tCMWNKN2FyWVdpQlcvZi85?=
 =?utf-8?B?YUJjQ3RpYmlhM3VxalZOZEtVVVJKQklrc24zTnJzQTFkRk5KbXdJNjJsa0pN?=
 =?utf-8?B?MEJXRkxtMEozaEZ0dEQ5eks4MFkySHRQeVlwSjFYdVVuWFFROCs2RzVKcDY3?=
 =?utf-8?B?UjR2Ujd1Ni9KQmRFK2R6MzFpQTBZU1FNaW1UU3FnUXVET3pDMmxVdjZoTWV0?=
 =?utf-8?B?MFdkckxPeXVvZDBPOXpLVUl4OEFTZXpsNWczTWN3aVRCeXFFQ1VyQ1ZWU2dR?=
 =?utf-8?B?MlZtdHcyTlZVU2IvRnZXZStLallsUHNGY04xMUVkdU9YdVN1M0NGd2NpclFP?=
 =?utf-8?B?dDgxMWY5NnhXeWVlUFgxYm9hUGo4Si9uNDc1UjBzT2JSTDFPSk1iK2Rha0NL?=
 =?utf-8?B?cWNrc2wzMTlEbHQ2bEJYZHpBWEtPemxQeTFTYzNtUDhTTElvNkdrVy95aWE4?=
 =?utf-8?B?ZlpVdlZPSTI5UUtCUUxIUk4wVUdKeHFSdXBwZWk4VGwzRjViN1gybk1NZkh0?=
 =?utf-8?B?QmFMK1NIVTVZbDZSWE1UVXRsRkcxcnNibFZFdVFZRzBqSW9VaDR3YjN0UDAy?=
 =?utf-8?B?Um5MRmFEcmZXV3BXQkJvOEdrUDN1OGU0TVpYSmpxUURlS0pONXRnUHNSUGI0?=
 =?utf-8?B?Sm9FODNyMnY0bGxRU1g4R1F6VGQxazZBZnZVWTl2dUFOajd1L3R1ZUdEa2ps?=
 =?utf-8?B?VVdOMCthdUtZb2xIUzgrd2JoaEMxM2JUQnlVY1BPWFNJN2tWT3M0MVZZTEhR?=
 =?utf-8?B?QlBTWjVqZGtLYnRCMGUxVlo1Y2VuQmdKU3ZtYzEraXpyUndrdTFhQmgrMHYx?=
 =?utf-8?B?bmZWeEJTYVUvSjE2cmFZc0pISGt1N3FlK1VRblZpUm1kQ3dxcmxEaXFPaStQ?=
 =?utf-8?B?WHMrQytzbnRtQlB1QnV5QitQc0VMOFJ4cUViZEhFenc5U0l6Z2hrVnYxYzBo?=
 =?utf-8?B?YnZpcE1JNEgwQTVhNlVLRHkwYXVYTEZBVjJEMGFqbGo0WStFd2VUa085Z0I2?=
 =?utf-8?B?MUpVRndqakdWOWZacTg5WUpFOGtoMWpkM3lZVUJVRGJXMlpaZDM3UEtBSkRI?=
 =?utf-8?Q?iDqLF+TZgmpn7XrVB6F9AnAMX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e1afe5-2db9-4133-d8ee-08dbe999012d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 07:19:16.3289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s37Ndwjtmn+DfYPKFaXhz5jwvN7hEq4AbuLyOdiyR9oHgZhcA/zRubk/SbR/irwwicICRxa78CLhE6RBoyhIqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6260
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:19:33PM +0100, Linus Walleij wrote:
> Hi Robot,
> 
> On Wed, Oct 18, 2023 at 2:17 PM kernel test robot <lkp@intel.com> wrote:
> 
> >    arch/arm/kernel/hibernate.c: In function 'pfn_is_nosave':
> > >> arch/arm/kernel/hibernate.c:29:40: warning: array subscript -1 is outside array bounds of 'const void[2147483647]' [-Warray-bounds=]
> >       29 |         unsigned long nosave_end_pfn = virt_to_pfn(&__nosave_end - 1);
> >          |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> So the concern is that &__nosave_end  could be 0 and the -1 would make
> it wrap around?
> 
> It still has nothing to do with arrays, I don't get it.

Hi Linus Walleij, sorry that we couldn't explain this warning very
clearly. Let's consult Kees for more input.

Hi Kees, our robot has sent out several reports of "-Warray-bounds"
warnings. Thanks a lot for helping to analyze them. [1][2]

[1] https://lore.kernel.org/all/202309200904.CEED70DA33@keescook/
[2] https://lore.kernel.org/all/202311071521.099CAEA58@keescook/

As for some other reports, developers have some doubt about them that we
are not sure how to explain, such as the one in this report and
[3][4][5][6]. If it's not too much trouble, could you please help take a
look to see if these are valid warnings or false positives? Thanks a lot.

[3] https://lore.kernel.org/oe-kbuild-all/CACRpkdZ-1OcZ-cz0V218-VxAc07DMPvKWee3MHngs6Hrwv4zPA@mail.gmail.com/
[4] https://lore.kernel.org/oe-kbuild-all/20231019092258.c2cbwmmgffa33bro@vireshk-i7/
[5] https://lore.kernel.org/oe-kbuild-all/CANn89iKdMVNrV_0QienhpCJ98D7hj2sqOOYFhhSHBVHzvtkgWQ@mail.gmail.com/
[6] https://lore.kernel.org/oe-kbuild-all/CAOQ4uxjTv+5cB4z8TZQ02c5F3rags1HARoEQG9834A0+_+_twA@mail.gmail.com/

Best Regards,
Yujie
