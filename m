Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8F37E2DC8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjKFULh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjKFUL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:11:26 -0500
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45324D78;
        Mon,  6 Nov 2023 12:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=456; q=dns/txt; s=iport;
  t=1699301482; x=1700511082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1ld+apERrGUt0dBa+qHXRBJleRbpESNanwWGQ1hn674=;
  b=FR033xxPscCkLmrgrTpEh+cTI6qfZgB4SHavJe4kflJV0I9A1Tef3msf
   Eq+Bv9hFFXA8e+yAmJuYp/8jeNenAxUKmFeiik2gItNLcl2IqZtnFUxpx
   UXI9gPAj4t367VDt18rzCw3jr3xMXRplvNsYfOqVgVS0J/vxOHCtJimig
   g=;
X-CSE-ConnectionGUID: 47CkL7bvRtKhEcQGgP7IyA==
X-CSE-MsgGUID: oyzoN+YoRr2RN/E/iRCDUg==
X-IPAS-Result: =?us-ascii?q?A0AnAADxR0llmJFdJa1aHQEBAQEJARIBBQUBQCWBFggBC?=
 =?us-ascii?q?wGBZlJ4WzxIhFKDTAOETl+IZZ1+gSUDVg8BAQENAQFEBAEBhQYCFocQAiY0C?=
 =?us-ascii?q?Q4BAgICAQEBAQMCAwEBAQEBAQECAQEFAQEBAgEHBBQBAQEBAQEBAR4ZBRAOJ?=
 =?us-ascii?q?4VoDQiGRAEBAQEDEhERDAEBNwEPAgEIDgoCAiYCAgIwFRACBAENBQgaglyCX?=
 =?us-ascii?q?wMBoHIBgUACiih6gTKBAYIJAQEGBAWybAmBGi4BiAkBgVCINicbgg2BV4JoP?=
 =?us-ascii?q?oJhAoFig1k5gi+JLgcygiKDVI0NCXdHcBsDBwOBABArBwQwGwcGCRQtIwZRB?=
 =?us-ascii?q?C0kCRMSPgSBY4FRCoECPw8OEYI/IgIHNjYZSIJYCRUMNUp2ECoEFBeBEQRqB?=
 =?us-ascii?q?RgVHjcREhcNAwh2HQIRIzwDBQMEMwoSDQshBRRDA0IGSQsDAhoFAwMEgTYFD?=
 =?us-ascii?q?R4CEBoGDScDAxNNAhAUAzsDAwYDCzEDMFVEDFADbB82CTwLBAwfAhseDScoA?=
 =?us-ascii?q?jVDAxEFEgIYAyADRB1AAwttPTUUGwUEOylZBaFPmWRJi0+iZAqEDKE/F4NuA?=
 =?us-ascii?q?RKMc5kMmD4gqAgCBAIEBQIOAQEGgWM6gVtwFYMiUhkPjiAZg1+PeXY7AgcLA?=
 =?us-ascii?q?QEDCYtKAQE?=
IronPort-PHdr: A9a23:5dLtGxVyMz1fpmEbfb69L7xKfVvV8K0yAWYlg6HPw5pUeailupP6M
 1Oav7NmjUTCWsPQ7PcXw+bVsqW1QWUb+t7Bq3ENdpVQSgUIwdsbhQ0uAcOJSAX7IffmYjZ8H
 ZFqX15+9Hb9Ok9QS47lf1OHmnSp9nYJHwnncw98J+D7AInX2se+zfyz/5TQSw5JnzG6J7h1K
 Ub+oQDYrMJDmYJ5Me5x0k7Qv3JScuJKxGVlbV6ShEP64cG9vdZvpi9RoPkmscVHVM3H
