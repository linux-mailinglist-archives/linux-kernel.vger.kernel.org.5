Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E507C6A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbjJLKBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjJLKBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:01:13 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F420010E5;
        Thu, 12 Oct 2023 03:00:40 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C11W2P017438;
        Thu, 12 Oct 2023 03:00:17 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3tnxdckvn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 03:00:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fm8wvDm2hx0jvILfTXnd/2ck4pX4D5KxuTNw2IL/Yv5gBRV7cgpW4YTD27v+ey5cYP2P8fexFNhpsCjgk6rKjyBsS1Xqv6Zb4Xnn3UXysDyPSQFUrhN2tbt7AkF3kyyS+HejIUc9alIiLQkKOIk+pyJDP0EdL6cg397OWmDdpkfIhI/bMng7pKnA/s2ujeEPELrIAoLeUMZe9JmicjOojaSOW+ux7s4SsSmc/ZR1H6pALsecKIO+lW+0z8afplzC6UkR6DEP9HhYGVZoBQm3cPzcI4FNrFV1/31+y2Jr1Qzj2wqq7F3SX6PMd8dz5h6BTLxtI5NXcJnzfu22GjU+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqLActJPPrhokAGX+sEV4fAAOgogxlpb0gED8/oHEb8=;
 b=OKvcDccT/eYi2QQPm3DXC7kYicFuUDUDsvtyX9FBWsh1sbyXKcZpein2H2utpP8korRw7cpyFFi60MfkxS3EkyCnu8y1MHXDja9Wj//PwF1PCVIzNAzsZaiGUtpdFEwEWR7GDdo4M/WJJvUkr+m9PSBE0sdchNBKXvCf8QmIw0HwBBjMTUdMCszFshUZu0PcHrhOEdtb/NI4PQaRE0QTbrsgZct+9Li32TtMyYHVMxC8TZA9nYlA0ulEzdMrqse5MZFpYXunxgeagVnCBut7nw1O3nvGmLwSo1ZDPeOGk/5zo+tMVKruITwasrdb1JhEsof1CSSOVCfBM9tA0s/vyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqLActJPPrhokAGX+sEV4fAAOgogxlpb0gED8/oHEb8=;
 b=AtrOokgoI+uXAt4yYdxdvm8E3TZ85c/AMlaXaRJkAfTM8M2RFI6u7WSiftSP19C39a6guw4Ra6KVGqShU8fK3SWXTiM8Mz4w2CcR+6kbEMWKBRr8Puyaub8TzvWaXEMd18qH1Ho6W1gR8rhSpToChNRG1kfRgYD8Qr54G4UXE4Y=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by PH0PR18MB4102.namprd18.prod.outlook.com (2603:10b6:510:49::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Thu, 12 Oct
 2023 10:00:05 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7652:bbbf:784a:bd40]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7652:bbbf:784a:bd40%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 10:00:05 +0000
From:   Shinas Rasheed <srasheed@marvell.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>
CC:     Vimlesh Kumar <vimleshk@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Satananda Burla <sburla@marvell.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>
Subject: Re: [EXT] Re: [net PATCH] octeon_ep: update BQL sent bytes before
 ringing doorbell
Thread-Topic: [EXT] Re: [net PATCH] octeon_ep: update BQL sent bytes before
 ringing doorbell
Thread-Index: AQHZ+2/0VtW6umhslEeGGb2vkKvXMrBF1iOAgAAVKnk=
Date:   Thu, 12 Oct 2023 10:00:05 +0000
Message-ID: <PH0PR18MB47342FEB8D57162EE5765E3CC7D3A@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231010115015.2279977-1-srasheed@marvell.com>
 <237ad66815a7988eaf9b0ed2132772c58e868cd8.camel@redhat.com>
