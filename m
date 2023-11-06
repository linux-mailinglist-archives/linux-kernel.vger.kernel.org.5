Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299E47E2D33
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjKFTtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjKFTtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:49:51 -0500
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212B595;
        Mon,  6 Nov 2023 11:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1614; q=dns/txt; s=iport;
  t=1699300189; x=1700509789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bj3KMIKN1jT5G/2tvcdK+fsQC4HQ25NiIKNZO1Tyjac=;
  b=Yt5gzfA6mLRr6Zl0beWIurZMv47xkvKzPU7eUdsVzRzLW3PgR1zy74d7
   6n4f56hA1HqwG/aTQm4v3HVpKbD93lYKB+Fn9MogzWnIcGfWYL6OAZL6n
   67EaIDPmEGM9r9g/t9fTOORlCPo8UTVAeMvJeezzkB4B6mPa22OVbXSDH
   k=;
X-CSE-ConnectionGUID: t3MX5rLPQDWmL3l2y6tsqw==
X-CSE-MsgGUID: LMTPM1+aRwWAbISXg27JKg==
X-IPAS-Result: =?us-ascii?q?A0AnAAAdQkllmJJdJa1QCh0BAQEBCQESAQUFAUAlgRYIA?=
 =?us-ascii?q?QsBgWZSeFs8SIRSg0wDhE5fiGIDnX6BJQNWDwEBAQ0BAUQEAQGFBgIWhxACJ?=
 =?us-ascii?q?jQJDgECAgIBAQEBAwIDAQEBAQEBAQIBAQUBAQECAQcEFAEBAQEBAQEBHhkFD?=
 =?us-ascii?q?hAnhWgNCIZEAQEBAQMSEREMAQE3AQ8CAQgOCgICJgICAjAVEAIEAQ0FCBqCX?=
 =?us-ascii?q?IJfAwGgWgGBQAKKKHqBMoEBggkBAQYEBbJsCYEaLgGICQGBUIg2JxuCDYFXg?=
 =?us-ascii?q?mg+gmECgTMvFYNEOYIviS4HMoIigyspjQsJd0dwGwMHA4EAECsHBDAbBwYJF?=
 =?us-ascii?q?C0jBlEEKCQJExI+BIFjgVEKgQI/Dw4Rgj8iAgc2NhlIglgJFQw1SnYQKgQUF?=
 =?us-ascii?q?4ERBGoFGBUeNxESFw0DCHYdAhEjPAMFAwQzChINCyEFFEMDQgZJCwMCGgUDA?=
 =?us-ascii?q?wSBNgUNHgIQGgYNJwMDE00CEBQDOwMDBgMLMQMwVUQMUANsHzYJPA8MHwIbH?=
 =?us-ascii?q?g0nKAI1QwMRBRICGAMcA0QdQAMLbT01FBsFBDspWQWhGAGBDxuBFYEOAZZHS?=
 =?us-ascii?q?a0FgS4KhAyhPxeqAJg+IKgIAgQCBAUCDgEBBoFjOoFbcBWDIlIZD44gGYNfj?=
 =?us-ascii?q?3l2OwIHCwEBAwmLSgEB?=
IronPort-PHdr: A9a23:XwgkxROUN6nIr8xIHqcl6nfLWUAX0o4cdiYP4ZYhzrVWfbvmpdLpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgrDmgKUYAIM/lfBXJp2GqqzsbGxHxLw1wc+f8AJLTi820/+uz4JbUJQ5PgWn1bbZ7N
 h7jtQzKrYFWmd57N68rwx3Vo31FM+hX3jZuIlSe3l7ws8yx55VktS9Xvpoc
