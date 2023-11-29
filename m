Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103AA7FDE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjK2R0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjK2R0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:26:36 -0500
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B282112C;
        Wed, 29 Nov 2023 09:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1233; q=dns/txt; s=iport;
  t=1701278801; x=1702488401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LDoizfVmAZkwK4vYIQc5/exGA43kxboClq0Rz9ss8Rk=;
  b=IpZipFzxeps2dOHvV7z5iVVZTf7DgpEyboG2zdIwqzAHcqJGawUbNvOL
   8enwR/FRlka6x5bSVV0bTfM8ZLV3SGuItKPzVx5aq58bQvvCo9lqU/AOk
   Y510GqwWXl/38W33Uvk5IDvt49Ne06PBmjB1AauJoCLR7OtKK9eNV3fk2
   w=;
X-CSE-ConnectionGUID: siz7qh8tTIaA7vD9gR4ZqQ==
X-CSE-MsgGUID: DoFWlH3uREqdzFPMzdG6DQ==
X-IPAS-Result: =?us-ascii?q?A0AuAABKc2dlmJNdJa1QCh0BAQEBCQESAQUFAUAlgRYIA?=
 =?us-ascii?q?QsBgWZSeVsqEkiIHgOETl+GQYIiA51+gSUDVg8BAQENAQFEBAEBhQYChykCJ?=
 =?us-ascii?q?jQJDgECAgIBAQEBAwIDAQEBAQEBAQIBAQUBAQECAQcEFAEBAQEBAQEBHhkFD?=
 =?us-ascii?q?hAnhWgNCIY9AQEBAQMSKAYBATcBDwIBCBgeEDIlAgQOBQgagl6CXwMBo2sBg?=
 =?us-ascii?q?UACiih4gTSBAYIJAQEGBAWybwmBSAGIDAGKDicbgg2BV4JoPoJhAoEzL4QSg?=
 =?us-ascii?q?i+DbIMXgh8HMoEKDAmBA4NSj1R/R3AbAwcDfw8rBwQtGwcGCRQtIwZRBCghC?=
 =?us-ascii?q?RMSPgSBYYFRCn8/Dw4Rgj0iAgc2NhlIglsVDDRKdhAqBBQXgRIEagUWEx43E?=
 =?us-ascii?q?RIXDQMIdB0CMjwDBQMEMwoSDQshBRRCA0IGSQsDAhoFAwMEgTMFDR4CEBoGD?=
 =?us-ascii?q?CcDAxJNAhAUAzsDAwYDCzEDMFVEDE8Dbh82CTwPDB8CGx4NJyUCMkIDCQoFE?=
 =?us-ascii?q?gIWAyQWBDYRCQsrAy8GOwITDAYGCV4mFhgDRB1AAwttPTUUGwUEZFkFomZhf?=
 =?us-ascii?q?F9lgQ6WS61TgS4KhA+hQReEAYxzmRKYQqgtAgQCBAUCDgEBBoFjOoFbcBWDI?=
 =?us-ascii?q?lIZD44gGYNfj3l2OwIHCwEBAwmKYQEB?=
IronPort-PHdr: A9a23:LL7ORByoDRK0TiTXCzMRngc9DxPP853uNQITr50/hK0LLuKo/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHBxd+53/uCUFOA47lYkHK5Hi77DocABL6YAl8PPj0HofRp8+2zOu1vZbUZlYAiD+0e7gnN
 Byttk2RrpwPnIJ4I6Atyx3E6ndJYLFQwmVlZBqfyh39/cy3upVk9kxt
