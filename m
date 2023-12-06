Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBFD8078C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442803AbjLFTjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379274AbjLFTjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:39:13 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AC590;
        Wed,  6 Dec 2023 11:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701891560; x=1733427560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GggbmtoLEqMkUjfaGdVLANg/yuDXt26GUayQbwRKTvo=;
  b=VtEQs+qSmZWEHcge3SY0Bv3Q6e6qCfmc4HmBrKNFA8KWyRV7e9ACkEXc
   /xeDurzF/KArhWxGpxdiQAV9/AJAOVX8jIFTubElUjzi65maGBTi6ohVS
   dxdyd7Sqa4sX86VkJByZHXXcQemYIvOCoHgtoZxnFHWA4WtipxsT+C7bc
   Q9v9fByDLoikvZJcKkLDI2NZdjoTG7kDz3J0Mv8ij9fK4vJALRWWYKB6t
   Rg0tg99degUQW3moxQhva8Wri5ykvfG/FUcn7ZHhAErLTAVQLfixcBfZL
   xBKqNP1qZHtDCWzaDon/70Ttnwnrj48LolCL4MMmXAAr4Sq7rbn102IH9
   A==;
X-CSE-ConnectionGUID: KVP9vlNuSLyowSRmxwqRVQ==
X-CSE-MsgGUID: BhkHt8JOTce/4zzlfz8ZlA==
X-IronPort-AV: E=Sophos;i="6.04,256,1695657600"; 
   d="scan'208";a="4156035"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2023 03:39:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ0IEj4ZHBtp3ik8I9wkzgdFj1z7TuPFCZYfeenOL7FMbHbySoPKgihbtNfOajkfFTLWyanhmoBrOYB8S/xf3AeBHIQPyRh8F4yQdGO0suBno/qsUXigfDes7vOtzuypet/zSOUT8tXQVunv7G+iIQ60xKcvMyrLfX+GOvahYUR3X2kshwJ5KM7MFCXKFjLe8AZw1II89Uz+WqpDQc0euBueHb6W0rfxR5zCdPnzqAlj98Te8X6JHcKU+du4feQXOltXHa0ReSTiOBgJCZ4BmYwtjscfwSdkjgiuYDj7ynE214c5eQFBOqhe/GoXBzgViadNZh+mLadQxZudDylQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GggbmtoLEqMkUjfaGdVLANg/yuDXt26GUayQbwRKTvo=;
 b=Qv+9uiSuWNMgtJ2NLNx0DINYf/5orJhSTad3+LnY4F1vnEaun93RqHyTCV3ZhcoB/OEPGYjzuqkN9HDRlvbCdv9dxZrjxktlM5GJr8SJ94VBkEzmfsl+KpSzI516Az6quZuya9VT5Uf6H/bl8452CWeL+w8j2vdxeqlrz4IXfk7tv7ox+b4/GO/WlFRIEIQzNbFF1tdRb/eqFWM4EDPpHLtQjcspB+jKE5n/13+4CucU1r6tqqRS/IgifFxIEJdvQ+oytwYj9woq/sn4nL1f6aeUOk+tjHWHlZnb+UFpMnJFCo3+u+uGjptUbTe9ffkU5jHNGDxl0zXqcFs2jrVZUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GggbmtoLEqMkUjfaGdVLANg/yuDXt26GUayQbwRKTvo=;
 b=BYcAxwkb9BOOmnJA1mHsQKpUgrJvClOpyGd7p7HRpLX9el/lKWP/QSGTMbdgcthgxFrxL+esThMxZHqjlq4VGryF9/wNfIhKYQeKisWDU0mVoQQbP25WYkzfSwDZ6ms7CxLiWVSr3WAqhXRaPvHQ8iWnf5Te4lXtluVcaNZyv0Y=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MW4PR04MB7140.namprd04.prod.outlook.com (2603:10b6:303:7e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Wed, 6 Dec 2023 19:39:15 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4%6]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 19:39:15 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "thomas@t-8ch.de" <thomas@t-8ch.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mikebi@micron.com" <mikebi@micron.com>,
        "lporzio@micron.com" <lporzio@micron.com>