IronPort-Data: A9a23:N59YdqgQLtgSdWuCizgOmbOvX161XRAKZh0ujC45NGQN5FlHY01je
 htvCGnQOvyLZ2OjedlyPY7n9h8B7Z+AydFrQFdurXphECxjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+1H1dOCn9CEgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZWEULOZ82QsaDlNsvrd8EgHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 woU5Ojklo9x105F5uKNyt4XQGVTKlLhFVTmZk5tZkSXqkMqShrefUoMHKF0hU9/011llj3qo
 TlHncTYpQwBZsUglAmBOvVVO3kWAEFIxFPICSTgms+3kEfYSWfPw9hlNW45BdI5688iVAmi9
 dRAQNwMRgqIi+Tzy7WhR6w9wM8iN8LseogYvxmMzxmAUq1gGs+FEv6MvIMFtNszrpgm8fL2Z
 MMDdTtrZRfoaBxUMVBRA5U79AutriCkKmcI8Q7J9cLb5UDU3R529vvcN+DPIOasAugSn3yzi
 l/JqjGR7hYybYzDlmXtHmiXruvOmz7rHYEfDru18tZ0j1CJgG8eEhsbUR28u/bRokq/Xc9Pb
 lcf4SsGs6c/7gqoQ8P7Uhn+p2SL1iPwQPJKGOE8rQqK0KeRskCSB3MPSXhKb9lOWNIKqSICi
 gCinPe2DyJVrJ6VZHmk2bis8hKjEH1ARYMdXhMsQQwA6tjlhYg8iBPTU9pueJJZaPWoR1kcJ
 BjX/EADa6UvYd0jjPrkoAiW6964jt2YEV5vv1S/sneNt1shPOaYi5qUBU83BMuswa6DRVWH+
 XMDgcXbvaYFDIqGk2qGR+Bl8FCVCxStbmG0bb1HRsRJG9GRF5iLIdk4DNZWfxcBDyr8UWW1C
 HI/QCsIjHOpAFOkbLVsf6W6ANkwwK7rGLzND66FP4AfP8QtLF/apEmCgHJ8OUizyCDAdolhY
 f+mnTqEUR729Iw+lmPtHrdBuVPV7npmnD27qW/HI+SPiOrCOyH9pUYtO1qVZedx97KfvAjQ6
 L5i2ziilX1ivBnFSnCPq+Y7dAlSRVBiXMCeg5IMLIarfFE5cFzN/teMm9vNjaQ/wfQM/goJl
 1ngMnJlJK3X3iaYcVzaOy88MtsCn/9X9BoGAMDlBn7xs1ALaoe056BZfJwyFYTLPsQ6pRKoZ
 5Hpo/m9P8k=
IronPort-HdrOrdr: A9a23:/hpogKwxoFYKz6SbBxqfKrPxaegkLtp133Aq2lEZdPULSL36qy
 n+ppQmPEHP6Qr5AEtQ6OxoWJPtfZvdnaQFmLX5To3SLDUO31HYYr2KjLGSjAEIfheOlNK1up
 0QDpSWZOeAamSSyPyKnjVQcOxQgeVvkprY+ds2pk0FJWoFGsQQizuRSDzrbXGeLzM2fabRYa
 DsnPav0ADQAkj/AP7LYEUtbqzonfGOvpTgZhINGh4g7yezrR7A0tTHOind9C0zFxdUz5kf0U
 WtqWHED6OY3M2T+1v57Sv+/p5WkNzuxp9oH8qXkPUYLT3ql0KBeJlhc6fqhkF3nMifrHIR1P
 XcqRYpOMp+r1nLeHuunBfr0w78lB4z9n7Zz0OCi3eLm726eNt6MbsFuWtqSGqf16MShqA77E
 uN5RPBi3NjN2KFoM063amRa/glrDvunZNoq59hs5UWa/ptVFYWl/1ewKuQe61wQR4TL+scYb
 NTJdCZ6/BMfVyAaXfF+mFp3dy3R3w2WgyLW04Yp6WuonJrdV1CvgMlLfYk7zw93YN4T4MB6/
 XPM6xumr0LRsgKbbhlDONERcesEGTCTR/FLWrXeD3cZe06EmOIr4Sy7KQ+5emsdpBNxJwumI
 7ZWFcdsWIpYUrhBcCHwZUO+BHQR2e2Wyjr16hlltVEk6y5QKCuPTyISVgoncflq/IDAtfDU/
 L2I55SC++LFxqmJW+I5XyJZ3B/EwhobCROgKdPZ7unmLO+FrHX
