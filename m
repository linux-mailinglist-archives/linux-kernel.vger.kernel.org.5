Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E787B7D43
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjJDKhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjJDKhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:37:11 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3D9A1;
        Wed,  4 Oct 2023 03:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAK3wPwlbrNhoy9nYetDsCq4xuHhfNfjburmXvzb4IDG0s0ZVHJyAsbe9fV8BWxd7ZjbMMezlAhmnkIgKGCkXYGgvi0l28g/gNy5VDZ+bFgd+vnZ9LcveT/RQL4N0f1+wht3Bivfb1g23FQmMIpH6x2/uMp2daZzY8OISjBeQb8aMHmYyCanvWq0Lv+XIqQuigMXYjrPMILeTjXQ1jMt+ntuoS0Ya0XB165FBCQZ/9ANHoEMVEqH2XRpt38ZIXNMPksFamhLxgj5jYA06b+U8wa+QPnAyDYbdtvCPw3qEPtrQertzHqPRARF2A5yGJd3dALPCbdltM9Sz6YQ7/5BVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWCMddIoBFgpIav2+s6+NEk4fMtlI8Hy34GsF0S7CsI=;
 b=fv6HUcQAJyAixz/QLnE4+4dce4Vcehnz5F8tMbCQwsAQIiJ7JtoN5tD5+YzIDzTDN/t1FfvDnyGVCHbqolL8jvxa4Sn7E6w8CQ2vpbbLgWhAGg7Seyf3+WNVGteiBog0xkxf39NNfP07N/rsckLbjabS5gSDCHmhJPrf6qkafjhROCCwXVuwI74CpcHjnQjryOgvlZ1F63n6OVMx2xJ+XFNBADZHy++nlB4rbtDdzjmeChqdRIX9SfgO9bVtdXOIm6Tdi6Zl4u1ff2lIfTjFUQskUt/o0VxJWl2Tz2/Rub1ikOnOl1KFmrAkT0mDsPw4oPLzbrgD7s8jyro5HulPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWCMddIoBFgpIav2+s6+NEk4fMtlI8Hy34GsF0S7CsI=;
 b=bbWm8IpTfQlH2jpzdLbnRO48QCVpfW5g5iB/8aIAD1olC1B0bVWrjt95AbUki1ZxskzpAao3HIZEjfHZ7CLvVvsteIUNwPQGu6n0dc87Zt/1T2+rSYj0yBnWgAg1vA1Ry46VYLf3d8+de7hH4WaWRDrMPYk3/EihTSPG83vyaGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by IA1PR11MB8248.namprd11.prod.outlook.com (2603:10b6:208:447::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Wed, 4 Oct
 2023 10:37:06 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 10:37:06 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] wifi: wfx: fix power_save setting when AP is stopped
