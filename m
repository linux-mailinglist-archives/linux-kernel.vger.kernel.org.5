Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E882E779508
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjHKQsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHKQsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33E02D78;
        Fri, 11 Aug 2023 09:48:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80250653A0;
        Fri, 11 Aug 2023 16:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6B7C433C7;
        Fri, 11 Aug 2023 16:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691772481;
        bh=HNF9fGrSYvD/puWTXs40//FsDvkwERCUiDXDq9zBp1c=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Nfl8zeqSSk+wpflVNiDAjsppAxKhF7RtifC3qNSz/hsDnHVyZOTBNk5fr0BgvxEqO
         N+mdrt+/FLz2M75OY0SopXHA1Jm0mVvkBk54sozoC/hH/Tfuq4IugZeGV4ESNGsQIz
         LCcwgpDX7AFX6yAms6dmfQ6vAHU3or38PJwjuE15vnzGBvuWpDxdocjU3cxjLi0LqA
         YKNMZg+4CGg/p3ZBJT4ZWuFaT8VGQSaoNNGr6wcBXp8KVOLzXz5Q7gb2P8TGdX4mhH
         qStbQ4XXxv3Y22OgfOsW8hzuC2IsvaaX00g/ZxnflRxUsLkIOcBdz7kybRA7nQodbc
         s99IWXa2iLeeQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Aug 2023 19:47:57 +0300
Message-Id: <CUPVAIZEO8S3.84Z95ILX1CFP@suppilovahvero>
Cc:     <linux-integrity@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        <stable@vger.kernel.org>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts categorically for
 Lenovo
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Takashi Iwai" <tiwai@suse.de>
X-Mailer: aerc 0.14.0
References: <20230810182433.518523-1-jarkko@kernel.org>
 <87zg2yrqmy.wl-tiwai@suse.de>
In-Reply-To: <87zg2yrqmy.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 11, 2023 at 10:21 AM EEST, Takashi Iwai wrote:
> On Thu, 10 Aug 2023 20:24:33 +0200,
> Jarkko Sakkinen wrote:
> >=20
> > By large most of the entries in tpm_tis_dmi_table[] are for Lenovo lapt=
ops,
> > and they keep on coming. Therefore, disable IRQs categorically for Leno=
vo.
> >=20
> > Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> > Cc: <stable@vger.kernel.org> # v6.4+
> > Reported-by: "Takashi Iwai" <tiwai@suse.de>
> > Closes: https://lore.kernel.org/linux-integrity/87il9qhxjq.wl-tiwai@sus=
e.de/
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > This will be included into v6.5-rc6 PR, as long as Takashi ack's it. I'=
m
> > planning to send tomorrow morning (GMT+3).
>
> Feel free to take my ack:
>
> Acked-by: Takashi Iwai <tiwai@suse.de>
>
> I'll build a test kernel and ask reporters for testing the fix, too.

Added, thanks!

BR, Jarkko
