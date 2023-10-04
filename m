Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4477B7D68
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjJDKkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjJDKkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:40:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DEBA1;
        Wed,  4 Oct 2023 03:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crHPGvzKwOz2d8Qm2JwM/Z3Mu2ZRWZBtF8x2qHYLW/bXsJcggP88tcQ57k6FA3mciXAWMCacJZrPpTxffk9kXXn4UltpAOQuL42VOl1SuSgD4qzBJWLC/CX7Q0d+un597Vfkm9tbDDlZPJdZYIl32mAfGn+ARerbITnvOOEIAiVUwZp68OpbgKAXAeF6LEaVPkq4M4dCGY/g/3I7Pp7uu7FOQfsypRfS+FnZZCzqqZy8ufjxtTWgw/jfYNhaIpjHfIwoRAJljEPqytmaLHuXryt/rX/QZMYfvTtvmHzr0COXJ35Wp+mi4a4bf9Ir3hCh4jVkZV6OMS7CFCSea5azWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp+Zv/GKdZI02VWUYQ4IrUCsl3bPo2OnLfSoCzPXpfc=;
 b=gd4gSGZBIoTWyizNJAID4FITcPAzzmb42bl+v40c+asH2rHDDAoFSxqrC80dVDlF2m4rYDTI4MAcCKaH+DrwtkYCXIb0LFDCGd6fHwDNa1cUK+r1WZQOykuZ+M67zPBw4GXNptjZa7wCyyaSA5pkAoQU82Mtb6LfXSLSEhhS5GLr9YecXvVmiK+XbZrzFhIQyAW7sN3KapOUwvthZ0EYFmRtSW5GbhqNRmc69/pUbJ5a4/OXGYBSh1uVIlSEkOwxAWiTxOxqe0U9ZSyLRhj1uS/8syiicXYMfS1EnH89pg8DjG1NzwUZxMjcyqBLPJQIRCC0m8buqL8CBv/X+0ap5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp+Zv/GKdZI02VWUYQ4IrUCsl3bPo2OnLfSoCzPXpfc=;
 b=h8sdFA54x3h9Ehnn5mZ1zcRX4emWll99hN8+Vwn+d11NqVgvjLCNF7f97r0Kd3/tWCBVSkF5tUn75ba5NsvJMdL/9OU9mxZuFD/CDeDWRQ/JgAhUHjYEasqmpfyxP0Ojl7XRmkNWn5cHGlGJAVWEZyCYymPCgI0/UXKnt4IO1LY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by IA1PR11MB8248.namprd11.prod.outlook.com (2603:10b6:208:447::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Wed, 4 Oct
 2023 10:40:17 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 10:40:17 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] wifi: wfx: add placeholders for remain_on_channel feature
