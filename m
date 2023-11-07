Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C46A7E4972
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbjKGTy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKGTyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:54:55 -0500
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99735D79;
        Tue,  7 Nov 2023 11:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1254; q=dns/txt; s=iport;
  t=1699386893; x=1700596493;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r8hulm3tDHgQjXGkz1tYi2DlumO7+B5YXts4FBb6E4o=;
  b=c61LnWm9+08P8xWAn5s6xEU8sNIXGLxzvFAQZR0+S5sl58jlQSw1TDB/
   Rui9ejv24jnIqmZrvTCRbjL1kIeY8nz+RR0Q5xLN66QMa6jsWyMLwc436
   /LyaBxlU+J9kP6vEPfmA+RFoQxZC9k6EPxC5ZNUAh8JTU0PHPvsSCP8gx
   o=;
X-CSE-ConnectionGUID: hmU4y/ATRre+z/3/BHpeAg==
X-CSE-MsgGUID: gcODKJN3RGeKJ8MBtXhLJA==
X-IPAS-Result: =?us-ascii?q?A0AmAADilUplmJpdJa1aHQEBAQEJARIBBQUBQCWBFggBC?=
 =?us-ascii?q?wGBZlJ4WzxIhFKDTAOETl+GQIIiA51+FIERA1YPAQEBDQEBRAQBAYUGAhaHE?=
 =?us-ascii?q?AImNAkOAQICAgEBAQEDAgMBAQEBAQEBAgEBBQEBAQIBBwQUAQEBAQEBAQEeG?=
 =?us-ascii?q?QUOECeFaA0IhkQBAQEBAxIREQwBASwLAQ8CAQgOCgICJgICAjAVEAIEAQ0FC?=
 =?us-ascii?q?BqCXIJfAwGgKgGBQAKKKHqBMoEBggkBAQYEBbJsCYEaLgGICQGBUIg3JxuCD?=
 =?us-ascii?q?YFXgmg+gmECgSsBEgEjg1k5gi+DcoU5BzKCIoNTjSYJd0dwGwMHA4EAECsHB?=
 =?us-ascii?q?DAbBwYJFC0jBlEEKCQJExI+BIFlgVEKgQI/Dw4Rgj8iAgc2NhlIglUJFQw0S?=
 =?us-ascii?q?nYQKgQUF4ESBGoFGBUeNxESFw0DCHYdAhEjPAMFAwQzChINCyEFFEMDQgZJC?=
 =?us-ascii?q?wMCGgUDAwSBNgUNHgIQGgYNJwMDE00CEBQDOwMDBgMLMQMwVUQMUANsHzYJP?=
 =?us-ascii?q?A8MHwIbHg0nKAI1QwMRBRICFgMrIgNEHUADC209NRQbBQQ7KVkFoEWDKUg1E?=
 =?us-ascii?q?QEBHY02iHNJrjMKhAyaEIcvF4QBjHMDmQmYPiCoCAIEAgQFAg4BAQaBYzprc?=
 =?us-ascii?q?HAVO4JnUhkPjiAZg1+PeXY7AgcLAQEDCYpqYAEB?=
IronPort-PHdr: A9a23:B83XjRI2Qn3VYaFSw9mcuakyDhhOgF28FgcR7pxijKpBbeH/uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1o2t2qjPx1tEd3lL0bXvmX06DcTHhvlMg8gJe3vBo/Whsef3OGp8JqVaAJN13KxZLpoJ
 0CupB7K/okO1JJ/I7w4zAfIpHYAd+VNkGVvI1/S1xqp7car95kl+CNV088=
