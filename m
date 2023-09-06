Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FF4793DA8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbjIFN2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbjIFN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:28:44 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E911D10F9;
        Wed,  6 Sep 2023 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694006920; x=1725542920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7w3ghhXSLpGFZKN/vbkImlET2bJKaP+M1C2pONh+sfI=;
  b=BVkLt5a40xlPqhcgh1ToyIDsuo+qgRtFMVwYR813rvfm0MyYgPKsMhJn
   T+NsXVopeS+v7dDu9O2qc+W9CbKWVdCm79QOLAlDLswg0jXg6CjtQhgi8
   AbktolkMqZFRBuf8QRwxMXqGmMzx7VWchZRqbr17Bdzkl+NsTgrHfsmHL
   gUi73SWAwchM2aUwlUBEBbeUUlL90mAddqHfEkApv9B9bhdQvQrw/uXkY
   jMBibPV/m/XHmjU39cFvxMiUyuYL6houhEU4t/XRkVpI6RcNjz4bcrGF0
   Zhwmz1P60zfnkzz+UXjB1NbFQVtWvDIUNk1GbDQx6BkMumbIBkdmpWPFQ
   A==;
X-IronPort-AV: E=Sophos;i="6.02,232,1688400000"; 
   d="scan'208";a="348402734"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2023 21:28:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWYuHAo+x4/1U7Sl+nmeDTemcZtHOzo7bX352CWkWxto7WGj1DB6u7fN0fMU2FaOM/sSIdm61OB2s30XFeYAXA5zp62Vm7nR7QAILz9NxPP26NScjs3NwEx+W6HE2sHT56QdWbP9H2xaPqilboELUr7+pWls01P2ZASz8Gj8leXDPXDxz8xMEzXSALGFVgeFt9Bigc2M9/l+VY/J3TNxU7jCmaxTkow22iRhcml3jPTASAo4q8SAUL+pMSWLwU3OjYlT2Z7xA2Cq1VnqgUyEwW6wgzv9yCHZPzaQuAHe894VrMXzJBMG+Z7qxT2o53kxQCxlk+4XstEAqY13Dgh51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LV9adeb8lu0jzKQnIUOUt/k6tpMSjsSXaiID6l/tB8o=;
 b=a02nnWO6gLfsTT8lMPfBjkRmnK3GSAvUPKUlFS3rKYtvWl+zmfbdosii57kQGddZYRs4Wn22CU9IkTK0Yt/LTK8K4hG0BUpuqSuFbpOHnDWdf8vOy57yH9Ga/PxsSPNMHLPpMAzQly1hUquZItV0Xc5Y8iQwK0430dkzz2FwGmrhbP0lfX/S6ahnMvxxTMbtge39EmlGxpgLtwItXABZ1vhj7IQjfCZ/etrvehZArdCoHz5kBUdwKV90x7gzblS0t9dkJaFW6fAumg99xJK6iK4RxkDm9dnNOGMpBMUpwBxLA48pr2iqykiwRmSSOhpckMEJ+7X4pQ8t/OGSLkHZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LV9adeb8lu0jzKQnIUOUt/k6tpMSjsSXaiID6l/tB8o=;
 b=0KqOHH9Ruzi/8BvDaubY5dUZG3zPO0+flS4FY02BtZbrXF+vExaskwsWr2150cyXfExdPhxivVCzUisqoFRlHTOF++LA7hZK7lTGeoIt6wZ5FhQpTFfhLkIyHcK83z6DDCG9cyy0wdv5mZveoL3Dii/0YFpq0FuDc19WBfqsHbs=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SN7PR04MB8604.namprd04.prod.outlook.com (2603:10b6:806:2e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.25; Wed, 6 Sep
 2023 13:28:37 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6768.024; Wed, 6 Sep 2023
 13:28:36 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     Szuying Chen <chensiying21@gmail.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jesse1_Chang@asmedia.com.tw" <Jesse1_Chang@asmedia.com.tw>,
        "Richard_Hsu@asmedia.com.tw" <Richard_Hsu@asmedia.com.tw>,
        "Chloe_Chen@asmedia.com.tw" <Chloe_Chen@asmedia.com.tw>
Subject: Re: [PATCH v3] ahci: libahci: clear pending interrupt status
Thread-Topic: [PATCH v3] ahci: libahci: clear pending interrupt status
Thread-Index: AQHZ4KgH0xm1jnrUEUi46VI4/h0EhLANsO4AgAAZ0QA=
Date:   Wed, 6 Sep 2023 13:28:36 +0000
Message-ID: <ZPh+gFyZOgthwbP/@x1-carbon>
References: <20230906095334.10310-1-Chloe_Chen@asmedia.com.tw>
 <14338db6-2cf8-06f1-d584-3fbdde82dd4d@kernel.org>
In-Reply-To: <14338db6-2cf8-06f1-d584-3fbdde82dd4d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SN7PR04MB8604:EE_
x-ms-office365-filtering-correlation-id: 977d2971-32e4-40c6-f0c0-08dbaedd2cd8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +p8b1+2j3rdrDlpTcq61CV4PCuKE6wAL40BlDloIb/nSxwfLxR0JwDqKm0LxGYhs/C7wGF151/9LNdujsuaR5cZGU2GdtunoUtF+oUk3lrH+vtYGjueqUsg7qdkX64wblo3HjdD4BHHwOIrLAMqmQASjJdtbaG7LZY6bdLStan3zKC0d5b94tgIgLMvUk/tCQiMkPjwDn7YuWp/MIOjoopTTTptEu1FszircBgjZlJkYx/w/USaXyiNSURlPK4bObUHClV2QXqOKInKOM8yTplksin+a8B3fJrpiiLQgj4V1YtOMgLt536y4ixTLnWrQ5p4nf9di/1ZwpamjRjGZd+Hcdss6Vxb70Ij3KEAhJdPv0hKJxzoiTIS0d+i7E9z6srjQLnKtJy1KMf5ByPJkuBEGi5/6eFlJdCTH46AY2gnEh9uGfHJcvvJ+Ji6bDCQ1HTKx3eg/vvjxuKnbNncqOCwcRJQsFFgnNp/WmoQVwtcSgjUx9/xSiCNpLdA6KqArZVnevJJBgOkJnlfhRZy4iZ3AfswgIQ8YFCBnMzJ5UXEGt18a2Y0UMatbUxTWUiVtzQ+UDhSay4uLcLbrTGTgKOecmhZknQjJW9lqXIi9HtLiK62mEeSzv1vhuhT4UOY6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199024)(186009)(1800799009)(8676002)(5660300002)(316002)(64756008)(6916009)(91956017)(66446008)(66476007)(66556008)(66946007)(54906003)(76116006)(2906002)(8936002)(4326008)(41300700001)(26005)(6506007)(6486002)(53546011)(6512007)(9686003)(122000001)(82960400001)(33716001)(71200400001)(38070700005)(38100700002)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7TV1gmiFVGYYsPqyJMAA3iGFL3pje+uXMfyZraV5kDLL7vL5yhCV5NqQUAsJ?=
 =?us-ascii?Q?6vVBzx5trqU2Xt34o3CXoe+FDh+xOIBvilu1geZEuWVnQFqJVtWDH6t+Tdfp?=
 =?us-ascii?Q?2KU3xsJDecWi19JhMePjAiSC1169VC0pbQKmApDRpf5ApAqs+5RRftEVHI49?=
 =?us-ascii?Q?OYC7bnSXSGYSs6fEFuBBwHpgBYugDBmujTTqDbgRX9v66L/wz8HIbs+9hSbH?=
 =?us-ascii?Q?+RXLqQVJS4GE8ZSgzSz4AepEf/c8qW2Z+ogWxmse0OB0npGgAmQ3BCs6lAOL?=
 =?us-ascii?Q?ts8oHU65Df4hA7Sy0eUZnuCDQlRJX1JEyG9DrSyw/9HvyTmy/CtxNXKLrd3x?=
 =?us-ascii?Q?K3mbidlR2kg807Y4gZW3PaiDt1dHTtV5qL7L6tO50iThsQws+i+Fp1L2mRz5?=
 =?us-ascii?Q?TovMhJNOU6YNsae+5INvwF3XZLrqb714Jnzg6aXlUNEKuICuAKbAe1Ksd4Ko?=
 =?us-ascii?Q?ZRhlLPH7t+F6s0CVRLbUVVJ2FVxuU2R/+vCk/4GIho3PvYDKG0JsiL8U59kK?=
 =?us-ascii?Q?BB2LoDNEApTWBckLwDm44a0t26sdajUCzoBrP4EYbCo4ixS4ityFee0wUMBZ?=
 =?us-ascii?Q?NJcXdgXn9JdOsKuk2lKSUKWCjRlZ7hv1NCfGsx2q+GAVgoAM/yS6HEuDC6Jy?=
 =?us-ascii?Q?/IVUoD453piHuahQ0BMz6NC+PjEcRoviru0Fj4AqRcXmk7JPM/QkoAWQadow?=
 =?us-ascii?Q?1/0OChU68gDTLItcR15M3F1QIokwyFuTwyWWtu1MatWVTXpkerFflUtPLBG3?=
 =?us-ascii?Q?xzWYcgMnki9byxWJ6FbRL64m5d+mxKfReVAd7lnrSAHZdgbu6AM9Ln8k2xru?=
 =?us-ascii?Q?gSi8c1kKp0Wt05kmdVxGfZaa9mR4iyJnIJCnP65ppIYeFGtJ5VAzQhbMGr5S?=
 =?us-ascii?Q?fjqdqeBrQM0kVRYCWQvT+3P89p4HSeRIiHggIoYUWOKzQcqznZMrLsX4saWT?=
 =?us-ascii?Q?MoNANPiFg89uyBaLrDy6yXOVa3NHRCgK1HgUBp7qtknzfT4sBpgdRC7RRZLX?=
 =?us-ascii?Q?AcV6FhO3hBLnDgMLHbIc+8Pik9Kh88b1LmIW+k8Oiy4cU+BqkrrPSl+HJOB3?=
 =?us-ascii?Q?rUjRUqVu+4JEeP24/2+tdifNhJ+hMuOMF1KZ+g1NfjYTFfVSW7qcSmqZIm51?=
 =?us-ascii?Q?hPuV6N8o7h8tbIE7T+XHNXEN3KQjSkjzi90L+e0oVuXs7CdqY2gVt437Pt6W?=
 =?us-ascii?Q?IlzJzTuz5Xsr1VFqLShRbhi3FsC3njhgkQI2tyWV+xVgop15PPP8pp/p9nxF?=
 =?us-ascii?Q?wPk7v5pu9yUDA9cielUtXp7b4dGjN+stH8wicqh3brZQKXRXwSUcHRXIt8D8?=
 =?us-ascii?Q?+lFSHtJcIQ9AEyRMAYZzWcGH2jaSq9/IcF8EmQX6stjfwKwoC7it20g1dpqv?=
 =?us-ascii?Q?noPnVuXxQ1gqgEWrVNiK3Xc+ypUFiIob5MGEJ+lG6qIV+zX1CA3BEk50waK/?=
 =?us-ascii?Q?GUDCmDUY3aRFjmZ7z9+x7p6WReWYwOFEZqEUBEzKfhp3nz3xXd229PS3uXRW?=
 =?us-ascii?Q?OriupUUQNbA0zjh1KzpznwITgGQ0pggYRV+86S1hytagtSFgLbT5h7du/YkM?=
 =?us-ascii?Q?aAqj6L5ARJRKxpCWSfCq3Kyiwzj2jeZbTZFFpyzOF/1YJQoWDVctJtjwGBYU?=
 =?us-ascii?Q?HA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2B44DC671E44A4CAF014EEFE1E29014@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uhAh/2Q6OZI0hNqGSjP19uPU8smJ1goCmQmqYNxCyE8CLrhoNp58VNU/k9SFCv0K2aRt+DeX9FbdpxI+j+tIBQ22cG5E3kjn3ZkMPR9AG7pXpI/bs7z4YsM65PgT9anbCK5eIwqoIHTMH9iazoVAirzTbv9q/8Zqg6LRDFFB1xxjNg814j4MlcGrsWxhogUB3+sJMo4n1BOWIUnWgqSO0UExC3izqB/G1oX/OUtSRChL4EKLpGT4RSBS+xYn6dtRreR+PpbVLSbtuLt8KNC4/nYhc60hS8xT/vwqqKZzuCIxeiEp4XxMhGY4Q79JDMiCVvj2Wa22LjRQjsztsHkHfO3eBxOutDWcPN0+y9lsvn6bRWP5HTOAfxmKhFUA6IVrYMeh3VPTWnHPyIGY/iqKMvpt08DG1pVEwtvShtyzn+rNsGyWFNQ9fm4Yh2fjR71fmyUI+qB6NyOa3YuHn2t48fjiQE1cvadpJBu8SMyY1KkRptsjlKmxnkeaqSRijMxnMUb2b+ZKXGG2CoItq+cbPdSHHJRoLtzJgfdH8mLxQnc1wVi6Mzgn0QNnj7DL3GElY41HO9pudNqzSEENHTNdr+1oPa5Tv+0f/Yv43KbhAM7PbtLnH7A7LW0p6wmWRKIvLVDmLLx55bBeJSZlbFGjGv/yom8J3WF4jlW5mR8qUL7E9stX5Gvkf95YCnXIpnjXq4txiJmjd0nqLuKv/vy1ts5eHd2NS8yztTAJmdMLhyZreD1afiWcN7EnbPjtXmyhbB14297SGtW9lKyjM/0Jg9flcYPFWECdMDEy9/590tQATjZITbet6urwV7UZpX4Dour8k/IJ8Doa8TO6Vhawb/+XtVYe4R6cXHQY7/CsWISDWrq1d4qp4Pc0VB0V8V1u
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977d2971-32e4-40c6-f0c0-08dbaedd2cd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 13:28:36.6397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDtfxF6p24ebkDgmUaIOmhpLeTxvbN4SdgurXWxQCqkzt9+RRXV6IGVtODLyTd7BDbfBKsIObUeKeDASvlPgUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 08:56:08PM +0900, Damien Le Moal wrote:
> On 9/6/23 18:53, Szuying Chen wrote:
> > Cleared PxIS and PxIE with error recovery when ISR handle interface fat=
al.
> > Then a SDB FIS with ERR (set PxIS.TFES) is received
> > before PxCMD.ST is set to 0.
> > When error recovery was finish and PxCMD.ST is set to 1.
> > The HBA can't issue any new commands.
> > Because the PxIS.TFES bit is not cleared.
> > To avoid this,
> > we adds the function to clear pending interrupt before COMRESET.
> > It follows the AHCI 1.3.1 - section 6.2.2.2 specification.
> >=20
> > Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
>=20
> Fixes tag ?

The ata code has not been clearing PxIS after stopping the engine
(the AHCI spec states that PxIS should be cleared after stopping the
engine, and before issuing COMRESET), since the introduction of the
code that stops the  engine (when ahci was still living under drivers/scsi)=
.

If you really do want a fixes tag:
Fixes: e0bfd149973d ("[PATCH] ahci: stop engine during hard reset")


Kind regards,
Niklas=