Date:   Wed, 04 Oct 2023 12:37:02 +0200
Message-ID: <14139521.lVVuGzaMjS@pc-42>
Organization: Silicon Labs
In-Reply-To: <87ttr6heoz.fsf@kernel.org>
References: <20230927163257.568496-1-jerome.pouiller@silabs.com>
 <20230927163257.568496-2-jerome.pouiller@silabs.com>
 <87ttr6heoz.fsf@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PA7P264CA0496.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::10) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|IA1PR11MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad1c859-d5d4-422f-3357-08dbc4c5daee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UfAj3wlF7mRlVY2UB6pQsYvWm2cNEFtX5ZLCFUckYa47PsWl1RRPNJeLje5HMlMcyYz2uQr220gSx+2Bkf0C8Eh2SvJun65Pv6zUgBz8j9LeZHr/JZdgN3Mk01FZjrcLl/UQqo5zp/eS+rHxn0hFFIHmm/HTN5B/4JGIE9Q3PVL3l/3pfpPWHwCVPA4WyRFlSzqlRTouhM06j3V8N3CcalztJEbQ9ctUwx1GjAem2ILyCVWFP1DOBo7QxrdVO82Apkm/YEb5QyszxEDSVkF1UtqG9fPC2qxXCw9mfirLc7BoR4fQOHwRp/oq650glPu0H55BHCcaWZBPiJBn32V17SaTucBWguHMQG3kgfSUg3mYnXgLsPm2C0BwaZhYW8IRwtDVvGrjwB66f+JKy3LyXgZjaavJnr5UXOgq6YTSScu0LiLcXUMnWPgjVs1oMFh3eUJ1ve1MZMkwv4QMG23LmlLBdPQkZbY8R2NLnCCb6pbw6omMvWo8aj/iZeSgio4f71it/8Bg3BFrapKZUEkhRSHdiLbdqeJRyyA1jJOJh7VpSII2kETNPcA8QEUozgVX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39850400004)(366004)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(52116002)(36916002)(6666004)(9686003)(2906002)(8936002)(41300700001)(316002)(8676002)(5660300002)(4326008)(66946007)(38100700002)(86362001)(33716001)(6512007)(6506007)(66556008)(66574015)(6916009)(66476007)(478600001)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SafGXu8c7Mioh01q34xdA0dXAFDiU6etZQd6/it3/iutz0elKsCTTcQhbB?=
 =?iso-8859-1?Q?ROJJSEu1WlUPujMfCDAsZUePvVGdI6y1XnlDJbhtQd9LSYxHWLCl8nWuow?=
 =?iso-8859-1?Q?gjKxpCU0vUYs+8P31ugvoNqPSQoQSJuziE9qNJNv9v2Q7xA9i6S2veEEBc?=
 =?iso-8859-1?Q?QSUAcVk+ZUF8qiNokORa4CfhczeqauT2AyBaF9+h0wP2+YSOPABrYLL+j5?=
 =?iso-8859-1?Q?K3efWSh1Fuy8366czvXnHkXDWBdYyBcQlO4lVLNhIye2gokz55RR3eX3Yv?=
 =?iso-8859-1?Q?yHB09dylIe5fkQNv/j1d1ITvi+7C9uwPslxJXjSvS7ITk3fR2CqKVk1a3U?=
 =?iso-8859-1?Q?OSP5doPA+uaR0sqwLsuwwAyLFmZrv6XHE4X7+eblTOpYDJTSbUqJMSFz4r?=
 =?iso-8859-1?Q?gEtY4BTIhRd3BLsVKBtDTqbnUwovZU1bTTWhnLRdWhntkrXGx0LOYpbXQM?=
 =?iso-8859-1?Q?26K9inkVhFbzNpHEAmUSZvFVswvQZO0WvB8/VSBkbrHzbSQuO5KfwG1n1D?=
 =?iso-8859-1?Q?JG5xuM0u3wkh6VuVCiR1AxA7IcJezRdI12uLT3u2m7JMIUrRSv9z7vuC83?=
 =?iso-8859-1?Q?XiozAHpFxe5+XS/HVJx2XsYyrZUHUml9lRSrzz53e6qy5pl88fIqQ10T/e?=
 =?iso-8859-1?Q?YKYLzuSRTjwp4KHXSAkGvNUbc231IIMH3Ds8/Ulyx0AHDqwfjkoWZ8Edgl?=
 =?iso-8859-1?Q?9RMTEsIgsEu1tdQ0VgomwJ/dy0St5DRVNwNc5Wqx8eSbeyCkj4OIo9VNHC?=
 =?iso-8859-1?Q?8MDl9Li4MyOf8c3Jn2wNgIYMk3kjiDWlkM5GdBaZ1NEyJvfMLgNrPq4n3d?=
 =?iso-8859-1?Q?TRVP+CjzLmwGbSuJsm2izIZBToUlpu3ZEfPC7Ak+aDTOZjiN1zmK1uO/UW?=
 =?iso-8859-1?Q?KkOffAX175lzZFP80V+ojtY72YfHAl2MKhB88ppWM5tZwZgPCANrfPrdAw?=
 =?iso-8859-1?Q?O4GTjCwYAe+XFrHvPi9rLr56hOzVapdhA/JKV4/baJ14wFhzS4b39Zer2D?=
 =?iso-8859-1?Q?bQWg6vMOsZeKlCG40IEVd+EQBl2xeaH7jltAn9C9A3WfQnpF08O7FN9+S/?=
 =?iso-8859-1?Q?yJ78wlVpSFpHUOMEPUdyiQaPldGyrxHfb0faRk1WCDlu5oQsuwrjZpDstA?=
 =?iso-8859-1?Q?aPdRNKlLwPiepmSdJ7ou3h5XbzOzHciEI0wtwDknEobp9h25AraW2OoJyj?=
 =?iso-8859-1?Q?j3yuaeWIO1bQsTv4RAuMXQHr82+FmfVjxAIlpIRxf1r3n4vVctBzowNnCZ?=
 =?iso-8859-1?Q?m3glWO191GaiGnh+ixIIp1pH5pFu+ci1XiPhy0B66on19uowCuElK8o3Qn?=
 =?iso-8859-1?Q?5ObGt6HvEel9bYf1NVWnU/yW1bBcuEogmHIaG6lVpSkq7s3P0jgu1vfy6F?=
 =?iso-8859-1?Q?wt/Zb88Vdrhca8+vf/9edt/1ZW0uIkSRSZ8QPKFeeoVtHfNqK/rDAP/9jk?=
 =?iso-8859-1?Q?LmH2jIME7njs3+wYwXQSFTDETV9/Eh2F+pfT82qwC4Uzm0VB6fHSbxWZh4?=
 =?iso-8859-1?Q?+zktyb9UdieWmLP2IZwo7sl5nKsDYKoBQrMLJMCKziRBlkaY/Ezi7stjVV?=
 =?iso-8859-1?Q?OFaceRdGW6I/HlQl/isHzlefHgYI6nuy2Xtl6GGeAqcKWe9PmE/nv/YjwB?=
 =?iso-8859-1?Q?S3eb0hXK1JEyaPHeapJAlhMR0C4z8y519pTSsAdW84ijilH/i6s2P+em4b?=
 =?iso-8859-1?Q?Kr93oP+EJksrKC58816rr3G7G+/hCFFbm0VzN4PK?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad1c859-d5d4-422f-3357-08dbc4c5daee
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 10:37:06.4713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WORnZsYf65GmcAAzKX19aWCaKheAq+g4gN/f2FA/jqeFVu5ij+B29LrR6l8BdeVilz4Dif1oaXPfW2Y2UTq4PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8248
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalle,

