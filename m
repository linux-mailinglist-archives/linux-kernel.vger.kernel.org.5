Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6F37E3FD6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343537AbjKGNM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjKGNML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:12:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 733F310D1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:10:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7E9213D5;
        Tue,  7 Nov 2023 05:10:55 -0800 (PST)
Received: from arm.com (RQ4T19M611.cambridge.arm.com [10.1.33.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C83073F6C4;
        Tue,  7 Nov 2023 05:10:09 -0800 (PST)
Date:   Tue, 7 Nov 2023 13:10:07 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/3] irqchip/gic-v3: Remove Mediatek pseudo-NMI firmware
 quirk handling
Message-ID: <ZUo3L7zGwbUTbdnj@arm.com>
References: <20231006151547.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
 <20231006151547.3.Ie582d33cfe46f9ec2248e7f2dabdd6bbd66486a6@changeid>
 <ZS-8k22ZWgn5hcCd@FVFF77S0Q05N>
 <CAD=FV=UVkE9k=o3-3UT2L172hhAH-gtpe5ByELN8srC+a-7mJw@mail.gmail.com>
 <0efbd5a2cfb5dab0876038ae726dc180@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0efbd5a2cfb5dab0876038ae726dc180@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 11:37:18AM +0000, Marc Zyngier wrote:
> On 2023-10-30 23:01, Doug Anderson wrote:
> > On Wed, Oct 18, 2023 at 4:08 AM Mark Rutland <mark.rutland@arm.com>
> > wrote:
> > > On Fri, Oct 06, 2023 at 03:15:53PM -0700, Douglas Anderson wrote:
> > > > This is a partial revert of commit 44bd78dd2b88 ("irqchip/gic-v3:
> > > > Disable pseudo NMIs on Mediatek devices w/ firmware issues"). In the
> > > > patch ("arm64: Disable GiC priorities on Mediatek devices w/ firmware
> > > > issues") we've moved the quirk handling to another place and so it's
> > > > not needed in the GiC driver.
> > > >
> > > > NOTE: this isn't a full revert because it leaves some of the changes
> > > > to the "quirks" structure around in case future code needs it.
> > > >
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > 
> > > I think it might make sense to fold this into the patch adding the
> > > cpucap
> > > detection. Otherwise, if you apply my suggestions to the first
> > > patch, there's a
> > > 2-commit window where we'll have two places that log that NMI is
> > > being disabled
> > > due to the FW issue. That's not a functional issue, so doesn't
> > > matter that
> > > much.
> > > 
> > > Either way:
> > > 
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > I'm happy to go either way so I'd love some advice from maintainers
> > (Marc Zyngier, Catalin Marinas, Will Deacon) about what you'd prefer.
> 
> I honestly don't mind either way. The sooner we have these fixes
> upstream, the better, so my only advise would be to respin it
> shortly.

I agree. I can queue them for rc1 if they turn up in time.

-- 
Catalin
