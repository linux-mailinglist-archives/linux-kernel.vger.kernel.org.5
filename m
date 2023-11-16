Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9D7EE8A0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 22:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345527AbjKPVCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 16:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPVCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 16:02:48 -0500
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3775FB9;
        Thu, 16 Nov 2023 13:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2136; q=dns/txt; s=iport;
  t=1700168564; x=1701378164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pYLBxnVN+suC8ijUK70fMgQn2FtteqZrCwymggAyQWw=;
  b=RF92luAdl7lX8wXbUxKpi0QVovDGq89ImiYUw/eNFzBPokfEcRzAquKo
   2EsWQwvsscX7jspl5bN6ccKDU+/SlSXLLcOoRarhCAlfXsFNPeeSPXie4
   PUipFHs4TNAKDgzKuR5SeaqUxkho+VJ/RwmtKXI6Silx1h/C+SIu3r5ym
   E=;
X-CSE-ConnectionGUID: rIeimE+JQluQ0yeJX/T8/w==
X-CSE-MsgGUID: swj6R21lSiSQvRLQGXTPXQ==
X-IPAS-Result: =?us-ascii?q?A0AbAAA5g1ZlmJ1dJa1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBZlJ4WzxIhFKDTAOETl+IZp1+gSUDVg8BAQENAQFEBAEBhQYCF?=
 =?us-ascii?q?ocSAiY0CQ4BAgICAQEBAQMCAwEBAQEBAQECAQEFAQEBAgEHBBQBAQEBAQEBA?=
 =?us-ascii?q?R4ZBRAOJ4VoDQiGPQEBAQECARIRBA0MAQE3AQ8CAQgYAgImAgICMBUQAgQBD?=
 =?us-ascii?q?QUIGoJegjwjAwGgOQGBQAKKKHp/M4EBggkBAQYEBbJtCYEaLgGIDAGBUIg+J?=
 =?us-ascii?q?xuCDYEVQoJoPoJhAoFiFYNEOYIvg22FOAcygiODKSmBE40TCXZHcBsDBwN/D?=
 =?us-ascii?q?ysHBDAbBwYJFC0jBlEEKCQJExI+BIMuCoECPw8OEYI9IgIHNjYZSIJbFQw0S?=
 =?us-ascii?q?nYQKgQUF4ETBGoFFhUeNxESFw0DCHQdAhEjPAMFAwQzChINCyEFFEIDRQZJC?=
 =?us-ascii?q?wMCGgUDAwSBNgUNHgIQGgYNJwMDE00CEBQDOwMDBgMLMQMwVUQMUANuHzYJP?=
 =?us-ascii?q?AsEDB8CGx4NJyUCMkIDEQUSAhYDJBkEOBEJCy0DMQYhA0QdQAMLbT01FBsFB?=
 =?us-ascii?q?DspWQWiLIJ8QTmWIEmuNAqEDaE/F6oFLpgSIKgLAgQCBAUCDgEBBoFjOoFbc?=
 =?us-ascii?q?BWDIlIZD44gGYNfj3l2AjkCBwsBAQMJimEBAQ?=
IronPort-PHdr: A9a23:uJt/mhSXhhPQ0MWYqqz+nv2Yy9pso3PLVj580XJvo6hFfqLm+IztI
 wmDo/5sl1TOG47c7qEMh+nXtvX4UHcbqdaasX8EeYBRTRJNl8gMngIhDcLEQU32JfLndWo7S
 exJVURu+DewNk0GUN3maQjqq2appSUXBg25MAN0IurvHYuHjM2ty+G28p77aARTjz37arR3f
 126qAzLvZwOiJB5YuYpnwLUq2FBffhXw24gKVOIyhD74MrxtJI2+CVLsPVn/MlFOZg=
