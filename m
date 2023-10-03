Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E397B690E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjJCMcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjJCMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:32:05 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F8DAC;
        Tue,  3 Oct 2023 05:32:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3cYQssZJpUo83SubOTDFfjBpVe3U7niuXLy5n2/K/Z7N4QdLsHQypbFLQ2pcSD+wnC9jWvG+mW9ToPlPCLvBBS+nDjGEJM0cQE9dm6rEmMgqcYKXM4+EUKyYRvgmgcf1CN0QCEcv3NPyYP/RkGWVmrK9wHJ6ORu77f1MjTtKT/Syebznf3hw8yG+kTqI96oH0GBJQjmQ9khIajvQolS40r/NaBr6cKNIAXpxXy+WePEaNrrEb16Iacn7uY0fS+h947ambwNSfn/h7l7PrSAOZhpQ0ve9kZjHJRWbFCPUH8OaOrkxuCyN6oDxXFOYbqux/xdfN6K5zhzfuW23RP8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBJlsczxqKX5mFisf9KSt7+xXNfOIZ+s7MyGpMOCeGU=;
 b=QDkxhfqverDYKAFPZ8lc89E34/yrAwllRp+0R9tCqeKc5po0WqnIqgyhfjtB8Z0zo+1ynaTvG1fS6ceE4lPp6K8oVcoGJQV5t/uTE0JfjUkJ4S9ei82IeT1tin1HmdqQshVhoz4ZhmzvOtMwWnputthkUtpFMbqaPU7AwU7uobgpD3SuiFgxq1RfxiyFQuRMk3IAPE1eBusajfpCIMVqS6FhYMvJzReIvRSO8AGIHgCM5TojqrAp8PQg8G9yRNpE2IiSU8QECf257LKem6QHFC/h3LFXPN3xkFyIYrEpFSrvN24PAzSBi7MJF+kyI4jujkbac96Uh6caX5T3kX2keg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.19.86.146) smtp.rcpttodomain=gmail.com smtp.mailfrom=nordicsemi.no;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nordicsemi.no; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordicsemi.no;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBJlsczxqKX5mFisf9KSt7+xXNfOIZ+s7MyGpMOCeGU=;
 b=kzp3/6y5gEga52X4i5RaCLH2Z1JFTmiFQg9NbAo4Wufsn/dSnQ3YYUosVIX/cEaGvVMR2pWvYiHh32vjDkC+mdmvq9usMVZZT7+Be++Iym8pAXfVNDhX9jPS8Ll4EvroZLrwdahTju20qz247bA7D9FXXaKYr5wGKNuCnVM2j7MTfQBVRTAL5sRpSyStOPJa2+jsjYGGrCvPOjOsB/53j0p5Yab6K9SSR8sCEubwauh2nkJpAsYnnnQIpRJPPko2/avZuQjXScn8ZmNUkxiq62Wf6t0ro4qHlySe5RSv5J8v7pQGmCLYjLQSi36CaM9UE4vzWbTmBDHpmJy7jUKhXQ==
Received: from AS9PR05CA0049.eurprd05.prod.outlook.com (2603:10a6:20b:489::9)
 by DU0PR05MB10209.eurprd05.prod.outlook.com (2603:10a6:10:42c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 12:31:58 +0000
Received: from AM7EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:489:cafe::ca) by AS9PR05CA0049.outlook.office365.com
 (2603:10a6:20b:489::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 12:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.19.86.146)
 smtp.mailfrom=nordicsemi.no; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nordicsemi.no;
