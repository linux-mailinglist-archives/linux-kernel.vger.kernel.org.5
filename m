Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD32780318D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjLDLbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDLbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:31:14 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95839A8;
        Mon,  4 Dec 2023 03:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701689479; x=1733225479;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qTX8j1YHohwd594hsiisi2EpYPYDKFhNoapU/QcmBNc=;
  b=nClLXZyYDdgZ6yq8d0kS03oPJRM9KpUCWDE36OOiUhBxJyiTrI8SD0ji
   5s5xQv/9B7Ds/nMP6GYY/VAJ17O1XRh6pCJfVw38eMdPYZuDC7TSUOTg5
   z6Bn6m9h23abKPnWyGvexb/5Wg5AXQ/f7kx/gb6T7n/GBfDbsNkRlouqb
   mJ7LzxkZobo4Xggh/j+uIoLu7q6/ZGCZBZAzVzfvCwtMRtgqnM+Apja0G
   MrB84uZMg5/ylLwLHa5WavDGwGqXlWbwYH7KDE9xFQfRDfNGNILIhA63w
   BjfCtxamXgfgS71YD640/DbLwK2wQ7iLRDdebzKv9ISVgP8IFlPH8Aohx
   g==;
X-CSE-ConnectionGUID: O4rXO/gzTXSVWHBlbmaUYw==
X-CSE-MsgGUID: 7UaNDeicQei+mr3Y9CJ0ZQ==
X-IronPort-AV: E=Sophos;i="6.04,249,1695657600"; 
   d="scan'208";a="3946669"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2023 19:31:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUFHZoCbUB6HEQVh3unPpVymVPz7KKpFWLjzkHlWmyl2dsRuaUI32H+1AreL7h4k1DbMTnEWbzQ2AhzTbidF8jGcVKGP/phBG/mv+CN4iIUO5CYarfNes9wK/Qo0CjWcOCK4BcFRNdjy1fYand+DsGJopOzQ/7uCFjHd7YKKbbUc8cJtaiwWVxA2TTR2msb7QVzKMBcmp77KMw3l6uys8w/xxa5cAq5Kdk4J90Ww3jt83quFOMZcXvcpEIalJnm1p8vu2CArOmLr9FAG374+i9bvikbf7UQ+q2Nxv88RRS1ghmjmXa9FbI6V/uQQIDYJqUBz1V/U34dDBjByaICUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXKgjwm9jOFByJ5e3thnGWO6a7w3VdUPm3E9F0VUsg0=;
 b=S+tbLigm+3+oXpnHmrOH+AQ3GlQ0GKOuuOWUR+wkM+diD+pw7HDxrx7vclcmYl3XKqlmEsf76xHNLF9ejRMimwzXXdbsfq2gSmD4zN2nWWurkmJ2opGQzNECxvARkrosQz8FN7nD9iDC/qUeTYyNmgfLtv3DcZDzjcG3AblHnPvyuGMc3BSk9cFjBSDbSBNgxO74VCAlskDiXkGyXc+H5dcpC8zcPP+skBWiEJPpDuzHp4Tg0lLmJRiRzA6Jqx2UVulSZlJpo+rVraXV3GGhuwo/b1YxtRZbMZnVivb+5vKKJbrU+aQJTYGnRVScltL7YITH+JEtlatvRhmrOth00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXKgjwm9jOFByJ5e3thnGWO6a7w3VdUPm3E9F0VUsg0=;
 b=HJ566OEeKYAAtTW86MEtYOax0TAYQ0ZTeQYCEFEMYE/HbLFfDiHloFEwPgHaMkM82jvGlm/qYgsdXPKv5/82zUhNumABNiQuEUIF+F4ioYElTiqsLeE/+GGxWFvugH2d4cUl8qdPR/fuBemgI1EYlVtmL5GHwL7PpDX4FYyXZQ4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB8357.namprd04.prod.outlook.com (2603:10b6:a03:3d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 11:31:15 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4%6]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 11:31:15 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        "CLoehle@hyperstone.com" <CLoehle@hyperstone.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "hare@suse.de" <hare@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "asuk4.q@gmail.com" <asuk4.q@gmail.com>,
        "yibin.ding@unisoc.com" <yibin.ding@unisoc.com>,
        "victor.shih@genesyslogic.com.tw" <victor.shih@genesyslogic.com.tw>,
        "marex@denx.de" <marex@denx.de>,
        "rafael.beims@toradex.com" <rafael.beims@toradex.com>,
        "robimarko@gmail.com" <robimarko@gmail.com>,
        "ricardo@foundries.io" <ricardo@foundries.io>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv2] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
