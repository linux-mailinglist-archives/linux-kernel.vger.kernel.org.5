Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBF8800299
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 05:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377317AbjLAEeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 23:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAEeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 23:34:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0451E1718;
        Thu, 30 Nov 2023 20:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701405270; x=1732941270;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=J9Mor72VQRwo0Jl+GvZ800ZQjhgiBCgHMKjoa6gp/Rc=;
  b=lA3tTlCDMEc+fFKfcpEfwz/+bLe9gwMhnWXdiZOxdpNOurOHrYMJlkvu
   YGCJNl4scD/CHzip4HIq1ixQFqPqELPkyJMb34ZDIT1hd8hoksWanLUj3
   b4KWQa23mWTzEtML65ISNFgHqbzMzM4nAIjYx7VdkTNr9I72Uo1MV/JRP
   JMSEG2M316Bm5MZqaUvX9C1XwIOHE1mnE9DqwANR9pCK1Xsr2Rf2iX/Jr
   N4R9nyouGoI6FyHJnkqCveWKRlw0pt7aXd4yHPVEDTtKb8eeU+EzoT5Rw
   ORDLjm3p6kKr8PwpAzE2PEtOM9EXvFXh/eQo+edruo/9042z3kaKAdsUI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="320326"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="320326"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 20:34:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="803920506"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="803920506"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 20:34:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 20:34:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 20:34:29 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 20:34:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcvJxctd1qESREGLm39SQzNIkLHRfpi+finko/lKIvlHMopdz/H/lHh58WZ2732tMnNaJNPVTKXmCsOM7zQIlhZITd0k0HCClCIeG0BDuwFF6mhYxr5ogUSFsPYH30Hs2n991Q0o9w0Vzvpp0Bzmowq9fHdH0bGopn+0TMF2mvz9pe9WDfTYg2OUBdmr3OEPeMPXtERL/8PQfot+X3ClGmyl6bwc6qNC3P6L0ElmhwBFs0VqkwRxGIMCkIKTTwVFjJOxslMjjGo5ML8YuZz7Ha+UN4M6uyqTUBqABNu8dv5LLc4a/K/8fGaVNgDLGum58+BZpq4z9kceGVmDc5gAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKQGSWPax2X9Qp4jPT6f4/wNDb8mYFyLDfq0lyNC6fM=;
 b=ITX9y/Xzt8BbRjpRnLCLAkLG6S/TWFT2pcFIewVHboIheqgCWNCmqN6KtfsCYeKPuikALcRsKwJzl59DTILJ3mHEgebeUjwYYdUUS7fVxjLNGbn5ZiajiOiM4anFvFSu1ZQciljnGR2S4GACdKBpeqYQyE6CkNAcet0l/TFrVW0R4m5DKkMREUOWHQ7SC8nYk7OzPO+N3aE4zTgVUCo6EPPBLzwUgxWU8CMM1opblIADa2tjsqujk7hcIfB6O6dyDnb5AwYZG/EsUJYttw8ZokPWPKhhvOpxLlDHM2kn+Q/drPzF8gaH4bZaP2r2UwmEcvdDb0PaANsMYSHsS0IMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DS0PR11MB7382.namprd11.prod.outlook.com (2603:10b6:8:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 04:34:25 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e%5]) with mapi id 15.20.7046.023; Fri, 1 Dec 2023
 04:34:25 +0000
Date:   Thu, 30 Nov 2023 20:34:19 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Ashok Raj <ashok_raj@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, <jdelvare@suse.com>,
        <fenghua.yu@intel.com>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/3] hwmon: (coretemp) Remove unnecessary dependency of
 array index
Message-ID: <ZWliS5pSORH1Ua9J@a4bf019067fa.jf.intel.com>
References: <20231127131651.476795-1-rui.zhang@intel.com>
 <20231127131651.476795-3-rui.zhang@intel.com>
 <ZWk2ZAxuyOFDCTmv@araj-dh-work.jf.intel.com>
 <b4723259-92a1-4c9a-8f4a-52b4b61940c5@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b4723259-92a1-4c9a-8f4a-52b4b61940c5@roeck-us.net>