IronPort-Data: A9a23:Wbsuja/gq1Ye4xKw3lshDrUDvX6TJUtcMsCJ2f8bNWPcYEJGY0x3n
 2JOUWuDOvzYZjbyethya9+xpxtUuZPTxtI3HgNtqXxEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEzmE4E/ra+C9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4upyyHjEAX9gWUtazpLs/jrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dgJtb
 7+epF0R1jqxEyYFUrtJoJ6iGqE5auK60Ty1t5Zjc/PKbi6uCcAF+v1T2PI0MS+7gtgS9jx74
 I0lWZeYEW/FMkBQ8QgQe0EwLs1wAUFJ0L/CHCSu9uWv9VfLMGmrmLJELFk7FIJNr46bAUkWn
 RAZACoGYhbGjOWszffgDOJtnc8kasLsOevzuFk5kmqfVqlgEMuFGviWjTNb9G9YasRmHv/Ee
 8sdYDlHZxXbaBoJMVASYH47tL7z3CSiImEA8Tp5o4I46E//7y5Xi4LCPfn3KvmgWfVVumSx8
 zeuE2PRW0FGa4P3JSC+2natgPLf2CD2QoQfEJWm+fNwxl6e3GoeDFsRT1TTif24jFOuHslUM
 E085CUjt+4x+VatQ927WAe3yENopTYGUNZWVuY98gzIkezf4h2SAS4PSTsphMEaWNEeRTkXi
 k7Otu/THzEsovrODli97rq9ombnUcQKFlMqaSgBRAoDxtDspoAvkx7CJuqP9obo0bUZ/hmtk
 1i3QDgCa6Y71pFUiv3qlbzTq3f9+ciTF19dChD/Bzr9tmtEiJiZi5tEAGU3AN5aJ4qfC1KGp
 nVBwI6V7fsFCteGkynlrAQx8FOBua/t3N702AMH83wdG9KFpyfLkWd4u2EWGauRGpxYEQIFm
 WeK0e+r2LddPWGxcYh8aJ+rBsIhwMDITIq0B6uEN4oSMsEvKWdrGR2Cg2bOhggBd2ByyckC1
 WuzLa5A8F5DU/08lWrqLwvj+eVzln5WKZzvqWDTlkT7juX2iI+9QrYeO1zGdfEi8K6Bu23oH
 yV3aaO3J+FkeLSmOEH/qNdLRXhTdCRTLc6t8aR/KLXcSjeK7Ul8UZc9N5t7Jdw890mU/8+Vl
 kyAtrhwkgei3yKdc1nUNRiOqtrHBP5CkJ7yBgR1VX6A0Hk4aoHp56AaH6bbt5F3nAC/5ZaYl
 8U4Rvg=
IronPort-HdrOrdr: A9a23:OAYuN6hUWnaFrZLSgWC868Ng3nBQX5923DAbv31ZSRFFG/FwyP
 re/8jzhCWVtN9OYhAdcIi7Sdi9qBPnmaKc4eEqTM6ftXrdyRuVxeZZnMXfKlzbamLDH4tmpM
 VdmsdFeaDN5DRB/KHHCUyDYqgdKbq8geGVbIXlvgtQpGhRAskKgXYde2Km+w9NNXZ77PECZe
 KhD7981kCdkAMsH7+G7xc+Lo7+juyOvqjLJTQBABkq4hSPizSH1J7WeiLz4j4uFxl07fMH62
 bqryzVj5/Pjxi88HDh/l6Wy64TtMrqy9NFCsDJoNMSMC/QhgGhY5kkc6GevRguydvfq2oCoZ
 3pmVMNLs5z43TeciWeuh32wTTt1z4o9jvL1UKYu33+usb0LQhKSfapxLgpNycx2XBQ++2U45
 g7mV5xcKAnVC8oqR6No+QgkSsaznZc70BSytL7xEYvIrf2IIUh37D3unklUKvp2EnBmd0a+C
 4ENrCH2N9GNVyddHzXpW9p3ZilWWkyBA6PRgwYttWSyCU+pgEy86I0/r1Wop47zuN3d7BUo+
 Dfdqh4nrBHScEbKap7GecaWMOyTmjAWwjFPm6eKUnuUPhvAQOAl7fnpLEuoO26cp0By5U/3J
 zHTVNDrGY3P0bjE9eH0pFH+g3EBG+9QTPuwMdD4IURgMyweJP7dSmYDFw+mcqppPsSRsXdRv
 aoIZpTR+TuKGP/cLw5ljEWm6MiX0X2fPdlzerTAWj+1/4jAreawtDmTA==
