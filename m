Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB07EDA8E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 05:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344582AbjKPEDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 23:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPEDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 23:03:33 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2068.outbound.protection.outlook.com [40.107.215.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B84F194;
        Wed, 15 Nov 2023 20:03:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU8nafaGcvJIXwP3qsJp3pufIrvzo6N3QB1eGCVEjriNaFFNOCqy+A/DPTTlx7Bmk9YQCAHHBjifmvOvhy3AaB8YVzIrbdIYT4YV6kzfO6bX0TVY/l2uhHiDiHCT+g5Z06aeO9zGIin5qCif3XvozvaUUDea6wCzJ4x5PLOdrcIZ5MSmKY/ACLhojReZ3bduzOfvzWmI6KUd6nawekIx+fv1ywJLCF68rnzVtfTk4ulc07HqR83d016ElK/yttampxb2OCIV+2zvGcWkaJpaMjRGopRelFadN2yAtUpGqj1bAtLFlxj/id8CgUL9E9LyeNvaKD/CFpMQtVLfz6WBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkIpYmfnmy1O0JDIr1mtTZa+OlWUjQo3eWypg7vFhFc=;
 b=FF2nIu7A6cseAJ00oD/7et+1YbCbomgjtCigYeIN/0yh3mD18xSpV4a1Tqif6a7exr+mhXr5A3CKZER43ReKWpZGZQCzyS6ohE168WH77nOlAjBD0aTNtIXx+CEYiCYJdsbCzkp0fR9Ydiwsg3zYmPIxoJbHni6Ezrjx9D5rvuMkJZz4L9ZjGqQ/Z1vqbqUuKjujooKiSgQRciyWBEK/9/MUv3t07LUh9bvjtNijVh+k6RvednjyrEoAzMxSZjmJc6KP4uDrftEXNUWjRGcwChAxSUf1iUxrqva2BkNmNz7NQ7fkYJyNGfe1Th2FYXP/ayH7RFVqF5GkUAl8GbidIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkIpYmfnmy1O0JDIr1mtTZa+OlWUjQo3eWypg7vFhFc=;
 b=Azxbf3kzA69Nct0J+iXo6vTYP2Hr7GoA45fr7FsXGT2CfhAWPxwavzN5Psq10h2w1cYbV6h+JdPhrwp2ezraAj/skAVjXgWyPi7o46YcQXOl4TL43vUntUJwwBZuAZdqk7uScSshNGZI24+Laktbh+EWSxEzaYVWQ2Z+e/YO4gI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KL1PR01MB6199.apcprd01.prod.exchangelabs.com
 (2603:1096:820:12f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 04:03:25 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::e90e:640c:2742:6339]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::e90e:640c:2742:6339%3]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 04:03:24 +0000
Date:   Thu, 16 Nov 2023 12:03:20 +0800
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Brenda Streiff <brenda.streiff@ni.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4] tty: serial: Add RS422 flag to struct serial_rs485
Message-ID: <ZVWUiMykxXsuuxMd@moxa-ThinkCentre-M90t>
References: <20231113094136.52003-1-crescentcy.hsieh@moxa.com>
 <c6ea912f-d5ab-4761-813d-3b6b6be141cb@ni.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ea912f-d5ab-4761-813d-3b6b6be141cb@ni.com>
