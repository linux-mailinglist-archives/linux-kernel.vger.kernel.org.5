Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F2B758B97
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjGSCzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSCzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:55:43 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1051F130;
        Tue, 18 Jul 2023 19:55:41 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36J1vGiE003434;
        Wed, 19 Jul 2023 02:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=6+BGeLfrqRu3UQRG+A
        MBQnKYzEqQcxshaYmHMAaYBWo=; b=NFqlfKG0G1EjiQNstX+D3L12zkL6/qoYHQ
        GuCuzsfIrTsN2Y4V3mFAgbI8sYgNDnU6XVJTkfbH6wF0+QavEiuimTlnP0sKrV9U
        R8mL13DjneuvC9p0/zrdlKT18VENXF+R+33S5t7mii7xtHy9dm7SlhzM9Pk4HvnF
        6UAP7nvtlgF0B6HUB+9XGPcGdyISsLsJ4TMfDuune/irUXmaLooAKlMeozbDI+xJ
        a5Q/LVWrRksHmosdrhkk9d5E02Y+hD6XkjkEM5bAXs9gDeIffc/1PonScPu09NiD
        wKHhyqIJtcUgk/DCEuPS7EKumauTcUDBEWf69bS39P3CtANoK0BA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3run8ab8pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 02:55:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhfJW+cJlmTvAh5FvBwnmoYruHlWd6fHcfMzLa+goJiAygeUhKblZpIo9nnvkEU81vQLABqQAHdTy+tPMwwjvNsLMtQCjBP/KwPJd++LgZOZKK2OF73WKz9AurRMrqhPY0ahCSA24FMVxv2PRlt0zfyPVbnr2IAvAR70Y9P423L/0PsAnP+hR6o5S7qmA2LWmSyzt6FzuSo/DWIgSKC1f7MZnvshkuJcQ7v6QP7UaSIUlhA5LN2TKXtHFXHpmZYSfw5zAx04USiFdt4lXcqNx8jSa/D7+CwIwgqoA5SF42qfFxwAR3mp56az5/aIZ4s58MoGx9p7OesPyzCmy+9gIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+BGeLfrqRu3UQRG+AMBQnKYzEqQcxshaYmHMAaYBWo=;
 b=aa22wvHBAL/NRQruY1OEEP+IMiiHrnHEQlwzhmaKSUZIOum7Nbkr6ItZuz3Mzhheqh9bca/7KGQY2WsF7PBs0dTeE+hkFqxRwnQ+x2TtaS5cdxICFuqfOPa+sX5Xi+zubuei+HPdsnaqXD/j53HVD8EVKfXV2NIlUKy8NSBAbVk1OVqGwIH3Ny98jETpFP39c/1QLf4kZgpnbGThKSFMH2xrJOepe4cQxijKfr160AKgrGH3nD1v3MIMifDGlNwWyPlwLDiiKsKGj1hcb9C7EOckwNa+aHeXgwUu7niCrtChiLvcKv2mK6SBv3b0kKsaW1nJ7W/YbvVC80KbzoeD6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by IA1PR11MB7728.namprd11.prod.outlook.com (2603:10b6:208:3f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 02:55:31 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9%3]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 02:55:30 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dinguyen@kernel.org, hminas@synopsys.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, meng.li@windriver.com