IronPort-Data: A9a23:1/ZCg66TMXLE3iuq2Ke5DgxRtAbHchMFZxGqfqrLsTDasY5as4F+v
 modUGuCafiMYzf1fYhzbt7ioE5UsJ+AnNFnTgFu+303Zn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyKa/lH1dOG58RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wq+KUzBHf/g2QvaztMtfrYwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoZWk
 M6akdlVVkuAl/scIovNfoTTKyXmcZaOVeS6sUe6boD56vR0SoPe5Y5gXBYUQR8/ZzxkBLmdw
 v0V3XC7YV9B0qEhBI3xXjEAexySM5Gq95fbel2P7Na393TqTH7ImPE0HR8qJpQHr7Mf7WFmr
 ZT0KRgXZRyFwumx2r/+E7EqjcU4J86tN4Qa0p1i5WiGVrB9HtaSGOOTuYEwMDQY3qiiGd7db
 tAFaD5mbzzLYgZEPREcD5dWcOKA3yKmKWMI8gPMzUYxy0z28DRUifvkCsXqU9arfvVaxBm6h
 W2TqgwVBTlDZIDAllJp6EmEgu7JgDO+W48IErC83uBljUfVxWEJDhASE1yhrpGRjk+4RsIaM
 EcP+wIwoqUosk+mVN/wW1u/unHsg/IHc8BbH+t/4waXx++Nu0CSB3MPSXhKb9lOWNIKqSICy
 gSsr47zIQRWnIKQbSmZrKbKsSirJn1ARYMdXhMsQQwA6tjlhYg8iBPTU9pueJJZaPWoR1kcJ
 BjX/EADa6UvYd0jjPrkoAiW6964jt2YEV5vv1S/sneNt1shPOaYi5qUBU83BMuswa6DRVWH+
 XMDgcXbtbhIBpCWnyvLS+IIdF1I2xpnGGOF6bKMN8B8n9hIx5JFVdwLiN2ZDBw4WvvogRezP
 CfuVfp5vfe/xkeCY65teJ6WAM8316XmHtmNfqmKP4sUM8UtKFfXoXkGiausM4bFzhBEfUYXZ
 8/zTCpQJSpy5VlPlWDvHL5NjdfHOAhknTqNLXwE8/hX+ePOOCHKIVv0GFCPdes+pLiVuxnY9
 s03Cid540s3bQEKWQGOqdR7BQlTdRATXMmqw+QJLbTrClQ9Rwkc5wr5nOlJl3pNxfoFz48lP
 xiVBydl9bYIrSacdl3TOiE8N+mHsFQWhStTABHA9G2AghALSY2u96wYMZAweNEaGCZLlJaYk
 9Ftlx28P8ly
