Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AD98016D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjLAWom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjLAWol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:44:41 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2071.outbound.protection.outlook.com [40.107.13.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5CBE0;
        Fri,  1 Dec 2023 14:44:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5N8Lh8TxcKVZwBG6ipQJE4X5eBwedf7W8sKu/xzdwuCLFpThL4s3Z9iCixymdp2EAerAT7c8A6/eg7AzPPXiBpcwdtXD9jfwmXhUJnNA62UFq6DAge8jQpk9XkLoPEeNrOWeHcS/rJDK93b7mi7aEY+danU22eW0B68O9kRrY1sznvooXAIBV1zbh+JrWOPLr8JQFmBNNoJ1MBqT/msd57dhNKfekh7M8asO83oNtu4XgqU/e9L0TpqoIDu80iCeOrGVHN0pnCm4z8TG2xdwZjV2cYAUJnpBFbl9nv7FgKX/NzE6EsnG5sJ9VgJLhlg6MuTZK8ggxVphqDZKJe/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GURLO4MnwgNHQ37o6tar2dUe6cxVT9KGhqm//1jQP+c=;
 b=Zwej7/fmgMITwhZ/myP0aCsdE/3CmkiWYDos+KVvl7CYIaC2Z0LxRcbfdO7jjCcwBy9fkrqIUdIU6067dCwg2nSu+99mX/yh+qNYouMMMaNdiLcMR+cD+7/bAlFO4LfEZEguEUEDIc49X1wznOzU7pTfdyD+guj0bevGGZkn3XLrG/Ky+yQyoUG3J8GMwFNVfzZyhdhYoKQaNqzHIW/jq70KC32xZHXjqQtb5s28gBUrK6xwbS6grfqpSqw74Uoy+B8KcvrsctgW9aJnoZefBbafXdJq5TAvILo1186W71NxFXBrY4EFkAECKwTvRAOlOglCjeN28hNTQuymCDeJ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GURLO4MnwgNHQ37o6tar2dUe6cxVT9KGhqm//1jQP+c=;
 b=Ia3oZoVlDaAGrkRk5D/qc6vRRr7q+8rGsLHowhmVJM65F/BG8G6/2m2T95hy5u5Kdi1UJ8tY/kIoZia0FAnOKfQr/LzYPmtN04jgpUZi7nO1aV0h7TgO+kWglI5JXCX2QZ2GejaTZFnEd8/p5dd6+AfoRUrsfbXNND4K85TK0fM=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM8PR04MB7875.eurprd04.prod.outlook.com (2603:10a6:20b:236::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.16; Fri, 1 Dec
 2023 22:44:45 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 22:44:45 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v7 03/12] wifi: mwifiex: fixed reassocation
 issue for WPA3.
Thread-Topic: [EXT] Re: [PATCH v7 03/12] wifi: mwifiex: fixed reassocation
 issue for WPA3.
Thread-Index: AQHaIdVW2Rgv+lAi50uctTuVAqJuI7CUO6GAgADQDPA=
Date:   Fri, 1 Dec 2023 22:44:44 +0000
Message-ID: <PA4PR04MB963809171278A338C8048D15D181A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-4-yu-hao.lin@nxp.com>
 <ZWmy0799XL9Vy4zT@francesco-nb.int.toradex.com>
In-Reply-To: <ZWmy0799XL9Vy4zT@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM8PR04MB7875:EE_
x-ms-office365-filtering-correlation-id: c107b420-8af8-46b4-c4ce-08dbf2bf1d78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dh5JYTGx6Zvv+ReaoLqsLHMFEQW1kaqyBCHTZqC9ncxfhOXbygIS/JDU3ZLZqz/MBYaORxhTEdQzJ/RrCBxhlRCkT6S9ka1MggoaMkyucT2yMrqkqkw8A/ethlVNuL4vSUbCrfGsBJKVq7hEFlVXkESAJdR9qY1iEXoo0JqCcTs8vjzOGm5l/3cuBOg+vPHBIq29KqWGVRaxvCUHt1OfybplgUV+cQ3PRiMolVaL+PFb+VOG0fXOzPWCBxvNUbQJR/YaJI2T8/zxX9Iy4/ZytqNYgV7qLp4JRlAgJdIYc6bZIg5adAGSRiumy3xnfqjbqdyuHNSO9Lfg4a+Yhb4uP0cUhaNVb0Vc9sF0K9POW5E+E7NpskRnAqG9JqFEiopFOIdAyUOUhhs0P0gWiimTvdl9q2PNVV8IJzYwR2Z/qAgppi9pOcebtqWkcvKpZyS9lDMJ4PBk/QvbVhJnidCTQ2uezfWRd5JPeLU/G8nEZy1RPW9ZqKiiYGW9MioLMpj2d+0uwA3zS3THE2MKPmeMihdqPT9EmItMdWikk1WuxSdt8Q56DxYiwnBp8F34WG/K+WO4DgL2wOabSE8M06lBVDsrodstDk4qXbAp2Y9v5nogETsWhRP2TwIYT852a5iE1/6yyzABaCQ9a5K9W/seh5A+JLBW84qtALyLw9UfDTw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66946007)(26005)(53546011)(83380400001)(6506007)(8676002)(7696005)(8936002)(4326008)(71200400001)(478600001)(41300700001)(52536014)(9686003)(86362001)(2906002)(38070700009)(55016003)(122000001)(76116006)(316002)(64756008)(66476007)(54906003)(66446008)(66556008)(33656002)(6916009)(38100700002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YhjT1dzLMMeHWKHIrX8JOMSnDTyo13EsJZNgeM0WAUcNPhxQtM4r69aAkhW8?=
 =?us-ascii?Q?pTs9E78h9bvpBHtS+stgVxTzh+pzk9pUgVGkunMEk0q0rpsCbsuD7RQh8r/0?=
 =?us-ascii?Q?Co8iq6SepEuT/GB94xaRYhf3DOipYvTzeSFyZlxIL5ITvvUiCxAJjuHO8Osg?=
 =?us-ascii?Q?NMxZKetJtGZv64ZqiymBUT9KJBc1RLgJiNyoC+kYB7tawvDKjfwH/SU1eQsq?=
 =?us-ascii?Q?8SczQQPqEah+xVPHn+3qq2tX7SMa3gHQCqyYJ8e2KZPzdu/HMN8X6nGyO0Rl?=
 =?us-ascii?Q?HZmQt9aAcDciq67vcK1FGsnLDcLG5wfqFHqS3uGpd4fzWdLbiJ/IzEcAfMMx?=
 =?us-ascii?Q?4Ha6rbEnEAqSmbnVC6AnxzgG3UMx8N5KXsxNAMRh3WkvQ8PDzwqavbFVUkwW?=
 =?us-ascii?Q?P9ttWke1XAXBF86HvyuOiUTakzEsVEuC7ENVsqkzh9vv4d5OIzfhdn790t84?=
 =?us-ascii?Q?wn3Th5FM1caFzUJA9FQYeBNjQpm4J/N6F3CM1kJxpZie0fKWhbESXDCIBMxG?=
 =?us-ascii?Q?GXjfu/865pRiZvfcapbwlzR2DshqYMFRTzxIvaOegoEtBbCpEvrMOPdRvvju?=
 =?us-ascii?Q?Q57MqdBp+SiQbLWYs6iAidtruYyLH31a3135OrD8LmfGxDLue/6vIYIvDKZ7?=
 =?us-ascii?Q?bTDRaZ/kjl4ourT6nSMWjTtejX2rfnR8TUwjYhtkQsDGII8LUKR0msoBrrwV?=
 =?us-ascii?Q?mpuFy+oq9KsuMA1Cp7aL4RFgVwWa9wsdTi3P/QIhG3v8e3ytZ23BjvtUoK8y?=
 =?us-ascii?Q?2p5HHt5PCPgk5Biz33dDbXxUizfGqOj8pFI2hcQPWEUjEr/wkQnl7luXtOfI?=
 =?us-ascii?Q?HzClaUwx5qgPDCOgZGbZ0vVyIKDI1g72jb5NbHgn15ewCUh2LeWBQfYJuHnd?=
 =?us-ascii?Q?2+6MCG83qi+KpLhFh7UcsJZzc+8XR+IJzkoZmKegBb8G2j0Nz1SwwIXdh7De?=
 =?us-ascii?Q?/bVR2py+5EzYvvGkkSwBrqS9XpTr8BOlMrBltAxOIwdmRU6bSPSjtYa+3jji?=
 =?us-ascii?Q?K0NxrGdswbphGX479gLV8osIaXNZWsQqQV6k5v0tzgqF5zfCMWfRhnb6SJhG?=
 =?us-ascii?Q?Mwzz4OV25TiYwbYTZ0DrcdR+3UFcfqHEiUdeqDklHpDYUn74TUSuN2PfDU6f?=
 =?us-ascii?Q?A2rw+PvFVWS0wI17nvlKrVSpEdkKfXxsNQNgj+y0/u6CzlIbpGH9WAzj4zR4?=
 =?us-ascii?Q?sregCpggqmsPATfS47MIwq2O+wTI0y7p6Ito1mPxn+fPBbiaJwtKi4UA5AAH?=
 =?us-ascii?Q?uIUlhl5sqgw1YoPeLgfJS0uHkCt2VkqOFlblu2zYwsLtt46hhxg4KhVf8quX?=
 =?us-ascii?Q?4Ut877cVTPB+si/qaBNiEYTBtFicplfKi0+YwDKRcH7PrzhHwwattXQxOoHd?=
 =?us-ascii?Q?ks1a89RFYjNj10rKIEeGyqL6Ii7OZlNzCdKXfWyQ09z4rGTNzBvEQtyuJgKX?=
 =?us-ascii?Q?kGmsyJ/ApoYpff3E+CdQHTEUR5qQg44kiA0NkC0Al3oLea7xKu+xinH1HlBa?=
 =?us-ascii?Q?eDeJ2TDiUnM94wVeK5HmnNfz+Jv649uhxW3KsKrw3SFyyKhN9qNlyBBnoc+W?=
 =?us-ascii?Q?4h72uD93Np+XAlE5P4h6xe9AIDD4HzOmuLfQYSZ/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c107b420-8af8-46b4-c4ce-08dbf2bf1d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 22:44:44.9870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +THjE9hiYh0g/PBNdDbna6Csnqq+FBSOH5bIqqcShkXkIH8ux3CSOb7uDBBXJjPBT/hkES43B2KUWSZIjr/oQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7875
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Friday, December 1, 2023 6:18 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v7 03/12] wifi: mwifiex: fixed reassocation iss=
ue for
> WPA3.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Tue, Nov 28, 2023 at 04:31:06PM +0800, David Lin wrote:
> > This issue is related to resatart/reconfigure AP.
> >
> > When AP is restarted or reconfigured, wpa_supplilcant will use cached
> > PMKSA to do association to AP.
> > Because association failure does not report to
> > cfg80211/wpa_supplicant, wpa_supplicant will always use cached PMKSA
> to do assocaiton.
> > Connection can't be established under this way.
>=20
> Same comment as patch 2, this seems a fixup of commit 1, you should fix
> that patch, not add a followup fixup commit.
>

This patch is due to QA test result of patch 1, I wonder why this patch sho=
uld be merged with patch 1?
=20
> Francesco

