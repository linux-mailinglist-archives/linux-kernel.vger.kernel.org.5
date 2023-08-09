Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8759776AFA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjHIV2y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Aug 2023 17:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHIV2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:28:53 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0361810E0;
        Wed,  9 Aug 2023 14:28:51 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qTqjV-002KS1-IB; Wed, 09 Aug 2023 23:28:45 +0200
Received: from p5b13a393.dip0.t-ipconnect.de ([91.19.163.147] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qTqjV-0010kt-Aq; Wed, 09 Aug 2023 23:28:45 +0200
Message-ID: <6dd20a539a18aca5e7d976d301c458e100f255b3.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/2] m68k: add memcmp() declarartion
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Arnd Bergmann <arnd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Aug 2023 23:28:44 +0200
In-Reply-To: <20230809211057.60514-2-arnd@kernel.org>
References: <20230809211057.60514-1-arnd@kernel.org>
         <20230809211057.60514-2-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.163.147
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd!

On Wed, 2023-08-09 at 23:10 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is a global definition of memcmp() that gets built on m68k but is never
> used and causes a warning because of the missing prototype:
> 
> lib/string.c:671:15: error: no previous prototype for 'memcmp' [-Werror=missing-prototypes]
> 
> Add the corresponding declaration to avoid the warning. As far as I understand
> the #define to redirect memcmp() to __builtin_memcmp() does not actually do anything
> here since this is what it does anyway.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Can you fix the typo in the subject?

s/declarartion/declaration/

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
