Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E156780E09A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 02:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345621AbjLLBAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 20:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345607AbjLLBAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 20:00:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22614BE;
        Mon, 11 Dec 2023 17:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702342859; x=1733878859;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=hBHRWFlSRrkT6xJMbDPHp1uzhvytY7AQHWSOdsP9etc=;
  b=KpGIpwQXlbBROqdmQMPILGFB8PDemFYJwA2sdw8Q2XLwOwu9l7SGnecq
   /x1jwoc8U8NE+OmaVrCrvTzbr1GyAKZC87X3oo8AyBhqlaxWCYPE0matw
   N/BX0NHJcIm+XoLuypSbAoYih0Ao7FvtDs7zQWLeXtjwgt+qWYNwvbIrB
   ijM+JfvqewB0fruFsxmMTSNxi4QCO7cncXBqu/8JRdxfhiRJ0fFZ4XfX3
   KyYJHlK1uDwBe9+mxbKP241gRaoKB9hetoU1QpBSGJOCEtQt7rzKsgo6Y
   E2mZPtm+UHhxe7O5z5j1mbNfHrp4DedVTvbXqRqBvG0iu8sf+SogAWxZ4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="379731209"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="379731209"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 17:00:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1104695680"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="1104695680"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 17:00:57 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 17:00:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 17:00:57 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 17:00:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gq7RT3R//MehEU4x1lDBACPEgysyEVPE2asO+gumrmfXCYcAjgAej3SuMvCosem2+N4YVEtN67tR8oh3aR/JviG4ZxUY+k9nMVKZoSBWjqT3PlO9PA2ADYfLGl8xKQdn8ElbA8Oj+erqRqGIMWZXHe2NGmro2enjMyVzhyqxrkk4JYTenfduFXSduaSofVQCqO8jGvaF+0MXECBEhgP0shJ2Rqx4uK0rdcwAr5QoNBnpdCkOEnCbO8nbGYFnUJ7ijFMjED91xKx/eg8W5WGzQCLeNql9UolFPsPwoel+ly9V45glIDJNW4e9AHHMkS4p6wbb81sCv9ERY9Nrx62mtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN7bNh3n8n1mbr12KYJyumBJKW0owH0G0SB5WNUqicY=;
 b=G3zhxGumeYToIpkuycCV+rFNGIHUi7BIAEK73RbG7o3d54sYbkQyEXQ7ve535uNAQBCr/gcI7i1uhTBoB7KvyziSqVhjVlYqndVyDUeh2ejqeaK81Z3odMbySFU7iMXSeJTlxmP6JgFN5jiXOKDHuF13l04qhAjnB1QUYVbvbs+B4RjeZuM5YTNgDJDDO7I1GK7DSOmntze5TrFuBo1A2P7lOZwa0UzZ9gAmyrO+2LUHC43FH8uo1vLipCcE1p0eMPdHQelFa0Cn36hxXau8SuFAj6G8W2vig79qHxlSfZM/HI+jtTKWRVo1e8vvWA3Qw8cRZlxZUwfXIRtxN6oZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 01:00:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 01:00:54 +0000