In-Reply-To: <237ad66815a7988eaf9b0ed2132772c58e868cd8.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|PH0PR18MB4102:EE_
x-ms-office365-filtering-correlation-id: d35312a4-45a5-4931-2b5a-08dbcb0a024f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9eWC+VPORfh4EXnH8wkbhKSukGDU6CCh63T4Qi3e89BHxwQ44/1mFsV3Y3A8Vx3RgqITmymfHArKfBSVBRGdrr/wEQCWO3/FS8K9sz3p+VzmNK0C8EUiMtxQfAfP8+9ekHsCFesDoAGYp0DtSWRwjxbanvPzhlg7eJIUUVjUvgUAkVsXzg4ZCFGRx50/bQBgvBlN2lX0IFIh6omjT5NlrOo9HDEL650dVKuKZspr13cUSVsts63txWenXm3jmfkA5UDICiGVUJNVmPkuLQElv/KbsejnrEgOhhk1YXrYkB4nJIEQKcWTZYg6Paeg7BnjKLMAwjMU4r4jgt/zjh4k3wpkc8VKqlhqB0zAxdKGl8ltd7wceRe1f93Uf0gDAv/jL8331Y+VpMJkAvMlvjSvSr+/I5zQ8S38c0d522UEL6vjnkA2VxVSrA/IOJeAzuZWLqlrDV8dgvEm6TN/N4pJVdfDIEnGYZLLoUhj993WsrX9LJEB+KRcRXnSg6OUA5bmNQmt/mwa2Z9LUD/RrUj6JEeYR3oxas8wQCq1J2gYOYkusVOsJO1v62fKsSobj09LABYTa8yGR5Kl+Qo2bEFd5lDg6iQctGIozaxdCNKBkjfPuWLjKg2IMc/mfb16FQOQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(55016003)(83380400001)(15650500001)(107886003)(478600001)(2906002)(26005)(6506007)(41300700001)(558084003)(5660300002)(33656002)(8936002)(4326008)(8676002)(9686003)(52536014)(38100700002)(7696005)(38070700005)(86362001)(76116006)(110136005)(122000001)(54906003)(66946007)(66556008)(71200400001)(66446008)(316002)(64756008)(6636002)(91956017)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MUCcUBNij8E/D1yz9xA+kif5GJlovMCsyZ9XeCoLMYtO8i2G9I7GJE2aIp?=
 =?iso-8859-1?Q?mX0OfMNfgb7493p9mmBKMKzvU3DuVbvJWYaWcmZ/+apBtKQVsrbU7nWIHg?=
 =?iso-8859-1?Q?kl//aPoCQxwy7dFEdKUwZqW4j+mJHv+8zBxnhbu3SWuGoTqpGoWY3831G6?=
 =?iso-8859-1?Q?dHcOPA63P2Cmg+1lQAC3z/pxGCNMSTc5uDRHyPgQGekngpY1g3ir5w+mKi?=
 =?iso-8859-1?Q?/7aVwtMjUozSG3C6Ii8QYupmZiPM8zCOtjN85fFx0CdxRpaJbrwSaVMJE9?=
 =?iso-8859-1?Q?r9fqmhSMU0A8fS912TtXjrTDS8jiZnbwx19dmgRoh+i3DlDkb8/AcTyMpF?=
 =?iso-8859-1?Q?8wxDM7EPKQqCBe7CztKgBEfD4SjU1SVbEEG2l6aq2K8QY3vm3PPVCeFodh?=
 =?iso-8859-1?Q?8oleitIse1xHPvmzsqRWG4X1XU+prbGmy8T7Vqyp6RrBSd4Xq5snjR3SRZ?=
 =?iso-8859-1?Q?sayMCZHm2s5RADqHk8VhQlHKcVID6JCpjtJ4VS08zemc5TiKe4pCoySFRn?=
 =?iso-8859-1?Q?0Uk6GheXHGfPRQqRZP1T2tlDopPEyfgZIERdsG33ZUkz8MOilpKdZ9PyHY?=
 =?iso-8859-1?Q?8dTcjYxAlXpFE6vafof1jqM5VmJJZ4/k9Lxb821RSR7TReuG/2MVe/gRPZ?=
 =?iso-8859-1?Q?U+miwO6d5kTqx6shwfWGorZlyTCHQkqkU/IvDJsE3irBAvoaW1ulDCa4F8?=
 =?iso-8859-1?Q?P2XVEKfay1TQWqmf/tlgzFGiwkQUNRnFq4UyKBxOpiWXsppCQzyyXpVXl+?=
 =?iso-8859-1?Q?nwGIs4GSsRaDmbs18gz2KipiaTmcMApeeKgDOViUwBJgQPfnmXCESrbu8f?=
 =?iso-8859-1?Q?t4i0KSYLm3VZB6A9BNG80GPMD0NMwh8PekFGHV3DKp0JwDX69hLoH0hpeU?=
 =?iso-8859-1?Q?ZoxxbJb1hSoR/eLfcQrn5R96DF2Nc8lf4U7hYjWJsPmeivJ5EanNVUU4qg?=
 =?iso-8859-1?Q?TDbNIxrI7lkmbZEcxxHGigOgBXhe48Ktze/cI9ETnl4HVowQ+DEGf2zuv/?=
 =?iso-8859-1?Q?2E4aIt9dY42rCte9nNiX7hp0l1GCfHgpnt7tjMBVfureXiaEBngljVHTjv?=
 =?iso-8859-1?Q?8gM22Ms6IhNEPdNKa+MMpW6EyINWmahibvxVbAYo9/iJjW5Bii/Phqhj6p?=
 =?iso-8859-1?Q?iSSO0GS0flSo5M06XVBS6qbE5lc6mrLXzBGnV5tCDJxJO7f42Sa/ZYNOkI?=
 =?iso-8859-1?Q?20Q3J2TJ+dJsAI58bPnsfq0OxgB1YxzRz9CYv+gWkDqHi8PM8CFhtPXnXd?=
 =?iso-8859-1?Q?A3/WLUWVeHScGfYrV70AvdJnqTV4vI0QGVGDPkv147fp+9K+e41hZudOW4?=
 =?iso-8859-1?Q?z7hFuRQSkNg719HS76eUk8EHfMNtxxJyoOrhGi5hRxRlH4kOwU8wdrRt9q?=
 =?iso-8859-1?Q?Shd4pFBPpZUfDct+6yFug7ZaVqQ90H7eSvniKU7y+a/KmIpO/qpz9dyQjP?=
 =?iso-8859-1?Q?cU+zb2JWFzmZLEG7h8dc06yfmRJeZ49qnReF7cdjkx+vTS9zx9wJL+H6ik?=
 =?iso-8859-1?Q?aZXG/2BVN74JmnSus9k/ZysywmVLh+R9XwL2vYYFiVV4IckgxvKYnclSX8?=
 =?iso-8859-1?Q?b8S10m/3eDspC17tf91nHREjdYxkTmxpSsnsZNULUxl+skQH0o8IJfKMbw?=
 =?iso-8859-1?Q?gdQ1IP7sr6SjTJct3NB5Xy2NBM9aHxVwhH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35312a4-45a5-4931-2b5a-08dbcb0a024f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 10:00:05.1539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yRvyZ3opYANjAHQ6kLDpzuwWOLzt6pL28eZUeO56RD+vyTY+RF2cBSGmLuCjhnCzBAnJd8EQjU63wzIzHQ8zzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4102
X-Proofpoint-ORIG-GUID: gthbG2EUuN_hOD4yLotPRMPXUYNVnei9
X-Proofpoint-GUID: gthbG2EUuN_hOD4yLotPRMPXUYNVnei9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
Hi,=0A=
=0A=
If tx completion and start_xmit happen on 2 different CPUs, how do you=0A=
ensure that xmit_completion will observe the values written here?=0A=
=0A=
Specifically, don't you need to move netdev_tx_sent_queue() before the=0A=
above memory barrier?=0A=
=0A=
>>> Yes, you are correct. I'll update the changeset. Thank you.=
