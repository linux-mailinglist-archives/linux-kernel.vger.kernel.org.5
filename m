Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5748C7F1B81
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjKTRtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbjKTRtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:49:23 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61669D4D;
        Mon, 20 Nov 2023 09:48:55 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 7D5592071A;
        Mon, 20 Nov 2023 18:48:53 +0100 (CET)
Date:   Mon, 20 Nov 2023 18:48:49 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Stefan Moring <stefan.moring@technolution.nl>
Cc:     Francesco Dolcini <francesco@dolcini.it>, linux@bigler.io,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
Message-ID: <ZVucAc2Nq0JwJ+N4@francesco-nb.int.toradex.com>
References: <e4f12422-1c47-4877-88b3-dfa9917331a2@leemhuis.info>
 <f4439fd1-7c2d-4a96-9116-1dbe04fceac0@leemhuis.info>
 <CAB3BuKA+qOY+UhWR-9Ov3qsz3wQr8q8n38MrEMf3FMCthr04yA@mail.gmail.com>
 <2fcdd99eee9ee4f5d34fa1abab2f51bb@mail.infomaniak.com>
 <CAB3BuKARgJhaVNFsP1FQ+2yLe18QU9H17fHKjc-Sf3izE+MZ1Q@mail.gmail.com>
 <86566391db9c5044f1a082bc8ec697a2@mail.infomaniak.com>
 <ZVsdNGyVrTJ/Kv3n@francesco-nb.int.toradex.com>
 <6322fd4c1967a518310140c35ab34f65@mail.infomaniak.com>
 <ZVsyVAapXTWnznFd@francesco-nb.int.toradex.com>
 <CAB3BuKDb6uucujD7ac-w4pa1GVNLSQUA4OGE7i074mQSU==WaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB3BuKDb6uucujD7ac-w4pa1GVNLSQUA4OGE7i074mQSU==WaA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 04:30:15PM +0100, Stefan Moring wrote:
> Can you verify the values used for the transfer,  spi_imx->count and spi_imx->
> bits_per_word inside the mx51_ecpsi_prepare_transfer() method? Those are the
> only two things that changed in the commits. Maybe compare them to the working
> version?

I would suggest to bisect the issue to the actual commit that
introduced the regression, I do not think this was done yet.

Francesco

