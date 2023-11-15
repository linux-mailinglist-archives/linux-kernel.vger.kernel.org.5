Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78D17EBB18
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 03:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjKOCHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 21:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOCHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 21:07:50 -0500
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FFCFB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 18:07:47 -0800 (PST)
Received: from localhost (88-113-24-34.elisa-laajakaista.fi [88.113.24.34])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id c3e2a2f8-835b-11ee-b972-005056bdfda7;
        Wed, 15 Nov 2023 04:07:44 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Wed, 15 Nov 2023 04:07:44 +0200
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH] pinctrl: avoid reload of p state in interation
Message-ID: <ZVQn8EpU8UrFMm20@surfacebook.localdomain>
References: <20231114085258.2378-1-quic_aiquny@quicinc.com>
 <CACRpkdYgyASV6ttW=AeAWSh3oiFDk9_Q1WV00=7yTxtuhpdXEg@mail.gmail.com>
 <94de6d83-d181-4a04-875a-377fb5e10b25@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94de6d83-d181-4a04-875a-377fb5e10b25@quicinc.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Nov 15, 2023 at 08:56:35AM +0800, Aiqun(Maria) Yu kirjoitti:
> On 11/14/2023 9:21 PM, Linus Walleij wrote:
> > On Tue, Nov 14, 2023 at 9:54 AM Maria Yu <quic_aiquny@quicinc.com> wrote:

...

> > This makes sense in a way, since this is a compiler-dependent problem,
> > can you state in the commit message which compiler and architecture
> > you see this on?
> I have a crash dump which caused by this issue which is using Clang 10.0,
> arm64, Linux Version 4.19.
> Thx for your suggestion, I will put this information in the commit message.

Please, also add a kernel version and a few (most important) lines from the crash.

> > If it is a regression, should this also be queued for stable? (I guess so?)
> This is a corner case which is very hard to reproduce in product, I suggest
> this fix to be queued for stable.

Please, provide a respective Fixes tag.

-- 
With Best Regards,
Andy Shevchenko