IronPort-Data: A9a23:SFkPwqNOAU/tdobvrR2Fl8FynXyQoLVcMsEvi/4bfWQNrUoi1DZRy
 GoXXG2CafqNamH2eNAkaImyo0kA7ZPdyoBlQHM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCdaphyFjmF/kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/W1/lV
 e/a+ZWFYwb8gmAsbgr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQrl58R7PSq
 07rldlVz0uBl/sfIorNfoXTLiXmdoXv0T2m0RK6bUQNbi9q/UTe2o5jXBYVhNw+Zz+hx7idw
 /0V3XC8pJtA0qDkwIwgvxdk/y5WJ4xL+brqYlqGtdGql1zLUUur/6UpExRjVWEY0r4f7WBm7
 /cULnUGaQqOwrzwy7OgQe4qjcMmRCXpFNpA4Tc7kneIVrB/HM+rr6bivbe02B8zj9pSHPLXZ
 OISaCFka1LLZBgn1lI/Uc5mw7/y3iWiG9FegEmKp/QNuTHX9w1K6abXFOP6SuCydfwAyy50o
 UqdojymWUtFXDCF8hKB83SxlqrMkDn9VYY6CrK17LhpjUeVy2hVDwcZPXO/oP+kmgulUMleA
 1Ib9zBorqUo8kGvCN7nUHWFTGWspBUQXZ9bFPc3rV/LwavP6AHfDW8BJtJcVDA4nNUXSD0v+
 xyrptf0PGR+vZ+lDk7NsajB+FteJhMpBWMFYCYFSy4M7N/ivJw/g3rzojBLTvfdYjrdR2mY/
 tyakBXSkYn/miLi6klW1UrMjzTprZ/TQ0troA7WRWmiqAh+YeZJhrBEC3CFsZ6sz67AEjFtW
 UTofeDCtoji6rnRzESwrB0lRu3B2hp8GGS0baRTN5cg7S+x3HWoYJpd5jpzTG8wbZ5cIGKzO
 haM4FwBjHO2AJdMRfEuC25WI5pypZUM6fy8Dpg4k/IXO8cuKlfflM2QTRTAgz+FfLcQfVEXY
 srDLp32Uh72+IxszSG9QK8GwKQ3yyUljWLVTtaT8vhU+eT2WZJhcp9caAHmRrlgtMus+VyFm
 /4BbJHi40sED4XDjtz/rNR7waYidyZrXPgbaqV/K4a+H+aRMD9xVq+Bnu9wK+SIXc19z4/1w
 510YWcBoHLXjnzcIgLMYXdmAI4Dl74m8hrX4QRE0Y6U5kUe
IronPort-HdrOrdr: A9a23:gnETE6uP5fnhIANXeo01OLBv7skCM4Aji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwSZVoIUmxyXZ0ibNhRItKLzOWyFdAS7sSo7cKogeQVBEWk9Qtt5
 uIHJIOdeEYYWIK6voSpTPIberIo+P3sZxA592us0uFJDsCA8oPnmIJbjpzUHcGOzWubqBJbK
 Z0k/A33QZIDk5nFfhTaEN1OdTrlpngrr6jSxgAABIs9QmJih2VyJOSKXKl9yZbeQlihZM5/0
 b4syGR3MieWveApSP05iv21dB7idHhwtxMCIinkc4OMAjhjQ6uecBIR6CClCpdmpDt1H8a1P
 335zswNcV67H3cOkuvpwH25gXm2DEyr1f/1F6jh2f5q8CRfkN5NyMBv/MdTvLq0TtmgDhO6t
 MM44tfjesPMfr0plW42zEPbWAzqqP7mwt4rQdZtQ0tbWJXUs4ikWVYxjIULH/FdxiKtbzO14
 JVfZvhzecTflWAY3/DuG5zhNSqQ3QoBx+DBlMPo8qPzlFt7TpEJmYjtYQid007hdkAYogB4/
 6BPrVjlblIQMNTZaVhBP0ZSc/yDmDWWxrDPG+bPFyiTcg8Sj7wgo+y5K9w6PCheZQOwpd3kJ
 PdUElAvWp3f071E8WB0JBC7xiISmSgWjbmzN1Y+vFCy/DBbauuNTfGREElksOmrflaCsrHW+
 yrMJYTGPPnJXuGI/cB4+Q/YeglFZAzarxjhj9gYSP6niviEPyfitDm
