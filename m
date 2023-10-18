Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2D87CD461
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344505AbjJRGWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjJRGWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:22:22 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2138.outbound.protection.outlook.com [40.107.247.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A20A172E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:18:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5xcxHHfAu1ImODd7dp1NF7qHHUEdXnUPtO6iIIzWlVy86xgReBH9h03GRRAg6zCFfDYacGcagW/oaZU7EbAWCBSifa4QTU0TLVTYorjJUoAPc41xk3pUTt2vdaAZn0EyIPwBD8VVtAZcQY16lm0PS9YQ6coJLRdqtB3tBR1FKXktgsOXLKxRIOFcjY3xpzyMtU7kLLQeZpHrZCUjDKehPF5JmUr98NmY4P71J9VjHIvSXeglDP54df60NUbP2r+IzdGsZnhXrHWidgldpF2lR24aK9W+hh6XeqlgG0B4CuPouHJujJHZpGJtYywBdXwLnUjye7RHN8hfSc7ILkGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEXvP4xHhim2iaQkAOSIeX7Q+tGhN4Ujx928NCyLcus=;
 b=dsq/r/uJRRJeqEy4ocvOUwHEKq5SWhUqEaVMXl4AqiQEInOMXDT2nj3llaeNu2vFMna0JsdpJl8de3nGWClXuKASHFJtXInRr32V3qANbxUv3pldGY9ZmzID0nJxWo7jikJgH6r+gmgjHfEz6tsyMBUmWqoManr72ptzKLAn+EtfGbk8m/NAsNy5kAW3Gb5RNaJR5uHrfefIDLVyIEZFOxv5Y4r+gLcYKHwKK8gFCRT87jtLpC1rrPDlkksXjs1KR01oSo6ywhRaV8yRXrV594NfdMfhXd9lNEzpl44CFb1/+ZZEjNt/UFPuRKea4rpk6FSxl+wV3Tty2FJXto8EOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keba.com; dmarc=pass action=none header.from=keba.com;
 dkim=pass header.d=keba.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keba.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEXvP4xHhim2iaQkAOSIeX7Q+tGhN4Ujx928NCyLcus=;
 b=a3FjzUeNPCRV654rwca+rHmp9efDIwRgbyqK1fkY/xkCX/DroZ8BgZcPXMQBUcG+TjPVCdDJGDXeVPIy43bmstWhw/AjUSv+wFF5bVl35QGbSTnNCxAUqYFku4HLFoAKVwptQmixLFYLF6eR7lV8bPkstn8UtJv2WcJL9HWQy60NRm2HxeBUisNYoSE/RgmM9I/4Un4ZrTIRNOVFIu5dyUpIGWBzzbyg72eAxFOt0p9ybb0+osI/nLCv6cEhemmaguQPgWoK/QKWx8ST78zy7ai9OenpDESayP19a/zAAoepY8VyUBNjURP82hacvmg7qkszUXvH3O5JkP5R+bTzXQ==
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com (2603:10a6:803:7::19)
 by AS2PR07MB9431.eurprd07.prod.outlook.com (2603:10a6:20b:643::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 06:18:06 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::e3f1:1f82:2831:a70e]) by VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::e3f1:1f82:2831:a70e%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 06:18:05 +0000
