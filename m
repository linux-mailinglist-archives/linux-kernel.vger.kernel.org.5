Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2237D08BD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376365AbjJTGso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376331AbjJTGsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:48:43 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECCAD49;
        Thu, 19 Oct 2023 23:48:41 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JKt1G1007324;
        Thu, 19 Oct 2023 23:48:35 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tubwr9g1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 23:48:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXpL+sklOQuBSJEk6Ju5uXTsR9CyMhERDHpUp1enjA6FtxW5bAepbaaDhCSAoc5rYDQMslT2A1QUfG1LB4pr0GwHoR2HkLCHiRZFFB72EmQS433VBjqXmh80fXKV79IGGA5TbCmGNdjwZ9wQOZBHSzgfLRDpt82tulf1yvhecN6vEFy+WO8+jf7bqehEfi8eTiy7YXWiRQv3Wy/93CcXGl9clemoCuwcLnUT0aZMF4V4+IrUpTH8JYQGnWc/AstAhb3z6OkrJ3AI0lDKdWjNNgRIqm5PnAsvhy8JD2meTRcufWrJ8IUSSlS65bMzsZ83Y36IFJkrbiYwTro9bwgfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XO+hswHCk+6F2u9xfQLi9q6+VGw9vq6qZNYk2U1Fn0g=;
 b=PIqBkM9ESRSSLTm7T5o4+Gi74LjE+v38A9WKJNMWrDjSLW1M3YEGaXSmrq/5GSbWnpju5ka2g5KQZ21W+/YpLYvDk2LZ/3HuMU0XeFo5fBFYN4eV5QIe8PUkYtMx/jU2/uVvrma2zz/BTBTUfbnWbHlvhzhAuO4t0QhYbTz5VhqKtYX+EPCPBQcGoExkP8Pi9p0SV/Qf9cs6X5/ROQES9Tdv7vHEVriWay4xWTvYVBgEaF+9f6UoqOe2GdqGG6770uhN5cxDrylIwNnMei8/B8lcbRPPPZs3htkR73N3vMeIOciG4EfosqHJagE6jLNO3qAJ4lYdXtvmU1/NgzQDUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XO+hswHCk+6F2u9xfQLi9q6+VGw9vq6qZNYk2U1Fn0g=;
 b=g3C4G685sMr6lQQ0N1k2hh9ytbWCvhwL6ZK0wkNNUpPm+/1Zqc+3eYoQdWbu5km5WE/pjSW7owuY5xoekeJRWVZspd+agqwFEKvm05Tsskv232349i70MPrPn1v4IuX8i27xEzShNCKEKcP+8PHvWuz9bxssxHZMxyir8IfnYUU=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by PH0PR18MB4969.namprd18.prod.outlook.com (2603:10b6:510:11c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 20 Oct
 2023 06:48:31 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7652:bbbf:784a:bd40]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7652:bbbf:784a:bd40%6]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 06:48:31 +0000
From:   Shinas Rasheed <srasheed@marvell.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "horms@kernel.org" <horms@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        Haseeb Gani <hgani@marvell.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Sathesh B Edara <sedara@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>
Subject: Re: [EXT] Re: [net-next PATCH v3] octeon_ep: pack hardware structure
Thread-Topic: [EXT] Re: [net-next PATCH v3] octeon_ep: pack hardware structure
Thread-Index: AQHaABIUJ5/HUS8g4Eig936RtZ8cVbBQP/aAgABYbq6AAPKrgIAAt1xX
Date:   Fri, 20 Oct 2023 06:48:31 +0000
Message-ID: <PH0PR18MB47345CD3D2B542ECA944082AC7DBA@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231016092051.2306831-1-srasheed@marvell.com>
        <20231018170605.392efc0d@kernel.org>
        <PH0PR18MB4734672BE30C49F09E2C7D65C7D4A@PH0PR18MB4734.namprd18.prod.outlook.com>
 <20231019125107.5acd7c1e@kernel.org>