IronPort-Data: A9a23:FqSgHKzMIiM7R/5fTIV6t+caxirEfRIJ4+MujC+fZmUNrF6WrkUHz
 2UZUGCFOvyMM2qmctF+Oou380NQsMPdx4BhGVdp/1hgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlpCCea/lH0auSJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 Y+aT/H3Ygf/gGctaDNMsspvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE88jmSH
 rurIBmRpws1zj91Yj+Xuu+Tnn4iHtY+CTOzZk9+AMBOtPTtShsaic7XPNJEAateZq7gc9pZk
 L2hvrToIesl0zGldOk1C3Fl/y9C0aJu477VfmG/4dCv7kTvLGXAkvpUUHMvBNhNkgp3KTkmG
 f0wMjsBaFWIgPi7heviDOJtnc8kasLsOevzuFk5kmqfVqlgEMuFGvmVjTNb9G9YasRmHv/Ee
 8sdYDlHZxXbaBoJMVASYH47tL701yWkLWYH8zp5o4Ib5EbsyCwqzYLAKdbHVOSvV8l6wGqh8
 zeuE2PRWUxCa4fFllJp6EmEgu7JgDO+W48IErC83uBljUfVxWEJDhASE1yhrpGRjk+4RsIaM
 EcP+wIwoqUosk+mVN/wW1u/unHsg/IHc8BbH+t/4waXx++NukCSB3MPSXhKb9lOWNIKqSICz
 V6bwMrpVSBTkbS8Fmyxp7iu8QGrAH1ARYMdXhMsQQwA6tjlhYg8iBPTU9pueJJZaPWrQVkcJ
 BjU9EADa6UvsCId60msEbn6b9+EvJPFSEs+4R/aGzv8qAh4f4WiIYev7DA3DMqszq7HEjFtX
 1Bdx6ByCdzi67nRzURhp81RRdmUCw6tamG0vLKWN8BJG86R03CiZ5tMxzp1OV1kNM0JERewP
 xeK4FIPvsEOYyvzBUOSX25XI5pwpUQHPYq9Ps04kvIXOvCdiSfepX4xOxbIt4wTuBJ9zv9X1
 WinnTaEVitCVv89k1Jats8W0KQgwWgl1HjPSJXghxWh2vz2WZJmYeltDbd6VchgtPnsiFyMq
 753bpLWoz0BC7eWSneMruYuwaUicCJT6Wbe8ZIHL4Zu42NORQkcNhMm6ep+JNU7z/QEz7igE
 7PUchYw9WcTTEbvcG2iQntic7joG514qBoG0eYEZD5EB1BLjV6T0Zoi
IronPort-HdrOrdr: A9a23:yE9q7q6dzg64lgjOgwPXwY2CI+orL9Y04lQ7vn2ZFiYlEfBwxv
 rPoB1E737JYW4qKQAdcLC7VJVpQRvnhOdICPoqTMeftW7dySWVxeBZnMTfKljbak/DH4FmpN
 pdmsRFebrN5B1B/LjHCWqDYpcdKbu8gdyVbI7lph8HI3AOGsVdBkVCe3mm+yZNNXF77O8CZe
 ChD7181kGdkBosH6KGL0hAddLu4/fMk5XrawMHARkI1Cmi5AnD1JfKVzKj8lM7ST1g/ZcOmF
 Kpr+X+3MqemsD+7iWZ+37Y7pxQltek4MBEHtawhs8cLSipohq0Zax6Mofy/wwdkaWK0hIHgd
 PMqxAvM4BY8HXKZFy4phPrxk3JzCsu0Xn/0lWV6EGT4/ARBQhKTvapt7gpNScx2HBQ+u2UF5
 g7hl5xgqAnSS8oWh6Nv+QgGSsazXZc6kBS4tL7x0YvI7f2LoUh7bD2OChuYco99OWQ0vF8LM
 B+SM7b//pYalWccjTQuXRu2sWlWjApEg6BWVVqgL3e79F6pgEw86Ij/r1Vol4QsJYmD5VU7e
 XNNapl0LlIU88NdKp4QOMMW9G+BGDBSQ/FdDv6GyWqKIgXf3bW75Ln6rQ84++nPJQO0ZspgZ
 zEFFdVr3Q7dU7iAdCHmJdL7hfOSmOgWimF8LAS27Fp/rnnALb7OyyKT14j18OmvvUEG8XeH+
 2+PZpHasWTZFcG2bw5qTEWd6MiXkX2Cvdlz+rTc2j+1v72Fg==
X-Talos-CUID: =?us-ascii?q?9a23=3AEGoO+mhOAyp0s95av8TDWpB4HDJuaXzPk27Qc1O?=
 =?us-ascii?q?EKG9AF6O5GFCqpJF9qp87?=
