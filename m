Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46396797DCA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjIGVLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjIGVL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:11:29 -0400
X-Greylist: delayed 81 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 14:10:31 PDT
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C32B1BEE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1351; q=dns/txt; s=iport;
  t=1694121031; x=1695330631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zOOVATlQrFW9yxg3sQ/Eo7rDoAHI9hOSCzSNatURcDY=;
  b=goKZILrxQFHdDxvp1yBZW/5u/gNBUqHAtQVEmJUv82hS3gkQG2wKfdwE
   xRSF/NtqaXsAuT2ct69Qvdh1x8xTpUUjnDklVqF/MaEo67yMZnkdgkhbo
   wi/e2xvRUB6YDIhEcScLZCNQ584ExeXs8FJdEM2RIeI0JmxB1DaGd5oMk
   A=;
X-CSE-ConnectionGUID: ++v693QbRJeFXcbQmARLdg==
X-CSE-MsgGUID: BxVZsVfZRLWoOwcNk4dpTQ==
X-IPAS-Result: =?us-ascii?q?A0AiAADgOvpkmIwNJK1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBZFJ1AlkqEkeIHQOETl+GQYImnXsUgREDVg8BAQENAQE5CwQBA?=
 =?us-ascii?q?YUGAoZxAiU0CQ4BAgICAQEBAQMCAwEBAQEBAQECAQEFAQEBAgEHBBQBAQEBA?=
 =?us-ascii?q?QEBAR4ZBQ4QJ4VoDYYEAQEBAQIBEigGAQE3AQQHBAIBCBEEAQEfEDIdCAIED?=
 =?us-ascii?q?gUIGoJcAYI7IwMBEJ1kAYFAAoooeIE0gQGCCQEBBgQFsmwDBoFHAYgHAYU4h?=
 =?us-ascii?q?E0nG4INgViCaD6CYgKBKwESASOEEoIuiVCFQgcygiqDXYk3KoEICF6Baj0CD?=
 =?us-ascii?q?VULC12BFYJHAgIRORNHcRsDBwOBAhArBwQvGwcGCRctJQZRBC0kCRMSPgSBa?=
 =?us-ascii?q?YFTCoEGPxEOEYJEKzY2GUuCYwkVDDVOdhArBBQYgRUEagUaFR42ERIZDQMId?=
 =?us-ascii?q?h0CESM8AwUDBDYKFQ0LIQUUQwNIBkwLAwIcBQMDBIE2BQ8fAhAaBg4tAwMaQ?=
 =?us-ascii?q?ANEHUADC209NRQbBQRmWQWgDnCEE4EYMx1Klh+uWwqEC4wAlTsXhAGMbphwL?=
 =?us-ascii?q?odBkD6NYZU+hH0CBAIEBQIOAQEGgWM6a3BwFYJuAQEBMVIZD44gGYNfhRSKZ?=
 =?us-ascii?q?XYCOQIHCwEBAwmLSAEB?=
IronPort-PHdr: A9a23:gFBhxB2KpkAyZvTHsmDPZ1BlVkEcU/3cNwoR7N8gk71RN/nl9JX5N
 0uZ7vJo3xfFXoTevupNkPGe87vhVmoJ/YubvTgcfYZNWR4IhYRenwEpDMOfT0yuBPXrdCc9W
 s9FUQwt5Gm1ZHBcA922fFjOuju35D8WFA/4MF92L/7pG4rbjOy81vu5/NvYZAAbzDa4aKl5e
 Q2/th6Z9tFDmJZrMK831hrPrzNEev8Dw2RuKBPbk0P359y7+9ho9CE4hg==
