Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388CF7FF978
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346557AbjK3Sfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjK3Sfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:35:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259E810D0;
        Thu, 30 Nov 2023 10:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qQKU50vKbXATuSXglJgEj5fFzmKu+YBO07b8qJOOdtA=; b=a27xugt2s7VCRZavZTnsN7HQZG
        49KGSFnP/lAr4dvK7i3HDJ4RMmY5/nj+Q/JtVwbX2EuSbtBP1TjOeJMiHUf17uTVAJdLo1VZZ8F7w
        f71Vg7/+DA5n6sUIJ030PbPVYq4bFV/2Q2Ch0CQ0wUYSClwjbvJxHySEDNe+p12tTfX4vqeMoQWG/
        RhpFELpiLJn1M+ZCQSbXXoxilSLcvbQDkXyKOLFhzt6YooPUXC46hvY+yy3pK5WjJBP/Ib1g29m8f
        ILI8SIpHjF0/ndrR5p2Q8uZNWd++lBHHKEPQf23MjpSx3hP2l9JhKT9Be1BvgumVRJd2JPK/YsJ32
        OHAR/qMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r8lss-00Ek8D-29; Thu, 30 Nov 2023 18:35:34 +0000
Date:   Thu, 30 Nov 2023 18:35:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Wenbo Hong <wenbo.hong@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: add support for an i_version counter
Message-ID: <ZWjV9obu2mvBfXbk@casper.infradead.org>
References: <20231130090413.1291703-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130090413.1291703-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 02:04:09AM -0700, Yangtao Li wrote:
> NFSv4 mandates a change attribute to avoid problems with timestamp
> granularity, which Linux implements using the i_version counter. This is
> particularly important when the underlying filesystem is fast.
> 
> BTW introduce a new mount option to enable the iversion functionality,
> and disabling it by default.

Why do you want to replicate the mistake made in ext4 and undone by
commit 1ff20307393e ?
