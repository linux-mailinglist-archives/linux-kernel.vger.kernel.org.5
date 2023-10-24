Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8E7D4730
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjJXGHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjJXGHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:07:17 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2087.outbound.protection.outlook.com [40.107.247.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7BAC0;
        Mon, 23 Oct 2023 23:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyfxEmQa8IJPMg0v5YeHCuLCYm/1vYWE41QzUtOF6s2RLr0+PmEwpvuVN5RwKMmEMJFOeFeeDbYKszU/yKYO4SG/gtStpInwl2UbzC6tTCAzVOci0QqX0yn9bORzwmd92gGz4qW1jstF+9a05rNQgala7JTKl8inAo5T5w5QrtNwNs+kAGmijtNXgdkh87f7AbHN4aXbTlKZ/DG+yUsrO7zOMdd9r/Jy5K8U8ABFHAy/YZP5EauPVki5LuLpT+PranxEXRgpRd7sO6g6hCyXW4PGNcmmrmcZI8vR55eLXwljtkCxot5oj0Q3Ftx3T+TB2AbDXCzago6S5FfmD96P1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVCy5GMDKyUNNA0DnvJ1zmYYgGvIr+qQk4fDk4KqKas=;
 b=Op6ypJe0YXM4VJmGaHgeSIP6524ZeBnVzb0a6NOvUfqOZnXNgT3JgimDCHdtiro4b80rq3jjPmv205yOsEAdqQTzsPv5Zhx4HZdnut62evOO3oGZTA5PawytMh9pywj/6GIQEtuQNRxKhyt3EBIqgVjvOu/7sJNlhuSni2m2J+aDwbZgXd+rhlzBiA2VyhzWZrZZb6otBcnx3eEGQFMYqSgv5YEcOlJML36wpY0xwaNS4oCAkt0EkKftGXdWgCpaAx04JhVEo78edKpZrDUnCHlHOS3EPKNlCz08cOqMHBQ9IktzikVhdrR0Nz3JjwkbUC3uae6fcXEUHEF1zMXedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVCy5GMDKyUNNA0DnvJ1zmYYgGvIr+qQk4fDk4KqKas=;
 b=inKJDwbwG33uybT8yhHe2ROXAYlVzbXAyur01XwtUW9x70ctCkOyOHqZBji62H33oIcdxPWnW9dnKNrvcQCN9oIQdqMVUmRZVuV/U/oq6+Se8CR3y82C5vxvSd2Fg2PItV7ltEQa4qPPzIVzjatrl50247q7BgT0i9WAoEpP36A=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 06:07:11 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 06:07:10 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v6 0/6] wifi: mwifiex: added code to support
 host mlme.
Thread-Topic: [EXT] Re: [PATCH v6 0/6] wifi: mwifiex: added code to support
 host mlme.
Thread-Index: AdoDCDtnHg9WHjidSq6kmhUFkN75GgAYVdiAAKjzqgAADLfD8A==
Date:   Tue, 24 Oct 2023 06:07:10 +0000
Message-ID: <PA4PR04MB96387A17610D1028E73698F1D1DFA@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <PA4PR04MB96388A628D6AB8359D3DAAD0D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZTKbxe1bAkfRI29V@francesco-nb.int.toradex.com>
 <d0865f9b-081b-4358-a039-2fc04f0575dc@quicinc.com>
