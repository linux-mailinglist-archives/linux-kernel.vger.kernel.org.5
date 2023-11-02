Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942ED7DEC6E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348574AbjKBFmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348550AbjKBFmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:42:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63074116
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 22:42:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76153C433C8;
        Thu,  2 Nov 2023 05:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698903730;
        bh=pJZ36zEO3yx6FWfDREAzB7mL2MkuS88AsB3/3YMtXUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mEu8dVVI4DwCyVt4aFPqCSPKbEZ/7D2f4ksKUcfRIiCsEs3NpG64sgdDFEtCNtFjA
         CnBsrSXA849nN0Ej7vCGe1zEo5Z2lvHhXTvOLp9kwvtLvVS7E/e/+UQjNbxmazPrlL
         396y6PB0Gb0SjwTZxr2RnUZTJ1/E7Ujff3pAjXpE=
Date:   Thu, 2 Nov 2023 06:42:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sourav Panda <souravpanda@google.com>
Cc:     corbet@lwn.net, rafael@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org,
        david@redhat.com, rdunlap@infradead.org, chenlinxuan@uniontech.com,
        yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
        bhelgaas@google.com, ivan@cloudflare.com,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
Message-ID: <2023110205-enquirer-sponge-4f35@gregkh>
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101230816.1459373-2-souravpanda@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 04:08:16PM -0700, Sourav Panda wrote:
> Adds a new per-node PageMetadata field to
> /sys/devices/system/node/nodeN/meminfo

No, this file is already an abuse of sysfs and we need to get rid of it
(it has multiple values in one file.)  Please do not add to the
nightmare by adding new values.

Also, even if you did want to do this, you didn't document it properly
in Documentation/ABI/ :(

thanks,

greg k-h
