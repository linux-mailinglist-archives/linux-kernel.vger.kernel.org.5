Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327F77D2A65
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjJWG1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjJWG1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:27:36 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA884E8;
        Sun, 22 Oct 2023 23:27:32 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39N45kxB005355;
        Mon, 23 Oct 2023 02:24:19 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3tvv62vu6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 02:24:19 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3aeFg98kmaPVnVcyqphq1pPv8MSzFt9h07T2CWWs5JSJ6ABDFm6s5isWZBPMIrBrpbLfdzCyNw8uRB+bVKVgOh2XJBuyLJqpyfidTTQY+vzdLtCMg9XjkzPqYipJcrs45qR+O41O5/tD9LjIr+s5sfKG/sAIwOvjcfE82HBxhaVjtIppfqfXdWr0Z0QE+qw3np6tEUpWuUa8lRQYaDMGsyxPycW4Pi2SecdKookBTgVigKSF3+yc6nKSVMVbKd3Ak/etu1kIJyiOP72MbSv+T7o9eSRqALLg9UMEpFBI2rMKpKfEHgcYPWL2PBj+2pImT4VY/XwtJdAyVPcAn5Zpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yre29T06kxkgTZKj9FP5DFupFfy/vQNtq3GYcHHuWw=;
 b=jWAqLtskmZzHyCAkApNL8K0UeZJIqo6qeiewiL4pquh32KGeP8Ae33Q3pRqRS0hXfCTcpvxmcMFkf1OTJUfPgCa18w6ztSeo8DowrgpMG78ONcYmZ32hBzAkIyBvXpbUOOWcgIr75tCM1gE4wL9ak9lPYmcWtpdm4FHiWPBwmbt2X5ijtpD01+dutQkj6986HQaZ+Ng/zNm4voLBq0cKxooTLP5zgaJGWj/+56q359WM16+mL9m4w9wvf+k1/sk0OXjuzE1yOdoLtIPzX4xz0dMG3/JMn8CCFYhT2AYjx2SSLQjkWF9SiKeCC9ryyLk3lyZxafKVp6kUA/Mr3jaY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yre29T06kxkgTZKj9FP5DFupFfy/vQNtq3GYcHHuWw=;
 b=qLS8p1Un3/jtrJC8n7a5d3zdFfofk/DORcSxREAtZRtr67t6m9wdqK1a/9qrTrTEjViH8qYTIfujHJGtnCwp+93n0NL9/VpA3QJipFkaNzkmkkJW6qj+eS3tbDXRDKP2+XkGNPfev8PCnbj44R/LX4ECk3l2n29YvWe4Og6SLoc=
Received: from SN7PR03MB7132.namprd03.prod.outlook.com (2603:10b6:806:352::6)
 by BL1PR03MB5957.namprd03.prod.outlook.com (2603:10b6:208:310::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 23 Oct
 2023 06:24:16 +0000
Received: from SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::9d8b:27cd:e980:436d]) by SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::9d8b:27cd:e980:436d%4]) with mapi id 15.20.6933.014; Mon, 23 Oct 2023
 06:24:16 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] net: ieee802154: adf7242: Fix some potential buffer
 overflow in adf7242_stats_show()
Thread-Topic: [PATCH net] net: ieee802154: adf7242: Fix some potential buffer
 overflow in adf7242_stats_show()
Thread-Index: AQHaBEj69vNVcmdAEkKRJdPJLN5zT7BW6mog
Date:   Mon, 23 Oct 2023 06:24:16 +0000
Message-ID: <SN7PR03MB7132B2112186F40E268727D38ED8A@SN7PR03MB7132.namprd03.prod.outlook.com>
References: <7ba06db8987298f082f83a425769fe6fa6715fe7.1697911385.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <7ba06db8987298f082f83a425769fe6fa6715fe7.1697911385.git.christophe.jaillet@wanadoo.fr>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1jOTBlMjBlMi03MTZjLTExZWUtYjgyYy1iY2Yx?=
 =?us-ascii?Q?NzFjNDc2MTlcYW1lLXRlc3RcYzkwZTIwZTQtNzE2Yy0xMWVlLWI4MmMtYmNm?=
 =?us-ascii?Q?MTcxYzQ3NjE5Ym9keS50eHQiIHN6PSI1MDI2IiB0PSIxMzM0MjUxNTg1NDg3?=
 =?us-ascii?Q?NjgyOTgiIGg9IlREVmFyVWFLaGRzMHRJZ2JwUjQxd2F4MkI0cz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QXFSbWFMZVFYYUFWTE5Sc3d2b2pveVVzMUd6QytpT2pJREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBbEdUR1ZnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR03MB7132:EE_|BL1PR03MB5957:EE_
