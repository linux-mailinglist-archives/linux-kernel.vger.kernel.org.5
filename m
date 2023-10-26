Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E0F7D866A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345556AbjJZQCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345561AbjJZQCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:02:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A105A10DA;
        Thu, 26 Oct 2023 09:01:40 -0700 (PDT)
Received: from pwmachine.localnet (unknown [86.120.35.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id B1BC220B74C0;
        Thu, 26 Oct 2023 09:01:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1BC220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1698336099;
        bh=DVgXG69hg5W0c45MzS4NeyWgcRVGF1rDjspPMX8zmFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J1BaxsGfXNCCiVsZb9L2BrEuxqgYpYnHw9SeVTRJPu0n64p72TiZyZH4IkmgUKrJ8
         5YJE9RLfdGGG0lMsRxe4fk2maVzL/MJu2TDv+aeijmhPFHoomBzzD9nj+d09yOHGQo
         Zunl7QMPER0hlaUhna8eUJ8KWKvFCL7GX7XGxCq4=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Alessandro Carminati <alessandro.carminati@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Kris Van Hees <kris.van.hees@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        Viktor Malik <vmalik@redhat.com>,
        Petr Mladek <pmladek@suse.com>, Tom Rix <trix@redhat.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6] scripts/link-vmlinux.sh: Add alias to duplicate symbols for kallsyms
Date:   Thu, 26 Oct 2023 19:01:31 +0300
Message-ID: <2162048.irdbgypaU6@pwmachine>
In-Reply-To: <CAPp5cGToUaPCr3Fp2PUQ1yQJ8ci+wTVqgTCEs2OxvR+yTr2oOQ@mail.gmail.com>
References: <20231024201157.748254-1-alessandro.carminati@gmail.com> <5776666.DvuYhMxLoT@pwmachine> <CAPp5cGToUaPCr3Fp2PUQ1yQJ8ci+wTVqgTCEs2OxvR+yTr2oOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


Le mercredi 25 octobre 2023, 21:33:43 EEST Alessandro Carminati a =E9crit :
> Hi Francis,
> Thanks a lot for your feedback!

You are welcome!

> Il giorno mer 25 ott 2023 alle ore 15:21 Francis Laniel
>=20
> /* SNIP */
> > > debug >=3D DebugLevel.INFO.value:
> > Shouldn't this rather test nmdata?
>=20
> Not sure to understand this feedback.

Sorry, this was not clear.
Rather than testing vmlinux_file, shouldn't you test nmdata_file?


Best regards.=20


