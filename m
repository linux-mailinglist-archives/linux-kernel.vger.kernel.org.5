Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE807D89D8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjJZUuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZUuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:50:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E28A1A5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1698353419; bh=1FIsEx1PZ/gqeG/838CEPnOEq8w3zTelwB+WJXMD37g=;
        h=Date:From:To:Subject:From;
        b=IBB+kMTGxBy9CzfH8bf4Siw3odakZxlhUicNc6+fjQWVPa/L4rmCOwDagg4o7aysw
         89GtIRIfGqb+5gPw3mcVvmoyRzTUVlkzi6ytVsak8szEC2Z7xDTmd3gI80K6U5Q+Iy
         WrXiwJ5D3t8NAQRT9gNluAOjPDJHo4x3JWsQR1dY=
Date:   Thu, 26 Oct 2023 20:50:17 +0000
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     qemu-devel@nongnu.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC] pvpanic notifications for non-panic reboot events
Message-ID: <984794aa-4af0-4c68-a74e-7420ec3151a5@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

the mechanism for a (Linux) guest to signal a regular shutdown event to
QEMU seems fairly architecture specific and dependent on kernel
configuration.

The existing pvpanic protocol [0] could be extended fairly easily to
also cover these events.

Any thoughts?

Thanks,
Thomas

[0] https://github.com/qemu/qemu/blob/master/docs/specs/pvpanic.txt
