Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E7A78A10C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 20:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjH0Sim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 14:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjH0SiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:38:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA0BEB;
        Sun, 27 Aug 2023 11:38:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 472DA61DA5;
        Sun, 27 Aug 2023 18:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107D2C433C7;
        Sun, 27 Aug 2023 18:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693161499;
        bh=FbU1liP+ZktUczLaa83cudoedJjS0x2zXv05trLJ0vU=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=I2I3k8pEMMzprJSJIeQCFkoH0wUglfytHt03Wv5DeXvsmnhzZThCV77OIJkhPpebv
         R8Gl/WRxbxcaPjB+G6rRORn+M+a0Tp5uL5RMXccwOuYycuAngNk1Q3oGgLCmtp8nOG
         u5FZJoIJ5a/RSr7d3kjw3s1TgTPtQdlgZygFgk2Qt0TuhYPpXsYZdft9rQm/eRWMl2
         n1zqXjucgY2SIE6lKmxc/Cs+YjVxCym5e/AST9/AOTFKC8J/lB0mTua0TiDUmTmGpn
         R3JqSoPQIZfMWwxp1tdEJZ3ek/W32XByRH8NvV0MxHkjKbslB83VwzrsbIEwK5Ihkw
         Mr8qoz2JlDckw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 27 Aug 2023 21:38:15 +0300
Message-Id: <CV3JNOUEC8MH.3SE01XJKM6F43@suppilovahvero>
Cc:     <stable@vger.kernel.org>, "kernel test robot" <lkp@intel.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Jethro Beekman" <jethro@fortanix.com>,
        "Serge Ayoun" <serge.ayoun@intel.com>,
        "Sean Christopherson" <seanjc@google.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/sgx: Describe the parameters of
 sgx_calc_section_metric()
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Dave Hansen" <dave.hansen@intel.com>, <linux-sgx@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230822102853.15078-1-jarkko@kernel.org>
 <ba319881-b4e9-7129-123f-1884bfeb50ec@intel.com>
In-Reply-To: <ba319881-b4e9-7129-123f-1884bfeb50ec@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 25, 2023 at 6:18 PM EEST, Dave Hansen wrote:
> On 8/22/23 03:28, Jarkko Sakkinen wrote:
> > Cc: stable@vger.kernel.org # v5.11+
> > Fixes: e7e0545299d8 ("x86/sgx: Initialize metadata for Enclave Page Cac=
he (EPC) sections")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202308221542.11UpkVfp-lkp=
@intel.com/
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> -ENOCHANGELOG

ack

> >  /**
> > + * sgx_calc_section_metric() - Calculate an EPC section metric
> > + * @low:	low 32-bit word from CPUID:0x12:{2, ...}
> > + * @high:	high 32-bit word from CPUID:0x12:{2, ...}
> > + *
> >   * A section metric is concatenated in a way that @low bits 12-31 defi=
ne the
> >   * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 =
of the
> >   * metric.
>
> Shouldn't we just do:
>
> -  /**
> +  /*
>
> ?  This doesn't need kerneldoc comments.

Yeah, I added it because of parameter descriptions, which I think are
still useful.

If checkpatch does not complain, I can change the comment type.

BR, Jarkko
