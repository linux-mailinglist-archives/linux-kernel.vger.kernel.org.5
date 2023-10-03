Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3527B6F34
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbjJCRCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240671AbjJCRCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:02:11 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA2895
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 10:02:08 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6673D5C0333;
        Tue,  3 Oct 2023 13:02:07 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 03 Oct 2023 13:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696352527; x=1696438927; bh=Xj
        dGRjhPL+NgQbb0Fq8+LNYwiDlMZC0hbW4ulM6CgK4=; b=PqaGf9PvXgBcYBdsfT
        CVLSD5SyMlTUthkuxTXYgjssGHMwGqHpoq5lW91MSvaXCO6xIX8toOzs0usNehRS
        jVsl+wwSgpTHI+715b4vj9doR/wg8uNKmi6OzYMeB/K6zKr/35K8mBPxx/9E+Z8i
        LTYMMZb9v9R6OxMs9wMb+sgmUCBY8FYRJznRRemxGNoyVmuXNKE5IOOmAa7j/dgk
        QvVrC7CAjW1S4dmGP6GZ05mcxuKUNDAz+lHKPZ1kh+igz9XZyDuKirLvuzhtEiCc
        qVg1wUdadRkkdJJwXzXRtO1XMCGggR63ewJIkfQ7KltZeO1gcXtiyQ0Gq3m9DLY6
        qwjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696352527; x=1696438927; bh=XjdGRjhPL+NgQ
        bb0Fq8+LNYwiDlMZC0hbW4ulM6CgK4=; b=bO7uNqDo/nuzsn69/n1i8DRAlZHQc
        ROsQ4w257Uc4pbjchQSlZkODoCUOHYlaPIgQuRaCyuWwYTwVKHY+a71VIbxLyzey
        HpbmFL2AsObsJEk1NdP+DPSp+EXmeYcQGgxUGcFEtE44PQkNrXkVpSZyY3FPUb2L
        OqR7/2lchX4xqlf5A5Ui0SVnpwkjk9cTUVMqIJ4rHC4Vqe2d6ZrThz4rGNY82G4S
        mxbJPGNBhLDOR4PbxJIo8TZLbWbZQI+hhrZj2w5bjK7tYlEOdb12DxF4WUXpl66G
        pyUF/V27F9Y6oF7YG60pOeE9zuPXpK6kz7pAQXx8IfjtM9OlShupHdbxw==
X-ME-Sender: <xms:D0kcZRauXhqshYL5WBvf4QOOaahkQcqo15itWd9q-zqdQau3dgZrgw>
    <xme:D0kcZYb_9SJGxWloNMTL_MuoTHocdbG5MYoC3sqvZkeMHgC8fu5ZiI8tRtSR4q3BX
    p52nk82FGDsTC20zkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeejgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:D0kcZT-IOKEmvzURn1S2tnxlzXjm1mykY9XeRAo8jkpA93nwj3i2aA>
    <xmx:D0kcZfoIcvC3EiMOrl86ZFYSavva7mOTNT9_WfNeAmpOHBaPTRflTg>
    <xmx:D0kcZcoyWiN86zHKZVRrVNLuj7SWgWmLoeosXmbSAlaHu6k-5Vi70Q>
    <xmx:D0kcZT0PKR5Uzh4ZDcyNl5cecv4DqXtdkb2S_W4u5vyXWHYstzieAA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 04B78B60089; Tue,  3 Oct 2023 13:02:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <f8d621c8-f5eb-4ba6-ab25-d3f782562abd@app.fastmail.com>
In-Reply-To: <325de88f-1237-4910-aa2a-97707bedae26@app.fastmail.com>
References: <20231003144857.752952-1-gregory.price@memverge.com>
 <20231003094912.08cf57998135446ef475dd19@linux-foundation.org>
 <325de88f-1237-4910-aa2a-97707bedae26@app.fastmail.com>
Date:   Tue, 03 Oct 2023 19:01:45 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Gregory Price" <gourry.memverge@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Gregory Price" <gregory.price@memverge.com>
Subject: Re: [PATCH] mm/migrate: fix do_pages_move for compat pointers
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023, at 18:57, Arnd Bergmann wrote:
> On Tue, Oct 3, 2023, at 18:49, Andrew Morton wrote:
>> On Tue,  3 Oct 2023 10:48:56 -0400 Gregory Price 
>> <gourry.memverge@gmail.com> wrote:
>>
>>> do_pages_move does not handle compat pointers for the page list.
>>> correctly.  Add in_compat_syscall check and appropriate get_user
>>> fetch when iterating the page list.
>>
>> What are the userspace visible effects of this change?
>
> It makes the syscall in compat mode (32-bit userspace, 64-bit kernel)
> work the same way as the native 32-bit syscall again, restoring the
> behavior before my broken commit 5b1b561ba73c ("mm: simplify
> compat_sys_move_pages").

More specifically, my patch moved the parsing of the 'pages'
array from the main entry point into do_pages_stat(), which left
the syscall working correctly for the 'stat' operation (nodes = NULL),
while the 'move' operation (nodes != NULL) is now missing
the conversion and interprets 'pages' as an array of 64-bit
pointers instead of the intended 32-bit userspace pointers.

     Arnd
