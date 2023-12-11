Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D8480D10A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344319AbjLKQSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344253AbjLKQSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:18:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAFBB3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:18:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE848C433C7;
        Mon, 11 Dec 2023 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702311518;
        bh=EiRoc1cO0j90XBlz9u2jZ9jEQ9O9yX4Cj8QCkAu5xkI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OAJaRjf5oBZ/VBOaEWZzCHoChUAxp7lVTVjYQjo7CFnB1HCzhfUio+urhKAOyCKT/
         75a513cv4JDi7SCJaldhok3Gs/TAvHaFsHypYVOxfk1yXBd85VrEPI55QQSKUUjzH0
         xs5MIS3xflkyKg/egH+Aqssb3MybsQ05It3ic6j5WOsjaRGjxVwhJzfrJr0Xe+nWIJ
         lmyWRVekFIp+n0sCuocFqgfFb5gv+06/MfdYGLvcNTYh/8U0koGNMOjGY7R/bYpxAg
         NvEUT1k1OhkqpgNxErlImygqJUFZJZOFQcGxML7YQpjD+7d75aL4JG7j+o/Fpl/QMp
         RfWQFq9N7gEjg==
Date:   Mon, 11 Dec 2023 10:18:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Fiona Ebner <f.ebner@proxmox.com>
Cc:     Igor Mammedov <imammedo@redhat.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Message-ID: <20231211161836.GA914318@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5121397-2a40-4c77-9dd3-8f0f47ec1360@proxmox.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 03:53:46PM +0100, Fiona Ebner wrote:
> Am 11.12.23 um 15:12 schrieb Bjorn Helgaas:
> > On Mon, Dec 11, 2023 at 02:52:42PM +0100, Fiona Ebner wrote:
> >> Am 11.12.23 um 08:46 schrieb Igor Mammedov:
> >>> On Fri, 8 Dec 2023 16:47:23 +0100
> >>> Igor Mammedov <imammedo@redhat.com> wrote:
> >>>> On Thu, 7 Dec 2023 17:28:15 -0600
> >>>> Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>>>
> >>>>> What's the actual symptom that this is broken?  All these log
> >>>>> fragments show the exact same assignments for BARs 0, 1, 4 and for the
> >>>>> bridge windows.
> >>
> >> The disk never shows up in /dev
> >>
> >>>>> I assume 0000:01:02.0 is the hot-added SCSI HBA, and 00:05.0 is a
> >>>>> bridge leading to it?
> >>>>>
> >>>>> Can you put the complete dmesg logs somewhere?  There's a lot of
> >>>>> context missing here.
> >>
> >> Is this still necessary with Igor being able to reproduce the issue?
> > 
> > Only if you want help resolving the problem.  I don't have time to
> > guess what interesting things might be missing and go back and forth
> > to get them.
> > 
> 
> I put the output of dmesg with my original QEMU commandline and kernel
> 6.7.0-rc3 here:
> 
> https://pastebin.com/UvpGAYf2

Thanks, I opened https://bugzilla.kernel.org/show_bug.cgi?id=218255
and attached this dmesg log there so this doesn't get lost or expired
from pastebin.com.

IIUC this is a log from when it fails.  Can you attach the
corresponding log when it works correctly?

Bjorn