IronPort-Data: A9a23:keLal6tftWyt3zp4Qr9R+BiA0ufnVJ9eMUV32f8akzHdYApBsoF/q
 tZmKW2HOKqDMGr1LtkgPd+1oE9SupKHz4NnQQtq+Ck1RXtEgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0rrav656yAkiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuHYjdJ5xYuajhPs/Pb90s01BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 44vG5ngows1Vz90Yj+Uuu6Tnn8iG9Y+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0HgkmVZCq9oMrLlD88tLNnhb/eUHOztteB0sPOKQi3up4VDQmG
 fwwcFjhbziKg+awhbm8UOQp2YIoLdLgO8UUvXQIITPxVKl9B8udBfyRo4YEhF/chegWdRraT
 8kQcyZuaB3DSxZOIVwQTpk5mY9Eg1GmLmQA+QnO/fNfD2775hxP4qPTPujvXuONYtpeuEXEq
 nr6xjGsav0dHIXPlWXamp62vcfLnCXmSMcRGae++/pCnlKe3CoQBQcQWF/9puO24ma6WtRCO
 wkP8TEvhbY9+VbtTdTnWRC85nmesXYht8F4Guk+7kSGzbDZplnfDWkfRTkHY9sj3CMredA0/
 hzKgY24XgVlip+YZ0KW/I6RhAmWNSdAeAfuehQ4ZQcC5tDipqQ6gRTOUstvHcaJYjvdRG6YL
 9ei8XZWulkDsSIY//7gpQGd01pAsrCMH1BruliLNo6wxl4hDLNJcbBE/rQyARxoBYKdQ1/pU
 JMsxJXGtLpm4X1gaEWwrAglFbWt4bOONyfRxAEpFJg6/DPr8HmmFWyx3N2cDBo4WirnUWa2C
 KM2he+3zMMLVJdNRfMvC79d8+xwkcDd+S3ND5g4lOZmbJlrbxOg9ypzf0OW1G2FuBFywP1mY
 M7HKpbwVCxy5UFbINyeGb11PVgDmHhW+I8vbcyTI+mPiODHPyfFFd/pznPXMLhnhE97nOkl2
 48Pa5TVo/mueOb/eSLQuZUCNkwHKGNTOHwFg5I/SwJ3GSI/QDtJI6aImdsJItU594wLzb2g1
 i/mBSdlJK/X2CevxfOiMC4zMdsCnP9X8BoGAMDbFQvwiiF9O973ts/ytfIfJNEayQCq9tYtJ
 9EtcMSbCfMJQTPCkwnxp7GkxGC+XHxHXT6zAhc=
IronPort-HdrOrdr: A9a23:TtSt06mwDYFL9p3pFPzkervGBd3pDfNpiWdD5ihNYBxZY6Wkfp
 +V7ZcmPE7P6Ar5BktApTnZAtjwfZq9z/JICYl4B8baYOCUghrZEGgE1/qt/9SAIVywygc579
 YDT0EQMqyMMbEXt7ec3OD8Kadf/DDlytHouQ699QYQcegCUcgJhGkJb3f+LqQ1fng4OXNTLu
 vl2iMznUvbRZ1hVLXBOpBqZZmkm/T70LjdTVotARkh5AOSjTWuxoLbPnGjtCs2Yndk+5tn1X
 LKvTDYy8yY3s1TzCWy60bjq7Bt3PfxwNpKA8KBzuIPLC/3twqubIN9H5WfoTEcuoiUmRUXue
 iJhy1lE9V46nvXcG3wiwDqwRPc3DEn7GKn4UOEgEHkvdfySFsBeoh8bMNiA17kAngbzZZBOZ
 FwriSkXl1sfEr9dRHGlpz1vtdR5xKJSDQZ4LUuZjdkIPgjgfdq3P4iFQVuYdc99OaQ0vF7LA
 GoZ/usvsp+YBeUaWvUsXJox8HpVnMvHg2eSkxHocCN1SNK9UoJhXfw6fZv1kvozqhNAKVs9q
 DBKOBlhbtORsgZYeZ0A/oAW9K+DijITQjXOGyfLFz7HOVfUki956Lf8fEw/qWnaZYIxJw9lN
 DIV05Zr3c7fwbrBdeV1JNG/xjRSCG2XCjryMtZ+59l04eMCYbDIGmGUhQjgsGgq/IQDonSXO
 uyIotfB7v5IW7nCe9yrkTDsllpWA8jueEuy6EGsgi107f2w6XRx5jmTMo=
X-Talos-CUID: 9a23:AQNdBGEuOV/l3lMMqmIkt1BKS5sceEf/wVngKEWBDE9TbLGaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AGIBAuQ8GN+06wZEX6qlSOcyQf+143Za1Nk4/q7E?=
 =?us-ascii?q?5vO6bPgpzZzuFsA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by alln-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 21:09:09 +0000
