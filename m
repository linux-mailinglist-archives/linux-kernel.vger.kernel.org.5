Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95BB7E837F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345235AbjKJUJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjKJUJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:09:45 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F07BC7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 12:09:42 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41cb7720579so44841cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 12:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699646981; x=1700251781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wtJyPVGXzuMJP+3PlJwZy5jGviDZFnnmGbzORztedw=;
        b=ydAaPlv2uRfKk9XwP8npUHCZ+UnZRx3bo1mJtY92mHHLgMFXwMlF+gKyrGq+s73fb1
         1C/c5Aqw1mI5x+nHfc6vnHelUpVCyHi2CrJ6wzW+0EtNoZxT09DTHgYSkKa/8kkBxgeb
         fl/URsHI81psR7NXMCYz0kZeaGkunhNPkIyptV+Y2F8BOHLSWQjekWatws/OENPInUoC
         PP3Lytv6XQHalxcdaklB0+5VCDhp8sC6Ve7Lqa1LV1/+lwDCC+KrMf5ACEHLGfHjG6Ev
         v/sNdUKnEjOscn8LWjuu+0/nEwAvyn7Zcdq+/AMRghS5QA/eCT6wVSKiPGqP1NiFeR2Y
         SEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699646981; x=1700251781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wtJyPVGXzuMJP+3PlJwZy5jGviDZFnnmGbzORztedw=;
        b=Kimgh/OtRMxQYk2qqLW6CJdhCBpDkkCzBZwJIwQsifOG51zW/vt6il7LfOaOMU5Zyj
         Kzu4I+6877CJK69s40ILAsL2wsrUPCXvFuItf0V7HR6ANtKAETkUu7tWySnEqiA4Iw1p
         T3Rtys9nauJm51E9kNkzzDAomojJse4ovBtaHBjZAILbCqHgkrWjCCdi6BGJNh8mXx9s
         WwPsYC5HJs2GRbj4AT7JqCgEDFCkOcrATczXfBbwSX4EhpL0lcXtYQleFmCRi9WMZXcD
         QFcuMHVPd5DgHqZAGlwkgxoAL6SSpnJVCbgBsANKOcOjRmd0oJAF2bKIkxSmOAvbcs7n
         UzRg==
X-Gm-Message-State: AOJu0YwNaGlwnFyD/q22q1fV5Cyvy3n7s5YGHeNXb4VCQBZAvu8KFZHh
        oW2i+zS1Zxl70ijZDwA0dC7Ygclg7Gd3JcsMLvffxQ==
X-Google-Smtp-Source: AGHT+IGWmpVnmrAJW27NZfaLWBvYoSnnqVB8m1CH9cFWxSCzG1oiAGekP2IqG5cVv0JP21MqTdAhzjgewFcokICOxn4=
X-Received: by 2002:ac8:4603:0:b0:41c:dad0:1c1c with SMTP id
 p3-20020ac84603000000b0041cdad01c1cmr659988qtn.21.1699646981217; Fri, 10 Nov
 2023 12:09:41 -0800 (PST)
MIME-Version: 1.0
References: <20231110170121.769221-1-herve.codina@bootlin.com>
In-Reply-To: <20231110170121.769221-1-herve.codina@bootlin.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 10 Nov 2023 12:09:02 -0800
Message-ID: <CAGETcx9gib6HC9TZNoJpS3RmnRt6_5UixRyvP6Mu_TbuxLO3fg@mail.gmail.com>
Subject: Re: [PATCH 1/1] driver core: Avoid using fwnode in __fwnode_link_del()
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 9:01=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> A refcount issue can appeared in __fwnode_link_del() due to the
> pr_debug() call:
>   WARNING: CPU: 0 PID: 901 at lib/refcount.c:25 refcount_warn_saturate+0x=
e5/0x110
>   Call Trace:
>   <TASK>
>   ? refcount_warn_saturate+0xe5/0x110
>   ? __warn+0x81/0x130
>   ? refcount_warn_saturate+0xe5/0x110
>   ? report_bug+0x191/0x1c0
>   ? srso_alias_return_thunk+0x5/0x7f
>   ? prb_read_valid+0x1b/0x30
>   ? handle_bug+0x3c/0x80
>   ? exc_invalid_op+0x17/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? refcount_warn_saturate+0xe5/0x110
>   kobject_get+0x68/0x70
>   of_node_get+0x1e/0x30
>   of_fwnode_get+0x28/0x40
>   fwnode_full_name_string+0x34/0x90
>   fwnode_string+0xdb/0x140
>   vsnprintf+0x17b/0x630
>   va_format.isra.0+0x71/0x130
>   vsnprintf+0x17b/0x630
>   vprintk_store+0x162/0x4d0
>   ? srso_alias_return_thunk+0x5/0x7f
>   ? srso_alias_return_thunk+0x5/0x7f
>   ? srso_alias_return_thunk+0x5/0x7f
>   ? try_to_wake_up+0x9c/0x620
>   ? rwsem_mark_wake+0x1b2/0x310
>   vprintk_emit+0xe4/0x2b0
>   _printk+0x5c/0x80
>   __dynamic_pr_debug+0x131/0x160
>   ? srso_alias_return_thunk+0x5/0x7f
>   __fwnode_link_del+0x25/0xa0
>   fwnode_links_purge+0x39/0xb0
>   of_node_release+0xd9/0x180
>   kobject_put+0x7b/0x190
>   ...
>
> Indeed, an of_node is destroyed and so, of_node_release() is called
> because the of_node refcount reached 0.
> of_node_release() calls fwnode_links_purge() to purge the links and
> ended with __fwnode_link_del() calls.
> __fwnode_link_del calls pr_debug() to print the fwnodes (of_nodes)
> involved in the link and so this call is done while one of them is no
> more available (ie the one related to the of_node_release() call)
>
> Remove the pr_debug() call to avoid the use of the links fwnode while
> destroying the fwnode itself.
>
> Fixes: ebd6823af378 ("driver core: Add debug logs when fwnode links are a=
dded/deleted")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/base/core.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index f4b09691998e..62088c663014 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -109,8 +109,6 @@ int fwnode_link_add(struct fwnode_handle *con, struct=
 fwnode_handle *sup)
>   */
>  static void __fwnode_link_del(struct fwnode_link *link)
>  {
> -       pr_debug("%pfwf Dropping the fwnode link to %pfwf\n",
> -                link->consumer, link->supplier);

Valid issue, but a NACK for the patch.

The pr_debug has been very handy, so I don't want to delete it. Also,
the fwnode link can't get deleted before the supplier/consumer. If it
is, I need to take a closer look as I'd expect the list_del() to cause
corruption. My guess is that the %pfwf is traversing stuff that's
causing an issue. But let me take a closer look next week when I'll be
at LPC.

-Saravana

>         list_del(&link->s_hook);
>         list_del(&link->c_hook);
>         kfree(link);
> --
> 2.41.0
>
