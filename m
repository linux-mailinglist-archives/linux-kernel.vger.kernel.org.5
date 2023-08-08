Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA776773F59
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjHHQqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjHHQpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:45:12 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B294C16BFF;
        Tue,  8 Aug 2023 08:56:16 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 3D5979200C3; Tue,  8 Aug 2023 17:55:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3850C9200BB;
        Tue,  8 Aug 2023 16:55:50 +0100 (BST)
Date:   Tue, 8 Aug 2023 16:55:50 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Zhangjin Wu <falcon@tinylab.org>
cc:     tanyuan@tinylab.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux@weissschuh.net,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>, w@1wt.eu
Subject: Re: [RFC 0/1] mips: malta: Select PCI_QUIRKS if POWER_RESET_PIIX4_POWEROFF
 is enabled
In-Reply-To: <20230805191407.45290-1-falcon@tinylab.org>
Message-ID: <alpine.DEB.2.21.2308081633120.38537@angie.orcam.me.uk>
References: <686dbb3128ad4e413b22685cd466a68e1adf670b.1690968173.git.tanyuan@tinylab.org> <20230805191407.45290-1-falcon@tinylab.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Aug 2023, Zhangjin Wu wrote:

> To simplify the enablement of the poweroff support, selecting the required
> options for CONFIG_POWER_RESET=y may make many people happy especially when
> they are using a customized config (maybe tinyconfig based) for a target qemu
> board. Without normal poweroff support from the kernel side, qemu will simply
> hang there after a 'poweroff' command, which is a very bad experience for the
> automatical tests. Currently, based on tinyconfig, it is very hard to find the
> exact poweroff options, some architectures simply enable poweroff support by
> default, the others' poweroff options are hidden deeply, which make things very
> hard. 

 The settings are a bit buried indeed and I was hit by that myself at one 
point when upgrading the kernel using old .config, but honestly I think we 
want to let people strip the kernel from options they don't want or need, 
so I think it will best be sorted by presetting the useful options in the 
respective defconfigs and then maybe guard the more critical ones with `if 
EXPERT'.

  Maciej
