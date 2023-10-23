Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A510D7D2D86
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjJWJB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjJWJBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:01:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6D097;
        Mon, 23 Oct 2023 02:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698051710; x=1729587710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=397b8XyC1JBxCrt4noJ6rNgos9iIctBlEpQwJDarLY8=;
  b=EbVScdAsS5lLx170XEb7SXCoE9n4LL4uBCQgwgz9OED3yUOG+KhBw/cy
   JHJIv49gHo3E9yRKiZr+xa9sOQZQL4N/278dkhqhcS6v4dz/MDS9RFVo7
   DGzC7JNdoZ4w3eAeyvuW7f48lyc3ownDvdGyl5ILC0zAJyBFnUe956QX1
   XKx+Ky6oCSdd0FWX5pdMe4L4vQHYsNm6lf8HH1Jua3NlkNbD6yng3j0wU
   MfqSeu4Ln9XV/WzPVQjy5G11VQ+PEy88Oz9qK0EMJ40OIML563qml6KYy
   L9cLBB8ara2+mfUpWMrKV2WuC+mf5EiKQxz+roGubZFPnZ7cp2/oF3KNX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="5421287"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="5421287"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 02:01:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="787412241"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="787412241"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 02:01:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 02:01:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 02:01:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 02:01:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSxH611SUCj335T4h1V18Zt2jjANZUFa73yOeQYuhKX6eFf1cVHUNl591LhWlF9Bn7miv1oweNSnMe4BpJHZh4UTINOKH87MkgXVrc5aCVXrAwCJ5oXHcnakneZw690VPhjOka7j7COmqYKZpWoIJE2jiXEk7ZX5kJuZz6aY8LmZcPBR4pnR5ZuZv45txn8oMaD9A9tIxUQ8e7BkqEtGv1iU2LpqIShADXXxlIU+6CEpMI7t2GwdhHuSoPwKsl/wEpUu67k5OyoaCPCTE17eNmVyYEmZhxPz7CzlFLYLX58Uv4v09nMdBAzHNO2qW7FzG+fziFyivoRtXlQm+hOufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MCe0OTgyKWJI2rM5nui+7uRz51T6vbNpfwp4G4gNrE=;
 b=HZwoo9aTu06LXDKW5z1lH2XgHuT5ncut4b8yWRjgb60+sxPug5bvuQQpLK4vqG1HtfVUuJ0iaDD4yYhSsCC3ZXSs3CG0Y/goziwd3SZoTfU1lUo/6OmJfevkzyjYQggKX/gZezEDSboBXTwfAccf8keVM4OGlXYdsMcM+I35XpTE6zNXJrHxXLm7qTD/C5//hBGxvXVHhqJjk7+geZz7tSNLkQ75kdPm7M74q/m0gjGoyaX1oAl/wLzSERggeoCCyZRwYa7hbThJ304uNkLYCZidVJGs2zKsiVfI6TTbgShp/kZwWCxp4VhyhAhe0MumMrHI0xW5Wn38/kXdiT8UHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DM4PR11MB7279.namprd11.prod.outlook.com (2603:10b6:8:109::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 23 Oct
 2023 09:01:40 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ec0:108e:7afe:f1a4]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ec0:108e:7afe:f1a4%5]) with mapi id 15.20.6886.034; Mon, 23 Oct 2023
 09:01:40 +0000
From:   "Drewek, Wojciech" <wojciech.drewek@intel.com>
To:     Edward AD <twuufnxlz@gmail.com>,
        "syzbot+9704e6f099d952508943@syzkaller.appspotmail.com" 
        <syzbot+9704e6f099d952508943@syzkaller.appspotmail.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "reibax@gmail.com" <reibax@gmail.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: [PATCH] ptp: ptp_read should not release queue
Thread-Topic: [PATCH] ptp: ptp_read should not release queue
Thread-Index: AQHaBVsrlvNhSH7D/EuTcW5/4OFPb7BXEvjg
Date:   Mon, 23 Oct 2023 09:01:40 +0000
Message-ID: <MW4PR11MB57763BDD2770028003988D8AFDD8A@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <0000000000002e8d4a06085267f3@google.com>
 <20231023024622.323905-2-twuufnxlz@gmail.com>