X-Talos-CUID: 9a23:XxPiwm6bC//PkaY0Gtss7m8ZG8UIMV/kyGrpe161K1YudO3SVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AcYToNw+r6oeM/Rhvzekd0M6Qf9x34fqUUhkJqpQ?=
 =?us-ascii?q?9gte+ERVfCwulvA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 21:02:35 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
        by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 3AGL2Y8h032033
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 21:02:34 GMT
X-CSE-ConnectionGUID: TOWuPvr3QAuD2VHxHUPzog==
X-CSE-MsgGUID: 700IAb2jS6q6ZdD8ZWJOyw==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.04,205,1695686400"; 
   d="scan'208";a="8743747"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 21:02:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNPf7Tq11yx3i8D9yqr/FrcOW4M8vPM6ndFwonT467aYFD17aI7phPEAynW0sRLbC1LKDK5T+eUJ/TAk2rLnA3EddGu6pfSDXFQlwjhlRNvLLWcDkyw2V5tPJOt9t/Q5GMirD1QrNEgvnzbSMvUZYL7rNACD7Mj2EDl+yPEA2aFYGl7OwJswivFNbyB1x9geF4xSWlzhYb6jAzRbw16awL+3BOB7Un7IYoUAMr3J5SmBcGWAphcmQdhb0Dwnne8aYUNAt4EbMTMV1K1juYSjRSsiIpLYRTNG5SHXCj22DK6CCPD+XEADi0qT2B9S0157Q+DbqBzmNDFMBr+JPQdy0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYLBxnVN+suC8ijUK70fMgQn2FtteqZrCwymggAyQWw=;
 b=ef3ViRSIi4eVUxrblawjaAfUdxC4vD+9VlJ4ouI+lv2B7ik2GYk79GqBLNLyKjyNO/yrRomORjz3tpc7yAsh85l6vR5k3yEVz1ve8ExTr2w9AO8xoD9lfjZ4Lw3wAkU9N3BYuEeMrFuR3sJmk/cspMGCW5QVo7aC2idrRYqFGmZCGnti0AiH0FdbiOTpI7I6y8t8NAnQ9TYjkEbsOkXLoiXm500Ly3nvXZwdcSzcU3KqL1ilOBDX/lmMZyZ4R211Syy/WP3l55cMeRHkHKID7chvtpwVUdUXwbASetaWgVDlAtwNwbvYewTM3envwwl1XD75obBKDKQ/ycBhNk76Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYLBxnVN+suC8ijUK70fMgQn2FtteqZrCwymggAyQWw=;
 b=micVYi7YERPlVLHDu8taYN+SdvrKRf0kIzR+HaDi3ilBTWekpr+ouKPtfJZH/yccYcSKKgxyXiBYZo7gkmyLuUJ0SHiFCMSMUlIlLVdcn/s5yOKpftHcjPkl3yT2a/THK+kcl3KlFISQ5L4PYNnBEbima55YSl8YIwHwaUoISPo=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 21:02:31 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6977.029; Thu, 16 Nov 2023
 21:02:31 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     John Garry <john.g.garry@oracle.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
CC:     "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: RE: [PATCH v3 10/13] scsi: fnic: Add support for multiqueue (MQ) in
 fnic_main.c
Thread-Topic: [PATCH v3 10/13] scsi: fnic: Add support for multiqueue (MQ) in
 fnic_main.c
Thread-Index: AQHaF0tJQV9WC9tGUUarC1O77Noe2LB7e1CAgACIBDCAASMbAIAAEDiAgAA6tqA=
Date:   Thu, 16 Nov 2023 21:02:31 +0000
Message-ID: <SJ0PR11MB589612C2B79E6A68D6017462C3B0A@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231114223810.634200-1-kartilak@cisco.com>
 <09b84161-748b-c1c2-e4e8-96df5d2b01e5@oracle.com>
 <SJ0PR11MB5896F9B7FA37D78B91BB1D42C3B1A@SJ0PR11MB5896.namprd11.prod.outlook.com>
 <b0552a30-c94b-4877-890f-d3f5bbdeaebd@oracle.com>
 <e3d03635-3b4c-44d0-8e16-a9d3a1b4cc92@oracle.com>