From:   gus Gusenleitner Klaus <gus@keba.com>
To:     lkml <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        gus Gusenleitner Klaus <gus@keba.com>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] amd64: Fix csum_partial_copy_generic()
Thread-Topic: [PATCH] amd64: Fix csum_partial_copy_generic()
Thread-Index: AdoBilvmES7GiG9dTkSxSspB8XHmAg==
Date:   Wed, 18 Oct 2023 06:18:05 +0000
Message-ID: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_ActionId=c8be42d7-c5b3-4ef7-84ec-33fddaee7927;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_ContentBits=0;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_Enabled=true;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_Method=Standard;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_Name=Confidential;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_SetDate=2023-10-18T06:13:34Z;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_SiteId=83e2508b-c1e1-4014-8ab1-e34a653fca88;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=keba.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR0702MB3840:EE_|AS2PR07MB9431:EE_
x-ms-office365-filtering-correlation-id: c7c0f8e6-66c4-4751-ca12-08dbcfa1fdbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yhkWhgGVYdmYMzp1OGXqQ6Px4AqyfpbGGMd1YLewOiRDb8HpHj4DKF7prb8oBl7wBL625RWrmJjLdfsvpWVvAInPDhCVrCl7TJOAUHoktzab8YFuv3ttOr5uerfHoRVnhcJaFKe0/X5I7IBsl3/0SzKaNt5YiW9MEioWhiWB+8FbT+mMLu4R1y9xQuLPAM0nSxbtFMGQkZ17zypoUiyIt7Tesmzgni2kNwfKQWAScvT4cFJD59CHLV8EXp/ddsAiqtK4tjDRyxlVr2GRMS3GfhtX1X07MKH1CXPPcIvX7rEV75gs1niVH2jGPpX0q56t1CD2uDHLJFVSzZk5djYvyNTy7ZIpFYfHRj8615g4MR97qkdey06uH30BfLLbDKqSD2WmgU6IjTX6dEAScnK7VcnBT6cpcuNngedEm7l7mSLmbqZy0R69PlrZ0i+PvTWfDGT0JSZ05reB5fX6tT44LfwOnskL3rXdMPn/Ddcr7rfYNAgDDJGan4Ax6HFYy9RH9R5j0VBWpUAWH+CtO8teYIxpxWU1WzY433IIwK3JD9q9PMYIchozpOsku9SqESDUF/iiVjFTn92G34gU208pI81XziE576E2CQzJwKy7l7OH6rf1K4/ka6m8UjrJEe/kb0p7yj+gxeSlwMNakaKPOvq67qFzQWo4yVNSfFecCewxNH3rxrkFlP0xpzCTwTEP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0702MB3840.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(7416002)(4744005)(86362001)(41300700001)(2906002)(478600001)(64756008)(54906003)(66446008)(76116006)(66476007)(66556008)(66946007)(9686003)(6916009)(6506007)(7696005)(316002)(38070700005)(8936002)(8676002)(52536014)(55016003)(26005)(83380400001)(122000001)(4326008)(71200400001)(33656002)(38100700002)(5660300002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/0IoEwErSu0R/J6imDjUHd3r6Pa3C4v7CcJmhhzuFT6vyvTwS/tINc2PVy0n?=
 =?us-ascii?Q?S6bOYl5uK3tIdKwpfbr9rkX55+fFmb75VKjqR042l6qmccrpqE2CJaI8Itsx?=
 =?us-ascii?Q?uEsI/6YxcCRnQLki6zuh+nLFDvCpFyAmLERQ9VvlrBZnh8HykjSVaIhhnElD?=
 =?us-ascii?Q?C32zEvBrzWnkdcuJcWa7Nk5lwrgtJVAvl/psiIMzgNO9sFW+g2Tj/7z1o8lg?=
 =?us-ascii?Q?nN9YGrbpCwHKYuEVnSww5NeJirEwk4T+n2ig7a20qkc+SV4+GA8LQ5nbgOTs?=
 =?us-ascii?Q?h+J22/IANxsmxz9rgM86V9xaNdXU5oKMApgzgR514lechILeRGIN1vIIIHiV?=
 =?us-ascii?Q?6GvoAvMu3M2xktXORQ4CCNYJ1xeZd5eYsE58+iUte2Dh4zQznjkubSzRek3a?=
 =?us-ascii?Q?zVFo56qR83XAfCXc3DeyH1MtmOIShrnubD/lAfBDRaKfGmgVJo3qcp7hbS5+?=
 =?us-ascii?Q?ErVqyW3QDbYcqdqFADjmo7EVXF0yLDhQ9ToQAxYNrKTXot4as+ihsL61aK0m?=
 =?us-ascii?Q?yYBpncHpUC91BWN88vrf0X2BTJn5wiQDpkyGSt+S0gpidresXNZDfxbGFbIo?=
 =?us-ascii?Q?ouA8OY4F5Z459yJLKDvbj1bXvvngQLYOOFUq93IpR4JMJQ09FOUr7/RwyPL/?=
 =?us-ascii?Q?etmCkvpW1H+tNWVLl3fTtW7Ehf6OyZtSKEDV9Jc6cpk4FQAy6hGKNCWqHIRn?=
 =?us-ascii?Q?C04bUVrcHAUVVJdkeK+fEhUbZmtUuS3fLN14QM4uUZqwztwjNbxFI1ZUtCjr?=
 =?us-ascii?Q?bdfqXI3CG/W69eJ9MSyDNGNSHghHBEDu4mMTT8wFpntoTrwDS4LW9X/OELLy?=
 =?us-ascii?Q?BUUJodvm71JG40OVRjiAJWZist0o60rqvz9utEdZTsQ6K/n75n8X+WaS56xB?=
 =?us-ascii?Q?FF+qEkzz9L1N4Wy4VMVWFbPA6THYeDl6xkv5mcxcMohtRDfKnBl5YfiQXqUd?=
 =?us-ascii?Q?cgKyQP0tMLWDv+yzEQeEh+5IQJbAjDpuJKw6oMp+6rSje5QSWavACiEbKTKx?=
 =?us-ascii?Q?qXV7JXUDFhzKQfz4Qem9VEZ6XoisCukLyPtIlBoNM7tRpF33KB0Awas3T+0D?=
 =?us-ascii?Q?Z8/i4DrYaE/Gv4TFfE0BNSfxjnxbTMvLV4sA9Any+mHCLiPQss8SPXHnJGJx?=
 =?us-ascii?Q?dP1KGx2v1uZ0XM2zqDbugLngc2dD2Xc7AAEZE8f28r5VL9pKTHskss81KCW3?=
 =?us-ascii?Q?MXklRR13qEQd2ujk6bsj5lN7CkYgYZ3xLYz67iLn5piliTvJTSZTafvLg6nt?=
 =?us-ascii?Q?uJyCBC0jZyuMOYyM1wH6jjukdOCeKzGYQbF3XbO9VC0Ur87HvVmRiS9/W1tf?=
 =?us-ascii?Q?9pXr35VK2VXRA+TlqIqjuiQMYYTd4nPT6fm9Lnw4akG0bmU1i0v8toX3YCcD?=
 =?us-ascii?Q?6o0YJ7BUheSOs0Eq8QNOJ5MSXzykcD1X+LL1y4lSqMc4abo3fqU43TyrGDES?=
 =?us-ascii?Q?DCCm1ZjjSwgHfXjiVkJHKm1Yhv10WxD8IMfMQVH7aQhncdv1Aqze2D0nJ5i9?=
 =?us-ascii?Q?mJYJvqCs7+vVu77vb5jKJDSRtVLPetbgR2TvC7k+QzLQBd8bV4YTk5TUMrMp?=
 =?us-ascii?Q?MGGG6Xmi6ptFWDMvbSM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: keba.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0702MB3840.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c0f8e6-66c4-4751-ca12-08dbcfa1fdbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 06:18:05.6394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 83e2508b-c1e1-4014-8ab1-e34a653fca88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGpF+ya80BCaPdzWLsR4vq3UWm+FaGZ/dcozyJEUX7PNqZv67UIu5JyUv7PRQ1bS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checksum calculation is wrong in case of an source buffer
containing zero bytes only. The expected return value is 0, the
actual return value is 0xfffffff.

This problem occurs when a ICMP echo reply is sent that has set
zero identifier, sequence number and data.

Signed-off-by: Klaus Gusenleitner <gus@keba.com>
---
 arch/x86/lib/csum-copy_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/csum-copy_64.S b/arch/x86/lib/csum-copy_64.S
index d9e16a2cf285..c8391b4f3dea 100644
--- a/arch/x86/lib/csum-copy_64.S
+++ b/arch/x86/lib/csum-copy_64.S
@@ -44,7 +44,7 @@ SYM_FUNC_START(csum_partial_copy_generic)
        movq  %r13, 3*8(%rsp)
        movq  %r15, 4*8(%rsp)

-       movl  $-1, %eax
+       movl  $0, %eax
        xorl  %r9d, %r9d
        movl  %edx, %ecx
        cmpl  $8, %ecx
--
2.30.2