In-Reply-To: <20231023024622.323905-2-twuufnxlz@gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5776:EE_|DM4PR11MB7279:EE_
x-ms-office365-filtering-correlation-id: 7c3e210c-1bef-4020-eb33-08dbd3a6ac19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ifm9dhMr9gNT1oyeLVaffIr7E4PLn9NNa6AJ7VvXJlkRT+opWizWAQi4jAGsOEFIqyuYcdg3M7emmdL6uDhFLCwL7LsMlQrHTluN+LfNUJQpLabKhB06Tat/OZb9m92WFhl8FIqSIye7uATZil0ZoATeoKonsPDJsW09qYTyZYlQoN3/rc1MjElHzP/Q4lDvPDZwFqV0R2V3WhPn+UJhS4veJMJQXmWbhPAfwVy1NENiwPagbQgflaOqJivnf9+xKJh9VmZiY017jiHWR0DwjYPtWn3lE3VPWsTUzaBAmz+O4WHVKDiB6wggIeIgSk1s2DaF3Wu9cWId0/6f6QDWRqZvUZ1aNSe/kIyRQafAjR7IiKJ+zMoe2oc+ijn1XlhB7SLUXdguD/hqyj6QH8z5wH8rG9t1nLLtkLHu4GJsEjCKEoJgpNkwyBaDFeZUc+xiB9+d4mvzAkG7qlRe98+EaEEHzMTYVHNtmdXoOfW7SsmRzKfckt8uxo4Dn4pmDTKSZP3x6ODJuDwigrCKjk6iwIcWBCnIoLUtV9Z5jG+E3OIn7lRvAyYH26MGj1fiw+APvL46FEG2uP60lkwdmiitAaYvQ+ACw3K2Q1OEU523lBu5BMr4b0CmXFyi92LRjp1T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(38070700009)(38100700002)(2906002)(55016003)(41300700001)(86362001)(5660300002)(52536014)(8676002)(8936002)(33656002)(4326008)(7696005)(6506007)(71200400001)(478600001)(110136005)(122000001)(82960400001)(66476007)(76116006)(316002)(64756008)(66446008)(66556008)(54906003)(66946007)(83380400001)(53546011)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jeDB+BWKDd1zU9GG6xMt0xE9ItBCcssBX1fikHoKxADY7wFdloxz3hxe3Tui?=
 =?us-ascii?Q?XwFAjScn0nxomYhIkHUSXodFPZhcIXS9cWiIeogarcqBxGbEKuCaf8LVRF0s?=
 =?us-ascii?Q?+NX4//azOoNJZt9AWs76xXT1odK43RiRxpPHa3ZtE/u612o7pzBB8quQGtDG?=
 =?us-ascii?Q?wFjGZnrXJaLe5faWYOgDskGQjtF6nSEdbBCwU4iAFq6gGo2tw/aK/Lsh9psu?=
 =?us-ascii?Q?I7G14lAv1h1KN+zxL2sI0dHgSxrkH/gzDtD+X+xoHnJrlMILAMIOnOO1ors3?=
 =?us-ascii?Q?c68Hk8Ze6kmy+rRFJxoC8M5jrlCzGdRUNesCEl9rOW0Mi/3KpYDDTzo5YBwu?=
 =?us-ascii?Q?uh2zoBBWoAIZY4fqn2OyIwcoa9su+mpiXXykaqNL3nwKuBeW7CQ71NJoTeUh?=
 =?us-ascii?Q?tycaDdrP/JoufjVYyM0bXP5QzWleHfP7oIC/PER1jR4Vi/24q2/FrT21F/VM?=
 =?us-ascii?Q?hAELl7z/bJeONABkrm2Xw1HZc8bBBVdW3NFpRhOHUmkek03paoO7htgSHZa3?=
 =?us-ascii?Q?gZflPDZrKwRLhtniQ6VJ8vcP5pmRu3TxOwBPAPA8ZaQ3fbe/Z3fJMFVeDzBK?=
 =?us-ascii?Q?GQBsBaWD5QWns2ooMEGIVbhv9Uc5nfs+azehLLcDcdNY4P787Xa+Z+MVQthw?=
 =?us-ascii?Q?BuTlMuuuh6XyYc4kphh5ts39sCdCvlu0F27JR/mx2vohQ0IBGeiWAtNinKTv?=
 =?us-ascii?Q?+NMkxzAaMsVKcGBecCm9Nw1wh7kbxaerU6x1lM+5tilLgNrXPQ16w7KEAMfT?=
 =?us-ascii?Q?agE7oBRUzoni4HkMbonPKa6qalUhJBn5CYmbL2lTuGavfKPFDbtaXyC0DZE4?=
 =?us-ascii?Q?T7TzOR4lUFo2itiTlB0/9ufZ3XZR4088q0JhThItvOPgPsKgdVlOOynZi8dd?=
 =?us-ascii?Q?IJnVyrECHMr/vouI3tpuWBvlLQHD4vcJe30qJf7Rs1qCHCVchsqX9Qxf7qEx?=
 =?us-ascii?Q?vNO3x3/09Fkmapsh5G/9eL0AVf1TEOw9lKo/J6O5SVinHotUFY8QOTaagypg?=
 =?us-ascii?Q?Q6OOyzv2U/hN4qg9+t/hTjZx+DL1yx4d1Atx7Ie1hl5GycDrmN2yh1ovvSy3?=
 =?us-ascii?Q?vnxpo1IHyBT/rKtzp5+5Bethopf1GL57zBkCwdx4pJmigr2EhkZiHw9g7fVx?=
 =?us-ascii?Q?2N3a2+3GAaJbOGk1k0HU5l2xUNYWHW8XrcneWlRXgWOhEfdEGkJv9s0WI0Pl?=
 =?us-ascii?Q?34n31rJP4Nudrqjrr9M6F6gi95lp6Adn5QpSp52YDO26y2SPWnCOmEvRDnWU?=
 =?us-ascii?Q?zjYeF96acjbM4++DXF4TqmSnxAzezwURUlw7qfKrar3N78OCuAL0Qpxh9Z1D?=
 =?us-ascii?Q?nDGVkrRX9JuCxHehrGgRDoEVlQJ67dRTPqBJYMkDZIIFg8lUwEnxhmE1b557?=
 =?us-ascii?Q?n0c2EwUbEXIY1Dna1eHm67qDJlmY2J+7HKH2U2eyhdgFU6nQHxKPS0yRszcI?=
 =?us-ascii?Q?Ych3G4b+2JD/67MlA1dXeUgbZG/lDwxmvXXtHcxDReTA3eaIk6JpUBUet59+?=
 =?us-ascii?Q?xF2OrzUSXD9bFRWJvS3Si8ZEIQQfoSRsYDwVl3tsin2cgYRif1kfxDB/ZnMA?=
 =?us-ascii?Q?E2n+ecGNAq4+4HMDYkPuFTF3A9dJD+sQ3fReDYIG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3e210c-1bef-4020-eb33-08dbd3a6ac19
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 09:01:40.7992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2g3GgxNyrCwnSi1egUx5Xwtu1V41lGedqq1WiIl1JYwzH65rWeE0Ux+CLf1hJeuA0cVJg/u9dWk206EJ2LMUzZHwJJKZMM+2YJDps8W/uA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7279
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Edward AD <twuufnxlz@gmail.com>
> Sent: Monday, October 23, 2023 4:46 AM
> To: syzbot+9704e6f099d952508943@syzkaller.appspotmail.com
> Cc: davem@davemloft.net; linux-kernel@vger.kernel.org; netdev@vger.kernel=
.org; reibax@gmail.com; richardcochran@gmail.com;
> syzkaller-bugs@googlegroups.com
> Subject: [PATCH] ptp: ptp_read should not release queue
>=20
> Firstly, queue is not the memory allocated in ptp_read;
> Secondly, other processes may block at ptp_read and wait for conditions t=
o be
> met to perform read operations.
>=20
> Reported-and-tested-by: syzbot+9704e6f099d952508943@syzkaller.appspotmail=
.com
> Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>

Hi Edward,

Consider adding a target to the subject: [PATCH net] in this case

> ---
>  drivers/ptp/ptp_chardev.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 282cd7d24077..27c1ef493617 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -585,7 +585,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontex=
t, uint rdflags,
>  free_event:
>  	kfree(event);
>  exit:
> -	if (result < 0)
> -		ptp_release(pccontext);
>  	return result;
>  }
> --
> 2.25.1
>=20

