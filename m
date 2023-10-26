Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D9C7D7F88
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344511AbjJZJ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjJZJ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:27:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5FC184
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:27:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698312430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IRhYRtBirUPXDp/2RewNMGJIV5PnhG7EQeVGJmNmtuY=;
        b=y8aNq0w4IgHdsQOLBrgI++aznBQayz2Ao5PgCcuI+uOPrtfJjNEXaS7+lnOeVOq33+WSDh
        nwGL72MOXJ0xgpOHddvdznTOPA45kSdRZijozg1+44v4G5tPj52A/A6Cr0RKmcX4kDDiyQ
        HV8HSpY4noacGCbN0ixRce388NEkzyZfyY+Jl+oJd52aJ00knRVPlehKoX3p0AUH81e0Jf
        YjDOTw0rozdK4B5OoxswpWMnOW0nrNaD78mtu47XS9UZyc5kIbOgpbMh1E3WW6plwsmFzK
        tplGndJKmTnf46xUPvRj8NEDh1UqW/VaUcxXVLWiF4CiC9WjLejj4WBa2os0mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698312430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IRhYRtBirUPXDp/2RewNMGJIV5PnhG7EQeVGJmNmtuY=;
        b=mVCVx/S0ECmQ+yBQY50eCICD/Fu5vUhJPwB2i+xv8A8a2ZjIRc1w7qyHIGrC09kRuA2qT+
        mHvs4xG9wAv3ozAA==
To:     Mario Limonciello <mario.limonciello@amd.com>,
        David Lazar <dlazar@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        hpa@linux.intel.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re:
In-Reply-To: <ad3affd0-58d3-41b3-8014-cb0fc953dc6d@amd.com>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx> <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
 <87ttqhcotn.ffs@tglx> <87v8avawe0.ffs@tglx>
 <32bcaa8a-0413-4aa4-97a0-189830da8654@amd.com>
 <ZTkzYA3w2p3L4SVA@localhost> <87jzra6235.ffs@tglx> <875y2u5s8g.ffs@tglx>
 <ad3affd0-58d3-41b3-8014-cb0fc953dc6d@amd.com>
Date:   Thu, 26 Oct 2023 11:27:09 +0200
Message-ID: <87ttqd4tua.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25 2023 at 17:11, Mario Limonciello wrote:
> On 10/25/2023 16:04, Thomas Gleixner wrote:
>> Cc: stable@vger.kernel.org
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218003
>
> s/Link/Closes/

Sure.

> Presumably you will add a proper subject when this is committed?

Bah, yes. I stopped replacing the subject line right after clearing it :(

> With adding title and fixing that tag:
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
