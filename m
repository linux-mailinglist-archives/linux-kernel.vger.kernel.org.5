Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC0A770867
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjHDTB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHDTBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:01:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2017.outbound.protection.outlook.com [40.92.99.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D71746B2;
        Fri,  4 Aug 2023 12:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISD01az3TIb5KyFbFUooMdhNkI5me74X270+gYFtCQCYa6DeDkfGjq/bEQV7GvRhltrYI+3eLjUIlmjXSz+YNmqvzWWU+gBeQggXOYykPeJfQBdRQARlJvXeYPWcRP4+pbvk5rbX8uXrVszzTbyEU9Kp+rcIprht8pHEMPpDU80j7NymTgpkUJt/KLQqk14VB0Eo+3v8wl9Q3Ph2QzJs7Z3Ib/bI2rylp3XaGE3D41MKmyAD3OhFndPTGFJIYYuW4NS2Bu+KwcAwUSLC8DZhpzQJ9S7GzT1oH377oljJ2j+Yl92V/NmYQI5STGrRR/zUuVBWi29xdruQVHmCAl9ovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+w0bvnlDib0Eg1kvm2xvqqrnZr/teLu8vIlcQe1zbus=;
 b=LY82dNVej6oMUzvlyh6AhtJaTvIANYA33JoLSbIwam5cJ66J0chDcUc5IcwgQesNKzddStYsu2/zW0tBxwxJCF7sxDlViRXGUW/XTpO2wjfF4pPQrZQHcQxi0gY+Q3xnMzPJQ1FMMi2e1N8lbtUz6K+urtLrED7tYMDFNhhmfb6IzxvRVnmXrfADvRwgGHqZ7gZr58UC9tskyjN7KRVvUkuMMp2029sfHc+jx5of6KZg9vUaq/31MQAAgWzlEAmtWZGICJCv+0MvqalXpEFh2jPhZzpqkJQcIiEGrBN54TlSkkly74jq2IR5289NHVcI97nXXA/E90rgJK/8b+VhXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w0bvnlDib0Eg1kvm2xvqqrnZr/teLu8vIlcQe1zbus=;
 b=AppVCMFje+cLTGGPeTCsZIwaoZ+YO+jX3ke1zBEXdJplTbqZ1a5nQQDMAfvicEmN5tslltIBrNYAJw2oaxQYm1W2FPEDMAiJuSwF0qgiTKLBYubOtC+k2fXvLHJGiNOqAIE+oXoSutIdbZr2LM/BLF5YIqZBxDZc8c7RIZq9HtNsWjwkdUdQ02/7919wC/FJmJaX+WImINkTXBLgcAWBvzIzSiadQw+AuyKCO3+54BUBEugilJnsXTE4Zb4TfTCCqTSnpjyJ8fwRJi9xyV7j81tofB/LAbEUNkqKy1x9MDuUCPq5YhjvvsgyxSpVxokdgUdVPBaRgILf1J4FDlNFaA==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TY3P286MB3567.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 19:01:19 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597%3]) with mapi id 15.20.6652.022; Fri, 4 Aug 2023
 19:01:19 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 0/2] Some dts fixes for Beaglebone Black
