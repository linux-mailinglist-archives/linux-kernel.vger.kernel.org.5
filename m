Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4738F7E5ECE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjKHTlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjKHTly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:41:54 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8433C2122;
        Wed,  8 Nov 2023 11:41:51 -0800 (PST)
Received: from uhura.nilsfuhler.de ([188.68.48.207]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M7ayR-1r3rMl130P-0083CM; Wed, 08 Nov 2023 20:41:38 +0100
From:   Nils Fuhler <nils@nilsfuhler.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nilsfuhler.de;
        s=dkim; t=1699472497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Klpdzpaw5XLvhLtEVmVBGcLPRZ4tVk8iCfxqVypP20s=;
        b=D6dGffhmzbCxj3GxB3D7FwAurZD2o3K0LA9KE4JM37dbS8wY7G/4oF0xcLRfTvz6SKjNQw
        e8JrbPGdgJmntqZmgh3TBuMQNF4KbNFmaAZaI+tOiTXiuWLnlX8Q8BSde8bX6ASPvxYkmx
        qtlfy+NFyuF7k8Pshk8ILhK4JtQ1xRsUAnNb+cDwJpEmFh1sUViDi7AVVUmwlXBNSrr3Su
        CtDF3ZnQy4D9xrriVAtJENOcgjxQv5L3AGrflPcKzH4mnNBAwU7euM+/z8V2vX94jJv+ir
        LLvgiPrXP4uiu10bPGbaT8Y4Xqht6tEzzQaUflX7Bk2EEVe7e03KUvjHVTMIjg==
Authentication-Results: uhura.nilsfuhler.de;
        auth=pass smtp.mailfrom=nils@nilsfuhler.de
To:     benjamin.tissoires@redhat.com
Cc:     davidrevoy@protonmail.com, folays@gmail.com,
        jason.gerecke@wacom.com, jkosina@suse.cz,
        jose.exposito89@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, ostapyshyn@sra.uni-hannover.de,
        nils@nilsfuhler.de
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
Date:   Wed,  8 Nov 2023 20:40:52 +0100
Message-ID: <20231108194051.279435-2-nils@nilsfuhler.de>
In-Reply-To: <CAO-hwJK_xp1A=dEOV-2v3KJAf0bRLDWNcrFQeBpgEuxT-qSBnw@mail.gmail.com>
References: <CAO-hwJK_xp1A=dEOV-2v3KJAf0bRLDWNcrFQeBpgEuxT-qSBnw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: **
X-Spamd-Bar: ++
X-Provags-ID: V03:K1:lBIuvzuPq6JRjA+uq9caNN+2p3vGyTgNynjU21yqcgrndYDKmXh
 DYslZglo7Rzj3CgwISOcA9hDeAutPJEY1eV8ozUlVqpv+sDt4GkjMXMweSh0HpGsHMykNWh
 B2wjQiGeiIZ6YpTSKsB6EOIexIMAeWc/X0Qla/99bgBO9eaXbyBaqlbHbPDSXCLmdf3dtya
 hkFOV0CYH+f31IA6XTdmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PmFPu9HGegE=;/ASF0T/mdTa6gHGOWm+zK3scLnl
 vLTH5fAvkCiF2nGm5u14uC+mtVqKSE3D229a3An8xLQFVvP9YrD7dCGzNIlptB66PN6IZFAc7
 L+rjUjcaN+dhB2YSlE5SmjPqvThvjGiMuboLo+vA1CL5zBGUSg9Ih7WGdmV4hUDj3BJZE6iJh
 G9hHm5ygs0kV5H3rKI+Bl8IQjLowPrL6d+/9Lni9ZQEQQFwKRLx98plz1nOT5CveGCwZXQZJm
 aUWnJA/Q+6Zldl/Fit0owt5T1OD93Vmy7Ly2+3gOrzZstMSOs575338XpSr+H7VchzaAISQ6C
 D9gcvy5tOEZUSwjtQusJhY8qjmWWW1KWrIQDT0xh3nXu+TmqW79CyOyPlOLXoshOW5QRx4YXL
 eeHWF0kHKXSUNMX3cf2w9fwi5etCS8br/EXpJNciwAzSkpjNbrsZT+4UiODRhXrr+TZnUXJ5D
 2MxxWOIep5WjSlaUJZQwDPsz6uqzhhstTDX2I4hEPWjyfYANMlBxyaDlp3/vAX0KJ5YaEinYP
 vZEP+undky1Mi/RTZ1r4GyZRGC29Fs/pEZvC4s3e5i9hGrFSYsLxdItqhIfQCif5RlPCyM4JQ
 LPx+kw+4V1GyIUJhRdAchdSjMyhqmNug0QkAJYR4M+jS3D8tUNLU+37dwg3hXRgNHghXfnBqS
 7sdjpkI9JItCJxojAPJYQbYk522y/B+HWNQrWLQpJ42W9HgEhJQ4KRRDVNprYaCe239bN9NFE
 JC/9hlM7jv0lCMdpJy5YkY39BsGQ5MdOK0SqyaKSWQm+Ro/x5UAM9SQl69MicI57bnvzG221I
 uer8yR47mU+BmfRrZiKxmrl99n5XkKaalCp0a92JkTpoZU1B0z0miul70RvJihelGwMHtH8en
 7MB3PasEZ57Bwwg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Tissoires <benjamin.tissoires@redhat.com> writes:

> So, to me:
> - 276e14e6c3993317257e1787e93b7166fbc30905 is wrong: this is a
> firmware bug (reporting invert through eraser) and should not be
> tackled at the generic level, thus it should be reverted

Surely that can't be the solution.  [1] is not a specification but a
suggestion that many manufacturers seem to follow.  Apparently, there
are devices that directly report "erasing" for the upper button,
skipping the whole "intent to erase" business.  A questionable decision,
but clearly intended.

The evdev input protocol represents the erasing action as BTN_TOUCH with
BTN_TOOL_RUBBER being active.  Previously, it was assumed that there is
an Invert usage that would toggle BTN_TOOL_RUBBER.  XP-Pen Artist 24
(and possibly other devices) does not have Invert in its report
descriptor, resulting in missing BTN_TOOL_RUBBER.  BTN_TOUCH without an
active tool has no meaning in the input stream.

276e14e6c3 adds a quirk for this and sends the required BTN_TOOL_RUBBER
events *only* for styli not doing it themselves via Invert.  In fact,
276e14e6c3 does not even affect the "two-eraser" XP-Pen Artist Pro 16
Gen 2 and all other devices having Invert in their report descriptors.
The quirk is not set, the behavior is unchanged [2].

As Illia already described, the *real problem* is the missing
compatibility of the whole hidinput_hid_event state machine with
hidinput_setkeycode, invoked from userspace via the EVIOCSKEYCODE ioctl.
In David's case, this is done by hwdb.

This has been the case at least since the refactoring and even affects
styli *completely* adhering to [1]: remapping Invert to something other
than BTN_TOOL_RUBBER borks the device.  If you replay the recording [3]
(with or without 276e14e6c3) and remap [4] 0xd003c (Invert) to something
other than BTN_TOOL_RUBBER, you can observe that:

(1) Remapped Invert does not trigger the event it was remapped to -- this
    is due to hardcoded BTN_TOOL_RUBBER and BTN_TOUCH in hidinput_hid_event

(2) After triggering Invert once, BTN_TOOL_PEN and BTN_TOUCH never appear
    in the event stream again -- remapping Invert masks BTN_TOOL_RUBBER,
    causing it to get permanently stuck in report->tool.

276e14e6c3 does extend this issue onto Eraser remappings for devices
without Invert, resulting in this regression.  However, the solution is
to fix 276e14e6c3 (and the whole function, while we're at it), not to
revert it.

> - both of these tablets are forwarding the useful information, but not
> correctly, which confuses the kernel
> - I should now be able to write regression tests
> - I should be able to provide HID-BPF fixes for those tablets so that
> we can keep them working with or without
> 276e14e6c3993317257e1787e93b7166fbc30905
> reverted (hopefully)
> - problem is I still don't have the mechanics to integrate the HID-BPF
> fixes directly in the kernel tree, so maybe I'll have to write a
> driver for XP-Pen while these internals are set (it shouldn't
> interfere with the HID-BPF out of the tree).

As you can see, there is no need for rewriting anything.  The generic
solution for "invertless" digitizers is already in place and has no
impact on other devices.  IMHO, it would be wiser to fix the regression
by making hidinput_hid_event compatible with EVIOCSKEYCODE, than to miss
the point of what is actually broken and write device-specific drivers.

[1] https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states

[2] David confirms it in his blog post: "I now know it is there for a
    long time, because even with the "old" kernel, my newer XPPen 16 Pro
    (gen2) also reacts this way."
    https://www.davidrevoy.com/article995/how-a-kernel-update-broke-my-stylus-need-help

[3] https://dl.uni-h.de/?t=6b2cabd8f15ac8ff281b52e25920c0a9

[4] https://github.com/iostapyshyn/evmap is a handy EVIOCSKEYCODE wrapper
    for remapping.