X-Talos-MUID: 9a23:2fAdLgRtgTaskIcTRXTAgx9dMOcz/p6DEUwfv60jqcWrawBJbmI=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 17:26:40 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id 3ATHQepE024041
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 17:26:40 GMT
X-CSE-ConnectionGUID: gWmjeJhzS+CvtNDye8nJtw==
X-CSE-MsgGUID: cWlqmjKDQJ2p71zPW8Qcag==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.04,235,1695686400"; 
   d="scan'208";a="12755581"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 17:26:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHSw+JmBCv/hMSnJXrY/dx4EkMt8Py1y6ERF7BOPZ+RAjzGJgdd/nT2vEmlox/G4qI35owYosWGf+XMrMkTd6mnaavYVEjFZakRxMJl+r2qhKAzkLMRopWq+e+jVFKRCIvcasIVQpwe2LDuOuTaOTbasX9kTIlAEsxEbAt/rhe4nxrTiYzTOUgx4R4ge76HFa7MhFFVpnNokPfNhOL5V/OwmhpqYLEsvQE7M39O363yIW0e6vut89yjbk5QeojHEc1pi0pesPXlxVDy7P8w/9bUJjpvYOspLtTeSCuUTGRieFtfFNHD1reh2v7YMBoMdL28us6P+8snmZSrnEeTcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDoizfVmAZkwK4vYIQc5/exGA43kxboClq0Rz9ss8Rk=;
 b=b+a1o1i89TvGEQUUyBYczuUkcR2f6LtykYDYtN2KH5fSQtouiVOxImv419bHW6gw97j82Dj5Esq3UIJ/CMBrtVy1lRMh1WvVwIgej/lIFRLfVHFqXxC9TaFPRvga1lGph+1EYwyXeOuXI2l4rUwARL17nBH6wHU+UAHyEmbzNozZLlvAv/cyPD3URqP5A0E/3Y1z+TBu1/53WUc/bbBF38Hex0fgiAbIC/BgD2wsZjl7Hc1WOKDHw7Eqo1RtnPyeIYjBXvNY5pNqYr6sP0lQawO3lEH5UvHfYrYAwe1BDOuMaJeriFkII9WUQQmeFXexaLaOsRXSgfHQ/lWmo6fKQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDoizfVmAZkwK4vYIQc5/exGA43kxboClq0Rz9ss8Rk=;
 b=iEeyJXC/mXzMp3hIMxl1pBTLnvlD0CloWVi2s6WFfeHe7cd08Uqg5C33DI9LRSeRAw/iFLdLviyfZ0vTwOSSN+W5KMS+In3prI//kmbCydEPM3riNe3/6MgXXTcl2YtJt2DnS74i33o6MrUqf0VQPM3/nMbEamLLmhJL/n9uSRs=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by BL1PR11MB5319.namprd11.prod.outlook.com (2603:10b6:208:31b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Wed, 29 Nov
 2023 17:26:37 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 17:26:37 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
        "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 02/13] scsi: fnic: Add and use fnic number
Thread-Topic: [PATCH v3 02/13] scsi: fnic: Add and use fnic number
Thread-Index: AQHaF0p6uXPGn2t9xE+tpp//qiyWn7CKTRQzgARhDUCAAvU4YA==
Date:   Wed, 29 Nov 2023 17:26:37 +0000
Message-ID: <SJ0PR11MB5896F27BA063CC63483B32DBC383A@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231114223221.633719-1-kartilak@cisco.com>
 <yq1y1emtzok.fsf@ca-mkp.ca.oracle.com>
 <SJ0PR11MB58960721DF0510FC1CED01F8C3BDA@SJ0PR11MB5896.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB58960721DF0510FC1CED01F8C3BDA@SJ0PR11MB5896.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|BL1PR11MB5319:EE_
