Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06077BCA79
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 01:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344255AbjJGXjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 19:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344250AbjJGXjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 19:39:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA77C5;
        Sat,  7 Oct 2023 16:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696721977; x=1697326777; i=w_armin@gmx.de;
 bh=rN/J4tytX8odR8cyIbKQEg2R3OsD5L2Rk6ycpjME1ho=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=JBQG3uPf+Mf7T3lV7NIb1zvPXkGGohxv9MdgECwjiLhalqypyswcXC6V1AyaaL381dDTGPh/wdZ
 MoxPd5GMvjHPm0CyD7XORbGcH0OHdnRlPYae4dC1tIOJu4Qz/S4ynGfMHCAsDc5ueahutT76MIPkE
 u9o7xnC6gBrnCS5xFkMQ/oIG9AL7Gf/+eKTJGFwskamKBkm8VLjI30pvd+gvcTY8NKVPJhxL+34Y4
 9DrgfH9g5XZA6d9CtmOIlasl2cArDFO8WGiuelAMN5V9VecZLk9q5tfHA8HGNikLT1UcA4RUZ52nB
 AATBl3C8YU9BYMng989DCctW6A0WPLs+qrdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MxDkm-1rmTFR2Yp6-00xZnY; Sun, 08 Oct 2023 01:39:37 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Preparations for fixing WMI reprobing issue
Date:   Sun,  8 Oct 2023 01:39:27 +0200
Message-Id: <20231007233933.72121-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UhCu5s6JNq3Ha5I8r0yx3x161HzDTY0JWkPNccesp7qLM5XW+Th
 R0JA2MzpgnyQfxQp4Mx9K8VU8LiQbcgheAlCeOGQMkqI1CgvpAYk9+Bj0iOlVKoWEySe9DP
 QhwvS/30qtC49ZxBtEs2mogoUpXPmYtxyNpa36StyowSqMIATH0GuXnDb4nKwAroVfle3Bm
 QhaM0CHB04OUEMcbEEiUA==
UI-OutboundReport: notjunk:1;M01:P0:xjkF9wO7oCA=;LFGgoh385PqBZGAk1YWJo1H7H67
 316uBz/B9ey+gXvJ3+oGuTlbUKviy4Vz1xcxDI9YhvhVX/tagwI21oMle9zKBwCm0G3+UUaOF
 f3C7m7lDJg6rPYrdLbdgkAOsxdJm4wHWBOEh9SluWZSXoZm57PZOmjo1vaehM4yoDnwsIhgZ/
 xtG0VtdMLmaLTCwVSSsbLYGH9My1eWnGyHl030vcyW/2lb6pCbTwv1BjPR9ch7vPpdUL/drcm
 p/I2eZwYPorGmdRqImeHo/om9XAI3RrIvPGxgSxc9mbas8gHqaMxU9FVpitYSkBlHrjA1jghp
 6jDFulqgHFyl/hkHB8ZB7npoRSr7+ufM8D/04VYEfQcb2WaWwP5NZJlC12dwJ4gKl42kI2X79
 W5XvZPIU1GWLFer90abbsCAVkCm2plrSo4eFpFxxc4mPkcAdmAMvG4gUWCeU2u/V5WBHCnJmc
 s8zcy9yAFJUZenhVYfxGQ+ElUy0p9q/B3RPwEVqHWuAt7dM46n0JfxJlgEnQoZTt/vnOasZMg
 Lnde23o+KrUr6B0h+u4DfBk4u1MXTQOng/kBfQdkUM+XYeSRURYlhmuSSv0tAmat/hV0+o9my
 jm3Al3nmU4OdDTy60wbSVyH9vXHlYKVbNCOMCLjK1ZKWNdzXxNjaGLbusbYtlzMUQRD9Wbte3
 zJGRDTF2jBEdn0CUN99gHhj9JLHqqfA/A57m1pZJBXRexVz1YVeHMp/VXmvhz2M0YkaAJu1/p
 7uHdob0jq6QgojqWMemRUAc2L+9eM87/OMKjSbljzu0L7KsmwV9KhqR3pFSo72lDF6O2XZQE9
 5hOze4Q/LkgHdPNyPzHh/dCqNlvqEAZ7Pxhpf3Tr7Mj2iLWAO12t8s7RA+XD/cl0jkLeHFmaK
 MEryEYqiteji7iGPtZ50Qgvjzf+JXRacY7YI8KRqf8Q74RAyeJ7IYK8NkVCKfXjyAbEVv3N6Y
 58hTDFtql7yuZYzgyHCBC+yp0kc=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains preparations for fixing the WMI reprobing
issue discussed here:

https://lkml.kernel.org/1252c8fb-8d5f-98ad-b24a-5fabec2e1c8b@gmx.de

It mainly aims to decouple some parts of the WMI subsystem from the
wmi_block_list, which is going to get replaced in the future. It also
fixes some issues, like a probe failure when failing to register WMI
devices and a potential issue when opening the wmi char device.

The changes where tested on a Dell Inspiron 3505 and appear to work,
but additional feedback especially on the third patch is appreciated.

Armin Wolf (6):
  platform/x86: wmi: Update MAINTAINERS entry
  platform/x86: wmi: Decouple probe deferring from wmi_block_list
  platform/x86: wmi: Fix refcounting of WMI devices in legacy functions
  platform/x86: wmi: Fix probe failure when failing to register WMI
    devices
  platform/x86: wmi: Fix opening of char device
  platform/x86: wmi: Decouple WMI device removal from wmi_block_list

 MAINTAINERS                |   3 +-
 drivers/platform/x86/wmi.c | 263 ++++++++++++++++++++++---------------
 2 files changed, 159 insertions(+), 107 deletions(-)

=2D-
2.39.2

