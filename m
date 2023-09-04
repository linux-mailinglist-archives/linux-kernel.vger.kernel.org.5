Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E077916F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348712AbjIDMRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIDMRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:17:01 -0400
X-Greylist: delayed 158 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Sep 2023 05:16:54 PDT
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EF31B7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 05:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1693829634; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bTgf2n1VCtl3BLE/yWNc0X3TX33ry6pCiep9Oo1qfp22tLLQi5dywyBelpvhJgkxLZ
    yKuAoBjbgZat99wUEeu5GSKn0zZquBIFrm8f0osOB8Cl89Lng1A4fSKuOrDfyeqRiRC1
    0D8xac/YgsqRtSpOROjwKTfydp9gtbh2LUUdvgESFuIjxuWIwKbR4hWyKGsmYyxkC/RZ
    A54PAM9uH7Sjz8jDJpTvZMYOQKkouv/li0/keAImz1Sz3XQ5rkNOsGcBoigZ+KsV3N2B
    JAOAekccfiympXEhaq5LiNePewmyYTsjbkI1PfAVblTs+DugNA0zxPiEdLlIKWefrWzm
    +j+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1693829634;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0xfmDclHXl8EADHN1AY4A5Wn7lVSKuYJQwOtTZAxW1s=;
    b=hchpbVpu1vTobwXA/O+WyWvnpp82JeCoKQL6qCZB3ytp1/kuQkYSFeLs5ObKRqO6Ib
    /ylrDFGrq9oEfQOrkNKRofnbVvAd6iMi+3h87/6sdfCJSZTS3mJuCPFCUU3oy7wcWPk9
    ePo8tplFjx9RjqFKVI36fZc4VFQlRHQErKkFHviziGFQOS32jF3cC8pmlJejDJude0nQ
    0IR6w64FIslX+NU1zHrv4UEd6KUsxDsKNK0cWaq9dKxfYtU7iPImTqiNlg8vA7b1FjAY
    BPQftp7IzV2iCd4lp+sL1KRX+h9Kwd1tdoT8/ATpIb/64K130LKOvdTaIxPAousxa1xc
    y44A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1693829634;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0xfmDclHXl8EADHN1AY4A5Wn7lVSKuYJQwOtTZAxW1s=;
    b=QLAZgtWrftCQJi1fpbuLm0EakdK4gzNSoKd3OYWSJ/fLWhBiVn1AoL5LnxVjqIuRyv
    8vhIYRPyk0M6rP3Mmdq6Pn1NxOHh0+dlIk+j6uBa7uNESu6sLscDbk/o6kU/lwKYFkmg
    pCw7uImjE1IlOMvg+rbhEC95Mts8TtZoDu9nuewk3Ngqryb7VCT8s0ICGq2duHfzZuqo
    apaQIex6oPCVyKF0tcCJfdKwvRBAqvuAy4kOqeQVZsL2iSsExxjKkI47xW8hIcfhvl32
    Q6wmCbsEPzPm175Gh6BxAwLXrwcrCbzo6PbIPGpj4Hd16CVGTCQBIpE726zBoMhKwMYV
    Me6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1693829634;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0xfmDclHXl8EADHN1AY4A5Wn7lVSKuYJQwOtTZAxW1s=;
    b=y6FqxRaeq7hfO7rBRv8oRDcGfFpGpB1lG7Ufrh/O0iEuU2RPTjhQD0+cM0GATYTb/l
    kjirpZPQZD96RZA4H4Cg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAg4xrVn7F5otYd+QgnvMgMBBq+8hhN3EzOMmjnoZDw=="
Received: from sender
    by smtp.strato.de (RZmta 49.8.2 AUTH)
    with ESMTPSA id C03bb5z84CDqJqw
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 4 Sep 2023 14:13:52 +0200 (CEST)
From:   Olaf Hering <olaf@aepfle.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v1] cpu/hotplug: remove unused cpuhp_state CPUHP_AP_X86_VDSO_VMA_ONLINE
Date:   Mon,  4 Sep 2023 14:13:50 +0200
Message-Id: <20230904121350.18055-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b2e2ba578e01 ("x86/vdso: Initialize the CPU/node NR segment
descriptor earlier") removed the single user of this constant.

Remove it to reduce the size of cpuhp_hp_states[].

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 include/linux/cpuhotplug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 25b6e6e6ba6b..6e18bb63b98d 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -205,7 +205,6 @@ enum cpuhp_state {
 	CPUHP_AP_KVM_ONLINE,
 	CPUHP_AP_SCHED_WAIT_EMPTY,
 	CPUHP_AP_SMPBOOT_THREADS,
-	CPUHP_AP_X86_VDSO_VMA_ONLINE,
 	CPUHP_AP_IRQ_AFFINITY_ONLINE,
 	CPUHP_AP_BLK_MQ_ONLINE,
 	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