x-ms-office365-filtering-correlation-id: eac28a1a-9a7e-4f4c-bf50-08dbf1005796
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kboz0o8iTwVEPYAdWrG+FElEuFxjB9IRXCFaMzQdQ7I1knoxDIiMLD9ZVKJdCdeRwsUXc5rQbEZMlL0ShWjzRRVuBrVZIY1giys2ORn906PZhPUHlwYy/ldX1oTqxHl9UiOOD5PgMNA2hoRqDZMsmVCtdCTp0LEJZHX3T215F5ZlhtUs+YLUfPGNdBZPV8BDCoYbhGdxYe/JHyE17UGYZr2VmN0I/LvgSDyfJLmSIZxhFHNgrAQGuqnnOYvsGssCCMhg/VSmH9LsKsheiTGHGlJ8oEaTI2BTgyrHH0J2rfO+zX7kn2fI2rpHndvicgaBzXANgnT8RhyYAQLe05XigBbFESX0VvFOe7FrckKsJlF7uWb/lpuju/a9EiQpMAEpIbRX2o5sOGPEBTUm+4x9t6VQIUvuV4/irsnRaUC6DyNjX2sGVslXCQSrFerbXVVo5zcWeMMJyDqbHZzO3StDsWQGRAqiEsGBLk6UJ0LP6OdVewVVGOynNwMyN3iPtWANopItDisDkJknzy5A+RF9trcJqFmgX4Sqkmr54u1zJS3IdHF6bwHZ1ED1PY6V6gtO2p3MSukunzCFC0pEBgXa7t2BmX4Vf99iIL9ThcWjbaRdQ3H5iWWZbjeaGjFzL6vC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(8676002)(6506007)(52536014)(7696005)(55016003)(76116006)(8936002)(86362001)(5660300002)(53546011)(4326008)(478600001)(66476007)(6916009)(64756008)(66946007)(54906003)(316002)(66446008)(66556008)(38100700002)(83380400001)(122000001)(2906002)(71200400001)(9686003)(38070700009)(41300700001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T6zYK5ecn9vCHkhzHpRNek/TKDNsPCFQzQLOntXCrQ6rWGOXPx3AVOTFK7gN?=
 =?us-ascii?Q?j7+8Y7T5nmJCnjPJM45ap3hEUqvv8n9i04rL1zBaiMP04oKvc4yXihjju7Im?=
 =?us-ascii?Q?L3vPw9lFl8+lYnGHWnkinkPrKw0tecRMjfVKuMa/JKUCOLSL4/3zV5osHTCV?=
 =?us-ascii?Q?Zn6fyLwRTq6yAXg+o3uIAttJNp9kLGqkWC8pxbjaaCPC4+hn00Hrx1/fwDlb?=
 =?us-ascii?Q?P/c88B+Gl0LDXsr9LUy24Bf0UWA2GqwIu8sfZ55CFKdCeAJeXE2X8qHspVbJ?=
 =?us-ascii?Q?FUphDgH1tIPMe+wDtaeLhzZJ/tAh49aWxgNqYUCdSvtVMd1KCUqZiywc1+ws?=
 =?us-ascii?Q?eiY0jwfUKTWz04cIAIBvRt/2ZSHeb6gsO7ih0bRYni6Jzvc0R4vwGO3n/r2E?=
 =?us-ascii?Q?GL223FC0bWSZrKi5anGjFFntRyeuwqsaKvwgJ6yJYCXF8x4xrfTi0G+7b3bm?=
 =?us-ascii?Q?22lCc66PqgczTnWYvYtfDb2AOQ6hyDLS8ndNdUV/Q6FjoduCbJfOcIcKZjyH?=
 =?us-ascii?Q?0ZCfcdEmhaFG/pjBBVXq+xXoVoJo/oB8V+LMiFVH9xzamWT2fVyApQV+oMdM?=
 =?us-ascii?Q?HYWm11UsJxOQJCXLPaG3R6zYQj0sojzSaXEHN/LXYQg+x7rZ+n8Gdp3MXKhV?=
 =?us-ascii?Q?ZDm6LjCSwgdw+fDxl7/jwr80eoWAO4kS2XjlZ0sjwOcPecwmRyhXp1iCfbeM?=
 =?us-ascii?Q?Or+iosXf4dSlOC1KDnqbFA9Q0Xi39Ub4Ranj0T4Ze+aUSCRsEKTpVzQJlpWX?=
 =?us-ascii?Q?YwCB2whadpD6uFo4Ta5AJARUsJhZVcUSgkC5CPtbYgduBdk0PO/fvO10KGnE?=
 =?us-ascii?Q?37k7q8QiJTj3Qg4/QscCuQ/TMdRHRO/Wzboj9qSwk05YPC7ZdyLCZKdswpTm?=
 =?us-ascii?Q?Fr3A2LHfr2DCldGTFyAsdi2XBsCOH7nHKRe71EGeqhC7GLUoH/9GCr5oaGxF?=
 =?us-ascii?Q?3OEAQW0YVjmDP2KSJ5xU+hQhNg31N4rv2tuwyVM+asUWvuTR7WSvqbSvchKh?=
 =?us-ascii?Q?vsuHOCdbZVclda3uBpdHUNRg8D0Fy3U+2ywt5MZLEhkttLUCm/tJpwNEZsQj?=
 =?us-ascii?Q?RqQQxP3hy6Sn7oudYMs8VmOXNOMBPn3Lpm7vhIVC7HPjwx43haGgiN0xQJxa?=
 =?us-ascii?Q?hHJ4OXaccNJOEQ5AdtPNDS41X3zzNFwWlew30w9tK1d4C9yIvqJyCQIe5kCg?=
 =?us-ascii?Q?YInWnPMEXtiGM21HnoOWq0v6YhAtbtNUrJxHlV4/Jl7qJnbo6iMuWaFzjbmV?=
 =?us-ascii?Q?EJ792gOVIKZe+BHgKVqmKZfhfsUiAnViCvHwou5f+C2bREheBik0zC+JLwix?=
 =?us-ascii?Q?FqD1TePJ388PuR2PXTFTI++O/rYB7je85HJk75KbcaHLL42YIUllV+xqwl96?=
 =?us-ascii?Q?Ioeg0Ns9XC4eMQaVpWkyMBB4wvHUM/MuoRD1Jes1LYxYkQckXCYaQLOxnmin?=
 =?us-ascii?Q?A8FSG3QyMuSQCNEGzB9D9BwjMK/LUyeMKVgS2H7WkUtuRe/o+qsLqeNiSTR1?=
 =?us-ascii?Q?3ZOuGwscQS9JzkyBJiFX8QjIeero1OH7BX3yxgcstK5sbLF+3f+K1qbZBfCu?=
 =?us-ascii?Q?kDyYMKIWGX8Fg6pTynpV4kNgYphpFE0HKDtBBPehoU6SkyqylLu/bHzxq4T8?=
 =?us-ascii?Q?D1rfV3XUXbOY6YRA6UgDO+U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac28a1a-9a7e-4f4c-bf50-08dbf1005796
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 17:26:37.4284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xVsQ9J0lrPuMYBFL4vTMdg67rcFAScbo9xE+1VuoeKLXt6Eq+eBIKP5oJsRYhPQPT2txkLzPqpuBgv1ddZzpRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5319
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-11.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 27, 2023 12:18 PM, Karan Tilak Kumar (kartilak) wrote:
>
> On Friday, November 24, 2023 5:22 PM, Martin K. Petersen <martin.petersen=
@oracle.com> wrote:
> >
> >
> > Hi Karan,
> >
> > > Add fnic_num in fnic.h to identify fnic in a multi-fnic environment.
> > > Increment and set the fnic number during driver load in fnic_probe.
> > > Replace the host number with fnic number in debugfs.
> >
> > I agree with Hannes. Everything else in the stack will be using the hos=
t number. Your change will make it harder to correlate a SCSI error message=
 to an fnic driver instance.
> >
> > If you absolutely need an instance number I suggest you add it as an or=
thogonal value instead replacing the host. Also, we typically use an idr fo=
r enumerating things like this.
> >
>
> Thanks for your review and comments, Martin.
>
> I understand the issue. I'll take your suggestion about adding the fnic i=
nstance number as an orthogonal value instead of replacing the host number.
> Could you please help me understand what is meant by "idr"? How can I use=
 it?
>

I found it in the Linux documentation. =20
I'll make suitable changes and re-submit the patch set as V4.

Regards,
Karan
