Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBCA7DC92C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343769AbjJaJMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343706AbjJaJMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:12:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22ADC1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:12:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E668CC433C8;
        Tue, 31 Oct 2023 09:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698743531;
        bh=TZHoglbnNbl6D6f/Gduib36dJPpwRhyifiZ/1ss+vKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hwa1VYBV95GX/xgu/AhrZQ4PP+C+U7judYDUKD57yRGTaBQf+/crMtinUYJn6B+9X
         bUS4IJ9KMPDJ7lYfRmRgjbdNGHy6cThDYt/B22P7ZaNzutuCW/clZG9hk8cyyEf4kF
         QK4yDk+y6A8zMM1nYglbxPIVz73L5qkoaW3wUwBA=
Date:   Tue, 31 Oct 2023 10:12:08 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5p+z6I+B5bOw?= <liujingfeng@qianxin.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>,
        "secalert@redhat.com" <secalert@redhat.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: Re: A null-ptr crash in linux-6.4 usb driver
Message-ID: <2023103153-probe-draw-860a@gregkh>
References: <80129780abd7432787d0136c2b0a5ada@qianxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80129780abd7432787d0136c2b0a5ada@qianxin.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 08:20:08AM +0000, 柳菁峰 wrote:
> Here is calling sequence, it looks need to call fault-inject into the second ioctl$USBDEVFS_SETCONFIGURATION:

Great, please submit a patch to resolve this and we will be glad to
review it.

Also, please never copy security@kernel.org and public mailing lists at
the same time, as that makes no sense.

And never cc: secalert@redhat.com as that alias is just spam that helps
out no one at all.

thanks,

greg k-h