Subject: [PATCH 0/3] Patches used to add platform specific data for Intel Stratix10 platform
Date:   Wed, 19 Jul 2023 10:55:06 +0800
Message-Id: <20230719025509.3007986-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0119.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::23) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5191:EE_|IA1PR11MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f9834e-cba4-46c0-9966-08db88039c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CqblDRrMVKQJR1FLPX7k3rWc9dkGhkC6HRvhOno50caj3KBDgaZN8vukNUcxNyc4yf2tfzXj34lbPpHGKKP9xKK/c8xJGQ6kE9dxERY28yPG1FrlqJY4Ero6o7yDYiyoSA9Q8QVjfSrHUatM6m13nZ2gw5mRTrEjjgFEyH7Ec75LQ7ZULKJ8D0u/bK7lTOshYV9PHhNREQKXgd6Y3LMktlJ/4O3jo6EsN/wpV+KqXXSASh6X9IwoSK616x7ZPjxYd9iaT3ISgJNTAtLZuC/bFKN4oGuUrehXAhVRDRpzGakI8+nOO0YmY0wEkcbuUQf0npFHJ+RM/IK/mvStRszML+m1/s5r6aC47MpWpZLfBRA2jhLVk2I7qFphzOB+mztPPfaEQLRyNusKcsgtamaOFT+LQCfGEw0aN4PCJwQkP1MXWPK2GheNbEXaDCp/pbjo/XNKM5uHVNiF3eL4uVa1jr6ar3vtgngWaT7T+/S9wXoEj68vvjaS9w29yOHSBy+SaWmp+Bybi7hfJ8j1l+M5ySSpNAW0x+aSL/XJCOPx5bhH00hgvuCd/y/Dp1bq469hwRx0U//J85eySNz9Yo2DqCgEY2EdRh3qeztSsva6zUC/jpYPoY73aQrOPswOSGQV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(136003)(39850400004)(451199021)(478600001)(52116002)(6666004)(6486002)(2616005)(83380400001)(86362001)(36756003)(4744005)(2906002)(1076003)(186003)(6506007)(107886003)(26005)(6512007)(38350700002)(38100700002)(316002)(4326008)(41300700001)(66476007)(66946007)(5660300002)(66556008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4l6bZ+gfzJaJSG4LtJ6t6MMagb5BZhKPsVrfqDBWkjbsK7GN1PFV026rf0KA?=
 =?us-ascii?Q?Rv06Pj0eJKD69bm0TO+XRGwk1/mXg8BLregCaksC4MZyeMRJV5LVvwkroIZA?=
 =?us-ascii?Q?H7oVJsEKbUGbzZaUvJwCEww9s52q4iS/KQYMsbw37FxbwAJKe+lZ9wabTm6g?=
 =?us-ascii?Q?zqtm0MKkO6SvtrZ2AbfHnwWIEu4U1XKDBhVOPe9nostAleun0MRyRDzbLT8Q?=
 =?us-ascii?Q?BRxJyBwBdEfVpD55PChN+deoPPeHKLqHXOGKPkof5ejA2/pUDyTjUkagLFzV?=
 =?us-ascii?Q?RDZb90UGlbTuI6w3lFsFeGOXnALd/Jgrqd3rhqvjD3Yst+ZMmfI2V/YIxqOr?=
 =?us-ascii?Q?urdOqTwvD6krXlYexUCM0C8wchALWdW6UxgyZStvtPJkxP4+JQNWkqXK1BM7?=
 =?us-ascii?Q?5O1DtTyD3MBG4nvsDMfCospqvSkFoJSaUq7rtFc/0aQhjW3gciveCwmdjB+v?=
 =?us-ascii?Q?fC8NdSlViz+ts2s5me421AajSZ066Lrz7FaCkrPfzl7+5W6JY9sqTAsB+/Oz?=
 =?us-ascii?Q?ha+s7Lprc43N2+gfCR+2z9ifgZiVQhhbPJwYaae3EaJBAsy1bD+12OEaeVHn?=
 =?us-ascii?Q?bv4k/d8Q2uIV/cEv4W/KTU6vJfiAdtj+F2ym+UJewi2ZrieVL5RM2B4TEnZ4?=
 =?us-ascii?Q?uZf82LK4KCkwbQyUuTx3DfFG2pWQlwVMlhqGDHiLqoJSbzv9D8tBH3PbcMuv?=
 =?us-ascii?Q?slurKXbHdAO6rgPuqm46+nlRv99mvveUSv7EPKN7hfRtedAv1sT6GUK5CX+w?=
 =?us-ascii?Q?cJEUfO1ieB4xDhX06F3xBOIiofm04El6f7nCvjTbK20Te9FkpJC14Hr5u/Go?=
 =?us-ascii?Q?VxW7+69MSku+drRaOoRTuh7Z2BJofzYyb915Qya7ZmWqtOsAnqlqusiWmJPj?=
 =?us-ascii?Q?mWvq//3O2xFPmoaBV6r6dx8muNBjZD/XVW++98TN52IGvlKlf9TcYN8c1pyQ?=
 =?us-ascii?Q?iGBrbMVqr+jaQB2m7d7JBpOgQYP2KG7jgGDmPBVTXrNUV3VUZFy/uuDQXCOY?=
 =?us-ascii?Q?7n7A1vU3sv85x7QDqxIgFOIVGOxmVgn8saibAQEuzKjSUidoj+XU67Iw8jrI?=
 =?us-ascii?Q?4ze9Jgd9fDrnMK94IA8qTze7zio0BoJ8GuZoD8YJTX2nyrTK6z+iM6BzW0un?=
 =?us-ascii?Q?/OWbqNKfly81o1eQanoJI7g8Ta4SZCTYRqN/7eSBGMZcKTlC3prPBiB5hHO5?=
 =?us-ascii?Q?MsS6eJTePSW+PNMhoNN94YgJ8YBX6FR1qqpaVLP4LEqTbitDF/3nX2uxwi0+?=
 =?us-ascii?Q?2Plq5DLwF61O7Fy9cRCnVVjN2MF5krshAaEnDMw0LrcPm02hdShaLGK1jx4/?=
 =?us-ascii?Q?FKOuASM0Uf4EfEpjbFJOoiCKX1xl52nHFfcV+8N1JfJcKSKnzhCsFiSkT/P+?=
 =?us-ascii?Q?fI6XVmYgIfCQnHD+3gJPk/xlOTS+LejjAwxiLeuzqbNphTaEj4njldB8ShQ1?=
 =?us-ascii?Q?V1RdHCwSiRIHTrKxdDMbKNXGhf89oI1P/y5soWO/WH5TmQhni+Iz2XmPD3g+?=
 =?us-ascii?Q?1+WJPLf5N0hbgbcCEtYcqq5VF+ixUgj8wC9qowwGPdP2pggoFj8+o2N1iX1+?=
 =?us-ascii?Q?sQkGj29ed7tEo3GHMR0ObmcNWenICJyM+Co1x8De?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f9834e-cba4-46c0-9966-08db88039c9b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 02:55:30.1788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qzai6w92/2pZjiwLqYYbvbZ1p8TBZ0zTe8Fy5Tg1kTWI3zxniM2C8N4lblcHiylxGD6oKha2UHSEAYRcv5AXng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7728
X-Proofpoint-GUID: hiOZCw3l6_DdEFSEG5Kp60kgGV3fABnM
X-Proofpoint-ORIG-GUID: hiOZCw3l6_DdEFSEG5Kp60kgGV3fABnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_19,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=690 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307190026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***

Meng Li (3):
  usb: dwc2: Add platform specific data for Intel Stratix10 platform
  arm64: dts: agilex: use the compatible "intel,socfpga-agilex-hsotg"
  dt-bindings: usb: dwc2: add compatible "intel,socfpga-stratix10-hsotg"

 Documentation/devicetree/bindings/usb/dwc2.yaml   | 1 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 4 ++--
 drivers/usb/dwc2/params.c                         | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.34.1