X-ClientProxiedBy: TY2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:404:a6::22) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KL1PR01MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 711f2663-0144-416e-dcc7-08dbe658faef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HjMOmPsYiNAUhSxMj6RBnWy5lj9RN/PrG8bDwQ6UZgVMe4CVDWZoy8ISMrzqEpVvHvWR/5otuDA+7eexhHBnhtrJwMuN7+5176W4RI5stPry1ubQxoqaGUTQ57vNZLikcI4uWvWFgw1TQR51psGLsvg1HW1zNbHbgB21C9NxRWis3MJel+0GbxSkXjujMNDwzLg2EVWhLcg9f012DQ6f+VPO9tAWZLbSBOtoK9EylA4ksVZLwyyF3LLrg6+hked18xD3MuUStBgyTVCaESYzjn98UDZwvk27Ja7iiLLFY4OOwBC8x0ISbHrpc4ZVGDk6VXvUp+2F+6oCP3Vksc4JDpF+pSi9hsJhYNT8cTZ8fFPdy5npd1RQR6rVORVslpNw3YgdGIBMhThD8qBSWFC98By+U2qQ2pZa+AwO8y/e66g4Ng52mwkg2UAGX5rO2QoNtr52cBaxtwgAiaTK5911sLP32I4UK7wXw045HhO38vldY42FtXl7iMxLwwIv8+5jYpMkmCZsCf7ZKCMjceQKL4ijCgHyXLB/UdQt9t3I8rbT4BbGcX6Sba6cn5uo/VQXfYGE7yWHg20xW1ox09SOaK8i/zPk0AMxNKOEQGvtWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(39850400004)(376002)(136003)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(41300700001)(6666004)(2906002)(8936002)(8676002)(5660300002)(4326008)(38350700005)(66556008)(86362001)(66476007)(54906003)(66946007)(6486002)(966005)(316002)(478600001)(33716001)(6506007)(52116002)(6916009)(6512007)(9686003)(26005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tkifJFF2GWkWiNvr7H+68ClD0yVMKUKA0p7qnotMqYuLPHvln5lDVlMbGiT6?=
 =?us-ascii?Q?+Uokr50snKJN/Yu9Xm5IDegdg1RKvPPthFhCpUKFHT/N+kfz5vwp88efMcYF?=
 =?us-ascii?Q?77GoW/8OJpZlWvowDKkVYNwLKJw8ywoXtF9xF2ZnAMyda8wIZuWycNcSFLGs?=
 =?us-ascii?Q?A5NEQuKcvlBXSOxBX+uu8Sbt4wAWTrpNb1fN+kiK15DXMZavpXMSZcmWIfWG?=
 =?us-ascii?Q?JzbZBzyYO886riAyOrC/O4cO8xtppZ2NTqmM22V4z5AeDQ5PCnyl1LrgU+Nw?=
 =?us-ascii?Q?eIJ7etckEHfHSCvMgfTLJ8sP70YOhnvJ1NxVrIDeRFVgH1PPK2qg5OimnmIb?=
 =?us-ascii?Q?+qcdE4rdHwZWsyeaFdeKK2PkNKSefEZlpdbw2HEsAlV47R9vlV3C2kkndhbC?=
 =?us-ascii?Q?Cxdum9RCIm4R8HKA8nsi/hvfYAgU1UPs81YV9ySHFkQ8wG5Fc0NvKre7PBHw?=
 =?us-ascii?Q?iEasRQDhN+cVT2xy0I/3oK4WCNOmQqxHSEhPmSMmSN5zyq0fXrYGSe0a1g89?=
 =?us-ascii?Q?1gZzp1WrTk3I9qsKVZTNrLHY2fxHb8b6fIjLr/+iq3qB856wvAFOYfyeZrPa?=
 =?us-ascii?Q?L1fFJhouyTLwYb2Izr6BPnjchc3fIaHjwlB0QCremqNYuxj+MGXbaXYdsLNI?=
 =?us-ascii?Q?LEpx25o/8TAiXKBkuyItgfvXHTvGoiY9YkE2r0qGZBJ/rZS7TtusUC3J4s56?=
 =?us-ascii?Q?hrNEj9WgFSRs2hFt1/rRTlUWsCIUUtuS9EzSTO4UByZ58DtREziU5Drud/1F?=
 =?us-ascii?Q?4i+v91rd5EPuev8neeF/kCdT7uT0TxVXpl16hSi601Qf8ZwqmO6rNj2LhJ/N?=
 =?us-ascii?Q?dglMeMFCU8ysAFWK+tFiB4WfW8QOTaGeoYf5nMU7fO9jdXv3YCmWHmJ7he1Q?=
 =?us-ascii?Q?gNg7/Mz+4JcpzqG6G/Nf601b3tIb8FIKCrlUsjY/VATQ7pCW4h+WxnpmY2Oy?=
 =?us-ascii?Q?k6C48QuYYBhRiOPGjpDnDvNodt4JzKtvbFjicJxADjNO9IvnoQ+re1XF/t1F?=
 =?us-ascii?Q?TrAbXDnWF3A8WK5HdNFJonVHJi9nQWvObLBKuvp9tDaxUzhGN5OMiJDz6q18?=
 =?us-ascii?Q?SIhMMPHodgGi8oWZ84QX3DyOg9LyxR0Z0oiWxoMBYx7JFUfuTFMI4mZLNE0v?=
 =?us-ascii?Q?eQSYRNeo6th85CklVdkYThnBlwaXvmWIwk2+X8EPmEwU3FjtQAkQMn4YvLdB?=
 =?us-ascii?Q?WZAojop818AAYcrYUNpiFQ0UnxQh710uOA8r+YMUuB3Ab3vu8ZxPmiOd7LVp?=
 =?us-ascii?Q?BP335yKH9OgixdrcbaCpJWb7onC31LpRPZm0ZFbDzOBefA89J+iUs8KyKP/H?=
 =?us-ascii?Q?VPho4FyiFkXqmOAizL1yr7d3HZsCYs146PSRxbnV+P+zjAS4emiKvlEdz7yh?=
 =?us-ascii?Q?3A0ZJpast7gIBAFE1rDqj29jzbco8ET/iGo7354trgLW0fYXAYMv2KmoqJNI?=
 =?us-ascii?Q?QJZq+hnKfKKRmMTkLC7eF3NIlt07YyrxRElZhmkGHedxS3qcxcRXNeMndQtT?=
 =?us-ascii?Q?sRxdlpi2gwgWOeXoClS0rimdZs6zD/B9BYFtVed82dosjGOuTfuhsZuQN038?=
 =?us-ascii?Q?MTPYyFlhmbyVDy/Bt+jrOX00fHLaqGLxHbe9E9NUFtXqrvxwV29nxd/H/czX?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711f2663-0144-416e-dcc7-08dbe658faef
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 04:03:24.6532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kC0JPGC9+3Zen3LcfV4CE4AwuJDq99OFukMo35Om9KlteJ1eL2tM0vjkQtOM5U1eu3bM7m1nK6yCHQx8q9HtYQk+j9d2GagrhRXZLfPlDOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB6199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 08:50:42PM -0600, Brenda Streiff wrote:
> If I compare this to your original patch set [1] for your hardware, then
> your proposed flag would be used in the following ways, correct?
> 
> RS-232:                       rs485->flags = 0
> RS-422:                       rs485->flags = SER_RS485_ENABLED|SER_RS485_MODE_RS422
> RS-485 (2-wire half-duplex):  rs485->flags = SER_RS485_ENABLED
> RS-485 (4-wire full-duplex):  rs485->flags = SER_RS485_ENABLED|SER_RS485_RX_DURING_TX
> 
> In iot2040_rs485_config in 8250_exar.c [2] we already seem to have:
> RS-232:                       rs485->flags = 0
> RS-422:                       rs485->flags = SER_RS485_ENABLED|SER_RS485_RX_DURING_TX
> RS-485 (2-wire half-duplex?): rs485->flags = SER_RS485_ENABLED
> 
> This would seem to create an inconsistency in this API.

I've checked the patch series of iot2040_rs485_config() about RS422 [1],
it seems to be reasonable back then so no one dicussed about that.

> I've also been trying to get a driver for NI's serial hardware upstream [3]; we
> have "RS-485" products that can do both RS-422/RS-485, and also have use of
> functionality to toggle between the two modes, so-- whichever way this flag
> goes-- I'd like to be consistent with how other drivers do it.
> 
> [1] https://lore.kernel.org/linux-serial/20231018091739.10125-7-crescentcy.hsieh@moxa.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/8250/8250_exar.c?h=v6.6#n459
> [3] https://lore.kernel.org/linux-serial/20231023210458.447779-3-brenda.streiff@ni.com/

Originally, I was trying to add a new flag "SER_RS422_ENABLED" to
represent RS422, but Jiri replied "Hopefully not" [2].

So I used an unused flag to represent RS422 as a workaround solution,
then Jiri realized what was I trying to do and recommeded to add RS422
flag [3].

Then, when I was adding a new flag for RS422, Lino suggested to see
RS422 as a mode of RS485 [4].

Anyway, IMO, it's more reasonable to add a flag for representing RS422,
as for the naming, structure or future extention, it would require more
discussion.

[1] https://lore.kernel.org/all/?q=IOT2040_UART_MODE_RS422
[2] https://lore.kernel.org/linux-serial/92aed0d9-791f-4708-8a73-4c78457a710e@kernel.org/
[3] https://lore.kernel.org/linux-serial/3332a86c-1a1d-4b78-bbfa-8ac3e2e642a1@kernel.org/
[4] https://lore.kernel.org/all/3fc18b13-fef0-439e-abf0-1fe4e46b224a@gmx.de/

---
Sincerely,
Crescent CY Hsieh
