Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB2B7996F4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 10:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344247AbjIIIuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 04:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjIIIt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 04:49:59 -0400
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480BA10F6;
        Sat,  9 Sep 2023 01:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2993; q=dns/txt; s=iport;
  t=1694249395; x=1695458995;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gZWAns42T3cQ+GTQCauC61QSiJa9p2oLmxJfaoJolL4=;
  b=mwzRehVAqJtRskfjgzP3DQLvSm9gRqhwWFz0UAkhDhe9QpRBbE1gR8LN
   lQ5Ca011OWTPohWYsxid/IT5HyKnZkH6W7c/VEyHOTYxlugoqOLXRTA30
   mYHfa5f6yJBsR0mVD+9SlvjCq+dQ4CExuHRDb5CI+Ljl0/AxxJPh64edS
   0=;
X-CSE-ConnectionGUID: VT0FzjqoRWKxZOC+X5bioA==
X-CSE-MsgGUID: k94k+P3NQ0e1k7MN3kFySw==
X-IPAS-Result: =?us-ascii?q?A0B1AgCpMPxkmIYNJK1aHgEBCxIMQCWBHwuBZVJ2AlkqE?=
 =?us-ascii?q?keIHQOFLYhkA517gSUDVg8BAQENAQE7CQQBAYUGAoZxAiU0CQ4BAgICAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQECAQEFAQEBAgEHBBQBAQEBAQEBAR4ZBRAOJ4VoDYYEAQEBA?=
 =?us-ascii?q?QIBEhUTBgEBNwEEBwQCAQgRBAEBAR4FCzIdCAIEDgUIGoJcAYIqAw4jAwEQn?=
 =?us-ascii?q?F4BgUACiih4gQEzgQGCCQEBBgQFsBYEglIJgUiICQGIIYFlJxtAgU0SgQNDg?=
 =?us-ascii?q?mg+glcLAgOBX0uDR4IuiU2CK4JXPwUCMoIpgn80KoEYiC8qgQgIXoFqPQINV?=
 =?us-ascii?q?QsLXYEUgSiBHgICETkTR3EbAwcDgQIQKwcELxsHBgkWLSUGUQQtJAkTEj4Eg?=
 =?us-ascii?q?WeBUQqBBj8RDhGCRSICBzY2GUuCYwkVDDVOdhArBBQYgRQEagUaFR43ERIZD?=
 =?us-ascii?q?QMIdh0CMjwDBQMENgoVDQshBRRDA0gGSwsDAhwFAwMEgTYFDx8CEBoGDi0DA?=
 =?us-ascii?q?xlXA0QdQAMLbT01FBsFBGZZBaAWb4JKDoEjFwFYQEIoAg9kki2vUII4CieDZ?=
 =?us-ascii?q?IwAlTsXhAGBVpIFkgMulwh3jWGIb5FMAgQCBAUCDgEBBoFjOoFGDgdwFYMiC?=
 =?us-ascii?q?UkZD41FWwwNCRaDQIRZO4pldgIJMAIHCwEBAwmIbgSCVgEB?=
IronPort-PHdr: A9a23:uDCrlh3GucK/epPusmDPZ1BlVkEcU/3cJAUZ7N8gk71RN/7l9JX5N
 0uZ7vJo3xfFXoTevupNkPGe87vhVmoJ/YubvTgcfYZNWR4IhYRenwEpDMOfT0yuBPXrdCc9W
 s9FUQwt5Gm1ZHBcA922fFjOuju35D8WFA/4MF95K+nvE5LSiOy81vu5/NvYZAAbzDa4aKl5e
 Q2/th6Z9tFDmJZrMK831hrPrzNEev8Dw2RuKBPbk0P359y7+9ho9CE4hg==
