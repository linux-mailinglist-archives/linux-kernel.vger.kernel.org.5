Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269747A23A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjIOQb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjIOQbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:31:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97315199;
        Fri, 15 Sep 2023 09:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694795473; x=1726331473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6M6rOq00dYpxIP2fvrgkrYRZSgkfk+XdNAGJQxwQQW0=;
  b=Cg2sSg7QKCndcfx8NeNaaHZT/dVMeeVvsTvTyOfclKP9VfStozh9cErT
   I7CzJRxJmxW9Lm9j7Nzx6LEjL5XTblMBxplSSeYFEv1pY1xm5KBDNJL15
   pKzLGPYSiBbMSFlfTF27PwvM45/XJ2aAiavamcJlZoD8P2oYkYpTeb3J9
   qs/u8npbvCEXf5tqwH4/mErmECtJ3QKUuO5QyOEmI7BvO/nmIV/NRXObC
   acHtzENgdBWhUrvf+H+8cwl13aeVrmVLIU4Ff2rR6K2m7kuo0ufsHDnRs
   9TSPcuMbG3Dx2Ap4EvsMe9LDBV7lxL5Po37GS7UQY4SuZSagEJ8+4D7E2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="364339397"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="364339397"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="868769690"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="868769690"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 09:31:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 09:31:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 09:31:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 09:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+E/e0jNBbkNKqUAPW+xqMYkw4a5m1MHnTFzmh4k1q9GpyZ9VzjEEkDgJYgbPV0DpxnBMmFQGOXe0uY9qEg4ToyRXfqP3M8dv2C8jDn1iqMGk6HhkPjUgUtT1p3+6ztvq1KHDpcNtZ2LW9Wuwb9YbHQMYvp7vJTsbjpp94gVF+TRExHLm1Dkt/Nzzt8xa6mcafjvOT6yCuvP4yD65j1xujb9u4zC8/vNxE69G0SUAfdWq6bEWvLm5hb+7nPPxm77UTUMeHbCfE9kYniTYJD7ptRBl6rzAtdod3o6HSyze609BC+gfzv8d39SWipEfAud8nk6/iucBFwCEcJCSPrJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4F9nWtdOt8gQVfBNOJ7ufAEnojYX3o9PqEZUgqgXDQk=;
 b=oHe/9B8ikTPNMYE/ydOSK5UwZcbcE4WngMHjFMxhA7u/kR9et/37sidgSqclXFQkSeJYjfXW3dCmP1xe4aMqWMlOPe7Klvu5DdiFifhSiUIztq1oiT0reuUdttmqk9RYkizKdjRDfPkoBovQvP23xvK3GX1fXfJSx1voT1cX2x5xZjSCz4YbDykcSv8Z7XKJF7vbGma/RW5TEII1KFOgaVIh+vmIT0alyryvpQcD43ReXB0ei4dEs0Msd9OILKADve25rRhq6hOc4tYoAbdGEH4yWYQMyimarSIaGeusD2mU6iCMSjCo+VFAQwbaeFNnACjKInczyL/mNaspCNC1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA0PR11MB4637.namprd11.prod.outlook.com (2603:10b6:806:97::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 16:31:04 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%6]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 16:31:03 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Enlin Mu <enlin.mu@outlook.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "enlin.mu@unisoc.com" <enlin.mu@unisoc.com>,
        "enlinmu@gmail.com" <enlinmu@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] printk: add cpu id information to printk() output
