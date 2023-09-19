Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2347A680D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjISP1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjISP1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:27:34 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 088339C;
        Tue, 19 Sep 2023 08:27:27 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 38JFGXnW031198;
        Tue, 19 Sep 2023 10:16:33 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 38JFGUOK031195;
        Tue, 19 Sep 2023 10:16:30 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 19 Sep 2023 10:16:30 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Lafreniere <peter@n8pjl.ca>
Cc:     anton.ivanov@cambridgegreys.com, geert@linux-m68k.org,
        ink@jurassic.park.msu.ru, jack@suse.cz, johannes@sipsolutions.net,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org, linux@armlinux.org.uk,
        linuxppc-dev@lists.ozlabs.org, reiserfs-devel@vger.kernel.org,
        richard.henderson@linaro.org, richard@nod.at,
        tsbogend@alpha.franken.de
Subject: Re: [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
Message-ID: <20230919151630.GO19790@gate.crashing.org>
References: <20230918175529.19011-1-peter@n8pjl.ca> <20230918234108.GN19790@gate.crashing.org> <20230919000026.7409-1-peter@n8pjl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919000026.7409-1-peter@n8pjl.ca>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:00:34AM +0000, Peter Lafreniere wrote:
> On Monday, September 18th, 2023 at 19:41, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > On Mon, Sep 18, 2023 at 05:56:09PM +0000, Peter Lafreniere wrote:
> > 
> > > ReiserFS has been considered deprecated for 19 months since commit
> > > eb103a51640e ("reiserfs: Deprecate reiserfs"). However, there are
> > > several architectures that still build it into their defconfig kernels.
> > > 
> > > As ReiserFS will be removed in 2025, delete all ReiserFS-related options
> > > from defconfig files before the filesystem's removal.
> > 
> > 
> > This is essentially equivalent to deleting the filesystem now. Why do
> > this? Is there such a hurry?
> 
> This is not equivalent to deleting the filesystem. The filesystem can still
> be configured into kernels, and few distros use a defconfig kernel anyway.

Most people who compile kernels use defconfigs though.  Distros are a
tiny minority if you look at builds.

Again: why do you want this?


Segher
