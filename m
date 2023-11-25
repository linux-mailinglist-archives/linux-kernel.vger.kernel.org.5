Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC73E7F8B9F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjKYO03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYO01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:26:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84518B0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:26:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCDEC433C8;
        Sat, 25 Nov 2023 14:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700922394;
        bh=WJqDOKsJ9Glk7K1YdRCLvcxH6F02SwD8nx0As1NGWuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HICul6Y3wp0+NFZgm9sAIPvoYVL4zS5BjH8s/DtReiEWIEkWqsDbkLVK+t6Lw9LCO
         p/OXrAFzJH5lvqf7IhERRyjnvBqcjiTrgalErU4zhcW/dZQ1EUHT0vuG+tOsUxXftA
         H5Q/5jTTWOjD5ZZzqFdnphVCIAdDWA6YDgABH7X4=
Date:   Sat, 25 Nov 2023 14:26:30 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: macros: allow generic parameter default values
 in `#[pin_data]`
Message-ID: <2023112525-impatient-untwist-ee3d@gregkh>
References: <20231125125024.1235933-1-benno.lossin@proton.me>
 <20231125125024.1235933-2-benno.lossin@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125125024.1235933-2-benno.lossin@proton.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 12:51:09PM +0000, Benno Lossin wrote:
> This patch adds compatibilty for generic parameters defaults by using
> the newly introduced `decl_generics` instead of the `impl_generics`.

This says _what_ is happening here, but not _why_ this is needed at all.

Try taking a look a the kernel documentation for how to write a good
changelog text to make this much better.  It's often times the most
difficult portion of making a kernel patch, the code is easy, writing a
summary of why everyone else should agree that this code is acceptable
is hard.

good luck!

greg k-h
