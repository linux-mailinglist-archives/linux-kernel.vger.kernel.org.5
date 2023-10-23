Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DB27D373C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjJWMyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjJWMyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:54:45 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9640DA4;
        Mon, 23 Oct 2023 05:54:43 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39NCB4N3018149;
        Mon, 23 Oct 2023 08:54:36 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tvuseyh5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 08:54:35 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiMwPOrpfhvY22Mwv7iPEYaNCkQboJ+VDdExJqDxvPcfTfTRJXR9Uq85DGC5gI5I3YZAGdK9021ABp8iv3WUWrOyzX8A3Hhjw78rjP4d6uKTCEMMVrY3gUe4Ws6aljEeQewXYiYn7vWiKH++9xBxD2/vFzHN0xDlLDitwwVnVUwATv1d8pZBnMZMpnDHtun7AyiP4IGrn7QNGo1wUZaKXHSJR/5KMUOvM27+/uuFeXAqhqyJkkwYja9A2USLvSp9JJr8D/grIlrxa+wfRD8ho6nyxodNbbcFzLR6U2PKCJyvGlEavjappKapBnifoDt0extvpB+Vd5PkF5CgSDh0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMoxsC63KiXv5nR1K+xNAj24YBVkF/cFmgDBbUSgs1A=;
 b=Tli2m/ve5yu64/IKaechWnTRyDcnpFLXgkbizvXF8ahSNgWz172FR2TmXUa1kUWniX7QwIT1cDFZjanH6vmCGALgsSzupGiewkD66CSKLIKCvsDDImgNOoEC1p3wLJdX5MeAQlzdrqZw4LDx0EkvrSWOzaZQ0qH+tJKG0EHj4qwR4JCAX9sYpZtHu/ZZM368ugS1NtEeR4vfswJtgHeYtm1yLIUUahSnpYV6KQYAix18StFAnyE+ZDYdG60VKxVZSJYBtaiyeDZOeJXOUgj29AkRC+LNNJry70dvSFHPlXg3FQc2UDIB9pE0efkgYYEiEloSw6h8on9AVwY6JsuYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMoxsC63KiXv5nR1K+xNAj24YBVkF/cFmgDBbUSgs1A=;
 b=CDG6qfXwuvB5wfTPc/fJN3HYdua73gv3/TBPp6VQEqXQEHgGRGjKxlPDtv1umoc2BmNOktebZ9CPcd3ReYHTbC2b6mcDfeYEJXPmdjYoT7fToZyLk9LOFY7oO8mzKVhDVwOa4kfNRKFRM6KDgHMwWIDkbOMqzgzJbFkN1BwODuc=
Received: from BN7PR03MB4545.namprd03.prod.outlook.com (2603:10b6:408:e::31)
 by LV3PR03MB7453.namprd03.prod.outlook.com (2603:10b6:408:1a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Mon, 23 Oct
 2023 12:54:15 +0000
Received: from BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e2c3:4dcc:c87e:bbca]) by BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e2c3:4dcc:c87e:bbca%5]) with mapi id 15.20.6886.034; Mon, 23 Oct 2023
 12:54:15 +0000
From:   "Balas, Eliza" <Eliza.Balas@analog.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Thread-Topic: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Thread-Index: AQHaAow+3kwQRklh0USw0Mt3uyHh0rBRZjoAgAEeXwCAADqhAIAEjRKQ
Date:   Mon, 23 Oct 2023 12:54:15 +0000
Message-ID: <BN7PR03MB4545FF54B96514EC9F41887E97D8A@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20231019125646.14236-1-eliza.balas@analog.com>
 <20231019125646.14236-3-eliza.balas@analog.com>
 <2023101917-cork-numeric-dab8@gregkh>
 <BN7PR03MB4545E7EAB2D72B9098C30C6797DBA@BN7PR03MB4545.namprd03.prod.outlook.com>
 <2023102030-resort-glance-57ef@gregkh>
In-Reply-To: <2023102030-resort-glance-57ef@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZWJhbGFzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctNDM2ZmU5MzEtNzFhMy0xMWVlLThkYjgtNzQwNGYx?=
 =?us-ascii?Q?NTcwNWY3XGFtZS10ZXN0XDQzNmZlOTMyLTcxYTMtMTFlZS04ZGI4LTc0MDRm?=
 =?us-ascii?Q?MTU3MDVmN2JvZHkudHh0IiBzej0iNTM2NiIgdD0iMTMzNDI1MzkyNTMyMTc4?=
 =?us-ascii?Q?MTI1IiBoPSJLQ0ViNDc0MzMwemtIcDJYZmZ1RWhqYjBqcms9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NBQURO?=
 =?us-ascii?Q?eE9VRnNBWGFBVXVSRUJSZnlsVUNTNUVRRkYvS1ZRSURBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQWxHVEdWZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBYVFC?=
 =?us-ascii?Q?ZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpBRjhB?=
 =?us-ascii?Q?WmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5?=
 =?us-ascii?Q?QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZB?=
 =?us-ascii?Q?R29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRh?=
 =?us-ascii?Q?Pg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR03MB4545:EE_|LV3PR03MB7453:EE_