IronPort-Data: A9a23:swsTwKmxr5lNmITGWnI/SODo5gxPJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xJOXWGCPKqOamXyf9x1OonjpEMHscXdn9EwHAppqyBhE1tH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaB4E/rav649SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+5e31GONgWYuaTpFs/Pb8XuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSq
 zHrlezREsvxpn/BO/v9+lrJWhRiro36YWBivkFrt52K2XCukMCdPpETb5LwYW8P49mAcksYJ
 N9l7fRcQi9xVkHAdXh0vxRwS0lD0aN6FLDvH0Tnn96R1kr8TFj88dJFT3FrN4wf07MiaY1O3
 aRwxDElZxSHgae9x6i2D7A2wM8iN8LseogYvxmMzxmAUq1gGs6FGv6MvIQEtNszrpgm8fL2a
 8cUczNzbBPoaBxUMVBRA5U79AutriCiK2EA8gPM9MLb5UDQnVByk4C2FuONd4WJGuBzxUW2t
 1nZqjGR7hYybYzDlmXtHmiXruvOmz7rHYEfDru18tZ0j1CJgG8eEhsbUR28u/bRolWiUthbJ
 mQK9Sc066s/7kqmSp/6RRLQnZKflhcYX9wVGOog5UTUkOzf4h2SAS4PSTsphMEaWNEeewBy+
 E2LhtTTOh9/gpq+CkLA/LaThGbnUcQKFlMqaSgBRAoDxtDspoAvkx7CJuqP9obo0LUZ/hmtn
 Vi3QDgCa6Y71pVThv/rlbzTq3f9+MaVE1JdChD/AzrN0+9vWGKyi2VEA3Dy6fJNKu51pXHe4
 SBcwaByAA3yZKxheQSEROELWbqu/fvAaWeail90FJ5n/DOok5JCQWyyyG8jTKuKGp9bEdMMX
 KM1kVgBjHO0FCD6BZKbm6rrV6wXIVHITLwJrMz8YNtUeYRWfwSa5ixobkP49zmzwRR1wP5vY
 sjKKZjE4ZMm5UJPkmPeqwA1j+dD+8zC7T+7qW3Tlk7+iuPOOBZ5t59cbgLRBgzG0E90iFyFr
 4kAXyd74x5eS+b5KjLG6pIeKEtiEJTILc6eliCjTcbaelAOMDh4U5f5mOpxE6Q7xP49vrmTo
 RmAtrpwlQCXaYvvc1vaMxiOqdrHAP5CkJ7MFXxwZAb2hCZ9MO5CLs43LvMKQFXuz8Q6pdZcR
 PgecMLGCfNKIgkrMRxHBXUhhOSOrCiWuD8=
IronPort-HdrOrdr: A9a23:YueOeK5KuLZjeS/DuAPXwY2CI+orL9Y04lQ7vn2ZFiYlEfBwxv
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
X-Talos-CUID: =?us-ascii?q?9a23=3AJR6RpmiaIq6cOu5ynSEjr1kJSzJuTEGF4mXSOki?=
 =?us-ascii?q?CNkV5epq+Cm/N8qJjup87?=
X-Talos-MUID: =?us-ascii?q?9a23=3Aimtb8Q7jXrDu8U9Pc64khfkTxoxrsvitS3hWt6x?=
 =?us-ascii?q?etpCHaglWYDSznQ+oF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-12.cisco.com ([173.36.13.134])
  by alln-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 08:49:54 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
        by alln-core-12.cisco.com (8.15.2/8.15.2) with ESMTPS id 3898nsHK022837
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Sep 2023 08:49:54 GMT
X-CSE-ConnectionGUID: n6zw4rdeQ660Tm4O3lfs7A==
X-CSE-MsgGUID: NDwm4EQ4QTmeo+o7T35Vsg==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=deeratho@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.02,239,1688428800"; 
   d="scan'208";a="1576395"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 08:49:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5wR+AMsRO3UJWcJC6G8fsnvzwBO07YGcUdc5QvRithNGUoCZGYi59ZVRCe8Gq8OprDGgoiIJpJtXB9UiLnYZEbYLshkGCbe1J8GMaAMOOi0buuggTwyYLHSkfo/ENADi0TNpTokNY97+fkTAQoZawkQsXSfZek9522Qr3+kPs39Gh5qhNb7Vjr3HXo5eEKXGkmaQpj4m4qi7h0Np66E1dger+ZqyPDRmIT38a+SrB+T6Q8m8Cw5QgwvRu8OFMMK9R+ofkunwr3ljsvk7SzI7dBiqw5qlLnzLQ7XFxS8IB+EaY2kXthDvh1UIibtO/hfeQvY4adtg8LW0iVOrRfqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0sFI09pNuMtjgzcMsSkQy6Spq6KBsfK12/2Kpl8+NM=;
 b=kU6TbG84bWV1P7PHSehQ8/PPJo25/EjJiBBiVach04eii+ZZ06C1Pi2FeYIOcQwfYJ0Jc3pIvbrT8IgElKPrntwkSxV9bnpjoOXhMuG86s1ImB/KzXNZ08BD0kT0teXQ9PbfH0oTD2DAuERYe4sXCzVVuSus5OxpJXHygLe785JITBBMl9KAV/AuUKCz1z55AN3KWvGY+Tbrz0dflJf/OYKWdwjni24wkJEv2cG29sLD2iVCDpuYjDJy+ZIini7g+qis3FCTWcglZuWIrkUNd9kvG+qAEcHPpd05R0p/Bz8vlza6znKCIIgi3GzwfzcJ3vxwuA1C8BYYxbpy5gAChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0sFI09pNuMtjgzcMsSkQy6Spq6KBsfK12/2Kpl8+NM=;
 b=UC+BJcgaq+nDtT4ZL+ADN6+/Pe0F0nFxiaiwG2TzjMSKHAVrUHCQUg+7Vrb5esWmfvfdVGc7dpwOkZ/NE4ie4XDpjKhiYtX9evtLIDd5taeVdmeNSFNf11OQzb0fRnofpFRWKTOpbjN1QstLD2GC2ehSZ/BsiGVqYw7co95Qk/Y=