In-Reply-To: <20231019125107.5acd7c1e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|PH0PR18MB4969:EE_
x-ms-office365-filtering-correlation-id: fb8a6717-e3d3-4c7e-05e4-08dbd13892a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o5zZHCuVHVX9UNH0EmZX7HgIYWGs/dHMVYvwitc7htLGeR1ROwzXycR/UsLLBcFZNXtw3RlAJclqgqTHWge8I+9zsWre+RHgWTaNQFP2RiPM9vFX5ZLp334mBW8qhFi7nmzypZmpe+6oR2mI5Aiq3jgh/fhmRsNB6CmXqG/YVAOrhzdF6Q8nYs4WR8DXb57zCoJFzfkJQlRadThPwJkvCy4A/yPRJKCjPwrfjnVtZHiq5Qg2ELnMldBGJ2N1zubLP10g3EA5BYHHeG5TloHLoUpjipMyXLBMyd7eNp68kN/8spqvI94sgc5GHaXfAM/vPhWxM1rSW0te7yAcp+m8wbhyksDEwIQk02GRq7gJ5k6gtFJ0HTGF1fHHO/dAXUk/TSI6JTWqghHvQn0owYFjnfGFQNRGOqflHdFilWU1BJ4j4geNchUrh8Ouc+QYFtSfQFaddYiFWV7l0Ea8NUASEFOOjyC17n577Juigtn3zhG7f0rL00fABkYF0mOi6w0znkhWh7Zv0A8Kp5+hdD3TSWu2B5qwNf/I/kHufkxkLruWghUrgSkhMWDx8eKOgpuGgVwl5ObTCYRFfyA8lYzDI0S3zYLUBYwoqT643FAE8EGK5VnESi9+SN6uC9DIa/xS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(91956017)(38070700009)(76116006)(66946007)(41300700001)(316002)(66476007)(6916009)(66556008)(66446008)(64756008)(54906003)(9686003)(107886003)(6506007)(7696005)(4270600006)(33656002)(558084003)(26005)(478600001)(71200400001)(38100700002)(122000001)(86362001)(55016003)(5660300002)(2906002)(52536014)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3gC28yhgqHXOnjJr2LT0qNb6IQzYpEl6chsx0uTZg1j24PQkq2FtzKagR+?=
 =?iso-8859-1?Q?t4bQkMiENUoVcIRcE4de/S3MAuYEqu2ga4t3HDtqKple/jXHCNQDmvrcLp?=
 =?iso-8859-1?Q?P9+fNrPRcwCTE7Ow8KPqbZyZq3mXUXlqpBN+uM86QYHpZ8avyhpvOooMw1?=
 =?iso-8859-1?Q?qACELMGvokw52+FOdLnFAuaOz08bC/WwBvnsm3QCMWgJen30drLdOJCxAF?=
 =?iso-8859-1?Q?QB4bBFLpFtpprwBCT/jlvuAFinuO+iJ6ZrKB4sM94lE20k2HYYH49oXPZy?=
 =?iso-8859-1?Q?Bvo3iAZT0wxdHnImlabKfjAvzdX1lWd92yj2KNZNFk+1diMI6z7zFB5QCL?=
 =?iso-8859-1?Q?wHKOpRAVrRRBqfqicKvCNbNpDBkiwvwJy86wsoAaRiW9na+//b3GvbrL7Q?=
 =?iso-8859-1?Q?tQN/6z4y4rOBq2qGweaGhjPAHVcl83cZo1bOm/qavgwoLNZcMWf0rlUkHy?=
 =?iso-8859-1?Q?gElVD0Py7H2IjG6ge7Bv67l557dgurNaRJ9J9ZIc1g0ReZB7UHAqysyols?=
 =?iso-8859-1?Q?0O5PZ9fsdMaWIgDeMXn4lpszkW3qDRwkTQl7DM6yQkVmQOuHGQq0yROM2e?=
 =?iso-8859-1?Q?NOvsID+S4a/5j1MMxnehx8PHcXje8eE3WdSAYTua1gVoM8mv+XzyOJeY9Z?=
 =?iso-8859-1?Q?bHiNL4lOdtu5M7aEEEncpHemq8zjK1toBJlyKw1ShaP7RGEmUZTGCp4+Tt?=
 =?iso-8859-1?Q?PUf/6s7fi1zphAB1ue0ds95uSUxk12H51i3cY92SLYYoQjIfg6y7LCClok?=
 =?iso-8859-1?Q?WdaDi1t8xRn2r1w7BuZ0WWR5z/vsVchnGcmygjqnh6Bl87UNAnc10S5Yss?=
 =?iso-8859-1?Q?DWfFJS4qrqcbNeOzfs0GH22Q8B5MxER7nrX2LVDB5CFHpX2q/JZMOnAaNN?=
 =?iso-8859-1?Q?0typJi0KdkV3ts0KGiwUG5rWtfBpO+8h3OG2OANVEKfeX1z1jahXH9oAt0?=
 =?iso-8859-1?Q?yJgEcnisryydkflxj6CANikejGG4ZFqOJiDyN7PjIqaQEwFn+NYh6In100?=
 =?iso-8859-1?Q?u+WMxYXso7LIY1o22aaqEJWjJfBAwxaPPgbYqGSaMisQn0zmYZsjau4n/n?=
 =?iso-8859-1?Q?kuuDr/bEKQIaOIJOb7uhMiHLhWY/OoT9VD5mhRZfZGYxti2kK7spqasgAr?=
 =?iso-8859-1?Q?NSJd9xVr3QiMUWydLx0ckmJdxDRZxC0H2e8I6qLe6rTA+y8pm7W2632Uea?=
 =?iso-8859-1?Q?T1w1l7V0/+rhMzd9ScCmCeZdkDbuT5HyRVzwaJpajbXVln3YklxM6Krnfc?=
 =?iso-8859-1?Q?7BseQOuDjIrcGyu+ieGfVb91aDDdgGMYZcg0FQtbYgEVAy/eyRX9q0U6cv?=
 =?iso-8859-1?Q?i2aG3ZX9SkVVatHcxE4SJzQTk3GHGL9cEs160a/wnquZcnoW4uGmlop3ya?=
 =?iso-8859-1?Q?R7ECoWI80PQRY4OVkF/ycEkAvS7tMMzokvAHah7nkppCgmWb2iVHgr2lMA?=
 =?iso-8859-1?Q?yUMEadK6OgTtM5oA1mhLa4WUA0Me3jHgN2OLBirv4OL62K8i9rfIfR5WZ5?=
 =?iso-8859-1?Q?XXyYZK3JqcunhliKMc2Q7FWbAbHmQzOeW27xVCwFlaEPXhs8V/PqVCbeeZ?=
 =?iso-8859-1?Q?pL7FjLTzjrJZ+Kl0v6VD+tJxRLVj1jPtIIINjscbQimnJGTZ6GwYSbfQsE?=
 =?iso-8859-1?Q?3QWB9TF01Sd4nzLhdIZlEEkQX5fdXO2RQS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8a6717-e3d3-4c7e-05e4-08dbd13892a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 06:48:31.1106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xuls8qW7yt5D4udtvjAeMXayfS1nYGalXpXezMw9u87Wlo7cNNieT3e3vT7ouOV2RmjEnqg6qSJEiFF5c/9oeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4969
X-Proofpoint-GUID: QQPWlIYdIng76kDzF_2UuvtEjtp-KttQ
X-Proofpoint-ORIG-GUID: QQPWlIYdIng76kDzF_2UuvtEjtp-KttQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_05,2023-10-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I understand. Thanks for your input Jakub. I will submit another patch =
correcting it.=