X-ClientProxiedBy: MW3PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:303:2a::27) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DS0PR11MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: c83d2b57-d99a-46de-9b01-08dbf226cc09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: py7i/KkXhLJI+DEoh4dnDFojpw0WVVB0IJ/y0E0gum3X6Kawtm5QJ1Ixf8uvMlgmUL8Kmka4mpcv04NNUo5lbI6uiFlTwEt6zYP23G4iFbYasfLLLfZPtgwCh+rRO/tJ1MMlle3BL5a7GJqcVFqSt83SQcWweUACoCaSyziVfJ+w1DhDk98Iwyc+6Cp34X8aFPYRPMyfWq+zo3Ewr6mVPWQ9SNzQQRK8xsJX8P6uSMgdMKYSjHyDhuLGsj9IaVZU7r3a6uu3i9vZzBmCbwfqnJemifP85DljeIdhGcuXtVm0NDZTtBD5Va6fO/MUIzILUm1jiickYQHh/9R3CD5HrygMA8iwsL/00VdfN27jSR0pWo+eGtue5ihqWFFNB1UUbc0YXuWpwxgtWLPsitMbnH2HSZCId2a4HuYjpslRBMDhYcxTMCUbsp7K3ueUmUAK8OlrtwrAxz8uqc/L9otdmp5rFrfhCwuUzxyieJYC1qSf/a1G1oc3DGYoj9xxr+C32LKKkKXG2wH62RLxGWPEp2R/ve5hjkk9ugKEvNLXJdGwUT7xrMcBO3+isQhGJby5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(82960400001)(38100700002)(5660300002)(2906002)(53546011)(83380400001)(6666004)(6506007)(6512007)(478600001)(66476007)(316002)(6486002)(41300700001)(66946007)(6916009)(8936002)(66556008)(44832011)(54906003)(86362001)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Ipyj215orJqCdObHEHJuJTvPBULfIQUTFWlG9HVmHaoaJ3dL4IT1sY5vL+0?=
 =?us-ascii?Q?1yay5kavz42eMRX45O5dtbmGubxrX4+WI0j4XjgpxYd/KL13cQ+3/oOMfWjJ?=
 =?us-ascii?Q?wA6/QI8LvlT3SEJ4QG8ghvgl+lgVs0ww9HcNEFtW1u7KWraX0KH8+ByU4YDs?=
 =?us-ascii?Q?stbp7Xewey6X8fcNAz3dUrgzIZ+IsSoK0/3h7mh0XhS1b4oQr5PEAV7PirB2?=
 =?us-ascii?Q?WjtDh6sPVq8w06yI0GPOvR8gn+pSNdnFHI+n2EhsVPto/rHnDo7PRAlxKy2t?=
 =?us-ascii?Q?Ecs2+X0LouuU+VHYOorBI6N0o7y10gG7o5OhH3RzBtFn1OAOcrSTw3cnN7dY?=
 =?us-ascii?Q?bvTKVPT8uST0iMdNnqqSjxwZfJGxCA6/EDbFUdaAAfciFM/amh0hCaD57twm?=
 =?us-ascii?Q?ClT5XXspQVY1BCQl5OJjjVn7ycwgnxw/l4mbaj2Hv+/XuNaTEfIlqnEG/vm4?=
 =?us-ascii?Q?Igi4ifOHrFn7IjweAZU+meVuXIJhEPa8Ajh/k17h/D0VIpButiS+8tH7aqX5?=
 =?us-ascii?Q?F34rVnrGsZR/hM9+3ZU6L4bL0aOCy7T6JsPenWt6vvOKZKfz/UO8k9pFmYsa?=
 =?us-ascii?Q?F51RL8GXuZdUJTwub9HWLwigOCLSrjwGQzb/t6JDrUN9aCzc3Gv0ZgSe25rK?=
 =?us-ascii?Q?1F6FRlp7sHbkvxxWY/8U6F6Fh7l5rJiJ5qJ1SQ+UQDS+YoX8QUj7zTlNfCCK?=
 =?us-ascii?Q?4ZbFTyICpWIb7nwdSexkSqVTB7FaZuU7/uJY+d5YpTuat+BaESijcw412+Px?=
 =?us-ascii?Q?JoKh8+3t7AXexOR4+lfx5Sj2YHyT6EkmDBiHFIwTAg06HZdVD+D+3fA0Te4p?=
 =?us-ascii?Q?12M73/CNskuNXCNnYmKU5me91HCbCJiabUGe/3hJVo4v9G7YtsevQL1QdoGj?=
 =?us-ascii?Q?Te8/WOMCxir59vOox1zXUDhJ6rcJ8KZ1hNOQPgGd22P1BA/Y0K6gp2o+X5HV?=
 =?us-ascii?Q?Bcko0ZYCB/DUQQi3sdfz4YnrzDTjrB+wh/IUSV0rMTzAS88f+JdaQuBXyGyP?=
 =?us-ascii?Q?yfMYjjkEb68zMpIhsAZmzc4uwFa/VB8rsv0jzxaqdtQbKiQn89/T/8umGIUE?=
 =?us-ascii?Q?ijQkqr6gqsc4oxPSw1fouE5a6VL1he9RV8YdX36TAJGlYYuMw4oGt3E85i2W?=
 =?us-ascii?Q?VjN4MLXLDDIRGwi7W9TercWMSdWa4R/7UldCNshmM34b0ohTSrV8iQqdd37v?=
 =?us-ascii?Q?0FZzADQJY2lxG+bhlkMpUZhZ0hWMX/wmIAcGSfQwD/GUh8hhIxHITPqp/LA2?=
 =?us-ascii?Q?Qvi68jxJqvl6MAuUBld9swW97zxnlNcj2WuTshdFCYf6LwCfQGux6+QcpQOO?=
 =?us-ascii?Q?lyp0RObFmeI6uTXnaAA1I6YHYrA493dLPNkMHKiQRarZx4uOi53AFxqxCdnL?=
 =?us-ascii?Q?DrjiV/kTudO7wmHen5mZFxqSHtIwnhQDncUFkxSV/69ESPh7C3MtVe3R8F/Q?=
 =?us-ascii?Q?+l7wCSrVxBFoe2xxu8Xngeox8Jqt1gK7/R6aEqxW/wEvVZUx7BGEUfgxycct?=
 =?us-ascii?Q?mV0F5+MMKYtzcNwhIE5aaA0FwZpCV9qVl6FS5M4xfrkf9GjPtXK82uoJOAQ6?=
 =?us-ascii?Q?PcvBKLlxrdo4HlMlnNEy6gtnV1+atmXULD7kpYygYoZkLrEkS794Wuo5e67r?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c83d2b57-d99a-46de-9b01-08dbf226cc09
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 04:34:25.0101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fw9aeDqjIdJ4xxSYYXuzukHiDHEHftR+Qyzc4mW2PTxEcpT0DfPav7gSy8S5qgQ1kvWA0uTpV1Vn25b9w1PT5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7382
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

