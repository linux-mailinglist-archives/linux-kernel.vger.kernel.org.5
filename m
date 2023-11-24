Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBF57F6E21
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344913AbjKXI26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKXI24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:28:56 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2128.outbound.protection.outlook.com [40.107.7.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64080D48;
        Fri, 24 Nov 2023 00:29:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdL7lF0QJc47lkb6jW7WOHVhFXgGptsRou1Z+uPQqQSsAc/ABbBa1ZzCZpbnYLLmSQAX4X/eKrdPlg62io0gXGK1xbz2YKAxTahjLPZAy0xySutGDicVq5tVfZqUzfVgl9Ng+2csEnnyepyN/RdrX4H4WqWEkl9284FkrS2scsyHB7KR/3J5E+ZRkdoqzQZZuvcVum9APMGrWpQA2YK7fHD0m7hOzxJVPoqB2hVymhE4OSUobBhVYn7mbZblWiZW9g9TnVybwMcPksBD7JSacD0cvn7V7DvX/Z8BP6Ppzt0d0Vy7emOCPiAF1qIls/mqpn+oud1e3ADrIjZckvtAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c74/hMJ+sbadKATYn6/JUfBQhoMdXFwiuOsGLUSfQJE=;
 b=H97PBnO/yV3i6EuL2xhLbZOAmngl0bcYQaPFxhXoSnlvVolDIC+ekl9uDDz5uClrA9woFGk/1EB4C5jg8icWiK95M9gOyAqdjIy1X99AGSmNCaQygZ7vjClLki6EC2HArL5XAmJY3eFDwVya7yV1eqMuX7VgJRD0Y6XaRTZZhBsXe+iodWtiWh3k5rE5DwQoZpnnkCJLajeHa6bhAieF8dg/CYPWJVyXR7qeKaMl3tEiPf1nO80tj79hWQ47v/YF7I1aAR5wL80p9AoItgQ/kPeQxItuEhvXSRm/UxvIR4oP5/vC5NyASAyfN37/bOPOWdTL0D35tFr5I+XbJZzRdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dektech.com.au; dmarc=pass action=none
 header.from=dektech.com.au; dkim=pass header.d=dektech.com.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dektech.com.au;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c74/hMJ+sbadKATYn6/JUfBQhoMdXFwiuOsGLUSfQJE=;
 b=O7dFYtEQFgHYFhm9NZIusMfvEjEZTd6m4/XWj/8z0dUEZ/sIZRLflCBmVwdjqe7gwmCoZlIUhTYFKlsdbiCWd+9AZEQ0E/qdjT0vmtPCE1+bVxiFmMFgtAPyONiMIBHf/Re+iXa3IWQsNeX9vNwi787+9WlRH23N0sV7MgZytjDPhV0VAFqupuRbTUTiBO7hPA7z6nT2undwXDkFj5Q0Zi/pbEBlSYpUM3bAFMn8ASuDeHuYKTWw/MpQknywYN1czeoapFRm46SeCedjPBJaiF0/ytpE6ld/Wbw1kbBETVlhKTMY0jSNHzYnJZkv6aON5tRfw9qdX1DGMBbYQEmTKQ==
Received: from DB9PR05MB9078.eurprd05.prod.outlook.com (2603:10a6:10:36a::7)
 by PAVPR05MB10448.eurprd05.prod.outlook.com (2603:10a6:102:2f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 08:28:56 +0000
Received: from DB9PR05MB9078.eurprd05.prod.outlook.com
 ([fe80::c9ed:567d:143e:af2b]) by DB9PR05MB9078.eurprd05.prod.outlook.com
 ([fe80::c9ed:567d:143e:af2b%5]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 08:28:56 +0000
From:   Tung Quang Nguyen <tung.q.nguyen@dektech.com.au>
To:     xu <xu.xin.sc@gmail.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "jmaloy@redhat.com" <jmaloy@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>,
        "yang.yang29@zte.com.cn" <yang.yang29@zte.com.cn>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>,
        "zhang.yunkai@zte.com.cn" <zhang.yunkai@zte.com.cn>
Subject: RE: [RFC PATCH] net/tipc: reduce tipc_node lock holding time in
 tipc_rcv
Thread-Topic: [RFC PATCH] net/tipc: reduce tipc_node lock holding time in
 tipc_rcv
Thread-Index: AQHaHbcmsQ7KURUzRkaicoeZO+zrDrCHRXnwgAAp2oCAAAQK0IABobQAgAAL9yA=
Date:   Fri, 24 Nov 2023 08:28:56 +0000
Message-ID: <DB9PR05MB9078FE84F8244C627FDCFA2888B8A@DB9PR05MB9078.eurprd05.prod.outlook.com>
References: <DB9PR05MB9078EEC976944CACEC531C1388B9A@DB9PR05MB9078.eurprd05.prod.outlook.com>
 <20231124073134.2043605-1-xu.xin16@zte.com.cn>
In-Reply-To: <20231124073134.2043605-1-xu.xin16@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dektech.com.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR05MB9078:EE_|PAVPR05MB10448:EE_
x-ms-office365-filtering-correlation-id: 2105a419-9c55-41ab-0b0d-08dbecc766a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uOluW3FJBMxsnp7Ln/q93RtzDS4ZUHZkxhDOk1jMScNCjdIc4RYcELhpxuujxOHhlGAMcxLHckpL7zPuW35zjqYN9UTY52Qtfq54OvrKVLCks1ouL6OTU2kkcpUf1D11Kgi1HIZSpdRtG9C/xQy3xkQwLBkW0Dor7LkWQJ2RoBVI0XWFYuSLFyhe67XjF8q0Xod1JWFH9S3j0HLPz6de/KVnBXEVFCEt6y9wiDHKssrmwBH1CZ/eP62innYYc356XWDRfgJuysa9+lQd9lgBY1/j/G61kQC8+P6yVE08dJkBw48H3Eo9y/Tdi4jb8PsPoTJL+LIM7EJr8qLtMkSdRGGYeraYaVV8/GtvPT5q1kb9qrKfEGBZQADm2C7sIcCxVUZmDsNdeZvYQxwlY27sqlWBnmRylh8zkgzCxnBvbjg17m8p9XiHzwHSIljrDsKG6JD+SkGqMhPRD2IQ880TDPlsxTwY/yXB8Kty/0TcdKZ/WIfEbOgLFjEUTcQleort0wmuZ0A2VzrlMInzPe0aj6+CeHJSFRlLl5scvThWqgnk5Bifmkd9VExKT6gdJZpUmdBDTkfQeVjR7JhaJZyPJEvQmOt8xN60A/MV1d18B3OuXXtEjMf2RLb1fLT5dmXl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR05MB9078.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39840400004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38070700009)(478600001)(38100700002)(55016003)(9686003)(71200400001)(6506007)(7696005)(8936002)(52536014)(8676002)(122000001)(4326008)(54906003)(316002)(66946007)(66556008)(66446008)(76116006)(64756008)(6916009)(66476007)(26005)(83380400001)(41300700001)(33656002)(86362001)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?scB+IHF2U5YlBF/9AetdJQ13JD9TgB++W/rdSCeHj6/vT3Zq0C1L3cDCWv+5?=
 =?us-ascii?Q?SkcSuZxoOgRMZxcfFqFa289emLjZHB5VNEq9pnMigaHE2/JIjKWBUU8F+emJ?=
 =?us-ascii?Q?9pH/uhPAIWZH0DRUI5219HkWfwAMRZq5NUFIm/2pIDfJvNFCfoeQbSEt4ZzG?=
 =?us-ascii?Q?dwcm63Kjd3tR09UzRTTO6zR3eA5oDDnwgw2l7eMiVTNp1RYEbSTd8f5ZipEe?=
 =?us-ascii?Q?2hieX+LN6POWmJhKvlvt6WBijHOjCczA7CMG08BHyzAeBrvZFBkejzYKNh/H?=
 =?us-ascii?Q?9v7FOqhS9YIKByT6dm0gU/IBbMK/SdDUR16NhHmDSYfO+Ze1JOJFctywHaeY?=
 =?us-ascii?Q?BJ5MLcEnr05RRfbWCWsbpKaOSWvo5Y/L/CWPsbZHr8Hc+1xGhPSlM92K5RA9?=
 =?us-ascii?Q?Y8Cc/vZmmJPk5gPOK/EVz7jilIhwfpMkdqgPHtN6f2tUn6FGj74bC8iQqxRY?=
 =?us-ascii?Q?YtDz9c/z5S2UEOYHf7ugNIBfYMy6oc/14B3V73KWHj7HNc6EyJtiVEXsugO/?=
 =?us-ascii?Q?UfU3RK6rYaB87rr/AN+7fyA1Xcxa6MC2+YbF3rc0ycc2/K1I4OA6/ZhjQwi9?=
 =?us-ascii?Q?3pvGl26PxDd1cfwQifAMaGcPOIlJCyUvZ+ZELMqU9biV+Pbx/fP0ge7b4T+2?=
 =?us-ascii?Q?KPmvBEk7qRN93orw7WCJrEoEgLnmaK7WdCmCHH7qqKJBbHJFhNsOxL2GLAhR?=
 =?us-ascii?Q?3/Jjkjuv7nLNEUv4UJa1vG2XetewBcCqwdGSTQjPsxRD84dFit/HwX0GZ2wt?=
 =?us-ascii?Q?+f0ZtRjSS/I0x6PUrIAa0rTvXgFcHjuftdI9LwWJ06ovPfTuaJlf+MPObh3i?=
 =?us-ascii?Q?5kCNdCUDEiI/0V5jX+Z7M+W8nXx7T7VBjvUjoO05iHTcKTWmExYT5LjUz1Ii?=
 =?us-ascii?Q?kqB4LwuwQpmIdQf6oTI3pE4hQlqQ+/Hhpz3q9d9Upu8eIW2EiQwiUSCFIbDZ?=
 =?us-ascii?Q?CI+Bnr7P2lBgnJFVenRI2HOYxf75sbU9IEH2T8p0Ebclh8CZp4RH1L3D/hwe?=
 =?us-ascii?Q?YG1qESiZy5ULYzvjdBKVlcmsM5xHrNcVcIlk7gKqthSOKSPvrSpXVFTaNFdC?=
 =?us-ascii?Q?BP9vsmedn0ZIHCRnzTNxqJdqEho6Ud7GbHvw6B1bKbylKVRW5qL0k69KUP+U?=
 =?us-ascii?Q?bgRel840liyKn6x8qEyEq7WutGrXVEjEzPoxQd1eSmIhV8/g3rFLEpFYXFYM?=
 =?us-ascii?Q?gKBZFU3n0q+adEiK35vQVD7Y0xTfKwZ+bDFdSi+KxxUNpNN4qkywcrqaBCUB?=
 =?us-ascii?Q?6EETAhGPhxcn4MP/64vN0sN6YZi8/D6hz6sYszJgT5UCuBwG/c442p42wtJe?=
 =?us-ascii?Q?BAO554TJZmFcHp59S8E1FSW/DrpMMjVKJkR5Aa/AUyYp/QVTw8AjOFhjfk2u?=
 =?us-ascii?Q?les/Wti4Y7XvJ70o0rJm5UZ/ckx8PXD43X03tmMN//Ju5EdZj0bV5yH+dQ1X?=
 =?us-ascii?Q?b6TC5N2P16vMVyuB42CI/iS01u8X1fw90jpXgBNUNO8F9uaX5SMen66GflQo?=
 =?us-ascii?Q?D9sFaxWCsWWTcugxmXdCndNHzDzhuEwKnoCcUZVSFp1hNZodeiLMQ/uitO7U?=
 =?us-ascii?Q?BjY+gmFF8dCu+Q7745u8fRd8elIOHNZLLeraabse265TPDdARgTF2keoQKrN?=
 =?us-ascii?Q?hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dektech.com.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR05MB9078.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2105a419-9c55-41ab-0b0d-08dbecc766a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 08:28:56.7117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1957ea50-0dd8-4360-8db0-c9530df996b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ho5WAH3nCSuR8rRCv29TQrJRPlmnZFR66gJNqfdXJnbjmzjZQXevtBHf/gBEDGuUn73ECEMeYlL/BS4PG+OoJyCUPveS/6pxrumjGdIRd4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR05MB10448
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Could we please solve the problem mentioned above by adding spinlock(&le->=
lock)?
>

No, you cannot do that. As I said before, the link status (including l->sta=
te) needs to be protected by node lock.
What I showed you were just 2 use cases (link reset/delete). There are more=
 use cases (netlink, transmit path etc) that need proper locks.

>For example:
>
>(BTW, I have tested it, with this change, enabling RPS based on tipc port =
can improve 25% of general throughput)
>
>diff --git a/net/tipc/node.c b/net/tipc/node.c index 3105abe97bb9..470c272=
d798e 100644
>--- a/net/tipc/node.c
>+++ b/net/tipc/node.c
>@@ -1079,12 +1079,16 @@ static void tipc_node_link_down(struct tipc_node *=
n, int bearer_id, bool delete)
>                __tipc_node_link_down(n, &bearer_id, &xmitq, &maddr);
>        } else {
>                /* Defuse pending tipc_node_link_up() */
>+               spin_lock_bh(&le->lock);
>                tipc_link_reset(l);
>+               spin_unlock_bh(&le->lock);
>                tipc_link_fsm_evt(l, LINK_RESET_EVT);
>        }
>        if (delete) {
>+               spin_lock_bh(&le->lock);
>                kfree(l);
>                le->link =3D NULL;
>+               spin_unlock_bh(&le->lock);
>                n->link_cnt--;
>        }
>        trace_tipc_node_link_down(n, true, "node link down or deleted!"); =
@@ -2154,14 +2158,15 @@ void tipc_rcv(struct net *net,
>struct sk_buff *skb, struct tipc_bearer *b)
>        /* Receive packet directly if conditions permit */
>        tipc_node_read_lock(n);
>        if (likely((n->state =3D=3D SELF_UP_PEER_UP) && (usr !=3D TUNNEL_P=
ROTOCOL))) {
>+               tipc_node_read_unlock(n);
>                spin_lock_bh(&le->lock);
>                if (le->link) {
>                        rc =3D tipc_link_rcv(le->link, skb, &xmitq);
>                        skb =3D NULL;
>                }
>                spin_unlock_bh(&le->lock);
>-       }
>-       tipc_node_read_unlock(n);
>+       } else
>+               tipc_node_read_unlock(n);
>
>        /* Check/update node state before receiving */
>        if (unlikely(skb)) {
>@@ -2169,12 +2174,13 @@ void tipc_rcv(struct net *net, struct sk_buff *skb=
, struct tipc_bearer *b)
>                        goto out_node_put;
>                tipc_node_write_lock(n);
>                if (tipc_node_check_state(n, skb, bearer_id, &xmitq)) {
>+                       tipc_node_write_unlock(n);
>                        if (le->link) {
>                                rc =3D tipc_link_rcv(le->link, skb, &xmitq=
);
>                                skb =3D NULL;
>                        }
>-               }
>-               tipc_node_write_unlock(n);
>+               } else
>+                       tipc_node_write_unlock(n);
>        }
>
>        if (unlikely(rc & TIPC_LINK_UP_EVT))

