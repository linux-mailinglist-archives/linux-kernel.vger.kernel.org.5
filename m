Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CEF7DA332
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346654AbjJ0WL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346636AbjJ0WLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:11:21 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66AF1B8;
        Fri, 27 Oct 2023 15:11:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 665E932008FB;
        Fri, 27 Oct 2023 18:11:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 27 Oct 2023 18:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1698444670; x=1698531070; bh=+pfzMKfDeQ
        MzwHOXJDWiQZICV087zj2gVTi0fZPI8qs=; b=DlDiXG06ZTpS7+rF7PHhLhBPke
        vPw3vAnkgNQvrzJJ5/tZAf7oOe9Ae/yoYrQoJorQXD3ah8Hvmw4oanD95umtHXqK
        geRq4C6Ou4QRinj6vZ27OqYwAjTtcREVEjel1WNdUubtsnp1lbseHdf4knYiNHv7
        lVDaGypXMLK8nIdnTvDHMSe7SkYxuUdQMA/oN2sAA7EnW+xV1GlBWT57VVUXUopm
        sVZOHTymsWdAAT4BL9lZZzOmgSnqGcUTatVh5wstIdMGK8jrtKt9VhDIvMlUX7yo
        EIVWGQv0YfmgCpbT+VJti/CuY3RGKz3plE/R6qN7x+/ZOzKeEi9SeUTVDIfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698444670; x=1698531070; bh=+pfzMKfDeQMzw
        HOXJDWiQZICV087zj2gVTi0fZPI8qs=; b=s9Q/EuMYvqX25dUrxABgywfoOe0jZ
        /KS0NViMkVHM6vuY92nZ4O7J3JHZ2sns3pPAUsEKZNkEpvv7X+ytq56Il0UTiXzz
        V00oikWpuKDlA1ip4iypQQaEsNKZwqpAL2ioEi7D0VN8zfJjTVAZtVWbmSJNSuaW
        NNpaeJOxZmEMSTgeyC8FDAqacenUnVllaoW1wFJ88da3zGQu+K9ECo2JiMDdZKPe
        5xmi4lSLZmMSTZGmgadHcarkAYWKCTJFPtZfFdIRpiGgMTmABx+DXPbTMrUqjnK6
        jPkBvARayTKj4gBa4IWNTzVRlNIZEtmLkql58suPlf/LUDZCPJP1yCE1A==
X-ME-Sender: <xms:fjU8ZViwRGx-FfAbbZgaAlAPckfOfDD4vHEBaXNS13H13mF5NwxxXA>
    <xme:fjU8ZaBBxPiCTCSlGeLEUrSDnxiH9gIl6MEMnJ-lpIGpZWcgtRMdEkQ8Zp-OgQZxy
    lLchyNyJU_KaHgVilU>
X-ME-Received: <xmr:fjU8ZVEJZnWqv4aLbhhl710OAfGvBlFS7E3huGuDo4Av0N7s6xpSQlZoaluG36O1LmNsGJwobLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleehgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvueetkeeluedugfeuteehtd
    dutdfhtdelffeghfeiheefieegvddtueevteeiudenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:fjU8ZaQpYMJjw5T9BfqZvYuudFxOCSLCytLt_K6YD1bdBZw-9ADNTw>
    <xmx:fjU8ZSzXzv8b-v7JnYrNCjH4XEEEUkuf3NS7Ee42H6t5t0df-VsyKw>
    <xmx:fjU8ZQ7C2cX9FUtP30SkcF1tbSKEJw9rbC9WO6asv2MtVuTuKJT9yQ>
    <xmx:fjU8ZcsH1PnJsa5UlmxXlTsKidy5ZiU9TpjY4TzjDDP3n5udum9XOw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 18:11:09 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 00/10] MIPS: Fix kernel in XKPHYS
Date:   Fri, 27 Oct 2023 23:10:56 +0100
Message-Id: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series fixes support for loading kernel to XKPHYS space.
It is derived from "MIPS: use virtual addresses from xkphys for MIPS64" [1].

Boot tested on boston and QEMU with loading address set to 0xa800000090000000.
QEMU patch on the way.

For EyeQ5's memory layout, I think you just need to write devicetree memory
node as:

memory@0 {
	device_type = "memory";
	reg = < 0x0 0x08000000 0x0 0x08000000
		0x8 0x08000000 0x0 0x78000000>;
};

And set kernel load addesss to somewhere in RAM, everything should work.

It makes me a little bit confused that in EyeQ5 enablement patch, you set
load address to:
> +else
> +load-$(CONFIG_MIPS_GENERIC)	+= 0xa800000080100000
> +endif
Where does not have memory aviailable.

I guess you might want to set it to 0xa800000800100000?
Though I would suggest you to set it to 0xa800000808000000, to avoid
collisions with low mem and reserved mem.

Gregory and Vladimir, do let me know if I missed anything.

Thanks
- Jiaxun

[1]: https://lore.kernel.org/lkml/20231004161038.2818327-3-gregory.clement@bootlin.com/

Jiaxun Yang (10):
  MIPS: Export higher/highest relocation functions in uasm
  MIPS: spaces: Define a couple of handy macros
  MIPS: genex: Fix except_vec_vi for kernel in XKPHYS
  MIPS: Fix set_uncached_handler for ebase in XKPHYS
  MIPS: Refactor mips_cps_core_entry implementation
  MIPS: Allow kernel base to be set from Kconfig for all platforms
  MIPS: traps: Handle CPU with non standard vint offset
  MIPS: Avoid unnecessary reservation of exception space
  MIPS: traps: Enhance memblock ebase allocation process
  MIPS: Get rid of CONFIG_NO_EXCEPT_FILL

 arch/mips/Kconfig                           |  27 ++--
 arch/mips/include/asm/addrspace.h           |   5 +
 arch/mips/include/asm/mach-generic/spaces.h |   5 +-
 arch/mips/include/asm/mips-cm.h             |   1 +
 arch/mips/include/asm/smp-cps.h             |   4 +-
 arch/mips/include/asm/traps.h               |   1 -
 arch/mips/include/asm/uasm.h                |   2 +
 arch/mips/kernel/cps-vec.S                  | 110 +++++--------
 arch/mips/kernel/cpu-probe.c                |   5 -
 arch/mips/kernel/cpu-r3k-probe.c            |   2 -
 arch/mips/kernel/genex.S                    |  19 ++-
 arch/mips/kernel/head.S                     |   7 +-
 arch/mips/kernel/smp-cps.c                  | 167 +++++++++++++++++---
 arch/mips/kernel/traps.c                    |  85 +++++++---
 arch/mips/mm/uasm.c                         |   6 +-
 15 files changed, 293 insertions(+), 153 deletions(-)

-- 
2.34.1