Date:   Sat,  5 Aug 2023 03:00:41 +0800
Message-ID: <TY3P286MB2611090BA1740FF8A5C117C59809A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [682Aohl9z6DH2Z/p8fsf7y4/BqO9iKFI]
X-ClientProxiedBy: TYCP286CA0110.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::17) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230804190042.2529-2-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TY3P286MB3567:EE_
X-MS-Office365-Filtering-Correlation-Id: 729f05db-de2b-43f5-5417-08db951d2fd4
X-MS-Exchange-SLBlob-MailProps: dx7TrgQSB6eSv4UmQnMV9WjmjHDmufSNAqkOYZaIzW5F1Hyr9YRdwAX+0wtRKL8S5PYQW8ezccInn15SMWudpEdb65Y5P8MfNnYnLNL0VqQfeKTRya0rvGGQx2EnN7AA9sIIWc5OSkZFVW7S2rSKrYCZYLkQGQGiONCrJituXa3wsRHzkDenSOJW9FIGd8/EhxpfpZxSPccjbMnn0vE9yvmIzr0cvTzZxUBHPtm4FSVeaytqoB6EWjJXMz3OKcrsk22KJpcMN42TP7oMjS7Dq8Ac4CsgT10yVa3jla8GOl2kXBqCPSVvHn8vB2Hl0wM31q0MC8ESl2y78WUm28MujamMxE4EPZfNtl7UsxZKJfa+2/UaVeq0hjR00JFSO++ovnRn+D25Pataq07lIhK9Vj9Lg9hWwIVaRZQJbMP9xR+PBZwDEh6Awhh4ALbPq4wx61xCSh7bbfOLJfBD6yOX/FcV2tKrUoBKO+3142s07InvgxVNUitknExHBM9mzwh5MZKzDLkP4yfJ6BHjGE3KjKDdMPpHWv0Hosj5wBT+mzAPhyS5UwrrSvwir3cZv3Yea5/6l7jRpupGf8BwQlVxYdFqf6zpL34+BUENmYm546ZQYPqLXKzJKrdtR34Jn1HI/dgdXZ70lKlquJXsFjQ+ZJ/5R5rnsi1gUAcUc4ftWj9ftsf06FM2zim39TACnd8903TXW47RSbsi0SejisDb8HNEOgo8XvPRQgxIMFwwGGViwO19TecI6uceZrx4J4uRn73TLCQoTnc=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9SV1M1MvHj951uHOU85RJwU4wy1QDDR1V44tV307RQblLAMTtA7k+BRHfvnJ77hOSZ5gEj4/NuA1aHkFlsKRPJByBUndz5V5vyG0nRuhlubKy0EZCKqN0/eK/X+X9PGhEZIkZ+33NKeLoH9gwZKAntxpuyMwQ8NFMagbBNQplLCJNMWtphcIfvt9ZsU8z/IIke38qtgGqO21renZBZIiFaWmGflAYfi6XM54tK9DQEcNfKK5aNx2rbbLoWl4C6AAyBNszW2bxXOifHvcWgq4QOOQuTeoaUXxsyguuDRO4/wdFLmGWnhKAr7nIzuOK59ZrGy8c98ZcBmaNisOG1/eY0cTP2Slj9H6NdanHJ2fbWOLowUBlomWBq6R3YEK3G6Nbz98EOT5fhVq4QkCUqFPBQ7ZZCUDmg1w+vuB5WvcmkRz92qDv7rbetpYznm1ILHozsYIlwwkt69vetJ4O4gP309dJdSfMP6FH+R/LMZoDg3tUF1Z/nTXXhHY5ZQAqlg31C7KD8KGMZ3P81pI7PZVLiKIYIDmRln9zODQadE18U/hHLEAkyn3MJefJ1RSQ07QiIobNXQbAb5A05IN7DFwYnNq2MWr/XvbzY4GiCAn3ruGtHKwRFenC/lXzzfPgh0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?moZqGO6iNOMySe1iwS35STDeDsukQFYh9Q6tbBy5Rz+eG7L15I0GSuqZOk38?=
 =?us-ascii?Q?KNVu+UKVHOX6jmP87PWadCzP4ndyRYh0dyO4Pib7Ipz8afZzqZgfpgtiunsA?=
 =?us-ascii?Q?rkf7e6/uZCSjCp9vE4kVsg/+DweAiZwgNb5Usf5NHyA9kV4NTCR2SKmbTUEo?=
 =?us-ascii?Q?R/8Dj/fk+IKi/IJu8gHY8ZtjXq5IY30gVzuGryKJG9lVYx7dv/sHaxqNW+FE?=
 =?us-ascii?Q?B/zvRSpwfT2UktIOkkwpD+riWNVT5hXtI246EDN8f1hzUDIc8EL4HmpG9vHm?=
 =?us-ascii?Q?6p/HGjRbIEIP9sTgjUK74mLxebczmjd+PFw/EbSkq4bcPcBclgnLhaH5XAxH?=
 =?us-ascii?Q?ww4jBuvdJklaDEVSkChChxVAU0L9Sc1OgjnhYh9NA0vwEPqfZPY0Z/6QWvA5?=
 =?us-ascii?Q?ag6OcUM7g6p7KIh02KgPJwBpd4be35wgev/XAD69lR/IaVOfEu7uDKawLbSG?=
 =?us-ascii?Q?9pwPT700t7HiPZoHNCBbIc51SBA/wawIQP2KoBDfpdrjJqafTAuAtEW50SSL?=
 =?us-ascii?Q?NHkjkYRmha9oNw2Qa8YXP/wNXN537g9bOhv53QfrpvRMNpd9NKy3Bn+Gbie2?=
 =?us-ascii?Q?hY9OVoSqqDlWfAa2bAjxQP0bnuyVT/zUKhNTQToXbOPP7s8ooF9+GVBbDc83?=
 =?us-ascii?Q?GP6aTd5C4yf9xKApOdMCo1XmANeW4dT1szOZy1GX+cIwot0fmz3a1hfOfEOh?=
 =?us-ascii?Q?bokWH3u7QhtmTUICXL4cM/4jZjH3fcA4WPzKgX2HxvYjEMNt4A73OohLUhfA?=
 =?us-ascii?Q?3kOMFbXJD69ZguYTUHeGkl1HUhIX9g+HbPGSHbtWpjHHcqEHSaxuV+dcYHWj?=
 =?us-ascii?Q?XjMvmc7IzxvHqgoqO0lidbaXu3qHe+yQOsHNFahsY+TOy5CZ3SXpWOLQwHhy?=
 =?us-ascii?Q?L+72UDOhapzo98WHhwMA3/Hm7rxgsJePtsOpz+yR4wdpU5zIdB+wDlKCsM5i?=
 =?us-ascii?Q?hBvT9X4RKX4kZtMuSirLO4poSSNro9Zrm+nQYSqlLcIO9qFcdEv3+V8mFMik?=
 =?us-ascii?Q?pTSIpDEYXjcfER8AfZ9hA/RomEH/RGleG510YFzHDeEYCn9Q/aDNdpfxZyWH?=
 =?us-ascii?Q?XRuFdTzucd1XLAxdFE/eX7sr3VG9UdfNTaS6yG5dg7Bh6idWdO6w5oRrb/kf?=
 =?us-ascii?Q?MuWo/cX7bF/t9QqAa35f9jkDTwlCpS4w8FYsoQJct6xwMOyuf7W4pjMDtdFO?=
 =?us-ascii?Q?QpxgHDrveuOQPk5vaG3YEx/lIOT0Zj+QfBxf7A=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729f05db-de2b-43f5-5417-08db951d2fd4
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 19:01:19.7440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3567
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series has some dts fixes for Beaglebone Black. Patch 1 adds power
supply for on-board eeprom to reduce warnings in dmesg. Patch 2 enables
ethernet PHY reset pin of revision C3 boards to fix PHY random startup
failure.

Shengyu Qu (2):
  ARM: dts: am335x-bone-common: Add vcc-supply for on-board eeprom
  ARM: dts: am335x-bone-common: Add GPIO PHY reset on revision C3 board

 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.41.0

