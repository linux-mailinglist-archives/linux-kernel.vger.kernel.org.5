Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF237DCBEA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343754AbjJaLhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjJaLhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:37:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3930097
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:37:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61789C433C8;
        Tue, 31 Oct 2023 11:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698752223;
        bh=3SkuphRz/pcBGjkRd9EkXxoSc1kkvEtAro0c6PtXBvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l1i5Z/YGrmTuWi7xt+sCTEBteTLBqrZt5VrLJbJ+gevmRS4H3HaFY5LuxUGrJkBcp
         IGruGdJpM5Asgzol+eAgTb9S/AUq+hQoD70WQ2NLw2kp+eAftkLWkT4iZoTVkfH6Y/
         TRrtiG8aXIZOFlm5Kra9C4x9qsrzqpaPbQcwtnmA=
Date:   Tue, 31 Oct 2023 12:36:59 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5p+z6I+B5bOw?= <liujingfeng@qianxin.com>
Cc:     Marco Elver <elver@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: Re: A null-ptr crash in linux-6.4 usb driver
Message-ID: <2023103132-flinch-rectified-d758@gregkh>
References: <b60e7642b76b464ca4acddcba5329a3d@qianxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b60e7642b76b464ca4acddcba5329a3d@qianxin.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 11:10:45AM +0000, 柳菁峰 wrote:
> OK, I took a look and it may be the same reason that caused the
> crash,but I just tested it on the latest Linux-6.6,it also crashed
> while running the reproducer,it didn't be fixed.

Very true, you are injecting faults into the system, so the system
faulted!  You are succeeding in breaking things.

But the trick is, is this actually a valid fault?  Or is it something
that can never actually happen in real life?  That's for you to
determine please.

> > Looks like this report from over a year ago:
> > https://lore.kernel.org/all/000000000000bb7f1c05da29b601@google.com/
> 
> 
> It seems that this issue will not be fixed because it must rely on
> fault-inject, right?

Yes.

> I am not familiar with this part of the kernel code, and if fixing
> this issue is very difficult, I may not be able to provide an useful
> patch,sorry.

Try it and see!  You have the reproducer, so you are in the best
position to work on this.

thanks,

greg k-h