Received: from alln-opgw-5.cisco.com (alln-opgw-5.cisco.com [173.37.147.253])
        by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 387L99uO024127
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Sep 2023 21:09:09 GMT
X-CSE-ConnectionGUID: RhwdWuQtRciqHK/kzLJNsA==
X-CSE-MsgGUID: 9Fs/VvMkRxGpDZxYZsTRRg==
Authentication-Results: alln-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.02,236,1688428800"; 
   d="scan'208";a="608990"
Received: from mail-sn1nam02lp2048.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.48])
  by alln-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 21:09:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2FObFy8jsiHk/qTnxAtLh/QtbETm9ChzEeyb53htsMqXkcGszJsv01NN6N9OsGSXVDD481lfRaQwviPqA3vPXBtWVHr4dxDxuBCaYLsB99vTHe7/ldFZtQGMdTBXO7XTQEaQNM9FO5W1ty7pR1F4K5pdUWnrryvy7dJsFXJhU3EOCLQcr855H5HaO0ccCsyd2FGTHMffhhLlwyhAYKLhrMupnN92Wl70oq1dwyCThRkh9sKvNRx1XD97nf73tOWNKxQnE+562/UjFysMkTjyozEtVkl3ITvyiF/55tvKNA7B2JgtXLWMiQV/JoP4vy/m0m6qbn8QjhDBK1lVLkyVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9aQRXNkF41IrObM6uWwCy9sGgoiQHnyE5TQ+rrQkUk=;
 b=EkZs5Y5QCaiMMbz0UcD3tco6hcg7cjuaPLovkAJKyKGSQyjR93+cU4CbEeC/B1AB8ZA0jUytNQcyg2NwkIk3o+YSz0b4Fg9joVI3bjcDWzk+kmQp3Yc+vgfk+VootHZZoUiEcL77m3pPhdp/PiE3HfRsgdjcleUIlzkpHwbWfHYMcNkezGE1Tv7nIX55qRqap9J/GyV9x2cdJ7/79xPyQrixUbFhq3rx8mQ7vx39lEp9BmFkUGj+YRYyn4hHrqX6j6438F8T65CD1jjmWKM+XdjSq5UKC91maCiosJ2tg2s9zvI5C7djT8alwZQE4Sv7pilJD7IGb39gz2/aKO+tYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9aQRXNkF41IrObM6uWwCy9sGgoiQHnyE5TQ+rrQkUk=;
 b=NnmwJ4PBiSXdQsTpMclOeA8R7xWidP7WCFCo7N2zQdQ28nZ2TZ4SUDnKEiNx0RHIeduQr5v2/CfqEN3YPWJs1LXNdjhxrIbtIVB4vI9mE/FJaW9yHKYTETNhHNRTfmKUgHBA0ZmTmevo3Pb50Os/WrcJnijlRLz12u+9tHQabjg=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 21:09:08 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::4877:8f0b:4cfc:d4f8]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::4877:8f0b:4cfc:d4f8%3]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 21:09:07 +0000
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
Subject: RE: [PATCH] scsi: fnic: Replace sgreset tag with max_tag_id
Thread-Topic: [PATCH] scsi: fnic: Replace sgreset tag with max_tag_id
Thread-Index: AQHZ0TfGBvu03c46X0eIQ87x36OFma/7kDlrgAUSZBCAAwuPaIAMTfTg
Date:   Thu, 7 Sep 2023 21:09:07 +0000
Message-ID: <SJ0PR11MB5896D892D85652FDB73915D3C3EEA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20230817182146.229059-1-kartilak@cisco.com>
        <yq1msyezuvm.fsf@ca-mkp.ca.oracle.com>
        <SJ0PR11MB589673606EA6527A478990B8C3E7A@SJ0PR11MB5896.namprd11.prod.outlook.com>
 <yq1h6oguia0.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1h6oguia0.fsf@ca-mkp.ca.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|PH0PR11MB4855:EE_