Subject: RE: [PATCH v3 3/3] scsi: ufs: core: Add sysfs node for UFS RTC update
Thread-Topic: [PATCH v3 3/3] scsi: ufs: core: Add sysfs node for UFS RTC
 update
Thread-Index: AQHaJTkJH+jmmEeQa0a4vN35DJxiy7CcrSjQ
Date:   Wed, 6 Dec 2023 19:39:15 +0000
Message-ID: <DM6PR04MB6575C19C0AA40BE1AD3B8F29FC84A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231202160227.766529-1-beanhuo@iokpp.de>
 <20231202160227.766529-4-beanhuo@iokpp.de>
In-Reply-To: <20231202160227.766529-4-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MW4PR04MB7140:EE_
x-ms-office365-filtering-correlation-id: a1973f21-cd92-4e3c-517e-08dbf69307cd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wv5wJREF4XEtLTzPrqx2CGdF7TodwiDmHae4l/mNrIwuAvtKQ0PhVgXc7klET3ry8O1QokwYIjnuCbqtjhgKFx1v1q66T1BhUtYZ8c2aVOjoI++ldKV4AqHywoLVLKkLT/Rn+MIlv/e1O+Zeo8oxxw+alRLoN4EXP4l5oIXZ+iV7W4HNI/kLykiS1Igp6p9wMd3EOso92t7NeTIXjmD7rl15EQEPHdM6CfUnmnjv7KK3J6/Hl+VyaiTeVGgQqM5GQQNGgoI1Dkl3amqvXjwsukMNyq9Ca99dZORI9Jw0HpjeHJTgnCNfRA4Zg2gejulg7nA7XMjgJ2AtitpZ+U8PIKmoz4FhFwD17aqlGykhNdjeoMStFgUG22C60/1B9vP6WxXTpTrDmny5afkBPfYkSq0zOX2J3k7KIKHhdDpVauI+sVG6Af9vLPrF8iOqUQmtca47Y0yynp05dP4neGd+0DNrXrK1K/a7y1RmCPcJxNWx9RUIOag+ftU9bQDhhLkgh63BpDCkosao2rY4RnNPgD5/N6AWZUCEm+W8nLCL2EcJx3uDVkNHBaUDLuuKt3xkKh/87BZnVoS6XO17Wt86FG+orOdAQ7me0OEOWJcje1p0BMmWwZJHcMxiULv05/3r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(9686003)(82960400001)(26005)(38100700002)(83380400001)(6506007)(7696005)(122000001)(55016003)(478600001)(71200400001)(76116006)(66946007)(66476007)(66556008)(66446008)(64756008)(54906003)(110136005)(316002)(8676002)(8936002)(4326008)(33656002)(2906002)(921008)(41300700001)(38070700009)(52536014)(86362001)(7416002)(5660300002)(15650500001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wizpgqWQVCrdZd4gZxGjl7DbRFs12Jya+om+vSTEwkXAL7KHjjPbWqtIky2R?=
 =?us-ascii?Q?D9zGWF63I0ja926JOAMpefGckuPnm5+96Dl13HQ+YLA9GLJwgcRG3JobOL+2?=
 =?us-ascii?Q?WyhYP/icW0iOSJt3CnbiFf5Q3ByKxl1u9Y2DtqSFiu7VnLa9c5OhKiz+yekN?=
 =?us-ascii?Q?Y8Lc4fwStFTSw8hefyceHn9tm6251JndLM8GFUQTlv4/poyyDuHvJcaYirOI?=
 =?us-ascii?Q?Tzdr7/8CX8+l+KFQIpmJWNjtgFikD59MDb7PIiLJAI2t76fo2OBtZ2Sarwa0?=
 =?us-ascii?Q?5IBxAiyjLvsOJzvqxcAU81iz7akQP1e3+CklxeCOqFgTxPvl8coIEs44RJPS?=
 =?us-ascii?Q?q35J+YRoO+xx3m7EuxgYkWPgMPeSlZM0+5rJL/gjxQg24Pq5fteN/vApD2df?=
 =?us-ascii?Q?SZpj1GzDr/nk0bk42O7IR2wmx2xFIkQhvBzjv0YJ25fLos1psczr/XuVcBxd?=
 =?us-ascii?Q?jpL+40A7vaEGO3rrNM07GX+QL01l3RaRzwji6ScTpP5U+dA9CsLAdy95wUcq?=
 =?us-ascii?Q?X/RADprD6q1U3IBf0pm2UuJ8cyMty3KbT46hm5al/3ZuQISBtBc86zTpLgji?=
 =?us-ascii?Q?XAykgBvWFNOGn1z5uoMroC/Vs5jrYB+eTBEqkfm1aTfPf3CoYe68tZjBOYTJ?=
 =?us-ascii?Q?wl6GpZQ2GIg62BfsN/TbKWTPvQpddz4f1VOASu5vyApvszHUkVqZ1sHtDVbb?=
 =?us-ascii?Q?ca/RPg5E38gS9HsoGkv4rRZ+sEokuu/Th8QFVp40ojBVydwwN7naax/b2pAf?=
 =?us-ascii?Q?XyrR8SNL0tKr1NLmFSDw8RUoDZ3y2lAmB3aHFYYRpbCa9iXwBQXWtVP+NBbj?=
 =?us-ascii?Q?UKkoSp5TG+9Ajy+v9AIVDILfAsSmd6jMjH8/SwT9nejtfJsqlFzg6eWBz3FT?=
 =?us-ascii?Q?NSk0CcOjP0tYRcZMVNVUefz+vSKlg8pDJvK3whNXAcHWwvEl3DpRdp0q63Ht?=
 =?us-ascii?Q?shI36iksOzQBkwawfS1JYQiYs9OWLEkba45fwICZJ5ph0wxXyLIIVPlI8W+b?=
 =?us-ascii?Q?LgYvEhEvsr+U2G0l1v/935iQ80NFEMQN8e30LDLhpMUp+CF7LbSz/taCejpp?=
 =?us-ascii?Q?v2LQ7iPyNlDXlhrg3TTC32jhIxE2vj89B3T2/j71ml72iPH026KUgU4I4n7A?=
 =?us-ascii?Q?WoUaS3tud92NS/ivAmLU76tkzPXvkqOMAh9fbH6Eu2lo4ilZBpQBo5P1ehAp?=
 =?us-ascii?Q?MuBClJUD0aZfhGGObfVvjRGh9nLyFS8cGLG3bqzJn8paviJeF1syZ/ztu5Cr?=
 =?us-ascii?Q?vCGe0HgA60txcAsU+MBTfHRvapWYWEV0wyD3iLSJ41Ju6Gm8Af4COVwn0MmC?=
 =?us-ascii?Q?Cm5XB6DziHcIRarZr6AW+Lw073Q9ndUPJYg3exK+Nv8kfyWvURCx8/6ze/0a?=
 =?us-ascii?Q?G0hOlyw7+96Oqfhpx3R033m8I3go3yeOVc61mxD2hru1O6l18IfQnVRZJ0D9?=
 =?us-ascii?Q?HrG625942NtExOXcCu8WA3jqvt3OTRzYMxciacJpIRIh9S4fD7D00dGlMS5G?=
 =?us-ascii?Q?XlswSrEJRg+VcJUOUryHMo8iB8bu2XxBKbShx3oxTANCQ9MNEu1rM8GkknY/?=
 =?us-ascii?Q?BScZBSV3mCK5id9ltAfFgJAMMEl2y5etwrmCm8oI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?aOkZ9Czv1u6rhDwrG2gmLWHWbd0xRaJgbrk6/F75xSgsQBXGJr8EvCmG62Yg?=
 =?us-ascii?Q?H4CQOs422nRFw2mizON8RHO0yGHrb9kkQwgiZEZwJd8rgNcA2xfBRVnOdThb?=
 =?us-ascii?Q?EJQZfQI55IDh4JoJ92aAaJOhrdnlRLtbzuJ2UDa0/qaJKZNxPOH05MFq7Eqf?=
 =?us-ascii?Q?U5qqofUCPMOEnrPsirM9K4AQeR9mALFaD0LRMSLJI/WxCZOyGnBOfNLJsn9T?=
 =?us-ascii?Q?SMxTK2XkfdRp1uBAiTBpt19wb/E1xjPpC11CQJggU8Lw2KuhJtbcukzo7E7U?=
 =?us-ascii?Q?GQN8CypgnJGdTSyXizBiie0aSrrLmJeb9XkR/nCVRubf7SbYROP9ojamY4fd?=
 =?us-ascii?Q?y0Wqe7Rg0gC8CGMvplIB68LcDWDRFCbEn2ClLnlPLIqVAoCvWQ716lZqVqoL?=
 =?us-ascii?Q?Bn7Ro+K8OPa3jm2hTLEwS+mdNfYeY1OQH+dRKfY8li8KTqs2hMtLDvZRuk71?=
 =?us-ascii?Q?G+cgTGP+Zs+dbw386w/sWaG1MM7lIsfftVhX7HPVBZApUQdrva90DsNxp+pg?=
 =?us-ascii?Q?KtPcR/HJ/ZlO7wLAu6wA4Q0BdEXV9ECCmzuPuuP//eoa3YWN17J1vOlPx70i?=
 =?us-ascii?Q?LCONiXSpqPtAoiKUd0tr59V8GOzwSGSkE3pkQt8daSDB7PSTZsb3f2/PhHos?=
 =?us-ascii?Q?mpRPFiWO21+OciX5AweCXEN5s6z25pI+ENfIfnu86Kb1Q+yq0mpWp9t+8sgz?=
 =?us-ascii?Q?6tncJHy23Te4a9vUK+PooCdsV13wbDFLWcO/PXqyMy6D6VyVx67dkLN8hH/Y?=
 =?us-ascii?Q?7/HixM5g+Q2Hxx8wpFZ1GKiV0CPkbQupKLEbvydA5tdh94me6Jb1AX+He2JM?=
 =?us-ascii?Q?dGfV8Y2phwVQTUhvv4GU8hzMmXds41AQDt6b002WmVBKNDEFHxmsJ7B/MMw3?=
 =?us-ascii?Q?IomP7BQf06WiBHRqtT0q9L+cHoCAJG8w2FIS+rPT0v1LigwRltiw/SP/zWXn?=
 =?us-ascii?Q?NklJv2ndCBHFfjBbevJ+8OjkcPMJAmyjErhmHWU/ARpOeyLv1ppjmjMXJd6I?=
 =?us-ascii?Q?AAA6nRrEQTB8623fQgzZ9WTeZd3mfznvETxt6S6AN2Xn2Kw=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1973f21-cd92-4e3c-517e-08dbf69307cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 19:39:15.4436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/wGX7c2675+oQ5G1BR85nsdeWNaFfVC2IG/vpclh+m+tbxoC2VTuGjorQtzIUtvYftmMQ6v/oBPQk13mN4c6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7140
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Bean Huo <beanhuo@micron.com>
>=20
> Introduce a sysfs node named 'rtc_update_ms' within the kernel, enabling
> user to adjust the RTC periodic update frequency to suit the specific
> requirements of the system and UFS. Also, this patch allows the user to
> disable/enable periodic update RTC in the UFS idle time.
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>
Acked-by: Avri Altman <avri.altman@wdc.com>
