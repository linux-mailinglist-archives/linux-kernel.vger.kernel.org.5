Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240767D005D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345484AbjJSRVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjJSRU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:20:58 -0400
X-Greylist: delayed 313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 10:20:56 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA38A126;
        Thu, 19 Oct 2023 10:20:56 -0700 (PDT)
Received: from localhost ([31.220.118.173]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mnq4Q-1rIPAX3aHa-00pMUm; Thu, 19 Oct 2023 19:15:23 +0200
Date:   Thu, 19 Oct 2023 19:15:22 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergei Korolev <dssoftsk@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: bmp280: fix eoc interrupt usage
Message-ID: <ZTFkKl6Qu4vpfcC4@anderl>
References: <20231018152816.56589-1-ak@it-klinger.de>
 <20231019162209.18872-1-ak@it-klinger.de>
 <ZTFfRaShatWdxGB9@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTFfRaShatWdxGB9@smile.fi.intel.com>
X-Provags-ID: V03:K1:MbuB95zQCzJCAuRmy9TbJEeUL+5uuxt06CS/DYsZ3ucmOQh4Qh3
 tPnLIhM//dKKDbbYjbdNYrdjXndTFiCszas8Nz4UrKW1dsKCs7dKcv1Qp+HzsNgpfbZ+rv2
 47LPVi4da7N6P0uBk1qdpyicwB3aaTaJ6kp7gTDCnto70Vn5Y9fc+Q6i0XcXcbde0YgG0J0
 Zqpjj+bcedRs7kffuOh9A==
UI-OutboundReport: notjunk:1;M01:P0:8hVPFhKhLK8=;eztUtI2Qv6usiHJlHiN8ptlPj04
 2xuPNcmH3Cn4jhkvgtlYiZwUrvofz2zGtBfD8Z53AG+F9FXzc3cSZMheGjOOxL1G57lXhCvw8
 O53xNPxnq29dRBCmj+VpIlz+2eoVWhIBH8P0xJFcx0hBbSltAMOqAkSQweJBEoXR1Svlw7W6Z
 0cHx7yAlpbG4pR3yFvEBglxIRM8avdsouO3i9TWvonlL5yy5uP0xl/evHJuofNpcSaR7XMedG
 vFUYML2Chek9CshUbpylNG8bqK2FYgLMDB+27Gu1WbZKMlwtHOB64Pj94TV3yuhtSzRli0Ypo
 ZtPwH+MihBvh8CCxIhHYjbV5Oy79DKyYpouv5iK5Kb1EhW0d9OX27Zsd8ln4MZFzsGc3E3kKw
 UYzidNZtcewFV10ntUjEaw6LqtaZc/iY6qr0m11wLF129YQIpXMNjlZnbAJTn5nM4x8FmkS0V
 lM7SCDjNTa0uSAlMfSFJRi4R3Ingy72l6ndDvNUlwbe/GXvnLl8wbVxP1U4/WngKy5ClUfkgj
 gLG0WWU7LKHTKwCyKvGqVQ5FrpLXODodURfJNEYeyN6YRgge0mqtu6PMQ5tflmeMkI6x2aI22
 +LUELIXll2feIXlIrV6zwkL+WrdZEla9SJF/ednSb/lcA4RkuUkMVLR2srFie90/veMa/foW7
 8R9wQm80ud/GYZhOVxvvWqEfjfUV7XTgpacQxP6Zsiun8DEg9bE/ryL2IU0wIAMvBFh0h4yYA
 SsL3jvjy48OiuvzHsiwija3OcpC5kO+yiGWCYtEBtFp6rNI38QGpPH+jbMb/qJ1JOo3taIZIB
 XRImQ/3H8w/imGZSJ2wnw5zG5NxsOdFjM3SmvGq+Jfzlc/D6BNqCnNaFpBajQ5/ioyvoBD1Gu
 w183fzSGJdob9NaaCYgX/eCZnavnO5tSP30A=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Andy Shevchenko <andriy.shevchenko@linux.intel.com> schrieb am Do, 19. Okt 19:54:
> On Thu, Oct 19, 2023 at 06:22:09PM +0200, Andreas Klinger wrote:
> > Only the bmp085 can have an End-Of-Conversion (EOC) interrupt. But the
> > bmp085 and bmp180 share the same chip id. Therefore it's necessary to
> > distinguish the case in which the interrupt is set.
> > 
> > Fix the if statement so that only when the interrupt is set and the chip
> > id is recognized the interrupt is requested.
> > 
> > This bug exists since the support of EOC interrupt was introduced.
> 
> > Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC interrupt")
> 
> As Jonathan already commented, this is part of a tag block below...
> 
> > Also add a link to bmp085 datasheet for reference.
> > 
> 
> ...somewhere here.
> 
> > Suggested-by: Sergei Korolev <dssoftsk@gmail.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  v1 -> v2: Remove extra space (seen by Andy)
> 
> 
> And seems Jonathan mentioned that this is already fixed in his tree.
> Did I understand that correctly?

I just read it in the archive. For some reason I didn't get Jonathans mail
yesterday. Sorry for the spam.

Andreas

