Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E112D7E01DB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346633AbjKCKh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346571AbjKCKh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:37:56 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C24218B;
        Fri,  3 Nov 2023 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699007871; x=1730543871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aIkk8wT4yx/UTU2gTisu9R6AlfMCI7RTXShRxqlT7lk=;
  b=VVidV/6KLSRY9N3l6sbJVBl/E9Jc1xzIJCBOsx+M5S8i8ep8UyRMht5c
   rWr/ST6ZV7UQkuXZ26WfwVmZegGUqkLiy36T2W8DhyujQMcSsvviztym6
   EDV0uArr2/zjkFI+Kt3/6R8ciNnUCNmlAtVtMk381U+hDaMim+Ifp2n/U
   7AEw0bJzyBdQpzH27CBUd9YSSZ8DFv+3IVMT+b03wTHPz48v4uJJzaAFi
   pFLrsbtmEtJ1AE7F7yyJL28umWKnnZ90sBuBU4vw7NtCSAecNM/Kb1Uzg
   3GlQlPl9TpbPbjpcsr+RYCkrKaNKDYpMnKSsm4CZ5CcrwsQz0ZagoVsGm
   w==;
X-CSE-ConnectionGUID: KLPgH0JcRtSRw5LW+Z46ag==
X-CSE-MsgGUID: /b7de2BHQ5Os+UnP4jNrVQ==
X-IronPort-AV: E=Sophos;i="6.03,273,1694707200"; 
   d="scan'208";a="1409458"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2023 18:37:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlMBbITkgT3Y5Ns8BTWLqc4ipy+6tBytmV8j+a2k7nUl4sIEsFXJCx4xDnC5aYvRP+Z+OeqjdegVsmf7BKHp6RotaSpCmu5JqPnD88Sn+8IufZQxzixmZbcx5eBBYGlELUnoi2znGS5xzpAyvH+Ux5z+Ze7JhQ8JSnQ9V5cWAVN5VyTW5a2PBY9NPZsnQQ4haaJe14i1Yqb2jNFq2D7nWH0ei9WRO2BW0sEzknZVjmX2bmQdwyu+xIdghBQVpiw1b5dYecaqTwcNAjOLDlWX5xvL/QIOVV/aqruIrY5m9/wKFkLUKpYvJUdwxtTxILI0KdGM4qdpbED/VyP2wDBhdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82G3kkNo/mH+Vm8FW8aGQhHgbO3UfsyKkZapiIyM42E=;
 b=I4Za4AriDUdRR+mGXhlWbXTKzG/Ki4nUQm6ODi4nt3plXLXlJPkT6fDuE7VXUC9SytpksPYYey1KddigNM2y4Q2y7z3Cj2AvcATl0XZnHrsD939CzQwDD4NqErGnQ+YV/GyClAyp8DOA0eZyB5+n36SnII8W87sfmYtKwJ3oC2fVsD4OR9YN+lD4NpQUvoZ2F+gCunvw/5wZjrK7LoMuifDArPVb//FZf4cubDrWUgSWr9OGNYhTuHjSMv4fkvCvwEdRpe1ahbtvMFXz93Lk3masez03qMzzUNIZ+v+R5zsVeu2S/SIYalPKsuwDlz/hIh/LJmSDzWczIteOJnZ/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82G3kkNo/mH+Vm8FW8aGQhHgbO3UfsyKkZapiIyM42E=;
 b=TA+XX4gcbRp0K9JppPkUBh+swiC7NJRTnswdMLtNhv+nyvZNmk5HnzfktwtbQDzYSMTMcoAxxQ2egJDUHgQIHijj9gz1gY9jIEafsH7qb4+jgWLuYdTXNxL7PM9Y76hB0ZjpVaPXtwduDeuMCx1ZEIhSoZDnAl98wuDPRiHgCGo=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7671.namprd04.prod.outlook.com (2603:10b6:510:5a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 10:37:43 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%5]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 10:37:43 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-2?Q?Kornel_Dul=EAba?= <korneld@chromium.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Bhavya Kapoor <b-kapoor@ti.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Thierry Reding <thierry.reding@gmail.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 2/6] mmc: cqhci: Increase recovery halt timeout
