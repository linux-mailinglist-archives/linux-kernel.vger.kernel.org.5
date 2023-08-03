Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066CD76F3A7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjHCTsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjHCTsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:48:10 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162BB273E;
        Thu,  3 Aug 2023 12:48:07 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BBB23320098F;
        Thu,  3 Aug 2023 15:48:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 03 Aug 2023 15:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1691092082; x=1691178482; bh=ZX9rnhr6+eORdLiwc8xWgVedUW0D9gRos+U
        IZTs7zXQ=; b=GZlpRHV1UUGTBNghgavsQqLOevJAIy8CREZ8oL0ZvUAq0NnWHBE
        a6GD8EcVuqJZKuUZ33DGorckbsEnKDbkJsV+o7zhleKoEgviuIV+fvovCe25lYyg
        BRXwLPsLvxgm2WOeG694v/rpkUiteS+/TjouYZiDtYa3LEQOFMgrXnZjQ2WIZx81
        ca14din3J7RlAebOscP4q6jhYE92ycJFJUe7hpav3+kxN63MwRGbsRRphEkXyIC0
        lX9kYg6TH69cdUatAW+AN6XDgrO4JeOGCQDBioMqo4Dk4w7OsSZpu1RAMZ/Id4aI
        lhxdtMqBeB5f47YPJUecn1P1IJPRil7Qh2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691092082; x=1691178482; bh=ZX9rnhr6+eORdLiwc8xWgVedUW0D9gRos+U
        IZTs7zXQ=; b=xVdkf/to5v74P3iLVw7UUjHwuLbdRQtQLrfxINl856NfDp9uXgN
        OjXMpiG1AtCvF4KbxHv5unGIiYmruXRcTWD8CCs/6h5c5Y7YGaHM5nlAjq0k9n65
        hG3Jp7RNpQPcWmKPTKRCoApigESlVmmXOBR4sNGoxiAtW7gUw1VwpaWKu16gSEpW
        hswxJFGxfAziDbV4/Vqa/5fi7hlmqDpp1k4YOKXsEOPfa5w1cYBiAYWBExVaGxS7
        wS1I3vUYrrXXRhIwm286dGPERtUvnURjBGfK1/KXKP9aPKRRNvuPA0RR1VBu7CZg
        yzEGfxEx1+Y72jItG8zZXvUkvEz2I4WLkKA==
X-ME-Sender: <xms:cQTMZKiKeWn5lcFAq2k2S8O1NYgrJA36P2qor_dRXFHkeJVoQiFyhw>
    <xme:cQTMZLAVKeb8eyuMrTgjR9vJL03x_rYD1pjQvHAy8MdWubmvKizHCHaihEXWKXys8
    FWT11eOg5405ImJug>
X-ME-Received: <xmr:cQTMZCG0mn66Koiu1W4Gs5f9gBeKaPGry6fo8CvSEQhSq-nkFRwPiJdI5sVP_pJ8k3ohzy8OJbfAE_xsYAPN5WlJNkojbWTkcwNB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedvgddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudduvdetkedvkedtudeludfgfffhudegjeeguedvvedtteevjeehheeiffefgeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:cQTMZDTEA9eAXE1AtgxXWyrHjCo4xU74Y4bRTJXugJ5IXRcImaRvow>
    <xmx:cQTMZHwGFSOR5XJy5FivvqLqex8mSG4DG_-dgDV48UUTRzRvBA3X9w>
    <xmx:cQTMZB7H_daU5cW1xGXFZJJYDaUKVlX9NEF012T7qWhtpjqmXZCPQw>
    <xmx:cgTMZMov-hLgBy6Mga0Ch5GE_UDcZZhA2bhZ7WJnE6dbJ1X5Qxgfhg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Aug 2023 15:47:59 -0400 (EDT)
Message-ID: <9e9f08b9-5cb1-f4f8-7527-7ae5b1f54ceb@ryhl.io>
Date:   Thu, 3 Aug 2023 21:47:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] rust: macros: vtable: fix `HAS_*` redefinition
 (`gen_const_name`)
Content-Language: en-US-large
To:     Qingsong Chen <changxian.cqs@antgroup.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        =?UTF-8?Q?Sergio_Gonz=c3=a1lez_Collado?= <sergio.collado@gmail.com>,
        rust-for-linux@vger.kernel.org
References: <20230803140926.205974-1-changxian.cqs@antgroup.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230803140926.205974-1-changxian.cqs@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 16:09, Qingsong Chen wrote:
> If we define the same function name twice in a trait (using `#[cfg]`),
> the `vtable` macro will redefine its `gen_const_name`, e.g. this will
> define `HAS_BAR` twice:
> 
> ```rust
>      #[vtable]
>      pub trait Foo {
>          #[cfg(CONFIG_X)]
>          fn bar();
> 
>          #[cfg(not(CONFIG_X))]
>          fn bar(x: usize);
>      }
> ```
> 
> Changelog:
> ----------
> v1 -> v2:
> - Use `BTreeSet` and existing `consts` as suggested by Alice and Gary.
> - Reword commit messages as suggested by Miguel.
> ====================
> 
> Fixes: b44becc5ee80 ("rust: macros: add `#[vtable]` proc macro")
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