Received: from DM4PR11MB6189.namprd11.prod.outlook.com (2603:10b6:8:ae::18) by
 SJ0PR11MB7701.namprd11.prod.outlook.com (2603:10b6:a03:4e4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.31; Sat, 9 Sep 2023 08:49:52 +0000
Received: from DM4PR11MB6189.namprd11.prod.outlook.com
 ([fe80::9b29:81ff:3783:1740]) by DM4PR11MB6189.namprd11.prod.outlook.com
 ([fe80::9b29:81ff:3783:1740%4]) with mapi id 15.20.6768.029; Sat, 9 Sep 2023
 08:49:52 +0000
From:   "Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco)" 
        <deeratho@cisco.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco)" 
        <deeratho@cisco.com>
Subject: RE: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Thread-Topic: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Thread-Index: AQHZ4LvcJrVsnoRBq0W95V9qrz7orbAPJ16AgAEtl9CAAB50cIAADDAAgAAAvOCAAATUgIABq+ow
Date:   Sat, 9 Sep 2023 08:49:52 +0000
Message-ID: <DM4PR11MB61897793502F49240BCA903CC4ECA@DM4PR11MB6189.namprd11.prod.outlook.com>
References: <20230906121525.3946250-1-deeratho@cisco.com>
 <2023090738-passive-snowless-3b9d@gregkh>
 <DM4PR11MB6189DEDD52F3E17C8C4E3D1BC4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <DM4PR11MB61890EE125816A786D153C22C4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <2023090820-wielder-angled-3def@gregkh>
 <DM4PR11MB618943BFA18521150923326BC4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <2023090826-fabulous-genetics-e912@gregkh>