On Thu, Nov 30, 2023 at 07:26:31PM -0800, Guenter Roeck wrote:
> On 11/30/23 17:27, Ashok Raj wrote:
> > On Mon, Nov 27, 2023 at 09:16:50PM +0800, Zhang Rui wrote:
> > > When sensor_device_attribute pointer is available, use container_of() to
> > > get the temp_data address.
> > > 
> > > This removes the unnecessary dependency of cached index in
> > > pdata->core_data[].
> > > 
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >   drivers/hwmon/coretemp.c | 15 +++++----------
> > >   1 file changed, 5 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > > index 6053ed3761c2..cef43fedbd58 100644
> > > --- a/drivers/hwmon/coretemp.c
> > > +++ b/drivers/hwmon/coretemp.c
> > > @@ -342,7 +342,7 @@ static ssize_t show_label(struct device *dev,
> > >   {
> > >   	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > >   	struct platform_data *pdata = dev_get_drvdata(dev);
> > > -	struct temp_data *tdata = pdata->core_data[attr->index];
> > > +	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_LABEL]);
> > >   	if (tdata->is_pkg_data)
> > >   		return sprintf(buf, "Package id %u\n", pdata->pkg_id);
> > > @@ -355,8 +355,7 @@ static ssize_t show_crit_alarm(struct device *dev,
> > >   {
> > >   	u32 eax, edx;
> > >   	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > > -	struct platform_data *pdata = dev_get_drvdata(dev);
> > > -	struct temp_data *tdata = pdata->core_data[attr->index];
> > > +	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_CRIT_ALARM]);
> > >   	mutex_lock(&tdata->update_lock);
> > >   	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
> > > @@ -369,8 +368,7 @@ static ssize_t show_tjmax(struct device *dev,
> > >   			struct device_attribute *devattr, char *buf)
> > >   {
> > >   	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > > -	struct platform_data *pdata = dev_get_drvdata(dev);
> > > -	struct temp_data *tdata = pdata->core_data[attr->index];
> > > +	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_TJMAX]);
> > >   	int tjmax;
> > >   	mutex_lock(&tdata->update_lock);
> > > @@ -384,8 +382,7 @@ static ssize_t show_ttarget(struct device *dev,
> > >   				struct device_attribute *devattr, char *buf)
> > >   {
> > >   	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > > -	struct platform_data *pdata = dev_get_drvdata(dev);
> > > -	struct temp_data *tdata = pdata->core_data[attr->index];
> > > +	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_TTARGET]);
> > >   	int ttarget;
> > >   	mutex_lock(&tdata->update_lock);
> > > @@ -402,8 +399,7 @@ static ssize_t show_temp(struct device *dev,
> > >   {
> > >   	u32 eax, edx;
> > >   	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > > -	struct platform_data *pdata = dev_get_drvdata(dev);
> > > -	struct temp_data *tdata = pdata->core_data[attr->index];
> > > +	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_TEMP]);
> > >   	int tjmax;
> > >   	mutex_lock(&tdata->update_lock);
> > > @@ -445,7 +441,6 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev,
> > >   		tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
> > >   		tdata->sd_attrs[i].dev_attr.attr.mode = 0444;
> > >   		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
> > > -		tdata->sd_attrs[i].index = attr_no;
> > 
> > I was naively thinking if we could nuke that "index". I can see that used
> > in couple macros, but seems like we can lose it?
> > 
> > Completely untested.. and uncertain :-)
> > 
> 
> If you had suggested to replace
> 	struct sensor_device_attribute sd_attrs[TOTAL_ATTRS];
> with
> 	struct device_attribute sd_attrs[TOTAL_ATTRS];
> what you suggested may actually be possible and make sense. However,
> suggesting to dump the index parameter of SENSOR_ATTR() completely
> because _this_ driver may no longer need it seems to be a little excessive.

