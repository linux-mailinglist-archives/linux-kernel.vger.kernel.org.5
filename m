Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6107649B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjG0IBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjG0IBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:01:02 -0400
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39AE272E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:58:24 -0700 (PDT)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
        by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 50F1840BE7;
        Thu, 27 Jul 2023 09:58:11 +0200 (CEST)
Message-ID: <1eb5c9ca-0e05-7aab-c60e-33cc0d8a9323@proxmox.com>
Date:   Thu, 27 Jul 2023 09:57:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: segfaults of processes while being killed after commit "mm: make
 the page fault mmap locking killable"
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, akpm@linux-foundation.org,
        Thomas Lamprecht <t.lamprecht@proxmox.com>,
        Wolfgang Bumiller <w.bumiller@proxmox.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <8d063a26-43f5-0bb7-3203-c6a04dc159f8@proxmox.com>
 <CAHk-=whKBx_UUKagfyF72EJrpqNCupF4yeoPgapjEBe1bynGcw@mail.gmail.com>
 <cc502fe7-716b-8114-c9e6-439e3b9cf0f6@proxmox.com>
 <CAHk-=wivat-bcWsGnQOd3=ODx0zFnc7R82tiee=fSU+DF4tD5g@mail.gmail.com>
Content-Language: en-US
From:   Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAHk-=wivat-bcWsGnQOd3=ODx0zFnc7R82tiee=fSU+DF4tD5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.07.23 um 19:59 schrieb Linus Torvalds:
> 
> It's commit 5f0bc0b042fc ("mm: suppress mm fault logging if fatal
> signal already pending") in my tree now.
> 
> And because it's a bit different from what you already tested, it
> would be lovely to just get a confirmation that I didn't screw
> anything up when I decided I needed to make a fix that covers more
> than just x86.
> 
I can confirm this still avoids the misleading logging for me :)

Thank you for the fix!

Best Regards,
Fiona