On Wednesday 4 October 2023 12:20:12 CEST Kalle Valo wrote:
>=20
> J=E9r=F4me Pouiller <jerome.pouiller@silabs.com> writes:
>=20
> > The WF200 allow to start two network interfaces (one AP, one station) o=
n
> > two different channels. Since magic does not exist, it only works if th=
e
> > station interface enables power save.
> >
> > Thus, the driver detects this case and enforce power save as necessary.
> >
> > This patch fixes the case where the AP interface is stopped and it is n=
o
> > more necessary to enforce power saving on the station interface.
> >
> > Signed-off-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>
> > ---
> >  drivers/net/wireless/silabs/wfx/sta.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wirele=
ss/silabs/wfx/sta.c
> > index 626dfb4b7a55d..9c0a11c277e97 100644
> > --- a/drivers/net/wireless/silabs/wfx/sta.c
> > +++ b/drivers/net/wireless/silabs/wfx/sta.c
> > @@ -402,7 +402,12 @@ void wfx_stop_ap(struct ieee80211_hw *hw, struct i=
eee80211_vif *vif,
> >                struct ieee80211_bss_conf *link_conf)
> >  {
> >       struct wfx_vif *wvif =3D (struct wfx_vif *)vif->drv_priv;
> > +     struct wfx_dev *wdev =3D wvif->wdev;
> >
> > +     wvif =3D  NULL;
> > +     while ((wvif =3D wvif_iterate(wdev, wvif)) !=3D NULL)
> > +             wfx_update_pm(wvif);
>=20
> Isn't the assignment of wvif to NULL unnecessary as in the next line we
> assign it to again?

wvif is also passed as argument to wvif_iterate(). wvif_iterate() uses this
parameter to know where the iteration has stopped on previous call.

However, the assignation during the declaration of wvif is useless.

--=20
J=E9r=F4me Pouiller


