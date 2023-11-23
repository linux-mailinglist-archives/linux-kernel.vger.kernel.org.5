Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F255D7F58A7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjKWGyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKWGyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:54:09 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2131.outbound.protection.outlook.com [40.107.20.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FB7B0;
        Wed, 22 Nov 2023 22:54:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0v+ve5CWbl7sEoF/M2AE5s2kCJTH1Z0IDdewUihAI8mty2HCpBuurQ7HIU6ZtdrC9xX9G39y0iWrJf6hBY/BEEO9UvY/Zc+OLtlCZ8/n76pvSbWBdunlsdgFnxcHm6Gl5IUlwrBdW4lHxvFAsMojtK2XqhsKhm8LsS0tlFLiSWB/icIS+c9eZl4R1HrgaKM9J+u52p49kwXzEV9wWdblag2V2UgsDap22ndKBpgNE2WB8iZRnabY41ktOwgu81kPK63N8QqrGm0WxxE7VjORKlWRQALyuhR2mRLRDNDRsk20srzk4QU1CrifNyrAsFRzPPnbmIFzcdKMw07Oas3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ztm5aQl5umJMyGv5QHBoFyn1RQNAHQwCYaNbcFcqI0=;
 b=SzbAkDX+RlXktRW1UyHyqZtFNFEJjEH2GeljlH6xVuaF85B+rNNBEOC2RXEsXRkn8VBTL2yX6mY/oCigecHj5HA2TIrajoS0U2RbhBnaGox2KaHDDaGss9Uq5Fmt5rdibDkg8XG8wPBBSrw88pEvpzS2N7Kbu6TkdcpE1oiVfXaQfWabL1LX9iGMArWW4Zw/k0YtjrUwagFog4A9H9Rlb78WBbIQwVoj6O/5CbR+LmOA+ynsGLug5wtLQr0tItdXztBMwKzGH9EC3Z2qtxcF33upg/N/jhuxGUpm7sjk+gpnGKoGBEJSsPSQ4LSgHOWaUbPkxXYFOdCz9fUoJBEPSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dektech.com.au; dmarc=pass action=none
 header.from=dektech.com.au; dkim=pass header.d=dektech.com.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dektech.com.au;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ztm5aQl5umJMyGv5QHBoFyn1RQNAHQwCYaNbcFcqI0=;
 b=ie5yd6zcTePuQlgPImOU47EiTMWHZUCWCVSIa4Vx56h2km4e8rNhs9cXBoIggwXq9dxfy7k27xEGOeKO8HCBFTMaX/sMscWihO/0f84TAiPtzcffnoz4d8vu7WbACzd9AP75TH9SjjIfYJF7T1rg+u3YAfEVi41F37ETRbuk1Aum6q2HcL/v8P/TnnHP047Vor765ByXihi2OeZJOrpFGRLDWX3Xz0B+REY4ai/gkalzAfH5O50IOGvcFSgMMrp361FP65RyNaRcwty0yZQ2BK7exlR2I+VjgMf9otbpZ2dayE8ktFmlBrLIhFrKICreR1PiHhjZf5XVdV/F0Wy/Fw==
Received: from DB9PR05MB9078.eurprd05.prod.outlook.com (2603:10a6:10:36a::7)
 by AS8PR05MB7638.eurprd05.prod.outlook.com (2603:10a6:20b:239::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 06:54:11 +0000
Received: from DB9PR05MB9078.eurprd05.prod.outlook.com
 ([fe80::c9ed:567d:143e:af2b]) by DB9PR05MB9078.eurprd05.prod.outlook.com
 ([fe80::c9ed:567d:143e:af2b%5]) with mapi id 15.20.7025.017; Thu, 23 Nov 2023
 06:54:11 +0000
From:   Tung Quang Nguyen <tung.q.nguyen@dektech.com.au>
To:     xu <xu.xin.sc@gmail.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "jmaloy@redhat.com" <jmaloy@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>,
        "yang.yang29@zte.com.cn" <yang.yang29@zte.com.cn>
Subject: RE: [RFC PATCH] net/tipc: reduce tipc_node lock holding time in
 tipc_rcv
Thread-Topic: [RFC PATCH] net/tipc: reduce tipc_node lock holding time in
 tipc_rcv
Thread-Index: AQHaHbcmsQ7KURUzRkaicoeZO+zrDrCHRXnwgAAp2oCAAAQK0A==
Date:   Thu, 23 Nov 2023 06:54:11 +0000
Message-ID: <DB9PR05MB9078EEC976944CACEC531C1388B9A@DB9PR05MB9078.eurprd05.prod.outlook.com>
References: <DB9PR05MB9078636E4D78B9F4442898B088B9A@DB9PR05MB9078.eurprd05.prod.outlook.com>
 <20231123062205.2038335-1-xu.xin16@zte.com.cn>
In-Reply-To: <20231123062205.2038335-1-xu.xin16@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dektech.com.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR05MB9078:EE_|AS8PR05MB7638:EE_
x-ms-office365-filtering-correlation-id: d5c51e34-1e96-4941-7211-08dbebf0ff62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uDhJICY5Fy2vNXXxC35/YDe2XwlqnHmbajy+4KCYU/5wA5fvTkFw8sL7LClqBAupabnehMgjYD/omLUV19cm6cjItbR3ydPrHlxLb71aenMY02U0YuDVB4ecJZZAHKrFPAPasRv9VwR2fvVXzvMIpvqnBbebe6u7epBF/NrI+kuvHfv7uIzZ2YO6jttvo7toRb4JisfVCAzWT2aF/t6UeVAib6DY47ywSiqCZFP7QzF4VGmVb6CXfAsaUBw7EUT6omWYmEnMADDfqzjRX7NkC0NOaPZLBH1Ra4nNue33b3UyyJnk1WVGbI1SXbS9ekajA7C5j02tG3WbFTEgW25pg0F3AGodDAy2ye/VyJlSqR03rORzl3XH2LbUeQl/yxREW4v0Op752W5CKkS1tXhLzPIP1ed8/99OPRHRe5zG5pXYSSbRKQeBMxcrJhfFkEMgnvogKDQpRW7r4FwllohE5DEbnknDikLjfCOKx7y/1oPhQcaHywKE8zZFHy3XkGOZYeAIb7Kfi/FCraNjBVNlPv3bcf/rqOD5xvr04i/zLkIdgNTv9eyiz6HVQjNfppgjOD4jcq4FGmvromayYzaZrseyNXVWeqIlkmxQD9yc9Wg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR05MB9078.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39840400004)(366004)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(9686003)(7696005)(6506007)(6916009)(71200400001)(83380400001)(8936002)(4326008)(41300700001)(8676002)(52536014)(2906002)(478600001)(5660300002)(316002)(26005)(54906003)(66556008)(64756008)(66446008)(66476007)(66946007)(76116006)(86362001)(33656002)(38100700002)(122000001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZP3EMBUIwKNPlOKg/R7WIExGDywlzOqRWDVqXPThxbjs3si3TAFPof6lTJv5?=
 =?us-ascii?Q?IyZD8oYL4RlD1PeB8RJkzfKUiYNke9OgOYyxGDBJpEu2Ir+Lz8tKy4qq8dbG?=
 =?us-ascii?Q?y1uFAgiKBjXXJ6Oi3pQDbMSQenh6fnk55/HFrnPgfX7wiIZmHs3OTiiJWYnM?=
 =?us-ascii?Q?qwf9jMBWQu6QVBtqdWA2PRW0hGLtTQOs6yHTUElCFVdmlTL+SRDakLaOSxB+?=
 =?us-ascii?Q?Jq+0oyRWKKMW4aGHywxhOBFxLoNGVuaUnTIDX+mEGL+DtdONbPGsnybVEStx?=
 =?us-ascii?Q?TDpb9t5GleC5GkdO8Y1F5qil2iKGdP0zQ729QvUUZjozRignYV4BGGL4+ubx?=
 =?us-ascii?Q?sI7gYFWiXCSYfOeZAlOLQlGBYjjLX8C6QCQ/5Tn1jJTIfJinY0DSp5yvJwGR?=
 =?us-ascii?Q?xo3I6n2RxbS0R/skVHV7jQPLSniYLVUbdxi2VyIKMihpgZaVFSoMLUt3tQ/B?=
 =?us-ascii?Q?WcCZkhV5jSxoRHYF6f/EexUubV0eUBW+Tq5ElK1sF93OfLLjxcymd2dqRtps?=
 =?us-ascii?Q?45jsEDjw+SkTmhZiOmZWYuhUbAjavk4A/FmKBz0Uzahain1pQ5NBu1RcwAUU?=
 =?us-ascii?Q?nXJ+QRcZbG1np4M3ZjkZfVh2WKMD0wp7mJGP3I26xZKb0cPXbRW92BMm8Rtb?=
 =?us-ascii?Q?qIXoiBVCrkVoovyXKJH2ARu8WwCKDMPsm9O92wvc1Jj2xEpge8i4DygWsU3H?=
 =?us-ascii?Q?41oXJSOkRfDksExGcMJGWDMNoCAiYl3uwYIfecJ/Iuw41udJheKbJIt9kR9x?=
 =?us-ascii?Q?7g42Xq8RFdGn/ip0ZfPqxCckvw1nHwLnZJMomXchiViuf9knfJPtly2saYGn?=
 =?us-ascii?Q?3K1HEZ3hYtsWdoORcoQBI447jkeURkZxrgatlzDXdipkujWUUsVeW8z9YUjH?=
 =?us-ascii?Q?aNBwnDAUQCwEzfA28KXDt5mxH85oQSLz6LfAZzCsrXEjqO4FD1+/k/Fe+Rmh?=
 =?us-ascii?Q?DpTast96xbosIq0Hfv7WL4jNcOz8V3emVSGbZXJjAJ44hSBDiO2qxoCG0Qr6?=
 =?us-ascii?Q?E5w8cXFOdmBsVc+TgGMPA6/8VeAOepBtMB/G2mR1XKEj05dDMcKpNrYkeOhH?=
 =?us-ascii?Q?abohTu74vYx+iCposu8Vr1fFWaGruiWG9xemjucA0r4wPzNT5RAXvoVwAfy4?=
 =?us-ascii?Q?8Frwp9H/VE1TXNvpvEoEMUa7x4TDUXjbqOJ6mTJPfPBt0co7kfGhkR058Y8Q?=
 =?us-ascii?Q?W6AvuQXpRLRj29/3Pp6L49czRpLXwvTeoueemfvaYnqdpaEfBwLP2CCq1shi?=
 =?us-ascii?Q?6iW0FmmPz+NLZTqgDDf3yRelEzu6y8gniQB3REZ+NPVQ5LQS8B1074uL/6KT?=
 =?us-ascii?Q?IRo+uZXJdrjKtvVJdEtctToXgg7Gysk2JLUM0lhe0nBhiYpjm5m8GPRD3DHQ?=
 =?us-ascii?Q?aaQAWUsrTc36mq+46r9+WWdU7xiz56pSQne4cyADebC3ImNRF3HbDZhWI0lR?=
 =?us-ascii?Q?HTje46NF94IGdfSFmuUDjKKZ7y1hm4FWibQWxAM+se/6mD+dmYzEyQGSHX0S?=
 =?us-ascii?Q?uDptwY7yMmjVtPigFHQvpgQUdJUjv+L5tA3TzHQMjkv6/eLhRAfd30LjldnW?=
 =?us-ascii?Q?G/2SRE93O8mj1zupZPvp5evtDoiVsVOa9z2PG2sIBMHPxlu/SrrdzsXJ/yej?=
 =?us-ascii?Q?lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dektech.com.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR05MB9078.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c51e34-1e96-4941-7211-08dbebf0ff62
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 06:54:11.2169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1957ea50-0dd8-4360-8db0-c9530df996b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d2yF0tFyOTFFZVhkH1D4Z1I4VB0MujPuQGEDTOwjyX7AhHagl7XHB5JEMNMu6n9RIc3Giudw7zglI5qJtEtmqdcmohWLLGoAmqhFZTgAvHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB7638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>This patch is wrong. le->link and link status must be protected by node l=
ock. See what happens if tipc_node_timeout() is called, and
>the link goes down:
>>tipc_node_timeout()
>>   tipc_node_link_down()
>>   {
>>      struct tipc_link *l =3D le->link;
>>      ...
>>      if (delete) {
>>         kfree(l);
>>         le->link =3D NULL;
>>      }
>>      ...
>>   }
>
>Happy to see your reply. But Why? 'delete' is false from tipc_node_timeout=
(). Refer to:
>https://elixir.bootlin.com/linux/v6.7-rc2/source/net/tipc/node.c#L844
I should have explained it clearly:
1/ link status must be protected.
tipc_node_timeout()
   tipc_node_link_down()
   {
      struct tipc_link *l =3D le->link;
  =20
      ...
     __tipc_node_link_down(); <-- link status is referred.=20
      ...
     if (delete) {
        kfree(l);
        le->link =3D NULL;
     }
     ...
   }

__tipc_node_link_down()
{
    ...
   if (!l || tipc_link_is_reset(l)) <-- read link status
    ...
    tipc_link_reset(l); <--- this function will reset all things related to=
 link.
}

2/ le->link must be protected.
bearer_disable()
{
   ...
   tipc_node_delete_links(net, bearer_id); <--- this will delete all links.
   ...
}

tipc_node_delete_links()
{
   ...
  tipc_node_link_down(n, bearer_id, true);
   ...
}
