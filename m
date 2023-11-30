Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192287FFE6C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377167AbjK3WZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377150AbjK3WZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:25:05 -0500
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6466210DC;
        Thu, 30 Nov 2023 14:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1701383109; x=1701642309;
        bh=kDz6GRm/hWtSvVtD3dqxU7Yl5I9tqNGfec+dHcSxHzM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=gEOTIOgtDWmLB5lg0FeZ9PAbtjBHoYsmI2Do/359hGHwBUHk91Ae1xAIZt6W2r8Q4
         nUb7Hki00P2pDsubO+5J9jtCAjy1Srnx4hd21x/NA4z1ZA2WCG/Ye9opRtfmFNAU2M
         QpfDV8qXb8TA6x9mlCamOOhD3mCbwI8ZOwfxh7kWty/d21ug5BhhPVubowCcSEifW9
         A3qxsLvNloK8XaRu8Q9v1DURx/1R7HbhypGJoGXwLYvmHo2AZvtGjuVIW72TpiFKVJ
         KJE/QcHpXaK3wA7gJG1gAPpjVnKCQLItGBkXlZZqkqnQxCHO/9xXoKGTqLo7KdlcXW
         2v7uQvu55gzgw==
Date:   Thu, 30 Nov 2023 22:25:00 +0000
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
From:   David Revoy <davidrevoy@protonmail.com>
Cc:     =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Eric GOUYER <folays@gmail.com>,
        Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>,
        jkosina@suse.cz, jason.gerecke@wacom.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
Message-ID: <xG1_-ipfam98DC9VwbLcH9Rnvu8MbVw9-fWMLHN4hKquTDdAL-nFDpLcf5ZsMQDD1WBnT39Uqtopi42ZWjrKfdzv8D-iMJZgRNln_W5VE3M=@protonmail.com>
In-Reply-To: <CAO-hwJKnH=Brhq7Jv020qQLROarvFiewnRb__0ZF9WVqDuqxLQ@mail.gmail.com>
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm> <7wmtNlKuYResf5cFQ7M2QTalzIUtw0I6ohvPcz69Jo1c8flezyIlnJu1IwAgXhJ-u0NlRL3IV7HnL0Kza6fVBqd7X7jhc-Z6QCi3oqHEvpY=@protonmail.com> <CAO-hwJJ+nx72_TPfxcWRPBDZdDaPrO5yMNH4Y_mj6ej651Mesw@mail.gmail.com> <nFHw6XePiH5p60JsbQSbssRkiuABiTiR_n5fIYFZjPgkV3ObjjZuwTC84BJ_1vXYVufPbG3UvZ1L7ODSrrGlq9CrI7BTKhsV5QeAQoakV18=@protonmail.com> <CAO-hwJ+jwmTE-v7FsPi3f70mB8SqUha7Ek9DtptZ0auiFpGM7w@mail.gmail.com> <CAO-hwJJoCp0_kxf_HHN9n9EWy9YDSY4rP8ysYNrNg2xTUYtKEQ@mail.gmail.com> <evHI05gyKuWwynY1WdyVvXqKPUaPE8W34cc3tFfp9FWh94TWfA9FWfHun7AAscF9lqfbiYsLKGC7kTSZ9xWNZg88-PTpbGTLcFMc9D3P2HE=@protonmail.com> <CAO-hwJLinACPsk=mEHrEz_YJroknmm=9PcX8byHiqEDxqOConQ@mail.gmail.com> <CAO-hwJKnH=Brhq7Jv020qQLROarvFiewnRb__0ZF9WVqDuqxLQ@mail.gmail.com>
Feedback-ID: 5460171:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

> I've updated the HID-BPF filter, and you can find it in the latest pipeli=
ne[0].
> I've removed the extra "Stylus" and you should have a better
> experience with the upper button now.
> [0] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/jobs/52148274

Thanks for the update!

> I think we are done with the XP-Pen Pro 24. But now I wonder if the
> Pro 16 (gen2) doesn't also have those glitches.
> Could you send me the same debug sequence as the last time
> (transitions from/to touching the surface while holding the upper
> button) but on the 16 now?

Sure, here is the same action, three time but now on the Pro 16 (Gen2):=20
https://www.peppercarrot.com/extras/mailing-list/hid-records/XPPEN-Artist-1=
6-Pro-Gen2/2023-11-30_XPPEN-Artist-16-Pro-Gen2_pen_tip-contact-and-press-re=
lease-upper-stylus-button-while-pressed-x3.txt

Have a good end of week,
David.