Date:   Mon, 11 Dec 2023 17:00:50 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [PATCH v3 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Message-ID: <6577b0c2a02df_a04c5294bb@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231211-vv-dax_abi-v3-0-acf6cc1bde9f@intel.com>
 <20231211-vv-dax_abi-v3-2-acf6cc1bde9f@intel.com>
 <87msugxnx9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <aac91f0ae8774c521469d518585a499da52912a8.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aac91f0ae8774c521469d518585a499da52912a8.camel@intel.com>
X-ClientProxiedBy: MW4PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:303:86::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f9f861-a6b5-47fc-61fe-08dbfaadca5a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HmlJqAg8yTwgeVPrqfhbHtx22d4vvYKmsUc4muym2ZidNZI1J8XSSjR1FmQ65e1oc5uQ7Bx38jQli8Y20Rg8tuOlUmCJazaAQs8Y/cizcIpNCra6B2ZqKH3JzPmz4KYjl0Rag/w45ptDBQyF9f1IS7m2Bq8Mt4FwffaEYtmDA0O7vGlGT6Iv78N3bOUB1/Ej/d8XNNrS7z3S7KY8LZzmYGq5O1NfP4sClce1KWoAth6oriNZoo7A1GjKoMcfVSdLKrMvlOvVkn6MpueKkof3OSTCVX6v24vG1EP20/wpZpcX2FaS7GTIUkuY2lHGC/+qAILycu3ui05lRuSqqW5sy2gv4DiujKaOPsskggH6q+LYMxYb6uFPzObJxT2M1ylzjN9R0WNKezUsnBXdnN7g393a3l5hdxYvDWFOtBg9q2h5P5rrF6w8RsbfQxZOuqBc4unDcoWN6YQYq3QV0IP2v0nGOW/J3DHXWEMbVkg5yrCX3dmJBnVtX1U/1irDSWNBt8+1qoClUmUwaPC6WyRQ+gOCl/g0TA9k45ElVFbIQdlCgl4T5oiMDyYyI8AGpR2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(26005)(83380400001)(82960400001)(86362001)(38100700002)(5660300002)(316002)(8936002)(4326008)(8676002)(4001150100001)(2906002)(6666004)(6512007)(6506007)(9686003)(6636002)(66476007)(54906003)(110136005)(66556008)(66946007)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ngg1+YB3ddvq6mndiE5C18BjIUxNA1twXlzokqsRr1RxNueQdVrz/3nzC6?=
 =?iso-8859-1?Q?4ngZroy9HyFjy5qTuONkor27elsUC7OrZSpamb/7wDI0g3PpTNMgtU7r0S?=
 =?iso-8859-1?Q?EqeFg4It7M6vH89dF3gyU9Xz0HW2jx7kRavgPuuglfNWjzPVpayRjzyEUF?=
 =?iso-8859-1?Q?7DTu02PhjW4jNwSxLHLtv+vMY7vqyLL0vsLqG3uw6Fa2IKQxGEMp3fO+H+?=
 =?iso-8859-1?Q?jBA94LuYJLSLC5VFRBXbU0jAIFLSFi5ScGWBot3pdwqnORI+MguonoCAC7?=
 =?iso-8859-1?Q?/4WjE49wrWq6QHoUQ5oxRUFlmHUysveKMygtcTHPFYk8FBJ8cO/mDZVt61?=
 =?iso-8859-1?Q?pPdVq8Dv1ufOxpyT2btygUxRgkX8YqGwhWGO30jdRCKxyc4Z9jseS1Jao2?=
 =?iso-8859-1?Q?hLC5mk1iD+oH49GStMa70WqxOM52fJHQVxXs9zWMNFu+BirrY5tAhHqc0m?=
 =?iso-8859-1?Q?/g+kMhstUNH8Hzd5Kj7kYYubf23RpEhboUIFqWiABT9NaVj0BWF1UQG4C+?=
 =?iso-8859-1?Q?DC76MpCEs/z+PXnhih1I0Y+oJnkWRjhw5mcmxXsUapvYllfQyozatnnGKH?=
 =?iso-8859-1?Q?TpGYbDGQqrd3QLtd1rqrp/GZDh7jteuIEwZ2JasaZg2Yu5ga4uvk40mWbV?=
 =?iso-8859-1?Q?oK6AMxqotzBFyZ/0SK4ImWQDvFHveFv6i0iqXdnGBy+SlQLZ7UeULFzd8F?=
 =?iso-8859-1?Q?zfzJrcKvgCKpsSuWfK4xufMpTocOUA7rG/39lPBy6uUKNEsYXzoYgfP3vf?=
 =?iso-8859-1?Q?2YVDjOnhx2gng5VxySwyVmqw7OAkf3XMpGzYNr9CTbuZNApjTJFH5f+vhf?=
 =?iso-8859-1?Q?smWgg/W2JH5pT3h5LEHd4ts++EeqFE8o5fA2ItrCSqu6x5MNkwG5Q6t/W0?=
 =?iso-8859-1?Q?JL57Z8YrePTpGR0KDIwHxhTNDf6PMPYIU5nzd+FOx2YIND/9dOBYGT8mip?=
 =?iso-8859-1?Q?s6XNKgfonbWNU43hxW+MGP76icZeJLd2M3TQMyoMlBUi5VY1FqkJiiEh8/?=
 =?iso-8859-1?Q?73Z0Kv7gJM7LGdX/uyUp/kUpfURDd0W8VTU3mNeUra8Kd2Wurudd1sXqot?=
 =?iso-8859-1?Q?fdX9UKlYBt3x6DGidPktwxmZdR0DDHGyWUd2HKlL7jGGTRBHHU3KkY2Fi5?=
 =?iso-8859-1?Q?J7MnFpAZbmyvGbYqeq/5YbLvY72Rs75QW8qJvDRPVaUDpKxmZW24CZ35wz?=
 =?iso-8859-1?Q?/qhO4b8x6bnOhXjh8jZT3NSOHngd1fgVUF602WApey2IX0oNDbiLLOWFJZ?=
 =?iso-8859-1?Q?+p1gm+ja+LLAwl8x+N/OXEUzs5DJyp7JG7UwOstH7BcQDXp/4mFx4AVU/i?=
 =?iso-8859-1?Q?ffS5yBXrUIcP/gF3VRRexgXe4QxGcDHP/3eVDJ7eRI4t/n76CSE/gZcP/5?=
 =?iso-8859-1?Q?1+8shKCcIoLjXBy5cOSi8kWy/kfIJ5eqjhHYaGfTTYnqiqYjGXqSTmQcsK?=
 =?iso-8859-1?Q?W3QgWQJuGJ8RQl5kDSXSjV4+i+4hZ7DhLk1iXUt/fXqetET7fuWM8Czr1l?=
 =?iso-8859-1?Q?XrNtdNudsH4uKnC8/4dl/+5pUqxOmDb5nsjZofiXX+ktYddwK8/4vMICCT?=
 =?iso-8859-1?Q?juK22iMuAs4VXfkydF8gs5oPQ1LX7CQIUOnVc576iKkueZ72ADoM/NfIcP?=
 =?iso-8859-1?Q?7Y3OLtvhphUjzOppKMvowU82a/X77dJCbMHeO3lS5N7ttxZK2JVkHJGA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f9f861-a6b5-47fc-61fe-08dbfaadca5a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 01:00:54.6050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYgq9Z6b9cgBaPda7m6K5Gz9vtWmuwoMlfIPns6V2+aRvgjkuYCXgdNUJWYbD3UD8tBCYrbxSytVuBax7TAuyoucQXdtfd69tkA+yLvyC/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5191
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verma, Vishal L wrote:
> On Tue, 2023-12-12 at 08:30 +0800, Huang, Ying wrote:
> > Vishal Verma <vishal.l.verma@intel.com> writes:
> > 
> > > Add a sysfs knob for dax devices to control the memmap_on_memory setting
> > > if the dax device were to be hotplugged as system memory.
> > > 
> > > The default memmap_on_memory setting for dax devices originating via
> > > pmem or hmem is set to 'false' - i.e. no memmap_on_memory semantics, to
> > > preserve legacy behavior. For dax devices via CXL, the default is on.
> > > The sysfs control allows the administrator to override the above
> > > defaults if needed.
> > > 
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: Huang Ying <ying.huang@intel.com>
> > > Tested-by: Li Zhijian <lizhijian@fujitsu.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > > ---
> > >  drivers/dax/bus.c                       | 47 +++++++++++++++++++++++++++++++++
> > >  Documentation/ABI/testing/sysfs-bus-dax | 17 ++++++++++++
> > >  2 files changed, 64 insertions(+)
> > > 
> > > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > > index 1ff1ab5fa105..2871e5188f0d 100644
> > > --- a/drivers/dax/bus.c
> > > +++ b/drivers/dax/bus.c
> > > @@ -1270,6 +1270,52 @@ static ssize_t numa_node_show(struct device *dev,
> > >  }
> > >  static DEVICE_ATTR_RO(numa_node);
> > >  
> > > +static ssize_t memmap_on_memory_show(struct device *dev,
> > > +                                    struct device_attribute *attr, char *buf)
> > > +{
> > > +       struct dev_dax *dev_dax = to_dev_dax(dev);
> > > +
> > > +       return sprintf(buf, "%d\n", dev_dax->memmap_on_memory);
> > > +}
> > > +
> > > +static ssize_t memmap_on_memory_store(struct device *dev,
> > > +                                     struct device_attribute *attr,
> > > +                                     const char *buf, size_t len)
> > > +{
> > > +       struct device_driver *drv = dev->driver;
> > > +       struct dev_dax *dev_dax = to_dev_dax(dev);
> > > +       struct dax_region *dax_region = dev_dax->region;
> > > +       struct dax_device_driver *dax_drv = to_dax_drv(drv);
> > > +       ssize_t rc;
> > > +       bool val;
> > > +
> > > +       rc = kstrtobool(buf, &val);
> > > +       if (rc)
> > > +               return rc;
> > > +
> > > +       if (dev_dax->memmap_on_memory == val)
> > > +               return len;
> > > +
> > > +       device_lock(dax_region->dev);
> > > +       if (!dax_region->dev->driver) {
> > > +               device_unlock(dax_region->dev);
> > > +               return -ENXIO;
> > > +       }
> > 
> > I think that it should be OK to write to "memmap_on_memory" if no driver
> > is bound to the device.  We just need to avoid to write to it when kmem
> > driver is bound.
> 
> Oh this is just a check on the region driver, not for a dax driver
> being bound to the device. It's the same as what things like
> align_store(), size_store() etc. do for dax device reconfiguration.
> 
> That said, it might be okay to remove this check, as this operation
> doesn't change any attributes of the dax region (the other interfaces I
> mentioned above can affect regions, so we want to lock the region
> device). If removing the check, we'd drop the region lock acquisition
> as well.
> 
> Dan, any thoughts on this?

Since this is a dev_dax attribute then this would have already been
synchronously shutdown when dax_region->dev->driver transitioned to
NULL. I.e. region unbind causes dev_dax deletion.

However, there's a different issue here as dev->driver was referenced
without the device_lock().

Additionally, I think this function also makes it clear that device lock
flavor of guard() would be useful:

    DEFINE_GUARD(dev, struct device *, device_lock(_T), device_unlock(_T))

...then I would expect something like:

        guard(dev)(dev);
        if (dev_dax->memmap_on_memory != val && dev->driver &&
            to_dax_drv(dev->driver)->type == DAXDRV_KMEM_TYPE)
                return -EBUSY;
        dev_dax->memmap_on_memory = val;
        return len;

...maybe with some temp variables to reduce the derefence chain, buy you
get the idea. Only prevent changes while the device is active under
kmem.