X-Talos-CUID: 9a23:3HmzOW0nMN+rIrMjiI40NrxfRp8OcVmCxmnqP2y4JG1QZ7KtFn6B0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3Aay+Kqg1gCbbWYq11j7XHvMKv2DUj5LW8D2ZOoJI?=
 =?us-ascii?q?8oZO+E2tdfDanpxiKTdpy?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 20:11:21 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 3A6KBKaQ020603
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 20:11:21 GMT
X-CSE-ConnectionGUID: Fhvn7u9ESF+Hfn0Qn2ex/Q==
X-CSE-MsgGUID: r6AMRWOMQOSzSvZC9ooNBQ==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,282,1694736000"; 
   d="scan'208";a="7213553"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 20:11:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oc13Tt+zVTt1eQRQxet8GhVJsRcoY4/b9Pj/0AmatfagSg2C2IBUc7ZsuhFwTqhMJxaRNVG5W72yG9z8yROSNod9sEpVrRY+0hW1ZjpH7NIsq2ZK0hBUHo3y44LxbNrrExhoBwoCCQ5FYSPDGZQ+uOQWMvfm3EKHPe7hkJso4Jcue9KAgvmo9GcnJwK7Ae/Ca+rrKw8sWp+EPgzf1zRG4V/TaJXS2p5MMhYRqAKC0OULAQf3k1vkgUPg1fCPPsaxEOFiW30362f9SRUDnnREKDAMED3ouidy2MhQKU8VMXzu28wAtq+CntdwYxVqAT/lflRhrknxe83LE88prXjAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ld+apERrGUt0dBa+qHXRBJleRbpESNanwWGQ1hn674=;
 b=cmwlHH0JXyktoLvM1lCtyLp8wDaadJ5q6iVtzxzTEoIL01rSCvx5BrBAfOY7Znl2tBMl/DZ6oUc2nj/sZRCOcMQYOdSi10GnDoEQpm3D6wCJeGH841RVDtGp5FGwZ8HInHcPQ2f7tVnvZA/ZSN8z3EcC4bpO4oBIAgX6+Nf3dD9Tov+Uo9B7jFmUmJzJ/wxej2a1hYufkF7OOtQPt+aUloxD5f80yFAqpQEZ1XXOOlTJdbWljYahBhSIqV63v0TkKtPRex7zRIr8R636gVdAiAYUgG3pLX7En6iY9z/EL8miJbvcj36f1GyOzcDl6QMyO3JffQKQqD9dq3kjf/jxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ld+apERrGUt0dBa+qHXRBJleRbpESNanwWGQ1hn674=;
 b=Mqm8N05Rpg+FxC//b5nXmW8fd8b89HhdQlvubnTq04A7wP1NGia/RCHLIwuYS+8cpfDqY5RIUvfnJ4Ivjssskmc34Aur/f2SWG0/rT5AyrvXaVUDclRli31tp6yWc1oj4zgIiVGiehN6FmHuAWMCPzmRJK0xZB+xVF0EaGxMUSI=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by LV3PR11MB8765.namprd11.prod.outlook.com (2603:10b6:408:21d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 20:11:19 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 20:11:19 +0000
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
Subject: RE: [PATCH v2 06/13] scsi: fnic: Refactor and redefine fnic.h for
 multiqueue
Thread-Topic: [PATCH v2 06/13] scsi: fnic: Refactor and redefine fnic.h for
 multiqueue
Thread-Index: AQHaCP/qeWYvrdpM4UWkRrEIoWbt9bBmrLMAgAcbpvA=
Date:   Mon, 6 Nov 2023 20:11:19 +0000
Message-ID: <SJ0PR11MB58960720A1AC4D5C3C7A4CF2C3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-7-kartilak@cisco.com>
 <f0e1431c-cfb3-4245-be79-a9f98d4b57fe@suse.de>