In-Reply-To: <e3d03635-3b4c-44d0-8e16-a9d3a1b4cc92@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|IA1PR11MB7856:EE_
x-ms-office365-filtering-correlation-id: b6c4187a-aa04-4fde-180c-08dbe6e75987
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PJrDktGWW+whMvxpY6Dfo0j5+YCqaN4hBlXE8AfIVYQCbKWK4aHXtL0Rs6+2eH/A1LaxK7O4rsIH5FUNnXq9bdYAmSyYDaRy2bFmCtC2UuwxzUXEfSMQUW7g6gW0MYlaj5QnXZ9jiufl9C+ABa0kosIepck9b+LPQxG/HRkYWzXhjfvDxPr5xOJrg5Nzt5B0Axx2Wrhvp9IQbHmPim5Cpl6e54vcUDNtQN58Xsk/Ba/q79rb/PfrF+FABCBtHl+uTUNdY1+/RVCVkciwj71lYH7VJUbSSc9CyiZgGjM+vMkP5Jauad+5Izgp2UlUlGxv32qZEUmFip4JP/cxTIZLYLpINBXDJY+b2S9/AaVJhw67gJfJXCLHmFjNS3yb3GGxSJc04pwFmu8rqMa7yBxrgdf5nuZy6JJP5yppdZHVnQoTzYP2bBeOqGTJeMRi/QHlWxmSYwq+HYHjD6eBJQdrgPwOe2EfheISMyD5QudoUlklIrMBZxx/4EFnc2w03AY/YqfKD9gAeuXZvQFcCW0igWNppHT3+YmQUC4Xo3zPVSbnWz1AkpQPCG4kUNvrhn3ReVkW09K5jlGPU1ou2SVEy2uBH2nLGmHcRNzlanNDY5Tud9JRhtraKj20lCWMMooG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38070700009)(110136005)(83380400001)(38100700002)(66946007)(64756008)(54906003)(8676002)(8936002)(66446008)(66556008)(66476007)(4326008)(76116006)(122000001)(55016003)(41300700001)(7696005)(6506007)(53546011)(9686003)(478600001)(2906002)(6636002)(316002)(52536014)(33656002)(71200400001)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1FoS1J5UFdDcnZaSXlkQWY1ekowb0hDOVF5WEhDWTdYZFN1NkduY29VbXBP?=
 =?utf-8?B?U1MrbU9HNUd2Uy9MZnZRenJhRVphMndIdEpVOHJrRVRIaUV6bU90eVRTVENM?=
 =?utf-8?B?dkxwT29TMWJ6WCtaVUlaZkhXSHR2SWRBL0ZCSklCNDNuOG9tYlVHSjRVdDZH?=
 =?utf-8?B?d1UzNThVQ3pNTnFNdUhSZlBpT2UzaVRvKzNFZWpwNmp2M0IzR2hodDZ4SC9E?=
 =?utf-8?B?NE9ITVREZ1BWYTBnTVJjN1VtUldRdTdqRGlkZkt5OXZRZ09SVWJINmVVYW9K?=
 =?utf-8?B?M0hKcExKSSs5aUYybkdURjgzOUxvNnVqczNsWC9IVzAxR0dRM3pxaEcraDhT?=
 =?utf-8?B?UU5ZUldVeEppSnFYYVc0MWlteFBoUU4wTWpZYjdqYVZlbjZsdFFTL2ZTRkc1?=
 =?utf-8?B?blhnRG5wWW1hMEorZnE0SkpLL0h4aW9IYjZYUnU0cSt0czhMOERrek94RGxT?=
 =?utf-8?B?RmNYVmxXcHRJLzA0b0NjTE1jK010VG9ZcHFwamVUdHZReTROdUNmd0FUbTMw?=
 =?utf-8?B?RENpVGh6WDJyMHBpWS95SFprMCt6THU0eVVvbWVVV1RtNGRZV3JubTgvRTlE?=
 =?utf-8?B?VVJCMXRrekdqNHZGcFZSbU9VMTZkQ3RVYzFjTG9YRlA5dDNaeHRXdU9zZGZ4?=
 =?utf-8?B?SHdNTDFvaTFnVGF1VnFLUFArSEJ2YUkvdDZSWWZIQXhCWjV5WXUzSGlab29u?=
 =?utf-8?B?NGovbnZJem1scVdqa0o3Mk4rYWFMdWNURUZabEliUWJEV1VCR0NOMHp2dDEy?=
 =?utf-8?B?NTFMeHBGc3Z5R24wOXdKSmE1ajVra0crck1CU2RCRHM1d1ZKTDlJM2ZPV2U3?=
 =?utf-8?B?UGNzTGxFbjU4dWxkRTZKVStmOGRWZ3E5OUxRWnVOU1l2bFEvOW0rQ01MVzBk?=
 =?utf-8?B?alZPdldXUFlLOVdKdzJpdnhyQkxaT2VJL2xQL2s2cm9sZXBZYUpTbjJPbWVk?=
 =?utf-8?B?eit0TmJOWm5YTjh0T2hRWUVuejdyTVpER2FrOVhEUnloYVhmeTlYNUx0dm5K?=
 =?utf-8?B?bUVESmJsbjJPaXp1VjFnS2lrdnVJeVFNN2Q5b2xaOS9ueEI1MmRKZFdYT05u?=
 =?utf-8?B?M2lYRVpYMm5VY0lmaFU5dUFVOWNqU1ROa2lIUk42dnZpN1ZWU3hpRW5MMnIr?=
 =?utf-8?B?VVFjNi9oaFgyRUNvRzRDMnhqdDNOblM3WU0rNDBvcGg3YThkMysyL01hOVZD?=
 =?utf-8?B?c3ZjREpMYWlPcnBFSGxkYVJQck1vWTQ0YmxiQkI5OFQ4bFFkb3ZhVG5NQ1ZG?=
 =?utf-8?B?YlUzZVNQTnBaYTliRXJuQ0t2dURNaU51WnhSbzd3cnJiaHBnNEM5aStBNFhj?=
 =?utf-8?B?YUIrNDhvZFJGZHJCd3NYREdjU0V0Q3VwS0hGM3E2YWxieDlTQnZmSDRFZjE3?=
 =?utf-8?B?NUh5YllhQXdnT1k1cjY1bkhtMER0K01TRGxZUzRieVB4dzExNHJGeUNVeWEv?=
 =?utf-8?B?YU9GV0xhekRsV2JLZHdxZHJJSCtuK1A0U2h4TjNLYU5VdzBzMlQ3YUNDL2U0?=
 =?utf-8?B?TWpvVGFJU1JqaHlMY0Q5L2YxcU44S0hlK1ozazhQVThwcmJ1ZVBrU2NuOXEw?=
 =?utf-8?B?d1lUejdWdnZLZzZ3TllSQ0JQdVFyTU5PbEZEaTEwUG50TzdxeCswWjB1WEt2?=
 =?utf-8?B?aVpiRXpBYndJazJKS1YwaHRncXB4SGIvRjlPOTZrTFkzNFBVNWdvVmNRWjBR?=
 =?utf-8?B?ODhXOEJBK3NZMWdEUzhpMG4wd3ZUbnd5ZEVDd3ROMitVOEk4ZDh3WWd1VndI?=
 =?utf-8?B?bFR0VnZjL1ZWSDdOQVczcGNGaGhRalp5UFFRVzE4Unl6QkFHeStoVnllUDVR?=
 =?utf-8?B?ejU4MnB4WlF0Z01hM2wxNUNwa3V6YjRvK2QwbUd6c0VjZ1hPRnBHMG5FL1FT?=
 =?utf-8?B?UVF5QU1PUytoMkN0NUJiY2VQdDhTd0FyNGo5NlI3QnUvZThnUUhkY25Wem1v?=
 =?utf-8?B?bWd2em4zcDJLekM4Ykw1eGNiT2Z4S2U4aVcrbWE4OEttb0ZXTE9YN0FkQ2Fz?=
 =?utf-8?B?TUhRRWZ1RCtNa1hLTzM3dGtPNHltMnJoOU1vMmRyeWRzWlpaNmVodk8xMmQ4?=
 =?utf-8?B?TkdST0N2Wi9YTVNsOWZYZUxRRlJqR3dxWUx5NmVZaEpBYmprdC9aZmFLY0RE?=
 =?utf-8?B?dTI1MUpXUmtTQlFRY2kyMklRNWVnQUZlaHlPZmlBelo1ekUzdSs2QVlGQlhi?=
 =?utf-8?Q?mB3OxGuxAcsdB7QhgbCeBJ1Zp/vl6m6vaLklmPa1rozk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c4187a-aa04-4fde-180c-08dbe6e75987
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 21:02:31.6722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D6e4GHRnH+zOkNrCygRFNKKgO5f5GPgJKhpcvsX3ypLSVNOgGVCWIuZJDOKmKmdsxP9bT7UAb0RsRGQxw9QCZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-6.cisco.com
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1cnNkYXksIE5vdmVtYmVyIDE2LCAyMDIzIDg6MzMgQU0sIEpvaG4gR2FycnkgPGpvaG4u
Zy5nYXJyeUBvcmFjbGUuY29tPiB3cm90ZToNCj4NCj4gT24gMTUvMTEvMjAyMyAyMzoyMCwgS2Fy
YW4gVGlsYWsgS3VtYXIgKGthcnRpbGFrKSB3cm90ZToNCj4gPj4+ICsNCj4gPj4+ICsgICAgIGlm
IChpbnRyX21vZGUgPT0gVk5JQ19ERVZfSU5UUl9NT0RFX01TSSB8fCBpbnRyX21vZGUgPT0gVk5J
Q19ERVZfSU5UUl9NT0RFX0lOVFgpIHsNCj4gPj4+ICsgICAgICAgICAgICAgRk5JQ19NQUlOX0RC
RyhLRVJOX0VSUiwgZm5pYy0+bHBvcnQtPmhvc3QsIGZuaWMtPmZuaWNfbnVtLA0KPiA+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICJpbnRyX21vZGUgaXMgbm90IG1zaXhcbiIpOw0KPiA+PiAgICAg
ICAgICAgICAgICAgICAgICAgIEFyZSB0aGVzZSBjaGVja3MganVzdCBwYXJhbm9pYT8gSSBtZWFu
IHRoYXQgaXQgaXMgc3RyYW5nZSB0byBoYXZlDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAg
Zm5pY19tcV9tYXBfcXVldWVzX2NwdXMoKSBjYWxsZWQgYnV0IG5vdCBiZSByZXF1aXJlZCB0byBk
byBhbnl0aGluZy4NCj4gPj4NCj4gPiBVbmlmaWVkIENvbXB1dGluZyBTZXJ2ZXJzIE1hbmFnZW1l
bnQgKFVDU00pIGlzIGEgR1VJIHRvb2wgdG8gY29uZmlndXJlIENpc2NvIFNlcnZlcnMuDQo+ID4g
VGhlcmUgYXJlIGludGVycnVwdCBvcHRpb25zIHRoYXQgY2FuIGJlIG1vZGlmaWVkIHRvIElOVFgg
b3IgTVNJIG9yIE1TSS14Lg0KPiA+IEFsbCB0aGVzZSBvcHRpb25zIGFyZSBzdGlsbCBzdXBwb3J0
ZWQuDQo+ID4NCj4gPiBIb3dldmVyLCB3ZSBkbyBub3Qgc3VwcG9ydCBtdWx0aXF1ZXVlIChNUSkg
b24gTVNJIG9yIElOVFguDQo+DQo+IEJ5IHRoaXMgSSBhc3N1bWUgaXQgbWVhbnMgbnJfaHdfcXVl
dWVzID0gMSBmb3IgTVNJIG9yIElOVFgNCg0KVGhhdCdzIGNvcnJlY3QsIEpvaG4uDQoNCj4gPiBU
aGVzZSBjaGVja3MgYXJlIHByZXNlbnQgdG8gb25seSBwcmV2ZW50IGFuIE1RICJtaXNjb25maWd1
cmF0aW9uIi4NCj4NCj4gPiBJZiB5b3UgY2hlY2sgYmxrX21xX3VwZGF0ZV9xdWV1ZV9tYXAoKSwg
Zm9yIHNldC0+b3BzLT5tYXBfcXVldWVzIHVuc2V0IHdlIGNhbGwgYmxrX21xX21hcF9xdWV1ZXMo
KSAtIEkgYW0ganVzdCB3b25kZXJpbmcgd2hhdCBkb2VzIHRoZSBlcXVpdmFsZW50IHRvIGJsa19t
cV9tYXBfcXVldWVzKCkgZm9yIHlvdSBpbiB0aGVzZSBvdGhlciBtb2Rlcy4NCj4NCj4gPiBJIGFt
IGNvbmNlcm5lZCB0aGF0IGl0IGlzIG5vdCBwcm9wZXIgdGhhdCB3ZSBoYXZlIGEgc2V0LT5vcHMt
Pm1hcF9xdWV1ZXMgbWV0aG9kLCBidXQgaXQgZG9lcyBub3RoaW5nIGluIHNvbWUgc2NlbmFyaW9z
Lg0KPg0KPiBJIHRoaW5rIHdlIGdldCBhd2F5IHdpdGggdGhpcyBhcyBtcV9tYXBbZm9yIGFsbCBD
UFVzXSBpcyAwLCB3aGljaCBwb2ludHMgdG8gdGhlIG9ubHkgSFcgcXVldWUuDQoNClllcywgdGhh
dCdzIGNvcnJlY3QuIFRoaXMgaXMgd2hhdCBJIGZvdW5kIGR1cmluZyB0ZXN0aW5nIGFzIHdlbGwu
DQoNClJlZ2FyZHMsDQpLYXJhbg0K
