Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3714780020
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355426AbjHQVrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355414AbjHQVrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:47:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59C7E4F;
        Thu, 17 Aug 2023 14:47:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7408562BEA;
        Thu, 17 Aug 2023 21:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829F4C433C8;
        Thu, 17 Aug 2023 21:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692308836;
        bh=qlrOzzd25FuYd7cFhcqAxs88wg3C8mE7LMmEAPbH7qk=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=dgMI/Akp+pgf8d6vAbqiqT3JIAJnY70gjvVXZV9oLEFlVQQ4uaLwPQFrYQXjIWUu7
         ps5pMxcYY9wpEtvx06PliyCYtYq+fUjA6HIKKl+Bcgy2n5+vrKezmg3riQ3P1V28Yr
         lLwC7wFl5FwOAayTY9QypZUd3iNkbBZPpUnyHKZ9G/IGysEehKTdoGTGf9NFl63U3L
         vHUmKPVISv7YUFhmjdHLibHAkoWitvKNYT3nyL97j4k66oLlCYlEUouSK2E+FAiQzy
         dBClYArV/uwBZ4t4gSI+fXo+Iot+8/neGY5dN8nMNjYT9ik2SIXHKrdC2FiyYEX62t
         5bRzia/jzOOrA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 18 Aug 2023 00:47:13 +0300
Message-Id: <CUV5EXGO425W.1RGBLDQJ8GK9W@suppilovahvero>
Cc:     <linux-kernel@vger.kernel.org>, <len.brown@intel.com>,
        <charles.d.prestopine@intel.com>, <rafael.j.wysocki@intel.com>
Subject: Re: REGRESSION WITH BISECT: v6.5-rc6 TPM patch breaks S3 on some
 Intel systems
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     <todd.e.brandt@linux.intel.com>, <mario.limonciello@amd.com>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <485e8740385239b56753ce01d8995f01f84a68e5.camel@linux.intel.com>
In-Reply-To: <485e8740385239b56753ce01d8995f01f84a68e5.camel@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 18, 2023 at 12:09 AM EEST, Todd Brandt wrote:
> While testing S3 on 6.5.0-rc6 we've found that 5 systems are seeing a
> crash and reboot situation when S3 suspend is initiated. To reproduce
> it, this call is all that's required "sudo sleepgraph -m mem -rtcwake
> 15".

1. Are there logs available?
2. Is this the test case: https://pypi.org/project/sleepgraph/ (never used =
it before).

I'll see if I can repeat it with QEMU + swtpm.

> I=C2=92ve created a Bugzilla to track this issue here:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217804

Thank you for reporting this.

BR, Jarkko