x-ms-office365-filtering-correlation-id: ada4e4e4-d9d4-49e4-5df2-08dbafe6acb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uLd71wPoANJSkQzGdCBMf90aMLx8kNe91160Bedn9RbRTJ3W72uG798nePBIfr68fety58DFEjkREqS4qfOw4Fekx4XPbLwhxKxev0IEG6dVodVhFyqfrNpCn8K0Fy51qJickJ7jiLCfVlw8cLxo+JhUfwYfR957QuRb83HYppeaL0TgaT/rnvzdPG8w9wNK6hhOd0pPlPmF6PdgMq/KlXvXi3zwAkkKYaiVPTm/Vovp4unXxnemtml1LargawKUc2j4Arrz0HWI+BajZmuFPg3jPAV+2Rvd3UkO8RPxqJ2qWJxMJOcTUINEBS7/DirwsmTw8DgT89I4UJQv0AYHGh0Au75V9Fi12SGNoBM0RlZ6ThvBgpOigdGzhdv+kbam21iG1sFBVAv7X1/03s63x4RLLMBxnmNJONQkuBnVKKoean/R3cw74UbHl7+JVzbUtpnnokbf+XEX3znZypaL/8Hjv4T80UsEf/XJsXlqED8DnpZ5Q+a4NHAqW2o2ZiZPc0Y+q9TYnhFHcjw7ZjmgrdOV20ftkUYA4rsW0gJLjob6t1oYJiK10/189y2E7T5zuhP0qGDGof2GJMlzjWKXeDJQGZ2cxZF8qA/KkNoOg24=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199024)(186009)(1800799009)(966005)(478600001)(71200400001)(9686003)(7696005)(6506007)(316002)(6916009)(8936002)(8676002)(4326008)(5660300002)(41300700001)(2906002)(83380400001)(52536014)(66446008)(122000001)(38070700005)(33656002)(76116006)(66946007)(66476007)(53546011)(64756008)(86362001)(66556008)(38100700002)(54906003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5fiQLr4uyGwzfblVuALXFaaqdtcfNArajfUrkrjQf2/jywCaK8HaXVq3FJqP?=
 =?us-ascii?Q?U+ynJIseKc0ZyO0Jm5r+s8qJtHrSQ73sD7tQylxZf1p2oBGPOekoeM0ftESG?=
 =?us-ascii?Q?urKON9rEI13Jj/lLQFTp3X0YpkNAAoh/wSjQvOmNf9vVddCiZGm2a4qWN2wj?=
 =?us-ascii?Q?/6Hn+ITTFUWfbr1PKEIVEPnlXdUcPqm7tg+U1AZT0OsUr63jsZk2f+6O1m+J?=
 =?us-ascii?Q?SbcvtQGwKMZ4m1yM8qWve4reZuvATW81DPRsIQBk8hAsLsgZC5h/3ZcW+XEC?=
 =?us-ascii?Q?u9WeAwY6JhELawt60oR5dI1XkBywfLf8gQ7F6Z0Kx0hz0M2NgNtZQDhMpr3y?=
 =?us-ascii?Q?Qq7VPDjrYzEpp/6oNOwBf2ACyJycm7VHLQZV8CMH5i9qXtUYEtZWLAtNW8hD?=
 =?us-ascii?Q?ML5Lb9qWmto5tihJTYdc4VsMD+QUznpzKdwnlpFYT+hFz9CzE17kw9F6HvfS?=
 =?us-ascii?Q?GQOf2aXHdNsYvK70numb7arSzIi6OJEbvG1lumn9xtiU0m6KXh9ovcYU1h/T?=
 =?us-ascii?Q?8KlM0aooFdCo7aIySwDJu2cKON8x6lrj09O5dTHwAt9R43JmekA1hSYhYnuc?=
 =?us-ascii?Q?dg9nLGOzx16/aT/M9UQ0k5iYSXWYdHxHDc0zRp4E0C05rq3fp1MH5KlBi05i?=
 =?us-ascii?Q?8f++DlWB1XvYRFcCHpwm9v/4r3AAY/I+F5uvPTSHG6T91JD2r/AuXYXATB1F?=
 =?us-ascii?Q?MSVGrQ2u+UUes8EYy6RQD13dAiBrOhqqH+RrKmX4pIa/Kg0m5tqFICdT3S1T?=
 =?us-ascii?Q?gFkr9035slZ823JjR8/XoOhlgLHDJD+LrMJWCu12c5c1iSHzIo25hu3eMou9?=
 =?us-ascii?Q?L5bQuR/BPd3rx35vF0k3qKNoHMRZAW5VvK2njGBME0g1eFJC4W0Fv8Fu5/iV?=
 =?us-ascii?Q?36/n/LlorTU3z/dutURlC9aUVjN3Sz36bEPUertoVIuQmg92dxx4mIT49Guu?=
 =?us-ascii?Q?pleGDLjA/YusbB/tfIEJRnyHJmMYqbFTCXeGM4jb6nxa3cOOvsE4I01/0D3I?=
 =?us-ascii?Q?IMIhoejoinLufQQvgykrUeAd7eoXpVIPck7matInfU7sfnXPBGUof07q3oZp?=
 =?us-ascii?Q?Ndth/6juGBY6t6vGCgVsKCJeYlPuvB6qCStO3LS7H91fdwVFK+tFzyI+DOCP?=
 =?us-ascii?Q?b04xoPYEMkjorz06pdKXZkMLZlvIFIxP8SgfDI7DATVOKRKnbg1RabkHfoc0?=
 =?us-ascii?Q?ffdon8mCSjdv1OgrWMLRw65ufTE+56NjoxqBri6AJm1XiPfl8NqV3nIGlFRX?=
 =?us-ascii?Q?nUQ4wB5FFB0GFkcJ7XQ31m2Ez6cqEHtaChM8BxBb7KkhEhnDqjQ8kQITf73v?=
 =?us-ascii?Q?BjoUMxBs2DTMJ3vw3KblEOAqM5XQVaJYwDgZ814XtrXh73fMGMan8mXPw77v?=
 =?us-ascii?Q?N/YS1OtKoao2z6gcX0eTfZzCb13ExuNk/X8ILWldGcUlpE4XNF7g1eh3kL3c?=
 =?us-ascii?Q?bVBasWwTmaP4zk0ik46nt2Z+B7/IpJ0os21K14BJiDeQfn1RhRpLfe9jODge?=
 =?us-ascii?Q?CbENbw9CidrwpD3/XRRxvop4C4UWBnjBgH8LmOYDbRb7gjbjj2H/hFq3c1AR?=
 =?us-ascii?Q?mh3E7DbvZSoo716r7a+3XQpb/4j0oJKLnTVjnW7xeHYwOilr1NydcW3O8K3h?=
 =?us-ascii?Q?iv+nNn1oQM8LCWRVD+gEKRPKH2P6jrL7cmvlmO3Ma1M7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada4e4e4-d9d4-49e4-5df2-08dbafe6acb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 21:09:07.7691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O33zUx25Hrbd7DNFHhA2gz6Y8hAbaq14Mc2OoxK6wOjB2KO1biyuuDpYHBDU0qrrGPRAdsQxm2vU5r4wlT1Aag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4855
X-Outbound-SMTP-Client: 173.37.147.253, alln-opgw-5.cisco.com
X-Outbound-Node: alln-core-7.cisco.com
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

Hi Martin,

Would I receive an email when the patch has been applied to Linus' tree?

I just checked out master branch from this repo: https://git.kernel.org/pub=
/scm/linux/kernel/git/torvalds/linux.git/
The fix has not been applied there yet. Am I looking in the right place?

>> You can request a stable backport once the commit is in Linus' tree.

Can you please let me know the procedure to request for this?

Thanks,
Karan

-----Original Message-----
From: Martin K. Petersen <martin.petersen@oracle.com>=20
Sent: Wednesday, August 30, 2023 6:13 PM
To: Karan Tilak Kumar (kartilak) <kartilak@cisco.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>; Sesidhar Baddela (seba=
ddel) <sebaddel@cisco.com>; Arulprabhu Ponnusamy (arulponn) <arulponn@cisco=
.com>; Dhanraj Jhawar (djhawar) <djhawar@cisco.com>; Gian Carlo Boffa (gcbo=
ffa) <gcboffa@cisco.com>; Masa Kai (mkai2) <mkai2@cisco.com>; Satish Kharat=
 (satishkh) <satishkh@cisco.com>; jejb@linux.ibm.com; linux-scsi@vger.kerne=
l.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: fnic: Replace sgreset tag with max_tag_id


Karan,

> Do I need to send out a patch request to apply this patch to=20
> 6.5/scsi-fixes?

You can request a stable backport once the commit is in Linus' tree.

--=20
Martin K. Petersen	Oracle Linux Engineering
