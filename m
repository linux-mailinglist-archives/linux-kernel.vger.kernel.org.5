Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FECE7C8418
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjJMLJf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Oct 2023 07:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjJMLJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:09:33 -0400
Received: from postfix2.imaqliq.com (postfix2.imaqliq.com [93.189.151.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC98BF;
        Fri, 13 Oct 2023 04:09:30 -0700 (PDT)
Received: from verse.imaqliq.com (verse.imaqliq.com [93.189.151.95])
        by postfix2.imaqliq.com (Postfix) with ESMTP id B8A001C2928;
        Fri, 13 Oct 2023 14:09:27 +0300 (MSK)
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: <0120de74-0b86-469a-b19a-b4b98a60a080@kernel.org>
References: <0120de74-0b86-469a-b19a-b4b98a60a080@kernel.org>,
        <OF950BEF72.7F425944-ON00258A46.00488A76-00258A46.00497D44@gdc.ru>
Subject: Re: [PATCH v2] tty: serial: meson: hard LOCKUP on crtscts mode
From:   Pavel Krasavin <pkrasavin@imaqliq.com>
To:     "Jiri Slaby" <jirislaby@kernel.org>
Cc:     Pavel Krasavin <pkrasavin@imaqliq.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Date:   Fri, 13 Oct 2023 11:09:22 +0000
Message-ID: <OF9F10A7E1.E13FABB2-ON00258A47.003D2ECF-00258A47.003D485B@gdc.ru>
X-Mailer: Lotus Domino Web Server Release 12.0.2 November 03, 2022
X-MIMETrack: Serialize by http on verse/com(Release 12.0.2|November 03, 2022) at 10/13/2023
 11:09:22,
        Serialize complete at 10/13/2023 11:09:22,
        Serialize by Router on verse/com(Release 12.0.2|November 03, 2022) at 10/13/2023
 11:09:27
X-KeepSent: 9F10A7E1:E13FABB2-00258A47:003D2ECF;
 type=4; name=$KeepSent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 180603 [Oct 13 2023]
X-KLMS-AntiSpam-Version: 6.0.0.2
X-KLMS-AntiSpam-Envelope-From: pkrasavin@imaqliq.com
X-KLMS-AntiSpam-Rate: 10
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dmarc=fail header.from=imaqliq.com policy=none;spf=softfail smtp.mailfrom=imaqliq.com;dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 539 539 807534d9021bfe9ca369c363d15ac993cd93d4d9, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;gdc.ru:7.1.1;93.189.151.95:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;verse.imaqliq.com:7.1.1;imaqliq.com:7.1.1, FromAlignment: s, {Tracking_dmark_f}, ApMailHostAddress: 93.189.151.95
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/10/13 09:19:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/10/13 08:46:00 #22180318
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jiri,

----- "Jiri Slaby" <jirislaby@kernel.org> писал(а): -----
> Subject: tty: serial: meson: hard LOCKUP on crtscts mode

> Ah, you are fixing one? So how does this sound:
> tty: serial: meson: fix hard LOCKUP on crtscts mode
> ?

you are right, idea was to fix it, not to add :)
I agree, your subject looks better!

So, do I need to prepare v4 of this patch, right?

--
Regards,
Pavel.
