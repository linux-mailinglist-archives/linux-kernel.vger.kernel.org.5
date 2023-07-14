Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EB6753D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbjGNOhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbjGNOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:37:08 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7CE134
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IVxnz3SsZvhBqdOnSCuFOolHoYJoaZMR3RVXll8Nh8g=; b=k8baPByjwgdZPzIyD9jGY0Tu05
        ZCA6U6vux/TI1np4H5a6ZQTRdHggtnETS2lqL8zGVu60apoWBlGG9Ph4VOdBzOfl/8A4uMz0ijLpe
        skcze3hB21WTVeKJAdxFNbpX6HxqEeKG23CWod3+yM9hWtFeKiRUCQbAxUWOW2wSUbAgjeTuVyAB8
        hYCEyaeTfwwGzeezAlrKuamFhmFf6r9c0TLSD0UaCAWrYwJ2LY8nOaU7flBYIB9Pbow28Trztvl01
        xxs/2xkRpL176Tk/BdgHkQPLDj4hEjJWg6+Xr/uEn5ciO38GBX/gTMp+UofmE4b+35XV1jU9GbfwQ
        iIvNwZ4A==;
Received: from [192.168.1.4] (port=23155 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qKJui-0003r6-3C;
        Fri, 14 Jul 2023 16:36:57 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 14 Jul 2023 16:36:56 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <andrew@lunn.ch>
CC:     <ante.knezic@helmholz.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <olteanv@gmail.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date:   Fri, 14 Jul 2023 16:36:50 +0200
Message-ID: <20230714143650.25818-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <570d32ad-e475-4a0b-a6ee-a2bdf5f67b69@lunn.ch>
References: <570d32ad-e475-4a0b-a6ee-a2bdf5f67b69@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +static int mv88e6390x_serdes_erratum_3_14(struct mv88e6xxx_chip *chip)
>> +{
>> +     int lanes[] = { MV88E6390_PORT9_LANE0, MV88E6390_PORT9_LANE1,
>> +             MV88E6390_PORT9_LANE2, MV88E6390_PORT9_LANE3,
>> +             MV88E6390_PORT10_LANE0, MV88E6390_PORT10_LANE1,
>> +             MV88E6390_PORT10_LANE2, MV88E6390_PORT10_LANE3 };

>Please make this const. Otherwise you end up with two copies of it.

will do. 

>> +     int err, i;
>> +
>> +     /* 88e6390x-88e6190x errata 3.14:
>> +      * After chip reset, SERDES reconfiguration or SERDES core
>> +      * Software Reset, the SERDES lanes may not be properly aligned
>> +      * resulting in CRC errors
>> +      */
>> +
>> +     for (i = 0; i < ARRAY_SIZE(lanes); i++) {
>> +             err = mv88e6390_serdes_write(chip, lanes[i],
>> +                                          MDIO_MMD_PHYXS,
>> +                                          0xf054, 0x400C);

>Does Marvell give this register a name? If so, please add a #define.
>Are the bits in the register documented?

Unfortunately, no. This is one of those undocumented registers. I will
make a note of it in the commit message.

>> +     if (!err && up) {
>> +             if (chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6390X ||
>> +                 chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6190X)

>6191X? 6193X?

Errata I have available refers only to 6190x and 6390x. Not sure about other devices.

>Please sort these into numerical order.

will do.