IronPort-HdrOrdr: A9a23:SKW93agT9PkExJqneuA38yKZOXBQX5923DAbv31ZSRFFG/FwyP
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
X-Talos-CUID: =?us-ascii?q?9a23=3A9OMtlWoUxksTZTjvL9+ro5rmUdx+V02A1lPoGmO?=
 =?us-ascii?q?HDEIyTOeEF0OL4bwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AwNmszA4HT5x3POGwFqeEAWc7xoxMxpiWLRlOmK8?=
 =?us-ascii?q?ZhOCOFBdANG3Crhe4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-10.cisco.com ([173.37.93.146])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 19:49:48 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
        by rcdn-core-10.cisco.com (8.15.2/8.15.2) with ESMTPS id 3A6Jnmat005474
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 19:49:48 GMT
X-CSE-ConnectionGUID: sdcxLf/cR1qMoMHYUEPqTg==
X-CSE-MsgGUID: xUsl4SDqR3SpK4vKhHkECA==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,282,1694736000"; 
   d="scan'208";a="7211404"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 19:49:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzJoiVPMO3vVKEhx+1S3P89F4jJjPpfXIpnNM2f14uoB4Mjjz6RAvysMS6oecOPvea8+x+ymhLZ/mqb21iT2NqEJ+SgR/uKhF365fPIDWF6ZVPtoYq2JT/O4rgdNAxNyaV21vfKwE70M3INcqFIR+ygnZ+9aKDJ5eyQE8wAL6cdYf5NCe0XiUlDIp3/1owYmaS+YyyeWXd3G+fhSXmzuSZuRhDT2TjZiBfKkPveaiPVj4X8FediszNzvDwLr2v9oNgf/G+c8boK4JfU4PYJZCxAh2HqSpOxxBlrkri0Wa5mdBYW8iwB/KH3PVOIOwQM4lrLU+dRE5WE0Uhvn5XyF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bj3KMIKN1jT5G/2tvcdK+fsQC4HQ25NiIKNZO1Tyjac=;
 b=Hy+RW9hRhCNjVsIWNpYG/saROSH3qJ76xypehdxVQRJ1kvfJGwtkYYqCxXjvCNquOc0adLpGoBhh1Z6WBIPhX1U/YBbWEy1hhqOf3Is5vwcFB2OMcTSGkjXqqi+StK56OgiMfhVJ8xpvvmspet0OaoPx09gliwuPsTF72fMvM/GUTLhrurFnxkYeQ2MvH5cjBDiIPhchoPTXkfC6IdoGsGivqfawvprnPLUgdEpDbE8wcZr9alxZUmDgObesU5oqFgfYCal2zUdrnU6YgyQXdylv5tKR+uzIlWMGSt0V5K8oRTSVdu2JLlPuS7UU4VT1HzEsxvkVE119AxZMZY/N9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj3KMIKN1jT5G/2tvcdK+fsQC4HQ25NiIKNZO1Tyjac=;
 b=BuT6OOaNMEwvC63xn5Nr1V3+vSd+kOUd3O/BS9VTsWQrxM2JRYE7MduWRYobhlqaUNSZ8t6VT2x1ak26Gu86EYza71Uh1yULZhxe+s3m4I6lIGQ4a8Xku2FD4zyHJfNnm+hsA1XyOuxalLcO8KPOEnW5nT2S2vgDAobPI1acoVs=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by PH0PR11MB4966.namprd11.prod.outlook.com (2603:10b6:510:42::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 19:49:46 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 19:49:45 +0000
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
Subject: RE: [PATCH v2 02/13] scsi: fnic: Add and use fnic number
Thread-Topic: [PATCH v2 02/13] scsi: fnic: Add and use fnic number
Thread-Index: AQHaCP/nsp9rHRuPP0iHM4UOntO7/LBmqZ4AgAcYoTA=
Date:   Mon, 6 Nov 2023 19:49:45 +0000
Message-ID: <SJ0PR11MB5896D3DE4476F2C1A31D1428C3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-3-kartilak@cisco.com>
 <7526d690-1deb-4611-92ef-a3707ebd60a5@suse.de>
In-Reply-To: <7526d690-1deb-4611-92ef-a3707ebd60a5@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|PH0PR11MB4966:EE_
x-ms-office365-filtering-correlation-id: 1599a7bc-7f5f-4817-e0a3-08dbdf01872c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A3Th9eFK6dMpRSOQX/5gJvdCPFNwMLfzmkqAX6V/QLBwWJwG9P+cmhSKiD3pg9RICelmhB4quHZf3CV4zLGelifqHnrzGf4+p7BXzHwjP8O+d+4FZT0AiF5ejdFXaRWyqnuXwyUTI3cvjyy1YThGRMYj2YWxh4CpbqPYWw1LB1KObBFNa036M57z3Wz7HFT3sUNCZJ3dma8RnCeoiWxTRU8cW2aI3/2fd9a50QiEtY/B00rqOv5niEnfkuaH6I/4+B7j0BFKUnT8x4nRSCDofcbE41WCjZu7Lgh9z9Pj66YA+bzUYf8p/SQzdpLw1jEZxfJV+ZnnA78ggAKWEP5fprSWwITVIw6W5kqM3sAwic6LAYUy5WTF+5aU+TIKG/Di5G6oHO3N3Yo7GxuMcWe4DFv9mi83gjuibO71IhCyA5zOg8VLwuWztVk3chiC/Pac00+bdk7r7tJMD0CMkN1RiX8mkiHf0uTAoBQmZCFHgvmN9xDubrohNATHWzq5ZZ9lCSGjKkG85yThHd0pl02LCSQznC8T3Y9MCYc6dF9idouVAVyZliuezL6sKOGGkgT+idauG7XLL37WJFsyrQnwb4vO+AdtWJdxIqmgA4pOhIy3K9D5h8+QbjNiO3zadC+x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(9686003)(122000001)(52536014)(76116006)(66946007)(478600001)(66446008)(66556008)(64756008)(66476007)(54906003)(6636002)(110136005)(316002)(38070700009)(7696005)(53546011)(6506007)(71200400001)(8936002)(8676002)(4326008)(2906002)(55016003)(38100700002)(41300700001)(33656002)(5660300002)(83380400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzkrYVhjbUJUQmFUTzFieExyUFowUUxqUCtucE1POUtXV2FzZk1XWERMVUc0?=
 =?utf-8?B?eG5BdW9DZVdqbHB2ZXlocndvQlhxTDVoakNoek5XdkFrMzNIbmtZNFJCWFFj?=
 =?utf-8?B?ME9NU2ZlNUxQZG5sR0NUZ09lVmthMFFVMXlpdm14RFIrZ1lJK2xXNzloYVVZ?=
 =?utf-8?B?aWJ1bDUvbXNoaGhrTXp0Z3MxaTJWSlFlQUxSZ0NlSUhrMndZdUNPYjJpUVpS?=
 =?utf-8?B?emJPQXc2OEZSMVhJYVdYWHNiTjdJTTBFcVVvZG9QY3Q5Y2NMVGlGL3V0VTE2?=
 =?utf-8?B?MjdhaDFOazRuQTVLbFhwTjU5WERuc3FEaEdRaWtxaFJaejZIRTg5WUZ6R3Bw?=
 =?utf-8?B?VlVUVFBpNUpybXJyMlMrRmc5RW90Yy9JN0taM3QwTHBybXZyeTU2NnlzcVZX?=
 =?utf-8?B?eVh2alV6alVGV0VTOUhOakoyYXpBaUdGVUtpcVB3TXFtd1ZSNGo5bUVyVmpl?=
 =?utf-8?B?T01VbGpWeDd4cnNxdXdDcFBVOThrYk15N2FubERLZ1Vla253emNla3pLN0Y2?=
 =?utf-8?B?Q1hsZ2ZsaGVDaGJFVmJmUU9VbnMzOG9iUHhkZU41bG1pdFdLK0hNbk9WY3Ns?=
 =?utf-8?B?UzRmQ0k1NllydHVUU0h0aVNxNTRPVUlCVDBoTi9UZVNuRW1CMFV4MVNjcGV2?=
 =?utf-8?B?T1dFbGhIbGJzYTVxa1FELy90RERCb3ZlM2xISGFvKzZoY1NpcCt4Sld2aHZQ?=
 =?utf-8?B?MTRtbVFSSjY1Nm5idTVmc1BXNEl3Vlh3Sm13aWpONHh0L1pCNzloN09uVVFx?=
 =?utf-8?B?ZUI4b0d6K0FNS2syMTRwdUNaMUNxcVF6aEFJK25mb3hRbTN6OXJWWDhmcGIx?=
 =?utf-8?B?NkxlKzBaanBGVjg5a0sxQ0hDVjNJNnU2b01lVG5oby8rMDVKZVRKUVJubElk?=
 =?utf-8?B?WEI0dThuczd2REt4LzlOMUtjdENVTE1zay9UYTlySFIzQUlNaCtnMFlKTHJ3?=
 =?utf-8?B?d0JISUlpdkVReWk0S1V6UUtET3NnWmRVaGNDVE5BRWQ0NVI1c1BwL0poNTRF?=
 =?utf-8?B?TlNpaVBXb2F0cy84QTVzek9CSk56Q20xbldVRDE4TWd6N1hVMjg1L3EweUh5?=
 =?utf-8?B?dnJwSCtxOGJmRGhBVXE0TDJlcUp5ZTd4ZVhLalFnTy8rWU9VYmZoSU82Q0xz?=
 =?utf-8?B?OHdPanRiVW8yUklmajh4NDgxamU0SCs4dXZMZHJmSjZ5dThmM3BuT28zbFJj?=
 =?utf-8?B?VUF0ZGFUSlNKOFF1T1UxVm14V1RMbmc5SWwxRDhJMG94QTNNVnZHMVJrQ0Yx?=
 =?utf-8?B?emFKVW9Yb1MrUE16MkwxUllZUlZqQW9zSUgwVE9hWEF4Q0FtK0hJYjh0MCt4?=
 =?utf-8?B?V3JUci92TzRDZVVGZFlSTDRGaTBpRmV5ekxtNW9rbGhLWXpBS09qMGJzN0ZE?=
 =?utf-8?B?Zlhnd0k1SXJhaDJBQ0pDOGtIMXZJV1F3UUlWRk1hZnF2SGc2Z1NObUV5VEZQ?=
 =?utf-8?B?SGpOTURpWmMzNW13SHExQkc2WmZlQkFMcjA3T25RSGdDU3F5SC9sMjI4S3ZE?=
 =?utf-8?B?bFBXdmxYY3luQmJIZTYvcHVEN0lURXIxWjdmRTRpR0lkQzd0Z1hmdzdWV2g0?=
 =?utf-8?B?ejRGSTIrZWJMSmh4YmJxU2FxWEFKVFlKazNsYkFVL2FpTDFiUjVyVmhkWU5j?=
 =?utf-8?B?cVdPWStyNzZQUkJVeWkxdXlyVW1uNUR3UE1Ya2R2ZUpJdit1em5jN3EveEJn?=
 =?utf-8?B?K2ZXd2N4eFlYN1lTcEhXd0hBZkMrd0plSjhQYlo3eW82eDFsVFkzQUFJNC9N?=
 =?utf-8?B?MXY5ZC9kVithRFlQU053WmRhN3JQSWwzbU0xQ1Q0UGV3alZJeFNtdVpqT0V5?=
 =?utf-8?B?cGtxRzZUQVRhd3o0dXRYSkRQRlRMQ0lzVGhCRWdOVzhVVldFSzBPaFZsRWFP?=
 =?utf-8?B?NkhERlpzQUI2L3FGTDVDU09uSmh0K05EVldlWWFud2JuamM4ZUl1KzRQQkpx?=
 =?utf-8?B?K3UwZTdNM2Y2dzNSU2tjM1ZkWXBmd3JVcW42dkVFREhBT2k0U1VhUE9UZ1J0?=
 =?utf-8?B?L2ZsbCtSblMvWmF5RzRIMnRjVW1MalhWZndIcmhqYzJwbERLdkFFUWRNeld0?=
 =?utf-8?B?Sk92TmdMdFkwZWNCNTdpL1lTMWxqR0RhQkVQVWZKNVhJRjA4THZLdHl2ZUZp?=
 =?utf-8?B?VFVBK3FraUJSSVN0WVF3dHVKM3hKaEk5LzBZR25HMFAyMDdwNVdYVTlZNXVO?=
 =?utf-8?Q?34V4ewP+aoDwd8rqn+aEYMc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1599a7bc-7f5f-4817-e0a3-08dbdf01872c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 19:49:45.8323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLDSNLPcO7O4ch8Kifew8nOaI9CPyz2hUO0lUyU0Qpr/4yjvv8srjZ+HuBL8WK6s8LFhpKk/zumz0yNBaP9O3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4966
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: rcdn-core-10.cisco.com
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

T24gVGh1cnNkYXksIE5vdmVtYmVyIDIsIDIwMjMgMTI6MjYgQU0sIEhhbm5lcyBSZWluZWNrZSA8
aGFyZUBzdXNlLmRlPiB3cm90ZToNCj4NCj4gT24gMTAvMjcvMjMgMjA6MDIsIEthcmFuIFRpbGFr
IEt1bWFyIHdyb3RlOg0KPiA+IEFkZCBmbmljX251bSBpbiBmbmljLmggdG8gaWRlbnRpZnkgZm5p
YyBpbiBhIG11bHRpLWZuaWMgZW52aXJvbm1lbnQuDQo+ID4gSW5jcmVtZW50IGFuZCBzZXQgdGhl
IGZuaWMgbnVtYmVyIGR1cmluZyBkcml2ZXIgbG9hZCBpbiBmbmljX3Byb2JlLg0KPiA+IFJlcGxh
Y2UgdGhlIGhvc3QgbnVtYmVyIHdpdGggZm5pYyBudW1iZXIgaW4gZGVidWdmcy4NCj4gPg0KPiA+
IFJldmlld2VkLWJ5OiBTZXNpZGhhciBCYWRkZWxhIDxzZWJhZGRlbEBjaXNjby5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IEFydWxwcmFiaHUgUG9ubnVzYW15IDxhcnVscG9ubkBjaXNjby5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogS2FyYW4gVGlsYWsgS3VtYXIgPGthcnRpbGFrQGNpc2NvLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvc2NzaS9mbmljL2ZuaWMuaCAgICAgICAgIHwgMSArDQo+
ID4gICBkcml2ZXJzL3Njc2kvZm5pYy9mbmljX2RlYnVnZnMuYyB8IDIgKy0NCj4gPiAgIGRyaXZl
cnMvc2NzaS9mbmljL2ZuaWNfbWFpbi5jICAgIHwgNiArKysrKy0NCj4gPiAgIDMgZmlsZXMgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+IFdoeT8gVGhlIHNj
c2kgaG9zdCBudW1iZXIgZ2l2ZXMgeW91IGEgcGVyZmVjdGx5IGdvb2QgZW51bWVyYXRpb24uDQo+
IEFuZCByZWFsbHkgYWxsIHlvdSBkbyBpcyByZXBsYWNpbmcgdGhlIHNjc2kgaG9zdCBudW1iZXIg
d2l0aCBhbiBpbnRlcm5hbCBudW1iZXIsIHdpdGggbm8gY2hhbmdlIGluIGZ1bmN0aW9uYWxpdHku
DQo+DQo+IFdoeT8NCj4NCj4gQ2hlZXJzLA0KPg0KPiBIYW5uZXMNCg0KVGhhbmtzIGZvciB5b3Vy
IHJldmlldyBjb21tZW50cywgSGFubmVzLiANClRoZSBzY3NpIGhvc3QgbnVtYmVycyBhcmUgbm90
IGNvbnRpZ3VvdXMuIEhhdmluZyBjb250aWd1b3VzIG51bWJlcnMgbWFrZXMgaXQgZWFzaWVyIHRv
IGRlYnVnLiANCkFsc28sIG1hcHBpbmcgdG8gVklDIGhhcmR3YXJlIGluc3RhbmNlcyBtYWtlcyBp
dCBlYXNpZXIgdG8gZGVidWcuDQoNClJlZ2FyZHMsDQpLYXJhbg0K
