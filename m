Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1537F101D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjKTKSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjKTKSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:18:05 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE14A7;
        Mon, 20 Nov 2023 02:18:01 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 2B1E4207FD;
        Mon, 20 Nov 2023 11:18:00 +0100 (CET)
Date:   Mon, 20 Nov 2023 11:17:56 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux@bigler.io
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Stefan Moring <stefan.moring@technolution.nl>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
Message-ID: <ZVsyVAapXTWnznFd@francesco-nb.int.toradex.com>
References: <8a415902c751cdbb4b20ce76569216ed@mail.infomaniak.com>
 <e4f12422-1c47-4877-88b3-dfa9917331a2@leemhuis.info>
 <f4439fd1-7c2d-4a96-9116-1dbe04fceac0@leemhuis.info>
 <CAB3BuKA+qOY+UhWR-9Ov3qsz3wQr8q8n38MrEMf3FMCthr04yA@mail.gmail.com>
 <2fcdd99eee9ee4f5d34fa1abab2f51bb@mail.infomaniak.com>
 <CAB3BuKARgJhaVNFsP1FQ+2yLe18QU9H17fHKjc-Sf3izE+MZ1Q@mail.gmail.com>
 <86566391db9c5044f1a082bc8ec697a2@mail.infomaniak.com>
 <ZVsdNGyVrTJ/Kv3n@francesco-nb.int.toradex.com>
 <6322fd4c1967a518310140c35ab34f65@mail.infomaniak.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6322fd4c1967a518310140c35ab34f65@mail.infomaniak.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 10:33:38AM +0100, linux@bigler.io wrote:
> I run the test and it worked fine. The transmitted data matches with
> the recived data, no diff.
ok, thanks for confirming. At least we are on the same page.

> BUT!!! on the MDIO it is completly different !!!
> When I request to send 4kB Data I measure on the line 16384Byte.
> 
> The data is again   3Dummy Bytes followed by the databyte.
> So the error symetic on send and recive

ok, that's annoying. I wonder if the loopback test could be improved to
spot such kind of issues, maybe we could verify if the execution time
is reasonable given the SPI clock frequency and the payload size ...

Francesco

