Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC83980BCF8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 21:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjLJUY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 15:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJUY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 15:24:57 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA4FD8;
        Sun, 10 Dec 2023 12:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1702239887; x=1702844687; i=w_armin@gmx.de;
        bh=LHjqlwgNkufpjFeWV3ISQg5S2l9qKebnwZiqRNS6g5Y=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=m+JryQTUJ0roAUpqZ231yKKZJOR/IrqAOQXW3xruX4NBCJ8AO889lx5dzWHDiu78
         ZBMIJJ+bZD0ENqlE5WBpC+8ksp8Ye4YAdStaB0ukt35hbKR+yxD5JAngvkTCNYo9V
         3wiogiUthOGt9DAV0/HylYnyHQ9rfQEWS6rcaiJv+bybjlbA6yeWj13d8a7//3/GK
         DZYJNCc1oGEcpSl3lSZUKw0UY2a8Ie4jON1PxGWUmuAEam5AjTO65zW9m8vphuIyo
         5x20Ri4E0lv7j6g1P0g6rvWg3fBJK7W6JWcZXVOhsn3Pnkig3tJHS7efpTr6/EHjF
         PjXmBxS53sQU2exu6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mv31c-1rUEFr1HQu-00r3Fd; Sun, 10 Dec 2023 21:24:47 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, corbet@lwn.net
Cc:     Dell.Client.Kernel@dell.com, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] platform/x86: wmi: Cleanup obsolete features
Date:   Sun, 10 Dec 2023 21:24:38 +0100
Message-Id: <20231210202443.646427-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OH4a1uQzlafpzkNjmLz9Vd7n/MpwUzaBWfMgJ+C5QZzotUa+f75
 CJu04BjoiatTw1eUT3Q1zChyFLHLvOg5IOcDZxBSNICPdbmYj9iB1WpBXgTVwAZ9Pk8xgTp
 f35u9SO83qbPk4GDsBVdJHOsUSXmFCNiUAdwwvwm1TfbLfLsZMGyl9WJ5fXCBGB8L51fo5B
 /4gg98V2PTogukk8sK98w==
UI-OutboundReport: notjunk:1;M01:P0:9zmj4gF7VEM=;Kc5QoihwiH/63+KNyBqiLrKfmkw
 +saeb5FPBdAR10eqj2frrCh+0O7Txlvi4bfNF0Nbgo3HB2sT57jt2qCjDtDjcSBRh9FmoX0hw
 uO3Mez409sFFmgsvw4vPbUcA0wBZ2kutafK3VcUGSYwRlhA9zSfJ8XGVA2AqlUXQgP3onamSY
 /UN40I4HYmQUQI6kOqA7HGAYaLYKNSD275LZSl9SDnIKo4OgGPr4PEaaz5ReG6xiC5pNG9AW9
 huckcCyfFN+7vvGDPM8rCw3kn9JcVVqav1o08hdfWf9vhLIiVE7fDcQtuhBemID7ml5+89EHR
 P0IB1NIDcByCBVnvef4ZrRKhMs8uZoNwMspl/JEzF4bbLtYPyA6uwmHbhYcgC16viPfRlhpk3
 Sw9O/JQafwJbwlHZInjmWyikXxdgSlZbFqtNdpgP1VzXxnJZ9Rx4RA7kCMvEUQgO/Ghmy+aFP
 Oi2YXVntCtHDZrsXN7RULrCQo1Q0Cc+kxVBgFIScInNHPjnJLC1umxQsjnpRiKusG5xFKjKTG
 fPAo8ikgPCt/A4qRMHm4KiEfnee1h2TSr4AR+ulFgTbGhFoiUrYQHGracwo4Z2bkKPj9epKwj
 4HKNVyVGAbVmCfyF/WDwvuDIjEoRhqCpjGimsTBuBr9fGxLbsusRxfNyMC1uS1ZxeG5/Sgz7y
 c6ctStF+Q4LLvONL1ovymqZwNOhEdtB0GVx6cpYZrSY0oQYZFORXXpYK3+qYJM+wsen0Gcccu
 5FUkvnu7eK89QBqGoySLf/LuPixBAyGgl1t6X8cSx9HoncefLEBOsnwWI3y6L1QHH2PfTHe6w
 M2AwSWw0aiW3EdriITPaElWPto0NI3xR3EZYgWlUVPgCOse5Os0B3czHHSpoVFi0Ay13NHoCj
 oESVO4P1oowZxQ0hJW+0sZ2/D2DnixtuVJTjfRa5PfGQcqaJ+JnphDsrkkea25I8CS0X6REPl
 TzOg+fST6nAtmvgy5yNJGSM90iA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series removes three features deemed obsolete:
- the debug_dump_wdg module param:
  - suffers from garbled output due to pr_cont()
  - functionality is better provided by "fwts wmi"
- the debug_event module param:
  - pr_cont() usage
  - uses the deprecated GUID-based API
  - largely replaced by the ACPI netlink interface
- ioctl interface
  - used only by a single driver, no adoption otherwise
  - numerous design issues

Since the ioctl interface is actually used by userspace programs,
the only user (the dell-smbios-wmi driver) was modified to implement
the necessary pieces itself so that no regressions are expected.

The series depends on
commit cbf54f37600e ("platform/x86: wmi: Skip blocks with zero instances")=
,
which is currently in the "fixes" tree.

All patches where tested on a Dell Inspiron 3505 and work without
issues.

Changes since v1:
- add Reviewed-by to patches 1, 2 and 5
- drop patch adding the driver development guide
- rework error handling in dell-smbios-wmi

Armin Wolf (5):
  platform/x86: wmi: Remove debug_dump_wdg module param
  platform/x86: wmi: Remove debug_event module param
  platform/x86: dell-smbios-wmi: Use devm_get_free_pages()
  platform/x86: dell-smbios-wmi: Stop using WMI chardev
  platform/x86: wmi: Remove chardev interface

 drivers/platform/x86/dell/dell-smbios-wmi.c | 173 ++++++++----
 drivers/platform/x86/wmi.c                  | 285 +-------------------
 include/linux/wmi.h                         |   8 -
 3 files changed, 132 insertions(+), 334 deletions(-)

=2D-
2.39.2