I should have highlighted the uncertain :-).. Said naively thinking to add
color that I'm calling it blind. But what you suggest might make more
sense.

I was just suggesting if there is more cleanup that could be accomplished along
with this might be a good thing.

I tried a quick and dirty cleanup.. apparently it was more dirty I guess
:-)

> 
> > 
> > diff --git a/include/linux/hwmon-sysfs.h b/include/linux/hwmon-sysfs.h
> > index d896713359cd..4855893f9401 100644
> > --- a/include/linux/hwmon-sysfs.h
> > +++ b/include/linux/hwmon-sysfs.h
> > @@ -12,36 +12,35 @@
> >   struct sensor_device_attribute{
> >   	struct device_attribute dev_attr;
> > -	int index;
> >   };
> >   #define to_sensor_dev_attr(_dev_attr) \
> >   	container_of(_dev_attr, struct sensor_device_attribute, dev_attr)
> > -#define SENSOR_ATTR(_name, _mode, _show, _store, _index)	\
> > +#define SENSOR_ATTR(_name, _mode, _show, _store)	\
> >   	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
> > -	  .index = _index }
> > +	  }
> > -#define SENSOR_ATTR_RO(_name, _func, _index)			\
> > +#define SENSOR_ATTR_RO(_name, _func)			\
> >   	SENSOR_ATTR(_name, 0444, _func##_show, NULL, _index)
> > -#define SENSOR_ATTR_RW(_name, _func, _index)			\
> > -	SENSOR_ATTR(_name, 0644, _func##_show, _func##_store, _index)
> > +#define SENSOR_ATTR_RW(_name, _func)			\
> > +	SENSOR_ATTR(_name, 0644, _func##_show, _func##_store)
> > -#define SENSOR_ATTR_WO(_name, _func, _index)			\
> > -	SENSOR_ATTR(_name, 0200, NULL, _func##_store, _index)
> > +#define SENSOR_ATTR_WO(_name, _func)			\
> > +	SENSOR_ATTR(_name, 0200, NULL, _func##_store)
> > -#define SENSOR_DEVICE_ATTR(_name, _mode, _show, _store, _index)	\
> > +#define SENSOR_DEVICE_ATTR(_name, _mode, _show, _store)	\
> >   struct sensor_device_attribute sensor_dev_attr_##_name		\
> > -	= SENSOR_ATTR(_name, _mode, _show, _store, _index)
> > +	= SENSOR_ATTR(_name, _mode, _show, _store)
> > -#define SENSOR_DEVICE_ATTR_RO(_name, _func, _index)		\
> > -	SENSOR_DEVICE_ATTR(_name, 0444, _func##_show, NULL, _index)
> > +#define SENSOR_DEVICE_ATTR_RO(_name, _func)		\
> > +	SENSOR_DEVICE_ATTR(_name, 0444, _func##_show, NULL)
> >   #define SENSOR_DEVICE_ATTR_RW(_name, _func, _index)		\
> > -	SENSOR_DEVICE_ATTR(_name, 0644, _func##_show, _func##_store, _index)
> > +	SENSOR_DEVICE_ATTR(_name, 0644, _func##_show, _func##_store)
> > -#define SENSOR_DEVICE_ATTR_WO(_name, _func, _index)		\
> > -	SENSOR_DEVICE_ATTR(_name, 0200, NULL, _func##_store, _index)
> > +#define SENSOR_DEVICE_ATTR_WO(_name, _func)		\
> > +	SENSOR_DEVICE_ATTR(_name, 0200, NULL, _func##_store)
> >   struct sensor_device_attribute_2 {
> >   	struct device_attribute dev_attr;
> > diff --git a/drivers/gpu/drm/i915/i915_hwmon.c b/drivers/gpu/drm/i915/i915_hwmon.c
> > index 975da8e7f2a9..c3bbf2f7d6eb 100644
> > --- a/drivers/gpu/drm/i915/i915_hwmon.c
> > +++ b/drivers/gpu/drm/i915/i915_hwmon.c
> > @@ -239,7 +239,7 @@ hwm_power1_max_interval_store(struct device *dev,
> >   static SENSOR_DEVICE_ATTR(power1_max_interval, 0664,
> >   			  hwm_power1_max_interval_show,
> > -			  hwm_power1_max_interval_store, 0);
> > +			  hwm_power1_max_interval_store);
> 
> That driver could and should have used DEVICE_ATTR() instead of
> SENSOR_DEVICE_ATTR(), and there are various other drivers where
> that would have made sense. Actually, it should have used
> DEVICE_ATTR_RW() but that is just a detail.
> 
> However, there are more than 2,000 uses of SENSOR_DEVICE_ATTR() and derived
> macros in the kernel. The large majority of those do set index to values != 0,
> and the affected drivers would not be happy if that argument disappeared.
> 
> Frankly, I am not entirely sure if you were serious with your suggestion.

Certainly can't be serious.. but I was hinting at additional cleanups.. but
I picked the wrong one obviously. 

> I tried to give a serious reply, but I am not entirely sure if I succeeded.
> My apologies if some sarcasm was bleeding through.

:-)... sarcasm is OK.. 
