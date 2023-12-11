Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7727E80CE22
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbjLKOSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344447AbjLKORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:17:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705E94786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:12:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E3FC433C7;
        Mon, 11 Dec 2023 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702303961;
        bh=VSph1+fDNCCmhnH5sf325cICVCA/0HcmwAI98VOjb3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RMvOiZRfsxo0D0aifsVlT6iRoA2ASvw2N5g5t3lz9qph8BTBSRPWbuNliN9AcMgAq
         rfFqIRuS0A9mnwguzYjdhQRnb/V+EwMaStALoD6SDzbG+rstYEWC329FQ/bmCAfQkC
         I2VOmPuHGA0rUxupUX/CXe7XYV3vyb5ewiuDojQwks9O+xqZOUDzndCerhgAM+6oer
         2LjhqpO4iGI3FdDLReTemWW0StCkxcsAN2SrNo6ZUqAteW9BML4CIjFn47EaFxQsON
         4q4sze+3aaQSPxgG6WzcvdqRq4KWj6g0P6JvbbSYQyc10u1MayxOkObUI9FdDUQ6D+
         Q2Gcla2zwD/1A==
Date:   Mon, 11 Dec 2023 08:12:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Fiona Ebner <f.ebner@proxmox.com>
Cc:     Igor Mammedov <imammedo@redhat.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Message-ID: <20231211141239.GA909479@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6233df5-01d8-498f-8235-ce4b102a2e91@proxmox.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 02:52:42PM +0100, Fiona Ebner wrote:
> Am 11.12.23 um 08:46 schrieb Igor Mammedov:
> > On Fri, 8 Dec 2023 16:47:23 +0100
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >> On Thu, 7 Dec 2023 17:28:15 -0600
> >> Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>
> >>> What's the actual symptom that this is broken?  All these log
> >>> fragments show the exact same assignments for BARs 0, 1, 4 and for the
> >>> bridge windows.
> 
> The disk never shows up in /dev
> 
> >>> I assume 0000:01:02.0 is the hot-added SCSI HBA, and 00:05.0 is a
> >>> bridge leading to it?
> >>>
> >>> Can you put the complete dmesg logs somewhere?  There's a lot of
> >>> context missing here.
> 
> Is this still necessary with Igor being able to reproduce the issue?

Only if you want help resolving the problem.  I don't have time to
guess what interesting things might be missing and go back and forth
to get them.

> >>> Do you have to revert both cc22522fd55e2 and 40613da52b13f to make it
> >>> work reliably?  If we have to revert something, reverting one would be
> >>> better than reverting both.  
> 
> Just reverting cc22522fd55e2 is not enough (and cc22522fd55e2 fixes
> 40613da52b13f so I can't revert just 40613da52b13f).

OK, thanks.  So it sounds like our options are to fix it or to revert
both.  I'm going to be on vacation Dec 16-25, so we have about 3-4
days to figure something out.

Bjorn