Date:   Wed, 04 Oct 2023 12:40:13 +0200
Message-ID: <16472781.hlxOUv9cDv@pc-42>
Organization: Silicon Labs
In-Reply-To: <87pm1uhejh.fsf@kernel.org>
References: <20230927163257.568496-1-jerome.pouiller@silabs.com>
 <20230927163257.568496-6-jerome.pouiller@silabs.com>
 <87pm1uhejh.fsf@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR0P264CA0083.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::23) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|IA1PR11MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: d63158d9-cc8f-416e-6a07-08dbc4c64ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hij1ZTkdUnYQMy3sNamCllRrc1eN5PTbBhF0tOcl/LOII3oe3mcZrC6DlSmGaW/u/UDYCsqTxoOJH8rXslqthrTVjErGqIlRVNbdn3tjLMaakIEJNxCuxOJPt4ofPsha4qfe1tahjZeplG9iq9TC4B73QvOMhg+c5mAD5xZJhL+8Gy+hYOg/Fna5c7iZIPx3N5hLUJZxPtrHm4x8gHpSn2qPUmUaZnvcpSn/ieEXL/2wJVDtsdRc3/weL5QvLjP8Ty1vhfxKOrIlx67sdl1Bu0Nf8FcAoZUmxO9ult2VFRsjCMYjqOcPT7SV8lPOomOy0F4vLtS4Cq4eyEGiLHCRsuAwt2vfLnyjcUhxzSYUo2PpYrsIw7ELx36grLF19lOqTpMr35FQ5Wqt1HsubGuEnXwGftiPeDKor1wvToYcRui6NsWSVwbbhP+LugccV4gGmg5b9iVmTfERh4dOTFoYWh8P5cs9V0Y2Gr0QBNW6YIK/j5Ogy66FiCx153AHvMCQGSGB7VnC5PJfwdLC9qKdHedxRooCW+FRskvRsRAYEVkpJ1vshEXRE2xRlIPKepbxwNB1waLbdBvUBfsgfDnnekcArBrP/o2qGsmAYoNkNvDjXhlBGn6I3z7qnBUkrLJb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39850400004)(366004)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(52116002)(36916002)(6666004)(9686003)(2906002)(8936002)(41300700001)(316002)(8676002)(5660300002)(4326008)(66946007)(38100700002)(86362001)(33716001)(6512007)(6506007)(66556008)(66574015)(6916009)(66476007)(478600001)(6486002)(83380400001)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QVMfNlql/zbthAORldPy3fS3eyy3WNyk4SpJUnIs3Kyzz/q3MMtMziIrGd?=
 =?iso-8859-1?Q?O9xS9B/z+eFw9EbyVVNmYzF+ulJRMcXAUnK+gyRgYTkdVA5Xn47tmB1k3Y?=
 =?iso-8859-1?Q?tCOn7U4Nm1K0dG8tGpu4wUURaFMnvSmFc5eGeW0dXEuJ9i2CNYH5t7wMXh?=
 =?iso-8859-1?Q?IefIjz7W1iBQZO9+e+of+A0ll87yk7xRmtpqfQpKlJ+9sVPK3WxWsfrmy/?=
 =?iso-8859-1?Q?IsFjfy8EB/1o9jO0LrtAbaIM0d5j9w+B1NYWZhEtlZJ681N7bPzGqT3QpR?=
 =?iso-8859-1?Q?TfadXi64LRted5YofChmXfay2K69wjqm5kd9ruEpWPYjZFzQ/p0INmlZtg?=
 =?iso-8859-1?Q?nptn4rE6NkR65o1FHZjxsmXNlv0829Y/oi8pxEKcumLJlicGDn4ci5Oaf2?=
 =?iso-8859-1?Q?d16oO/zyyaYZoEjA1mCt9HloVNrngi3qPPLwUtiyqV/Fi94n3qjbs5ALj4?=
 =?iso-8859-1?Q?mhl4Z8fmseOaCvTAIEibMV8qgzJVNVsAeXql08K0Vx+USMqqIA2AwTeedz?=
 =?iso-8859-1?Q?kA1W6dgAJgvYR4MmiKHRRLUT1H9Juxcersev960mJY5RwipOgS6soZVCbV?=
 =?iso-8859-1?Q?llQz8IVnKgxHzdVypHNdd1i1f6LdX1h0OeBowQWU4lOwIoU2S4saljui91?=
 =?iso-8859-1?Q?kRKX1RCTnLVCSjQnjsF8dfP4r1GWHA8MbwKl57Lmapeq0PVPkQ9e7qO2sd?=
 =?iso-8859-1?Q?uJxWlotWWj23Q0mF9egK1WJcYKRMLKgURHYSnlajGfYbW772/iOuy4HXZO?=
 =?iso-8859-1?Q?y1WrHzY64NH93u0YTHrcGh2svH5nDlSuwpSKDxCjsJGekOS6NywlhzbPYB?=
 =?iso-8859-1?Q?3dRTcxVSHUyDWbALDCv8lvlDlKAZEuUvZr8d/ASwaURGEiPVFSJIjemnGn?=
 =?iso-8859-1?Q?LnFCCXwbQGZCO5/iZUE05XaXw8uWQQW7dAjJIO07sqwrGlnCNmAt44zbSB?=
 =?iso-8859-1?Q?Y32ZG1jGG5vbKkBfU3Opi+xpWLyOOPEt5TlfWCiaJKfz0wC6tlKeNKb8Di?=
 =?iso-8859-1?Q?SgQi/gsvX9NWw5cpLuvutIRmTt3Xcw8NeQFabVnPF3SGzUN2w44KI3o3bI?=
 =?iso-8859-1?Q?6WOQEy2E8IJ+dUgWx/0FFUgYvir+T6CJ0iCqnyMUb5H3baC0NRuE++ALyU?=
 =?iso-8859-1?Q?nGKvYMIRBRJ4JdF73e9bhSAgI7dfORqk7naxYxzEpDorXaFUlWmPPtlTpG?=
 =?iso-8859-1?Q?7lhDJzmXlSPQ3ki41WrK6NwAbRNChihGqJRrYyW1t9SKHwqrhQ0RIg/+jf?=
 =?iso-8859-1?Q?/YXWNNmlMZc1K6/+CpjsXIEYAs4LRhngSLBpcrPK1dJR1UMYmk0yhAjyoe?=
 =?iso-8859-1?Q?VR7LdEFkOyYRyAm85SQtGLMCC3Ua3N0GmRI3hQUG1KGqn0ugs7DrewGVCn?=
 =?iso-8859-1?Q?Pxi81X5aqgaDeonXMQBZAHirr7v2nvE9J2PDyd6VYB8dgs9hmLsF2AO+lN?=
 =?iso-8859-1?Q?lsUFJjhdjYnYxjSJlWSfh4cfkE4gXrZK1OgGO7xC0hKOHfso6tVi/0vz6y?=
 =?iso-8859-1?Q?zdwdoCEujeKjx1DcJfJbB684W6muPYdTyJT7HAZknfzPV5gC4aUmwrfQ8C?=
 =?iso-8859-1?Q?4hmV3gdonAaPDExFoYtmW5K7VJWtiCYyuf8smm/BT+Ms62DBkAuQVXK0LA?=
 =?iso-8859-1?Q?924ti3tVqcmg+l8eDpyvOQoCzYmebUHk7nXChtLicyhmT7+1acTpUMU1sj?=
 =?iso-8859-1?Q?W/RnzZqFYuVYxm5rbEl1MD1yqC693AhV47I1n2vG?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63158d9-cc8f-416e-6a07-08dbc4c64ccc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 10:40:17.5318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnBNUWYiM24gSh0Yztl9MT9sArHOCYR079ljt1jbRHsXbxu8dWfS/CoSggDgoDkkZo2gbUu9RerQBfrOmhWmNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8248
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 4 October 2023 12:23:30 CEST Kalle Valo wrote:
> J=E9r=F4me Pouiller <jerome.pouiller@silabs.com> writes:
>=20
> > First step to implement remain_on_channel.
> >
> > Signed-off-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>
> > ---
> >  drivers/net/wireless/silabs/wfx/main.c |  3 +++
> >  drivers/net/wireless/silabs/wfx/scan.c | 12 ++++++++++++
> >  drivers/net/wireless/silabs/wfx/scan.h |  5 +++++
> >  3 files changed, 20 insertions(+)
> >
> > diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wirel=
ess/silabs/wfx/main.c
> > index ede822d771aaf..31f6e0d3dc089 100644
> > --- a/drivers/net/wireless/silabs/wfx/main.c
> > +++ b/drivers/net/wireless/silabs/wfx/main.c
> > @@ -151,6 +151,8 @@ static const struct ieee80211_ops wfx_ops =3D {
> >       .change_chanctx          =3D wfx_change_chanctx,
> >       .assign_vif_chanctx      =3D wfx_assign_vif_chanctx,
> >       .unassign_vif_chanctx    =3D wfx_unassign_vif_chanctx,
> > +     .remain_on_channel       =3D wfx_remain_on_channel,
> > +     .cancel_remain_on_channel =3D wfx_cancel_remain_on_channel,
> >  };
> >
> >  bool wfx_api_older_than(struct wfx_dev *wdev, int major, int minor)
> > @@ -288,6 +290,7 @@ struct wfx_dev *wfx_init_common(struct device *dev,=
 const struct wfx_platform_da
> >       hw->wiphy->features |=3D NL80211_FEATURE_AP_SCAN;
> >       hw->wiphy->flags |=3D WIPHY_FLAG_AP_PROBE_RESP_OFFLOAD;
> >       hw->wiphy->flags |=3D WIPHY_FLAG_AP_UAPSD;
> > +     hw->wiphy->max_remain_on_channel_duration =3D 5000;
> >       hw->wiphy->max_ap_assoc_sta =3D HIF_LINK_ID_MAX;
> >       hw->wiphy->max_scan_ssids =3D 2;
> >       hw->wiphy->max_scan_ie_len =3D IEEE80211_MAX_DATA_LEN;
> > diff --git a/drivers/net/wireless/silabs/wfx/scan.c b/drivers/net/wirel=
ess/silabs/wfx/scan.c
> > index 16f619ed22e00..51338fd43ae4f 100644
> > --- a/drivers/net/wireless/silabs/wfx/scan.c
> > +++ b/drivers/net/wireless/silabs/wfx/scan.c
> > @@ -145,3 +145,15 @@ void wfx_scan_complete(struct wfx_vif *wvif, int n=
b_chan_done)
> >       wvif->scan_nb_chan_done =3D nb_chan_done;
> >       complete(&wvif->scan_complete);
> >  }
> > +
> > +int wfx_remain_on_channel(struct ieee80211_hw *hw, struct ieee80211_vi=
f *vif,
> > +                       struct ieee80211_channel *chan, int duration,
> > +                       enum ieee80211_roc_type type)
> > +{
> > +     return 0;
> > +}
> > +
> > +int wfx_cancel_remain_on_channel(struct ieee80211_hw *hw, struct ieee8=
0211_vif *vif)
> > +{
> > +     return 0;
> > +}
> > diff --git a/drivers/net/wireless/silabs/wfx/scan.h b/drivers/net/wirel=
ess/silabs/wfx/scan.h
> > index 78e3b984f375c..2f8361769303e 100644
> > --- a/drivers/net/wireless/silabs/wfx/scan.h
> > +++ b/drivers/net/wireless/silabs/wfx/scan.h
> > @@ -19,4 +19,9 @@ int wfx_hw_scan(struct ieee80211_hw *hw, struct ieee8=
0211_vif *vif,
> >  void wfx_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif =
*vif);
> >  void wfx_scan_complete(struct wfx_vif *wvif, int nb_chan_done);
> >
> > +int wfx_remain_on_channel(struct ieee80211_hw *hw, struct ieee80211_vi=
f *vif,
> > +                       struct ieee80211_channel *chan, int duration,
> > +                       enum ieee80211_roc_type type);
> > +int wfx_cancel_remain_on_channel(struct ieee80211_hw *hw, struct ieee8=
0211_vif *vif);
> > +
> >  #endif
>=20
> I'm not really seeing the point of this patch. I would expect that once
> .remain_on_channel is assign the feature will work without issues, for
> example otherwise git bisect will not work correctly.
>=20
> What about folding patches 5 and 6 into one patch? And then moving that
> patch as the last to make sure that the feature is enabled on the driver
> only after it works correctly?

Ok.

I think I will have to reword a bit the commit logs but the reordering shou=
ld
not be difficult.


--=20
J=E9r=F4me Pouiller