Thread-Topic: [PATCH V2 2/6] mmc: cqhci: Increase recovery halt timeout
Thread-Index: AQHaDjKHOEK5Q+ZpQUKFBshv6hnyBrBoZmEA
Date:   Fri, 3 Nov 2023 10:37:43 +0000
Message-ID: <DM6PR04MB65752D6E30DFE006E2CD5632FCA5A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231103084720.6886-1-adrian.hunter@intel.com>
 <20231103084720.6886-3-adrian.hunter@intel.com>
In-Reply-To: <20231103084720.6886-3-adrian.hunter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB7671:EE_
x-ms-office365-filtering-correlation-id: 3a7d385b-ef52-4531-5a1a-08dbdc58e9a3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uAGBaOPzy9n12Hd3Q4dTHq41Y41I+c1SIlJdHJ48bpnICz3jN5k8o0b1hejLNGRpTWVBMcrUsZTLWfeWkt9fvfv3GVDpUb4ryrPZDRRL+GYHiS9yNzQ1gIHbi/8TtegbL9yR1ccU3+eTSZBw5KMgoNz+u5Pi1mpSimPyJrizQg6lG8mEpUWRWHNN+mLc2bExRAqg+wCZQjy6sFjkSGXgqwcEvdnii5ujqUkyFK/suBTlF419zWp2LQQdLMm0S3/OZ+6HDTVq9/yEL2KZ2SZtqbwxLp/0UFcx+DJQM7v934MrKtMHfmE60lNDDniSI2nX6XAxsNVtnvcD25haaMal/FwoDSO/OMX1ftaoRP6PaaXw6sNjCRyeDcjlBxvji1a3IK12aK3kZRseyTVWCGlbvJNCtHU1T17SuwI4RJwyWA4cltuhiOJR1VJyt6JZmNRke/368YqfyzycLKDWRhD+lqumh1i6LSuQgNVlJwZ5q2snCbRpTaVNb5sm4IKegdZ2i6hgCbZIJ66C5oRX4ZRzEyweYxOf8FPeav6iyJlhumYUcu7WjKy6d2yF03OYoCZcFFWnfQYJS7qTADDD8IEPKrxihw/E7ElTriy8peUFNZZ82emzFfeXLlL5wonw4qxc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(122000001)(9686003)(82960400001)(26005)(38070700009)(76116006)(8676002)(33656002)(5660300002)(316002)(52536014)(7416002)(2906002)(86362001)(4326008)(41300700001)(8936002)(66476007)(64756008)(66446008)(66556008)(66946007)(54906003)(110136005)(71200400001)(7696005)(6506007)(478600001)(55016003)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?exAv5C+My6N2ZS419uyLpL364hmRVGEEqj+vA/4X3RAUKKdGyb/5pk3J+6?=
 =?iso-8859-2?Q?lvKuMxJh9U8U8QYoWetY9s2ZHszyNdMpRpu1IHMQoVZn/wJBt/0cSmLfyQ?=
 =?iso-8859-2?Q?3amP7WA18hvWR5lwHV+V193ln6utvy+e7w6/UjlXILB38GQGpOHIiOtf7T?=
 =?iso-8859-2?Q?Ze6K7OeaxJMKwct24xibERb+Y+YuBpfI4JNg9yVjarllfu/l4AVHtEgQa3?=
 =?iso-8859-2?Q?JGx2gPRoB2h7Zz1JqFdaAdDgPADSyJoVo8gMUImcUzDJbzkYw8AP28UDsu?=
 =?iso-8859-2?Q?5dsTHXGY+ukXJ+hJBnCs9XgenbjWCxE+kKG+GDVjsDLQkSOn60Jy57ZLDv?=
 =?iso-8859-2?Q?lPMPjrNnX57w/D0881PwXLqN1dZlW44nBs/JKC/7QXbil5ZnNog7+GFVJ5?=
 =?iso-8859-2?Q?APoWffTKtitVI+Mkbv4+RIN2AKuygy5zFH6iyCzH9SUy/Qw0qmjcPAPZJT?=
 =?iso-8859-2?Q?FfE7GwfhwNKQNZntCaqJeKF3PZxHK8eZq8a/DCit65kHQ3arB/Muklrdob?=
 =?iso-8859-2?Q?NN9ShaeUg2IUIGml9JGpUuXqsOUQOHz7XQGLYhQtOkWx42ypUej8kT2X/2?=
 =?iso-8859-2?Q?8vDY4LxxsyQqHhLs9Xz4N1p4FHHSADjXNXyj6ikNpeQISBVNhufJSgb2ip?=
 =?iso-8859-2?Q?VXynlw2DkRx9/F6EOuvRgaafzHvUPyDvMr181R/hIU/SmHETAXo7PiSxL2?=
 =?iso-8859-2?Q?aMAiF3DYV8d2JJO9/WbWm9ckiTiflxGt1lnzKKsZPMPcopSKa5iexuC3Pc?=
 =?iso-8859-2?Q?uNYraxWbvmR+ZbiB7cJE/yzwopgIY2QmEv0NwBuZcIWfDNTlVnLmMJtzNk?=
 =?iso-8859-2?Q?a3T2V3PCxqsNUDmd/HywugsG/qI2JSfGapY3oGJST3L7NvRZ/al2B/S0px?=
 =?iso-8859-2?Q?49D4yopT1xeriU1yPcHWdkXeBANbHpQQaxdnVACB5wu++iZqI8y9uNREEb?=
 =?iso-8859-2?Q?I4dWI2hFuescdOGwocrMT+U7O6/UOHPr+94TvsUc2lfVksk4EQ2xCVyzMr?=
 =?iso-8859-2?Q?YU5H7dVOBD8e1vMEHyiUG2Hs5ReCIhUDAQZmeQK6XAJvZPvO5Pcrf1rpTi?=
 =?iso-8859-2?Q?mSsK0yvBzasm2Hw+AwNOmM9h3gSDcCro9aH37qpX788Gw+rXfUY3VizUT6?=
 =?iso-8859-2?Q?3hktKJL2KxR3ekJULEXS9ih+V2EaQg/iaANubr8Vhvz/Va6IJQc4pp7fGj?=
 =?iso-8859-2?Q?7L6cqUDBz+1JvslOiw/KrgmnIAIlH+u5aApslUSGnZmTb6Nxipxa7bRelH?=
 =?iso-8859-2?Q?mjD4hBAyCPsODh8TpFzRdI6jyQvv6nbt+Pr0ajTwVctqeYB3yiOwfOvsdm?=
 =?iso-8859-2?Q?/Dl5CmM7Ks+4jXGO3wBD3Cyo7jk5BzvHEByRcpDq3RO7gsOa/xYMN072oT?=
 =?iso-8859-2?Q?mWDHGCqklt2PKkEU6NFdPKAjmRn53ANwM2gY+Zm/4j1vUYLrrrK//Dz1Do?=
 =?iso-8859-2?Q?CWtMfk3gvRsdLA5t8loHzBghmubapNb1E+CrzLkHe/26CWKtBeuuyerdKN?=
 =?iso-8859-2?Q?HRz1YYQGz1fh5KqkH8V4H14ETRFkRcCotCEloKp3e9c35JxeScNlFVKDRc?=
 =?iso-8859-2?Q?aVA+mEtGTy5rvEsBMcL3GsX73yGxEZGUxI095I5BIlwHXFNlPrpiIXEs9Z?=
 =?iso-8859-2?Q?nBJE2XToW/sMiFhLWVbWRMlQNdFp3GYWaw?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-2?Q?GFEpdEW+PPnIukWhGIzIe/z3Ley527hhjrmhYSJj4Jvl93FeURigEysAYa?=
 =?iso-8859-2?Q?6BtAtRX7LIbEsmC0T+D+oM3jGVdtt0JiejF180inPDBup4tR/34urEgBxP?=
 =?iso-8859-2?Q?+xftPsaEgooMPQXfgkyzDTY3US0ZebbHviQGGXYwTUaD50pnBIlOk8k1DE?=
 =?iso-8859-2?Q?R7Tvbq6zeIuGCcD+vFvpwgiBmVtEApWmXSrSOV3KzB0VxSf44Fi91qsFo0?=
 =?iso-8859-2?Q?ciing6lbERSvSIsEs2Qkt8fJqL4BBfy5JQDWi/mA2ymEkOeho5CxN1l+//?=
 =?iso-8859-2?Q?fVAByrUZrop9o0CfP5c8az8kBNxX6gQo6aOuL9prRQT+jySQYrJAVRmtfL?=
 =?iso-8859-2?Q?WJtzTEh+feY+wFKGZaB7WObktK9FgGVtC1zBQFz/Jhw75kQ19pcS6h7D30?=
 =?iso-8859-2?Q?wiDG57NQ++/7j0UoulOLfXLwwAs1C/MTO1l2Q9bAv3WVxxY94goY1Nsfa4?=
 =?iso-8859-2?Q?T/CGVzL9wkMdwvdSlvUDXm8dLOuhQImAgokpwt3VJLbgtPM8yw385vnsQ2?=
 =?iso-8859-2?Q?7BnlAGJWgdBAJ++RMZspO279MiH+fIRmi158adiHFBoCzL1JW3DFRxo7fY?=
 =?iso-8859-2?Q?bS+ZV+GpBBjy6MRDvb7M0YK4AYH5g5jRzqvzzaejHHc4Qmm+qcGEXv1gIa?=
 =?iso-8859-2?Q?H3g7ZlB2itbiPCcF/QWrCVdjHPqAEy6b9XBMD+HZKvj/MN7Rb/G7BGlF0X?=
 =?iso-8859-2?Q?F4kS9tg79crGlZjgTBN01iSFVE0R4VvhJPvVzsM++HuzEEU387G6VMCJCS?=
 =?iso-8859-2?Q?QtxlnRYmAeNV8a1s/s7QSAOzUR89n1XgPgyLgiSF8C6KFqwQ7KMqOanP/B?=
 =?iso-8859-2?Q?T93kectv5tMaAnXTEP7aOQsBYHTeQFQoMLYKUUl+ycAdyD0EL5ti1i9+JU?=
 =?iso-8859-2?Q?D8Gh1fm4/wuFwrW4wJc1ILOWXbn6JtObFCGnAz8uMEOUOYTGErJlYXi1eT?=
 =?iso-8859-2?Q?54ERV9j0jWc01CWxwW/ZDg2P21Kufg8U4vMeqTw781gOtb9e238yTuePtU?=
 =?iso-8859-2?Q?L4vfH9gy+xM0C2KT/WhyYPvVHZrkldyGXfk2CCrVLQrh4rmfnAN+00rPN8?=
 =?iso-8859-2?Q?cqM2BAIUhM2JfgReezGCZZ+5Jce6gGn7msIuJr+/EkYHwgCuLj4B9gDLC8?=
 =?iso-8859-2?Q?d+H6fDmo+PIeiUpAccGCO3BTs2vGBrpfWppiIpL9JOPXORBDR8ohSAyKQJ?=
 =?iso-8859-2?Q?z5BKYF6IC/E5QcQHnua076lS3qtQNpQx9lE=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7d385b-ef52-4531-5a1a-08dbdc58e9a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 10:37:43.8007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IoADgZPv9ZzzD16ztPl0yUyngSIO/Xg1eLgnyZBJgU6ntXFE9xrKVpR3HUvg9PUemNq21JaRZ71y4bvO6NUlUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7671
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Failing to halt complicates the recovery. Additionally, unless the card o=
r
> controller are stuck, which is expected to be very rare, then the halt sh=
ould
> succeed, so it is better to wait. Set a large timeout.
Maybe also explain that If task queuing is in progress, CQE needs to comple=
te the operation, sending both commands and processing the responses.

>=20
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled
> host")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  drivers/mmc/host/cqhci-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.=
c
> index b3d7d6d8d654..15f5a069af1f 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -984,10 +984,10 @@ static bool cqhci_halt(struct mmc_host *mmc,
> unsigned int timeout)
>  /*
>   * After halting we expect to be able to use the command line. We interp=
ret
> the
>   * failure to halt to mean the data lines might still be in use (and the=
 upper
> - * layers will need to send a STOP command), so we set the timeout based
> on a
> - * generous command timeout.
> + * layers will need to send a STOP command), however failing to halt
> + complicates
> + * the recovery, so set a timeout that would reasonably allow I/O to
> complete.
>   */
> -#define CQHCI_START_HALT_TIMEOUT       5
> +#define CQHCI_START_HALT_TIMEOUT       500
>=20
>  static void cqhci_recovery_start(struct mmc_host *mmc)  {
> --
> 2.34.1