In-Reply-To: <2023090826-fabulous-genetics-e912@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6189:EE_|SJ0PR11MB7701:EE_
x-ms-office365-filtering-correlation-id: 1ddf400b-f6f9-4bca-e7c7-08dbb111bb7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VYY8VfDvysc9ixl3+bLhbRRL5tFQG+AzTfM8K0PJrbw/Qpnzi0womaqPsguG+gIuXxNkM2Ci2cfqTAuLuAo5lp7OQNHZidAKJhnJo82S1TKLDcPri7A5bWB4SDJmj4sT/cuWdoz0gFbC3ytAmo73WlZL/TZf5rCI96qnMHD2F9jCIDVlqu6VJhUU+N6O4wFCQZ4EN7yphpXXQcAWxuXrRQROQfqrbjLCCzesO1TmXgK06iPQmH5PZkBu44Pao2p1ggqK8n/F4gWJgXT91WwS8di3JcJQv943kj+cQuRwTR+Nt9FMMe8VEf4bsXL5z8Jd9Sb9JleJzFXXSqCZOZckbOZcn+trh7F2msvIDbJtEBpfUVCA4epWIRofYXskjXUZdaAc3nYYsV2PfqSqcp2YisGmort7nA4ybpYtDRs/+C81Sju8SIyNKiuVGg1ItIv0CaWG4EeZuP+CgUIzfQBX3Nz1F4sFAs6ueJ8WvP5/82rBVq9trQlg+Dch2PZEX91LRL6VT3OPiRTTYwo6oZBZVKW6DvFsgTOzqplc7tEoNGNVoIVSJYgsu2TfpzVwsQWqwC6bSEl71jojBdouy5YAbkj3lQFV9x4D+ZyFHq6JaGI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39860400002)(186009)(451199024)(1800799009)(83380400001)(966005)(19625735003)(478600001)(122000001)(107886003)(9686003)(55016003)(53546011)(71200400001)(6506007)(7696005)(86362001)(2906002)(52536014)(8676002)(4326008)(5660300002)(8936002)(33656002)(6916009)(54906003)(66556008)(66476007)(64756008)(66946007)(316002)(41300700001)(76116006)(66446008)(26005)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OtOvLMWfQYNPMeaTmG2Ny9KTXS2jlJ3HjvnS3tzhAP+sQpXQ83ZIcMc9fm8E?=
 =?us-ascii?Q?nnls/EsQjoSWXGA6P2MoVX2Ob6gDrRMm9IKQwtL9pmwL57la4oZ8C2oK89Va?=
 =?us-ascii?Q?3bmGaVUyg9dF7r+EGgN2Tk7Vvwgl/AcS6Mxd8iR1xQAbme4W5Fcm15cblVhF?=
 =?us-ascii?Q?oYRmzN7FwIm/01DYnesrnF6T6OS56xbB7TTvsO1HwJWdSk2isknccLnfFGhn?=
 =?us-ascii?Q?wFBWwxKSMY6eZBT8u+EtAbfzXyk6er8UFCT2zbkq5OJ3jzvzq6pE1qz95eLs?=
 =?us-ascii?Q?j0qxw6udBbFNVczWb7Hu2OFVQUoElhZMhzVoEPlsdGn9K6ImdU8ZAkQc34Yb?=
 =?us-ascii?Q?kOxhhvsEx5vlZi97p5/vznVYSdtCClQcw/DWFl+qvArceQCSW+A364TMJfWB?=
 =?us-ascii?Q?RyowwcmmNpPr10sidwyzkUbqejqY25oddKujptEtQW8ip8WZ8gXM0MrcRXTk?=
 =?us-ascii?Q?vVzgHzxqfBrPAw+G2aAejvVJUTb+MF+OOKs999o6rtixhtVO/UH+2X8QWU3p?=
 =?us-ascii?Q?witlIoANohI5WwGH8iHF4zz4GlFx3s6ePg90xYYPG+POTS7Hn02qUzy6Gjql?=
 =?us-ascii?Q?srLBwpwjhb3r/oRex02ivZdeKEh8T3uru6hGPl79UMOPGwaCBJX6cil5eKhq?=
 =?us-ascii?Q?3BI1U7KGqdAqpSACYklHh9jLlVby1QuXEs+Hw261x6KPSvB6/S62VmlUavET?=
 =?us-ascii?Q?mCUpGHZlRQVE8cDgkaYZxd0Ccum95Z+U4zE7wZjCoKSOM/mImQgIfNAIxd1l?=
 =?us-ascii?Q?dhGSAuxb4kiYqqO3Q1sT0DKpKCHByvJ+yTl645IN9Flg94B+7cmBQi5QOdCm?=
 =?us-ascii?Q?F4GQCGrT4qlhuMTRSWbtqh781evNmXVOn4bateTMHgn1ifuaH2LpAKscqCzU?=
 =?us-ascii?Q?QcBxjumYsK3gH4K92Epm1QpEmrXi2Qju2/ftZOtj/l5lolecu0hReMYx4c0+?=
 =?us-ascii?Q?KV6jink92tKlL8PxwHEATwJ0YVMUaZDbqGxFpp3QyvQYtET41c2qeP5C+ArO?=
 =?us-ascii?Q?RhIMlkh7J5AB1LUJDiD6P8CK3OrFWfGDKI9raP5HBkmJ0yzQvVfKauQkbmLx?=
 =?us-ascii?Q?EHf4GkYnkaWDtrj82Rl8TP7aqZzgExB2HCYCaOUcFUsBibOxz/+99TQ5LdzT?=
 =?us-ascii?Q?DmXufTmJf6X+mN+Q1LXwYQBBwXwEl4uzApxntX0Xa96hMJsmzru23eRl9cNF?=
 =?us-ascii?Q?mLosyPATTyTBEmMa3BFnWZZloeYOpfWrRHMC/RJrtT6dG7qr6pS7lK4K0IZM?=
 =?us-ascii?Q?s39YzHDzfsJ9vsqWOMsDCz6EJQwfmyCdLgB6x/DII1b0JcQ2hfUA3kLbyY/r?=
 =?us-ascii?Q?4swkCBWkrneMXYSH2zhjDjFvmgYaQrf5wxidbQp3rv3hxjwv/k5OBkp+p82d?=
 =?us-ascii?Q?11kMQERyGuC1CbEbkilQ5AUF3Bkzgcl9F8h2uIJNwSxU5doR9v/Re04h6wQB?=
 =?us-ascii?Q?MBw3S73OtMEbLtVf43qTMtZ7z1/c9uP/ccLQkdMp3wqajidwXFKoscdHqRF6?=
 =?us-ascii?Q?wRMTmdZg2/RM7E+LmP2M7zLj8Z0BrXew7fHNi59rveAZwObiF1Sp5FrbwuaA?=
 =?us-ascii?Q?ZDIZAR1R7cDcduJ3NldZOaUh5l9OFGOqlqww+yRT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddf400b-f6f9-4bca-e7c7-08dbb111bb7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2023 08:49:52.1275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OeGdNuR6kIvnFPppPLWqZ6NqXTByea3Lq+U80nuExo3LKVOWJHPCaxBK35uXJZW3/dLrLllyUt9ueRMT3QHq5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7701
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: alln-core-12.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Friday, September 8, 2023 12:39 PM
To: Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) <deeratho@cisc=
o.com>
Cc: stable@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in =
btsdio_remove due to race condition

> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?

> A: No.
> Q: Should I include quotations after my reply?


> http://daringfireball.net/2007/07/on_top

On Fri, Sep 08, 2023 at 06:54:06AM +0000, Deepak Rathore -X (deeratho - E-I=
NFO CHIPS INC at Cisco) wrote:
> Hi Greg,
>=20
> This change is required to fix kernel CVE: CVE-2023-1989 which is=20
> reported in v6.1 kernel version.

> Which change?

[Deepak]: I am referring below change. This below change is required to fix=
 kernel CVE: CVE-2023-1989 which is reported in v6.1 kernel.

Subject: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in btsd=
io_remove due to race condition

From: Zheng Wang <zyytlz.wz@163.com>

[ Upstream commit 73f7b171b7c09139eb3c6a5677c200dc1be5f318 ]

In btsdio_probe, the data->work is bound with btsdio_work. It will be start=
ed in btsdio_send_frame.

If the btsdio_remove runs with a unfinished work, there may be a race condi=
tion that hdev is freed but used in btsdio_work. Fix it by canceling the wo=
rk before do cleanup in btsdio_remove.

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Deepak Rathore <deeratho@cisco.com>

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c index =
795be33f2892..f19d31ee37ea 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -357,6 +357,7 @@ static void btsdio_remove(struct sdio_func *func)
 	if (!data)
 		return;
=20
+	cancel_work_sync(&data->work);
 	hdev =3D data->hdev;
=20
 	sdio_set_drvdata(func, NULL);
--
2.35.6


> It is fixed in upstream starting from v6.3 kernel version and required=20
> to fix in 6.1 kernel version as well so we have backported this from
> v6.3 kernel version to v6.1 and I have sent this patch for review and=20
> merging.

> Again, what commit are you referring to here.

> confused,

> greg k-h

[Deepak]: Sorry for the inconvenience that my message did not provide all t=
he details.
The kernel CVE: CVE-2023-1989 is fixed in upstream with this commit: https:=
//github.com/torvalds/linux/commit/73f7b171b7c09139eb3c6a5677c200dc1be5f318
Starting from v6.3 kernel and we have to fix this in 6.1 kernel as well, so=
 we have backported this from v6.3 kernel version to v6.1 kernel.

Regards,
Deepak