Thread-Topic: [PATCH] printk: add cpu id information to printk() output
Thread-Index: AQHZ56gGj/rt1aCNXkiaM2mvxEzR1rAcFCLg
Date:   Fri, 15 Sep 2023 16:31:03 +0000
Message-ID: <SJ1PR11MB608326C26516C66ADC0526D8FCF6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
In-Reply-To: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA0PR11MB4637:EE_
x-ms-office365-filtering-correlation-id: 2a713f6c-0454-4602-ae76-08dbb60927a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iYXerLD8199MWJvXOh4HSJ7BLBNmNEc7w01l5YJaMiPAnB8xcKFrK/1r0wzPY6tzc7dpvKmrHOsT7XZ3gL8OFPjQXfVYHEMaQ38jOhSjU2uBI5IN/N7YjPMYwa7sOAu+ntDbDV+W7MjZ2Y1+NFw3A8YBwvjFMPAZQud4UI/QUqqN/UT0F85MatvsMMC2XVOt/oKOGpYJf/eLHJHG0p1+YTR64PGgl2ePI5IIscz0ItzraFOIwM+J+EK5MRaMqEoa9CH/HP0rjuaYXSXj2l/J3xiKUhy7r2HSRwLMFgCmdZAWenCjfIZ/XPwao5tGooVuE1SV4cxi68w/xTmgLyuxbRchtau+FEx8cMH8RJffTO3ukwh+i8O+3pNV3zL+zpsF+HT4OOzLRtPqw8HxFYU+dOmA8as7wVYG8cHglRkuTEFip+CiSgg9I40qVNyI6r4QBTGnJDogOvxAPUmCMZC8Y/WkUlF7BFP+aRHLtZcN1UMpWxjbx3CXTIuRoCTvpIp51lQtRmW/FHV+kc7FtyqDhSdoR1qnnFMIdQlWYAIZojzUR4qnIO4/aEAldrU0+h2AuAdqBYOFC4UGG8knYNBH0tneypkqR7kA91cB+JLsj6GQzf37y3NoXlz2BtLbCpJf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199024)(186009)(1800799009)(316002)(76116006)(66446008)(66946007)(64756008)(66476007)(66556008)(54906003)(41300700001)(110136005)(55016003)(478600001)(71200400001)(122000001)(38070700005)(38100700002)(82960400001)(7416002)(33656002)(558084003)(2906002)(86362001)(5660300002)(52536014)(8676002)(4326008)(8936002)(26005)(83380400001)(6506007)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KHPXQdwh5XNura4xaDKesyUStFl2moEgL9gPazNAnXj6MO2b2aXTY42fdUVV?=
 =?us-ascii?Q?KJ56mLqZbFXcaBZeEqrelTJku+CBM2wEW3noiXJZenx7mG9y7jwzzO8iZpmc?=
 =?us-ascii?Q?ds2Csj2EnlXERQ5OYw5MEIlcL1Imj0tO8N7Ua4GFZduWj9X/n6+jwf5+KT00?=
 =?us-ascii?Q?dOxKD2oOy4WpEIkydALkGAfIEzMKT1fkNXFSHlawxjFqsYaJpMLpp1Fs+S8z?=
 =?us-ascii?Q?9VSkAwLKVUw9/xpNjh0jkbjC8IWLdVDJEiFWMks7a/gEje4qDMpx843avZoG?=
 =?us-ascii?Q?mXsH0GpHOIkVQyQcBz/74gptLmj0vvNne69hYcu+IotfATviLKYFDrrIDr+r?=
 =?us-ascii?Q?lyS4l6A/BnQnkuVlP2lDl+6EPmwCsCCS3GVP/k8MPiOFxBnF5HvP9UaVJJUl?=
 =?us-ascii?Q?OhaIcnlIeDZ7Oh4biPa2Kh1bAjRSfvmFzFy8HsOsnJ+IN5sOT30B4f1JCeFW?=
 =?us-ascii?Q?2BNHS7kbV+vdQr03zfJVhlAH0586S3ZdyKejzUR+IjhgUDjeQZaokV3pdcy3?=
 =?us-ascii?Q?o38kwa3/2hV30TiRq5iVV44a5L1dtJjC4eB8Fx6XcMbC7ArHpE55MHWUJ3FF?=
 =?us-ascii?Q?XYNd+JC59CPQpf8oMtkOKxcXwaJ26ook/Lzha1cA0lgSQfGhPi4YevOfEWr6?=
 =?us-ascii?Q?9z8yeVa/w4C0qaGoUFduzHWzZhdRwoZDcplr4ox3dmBTbq3djl30gmMl20B3?=
 =?us-ascii?Q?FC/cBaYee0VTVecr6LX+W90kjIo4dcQLOrxWGPCRLOKzFSVQtPOsKUme4J0i?=
 =?us-ascii?Q?MfhoL9TmcrOoWuuJ0ch7+U20f1syqCNcL5qOgZGUN5zlz0hKvRGSzBfJ2LGE?=
 =?us-ascii?Q?/ulkHrIhGcPZiahNpzgocO6Jd9LJBqnjxOE2UmXZELgMB58Yd5FNjEU0aMst?=
 =?us-ascii?Q?a3oKt9hhEvxr5jeZPmY0AIq3bqOGtgnpRZQOZXR06vvywwrGbdzVXJoIcazA?=
 =?us-ascii?Q?JJYlmE789JUYFcCR5xaOIMSmFK4wG4F6pprIYvArhFyNJY4Yb+C1A4hD32W7?=
 =?us-ascii?Q?FNhWfTkW38ApN06indZosBY/AGvZS5/KjOhjUMdAA3S5PJCGYXYsX2UeLs+n?=
 =?us-ascii?Q?pwQa7BlHU43DP2Jm2vUVlFm2VPnaBAX0EuG5+1EXSoJ98EoHIrHZwRXyxwlR?=
 =?us-ascii?Q?i5Nx2AlwqBypfTHlJqX5SxqRcg+k+MzcB9Vgpm1i4EATUrDV/E8XlXt5QPDF?=
 =?us-ascii?Q?CUR6rs8QQHPTtDESotpCsd+yTETPkA5B8lAm9ea2uZjwTrvzCXuCH83t1m46?=
 =?us-ascii?Q?U9nX/mL7BlZuQdJimw/Qg4y/XE7wwhQfNJlB/yznnsQaG8Y5bXZI7DK55VDK?=
 =?us-ascii?Q?wYuzcNclNJzKe4Qrw00LZ9vAM8WcOHBJ0qRPvUGxvlq4RhMP3xzbvv9jnKGe?=
 =?us-ascii?Q?cXEgKi6p/cEfycOMzJHJzK5ZWnvBea6nYznQ498u0hzI4TvmooS3Lh/ti9cM?=
 =?us-ascii?Q?oFKFQgOnIHqzy/BinePQtvbqGjpBLy3aTrkxEFDs5zOufFqjWtxqVNc97i7+?=
 =?us-ascii?Q?Be/KS2ChnWe85pdXWHpIr/aXoxel4SB6ebVpYQJyAfDiQ5HD/GCGLJFbkCrN?=
 =?us-ascii?Q?9RbuxIkblIQP81mrafr8Md7Sy13W3azvtOcEP6h6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a713f6c-0454-4602-ae76-08dbb60927a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 16:31:03.9138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /FelIW0PTcnKh0jLtO/HZvLv8Xs+HSlCz31m4yzmEUn2taR9DSLKGjx6gMWf/LBLYEAT0E0AxRS/L+TqyVdm8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4637
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	return in_task() ? task_pid_nr(current) | (smp_processor_id() << CPU_ID=
_SHIFT) :

There are contexts and CONFIG options around pre-emption where smp_processo=
r_id()
will throw a warning. Use raw_smp_processor_id().

-Tony
