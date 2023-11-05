Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969CF7E1417
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 16:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjKEP3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 10:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKEP3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 10:29:48 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADCDA7
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 07:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail3; t=1699198180; x=1699457380;
        bh=sbHeqy/8reGqaVMiS2UA+arx+lejDT/6T/0YzKo1wxk=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=apr3vZsm2k+5qf36OCvYkY0TT7vsqLyGCDxz7JBssB8vKeA9DW41BsfohWHBDVY1C
         Ki3KABe2034ejpZ8KSHXyUqnpkXZZDQlxROSelibgKe2nLy+SBmx6Dmr6HK/y0oOo+
         ode0nC8UTuDD53lciphvQAlAIpfbEneYIWHTbpjswP4kl1UMme5jOjLl42h7OhjnyE
         hHA8mahHxMlcZSABbOwlqYVbBzcbjq9WOoq6z+UPqxmRvMoSlWhoGXkoiQr5cs+/Du
         8dTpMQPeO7jRQ+tzPZfNCN0V5Ghx3km3+soxRppuaLIgsjv+dg9sU0x+T/SPhvuwuw
         +NTsnFjC0hJYA==
Date:   Sun, 05 Nov 2023 15:29:29 +0000
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
From:   Alexander Koskovich <AKoskovich@pm.me>
Cc:     Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH 1/1] ALSA: hda: Add ASRock X670E Taichi to denylist
Message-ID: <20231105152834.5620-1-akoskovich@pm.me>
Feedback-ID: 37836894:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent AMD platforms expose an HD-audio bus but without any actual
codecs, which is internally tied with a USB-audio device, supposedly.
It results in "no codecs" error of HD-audio bus driver, and it's
nothing but a waste of resources.

snd_hda_intel 0000:59:00.6: no codecs found!

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 sound/pci/hda/hda_intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 5cfd00917..f727add4c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2086,6 +2086,7 @@ static const struct pci_device_id driver_denylist[] =
=3D {
 =09{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1043, 0x874f) }, /* ASUS ROG Zenith =
II / Strix */
 =09{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1462, 0xcb59) }, /* MSI TRX40 Creato=
r */
 =09{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1462, 0xcb60) }, /* MSI TRX40 */
+=09{ PCI_DEVICE_SUB(0x1022, 0x15e3, 0x1022, 0xd601) }, /* ASRock X670E Tai=
chi */
 =09{}
 };
=20
--=20
2.41.0


