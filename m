Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D99F7C9894
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 12:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjJOKGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 06:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjJOKGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 06:06:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACC8F0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697364376;
        bh=fNILS6uDqzn/+3Ar+0VrGi84TCCExiQmIbL2jAANHTU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HmEGUjqtwXU1PP3R09/L84YDDHpybyRlLIClTp2AjvJEN9hrp9HDTxTQiA8OSrI0D
         AsFwtIMbErrBzRJVj/rcBQegAjUM731KhBdMDDzpM2KYYWqm/dmCXxq8Frwgm7IkLP
         xjg01JzXJatVjJc1t6POPdRaiiVIpUt4/U5QW44STccatnTWPz9V9bmwpcGUp5PQaS
         XyKlqDFEQ28OtjMnRK4frK8OU+RuP59BS769h/HWObHqsBqMMCyUD0KC/aP7G6I2Gd
         WlvsC3pYY6ROEGXRCV4Om+E0Csa0G/VONr0CmOe30g5BCDMnBeJ9PlBKEpyEzqleq5
         kvorUc+Cz+b8w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S7bVS4L6tz4wdF;
        Sun, 15 Oct 2023 21:06:08 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     npiggin@gmail.com, christophe.leroy@csgroup.eu, sam@ravnborg.org,
        benh@kernel.crashing.org, linux@treblig.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
In-Reply-To: <20230825142754.1487900-1-linux@treblig.org>
References: <20230825142754.1487900-1-linux@treblig.org>
Subject: Re: [PATCH v4] powerpc: Use shared font data
Message-Id: <169736429855.960528.2851417902761239149.b4-ty@ellerman.id.au>
Date:   Sun, 15 Oct 2023 21:04:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 15:27:54 +0100, linux@treblig.org wrote:
> PowerPC has a 'btext' font used for the console which is almost identical
> to the shared font_sun8x16, so use it rather than duplicating the data.
> 
> They were actually identical until about a decade ago when
>    commit bcfbeecea11c ("drivers: console: font_: Change a glyph from
>                         "broken bar" to "vertical line"")
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Use shared font data
      https://git.kernel.org/powerpc/c/0ebc7feae79ac07772a20382eebd8c3503313714

cheers
