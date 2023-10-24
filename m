Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554277D4790
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjJXGhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjJXGhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:37:10 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2053.outbound.protection.outlook.com [40.107.215.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DA3DD;
        Mon, 23 Oct 2023 23:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjBLvOaPZYv4TynHZ7EPNVfbLKbVXoXD1CQ/S4ltFKXzSgDFCMCQAvh29WfYsDYQUASue5ayzzz0EIF1NZ8duxZe0v3B7R8WRLpvK152CM2zUsIUdbobEmBy7H0i/ub5XWknOSugKdcd8KCv3zlWa1ZvwRBabCD5PEAteADb0nxztLgNbP4A4f5Pp9lruYP9xn1PwOzoDJcUFXfPAIbLzulEPgSI1ERcH5p6/eaheZJMDn+Wb7h+hn1MF1PN7jBfaRXue/zHL+pQd5igmihuxvR6fYFlTQxSd1mBY083HnC/eN0BjkLC/s9UxQ6oo0Fa3+53AusVHzp8sjxiuxJGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S776CKgV5vhw4m649OWtPzVm7jLwVn/6Pas+XvI5hfc=;
 b=bD7lZFK+m3uIAWcCMLPDtMT83mz/VrYN5W/WXwYfrF7p67sPY5AHR/N2URMoAMlt7h9hvzakbWyXxcf4J7lDwZNcpmXBMf2FgE76Pe48j0a+KctfXGbIbKBBwqtAQQ8+nIC0tLSnazyqbsyegK50aoFXzV2rF5QWlQ74Bvd1jJtRjXRJUOwELwg69vM3zQZnREbjwR7r7jy6Do5qvu8+eFGmwH1riJDntR7yFpac/paMmZS3Q+9WRiG63ojaVHDqXYhzHmfYROQl1lyXYA7oO1T2yfBChG10Bp3QhuwExph8LJJXF/frDc6YoszZi57Ef00ngeWK/GPUDynf0fCIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S776CKgV5vhw4m649OWtPzVm7jLwVn/6Pas+XvI5hfc=;
 b=mi400As+eTjuAI2QHeS5SjWhtUiPPRPweVLTxPFATVo+zPSj0pB+ZnQZXjU+2jqwbz/cZslrok7g6uod+uq4ZbvT/ZlfUSdbqw8VG/rq/cbSN5gtMf8EtA78iQMB45PZw7Vk8DuKykXHsJYcOU9w5Hn4KfSG3E0fIbhuJKDUGaM=
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com (2603:1096:400:71::13)
 by SEYPR02MB7252.apcprd02.prod.outlook.com (2603:1096:101:1db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Tue, 24 Oct
 2023 06:36:58 +0000
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::e6c0:ad44:ccaa:789]) by TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::e6c0:ad44:ccaa:789%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 06:36:58 +0000
From:   "Puliang Lu(Puliang)" <puliang.lu@fibocom.com>
To:     Johan Hovold <johan@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: add Fibocom to DELL custom modem
 FM101R-GL
Thread-Topic: [PATCH] USB: serial: option: add Fibocom to DELL custom modem
 FM101R-GL