Thread-Topic: [PATCHv2] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
Thread-Index: AQHaIt3uugCp9rO7UEO94df443a6MrCSq88AgAAvjgCAAGE4AIAAL3CAgAAE5ICAAJy6AIAARKeAgABFQgCAABTwAIABhBXQgAGUvgCAATXMcA==
Date:   Mon, 4 Dec 2023 11:31:15 +0000
Message-ID: <DM6PR04MB6575F9EB1C3309F64EEE6BCCFC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CAPDyKFpg+7W1ODGHw5oXy_wzWA1Qqzg9w_12rhQ8qW4o--6dWg@mail.gmail.com>
 <ZWiNDgUFF8ug7gZf@trax> <fbc82848-d402-4075-8176-de9ed0345d78@intel.com>
 <ZWkGZ7av1S4Clwdv@trax> <ZWkKgU+J9atnJdqT@trax> <ZWmN+k+wUWcXT5ID@trax>
 <fecd033b-b2ea-4906-a320-22a5c2ede46c@intel.com> <ZWoBqs/5m6tCuBGo@trax>
 <ZWoTOm+8Y75TLz6q@trax>
 <DM6PR04MB6575FF9532A9FC0EE91B5B37FC80A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ZWysTPapFyGJdu5d@trax>
In-Reply-To: <ZWysTPapFyGJdu5d@trax>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB8357:EE_
x-ms-office365-filtering-correlation-id: cf06ff2e-c3ff-4e06-efdd-08dbf4bc868b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u0GDlOZsJJM+nY7P93+YOMJGr5KHcosXDNaxn20YEQ3i0t/f47fkUgmadnyzJmpRe7wRbUQunBd60QINacGC1OjZ7jmKm7o3LsZ8Ecl0oaK3b54x836V9Hbegk8TUvW84ooxq25viGPkxUJPGXXEL/GCU2vr1eaGxhiccmYmCKtHHB6FIZHfFD4kX/imYgaWwGtlUL3qQ+Yy+RLpentos97FV8c7+i7cfSgRuQwPbqXJfwz0tpdG9os3RlthT188+UTfo/IQBMbMqEAE6AAF8IpLSIGU+2K3BmiHR34H8dhGMd9uDqQ660BQEopHww9m494mLcqsuqodX5qEf2I2oLcxOtGt9UqR382a36wjyfRZfd5HmLm+L6fSeBKVwqEonkcG7OM5rrVTO3ABNru8lQtpF55vp9Hsh66BlZu4MZ86h5ku+384PGaIELa20n0Vrgqlv0KpccUu6OXgWNxFKCl40pTi7XaSyHUejKJF8vUhq1eCRuccu2zTfJoR0kGw4/hl3MzRY/kSr/fFWQD6sG6/jX9jdfRoDoQKwF/oyfO4DbmNyFgQUmmHbMMoq1OR2DBm6/mMjbATqSnDxHm0XhSVPVPtHxx9ysFwDAsDvK8FJFIMFVddFYWkBZVXAWW338Jc7Am/l7YXMScBX/Jatg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(478600001)(26005)(966005)(83380400001)(7696005)(71200400001)(6506007)(9686003)(53546011)(82960400001)(84970400001)(316002)(6916009)(66476007)(66446008)(64756008)(54906003)(76116006)(66946007)(66556008)(122000001)(38100700002)(55016003)(5660300002)(52536014)(66899024)(4326008)(86362001)(2906002)(8936002)(8676002)(7416002)(41300700001)(33656002)(30864003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pNLgi6D02uyc3QMXtY7VjI+HzwEsZFvY9P12Ej4x5nhD/0F5CCCOkBM6W5ty?=
 =?us-ascii?Q?qJCLmDaGBKQqLlnLNA6Xtuv14G6VbchvepA9GFQGXoGxm3FBDTB4oznLXvWb?=
 =?us-ascii?Q?MSmCiWzNBm3Rx1csMy/sFL2RlO2s5ND1r49AFohtYAqXWk6F7IgImG/FWts1?=
 =?us-ascii?Q?CXIldSWKqcvUsvhWpoOvqDOn07FsIG0QFOdpibesTS0Zd1owYqTU8Cm1c1T2?=
 =?us-ascii?Q?VS3hqInGOlgYJhTkEtMb+KM03xEiK7cWz9ZgeuQxSZJzkB/+LUj1oSV4YYzv?=
 =?us-ascii?Q?ZQ9mMYADlDcOWjImsSMlNBjQ3MjALXsW5/eQk90yI3czqTATn1fDAc7YPOn1?=
 =?us-ascii?Q?NOoZC7ufJbMYF9l4aRh87fLxBZfZ0QHgjG4XlVqwpO63r5y83D8EhK7TOtO1?=
 =?us-ascii?Q?hJj4qsI9gm0HeMn52UWkGnFG2cwHUTohYpzNJQWqdqW398xo9cUBw3Ph7XyR?=
 =?us-ascii?Q?U5W7zbzWnR/jDmPiH01tWOXH77tCizAa8Q7huaaXppU+0US7Dp2imntnJOQu?=
 =?us-ascii?Q?/1PDH0uf42wcZbqR3h6UmK0PPQDzrUvzNNgnNdNxiQjrZL+QDKFLchUwtHsS?=
 =?us-ascii?Q?AaB1ePjOiQtMxsoP8Hwrwzt5aF8s+wKaYRmUeO49MXmA0YjNgC2HSwiqYgtO?=
 =?us-ascii?Q?gl6SXrVCJOT75yBlQFJTBFM4J9UOZ3GLnM+6TxV3EInhecx9Rjh6XMh8CUrZ?=
 =?us-ascii?Q?bZtlIH/mc0+YUuMcFWXcnZ0a/8DFa6QhythDoZankRfamLpBSY6zrHXeJLXu?=
 =?us-ascii?Q?mgNz2rCbDmRpb4wLtJU9KycoPheT/bWySMkatxf1XUTxu65u/6Zm+IEnujnd?=
 =?us-ascii?Q?Oq+aR0vY7usue7/bzCRtdBMeAhLdIu42zwFnmpoAZVX44ePyOa8SqcJKkMq1?=
 =?us-ascii?Q?A9vuM4hTki/f/Mv9PXQSDG/YacAoXXJAQkOONcpCd6HNpJcvi7EYx3g1YngB?=
 =?us-ascii?Q?H234pfTFPTSzrqKXJogWEMOrFaZ/OblfESychzzkI6iI/FlGSO08+eCK2Qte?=
 =?us-ascii?Q?wvd8pFUrhdTOPUP5Q4xz3L83HLaPtJPBsFfCGoxzaWDihyxRJuB4rbYMyWtd?=
 =?us-ascii?Q?RPTY0koy4LJT9/2y7g5oxAo8SBv+IINrjcLGghCk7ZErCm+sw+lyijiHPMpx?=
 =?us-ascii?Q?jjsh0t/pNRaqYToudehtADI0eX/kvktLzwS5i1z9sCTi1hsGsemwVHOQQ0YN?=
 =?us-ascii?Q?jvFUJXBwIYtYEEFzXW0Zx5HsutqPX180QhST/nwiMv5Uf0oaaUH5d+zj8nSH?=
 =?us-ascii?Q?/UWjDoWKKh0jWmAPD9qOOWTusYFLiAlWG7/4wHlVTcFj2rtFc/1dUgBFpemr?=
 =?us-ascii?Q?+YKYjkfCLbIwyYNDzJpINYaQFeHbCdVAD8ITCabecvuWYQvY0byNBYyAgtLK?=
 =?us-ascii?Q?oH1mI47NRzsAZ2Q101cKmMz4dCxcng0hMx80QPLWJ1AiorntFufMISH/oPdJ?=
 =?us-ascii?Q?Q8tjaIWrzFntVVmd9eoB7J/LAJE8A/L/KpRverYLX9duAmZ9h7rBdZNjXnXL?=
 =?us-ascii?Q?8GuJpu3Snr7jislqH/vfWXDi3C8APvF8fN9bYK8jAmwcTzuCc4TnriGuz3qH?=
 =?us-ascii?Q?PhJJ50yiyEGtsJo9nJkImxfM7gKVr+MSMVlK2ek5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CWY++V/Y/11k2x/8qzmUw2x2Xf2FeX5XHH3nEGnj9tU/V0eOV8WhUgwwm0r8?=
 =?us-ascii?Q?TxEqR+BxgPoH/tzRVUODMaMzQEs+yAl24z3lurStkKH43nAz4nF0ptxi4RZZ?=
 =?us-ascii?Q?Qyv+9tfz7j+kmOyTZEHgT2jcJj7fOttYjRUSq0+qntUxWU/fe4VObkK37Yrx?=
 =?us-ascii?Q?wPjFB3m3xlFuGERH6oShLQWTJa2wbAIsERiZEVfQyDJVbimIW/D/sgPiq1x0?=
 =?us-ascii?Q?cYRrgBqo6QeW3AB5iPc6ZXX5GpEw1PZtGZLiyOOgxm7gB1GCowK5zLyaFGTF?=
 =?us-ascii?Q?fLAybZ1TKUCuYxuB/VK8O0k0CSR2vs0opTcS7MMPu3j0+UkOZ5Z0bsDLAzWg?=
 =?us-ascii?Q?LOkbQO5vWTRfTt+lEjEGm77AVJArhj73ByTnn9jmgWzGWiHou3Ay6HcHdqK2?=
 =?us-ascii?Q?QOFeDN9Qou5JmYRfftbixHpvG3MSMr76ccUZ/h7lgjsmKlnU3WNA5sVFB94r?=
 =?us-ascii?Q?qefWyZsnXiu/ahVgn07wwQMeKq1ewftD6SscC3g9+d8hSxSMcy3lDGVYc+pz?=
 =?us-ascii?Q?6KMASrJu6UKuNBGFwUsQ0WR640ll6CFELlAZpq2i3Vhu30LqTSAPaN+70zny?=
 =?us-ascii?Q?YY2y4HTne6PgT8BsJToaRvvISrYHL7xh3Je0A/s91FZSZpX8wSFfPWS0DFag?=
 =?us-ascii?Q?wMb+b5UW8AWZjAmL2s9Gk2Z5zvhgLS98D8mhmtw7RY7bHyiCx99waxxt0gpT?=
 =?us-ascii?Q?ASr+MI2nfQ3fVnDasu+kGiO/ANrXsHHWSGOB6IUylUNuDTOux4ZqomRtUBPk?=
 =?us-ascii?Q?0pq5wnxkqn6eGi+E2NZ45se3cWyEVsAyjb0iQhV+e2uGVREjFkzFdV80mSJQ?=
 =?us-ascii?Q?k1Vlpj4o7l6RQLwaNb3ko1oHTQg5piX2sJ5DTgbOuBABe++DSTJzmxXli90V?=
 =?us-ascii?Q?XjlV9a6eC2CYgpPMnr4DZCh0I0TDNIV399nmkvI/HCcIES0pBt+r/ipcVzYY?=
 =?us-ascii?Q?R1m1+Qil9HdQMQoXSvrpGnHa7ERIiO1MO7FNX59JkJeWTUk8ybLP5VOdV0eL?=
 =?us-ascii?Q?KDSN+If9MOhlVlEGzwk71YOLWw0s4xodzK/dJuf57YWcF/DLGa24sg5y2hGy?=
 =?us-ascii?Q?Uk2BESH0fZg0SRPA1Vz/vqEWWW5boEjY9hPA7rcExBFj3B4dheK3b4rPMxu5?=
 =?us-ascii?Q?EoZD49jaLT07Ad0OOzNMXi8q72L17mwskjHLyT8X0XXfDfKe+uKylOs=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf06ff2e-c3ff-4e06-efdd-08dbf4bc868b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 11:31:15.0931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOJfChJoJ3FRp1zZAqNrOA9/m20PhzXpGQchf8YnqP3rXe5fRbmg0jELf7RifJx89OjrQ3y23oYtfOogqHbTsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8357
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On 02/12/23 16:47:23, Avri Altman wrote:
> > Hi,
> > Sorry for joining so late - This thread was routed to my junk mail some=
how.
> > We were observing this issue recently with one of our clients using a
> Broadcom platform.
> > Similarly like in this case, the tuning process didn't use cmd21, so se=
nding
> only cmd6 is perfectly ok.
> > We couldn't find any issue with the device at the time.
> > During our investigation, it turned out that the client had a kernel
> > hack of its own, and once it was removed the issue wasn't reproducing
> anymore.
>=20
> um, do you know what driver or setting could have be caused the issue?
>=20
> This product is using the Xilinx kernel. 5.15.64
> https://github.com/Xilinx/linux-xlnx
It was a Broadcom platform - BCX972127OTT, using sdhci-brcmstb, with a 5.4 =
kernel.

>=20
> >
> > > > > >>> hi Adrian
> > > > > >>>
> > > > > >>> Sure, this is the output of the trace:
> > > > > >>>
> > > > > >>> [  422.018756] mmc0: sdhci: IRQ status 0x00000020 [
> > > > > >>> 422.018789]
> > > > > >>> mmc0: sdhci: IRQ status 0x00000020 [  422.018817] mmc0: sdhci=
:
> > > > > >>> IRQ status 0x00000020 [  422.018848] mmc0: sdhci: IRQ status
> > > > > >>> 0x00000020 [  422.018875] mmc0: sdhci: IRQ status 0x00000020
> > > > > >>> [ 422.018902] mmc0: sdhci: IRQ status 0x00000020 [
> > > > > >>> 422.018932]
> > > > > >>> mmc0: sdhci: IRQ status 0x00000020 [  422.020013] mmc0: sdhci=
:
> > > > > >>> IRQ status 0x00000001 [  422.020027] mmc0: sdhci: IRQ status
> > > > > >>> 0x00000002 [  422.020034] mmc0: req done (CMD6): 0: 00000800
> > > > > >>> 00000000 00000000 00000000 [  422.020054] mmc0: starting
> > > > > >>> CMD13 arg 00010000 flags 00000195 [  422.020068] mmc0:
> > > > > >>> sdhci: IRQ status 0x00000001 [  422.020076] mmc0: req done
> (CMD13): 0:
> > > > > >>> 00000900 00000000 00000000 00000000 [  422.020092] <mmc0:
> > > > > >>> starting CMD23 arg 00000001 flags 00000015> [  422.020101]
> mmc0:
> > > > > >>> starting CMD25 arg 00000000 flags 00000035
> > > > > >>> [  422.020108] mmc0:     blksz 512 blocks 1 flags 00000100 ts=
ac 400
> ms
> > > nsac 0
> > > > > >>> [  422.020124] mmc0: sdhci: IRQ status 0x00000001 [
> > > > > >>> 422.021671]
> > > > > >>> mmc0: sdhci: IRQ status 0x00000002 [  422.021691] mmc0: req
> > > > > >>> done
> > > > > >>> <CMD23>: 0: 00000000 00000000 00000000 00000000 [
> > > > > >>> 422.021700]
> > > > > >>> mmc0: req done (CMD25): 0: 00000900 00000000 00000000
> > > 00000000
> > > > > >>> [  422.021708] mmc0:     512 bytes transferred: 0
> > > > > >>> [  422.021728] mmc0: starting CMD13 arg 00010000 flags
> > > > > >>> 00000195 [  422.021743] mmc0: sdhci: IRQ status 0x00000001 [
> > > > > >>> 422.021752]
> > > > > >>> mmc0: req done (CMD13): 0: 00000900 00000000 00000000
> > > 00000000 [
> > > > > >>> 422.021771] <mmc0: starting CMD23 arg 00000001 flags
> > > > > >>> 00000015> [ 422.021779] mmc0: starting CMD18 arg 00000000
> flags 00000035
> > > > > >>> [  422.021785] mmc0:     blksz 512 blocks 1 flags 00000200 ts=
ac 100
> ms
> > > nsac 0
> > > > > >>> [  422.021804] mmc0: sdhci: IRQ status 0x00000001 [
> > > > > >>> 422.022566]
> > > > > >>> mmc0: sdhci: IRQ status 0x00208000
> > > > > >>> <---------------------------------- this doesnt seem right [
> > Why not?
> > Its cmd25-cmd25-cmd18 which implies rpmb write?
>=20
> sorry I am referring to the IRQ status  0x00208000 (CRC errors) - not the
> sequence.
>=20
> >
> > > > > >>> 422.022629] mmc0: req done <CMD23>: 0: 00000000 00000000
> > > 00000000 00000000 [  422.022639] mmc0: req done (CMD18): 0:
> 00000900
> > > 00000000 00000000 00000000
> > > > > >>> [  422.022647] mmc0:     0 bytes transferred: -84 < ---------=
------------
> ----
> > > -------- it should have transfered 4096 bytes
> > > > > >>> [  422.022669] sdhci-arasan ff160000.mmc:
> __mmc_blk_ioctl_cmd:
> > > > > >>> data error -84 [  422.029619] mmc0: starting CMD6 arg
> > > > > >>> 03b30001 flags 0000049d [  422.029636] mmc0: sdhci: IRQ
> > > > > >>> status 0x00000001 [  422.029652] mmc0: sdhci: IRQ status
> > > > > >>> 0x00000002 [  422.029660]
> > > > > >>> mmc0: req done (CMD6): 0: 00000800 00000000 00000000
> > > > > >>> 00000000
> > > [
> > > > > >>> 422.029680] mmc0: starting CMD13 arg 00010000 flags 00000195
> > > > > >>> [ 422.029693] mmc0: sdhci: IRQ status 0x00000001 [
> > > > > >>> 422.029702]
> > > > > >>> mmc0: req done (CMD13): 0: 00000900 00000000 00000000
> > > 00000000 [
> > > > > >>> 422.196996] <mmc0: starting CMD23 arg 00000400 flags
> > > > > >>> 00000015> [ 422.197051] mmc0: starting CMD25 arg 058160e0
> flags 000000b5
> > > > > >>> [  422.197079] mmc0:     blksz 512 blocks 1024 flags 00000100=
 tsac
> 400
> > > ms nsac 0
> > > > > >>> [  422.197110] mmc0:     CMD12 arg 00000000 flags 0000049d
> > > > > >>> [  422.199455] mmc0: sdhci: IRQ status 0x00000020 [
> > > > > >>> 422.199526]
> > > > > >>> mmc0: sdhci: IRQ status 0x00000020 [  422.199585] mmc0: sdhci=
:
> > > > > >>> IRQ status 0x00000020 [  422.199641] mmc0: sdhci: IRQ status
> > > > > >>> 0x00000020 [  422.199695] mmc0: sdhci: IRQ status 0x00000020
> > > > > >>> [ 422.199753] mmc0: sdhci: IRQ status 0x00000020 [
> > > > > >>> 422.199811]
> > > > > >>> mmc0: sdhci: IRQ status 0x00000020 [  422.199865] mmc0: sdhci=
:
> > > > > >>> IRQ status 0x00000020 [  422.199919] mmc0: sdhci: IRQ status
> > > > > >>> 0x00000020 [  422.199972] mmc0: sdhci: IRQ status 0x00000020
> > > > > >>> [ 422.200026] mmc0: sdhci: IRQ status 0x00000020
> > > > > >>>
> > > > > >>>
> > > > > >>> does this help?
> > > > > >
> > > > > > Just asking because it doesn't mean much to me other than the
> > > > > > obvious CRC problem.
> > > > > >
> > > > > > Being this issue so easy to trigger - and to fix - indicates a
> > > > > > problem on the card more than on the algorithm (otherwise
> > > > > > faults would be all over the place). But I am not an expert on =
this
> area.
> > > > > >
> > > > > > any additional suggestions welcome.
> > > > >
> > > > > My guess is that sometimes tuning produces a "bad" result.
> > > > > Perhaps the margins are very tight and the difference is only 1
> > > > > tap.  When a "bad" result happens in non-RPMB, a CRC error
> > > > > results in re-tuning and retry, so no errors are seen.  When it
> > > > > happens in RPMB, that is not possible, so the error is obvious.
> > > > > Not re-tuning before RPMB switch helps because the
> > > > > CRC-error->re-tuning to a "good" result has probably already
> happened.
> > > > >
> > > > > However,  based on that theory, it is not necessary the eMMC
> > > > > that is at fault.
> > > > >
> > > > > It may be worth considering a stronger eMMC driver strength setti=
ng.
> > > >
> > > > sure I can tune the value (just building now). however I am not
> > > > sure about the implications - is there any negative consequence of
> > > > increasing this value that I could monitor (if tests pass)?
> > >
> > > ZynqMP does not set the property "fixed-emmc-driver-type" and since
> > > the sdhci-of-arasan driver does not implement
> > > select_drive_strength() the drive_strength setting is zero.
> > >
> > > So AFAICS things are working accordingly - it is hard for me to say
> > > if things should have been coded any differently.
> > >
> > > > >
> > > > > sdhci supports err_stats in debugfs - that may show how many CRC
> > > > > errors there are when not accessing RPMB.
> > > >
> > > > ok
> > > >
> > > > >
> > > > > I don't object to skipping re-tuning before RPMB switch, but I
> > > > > am not sure about tying it to a specific eMMC.
> > > >
> > > > thanks. will follow up after further testing.
> > >
> > > should I just repost the patch now skiping the retune for all cards
> > > before switching to the RPMB partition? instead of using a quirk?
> > >
> > > On this particular card it has now run for a couple of days so I am
> > > confident that it addresses at the very least the symptom of the issu=
e.
> > As aforesaid, we observed a similar issue on a different platform as we=
ll.
> > If it's not realistic to further pursue Adrian's theory, *And* this
> > doesn't reproduce on other cards, we have no objection setting the quir=
k
> for Sandisk.
> > (if you're having trouble testing other cards ping me privately I can h=
elp you
> with that).
>=20
> I have some extra eMMC cards which I used to validate RPMB on the OP-TEE
> port I did for AMD/Xilinx Versal ACAP some time ago and which I maintain
> upstream:
> https://optee.readthedocs.io/en/latest/building/devices/versal.html?highl=
ig
> ht=3Dversal
>=20
> However I cant use them on this hardware - there is not a uSD slot, just =
USB.
> And from what I can see, RPMB doesnt get mapped when the device is
> mounted as a mass storage device (unless there is a way that I dont know?=
).
> Other than that I am not sure what to propose. Suggestions welcome.
Maybe we can help you to replace the soldered device with a socket.
I need my managers to approve this.
Ping me privately if this is a viable option for you.

>=20
> Versal uses the same sdhci-of-arasan driver but with some diffences:
> https://xilinx-
> wiki.atlassian.net/wiki/spaces/A/pages/18842090/SD+controller?responseTo
> ken=3D4bd005c7902a3dbd9ecb032f02e52ccb
> This particular issue can not be reproduced on that platform.
>=20
> It also didn't ever trigger in any of the other platforms I have worked w=
ith
> and supported during the last four years (STM32MP1, NXP (iMX8, iMX7,
> iMX6), etc). And we have heard of no customers complaining about upgrade
> issues.
>=20
> Being RPMB critical for our security story - device firmware verification=
 and
> upgrade - we would have noticed. So this one is the first time we have ha=
d
> troubles accessing RPMB - incidentally blocking a product launch and caus=
ing
> a bit of pain.
> https://docs.foundries.io/latest/reference-manual/security/secure-
> machines.html?highlight=3Drpmb#accessing-secure-storage
>=20
> We could carry the patch internally (it seems harmless after all the test=
ing
> done) but I'd much rather land it upstream if possible.
Agreed.

Thanks,
Avri
>=20
> >
> > Thanks a lot for fixing this,
> > Avri
>=20
> thanks everyone for the support.
>=20
> >
> > (btw - yes - our manufacturer id is 0x45 - it is set differently in
> > the mmc driver for historic reasons - Thank you for adding this.)
> >
> > >
> > >
> > > >
> > > > >
> > >
> >