In-Reply-To: <d0865f9b-081b-4358-a039-2fc04f0575dc@quicinc.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB8814:EE_
x-ms-office365-filtering-correlation-id: e5bf0bec-ca0c-4905-46e1-08dbd45775de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KgRSk8Z1tOsrYt6gBhjZhsm2EJDefXdNkAVuBQyRG2cwjY9I41+Cjf9L7tTPtHRZiL4pFfHcF83h79wTu0nL2XfjGtH7h6FrC4fzkZyrCZU1VlIB7RcIPLU2cG+Cmta0mHsYw4/R6JDUIEfVsLogvt8tckjbKerQGa0YXiWfw5X2CcUz+EKQlJH9SY6R3FSNE6uo3HeR55ww5nnPmoqbac1rLNcxklQOfG3WR4ayHbMC+uCe1mqyuKDh8K1K0Fbk7gcOC0YNFZ+WzSutN4DwNLJsqf/6VtHkee6MYt1JLWqrb9lyMnU6PDiZ36rmFp/jy4Y1jTYE3GHh2EFT/dvWVYOrW8KFY8O9ULuchh8Z5aNVlbNKV00ntkjmIGf7FDVdTDiviTwoHe3l4602WZGOLaIdD7K50q8nqkqqtA0GH/uI17PvhBPqh3BzJQ1cbG+2FcfJo7L9jwRiEQgKAphlMBuDhV3lXUuigLeJ3Pxzcod+ZC2xDO3ltLFjHV9k64+it1jnz0RGm3irVEyT9iNPQeJtysPO/UkghHng5WJbMtRIVW4zmeD/ONVtYPZCuff0IaxG2/GYRk0mkB7K6fWixqPHITcCw+e55+qJeVRHUJs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(55016003)(45080400002)(478600001)(7696005)(71200400001)(38070700009)(33656002)(38100700002)(122000001)(86362001)(2906002)(6506007)(5660300002)(83380400001)(26005)(41300700001)(8676002)(4326008)(9686003)(316002)(53546011)(966005)(8936002)(110136005)(52536014)(66946007)(54906003)(76116006)(66476007)(66556008)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VD9bUxx0cuzdQtZYyj+5HPd9KdzLPlpkCcPzlvfcVJWo1nfkpu2qBbJH/J4s?=
 =?us-ascii?Q?PvGxBjXHNHkHGkA3KdszBgQ5UzcssZo2fMpZ4p0YXYZddS8KXyoC4H5yI7Nc?=
 =?us-ascii?Q?iQ0nWMhWzsuUeipgeVEqb2BHyLl2cBfxrpP6TBuSNV4WNMpq3fU02CyTwpcC?=
 =?us-ascii?Q?LpLSIkORq32sHP0jf+BWTNqONRhGXPQ7GCWZ+woHx+7qJzhGXMXxYLoXr7VE?=
 =?us-ascii?Q?BDfJQLzzFupzMfQ/7jFOa+BtJvvB7BwHN7lxK9Ob7xzv70xjipYPjKp8XKMb?=
 =?us-ascii?Q?nmFhgJT5nv5l1+muUPLS1E2C99XmrKK3PEJraLZWcWV5qiuad/7C3SInpJ8O?=
 =?us-ascii?Q?ouDSE31LNZPgFCsjhVrGoLuKDIVVkcMNejPGvvqxgQ+MuppfWpJJ6ugt8omE?=
 =?us-ascii?Q?0oeZCUn1AmZUlRySIsGeWtTp4zo5DffPY2ufi/egK6awFMCyPZWiPE8Png93?=
 =?us-ascii?Q?lAvu3N/67vw/sYc82jvtTKZ+uY1cpfOlwT05Q4Lk5JRwjZN+GzKQXL62hCoy?=
 =?us-ascii?Q?6HmIPWOnAespYAXxN+HtO5mFMI6LJANZ6K7+eQArEejosgS7fxbvOlOiOnSn?=
 =?us-ascii?Q?zaO9llpQhBS4NUs5Gx969VpmrHzJDYkdcktfUhu6ZDLu3YzcC5JfZNmJPvUy?=
 =?us-ascii?Q?diO2YDjRmjJhFKeQMgdFUbCuZK00euDQ/KcF0pDDKigs0jVhGHoCGSYCJq1y?=
 =?us-ascii?Q?9MYVHW9bfyBPPwcLlhqRMIj/OysSLtkqy9Q03vgS9Rjq/Zm9+lWKgYLE8qoz?=
 =?us-ascii?Q?o4nBZuTEeEftp24cPfK82ZUXUA38mp80KDAHkowusG48bmcH4sAYja0kld3Y?=
 =?us-ascii?Q?MJVeUtoPYcTPrbYdWl2Qy/ra3MlqXVZJOGUvmY9ZEIIDrHLAgwKbyutsReQ8?=
 =?us-ascii?Q?4zS+fRKihxrZigYa9th7yCt7O1mO8wZ2WLVnHIVikLl3vRXrTKy0uK7Nsib4?=
 =?us-ascii?Q?XdvkxVos5ie7Y7LVuTmUb/Vv6DlmBprSl4QzvrVVOffwU/Z7HPOxU26mR+Wk?=
 =?us-ascii?Q?ltlimT2wOQd/FdWfYEZ1QkRzqXBKpHG0omebTQT00wn4W98sYrbc1XZlGY5D?=
 =?us-ascii?Q?aeIBomh2tjgypzxAj1zFAd8IQ0YOvyu3tvVrDdoiNKAp3FkpKZH1OyaTCSVv?=
 =?us-ascii?Q?NU1G1s/Q0N1VFUdxlJgZIQKQh5MqN2lGDnERneps+hG2pbGV8r8IF8OuBNFH?=
 =?us-ascii?Q?340J1j/5VWSz9a9XjQY0oUNKrjI4t8iIMY8wx+ArYqoAu1ouP2zOJncoOchs?=
 =?us-ascii?Q?J4F8jldhUF8zodbQ1NxRg7HgGBKIHhLbS88V25LbNs1vtCANIkoP7YA+slfh?=
 =?us-ascii?Q?Sm5/mBJYXgQGztp6IXhrfQd7k8MCNlLancC+71I05Rp45l/a1/vcwPy5+P00?=
 =?us-ascii?Q?PVEHGibf9HzlV6jGjZvPcdhtMkhbLyo7J+o4NAETL4C3S+/eUzMB0hhl+xJF?=
 =?us-ascii?Q?0aOR6FCsSVFIWYsTPMaTV0cQokdnnFgl2jSiaLbCavtXRZBrOiL+EMFHbiAL?=
 =?us-ascii?Q?TWAjgzGCYs3p/REEt4AwJvknOjWbR2Wmj6KdIOnrsfza68hsVdr5DBwY6nTS?=
 =?us-ascii?Q?ts492AcSNE8vzCy61eRaJhwWN1f1gs5Iy9P7ESI0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bf0bec-ca0c-4905-46e1-08dbd45775de
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 06:07:10.7752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PrsoKLsYOvvCb+IJU1NabVko47XhkwWldozV9WDEUxvyONmfgIabZyWqiGkH+at73d0hHx/pldJ4AC4SGZB07w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jeff Johnson <quic_jjohnson@quicinc.com>
> Sent: Tuesday, October 24, 2023 8:03 AM
> To: Francesco Dolcini <francesco@dolcini.it>; David Lin <yu-hao.lin@nxp.c=
om>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; Sharvari Harisangam
> <sharvari.harisangam@nxp.com>; Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v6 0/6] wifi: mwifiex: added code to support ho=
st
> mlme.
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On 10/20/2023 8:24 AM, Francesco Dolcini wrote:
> > On Fri, Oct 20, 2023 at 03:48:06AM +0000, David Lin wrote:
> >> Patch v6:
> >> Correct mailing sequence.
> >
> > You are still doing something wrong sending the patches over email,
> > the various emails are not threaded as expected, git-send-email should
> > do everything for you.
> >
> > No need to re-send now IMO, but please figure out what's wrong for the
> > next time.
> >
> > To give you an idea here [1] you see this email alone.
> >
> > This [2] and this [3] are examples of a properly sent patch series
> > (just random series from your NXP colleagues).
> >
> > You have also a winmail.dat file attached to every email in this
> > series, not sure what it is, but I would try to not send it.
> >
> > Francesco
> >
> > [1]
> > https://lore/
> > .kernel.org%2Fall%2FPA4PR04MB96388A628D6AB8359D3DAAD0D1DBA%40
> PA4PR04MB
> >
> 9638.eurprd04.prod.outlook.com%2F&data=3D05%7C01%7Cyu-hao.lin%40nxp.co
> m%
> >
> 7Cfa233ec6406043013edb08dbd4248bb1%7C686ea1d3bc2b4c6fa92cd99c5c30
> 1635%
> >
> 7C0%7C0%7C638337025651088842%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwM
> >
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> &sdat
> > a=3Dj%2Fdb7i1jZc5Y%2Fc0s9JUHVmdamBx0Unu9i532CrrEngo%3D&reserved=3D0
> > [2]
> > https://lore/
> > .kernel.org%2Fall%2F1697794232-2607-1-git-send-email-shengjiu.wang%40n
> >
> xp.com%2F&data=3D05%7C01%7Cyu-hao.lin%40nxp.com%7Cfa233ec640604301
> 3edb08
> >
> dbd4248bb1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6383370
> 2565108
> >
> 8842%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz
> IiLCJBT
> >
> iI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D6bh0m%2FKqIX6u
> IvmTLr2K
> > 6YoEs8feeJsrldxgiiDf%2Fn4%3D&reserved=3D0
> > [3]
> > https://lore/
> > .kernel.org%2Fall%2F20230811101232.844769-1-neeraj.sanjaykale%40nxp.co
> >
> m%2F&data=3D05%7C01%7Cyu-hao.lin%40nxp.com%7Cfa233ec6406043013edb0
> 8dbd42
> >
> 48bb1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638337025651
> 088842%
> >
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> TiI6Ik
> >
> 1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DmleWOeKLaj39Bratl9
> E%2Fn9KsL
> > zx71aippjx50VNt0QI%3D&reserved=3D0
> >
>
> If you are new to contributing to the kernel and don't have an establishe=
d
> workflow I strongly recommend using b4. It removes a lot of steps from th=
e
> standard workflow.

Thanks. I will reference it.

> <https://b4.docs/.
> kernel.org%2Fen%2Flatest%2Fcontributor%2Foverview.html&data=3D05%7C01%
> 7Cyu-hao.lin%40nxp.com%7Cfa233ec6406043013edb08dbd4248bb1%7C686ea
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638337025651088842%7CUnkn
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DwAe4ueeaorIDgVIYpkf6x
> 4PpZ5epJynpQOzUiqaGLAs%3D&reserved=3D0>
