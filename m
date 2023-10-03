Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6E27B69E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjJCNIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjJCNIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:08:45 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2058.outbound.protection.outlook.com [40.107.14.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE7390;
        Tue,  3 Oct 2023 06:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnO4SB47sj4pB6uiE9AUlox3+liDqaOAh1eEE8pide5Regf2B2urXH7GAXg40ZxZ5oBrUVLP/66gn4t9FfTa5OGquTogm9dkNs8apuyVkmT9nw22TkbpEw7gLqjpB7whKF++dsAAM9CelvGAnk3AsxO9166rYxfbesQEg7dfsHk1y8F8gFuaFxbYnS3TdZJq/P1TCeS5/ALi8ZaiRxmr4Sdo/XLpVBTNfLl7AhmGTN6QZoS3rBb2OWWr00ogyfLWwbvwGY1ktQLm06tEC9F8oS1gWXAfrpyW2sKGHPLK6aC6LUuzS9DHAumMIgnUPrRCss3KjTJz/qR1vqD4+iV6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9u6V0UP1yF0lbRwRj0p3ciRQWa73V/FyreOMa0xJN+A=;
 b=cRqAofqHMChBJNuXjAIzpxAmU1ChKS0/hJPiwE1Y1NwWQmgLB+v1PSP14sEak+JmFSOMZHK0AlBFOaYgFhGkzvMsunhlAZsqP1YZK8WcCQrgpnXFFwHZpE0TreooqbhLn4dL4sEyGyOzGNylRiONikoktDmngeHqmnexUZDNoclflx+IO1naGwt4f9hYhf1jdRxeZhCb6vJnq7/nGwCFPHtUsMUjpaeOI67dSecwe39oAckUcITgZQ402uIIXzfC6uB8tChsuCOBQ68RPSI+CQqHXGfg8cPzQRleA8zrt60SDirOKTHnhSQAe0Ey5OcYU0SigiL2OV+6sY9yFMYq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.19.86.146) smtp.rcpttodomain=gmail.com smtp.mailfrom=nordicsemi.no;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nordicsemi.no; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordicsemi.no;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u6V0UP1yF0lbRwRj0p3ciRQWa73V/FyreOMa0xJN+A=;
 b=U7KTLGCBWmHwZkVgYrxBaa4dykhYih8QzKIxEoZGy4M5GmZ+Vc/IuUC5NV6Oa8ABBSbJWN35ZNZ4BW7ZhkaxOC1gq3ib66hWZpEsU1zIAUoEtAsYynecu6ZkBKMPRO4vwDaL2B9+I0mEA4JkOUg9IAJuHeQf7KSvC/V+IrPLQdQTx+4GZRAjgJhNxAOkK2c/zhk6lHMW224vEdQBFK5u7u1mYspNnejM4MIfoVdq529cd6yqpwfd7nROf9PCYCx8Hjor4jqiZ/JkAZ8fSQFIytr/t9YFfcJf3sqqy/A3xsO8fwLCvunUO0m8WI1LqWRRWvD/rzrC32saDZJqndLFGA==
Received: from DUZP191CA0050.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::23)
 by AS8PR05MB8742.eurprd05.prod.outlook.com (2603:10a6:20b:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 13:08:38 +0000
Received: from DBAEUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:4fa:cafe::5c) by DUZP191CA0050.outlook.office365.com
 (2603:10a6:10:4fa::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 13:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.19.86.146)
 smtp.mailfrom=nordicsemi.no; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nordicsemi.no;