x-ms-office365-filtering-correlation-id: 5dc72305-e376-40c3-a418-08dbd390aed3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7qzrrYkYx82+xHsVHImyjkwAAhTb9Fb2jUafOlUXltwX4hWZ0xr3+g6zI2cj7GPl4epmN/UcPTOVhcaUfXhXZSClW9OiIs/BUUjO6o+QHAYY2I8ZZ2CiffJEyzYtCqYUhlQ8T5fmChvuEDDCKGIX2Gf3MfBzjbtKY5JSNKEASGKYddP0NJgDU4KG/GLiY2qed1N98TZ5B0kUUb66uOCEL0YCtMt30Ejtrwv5Srst1HUpVjvcOZpg0IhRlWJwXgS97dviU/1nGdvEl87Or5UnF3tqyWBEnXxoE8n9k5jfW8SPz9GqYqbfdmHi8pmQcONG/gyeaKFJbPBfRjUZwNfwP+KB6Det/3MSEGdL4HU+hxeA/LSB46jUtxHyYEZ6d9Zq6CapLCsL5OEcEgdxSJv+jG4TXQaAeq5wuC/v5kf/o6f0bPAj3XF/eOheg7sllQw4ANm8u681DarNacC/cFBbh2ch5RrTH0TDFx3FZeOzTOdGD/8u6AcsfS4KxFlWVlIqA2asiPYhkqkVG1I5oJ5a2LpBITcpYMTEdK3tzjQFMA95bhUIvBYELmYSYzgGfDp3JtV7HtwzRvTZhgCjLWqi4P1nyuab7IP+RviAmTJQvE7o+9k1RQK6PS77N+Vmk2VUgH4ff0rx8iRdB2vH4iyUfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR03MB7132.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(55016003)(83380400001)(110136005)(478600001)(76116006)(66946007)(66556008)(66476007)(316002)(66446008)(64756008)(54906003)(122000001)(86362001)(33656002)(52536014)(5660300002)(7416002)(8676002)(41300700001)(2906002)(71200400001)(8936002)(38100700002)(53546011)(9686003)(4326008)(7696005)(6506007)(26005)(38070700009)(921008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PvtbIBznWqOT56Y6N/1mLlkDwGhOSjJL0BYhUD6BfA8kCEzPExgBZkLVOW02?=
 =?us-ascii?Q?WhMZUPKhLjLNlP9DTP4Hx/w2ZBSksDJNE26QAeN5+dpSIq1GAwh3CquY8BNa?=
 =?us-ascii?Q?siphyJTjHRAYorjdFZUfNRByncWcsjf3LeQfn7szrhyQtPPbWhdKwneszdqr?=
 =?us-ascii?Q?6BnnjJgNRwsOnrr4jzzDCDqT25LUPCjdHISlK9VIboZzcorxdZli40OhsNxC?=
 =?us-ascii?Q?woBdrsRalrG8bTHgM4NzKvMypFVNfEoe7hIn3jC9uyyju15G67DKyZrmXG2p?=
 =?us-ascii?Q?1Fdy8gM42fA4yYhisquCegAErZkMU9geuUvg3UbVzSi4re2Q2Fm/IvEV5sg2?=
 =?us-ascii?Q?Re30Yw/9VsXGBUNZcZ3M1KCziaRFQts+jjp/vQ6itgVmNqC5zysgAjvsZWhb?=
 =?us-ascii?Q?mCzGZVHAqwiRGRTS+fXuwKCxxIARYYAKyLIZO/EhpT2izccynpEqD/mWuII7?=
 =?us-ascii?Q?gQFzXZ6ySCL0/tBAhTrchLG0Y4J/ebDdwcWRhrLM1Y+IDh+BY/pemTfwQ4eG?=
 =?us-ascii?Q?jIuumGa6pGnQZzWafRUuq6Pfel4UxmuwIaqa4WHEJ3r/1qFclvsXIoo/Y3eK?=
 =?us-ascii?Q?cQE4NMzG+z/OW5P3TRcGPA8fDDO3kY6dKtdvIhgHTxav0MiWSt2eUM86d/cO?=
 =?us-ascii?Q?oBqYg2KOhGo9B5O3GIYrQv108kQk5ZgUZ1+jzbKDjw9SjVqclsa0BvR6xF9f?=
 =?us-ascii?Q?2wwXm+DRPwnxcwwhFC7Zjj9+dB67+a0FoQiL1x7/S1DMk4vaosmSDO7LDYzn?=
 =?us-ascii?Q?RYCHcCo4sJIDEKiP7zjow1wgbjJAtuW309iCrW6SL9vLKowSRCp2ZzEKgpCC?=
 =?us-ascii?Q?6IiGQ0NDBUBC9T9JyzYx9y+/U0iLvCdVic8zGlBWat/XNFBcVZhDe0H3q7a0?=
 =?us-ascii?Q?TZg9hHgQv+6MKA4uuy6w670AIejHkRAvG/tYxGy1iPrOn7qh8VnJcqfYg2Dp?=
 =?us-ascii?Q?p1KrdhXWW3uTnzoxgS9nNqgBEJ/YBAyfl25wLtW1CBs8bAp6Cq4Tp5CEPlq7?=
 =?us-ascii?Q?K3iZ9yKj9g0VA3pMHBWuoGTiP8NcYb1U3oRPDkj7eFe9Imz/iy8SucdJWPXC?=
 =?us-ascii?Q?tBRi7iAMSjeTn5BNtR3GpzA31JNsj//jAv+zsWcq1YYPSh5ngOIa0RViNufE?=
 =?us-ascii?Q?IMPG0UGEJq36gX/w9c7q/CS4WYNnim3qMxcYFgWMfNZ4PK/5tlQwQked/GN7?=
 =?us-ascii?Q?J6b69W0Mr1cn1L5W01ImX44HWBerd8tC4NJ+A1SvHVJEYc7NX0X8q7rM318W?=
 =?us-ascii?Q?4HszOOEkgYSQfmUgrWxlxFKALipwTKzLiNMNLkzsruaIksoSWzsaLHBbKljn?=
 =?us-ascii?Q?qJ2tm8HKzQ/jCfFNOT+fIeVyhWeBEIbX1lu7rn/1vU34tyJNfEnIpM4MoZoI?=
 =?us-ascii?Q?K6n9sJyXh/4cUtccTHyJHUOzyNAEsssDsvTKXlULc2CHp1+iZ2fOIgPMgyQ/?=
 =?us-ascii?Q?PKtpRCdrO2/SioYCPvv4U5IS16Log/XnOWjWHiXDANW6h+iTU2IsBmjA0kra?=
 =?us-ascii?Q?JRl8Gl/fwJOy3tYHL4h3ZiCqO7ZbZ3yV5QBoshgcQ2H3YmOs474KYgFVp57S?=
 =?us-ascii?Q?ghFbazfaUCX6tW5LG+I7llsEn0KNzsJFZP7NvplJU3B7YZVLRmC/Op4MAUKb?=
 =?us-ascii?Q?0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR03MB7132.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc72305-e376-40c3-a418-08dbd390aed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 06:24:16.4484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rixPErjm/9Yo5kdByc6aI60cxkI6dSVE/a+p0rIxWNVxIPiU8vhtwUGhDUI5gje9sXwxx8b3TxQSbUI12bCr9VKXO5C6ZGS28GD4yjggokI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB5957
X-Proofpoint-GUID: rzJh7cbR5jbKHSOp95nDnuBdS3X5Z4H7
X-Proofpoint-ORIG-GUID: rzJh7cbR5jbKHSOp95nDnuBdS3X5Z4H7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_04,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310230055
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Sent: Samstag, 21. Oktober 2023 20:04
> To: keescook@chromium.org; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Alexander Aring <alex.aring@gmail.com>;
> Stefan Schmidt <stefan@datenfreihafen.org>; Miquel Raynal
> <miquel.raynal@bootlin.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Marcel Holtmann <marcel@holtmann.org>
> Cc: linux-hardening@vger.kernel.org; linux-kernel@vger.kernel.org; kernel=
-
> janitors@vger.kernel.org; Christophe JAILLET <christophe.jaillet@wanadoo.=
fr>;
> Stefan Schmidt <stefan@osg.samsung.com>; linux-wpan@vger.kernel.org;
> netdev@vger.kernel.org
> Subject: [PATCH net] net: ieee802154: adf7242: Fix some potential buffer
> overflow in adf7242_stats_show()
>=20
>=20
> strncat() usage in adf7242_debugfs_init() is wrong.
> The size given to strncat() is the maximum number of bytes that can be wr=
itten,
> excluding the trailing NULL.
>=20
> Here, the size that is passed, DNAME_INLINE_LEN, does not take into accou=
nt
> the size of "adf7242-" that is already in the array.
>=20
> In order to fix it, use snprintf() instead.
>=20
> Fixes: 7302b9d90117 ("ieee802154/adf7242: Driver for ADF7242 MAC
> IEEE802154")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

>  drivers/net/ieee802154/adf7242.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ieee802154/adf7242.c
> b/drivers/net/ieee802154/adf7242.c
> index a03490ba2e5b..cc7ddc40020f 100644
> --- a/drivers/net/ieee802154/adf7242.c
> +++ b/drivers/net/ieee802154/adf7242.c
> @@ -1162,9 +1162,10 @@ static int adf7242_stats_show(struct seq_file *fil=
e,
> void *offset)
>=20
>  static void adf7242_debugfs_init(struct adf7242_local *lp)  {
> -	char debugfs_dir_name[DNAME_INLINE_LEN + 1] =3D "adf7242-";
> +	char debugfs_dir_name[DNAME_INLINE_LEN + 1];
>=20
> -	strncat(debugfs_dir_name, dev_name(&lp->spi->dev),
> DNAME_INLINE_LEN);
> +	snprintf(debugfs_dir_name, sizeof(debugfs_dir_name),
> +		 "adf7242-%s", dev_name(&lp->spi->dev));
>=20
>  	lp->debugfs_root =3D debugfs_create_dir(debugfs_dir_name, NULL);
>=20
> --
> 2.34.1