In-Reply-To: <f0e1431c-cfb3-4245-be79-a9f98d4b57fe@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|LV3PR11MB8765:EE_
x-ms-office365-filtering-correlation-id: fd2711b7-3c69-42b8-1e25-08dbdf0489f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QVwnyXI+3yuftdai9QUkKPTIeifRfE+2UMhlPixKnprM5eKCH/ku+Edmto6pfYNQ3PrRoCqBJmGOrjIkdw/GERYLK+WspKc4dWRuoNt49CrHOWjtDHMhbS1JOsW6r+b7UGn3nBP6HFO8ZeM6LB+6F0u9PwKSiIlVTIVdO6AanVBtsnhQNFMR4tiX3wofxRHhhDdAU+7jQrRbNTX1oOXT9TbsRPBTuKctaRlxxk9ik99ASah3yDThXAwHJ+gMFfObU9m6n/2c4OvZBq2xNne1lJV0ouiZEUImJo9BOFHXdyyKciAwyERpOiGtxKGKl2L6lLAWmBqudGU+0yeA6pKLxLwA0KiN03IsG7WmViJ/H8d6zejvg0B9Q0xXQzITK3zTh2QBd30q2Tez0kxsId4C2nzeFHDvhjc4eXALsqJx7xLKJyuYriPz7MmIcz3q80TeESC7oyhiK4SIASY/VV9TWhncHM1umqMevAEJ1d+81qOEXuunITi5m3vZyPzDSFbVLFcru4PdET9+gswtYkB4BGq+uUZnMUaHnP1AbHwFNj1WbYMB9xm6E2ZaJ2gjtPrN3vtz8do3BBAaYyP1TSxebfDL4mZIORuJEtf7N+MjRSe3VJjyGBDD0yj8gFyqWM5Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(122000001)(9686003)(38070700009)(478600001)(52536014)(8936002)(8676002)(4326008)(5660300002)(86362001)(41300700001)(2906002)(66556008)(4744005)(33656002)(66946007)(66476007)(54906003)(64756008)(66446008)(76116006)(316002)(6636002)(110136005)(6506007)(53546011)(7696005)(71200400001)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3krSzhXbmFETENVOVBXTTVlb3Zsd3F4b3IyV3p4RUlFUStJNno3RnR0RXdG?=
 =?utf-8?B?S3FsZ1ZmdDBTcmdnSXVlVTk1b3VkT0ZKOFVsQzFqNEtZaFA3bEsycko3YWta?=
 =?utf-8?B?cU12eTJWNjROQm43V2pMcGNKazBIUlhHVDl1SG1pMUh3b1ROQnE5R1lOQkhW?=
 =?utf-8?B?bnBGaFgyQ1V6WVcydjZrdTlDbGJYUEFickN1L0YwM3lXeW14QlVaakVlNUFI?=
 =?utf-8?B?enVTV3JQaUFTY05GOERMNkpIZXVxdERNNnRqOUpqeTdSeGF5Wk82MERkaWkr?=
 =?utf-8?B?eHQ2aldHY2JCamJoQk96MFJPZm1OUE1tT1FKdTlhQkRISGFYVXFrVThXZXVI?=
 =?utf-8?B?ZFNwc2t1OSt3V1BIMWZSSldZVlVFek5XLzgrSVQ4MmcyZkV4S2V4UGNHdS9C?=
 =?utf-8?B?RGtPMWhydThtQUNRbjR2S2JOSVptN0pKMllUQ0VZVGlmd0xHVHBoVDhPUHdw?=
 =?utf-8?B?V3I5dk1SUFY5TkIrT2dxMG9zbXplS1ZKdjlWdEN3SWpiN3ppbTEzSjg4ZnVl?=
 =?utf-8?B?NGJLM1dFUzZpaU9JR3EyQmpBUGpRUWdMMW9NSWJ3MGlqRHV5MG9MdUpIK01K?=
 =?utf-8?B?b3RtbTMxbWFZSWFqeW96UW1Uc3BoUG51bWltWHhWTG9oR3YvQkkrTUFBdzFY?=
 =?utf-8?B?VHhpd0pSemMrdzhmMGZPQ2lDVERyU3NhVjEzZ1VHMnh0a0tFdi8xR3dGeHVJ?=
 =?utf-8?B?NG1kT29CbkRiM1dydzUxaUVWQVF1c2RuWkgyQm5VclBGTE84TkR6S2FaclVG?=
 =?utf-8?B?Ujl3ZWNRZWtvUkJpeHR3aXRENEtGakZaVTdWaWk3N1MrK2dTU0VXZkdsWVB6?=
 =?utf-8?B?bWhJR01zL1QwNWtJVitrNTR4bHBKblZYd2M5UUsveUgvZ1gvVlFEU3A5cDJr?=
 =?utf-8?B?S3pFYkZjZE1KL1YwalJ1d0NkYStxTUJEZm04MUZtZHF0QVlhVjNjN09peFpY?=
 =?utf-8?B?ZnN6dUFFVkNqdXphMkVuWFFMNlZLeHJuRmxhSDZYdTJTMHgySnVyYlUyd0VN?=
 =?utf-8?B?N3hMSWVFeTlQRlhSeEVZWS9LbW1mQ0xkUktQUVZuY3JtQmhzWisxZmkzUnZo?=
 =?utf-8?B?ZU5kUU1NYkVISHV2bnBJVHRPM0RsRGJxNWJISzdFNDBPOUJUeUhORXNsSU9z?=
 =?utf-8?B?eGFLVGllcFFiT3lCZEtHTENENk9rbFlyd0U2eUphR25mNThVZEY0K3krcTZz?=
 =?utf-8?B?N3BBSTVFeWNLd2h3SG92Skk0c20ycG5qVzVTR2k0SFJTbUIwOFhmbjh0UVdL?=
 =?utf-8?B?S3NyZGYyWVdXSCtrSEkzZW5WSkl2SkpsbHFiYWF6NTJvUXRaTWlEQXlOcHdw?=
 =?utf-8?B?TVVkZURPZUYrM2VIVzJza09kdGdJcHBtRkxqVGw5WVlQTUdRTmxvSithUlRq?=
 =?utf-8?B?T2g1S3czdUw5M1ZhNE1WQTBwS2R4TWdqR1BSS1JxZ3pxNE1id2ZyQklLRjBO?=
 =?utf-8?B?Z05WY2EzS1lINUZjNFBHNTlqUEJ3K0VNeG5NSm5OZ1VINFVlUW55S09JZUNR?=
 =?utf-8?B?cmZLeHBHVmMzclhIZ296N0lkd2twUlBvZmkybjB4RitvNmp0aEtzSEJyKzVU?=
 =?utf-8?B?SUZ1UHlWY1FnczQ0QVNXY1IrUFpVY2RNWTFjc1Y3Z1RXNzFmSHhjcjdjaE1B?=
 =?utf-8?B?b1FMSkNWc2tJaGl5ditiYUpKOHE0L1B1WTVibmZHTmt4YmxxdjdJNGdSUzhy?=
 =?utf-8?B?SkVuck1tajhUUktCdXQ2QlFtWm12SUc3M2Zkd24zVXJFTVV5L0hGYjI5bS9s?=
 =?utf-8?B?R1pHaWY4a0IwVGhDbU5CTkR3aStiallYbGJEM1FnYXgvMEVxZ3ZUanJ6aXhE?=
 =?utf-8?B?R1JycUxIWmVmV293cmt3TVZ1YjBaOEJTVkR6bytSZmRqREYwZlVHSUhrMVZN?=
 =?utf-8?B?TTdtbUR0aWVlbzg1R1k5VXM5MWo1T1U0bUE3Z0lab3RrSlF3TU0vS0xicU1D?=
 =?utf-8?B?TGZPdktuQWJrVWFjNWMzTVFqRUZwSkZBUkNDZ3piR08rNFdveTBHZFZPb05J?=
 =?utf-8?B?d3hjRm5HNFpyazVVSVN1NjN5c3BMZFRTRTgyUnpWNEhtR002aW1jMFgrVlZa?=
 =?utf-8?B?SHg0TGNVaWVJQm5yWFBWb3g4RjY4NSsvRHZ6RFNzZ1k5T0JJamgvL3p0ZHhI?=
 =?utf-8?B?NTg4K3RSVW1SVzQzS2QySWs5L2lMMitSSHR6WnA5UW5wcktjb21weDlvbzF0?=
 =?utf-8?Q?NW0EQm962MvkGmK6UMg4gIQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2711b7-3c69-42b8-1e25-08dbdf0489f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 20:11:19.0357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aO/I8zTPcr1raj86WZnge7tPlTPf6DFmXq4QPxXvTO4BuD230HSwKv5BAZ6tc3vdcOEgeH5uMB6sSGMw1LcPhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8765
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: rcdn-core-9.cisco.com
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

T24gVGh1cnNkYXksIE5vdmVtYmVyIDIsIDIwMjMgMTI6MzcgQU0sIEhhbm5lcyBSZWluZWNrZSA8
aGFyZUBzdXNlLmRlPiB3cm90ZToNCj4NCj4gUGxlYXNlIG5hbWUgaXQgJ2NvcHlfd3FfYmFzZSc7
IGFsbCBvdGhlciBpbnN0YW5jZXMgaW4gdGhlIGRyaXZlciBhbHdheXMgbmFtZXMgdGhlIHN0cnVj
dHVyZXMgJ2NvcHknLCBub3QgJ2NweScgdG9vLg0KPiBZb3UgYXJlIG5vdCByZWFsbHkgc2F2aW5n
IGFueXRoaW5nIGJ5IG9taXR0aW5nIGEgc2luZ2xlIGNoYXJhY3Rlci4NCg0KU3VyZSwgSSdsbCBt
YWtlIHN1aXRhYmxlIGNoYW5nZXMgaW4gdjMuDQoNClJlZ2FyZHMsDQpLYXJhbg0K
