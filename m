Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691E67B6FF0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbjJCRg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240713AbjJCRgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:36:54 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536FFE4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 10:36:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6695632004CE;
        Tue,  3 Oct 2023 13:36:48 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 03 Oct 2023 13:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696354607; x=1696441007; bh=MM
        zuo9HE7N9XHvGcmeh0w7Xoy80nI7ZB5qQuJulIDRs=; b=C0ODr5z9/gLmrDOooa
        JZsCCEsAruD778TTNm4ELJsR/mqR8l6TKOPYEGan5PrkkkGwtYHxELl9ppWsv4br
        sCimyIfrVOg8o1ej/HzMmNzJg+mw/+VwG7VCWJ+mLs7TYVhLzr3JSmt7VBYxsz3/
        x6uIgDIG/N4ZSVU6ppQUiHFI/ZadpBHEbhD/TrhnWSjzKGPWFgy8/0hoHvQmjeKY
        Av6UK6P2t41yGEbluCv/T2nEs+qSVsbWN9rv/v6LDsN7KjB1B+DmmAeLtwSJBQpi
        bOf6N2IUPvZkenGM0Rvp415UfhBWTit2OvnU+xqNQsN8YrS3vB3/P1yO3FlJSzCn
        yEDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696354607; x=1696441007; bh=MMzuo9HE7N9XH
        vGcmeh0w7Xoy80nI7ZB5qQuJulIDRs=; b=iTx7hzXCGCs/iUwzVxLOfSLz0MH//
        OPdrKqkSMGV6rxVmDHU+4OE3atE6f4XbZ+GqOljpBWLXfUqeF0U0um4zlQKZGn/k
        Du8Mbxw/S2nMAz4ccPJ/qCTFM0k8YEJ8woZ9H7GuH8ZP6Eey0O0pAINH6n/rDWzh
        IYvj0I9xfPj+QFT5UTx95ludyFzw0zM4QpxYSt+alRnXIEyfl0xPRObpve1/a+OK
        UWTIZ5V/N0GqoHcJPtFqbDV6L9MD7e1XmYY4RqDquItrw5Qgvk7Vz7I9gsROAMp5
        3dHHSVs5ZB09lmTlo5/qHBoGWx5fAp5ZDeU0ONp24/MqMipG+WG9C9GwA==
X-ME-Sender: <xms:L1EcZdVXwD0E-Hj3teILm3KYHOZWuOdYyIsjvcq6fJmnZ6hs7DmM8Q>
    <xme:L1EcZdnfIBDysGCpIUZG1J6ZXtxygayxtcj3OesMc-V8aP_Nnz9DBV1UReOUSxPuv
    OPKTy-ekG12NgwQ-xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeejgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:L1EcZZadiOgljdC35bhsCRoaE2QFcdIjzryDpcd8xeL-m8WKz9uFyA>
    <xmx:L1EcZQVJ615MywnJT9nEeqxsENrXk1fd8nq52RdPUlQcosrlb6WLlw>
    <xmx:L1EcZXlZqLAiyTzbwwvhqdosmZC5jtOlSNlRs87wfKI8YxutyZ4ydg>
    <xmx:L1EcZcy8jSds17FGcT7sgzu0Tg7QDxynD6MMN8e6YBTtw5RQr2suwQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9D17BB60089; Tue,  3 Oct 2023 13:36:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <b977b720-f9e7-482f-af09-f9c94c0491ec@app.fastmail.com>
In-Reply-To: <20231003101717.f57af0208431dba6dac0357e@linux-foundation.org>
References: <20231003144857.752952-1-gregory.price@memverge.com>
 <20231003094912.08cf57998135446ef475dd19@linux-foundation.org>
 <325de88f-1237-4910-aa2a-97707bedae26@app.fastmail.com>
 <f8d621c8-f5eb-4ba6-ab25-d3f782562abd@app.fastmail.com>
 <20231003101717.f57af0208431dba6dac0357e@linux-foundation.org>
Date:   Tue, 03 Oct 2023 19:36:27 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Gregory Price" <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Gregory Price" <gregory.price@memverge.com>
Subject: Re: [PATCH] mm/migrate: fix do_pages_move for compat pointers
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023, at 19:17, Andrew Morton wrote:
> On Tue, 03 Oct 2023 19:01:45 +0200 "Arnd Bergmann" <arnd@arndb.de> wrote:
>> On Tue, Oct 3, 2023, at 18:57, Arnd Bergmann wrote:
>> > On Tue, Oct 3, 2023, at 18:49, Andrew Morton wrote:
>> >> On Tue,  3 Oct 2023 10:48:56 -0400 Gregory Price 
>> >> <gourry.memverge@gmail.com> wrote:
>> >>
>> >>> do_pages_move does not handle compat pointers for the page list.
>> >>> correctly.  Add in_compat_syscall check and appropriate get_user
>> >>> fetch when iterating the page list.
>> >>
>> >> What are the userspace visible effects of this change?
>> >
>> > It makes the syscall in compat mode (32-bit userspace, 64-bit kernel)
>> > work the same way as the native 32-bit syscall again, restoring the
>> > behavior before my broken commit 5b1b561ba73c ("mm: simplify
>> > compat_sys_move_pages").
>> 
>> More specifically, my patch moved the parsing of the 'pages'
>> array from the main entry point into do_pages_stat(), which left
>> the syscall working correctly for the 'stat' operation (nodes = NULL),
>> while the 'move' operation (nodes != NULL) is now missing
>> the conversion and interprets 'pages' as an array of 64-bit
>> pointers instead of the intended 32-bit userspace pointers.
>> 
>
> Thanks.  So is a cc:stable warranted?

Yes, absolutely. It is possible that nobody noticed this
bug because the few applications that actually call move_pages are
unlikely to run in compat mode because of their large memory
requirements, but this clearly fixes a user-visible regression
and should have been caught by ltp.

      Arnd