Thread-Index: AdoGQiyCd20oL5c8QD288tOBB0WzCg==
Date:   Tue, 24 Oct 2023 06:36:58 +0000
Message-ID: <TYZPR02MB508845BAD7936A62A105CE5D89DFA@TYZPR02MB5088.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR02MB5088:EE_|SEYPR02MB7252:EE_
x-ms-office365-filtering-correlation-id: 4e840e6b-ed5c-4f67-6e30-08dbd45b9f2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /nXqcOvPWzG04jrItXH1UgOkAxvCunohUztXROtfRnGZEPXvRN0UPaNO8w5+ZQvgZm0tS0Tb7oT6meRZtgg5EDKYcLZSEdE2tZ3FYTtsvKLOLrhgyuOLYE9FCsQUNWf1d5K9HGi++CzKPBFJfxGaVkXFxhoaOj1ZQo3CVIc2rcDsaQhNjfGTzjoSWLSLFXATK5CoyOpCkUEHEArRgBAfQWMwR6vG/Pd1kXtnJMoYW+qoJKUIT0Uf8vE46lXNjUkbfEyt25vHLAKeSuA1nXtvvR3uRdi+XpjGtxhiWhh9ED9AjCyq2I2j56thkaHbqAJXUNQP5F57Z+ycab/Cyh51tsGLtW82HOUDUT/AgpbOrp5gqSZuPCVxhRlh+q0ehoO0lY9sMI5mSzhlOf5KTx1ofWPUE51Nk1LwT2+vMNKi1e+cNA7nrHLTWqr3pkMWG+FzlAjMsUmNe7uRgNzZhUAZgp5RCPq0R0G13Xnw7oEX0aey4JGebgW8ybjbkiRtI2p59CJqv9Pm5gBFwBfNpsAHN3q7J8wW+ix5Ep2zY7zvenrrUdGW2vc3AOohNOdqGx2aHC7EaZLKA3dZ4nrmA0O0Zo7noUvh4IsHqyGEGLq/vZut/upW6r6AtHimOQUP2Ynd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5088.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39850400004)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(38070700009)(26005)(38100700002)(2906002)(55016003)(41300700001)(52536014)(86362001)(5660300002)(4326008)(8936002)(558084003)(33656002)(8676002)(6506007)(66446008)(478600001)(7696005)(71200400001)(54906003)(76116006)(66476007)(66946007)(66556008)(122000001)(316002)(64756008)(6916009)(83380400001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0WDQYMLKOfNPqoMXLZuRbexiEEcsmo2tt5D6E2+oX3jPgKqk+7HRSnmBnILA?=
 =?us-ascii?Q?j7wQD4sRVoaZBzYQ9O1vEabMcX3+FqZPHQx54z4y9RfG7/r9KyMdfJDlSxUq?=
 =?us-ascii?Q?WNPEKhR2cJSfLCC7KzXYIM5Qw/p96KS3/mZy/y48KOIODG5MMedo7Xvj1h2c?=
 =?us-ascii?Q?DSrYV8MUjPihOl0uGuwsSy4p5uAzyuFp9dfov5a+IUqrc5nZHM3dswczEpI0?=
 =?us-ascii?Q?Qwiwg9lt14t5Lv/MtfywaZSoN53ldH07UfaEwTgMqvxjWxVXA9zR0hIeceGA?=
 =?us-ascii?Q?CpyIzuMvwn/QvLEdfBvKwVczxHyGnhjdp/nQat1dV9u/vDzS+QI8eWEiUfFW?=
 =?us-ascii?Q?o9E2iXDJlZRscy5dUj7UGtgg4AmIKQp+AghfD/1RfF+51h8kfbzm8pELs3ql?=
 =?us-ascii?Q?b7OEkbcxgX+JKnqtzlz0Ml4pifVz0VXwjvq/OL517hkJF3sAkeZPFJ1TJsjF?=
 =?us-ascii?Q?+SRwLBn8fM97pgs7OcQ4O21tUvhlFbNU9OGrPFnOA9Z9u0LZ+xSojIIqMlHi?=
 =?us-ascii?Q?xCjM97Vum9IEl6dVLk29b61QwZTKN3jORf1LlUBN1JC2lh6D/Awu6/R0zmiq?=
 =?us-ascii?Q?sqoeX1fenRXF9NJJ3Gjnkf0BfVr6GvjeBfIPp9M9XPQhWOTJH8Z5NHMnEUWa?=
 =?us-ascii?Q?/Ox+Lwos0iKcVWngmAo691pH7l0wVqaWoP+ZpQgbsQKZIijcDoWqCI1vUU3Q?=
 =?us-ascii?Q?0G5RCfr+UCmEuh1/16cEVPR8weGwDE0P83DZnXqi8z/0Qi5KDvgdSxh6yAEU?=
 =?us-ascii?Q?4UazUfI7BtxkwkpEtX/C/nEM3eFGOYLNib2lLwUSC26PfC7gpdkYHGOEdwUX?=
 =?us-ascii?Q?za20mCCm2eqoa9Tn8CWk/cIo/OfM/GDeVSi50m9obhBrKZjDJ4tUkV8r/CTp?=
 =?us-ascii?Q?9R58SgUJHDtXBEu0CXWHdzBeQbRKjGSDgjVVWb6N7ipKpfWCrX0cXvxtW5up?=
 =?us-ascii?Q?17tGUg6Gs0AMmWBHCqNQhkz1l6PeF/bW0S1T8ClHpNC/VNGdj0QB0gJAl31G?=
 =?us-ascii?Q?cG6O+sitNCCKfgR98R/FrSCDfDd5b0JADi9BgYbcI5LiBsCcG2gOaavi1r3i?=
 =?us-ascii?Q?H3HS9axkpbqys1JY2mkeCKPRe5qMjsswzkztFZ3v81GZhZTuvEOKDeVJFqgm?=
 =?us-ascii?Q?E/9vXqGERbvrlD+QO4Jo+JAgynEl43ClhiWHEYMqUEQWxaJNZMx1Ac++7Jyc?=
 =?us-ascii?Q?+6cVOlL10pbbLsYsJP5oFBY5U8K/eJ0w1pP180HSrHgm0e5+3+frC7DEULle?=
 =?us-ascii?Q?o3iLCFCzv29FaL2uYQhgqkRAVf3vTpKW8lKHJNGvaRsQEbQkJ+A4wk4T9x46?=
 =?us-ascii?Q?lkzujE4+Y3XQO4IifhosGjGRQkWE/ngc5KxwfBm7FS8gGI5FHCih19Kq0LoK?=
 =?us-ascii?Q?NjIC9gLPongeXu3gYukQsUU5bc/3gyeMOQe/Pds/84Jsh7Q6wR3jhU7TJoms?=
 =?us-ascii?Q?5mHkMeg22U0gToLtdL1QEx+sZekbYgQZGD8kOFI41j8vhuaAxwuxnMMPw536?=
 =?us-ascii?Q?Q9hQYCsWQ5NhS3ULQgCKfF5LW7Fl4idSfa6/cmi5chzjCJJYQT92ED9IdUtZ?=
 =?us-ascii?Q?jLRQRliy3t68EOuhGmBVjOnsV0FSJ4P8RAxlSzhr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5088.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e840e6b-ed5c-4f67-6e30-08dbd45b9f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 06:36:58.0722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdVMCEa0NUbACIrhB7hFhfgx4dlTiAsZ8aC5G0OSUHLJR5zmh4IjdQgEDgr9VOXXS9DGUNCz1ODU8pqslyZORA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Oct 2023 10:40:05 +0200, Johan Hovold wrote:

> Ok, thanks for confirming.
>=20
> I've now applied the patch.

Can I still modify my patch now? 0x8213 is an ESIM device, 0x8215 is a NO E=
SIM=20
device, but it is written backwards in the commit message, and the define i=
s=20
also reversed.

Thanks.

