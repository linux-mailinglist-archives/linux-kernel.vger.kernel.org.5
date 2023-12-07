Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1399807F16
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 04:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjLGDPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 22:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGDPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 22:15:09 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26612110;
        Wed,  6 Dec 2023 19:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ikyQNDZSs7x392fCLkxFtZ8cjqbTuYZcw0JdF/jOx7Q=; b=cee1OpeemiJOyTxllx1VHwGK5e
        gmWahVa18cIhmTsUgG64nYuTzCmSPxOJvru3ApiVKKGcg67Mtz3q5aTSbzS/4Un+LjGjUng7u+iLY
        5PwKROUYBZ4p9SA3TGUQK+skkWDdO2xCsmZbDhsDLX73TSTEOdy7/083iPTO4WEvJtOPXXuU8ZXwm
        fdC25rldwh5Ug9yeRrINMkPFoJpA+mKmiu3+KSQypdhyKl757SbbFYnzj7eOENNFRdqAfLPrxKWeY
        PYQs8e+3J0bkxANfUcogshBBc4+XLdsC1t2RNjFi2cAIt9jHKvaptc/nEQoDM+B2SyjPPEsoaRx7t
        CjsSE29g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rB4r3-0083zj-0A;
        Thu, 07 Dec 2023 03:15:13 +0000
Date:   Thu, 7 Dec 2023 03:15:13 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-cachefs@redhat.com, dhowells@redhat.com,
        gfs2@lists.linux.dev, dm-devel@lists.linux.dev,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] hash-bl: explicitly initialise hash-bl heads
Message-ID: <20231207031513.GX1674809@ZenIV>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-10-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206060629.2827226-10-david@fromorbit.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:05:38PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Because we are going to change how the structure is laid out to
> support RTPREEMPT and LOCKDEP, just assuming that the hash table is
> allocated as zeroed memory is no longer sufficient to initialise
> a hash-bl table.

static inline void init_bl_hash(struct hlist_bl *table, int shift)?