Received-SPF: Pass (protection.outlook.com: domain of nordicsemi.no designates
 194.19.86.146 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.19.86.146; helo=mail.nordicsemi.no; pr=C
Received: from mail.nordicsemi.no (194.19.86.146) by
 AM7EUR03FT031.mail.protection.outlook.com (100.127.140.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6863.25 via Frontend Transport; Tue, 3 Oct 2023 12:31:58 +0000
Message-ID: <834062302e6a98e773dc4b03d7ed568a0f1c44fc.camel@nordicsemi.no>
Subject: Re: bluetooth issues since kernel 6.4 - not discovering other bt
 devices - /linux/drivers/bluetooth/btusb.c
From:   Tomasz =?UTF-8?Q?Mo=C5=84?= <tomasz.mon@nordicsemi.no>
To:     Erik =?ISO-8859-1?Q?Dob=E1k?= <erik.dobak@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
CC:     Linux Stable <stable@vger.kernel.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Mediatek <linux-mediatek@lists.infradead.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Marcel Holtmann <marcel@holtmann.org>,
        "Johan Hedberg" <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Date:   Tue, 3 Oct 2023 14:31:39 +0200
In-Reply-To: <CAH7-e5uspavg_VBJxKLOKJfU3nAq-OrPqzihF2opffY-ReiC-w@mail.gmail.com>
References: <CAH7-e5sb+kT_LRb1_y-c5JaFN0=KrrRT97otUPKzTCgzGsVdrQ@mail.gmail.com>
         <ZRtWcgiH5JhD5NU2@debian.me>
         <CAH7-e5uspavg_VBJxKLOKJfU3nAq-OrPqzihF2opffY-ReiC-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Originating-IP: [10.241.138.38]
X-ClientProxiedBy: exch02.nvlsi.no (192.9.200.127) To exch01.nvlsi.no
 (192.9.200.126)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7EUR03FT031:EE_|DU0PR05MB10209:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e283098-08b0-4a8d-6095-08dbc40cbc71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l75YzwBnmuyUnny6ETO4eDX/JUDdo5AEAhh4/4HbFY3Gcwbk4Ec4Gy40GGapeZzoROxbp1dykeb4zbv0uZWpS/7vmtyIsRSQXzmw05uG9oVT2eElUx1a8yK6Yt8z0AhqLnqPZYFebhW3QgnHVUjkt1O5lgJtd+/2V0+ATWlUmOArpRYT8OHkxqu7jZfoq7OnqrO6P2Mn0ld8PTNJUUqUQYmlBcFrMUXtz06j/VeyeaBGrKcbvyQBvW4iJQe35XwAaqgIqCggzSVmQ8aTvLr4kKBRxQ12k6sC3mXc7+0be4eth7URzDVXqYXaeniFa5VYEt64RGg57yB1qeK4vTahh0xy3BTdppAt4uKxyk15r8CH+/PMS3RXlP0taGp/jhVZF0QBHAxItTMCh9uoMwEjpgI/Z/OXa+TDSVUiy+zgQeSbPls/+UV154PqLR+7Q1xb4B/BExHnLr8jLFp6Vr72DiyvKh3jOIB+4+EOV+/PrZb8Ao4srkW630Ow6vtcbkTSLggllYfqM/KFXPomiqXepGK2PycJXwK1o+rW/v5Fa5adkUZacifZID61vAlPpdYNKTCOd3rSDRqt+Cc6it4ZEutgJrAZeWNW5jJdeREE5Gx9rUGdl2gLywQCd9M74Mu8Qrs3F8wKwigIGTOc3gDDu3G5QJPyV1DKAjsPHuYwtghYxH7bsB8ymnBc7b+Z0NS+vD/bbZmmsJwmS/MgP6d8oQ==
X-Forefront-Antispam-Report: CIP:194.19.86.146;CTRY:NO;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nordicsemi.no;PTR:mx01.nordicsemi.no;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(346002)(136003)(376002)(396003)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(9316004)(36756003)(86362001)(118246002)(40480700001)(336012)(82740400003)(2616005)(956004)(26005)(7416002)(6666004)(356005)(7696005)(4744005)(7636003)(478600001)(47076005)(36860700001)(6486002)(8676002)(2906002)(4326008)(8936002)(110136005)(316002)(54906003)(36736006)(41300700001)(70206006)(5660300002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nordicsemi.no
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 12:31:58.2630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e283098-08b0-4a8d-6095-08dbc40cbc71
X-MS-Exchange-CrossTenant-Id: 28e5afa2-bf6f-419a-8cf6-b31c6e9e5e8d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=28e5afa2-bf6f-419a-8cf6-b31c6e9e5e8d;Ip=[194.19.86.146];Helo=[mail.nordicsemi.no]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB10209
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-03 at 14:25 +0200, Erik Dob=C3=A1k wrote:
> Hi i booted now into linux-6.6-rc4 and the issue is still there. No
> bluetooth devices are discovered.
> with this device: Bus 001 Device 004: ID 04c5:1670 Fujitsu, Ltd Bluetooth=
 Radio

Can you please be more specific and for example attach the full
descriptor? One way to get the descriptor would be to run:
  lsusb -d 04c5:1760 -v

Best Regards,
Tomasz Mo=C5=84