X-Talos-CUID: 9a23:ttEnvm0q/ryf9fbU2dZWpLxfGsUYLmya5UvqOUL7GyEyD5e1UVK59/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3ALyWJKw/+r0nJeEvc8e4i39qQf8hjxIiNKmZWq7o?=
 =?us-ascii?q?LmOvUEAZsCze5rh3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 19:54:38 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
        by rcdn-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 3A7Jscl7008418
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Nov 2023 19:54:38 GMT
X-CSE-ConnectionGUID: MXNv5CmATUShd00yAxYolQ==
X-CSE-MsgGUID: nYdFhiM4Q3qCUKwEfY6bjQ==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,284,1694736000"; 
   d="scan'208";a="7432423"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by alln-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 19:54:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NppMkZMwAZ0qr5i0MHZn+xYwK5ttP2/UTB5bjYkkc1OKtlFh8rZ5hv45rTYRVVCcYIef2TD0FFkXHpfPvpWVokc0v9W+ICe6X6G8fc5LCXvJACIevxxfhmzV5ma9w4GcPkna5w3+zv96AT2WRtfVo8zlwZLssZI6K3saZL6elR2OR/hyll8DMCR5sQy/9vskm+6BZFLM5UUppTG8xkhPYCuMZFhCsg8TAMbBemVpfRkKxRlUot1ZLdiC5MLh2wOQiq9DER38R2yBxod/MjGKf2VuHuJvfMbq1NHj32NzOj+9q/bizDNDESLK0HH6KWKQUtuxPukXtpVIO/3xDiEcjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8hulm3tDHgQjXGkz1tYi2DlumO7+B5YXts4FBb6E4o=;
 b=ZKMcOrcnl5N0Gj73EM+/ZEwxGUubI2anXZ28V+pppMf8BqRH0+WmeNrLHiyAoMGdDHW0yQjnKVYw7tYY23ZlV1OHz3bzN8sYcxYP27NgmL3WdZcxJIP69caq4dFjbo94/fABtARqYO4wpTgMjVaS69ZksR2qQqAU7XdDz5MwDUVqgNTo4b4oMcko9dmtfbO1yf8RqbK4g5WaLPKJnjw2ECOeafOGesIzpkKIX751qtczWjfkyqCCHZjHXsPhUxh35n8VCITWXj6o9OIDhxm0SQV3OMQZ4BybzuAZUOW4Btr5+JItR2u2mjH8/rDJcxMsVdkAAWxRnwwnuNg/judNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8hulm3tDHgQjXGkz1tYi2DlumO7+B5YXts4FBb6E4o=;
 b=HRtLiQSjyINpGsmQ/bUvultU8gLLTGH71VMZCEuqAuxl1ogqEc5cJPWEH3z3p0S5h6/lcGzovpyvThyYUHD/DBqQdzVI9lzDyX00KKzVheqXiayP+5MJZPGv7pGrxNjrJhwOts/RaVd7sXSUZdPA5NHVerrLbrK7UZmvt5zdShs=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by MN2PR11MB4712.namprd11.prod.outlook.com (2603:10b6:208:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 19:54:36 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 19:54:36 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     Hannes Reinecke <hare@suse.de>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
CC:     "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 03/13] scsi: fnic: Add and improve log messages
Thread-Topic: [PATCH v2 03/13] scsi: fnic: Add and improve log messages
Thread-Index: AQHaCP/qh3b6PTh+8EGi8tSfqgAnobBmqi6AgAcYxLCAAMDygIAA0c1w
Date:   Tue, 7 Nov 2023 19:54:36 +0000
Message-ID: <SJ0PR11MB58962C5B6263F79D48081292C3A9A@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-4-kartilak@cisco.com>
 <41c2fd4c-f6b3-450f-87b3-d059d52ba2f0@suse.de>
 <SJ0PR11MB58960545FE72C28A91D3585AC3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
 <32be196b-4742-4411-adc5-bb0220470662@suse.de>
In-Reply-To: <32be196b-4742-4411-adc5-bb0220470662@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|MN2PR11MB4712:EE_
x-ms-office365-filtering-correlation-id: 15285bb2-b86a-418b-9781-08dbdfcb5e94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ddzgih0H1LFaTn0fK5+Nv+Nav0TOKCiAoOzTEG/0aMO2qiAyXLxYI05qBT27QSQtRSpRa8/8RgCLUvsyjL6TwAKumlGHqam2l3t4LA3umUq3bRkKVdfpAhF08OJt7czPzZ5JZloFIsQB7qmTAzb5pured27cxWG5eWpuaxQf2Wk39g4x1mtxUMMn8cwwBKbW6ZooAfRUYTA4F+JkyJNqGoNm8QmSgde5W+UQnkWcDBvV1/QNw9DySnrv+5vRaWHFlsa1KfJWuefydEx5wS0mrjLSd1WNkE4WvUKUTd/97Pd5ZUJUjMXSwIoEP0Zyz1j/m2EPmrEz9oMbUmtjLoR/ovdoC5dh+tAz9WwLrVL6q6Yq15YOJ9BJuX1vlAT7tgtCvjhET5i/pUhvvka/ee7tjy4OFErnVE3F9rp+nXoLH9YF0C78UL4UyIFE2XcRsmv+E99rK3FycPeKOUaNjRXvcMQ6W8hmVWR2jpM84fK+O3OArmtniLibwzdubXDc3WIHhlp5BZoL6VHOIpR/4w86VQuUtQD2Kb/gBqZwauyWpmvUB13dAEz6Lc8vbR/RaSFWUMHbbEeUlYs/OTF0GhGM33jpJo6+IfmLECbFjwttz/ssjhxPcDrZaJLYHt5XqEo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38100700002)(55016003)(7696005)(71200400001)(6506007)(53546011)(9686003)(122000001)(86362001)(41300700001)(6636002)(4744005)(2906002)(52536014)(5660300002)(8936002)(33656002)(8676002)(4326008)(316002)(54906003)(66556008)(66446008)(76116006)(64756008)(66476007)(110136005)(66946007)(478600001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjlnMWVTcnB6cVNncnIvUnlUTExIN2pPaG53NXVZK05TZ3JNU1ovSGl1amY1?=
 =?utf-8?B?Tk5OYTlrUXlJempPaVBManNYTVV0bTMxMlBudk9FNE82LzN2NDdyeGhoVytU?=
 =?utf-8?B?ZWUreUpUZ1BhK0Y0SkFaYTVRNG5sdGNXMmkvdWpVVUorcmZSUCtSUk5hdTRM?=
 =?utf-8?B?NFEwd3NtdDVsdDN4ajAzSTRwanJycUR0ZlBmZ0piNm1YZjl0N1Z5Z1BURUg4?=
 =?utf-8?B?WnBLSGpBTE9Gb3FCUEVZRkxQdWJyRW9QN1o2Vks1RXFjVzNjc0U1VVBWR0RU?=
 =?utf-8?B?MnFJMVA0Q01ZZ3ZkKzduQnE1RExhd2ZSZlhUNElQR3NuaGdrNlczTlJHWWhz?=
 =?utf-8?B?Y2txOGFJaVFLYVZZY0tEM0NRSzVQaUpGMGxNTGRwSkdQSENjZnFvWVUwNGdM?=
 =?utf-8?B?aHhHQVN4MW1jTUNva3czTHNCeTRoK1RrQ3hSeDNIWGh6Nm03SjNINDdkNW9p?=
 =?utf-8?B?ellITGlDVTBLL05GQVdXay9BajE2bWJuRzVQb3JvelpGeVQzN3o4OVA3dzda?=
 =?utf-8?B?eWdRTHUvRGZsaVZlVlp1bXFUa3ZuV2ExOGkwZEtnTFhnWnZrSCtxQm44V1RV?=
 =?utf-8?B?ZVdkc04zNjc1YTNGRjJWa1JwWDYxaVdSVVZJN09YL0VyQXY1REVzTTNWdU4w?=
 =?utf-8?B?WkxPcnFhRFArK3BvOE5YT0ZjWHpoT2I4bDJtMEZTS2hOaVFNR3llendDQkRr?=
 =?utf-8?B?WFovTXhWRlZZK0piRTV2dGQwdkpUYUk1bnljV3VMTmZWbkVQZWhCanhOOVda?=
 =?utf-8?B?Z2ZyVllxVGd2T0tPMUVtN2xYY0xDOFhYZEpLK0VyTHp6K1VmUGNUWTlVall5?=
 =?utf-8?B?Ly95ZVQvdU5SWUVzVUpxQTI5OVpCRjNYeEVOL2hkUll3djVIaTNTWTF5K2NV?=
 =?utf-8?B?cTlPZGJKWTdoK2dyMGQ0V09TMGwxL2JIL3lYQTNrdEluYUYzTlZpK0E0Ti9p?=
 =?utf-8?B?QXJkNThDR1hPa1c4V2F1NTVoMS9LMXh5NFloOHZEN1IxZ29yTlEwdlRhRlR1?=
 =?utf-8?B?Q0IvaXdKeThDNnR0c2JlS3ZkVTNvby9wb0ZQRG56WjdSbVlqNTg4M1NZNUg0?=
 =?utf-8?B?bjg0WXlRU2l2N0tadTJzS2hrNjdlcExENUxaZ3BmUjBOYytpUDhmaU1PK3ls?=
 =?utf-8?B?L1kyRDFyU0xrZHVCdjJFcmdERU81M3NWZWduKzB3cXRES1A2ME9BZThsN2ln?=
 =?utf-8?B?bjhjMmNSZENJd1RXaUJlaVlza1M2dzB6QmxZVk9DM3daY3ptYVlDUERUWjdU?=
 =?utf-8?B?RVZMSTRIRWx3QjdoYXpSNStqT3VFb1VRaDZnV1JtcnEvYm0xU3ZyOGNxK3I5?=
 =?utf-8?B?bzk4ajZUZ0RESXNlL1BGa0d5R0VMM2tQcDZzYkhYaWNHeThnbEMycC9CYnJI?=
 =?utf-8?B?TFN1Ykt4SmNSOUh4QmFLWHRzSmZ0enlPcFZJajV3cks5UUxLalBTM1p6UU9x?=
 =?utf-8?B?MHpxcTNqdkRCVWkwUlU2bFBPeEZDRngzaThIeDdVU2c1K2VISGVscUxqaVhU?=
 =?utf-8?B?bDE4VUNTdEdVaW4zSjhPOFlpTnZ3aEhnSm1BK1dJeVRVN2ZZQ3ZXdUhLeWJi?=
 =?utf-8?B?dHR2ajNaRmpxai9CUUFtL2pNTk9tN21VNkRDSXpRZk9mZzNIZU5jTVJOdkpl?=
 =?utf-8?B?Ym92Y3NuSHU0Sm9YL1FIbDNSTzNRMDdnOUg4dVVNU0E3SVFaZWduMlhHdVJn?=
 =?utf-8?B?blFVcGNaV3JHZVp2VWhJdlBCaXZBSW56RExyT2ZqQXNhNTNKV29TWWgrZm92?=
 =?utf-8?B?Wm9YOWs0YnBhbVRDaHZqeUkrVWQrZjhWM3dhRFN3eEpJdXkraGdrMzNyTWFs?=
 =?utf-8?B?SzJkZVdTblBKdC9CWlAxS0tpVi9WNkNWcGh2alNpUURMLzlrL1I0MXVla05q?=
 =?utf-8?B?WWkwNm0yT1AvV0U2bWRETlZSRmpQQUphV09TZlJoUlhrc0hhUzg5ZUN1dlhO?=
 =?utf-8?B?UCt2c3hscXRNM2pxeVpyOFYxNW5lRm1wemJiTnVVN25TYVZiOGo2ZzBzU0d6?=
 =?utf-8?B?NmtOWitKMXNmNHJBdU5vTEppdEZPY3U2T2hyZC9HNkNOdXVHRG4xRDVEVHVp?=
 =?utf-8?B?cG1mWG1Oa0VmS3pDY2pJSFNPcWplcSs1OWcyOEhiUmtDWnovdHVVbWFYeExi?=
 =?utf-8?B?aHVselFyU3Y2ODJJVmk4Y0xPVGhkdHluanBpajhaZEsyWjZYcVF0Qy8xSU1S?=
 =?utf-8?Q?D/Gh8Pi+Kxm7CreaiKuv2eE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15285bb2-b86a-418b-9781-08dbdfcb5e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 19:54:36.0889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R7c+pI8ScOM8D/FpIxv7mKRYuhbop+srwZgTr+XrTfH+XNNDnlgOeE8jHV4l/YU4CMz99wHEU6cFYMohI0uCuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4712
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-3.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uZGF5LCBOb3ZlbWJlciA2LCAyMDIzIDExOjIxIFBNLCBIYW5uZXMgUmVpbmVja2UgPGhh
cmVAc3VzZS5kZT4gd3JvdGU6DQo+ID4gVGhhbmtzIGZvciB0aGUgcmV2aWV3IGNvbW1lbnRzLCBI
YW5uZXMuIEknbGwgbWFrZSBzdWl0YWJsZSBjaGFuZ2VzIGluIHYzLg0KPiA+IFBsZWFzZSBhZHZp
c2Ugd2hldGhlciBJJ2xsIG5lZWQgdG8gc3VwZXJzZWRlIHYyIHdpdGggYSAiZ2l0IHNlbmQtZW1h
aWwNCj4gPiAtLWluLXJlcGx5LXRvIiBzbyB0aGF0IHlvdXIgIlJldmlld2VkLWJ5IiB0YWcgZm9y
IG90aGVyIHBhdGNoZXMgZ2V0cyBwcmVzZXJ2ZWQuDQo+ID4gSSdtIG5vdCBleGFjdGx5IHN1cmUg
aG93IHRoZSBwcm9jZXNzIHdvcmtzLiBUaGUgZ29hbCBpcyB0byByZWR1Y2UgdGhlIG51bWJlciBv
ZiByZS1yZXZpZXdzIG9mIHBhdGNoZXMsIGlmIHBvc3NpYmxlLg0KPiA+IEFueSBwb2ludGVycyB3
aXRoIHJlc3BlY3QgdG8gdGhpcyB3aWxsIGhlbHAuDQo+ID4NCj4gUGxlYXNlIGFkZCB0aGUgJ1Jl
dmlld2VkLWJ5JyB0YWdzIGZvciB0aGUgbmV4dCBzdWJtaXNzaW9uOyB0aGF0IHdpbGwgaW5kaWNh
dGVkIHRvIHJldmlld2VycyB3aGljaCBvZiB0aGVzZSBwYXRjaGVzIGFscmVhZHkgaGF2ZSBiZWVu
IHJldmlld2VkIGFuZCB3aGljaCBuZWVkIGZ1cnRoZXIgYXR0ZW50aW9uLg0KPiBIaW50OiB0aGVy
ZSBpcyB0aGUgJ2I0JyB0b29sLCB3aGljaCB3aWxsIHNjcmFwZSB0aGUgcGF0Y2hlcyBmcm9tIHRo
ZSBtYWlsaW5nIGxpc3QgX2FuZF8gYWRkIHRoZSAnUmV2aWV3ZWQtYnknIHRhZ3MuIE1heWJlIGdp
dmUgaXQgYSBnby4NCj4NClRoYW5rcyBmb3IgdGhpcyBzdWdnZXN0aW9uLg0KSSdtIHVzaW5nIHRo
aXMgdG9vbCBhbmQgcHJlcGFyaW5nIHBhdGNoZXMgZm9yIHYzLg0KDQpSZWdhcmRzLA0KS2FyYW4N
Cg==