x-ms-office365-filtering-correlation-id: 8b84ab33-fd13-4093-d421-08dbd3c7299a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vVBGQm84zwLC/dbwgI4vG7WYS9iph+Y2PsdnDFehI1zYmaK+ghsX+B+uPRCogoTuncJS/vIeGpc+JkDpI4D3sgj8QEMBxHjyg3Z2HyQXE2mi2EaxnWigRjc+UROp4jGwKjUh9KcaEjDO3r7BrTPrv/0jiV/k8K016QoEBSgodRKS8So0fkX4KlESf0f8EaI19KsY285CgbULEM3iMnQKA1GjzXUd47u1ev/0P2uzwYgaVggWb8STjPkGOvQ+HjGjibomebFYLM3yxvGxbSXdyOf6COC3jdr1SY/65+IGqi+XAUHd/ECr9nRdMCM8XJOyFz8NP7TALD4J2UCXIEQk3vgFzCp1fuuoKFW29u1k0/uh4C3Jmpe7e7mLibZGHbjU25f6KEuxAYlcrUsOufxr5QdX0XJT6Y9+j17wiprU4yvGF0dMSjNOxHYm54Ikh7chQCjnwxwo6vPo2pdKH53D9iaLEIx8lf1I5Bdh7fVX5ktWvlQI6NasL3i/laellLbdHunO9clpWBdni8CtzwSLEPVrfAssRdyzPJfGT0LxmP8hOPtlziTwnz4oUAV2KDdNq6vtByyLa+9ONShZxNwe+WDlLrerlkWXtssw+2m+TKPQcubLO4xpLIYymxjmwLwn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4545.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(52536014)(2906002)(71200400001)(478600001)(41300700001)(8936002)(4326008)(8676002)(5660300002)(6916009)(7696005)(316002)(83380400001)(54906003)(66446008)(76116006)(66556008)(64756008)(66476007)(66946007)(26005)(38070700009)(6506007)(55016003)(33656002)(9686003)(53546011)(86362001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zd6h473G3XxYopkWNwsTKqF4ZB5hy01YpTv/mfdpOvU6c5FseIo7JyPcGYIn?=
 =?us-ascii?Q?tCd4141SJA47FJ6emHbaJFSRSXRkyhDLnZ9A9qWW7X6+1RPob3HhmZmCTj8d?=
 =?us-ascii?Q?7g7qVnhDd4mifws+Wzf6+4vyucfQiD1z5TUyQNTL0+3r7f/lytDsKEOfTn3y?=
 =?us-ascii?Q?9xhRaJfv5RjlkD/f4MeVexr3cTvkkvuNaD1r0Qh3wX7NUPcaPrN2pX5Fa0Am?=
 =?us-ascii?Q?Ttn3pxbChpNoAUHXSSSYTCcpv3XmdrMcaUdnWs2RHBWozwLhiHEnfohVgOvc?=
 =?us-ascii?Q?nUd8zow2re4PTWN8BKu96R5grMFnHr+R/V4ZFPvcHpx7coWmKkSw7ImaYQoD?=
 =?us-ascii?Q?XaPX1v2mtyRR6MwZIe/TZfWBMHZC9EzzzYU6TySp00OJ8Kg/1sSS7x+PmTgu?=
 =?us-ascii?Q?2QDX5DkYHpmlG1fWMrm0+H4F7qU5SNV0h6NdqOV6Vfl6UtXyWmjrb9lsCz6L?=
 =?us-ascii?Q?AmWQ9K5/PiagQGN88Sk4l3qHHKeWGGpi4dCkSdOGWmTRXJI4xLrMZrpVLxvT?=
 =?us-ascii?Q?dp+tklVUwnYFe+KiXQ2ezxebSApGUrTrmKKdHpmnK37yR+Cv9oykNbhOHl8S?=
 =?us-ascii?Q?7PifAFyIuE5u4QBwVdfnZM9AE4CJyq0krLUf+yncwfU7j6pNlpti7tzGFMp0?=
 =?us-ascii?Q?5ykX6Zd8VBXd5BfsF9f/Apx/NM1R8bWF2CD1anaAfpOK7lZvIJ9t6CsmlyWS?=
 =?us-ascii?Q?tVrqkAqwLiiIGQ5zK4JCnVt4kC2kvkq9o8VQrunZYxKMTn6ZcmFWGVJMyPbw?=
 =?us-ascii?Q?35uvR7eAOFNPyHn2P2wJpms8HC2FMY1LmGkRxz0A5r3gVt+PYMVxTllAl2Zl?=
 =?us-ascii?Q?4jIBEPsSE7GE3x8nR4SAmTLnAeOf4LP72JjJP0cXVbMQ02UWz5aJU+emqDAT?=
 =?us-ascii?Q?kV6+mg4D803QTtH1r1rwvgbyW7jHz/A90aXwfB/cFWE8eRcPOuaKol+xFhfd?=
 =?us-ascii?Q?fbcBT8dEantnQEjRi/jeRGswB9ItC34USnfoRzcuLJA2Tx0WE+JRrtQFFAcq?=
 =?us-ascii?Q?qCebTfPViHPQ/I50z0Bnuo/Hcft6xQC3w3B6RFNyPbB+Gtf4YEKWtKlZqBnY?=
 =?us-ascii?Q?6PoMXS8MykVlRppwDGjO2T5lmOih1yg4czGsFfoo/kRyZMRzQMfEWAGWSWqL?=
 =?us-ascii?Q?bttD5Caz9ZUi18k1LIEwayo6W9hdr0IRVknqZ1QR7NHNp5kn8K6u2tudytSg?=
 =?us-ascii?Q?H93/wAp8Mxv+DSUTj/mPuvW/dZKK/KYrkLwuQONWessu+aSENhs4PfQ64/Em?=
 =?us-ascii?Q?f/7crOBnWKuFz28PYVSYoDs3O0lUu3fCnSL+TK/HCCVfnwWhyJHbcLnBL0ky?=
 =?us-ascii?Q?irV1GHAbFn67EyIfrGVdXp/cfMZ+dSFkMb9hEVAwU0qPp/irwRQVDWxwWUjx?=
 =?us-ascii?Q?V5UNnzje0YdqyIWMXjsrvTH7GHivQcp5sYaWtX9/RM7iCgUNPGHTQ9n2+kpx?=
 =?us-ascii?Q?qo9+MmbdF8kA15SGLWYDc7cQ1SPC3Efg9IFhZu9echm6oP8AZ5CalOSJ1BDU?=
 =?us-ascii?Q?dW9BfdKL2d0BnH+eWWCI+FKJlhg7vsZv7MMVCY7YrGU3hcs8mhQ3hh11VgHZ?=
 =?us-ascii?Q?tUvXZvh8Zk7GmRFvRCQODE4NdbA1umZTi2tFeX5S?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4545.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b84ab33-fd13-4093-d421-08dbd3c7299a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 12:54:15.2793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kvo+rE99cOww2E0YV+BzHRkG0ZPn/ZA85W8IyMMf6R448IeeMsIkUBjy+n2PH7UmR/DuLJrR99Rw4yKKrQbwkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7453
X-Proofpoint-GUID: qh44bE8Rg3jRDuxvLgadyMpiuDexP6F4
X-Proofpoint-ORIG-GUID: qh44bE8Rg3jRDuxvLgadyMpiuDexP6F4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_11,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2310170000
 definitions=main-2310230113
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Friday, October 20, 2023 17:32
> To: Balas, Eliza <Eliza.Balas@analog.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Rob Herring=
 <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>; =
Derek Kiernan <derek.kiernan@amd.com>; Dragan
> Cvetic <dragan.cvetic@amd.com>; Arnd Bergmann <arnd@arndb.de>
> Subject: Re: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
>=20
> [External]
>=20
> On Fri, Oct 20, 2023 at 11:18:44AM +0000, Balas, Eliza wrote:
> > > > +static int adi_axi_tdd_parse_ms(struct adi_axi_tdd_state *st,
> > > > +				const char *buf,
> > > > +				u64 *res)
> > > > +{
> > > > +	u64 clk_rate =3D READ_ONCE(st->clk.rate);
> > > > +	char *orig_str, *modf_str, *int_part, frac_part[7];
> > > > +	long ival, frac;
> > > > +	int ret;
> > > > +
> > > > +	orig_str =3D kstrdup(buf, GFP_KERNEL);
> > > > +	int_part =3D strsep(&orig_str, ".");
> > >
> > > Why are we parsing floating point in the kernel?  Please just keep th=
e
> > > api simple so that we don't have to try to do any type of parsing oth=
er
> > > than turning a single text number into a value.
> > >
> >
> > The adi_axi_tdd_parse_ms function does almost the same thing as the
> > iio_str_to_fixpoint() function which already exists in kernel.
>=20
> That does not mean that this is a valid api for your device as you are
> not an iio driver (why aren't you an iio driver?)
>=20
> > It parses a fixed-point number from a string.
>=20
> And as such, you shouldn't duplicate existing logic.
>=20
> > The __iio_str_to_fixpoint is used in a similar way, as I intend to use =
adi_axi_tdd_parse_ms.
> > It writes to a channel the corresponding scale (micro,nano) for a value=
.
>=20
> Why not just have the api accept values in nanoseconds and then no
> parsing is needed?

I thought this would be easier for the user, to work with smaller values,
than using a lot of zeros for nanoseconds. I will make the changes
to accept values in nanoseconds..

> > Since the device is not an iio device, using an iio function would be c=
onfusing.
>=20
> Why isn't this an iio device?

The device is not registered into the IIO device tree,=20
and does not rely on IIO kernel APIs.=20
Even though there are a few attributes that resemble the
ones from iio, and the sysfs structure is similar,
this is not an IIO device.
In the previous patch versions 1 and 2 we concluded
that this device fits better in the misc subsystem.