Received-SPF: Pass (protection.outlook.com: domain of nordicsemi.no designates
 194.19.86.146 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.19.86.146; helo=mail.nordicsemi.no; pr=C
Received: from mail.nordicsemi.no (194.19.86.146) by
 DBAEUR03FT040.mail.protection.outlook.com (100.127.142.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6863.26 via Frontend Transport; Tue, 3 Oct 2023 13:08:38 +0000
Message-ID: <ba7aaaed859ea2c4f5aac597deb382cceab33d65.camel@nordicsemi.no>
Subject: Re: bluetooth issues since kernel 6.4 - not discovering other bt
 devices - /linux/drivers/bluetooth/btusb.c
From:   Tomasz =?UTF-8?Q?Mo=C5=84?= <tomasz.mon@nordicsemi.no>
To:     Erik =?ISO-8859-1?Q?Dob=E1k?= <erik.dobak@gmail.com>
CC:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Stable <stable@vger.kernel.org>,
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
Date:   Tue, 3 Oct 2023 15:08:35 +0200
In-Reply-To: <CAH7-e5uZzmnFJAJrG664G6_JbK--DfbKC50aeVN5gMMxDJ51UA@mail.gmail.com>
References: <CAH7-e5sb+kT_LRb1_y-c5JaFN0=KrrRT97otUPKzTCgzGsVdrQ@mail.gmail.com>
         <ZRtWcgiH5JhD5NU2@debian.me>
         <CAH7-e5uspavg_VBJxKLOKJfU3nAq-OrPqzihF2opffY-ReiC-w@mail.gmail.com>
         <834062302e6a98e773dc4b03d7ed568a0f1c44fc.camel@nordicsemi.no>
         <CAH7-e5uZzmnFJAJrG664G6_JbK--DfbKC50aeVN5gMMxDJ51UA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Originating-IP: [10.241.138.38]
X-ClientProxiedBy: exch02.nvlsi.no (192.9.200.127) To exch01.nvlsi.no
 (192.9.200.126)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAEUR03FT040:EE_|AS8PR05MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb6e9da-034c-473a-e031-08dbc411dba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwhxN1KSJ1Hk1JapuNUx1OivnIvTKE9YD5oL12WWcQzfTY3ss2mPH1dgtVMNSZ55tg3qcsTw2Ks08tHYmr9J5WyOUv9IaBUrGTiMStEcY2YmlP09W5UpjJS9N5AijP2Fj+FZG96crnlCGI3pgkMUOsOGQ8ZGzME9PK71e4vTJyqKiw61JWYy38xdLrjiayXyUjncqG0gQtFL/PRVCqAS+diAqnmDOWnjx+7M9bIN81IDliycHc4MRSZkUzT1GhoBkQMSsK2xKKi6FMZ5cDYKriAejyS+YYn8ZkPuUUaKUfC+8nqmYwR/edhJVi+BxgZIvoMJfOwKbQH4bqdHxSzbCzMZohNdkRrLPbR3DZTVgM1i74useOCWAecb+HfEmWz+269X5m6GgSU3+ZGapFdxbNfP1/zOScdKOCHytNZu6RsmoF/+EjA3ch39SX+Yb7gkQqXaQhquv30uqxmOqs7Tdg2ewhQVC6cbCItGPt2FWASBTB5xHmcfCdZdhpEarEwDzdJHns8W5ui6+yZ7X6gODJMPp7zmsXDuaERet6ZA//i/c+oaAOc+HZ2V+5cGhcOxeGrrQ0qlJh6qOWXJc4PMTL6L4rJ171s51jo/iGXchyB1uOaz0Ml/aSyQ5y7cOgjrOXjsIRD29APVXFsNER0spfr+LhmeHY/hYm4XTmWSMO6HdgsF3RgVU9QEOPYTPlhl+XT01sop/DdC22sWeH2hxQ==
X-Forefront-Antispam-Report: CIP:194.19.86.146;CTRY:NO;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nordicsemi.no;PTR:mx01.nordicsemi.no;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(376002)(346002)(396003)(136003)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(64100799003)(36840700001)(46966006)(40480700001)(86362001)(7636003)(70586007)(356005)(6916009)(82740400003)(70206006)(316002)(54906003)(36736006)(478600001)(118246002)(2906002)(7416002)(4326008)(5660300002)(36860700001)(6666004)(47076005)(41300700001)(6486002)(26005)(956004)(8676002)(2616005)(8936002)(7696005)(336012)(9316004)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: nordicsemi.no
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 13:08:38.0270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb6e9da-034c-473a-e031-08dbc411dba1
X-MS-Exchange-CrossTenant-Id: 28e5afa2-bf6f-419a-8cf6-b31c6e9e5e8d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=28e5afa2-bf6f-419a-8cf6-b31c6e9e5e8d;Ip=[194.19.86.146];Helo=[mail.nordicsemi.no]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT040.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB8742
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-03 at 14:42 +0200, Erik Dob=C3=A1k wrote:
> Sure here you go:
>=20
> # lsusb -d 04c5:1670 -v
>=20
> Bus 001 Device 004: ID 04c5:1670 Fujitsu, Ltd Bluetooth Radio
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.00
>   bDeviceClass          224 Wireless
>   bDeviceSubClass         1 Radio Frequency
>   bDeviceProtocol         1 Bluetooth
>   bMaxPacketSize0        64
>   idVendor           0x04c5 Fujitsu, Ltd
>   idProduct          0x1670
>   bcdDevice            0.00
>   iManufacturer           1 Realtek
>   iProduct                2 Bluetooth Radio
>   iSerial                 3 00e04c000001
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength       0x00b1
>     bNumInterfaces          2
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xe0
>       Self Powered
>       Remote Wakeup
>     MaxPower              500mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           3
>       bInterfaceClass       224 Wireless
>       bInterfaceSubClass      1 Radio Frequency
>       bInterfaceProtocol      1 Bluetooth
>       iInterface              4 Bluetooth Radio

I have no idea why you referred to my commits, i.e. c13380a55522
("Bluetooth: btusb: Do not require hardcoded interface numbers") later
fixed by eaac6e223a0d ("Bluetooth: btusb: Fix bluetooth on Intel
Macbook 2014") in the first place.

BTUSB_IFNUM_2 is not even getting set for this device and therefore the
patches have no impact on your issue. If you were affected, like the
Intel Macbook 2014 was, then bear in mind that the issue would manifest
as btusb driver not even binding to the device. From your emails
however it appears that the issue is something different.

I honestly don't think it has anything to do with my patches. If you
know a Linux version where your bluetooth device works, then the next
step would be to bisect to find the first bad commit.

Best Regards,
Tomasz Mo=C5=84
